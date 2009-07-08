From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] pcspkr: switch driver to dev_pm_ops
Date: Wed, 8 Jul 2009 14:18:36 +0200
Message-ID: <200907081418.37229.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:65434 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428AbZGHMSm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jul 2009 08:18:42 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Dmitry Torokhov <dtor@mail.ru>

Gets rid of the following warning:
Platform driver 'pcspkr' needs updating - please use dev_pm_ops

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---

Looked straightforward enough for me to give it a shot.

diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index 6d67af5..21cb755 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -114,7 +114,7 @@ static int __devexit pcspkr_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int pcspkr_suspend(struct platform_device *dev, pm_message_t state)
+static int pcspkr_suspend(struct device *dev)
 {
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 
@@ -127,14 +127,18 @@ static void pcspkr_shutdown(struct platform_device *dev)
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 }
 
+static struct dev_pm_ops pcspkr_pm_ops = {
+	.suspend = pcspkr_suspend,
+};
+
 static struct platform_driver pcspkr_platform_driver = {
 	.driver		= {
 		.name	= "pcspkr",
 		.owner	= THIS_MODULE,
+		.pm	= &pcspkr_pm_ops,
 	},
 	.probe		= pcspkr_probe,
 	.remove		= __devexit_p(pcspkr_remove),
-	.suspend	= pcspkr_suspend,
 	.shutdown	= pcspkr_shutdown,
 };
 
