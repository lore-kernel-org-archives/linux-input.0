From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/5] Input: xpad: robustness updates
Date: Sun,  1 Nov 2015 16:31:34 +0100
Message-ID: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38748 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAPbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Nov 2015 10:31:52 -0500
Received: by wicll6 with SMTP id ll6so36144434wic.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2015 07:31:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

Patch 1 implements "on demand" creation/ deletion of input 
devices.

The other patches make it robust in the following corner cases:

Patches 2-3 properly handle incoming messages when the irq_out is busy

Patch 4 fixes issues of the x360 wireless pads after suspend/ resume.

Patch 5 adds a packet serial number for Xbox One pads to match
the Windows driver and improve Force Feedback support

Pavel Rojtberg (3):
  Input: xpad: do not submit active URBs
  Input: xpad: re-submit pending ff and led requests
  Input: xpad: workaround dead irq_out after suspend/ resume

Pierre-Loup A. Griffais (2):
  Input: xpad: handle "present" and "gone" correctly
  Input: xpad: update Xbox One Force Feedback Support

 drivers/input/joystick/xpad.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 178 insertions(+), 47 deletions(-)

-- 
1.9.1

