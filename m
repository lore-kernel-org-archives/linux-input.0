From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH 0/2] Input: surface3_spi: Surface Pen Support
Date: Mon, 23 May 2016 07:55:32 -0600
Message-ID: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34791 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcEWT4W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 15:56:22 -0400
Received: by mail-io0-f196.google.com with SMTP id d197so16496434ioe.1
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 12:56:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Bastien Nocera <hadesss@hadess.net>

This series adds support for Surface Pen devices to the Surface 3
touchscreen input driver.

This series works with both styles of pen:
the old style with pressure sensitive tip, an eraser button, and a
secondary input button, as well as the new style pen which does not
have a dedicated eraser button.

The top button on the pen is not supported by this patch. Those
buttons are a separate Bluetooth device.

Stephen Just (2):
  Input - surface3_spi: Prepare to add support for Surface Pen
  Input - surface3_spi: add surface pen support for Surface 3

 drivers/input/touchscreen/surface3_spi.c | 140 ++++++++++++++++++++++++++++---
 1 file changed, 127 insertions(+), 13 deletions(-)

-- 
2.8.2

