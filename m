From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/6] Input: keyboard: pmic8xxx: remove unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:17 +0100
Message-ID: <20171122174921.20192-3-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdKVRtf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 12:49:35 -0500
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

MODULE_VERSION is useless for in-kernel drivers, so remove the use of it
in the pmic8xxx-keyboard driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 97c5424f49b9..98b24ed18752 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -697,6 +697,5 @@ module_platform_driver(pmic8xxx_kp_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("PMIC8XXX keypad driver");
-MODULE_VERSION("1.0");
 MODULE_ALIAS("platform:pmic8xxx_keypad");
 MODULE_AUTHOR("Trilok Soni <tsoni@codeaurora.org>");
-- 
2.15.0

