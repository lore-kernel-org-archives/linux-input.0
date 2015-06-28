From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/2] Input: xpad: clean up x360 LED handling
Date: Sun, 28 Jun 2015 14:45:12 +0200
Message-ID: <1435495514-13954-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38340 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbF1Mpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2015 08:45:38 -0400
Received: by wibdq8 with SMTP id dq8so50852803wib.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2015 05:45:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

this series is a follow up to 
"[PATCH v2 0/2] Input: xpad: fix 360 wireless controller blinking LEDs"
it clarifies the new codepath and removes the now obsolete bulk URB one.

Note that while removing the bulk out URB altogether might seem intrusive, it
was only ever used with Xbox 360 wireless Receivers.
Tested on the Xbox 360 Wireless Receiver (PC).

Pavel Rojtberg (2):
  Input: xpad: clarify pad nr handling
  Input: xpad: remove bulk out URB

 drivers/input/joystick/xpad.c | 99 ++++++------------------------------------------------------------
 1 file changed, 9 insertions(+), 90 deletions(-)

-- 
1.9.1

