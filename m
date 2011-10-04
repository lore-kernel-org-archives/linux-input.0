From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 00/12] Wiimote: Extension Support
Date: Tue,  4 Oct 2011 15:36:41 +0200
Message-ID: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55806 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab1JDNhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 09:37:23 -0400
Received: by wwf22 with SMTP id 22so815066wwf.1
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 06:37:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Hi

This series adds extension support to the wiimote driver. Extension hotplug is
not fully understood so we only support limited hotplugging. However, if the
wiimote is connected with an extension already connected, this extension is
fully supported.

This splits the driver into multiple files. To keep the module name, the first
two patches rename the core driver file into hid-wiimote-core.c and export
common symbols into a local header.

Patch 3/12 adds some helper functions which are very similar to the existing
write-mem helpers.

Patches 4-9/12 implement the basic layout. I'd appreciate any comments on this.
Changing this in the future will be complex so I'd rather have this done right,
now.

Patches 10-12/12 add parsers for the data of Nunchuck Extension, Classic
Controller Extension and MotionPlus Extension. These patches are very simple and
don't add any new logic. The binary data layout is a bit difficult to
understand, though.


I'd appreciate any comments on the layout. I've tried to keep it simple, but the
wiimote extension support is very weird and lots of different devices need to be
supported with one interface. I've only added 3 example parsers for the most
common devices (I also don't own any other device) but several other parsers may
be added in the future.

The atomic-operations seem wrong without memory-barriers, but I triple-checked
them and they aren't needed at all (there isn't any real data-dependency
anyway).


This is the last batch of patches for the wiimote driver for now. I have two
more modules hid-wiimote-sound.c and hid-wiimote-debug.c which add sound and
debug support, however, they are far away from being stable and will take
several more months. But I think this explains why I decided to split the driver
up. Otherwise we will end up with nearly 10000 lines in hid-wiimote.c and I want
to avoid that.


Thanks and regards
David

David Herrmann (12):
  HID: wiimote: Rename driver to allow multiple source files
  HID: wiimote: Move common symbols into header
  HID: wiimote: Add read-mem helpers
  HID: wiimote: Add extension support stub
  HID: wiimote: Add extension initializer stubs
  HID: wiimote: Add extension initializers
  HID: wiimote: Add extension sysfs attribute
  HID: wiimote: Register input devices for extensions
  HID: wiimote: Add extension handler stubs
  HID: wiimote: Parse motion+ data
  HID: wiimote: Parse nunchuck data
  HID: wiimote: Parse classic controller data

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   12 +
 drivers/hid/Kconfig                                |    9 +
 drivers/hid/Makefile                               |    5 +
 drivers/hid/hid-wiimote-core.c                     | 1316 +++++++++++++++++++
 drivers/hid/hid-wiimote-ext.c                      |  755 +++++++++++
 drivers/hid/hid-wiimote.c                          | 1346 --------------------
 drivers/hid/hid-wiimote.h                          |  186 +++
 7 files changed, 2283 insertions(+), 1346 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-core.c
 create mode 100644 drivers/hid/hid-wiimote-ext.c
 delete mode 100644 drivers/hid/hid-wiimote.c
 create mode 100644 drivers/hid/hid-wiimote.h

-- 
1.7.7

