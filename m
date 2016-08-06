From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 0/3] Input: xpad - improve support for new Xbox One S pad
Date: Sat,  6 Aug 2016 14:30:27 -0700
Message-ID: <1470519030-23051-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36343 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbcHFVac (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Aug 2016 17:30:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so22279415pfg.3
        for <linux-input@vger.kernel.org>; Sat, 06 Aug 2016 14:30:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

This pad generally works well enough on the current xpad, but there are
a few usability issues that I'm fixing with this series.

The notable changes:

The protocol seems to have changed a bit with the new pad. For one, it
needs an ack for the mode report now, otherwise it just retransmits it
forever. This makes the mode button look stuck down to userspace after
the first time it is pressed.

It also seems to overflow some internal buffer, hang, then eventually
reset the pad if there is user input without the driver listening.
This causes a spurious disconnection that may cause userspace programs
to behave unexpectedly.

Cameron Gutman (3):
  Input: xpad - add product ID for Xbox One S pad
  Input: xpad - fix One S pad disconnecting when not opened
  Input: xpad - fix stuck mode button on Xbox One S pad

 drivers/input/joystick/xpad.c | 52 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

-- 
2.7.4

