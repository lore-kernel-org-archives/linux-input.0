From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] Input: scan pci_bus_type
Date: Mon, 02 Feb 2009 14:44:31 +0100
Message-ID: <4986F8BF.9000102@gmail.com>
References: <4980D3F6.3050409@gmail.com> <20090130071021.GB3481@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39262 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZBBNoe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2009 08:44:34 -0500
Received: by ewy14 with SMTP id 14so1846973ewy.13
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2009 05:44:32 -0800 (PST)
In-Reply-To: <20090130071021.GB3481@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Jan 28, 2009 at 10:53:58PM +0100, Roel Kluin wrote:
>> scan pci_bus_type rather then a get/put
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> 
> Applied to by 'next' branch, thank you Roel.
> 
A bit better is this patch, since struct pci_dev *dev isn't used
anywhere else in this function.
------------------->8--------------8<----------------------
scan pci_bus_type rather then a get/put

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index fd09c8d..3941f97 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -108,14 +108,10 @@ static int pc110pad_open(struct input_dev *dev)
  */
 static int __init pc110pad_init(void)
 {
-	struct pci_dev *dev;
 	int err;
 
-	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
-	if (dev) {
-		pci_dev_put(dev);
+	if (!no_pci_devices())
 		return -ENODEV;
-	}
 
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
 		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
