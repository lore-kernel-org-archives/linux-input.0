From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/1] cap11xx: add runtime PM support
Date: Sun, 23 Aug 2015 14:17:56 -0700
Message-ID: <1440364677-1016-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34901 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbHWVSB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Aug 2015 17:18:01 -0400
Received: by pacdd16 with SMTP id dd16so80978834pac.2
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2015 14:18:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Changes from v3:
* Dropped cap11xx_remove() and devm_add_action a powerdown and
  runtime pm cleanup. That runs afters input and LEDs devices have
  been reaped.
* Move cap11xx_init_leds() after input device register becuase it was causing
  a hangup condition if an LED was lit on module removal.

Matt Ranostay (1):
  cap11xx: add runtime PM support

 drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 19 deletions(-)

-- 
1.9.1

