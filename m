From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH v2 0/2] Input: surface3_spi: Surface Pen Support
Date: Tue, 24 May 2016 07:43:51 -0600
Message-ID: <1464097434-10063-1-git-send-email-stephenjust@gmail.com>
References: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35161 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbcEXTrA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 15:47:00 -0400
Received: by mail-it0-f65.google.com with SMTP id z123so2953126itg.2
        for <linux-input@vger.kernel.org>; Tue, 24 May 2016 12:47:00 -0700 (PDT)
In-Reply-To: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Bastien Nocera <hadess@hadess.net>

This series adds support for Surface Pen devices to the Surface 3
touchscreen input driver.

This series works with both styles of pen:
the old style with pressure sensitive tip, an eraser button, and a 
secondary input button, as well as the new style pen which does not
have a dedicated eraser button.

The top button on the pen is not supported by this patch. Those
buttons are a separate Bluetooth device.

This is v2 of the series with a minor code cleanup to use a
switch/case as suggested by Benjamin.

Regards,
Stephen Just

Stephen Just (2):
  Input - surface3_spi: Prepare to add support for Surface Pen
  Input - surface3_spi: add surface pen support for Surface 3

 drivers/input/touchscreen/surface3_spi.c | 145 ++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 13 deletions(-)

-- 
2.8.2

