From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v2  0/3] support for the Fujitsu H730 laptop (update)
Date: Sun,  9 Nov 2014 22:38:34 +0100
Message-ID: <1415569117-29461-1-git-send-email-ulrik.debie-os@e2big.org>
References: <20141108082357.GC21475@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:41423 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaKIVjG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Nov 2014 16:39:06 -0500
In-Reply-To: <20141108082357.GC21475@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

This is an update of patch 3/5,4/5,5/5 of my previous submission.
If content looks good, I'll ask the testers to retest this modification.

The patch "report the middle button of the touchpad" is now made conditional
on the dmi check for the announcement of the middle button.

The patch "provide a sysfs knob for crc_enabled" is now simply 0/1, the autodetect is removed.

The patch "Update the documentation: trackpoint,v3/v4,crc_enabled" is now
updated according to those changes


Ulrik De Bie (3):
  Input: elantech - report the middle button of the touchpad
  Input: elantech - provide a sysfs knob for crc_enabled
  Input: elantech - Update the documentation:
    trackpoint,v3/v4,crc_enabled

 Documentation/input/elantech.txt | 82 +++++++++++++++++++++++++++++++++++++---
 drivers/input/mouse/elantech.c   | 21 ++++++++++
 2 files changed, 97 insertions(+), 6 deletions(-)

-- 
2.1.1

