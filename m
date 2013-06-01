From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] HID: hyperv: Cocci spatch "memdup.spatch"
Date: Sat, 01 Jun 2013 11:40:31 +0200
Message-ID: <1370079631.29224.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, haiyangz@microsoft.com, jkosina@suse.cz, devel@linuxdriverproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -199,13 +199,11 @@ static void mousevsc_on_receive_device_i
 	if (desc->bLength == 0)
 		goto cleanup;
 
-	input_device->hid_desc = kzalloc(desc->bLength, GFP_ATOMIC);
+	input_device->hid_desc = kmemdup(desc, desc->bLength, GFP_ATOMIC);
 
 	if (!input_device->hid_desc)
 		goto cleanup;
 
-	memcpy(input_device->hid_desc, desc, desc->bLength);
-
 	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
