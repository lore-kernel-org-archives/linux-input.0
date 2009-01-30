From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 4/5] input: Update pxa27x_keypad to use MATRIX_KEY macro
Date: Fri, 30 Jan 2009 13:48:48 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A546D@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og116.obsmtp.com ([64.18.1.37]:38732 "HELO
	exprod6og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751411AbZA3St0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:49:26 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Update the pxa27x_keypad driver to use common MATRIX_KEY macro.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
index d5a48a9..7196447 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
+++ b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
@@ -51,8 +51,6 @@ struct pxa27x_keypad_platform_data {
 	unsigned int	debounce_interval;
 };

-#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
-
 extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data
*info);

 #endif /* __ASM_ARCH_PXA27x_KEYPAD_H */ 
