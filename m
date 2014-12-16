From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 0/2] HID: lenovo: Extra features for compact keyboards
Date: Tue, 16 Dec 2014 21:26:44 +0000
Message-ID: <1418765206-30885-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

Another set of patches for the Lenovo Compact Keyboards, enabling
sensitivity control and improving scroll-wheel emulation.

This applies to 3.18, once previous fixups[0] have been applied. Tested
with USB and Bluetooth versions of the keyboard.

Cheers,

[0] https://lkml.org/lkml/2014/11/9/25

Jamie Lentin (2):
  HID: lenovo: Add sensitivity control to compact keyboards
  HID: lenovo: Use native middle-button mode for compact keyboards

 drivers/hid/hid-lenovo.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

-- 
2.1.3
