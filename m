Return-Path: <SRS0=sycj=ZN=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E2C432C0
	for <linux-input@archiver.kernel.org>; Thu, 21 Nov 2019 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DAA20679
	for <linux-input@archiver.kernel.org>; Thu, 21 Nov 2019 13:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUNVF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:21:05 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNVF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Nov 2019 08:21:05 -0500
Received: from orion.localdomain ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mo77T-1i4oDM1mzz-00pfFZ; Thu, 21 Nov 2019 14:21:03 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH] input: misc: Kconfig: use select instead of depends on KEYBOARD_GPIO
Date:   Thu, 21 Nov 2019 14:20:46 +0100
Message-Id: <20191121132046.11977-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:IILHN2gZyS/uD0ijtR3gpcJUJy3FftXsgrH1MzQ+23L6j1fpvVf
 EfCR+YvcrUTzV34S08cFqJrBL1qq2szZ7KElXWbrT+/qPWEjPrhzh00UHdkM0eJg9PJFgow
 yq05yqTcV7XKhP9TKnEQoeYDBChgHC59Vj+IaAn1w4yfOcqcvAgzdY3Ze3XtyOKe4qmlCbj
 3YUNiN/NjpYWocPeLM+Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/83MODPXh00=:kewR5FyNX8qhcslOklspDd
 NsOVmXeUNSymLHWV6UJ6K5Zbq/ZXNxVZL1JKy5zTSSD77EktDTQh0yga0u8VOg+AceWBzYtJt
 fxMgTFOVHtD8dBl4Ux24rfqBTn5TVkYKfgVu35xVThckfRzszb+pyC9VhV9p2S8kDlUwvr3G4
 47CLFMFq9ABaO3zYAknsLF3OU33qdLA95hOPdPyIZ5+pcOwCqOAsS97y1EP0kSkcXe4RbcwiV
 8bRJMWXcqqfGJ7YPbHse4UIqVvokYpv3DonQgwyioIRUttAqAc0PrrEU5zS0Ys9VyOMNULAo6
 hLULBl6ujA1cUdlK/c5qOpj+yBSiDqwt15iiMIiJ60JJx8DZontKYPTs3sKXTZdyKh0B0pcHW
 t9RyO4aI7a/fITISu/L3Cc7bbsmVdBK9dPjMuo+o2EeljaOvBLFthm1HfPUYw4XO+F6Oaproz
 uuFgnaBMDdtkeSOocTggKLzqs+A3EXSgj4LPIq/7OJwCyIbUVthhHGVZJeWrr1mGtXdvbHp5u
 x9jS/P8gjTYptT+C2H44DPlZoXxIv1uzj1CN5rm8+bxw8aCWowOa/D9Z+I38Pnyg2NI9iaSw9
 YqWLdQ3dGgNt+aTkIQz6N5EU8wmlR6bb5fowCN3VfjKBHHHaQf+hb+8T0O3ymbS9cBpuhvuqq
 Jaab1jF1L81ZRN2SdByLpH2tEdhj8lMJJ9yiWe71LQApNDoCTEaAztMYxpLa/ROzVNvU2wD3X
 9+sqmvzIos3Ccod7hyi6owYGzbVCXOT8HdHH2F/knJIDOi6I+DHqO06Vx6fB6FkY8TJUZ0UHT
 +KTuXWNNT0P0htN37lAGqQ7/RNvS84sraGKpfjkvnZbJU8mmSnGhSJqmS0IwGh5xgp+fr8cxp
 MliF+7TacbSfifvjH4iw==
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Make selection of the driver a bit easier by replacing depends on
KEYBOARD_GPIO by select, so we don't need to enable KEYBOARD_GPIO
before being able to enable INPUT_SOC_BUTTON_ARRAY.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/misc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7d9ae394e597..99d263177d8d 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -813,7 +813,8 @@ config INPUT_IDEAPAD_SLIDEBAR
 
 config INPUT_SOC_BUTTON_ARRAY
 	tristate "Windows-compatible SoC Button Array"
-	depends on KEYBOARD_GPIO && ACPI
+	depends on ACPI
+	select KEYBOARD_GPIO
 	help
 	  Say Y here if you have a SoC-based tablet that originally runs
 	  Windows 8 or a Microsoft Surface Book 2, Pro 5, Laptop 1 or later.
-- 
2.11.0

