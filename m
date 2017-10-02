From: Fedora Kernel Team <kernel-team@fedoraproject.org>
Subject: [PATCH 0/4] Quirks cleanup and hid-generic niceness
Date: Mon,  2 Oct 2017 22:18:46 +0200
Message-ID: <20171002201850.13175-1-kernel-team@fedoraproject.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbdJBUTB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 16:19:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi,

This is the series I was talking about earlier[1].

Basically, Jiri, I'd like to see 1-3 applied in for-next at your earliest
convenience, and we can discuss about 4/4 without any rush.

I have this in my local tree since June, but I made some late minute
changes before sending, though the tests showed they are fine (I wouldn't
mind a second pair of eyes on it).

I am pretty sure we can optimize the things more, but for now this should be
just fine and just convert the quirks mechanism in hid-core.
For instance, there is a second call of hid_lookup_quirk() in usbhid/hid-core.c
that I am not sure about the absolute need.

Niels, please have a look at this and tell me if you are OK to rebase your
series on top of it.

Cheers,
Benjamin


[1] https://patchwork.kernel.org/patch/9980443/

Benjamin Tissoires (4):
  HID: core: move the dynamic quirks handling in core
  HID: quirks: move the list of special devices into a quirk
  HID: core: move the list of ignored devices in hid-quirks.c
  HID: core: remove the absolute need of hid_have_special_driver[]

 drivers/hid/Makefile            |    2 +-
 drivers/hid/hid-core.c          |  925 ++---------------------------
 drivers/hid/hid-generic.c       |   68 ++-
 drivers/hid/hid-quirks.c        | 1242 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/Makefile     |    2 +-
 drivers/hid/usbhid/hid-core.c   |   10 +-
 drivers/hid/usbhid/hid-quirks.c |  401 -------------
 include/linux/hid.h             |   21 +-
 net/bluetooth/hidp/core.c       |    2 +-
 9 files changed, 1388 insertions(+), 1285 deletions(-)
 create mode 100644 drivers/hid/hid-quirks.c
 delete mode 100644 drivers/hid/usbhid/hid-quirks.c

-- 
2.9.5

