#!/usr/bin/env python

import http.client
import os
import json
import subprocess


def create_dumps():
    files = []

    dumpfile = '/tmp/qwat_v{version}_data_only_sample.backup'.format(version=os.environ['TRAVIS_TAG'])
    subprocess.call(['pg_dump',
        '--format', 'custom',
        '--blobs',
        '--section', 'data',
        '--compress', '5',
        '--verbose',
        '--file', dumpfile,
        '--schema', 'qwat_dr',
        '--schema', 'qwat_od',
        'qwat']
    )
    files.append(dumpfile)

    dumpfile = '/tmp/qwat_v{version}_data_only_sample.sql'.format(version=os.environ['TRAVIS_TAG'])
    subprocess.call(['pg_dump',
        '--format', 'plain',
        '--blobs',
        '--section', 'data',
        '--verbose',
        '--file', dumpfile,
        '--schema', 'qwat_dr',
        '--schema', 'qwat_od',
        'qwat']
    )
    files.append(dumpfile)

    dumpfile = '/tmp/qwat_v{version}_data_and_structure_sample.backup'.format(version=os.environ['TRAVIS_TAG'])
    subprocess.call(['pg_dump',
        '--format', 'custom',
        '--blobs',
        '--section', 'data',
        '--compress', '5',
        '--verbose',
        '--file', dumpfile,
        '-N', 'public',
        'qwat']
    )
    files.append(dumpfile)

    dumpfile = '/tmp/qwat_v{version}_data_and_structure_sample.sql'.format(version=os.environ['TRAVIS_TAG'])
    subprocess.call(['pg_dump',
        '--format', 'plain',
        '--blobs',
        '--section', 'data',
        '--verbose',
        '--file', dumpfile,
        '-N', 'public',
        'qwat']
    )
    files.append(dumpfile)

    return files

def main():
    release_files = create_dumps()

    conn=http.client.HTTPSConnection('api.github.com')

    headers={
        'User-Agent': 'Deploy-Script',
        'Authorization': 'token {}'.format(os.environ['OAUTH_TOKEN'])
    }

    raw_data={
        "tag_name": os.environ['TRAVIS_TAG']
    }

    data=json.dumps(raw_data)
    conn.request('POST', '/repos/{repo_slug}/releases'.format(
        repo_slug=os.environ['TRAVIS_REPO_SLUG']), body=data, headers=headers)
    response=conn.getresponse()
    release=json.loads(response.read().decode())
    print(release)

    conn=http.client.HTTPSConnection('uploads.github.com')
    for release_file in release_files:
        _, filename = os.path.split(release_file)
        headers['Content-Type']='text/plain'
        url='{}?name={}'.format(release_url=release['upload_url'][
                                :-13], filename=filename)
        print('Upload to {}'.format(url))

        with open(release_file, 'rb') as f:
            conn.request('POST', url, f, headers)

        print(conn.getresponse().read())


if __name__ == "__main__":
    main()
