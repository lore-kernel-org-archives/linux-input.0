From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/5] hid: Add device group to modalias
Date: Thu, 19 Apr 2012 12:06:45 +0200
Message-ID: <20120419100645.GA23480@polaris.bitmath.org>
References: <1334786457-2124-1-git-send-email-rydberg@euromail.se>
 <1334786457-2124-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:44563 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2DSKDd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Apr 2012 06:03:33 -0400
Content-Disposition: inline
In-Reply-To: <1334786457-2124-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 19, 2012 at 12:00:53AM +0200, Henrik Rydberg wrote:
> HID devices are only partially presented to userland.  Hotplugged
> devices emit events containing a modalias based on the basic bus,
> vendor and product entities. However, in practise a hid device can
> depend on details such as a single usb interface or a particular item
> in a report descriptor.
> 
> This patch adds a device group to the hid device id, and broadcasts it
> using uevent and the device modalias.  The module alias generation is
> modified to match. As a consequence, a device with a non-zero group
> will be processed by the corresponding group driver instead of by the
> generic hid driver.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---

Addition for v2: store_new_id() needs to be modified as well, in order
for the added devices to match the right device group. Something like
the below should suffice.

Henrik

---

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4845567..3c9bf3e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -580,6 +576,17 @@ const struct hid_device_id *hid_match_id(struct hid_device *hdev,
 	return NULL;
 }
 
+static int hid_get_driver_group(const struct hid_driver *hdrv)
+{
+	const struct hid_device_id *id;
+	int group = 0;
+
+	for (id = hdrv->id_table; id->bus; id++)
+		group = id->group;
+
+	return group;
+}
+
 static const struct hid_device_id hid_hiddev_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1) },
@@ -977,6 +984,7 @@ static ssize_t store_new_id(struct device_driver *drv, const char *buf,
 		return -ENOMEM;
 
 	dynid->id.bus = bus;
+	dynid->id.group = hid_get_driver_group(hdrv);
 	dynid->id.vendor = vendor;
 	dynid->id.product = product;
 	dynid->id.driver_data = driver_data;
