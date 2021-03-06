#!/usr/bin/env python
# vim: set fileencoding=utf-8 :
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue 22 Jan 2013 13:37:39 CET

"""Professional website package management
"""

from setuptools import setup, find_packages

setup(

    name="anjos.website",
    version="1.0.1",
    description="My professional website",
    license="FreeBSD",
    author='Andre Anjos',
    author_email='andre.dos.anjos@gmail.com',
    long_description=open('README.rst').read(),
    url='https://github.com/anjos/website',

    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,

    namespace_packages=[
      "anjos",
      ],

    install_requires=[

      # pretty generic
      'setuptools',
      'pillow',
      'flup',
      'uuid',
      'mysql-python',
      'python-openid',

      # others
      'django-robots',
      'django-openid-auth',
      'django-maintenancemode',
      'django-rosetta',

      # mine
      'djangoogle',
      'django-flatties',
      'django-nav',
      'django-publications',
      ],

    entry_points = {
      'console_scripts': [
        'remove_app.py = anjos.website.scripts.remove_app:main',
        ],
      },

    classifiers = [
      'Development Status :: 5 - Production/Stable',
      'Environment :: Web Environment',
      'Framework :: Django',
      'Intended Audience :: Developers',
      'License :: OSI Approved :: BSD License',
      'Natural Language :: English',
      'Programming Language :: Python',
      ],

    )
