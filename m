From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 0/3] HID: lenovo: Improve wheel emulation
Date: Tue, 11 Aug 2015 22:40:49 +0100
Message-ID: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

A collection of unrelated patches to improve support for the Thinkpad
compact keyboards. The first 2 are just cleanup patches.

The final patch alters the behaviour of the middle button so userspace
either gets wheel events or a button click, not both. This stops
browsers opening a link in a new tab as well as scrolling, for example.

This means you can no longer long-middle-click, but I don't think this
is likely to upset users as much as the current behaviour.

Tested against 4.1.2 with both Bluetooth and USB compact keyboards.

Cheers,

Jamie Lentin (3):
  HID: lenovo: Use constants for axes names
  HID: lenovo: Add missing return-value check
  HID: lenovo: Hide middle-button press until release

 drivers/hid/hid-lenovo.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

-- 
2.1.4
