From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: qt1070 - Add MODULE_DEVICE_TABLE
Date: Sun, 24 Apr 2011 23:22:45 +0800
Message-ID: <1303658565.8556.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53941 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366Ab1DXPWx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Apr 2011 11:22:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Bo Shen <voice.shen@atmel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Adding the necessary MODULE_DEVICE_TABLE() information allows the
driver to be automatically loaded by udev

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/keyboard/qt1070.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index fba8404..ca7b891 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -248,6 +248,7 @@ static const struct i2c_device_id qt1070_id[] = {
 	{ "qt1070", 0 },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, qt1070_id);
 
 static struct i2c_driver qt1070_driver = {
 	.driver	= {
-- 
1.7.1



