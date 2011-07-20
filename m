From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:input:change the statement be consistent with the style of the rest
Date: Wed, 20 Jul 2011 22:34:27 +0800
Message-ID: <1311172467-7110-1-git-send-email-wanlong.gao@gmail.com>
References: <1311171857-6869-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55243 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab1GTOgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 10:36:43 -0400
Received: by iwn6 with SMTP id 6so239048iwn.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 07:36:42 -0700 (PDT)
In-Reply-To: <1311171857-6869-1-git-send-email-wanlong.gao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Change the statement of *_init() and *_exit() in ad714x-spi.c
to be consistent with the style of the rest.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/ad714x-spi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 4120dd5..7c172cb 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -85,13 +85,13 @@ static struct spi_driver ad714x_spi_driver = {
 	.remove		= __devexit_p(ad714x_spi_remove),
 };
 
-static __init int ad714x_spi_init(void)
+static int __init ad714x_spi_init(void)
 {
 	return spi_register_driver(&ad714x_spi_driver);
 }
 module_init(ad714x_spi_init);
 
-static __exit void ad714x_spi_exit(void)
+static void __exit ad714x_spi_exit(void)
 {
 	spi_unregister_driver(&ad714x_spi_driver);
 }
-- 
1.7.4.1

