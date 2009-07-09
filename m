From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] PNP: add .shutdown method
Date: Thu, 9 Jul 2009 15:39:19 -0600
Message-ID: <200907091539.20165.bjorn.helgaas@hp.com>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu> <200907081052.20142.bjorn.helgaas@hp.com> <200907091538.21685.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:9797 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbZGIVjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 17:39:23 -0400
In-Reply-To: <200907091538.21685.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 527ee76..cd11b11 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -135,6 +135,15 @@ static int pnp_device_remove(struct device *dev)
 	return 0;
 }
 
+static void pnp_device_shutdown(struct device *dev)
+{
+	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver *drv = pnp_dev->driver;
+
+	if (drv && drv->shutdown)
+		drv->shutdown(pnp_dev);
+}
+
 static int pnp_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
@@ -203,6 +212,7 @@ struct bus_type pnp_bus_type = {
 	.match   = pnp_bus_match,
 	.probe   = pnp_device_probe,
 	.remove  = pnp_device_remove,
+	.shutdown = pnp_device_shutdown,
 	.suspend = pnp_bus_suspend,
 	.resume  = pnp_bus_resume,
 	.dev_attrs = pnp_interface_attrs,
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index b063c73..fddfafa 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -360,6 +360,7 @@ struct pnp_driver {
 	unsigned int flags;
 	int (*probe) (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
 	void (*remove) (struct pnp_dev *dev);
+	void (*shutdown) (struct pnp_dev *dev);
 	int (*suspend) (struct pnp_dev *dev, pm_message_t state);
 	int (*resume) (struct pnp_dev *dev);
 	struct device_driver driver;
