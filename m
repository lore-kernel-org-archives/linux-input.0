From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 0/5] HID: wacom: Support tablets with pen and touch on same interface
Date: Wed,  3 Jun 2015 18:18:12 -0700
Message-ID: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35334 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbFDBU3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 21:20:29 -0400
Received: by pdbnf5 with SMTP id nf5so19088387pdb.2
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2015 18:20:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

I've recently got my hands on a device which has an I2C sensor that sends
both pen and touch reports from a single interface. To userspace, it shows
up as a single input device which blends both the report types (e.g. it has
ABS_PRESSURE for the pen, and ABS_MT_POSITION_X for the touch). This patch
set modifies the driver to be able to handle devices which place both pen
and touch on a the same interface. It does this by treating the pen, touch,
and pad (which was already special-cased) independently. If a device has
the appropriate device_type, one or more of pen/touch/pad input devices
will be created, initialized, and used to send data to userspace.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason Gerecke (5):
  HID: wacom: Simplify 'wacom_update_name'
  HID: wacom: Treat features->device_type values as flags
  HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type
  HID: wacom: Split apart 'wacom_setup_pentouch_input_capabilites'
  HID: wacom: Introduce new 'touch_input' device

 drivers/hid/wacom.h     |   4 +-
 drivers/hid/wacom_sys.c | 194 +++++++++++++++----------
 drivers/hid/wacom_wac.c | 379 ++++++++++++++++++++++++++----------------------
 drivers/hid/wacom_wac.h |  15 +-
 4 files changed, 332 insertions(+), 260 deletions(-)

-- 
2.4.1

