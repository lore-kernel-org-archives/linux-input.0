From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 0/3] adp5589 fixes
Date: Tue, 21 Apr 2015 11:21:27 -0300
Message-ID: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34128 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbbDUOVj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 10:21:39 -0400
Received: by qkgx75 with SMTP id x75so202169859qkg.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 07:21:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Hi all,

Here are a couple of bug fixes for the adp5589-keys driver. The last tw=
o
are pretty serious, I think.

In particular the last one resulted in an interrupt storm and a
hung keypad when the FIFO filled completely, since the driver was
interpreting the event count of 16 as 0.

Thanks!

Guido Mart=C3=ADnez (3):
  Input: adp5589-keys: handle i2c errors on the irq handler
  Input: adp5589-keys: fix pull mask setting
  Input: adp5589-keys: fix event count mask

 drivers/input/keyboard/adp5589-keys.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
