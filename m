From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [ANNOUNCE] libevdev 0.2
Date: Tue, 23 Jul 2013 09:09:08 +1000
Message-ID: <20130722230908.GA14622@yabbi.redhat.com>
Reply-To: input-tools@lists.freedesktop.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:27905 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab3GVXJI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jul 2013 19:09:08 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: input-tools@lists.freedesktop.org

[Note: bcc'd linux-input, wayland-devel and xorg-devel since those are the
expected interested parties. Apologies if you get this email multiple times,
I won't do this in the future. Future announcements will only go to
input-tools@lists.freedesktop.org]

This is the first release for libevdev, a C library that wraps the
kernel evdev interface. The benefits are
* type-safe interface for checking bits on a device
* various abstractions for ioctls that aren't quite as straightforward (e.g.
  EV_REP handling)
* simple abstraction for handling SYN_DROPPED events

This library is now hosted on freedesktop.org:
http://www.freedesktop.org/wiki/Software/libevdev/
API documentation: http://www.freedesktop.org/software/libevdev/doc/latest/
Bugzilla component: https://bugs.freedesktop.org/enter_bug.cgi?product=libevdev
cgit: http://cgit.freedesktop.org/libevdev/

libevdev provides API calls for the various bits, so a simple process can
work this way:

  struct libevdev *dev;

  fd = open("/dev/input/event0", O_RDONLY);
  rc = libevdev_new_from_fd(fd, &dev);

  if (libevdev_has_event_code(dev, EV_REL, REL_X))
        /* do something */

For event handling, libevdev provides one call that returns the next event
in the queue:

  rc = libevdev_next_event(dev, flags, &ev);

which does what you expect and returns 0 on success or -EAGAIN if there are
no events waiting. If a SYN_DROPPED is the next event in the queue, libevdev
syncs the device state and returns 1. The process can then handle the delta
by simply parsing events until the device is fully synced again:

  while ((rc = libevdev_next_event(dev, LIBEVEV_READ_SYNC, &ev)) == 1)
     /* this is a synced event */

  if (rc == -EAGAIN)
     /* we are now fully synced */
  else
     /* error */

To check out an example of how libevdev looks like, have a look at how
evtest would look like with libevdev.
http://cgit.freedesktop.org/libevdev/tree/tools/libevdev-events.c

The goal is that future and current processes that deal with evdev events
will switch to libevdev. An example of changes needed for the X.org
synaptics driver is here:
http://cgit.freedesktop.org/~whot/xf86-input-synaptics/commit/?h=libevdev

Suggestions, comments, etc. are all welcome. Please note that the library is
still in an early stage and may change in the future.

Cheers,
   Peter

git tag: libevdev-0.2

http://www.freedesktop.org/software/libevdev/libevdev-0.2.tar.xz
MD5:  bce22c2ae9c87b9a7b5c8d055f771084  libevdev-0.2.tar.xz
SHA1: 8efec1ff4f8b45929c3acc2b7e4f9fd37c9f8d37  libevdev-0.2.tar.xz
SHA256: da25b6efba09d7e357e50a31e599d98b97f116eb0f32086335640a06e13e37a6  libevdev-0.2.tar.xz

