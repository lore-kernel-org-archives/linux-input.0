From: Priit Laes <plaes@plaes.org>
Subject: [PATCH] input: goodix: RFC - implementing support for GT801x2
Date: Sun,  5 Apr 2015 00:08:12 +0300
Message-ID: <1428181693-25362-1-git-send-email-plaes@plaes.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plaes.org ([188.166.43.21]:54775 "EHLO plaes.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752561AbbDDVQr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Apr 2015 17:16:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Priit Laes <plaes@plaes.org>

Hi all!

I'm looking for some advice on how to proceed with the GT801x2 touchscreen
driver. Current proof-of-concept uses the existing Goodix driver as a
template, but due to the differences between GT801x2 and GT9xx series,
I ended with a driver where GT9xx support has been ripped out. I'm sorry.

Notable differences:

1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
2. Different configuration layout and version info
3. Different touch report protocol

So, would it make sense to have these two in the same driver?


Priit Laes (1):
  Input: goodix - preliminary support for GT801-2+1

 drivers/input/touchscreen/goodix.c | 87 ++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 14 deletions(-)

-- 
2.3.5

