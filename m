From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v4 0/5] add support for high res wheel found on some Logitech devices
Date: Tue, 11 Apr 2017 10:29:37 -0300
Message-ID: <cover.1491917052.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59417
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751966AbdDKNaK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 09:30:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Some Logitech mouses (MX Anyware 2, MX Master) have a wheel with two
resolutions. It initializes in low resolution mode, but can be changed to high
resolution. It also supports free wheel mode, where there's no tactile
feedback at the wheel, nor it offers resistence to movements. Such mode is
enabled/disabled by clicking at the wheel (on this wheel, the middle button
is a separate button).

Add support for it.

Tested on with MX Anywhere 2 device.

PS.:
       Patches 2 and 3 will have trivial conflicts with -next version of the
       input tree, due to the documentation patches that got merged there.

v4:
 - rebased on the top of HID tree, branch 'for-next'
 - added a patch reserving some REL_MISC_n events
 - fixed CMD_MOUSE_SET_WHEEL_MODE params logic;
 - don't send 16 bytes on FAP command sync - send just what's needed;
 - HIDPP_QUIRK_CONNECT_EVENTS is now applied by default.

v3: addressed Peter's comments for EV_SW SW_RATCHET documentation

Mauro Carvalho Chehab (5):
  input: event-codes: reserve some space for REL_MISC events
  input: add an EV_REL event for high-res vertical wheel
  input: add a EV_SW event for ratchet switch
  hid-logitech-hidpp: add support for high res wheel
  hid-logitech-hidpp: add support for ratchet switch

 Documentation/input/event-codes.txt    |  29 ++++-
 drivers/hid/hid-logitech-hidpp.c       | 216 +++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |   4 +-
 include/uapi/linux/input-event-codes.h |  13 +-
 4 files changed, 255 insertions(+), 7 deletions(-)

-- 
2.9.3


