#!/usr/bin/env python

import os
import sys
import argparse

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "moztrap.settings.default")

from django.contrib.auth.models import User

def add_user(username, email, password, staff=False, admin=False):

    default_user, created = User.objects.get_or_create(
        username=username, email=email,
        is_active=True, is_staff=staff, is_superuser=admin
    )
  
    default_user.set_password(password)
    default_user.save()


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument('username', help="The username for the new Moztrap account")
    parser.add_argument('email', help="The email address for the new Moztrap account")
    parser.add_argument('password', help="The new Moztrap account's password")
    parser.add_argument('--staff', action='store_true', help="Creates the Moztrap user as a staff member")
    parser.add_argument('--admin', action='store_true', help="Creates the Moztrap user as an application administrator")
    
    args = parser.parse_args()

    add_user(args.username, args.email, args.password, args.staff, args.admin)
    print "User: %s added." % args.username
