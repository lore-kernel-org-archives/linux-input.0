From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH v3 0/2] Input: surface3_spi: Surface Pen Support
Date: Wed, 25 May 2016 05:40:03 -0600
Message-ID: <1464176406-9917-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32855 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbcEYRlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 13:41:06 -0400
Received: by mail-it0-f68.google.com with SMTP id l63so6296754ita.0
        for <linux-input@vger.kernel.org>; Wed, 25 May 2016 10:41:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>

This series adds support for Surface Pen devices to the Surface 3
touchscreen input driver.

This series works with both styles of pen:
the old style with pressure sensitive tip, an eraser button, and a 
secondary input button, as well as the new style pen which does not
have a dedicated eraser button.

The top button on the pen is not supported by this patch. Those
buttons are a separate Bluetooth device.

Changes in v2: Code cleanup
Changes in v3: Send proximity-out report when switching tools

See evemu-record example:
https://gist.github.com/stephenjust/08f67f1668aa116c78be4412610ad4d0

Regards,
Stephen Just

Stephen Just (2):
  Input - surface3_spi: Prepare to add support for Surface Pen
  Input - surface3_spi: add surface pen support for Surface 3

 drivers/input/touchscreen/surface3_spi.c | 148 ++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 13 deletions(-)

-- 
2.8.2

