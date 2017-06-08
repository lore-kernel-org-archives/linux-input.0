From: Yueyao Zhu <yueyao.zhu@gmail.com>
Subject: [PATCH 0/3] USB: add API for interface driver to vote for autosuspend
Date: Thu,  8 Jun 2017 14:58:25 -0700
Message-ID: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36220 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdFHV6j (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 17:58:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, Badhri Jagan Sridharan <badhri@google.com>, Dmitry Torokhov <dtor@google.com>, Yueyao Zhu <yueyao@google.com>

From: Yueyao Zhu <yueyao@google.com>

Currently, if a USB driver would like to enable autosuspend on the USB
device, usb_enable_autosuspend() seems to be the only option. However,
this acts on the device level, and other interfaces might not desire
to autosuspend the USB device.

For example, for the usb digital audio driver to enable autosuspend on
a device, calling usb_enable_autosuspend() from the interface driver
might not be a good idea as the USB device might have a keyboard HID
interface which generally doesn't handle autosupend very well.

This patch series introduces an API for interface driver to vote
for autosuspend on the interface, and when all interfaces agree to
it, autosuspend can then be enabled on the usb device.

Yueyao Zhu (3):
  USB: add API for interface driver to vote for autosuspend
  HID: usbhid: enable autosuspend for devices whose ...
  sound: usb: allow interfaces the driver claims to autosuspend

 drivers/hid/usbhid/hid-core.c | 37 +++++++++++++++++++++++++++++
 drivers/usb/core/driver.c     | 55 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h           | 10 ++++++++
 sound/usb/card.c              |  3 +++
 4 files changed, 105 insertions(+)

-- 
2.13.0.506.g27d5fe0cd-goog

