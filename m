From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH RESEND v4] cap11xx: add runtime PM support
Date: Thu,  1 Oct 2015 22:18:59 -0700
Message-ID: <1443763140-16368-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34375 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbJBFS6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 01:18:58 -0400
Received: by padhy16 with SMTP id hy16so96663972pad.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 22:18:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@zonque.org
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

