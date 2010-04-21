From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 21 Apr 2010 01:10:48 -0700
Message-ID: <20100421081048.GA22357@core.coreip.homeip.net>
References: <20100329233257.GA85504@jhz.name>
 <20100329233901.GF5864@core.coreip.homeip.net>
 <20100330203911.GA89560@jhz.name>
 <20100414233401.GA12414@core.coreip.homeip.net>
 <20100419094614.GA27749@jhz.name>
 <20100421070158.GM4364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41896 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0DUIKz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 04:10:55 -0400
Received: by pwj9 with SMTP id 9so4913069pwj.19
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 01:10:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100421070158.GM4364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Hendrik Zab <jan@jhz.name>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Wed, Apr 21, 2010 at 12:01:58AM -0700, Dmitry Torokhov wrote:
> On Mon, Apr 19, 2010 at 11:46:14AM +0200, Jan-Hendrik Zab wrote:
> > On 14/04/10 16:34 -0700, Dmitry Torokhov wrote:
> > > Sorry for the delay. I wonder if we simply do not recognize PNP ID for
> > > the touchpad. Coudl you give me output of:
> > > 
> > > for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done
> > > 
> > > and also your dsdt.
> > 
> > Hey,
> > I attached the DSDT and uploaded it to [0] for everyone on the
> > mailing list.
> > 
> 
> *sigh*
> 
> 
>                 Device (PS2M)
>                 {
>                     Name (_HID, "SNYSYN0003")
>                     Name (_CID, EisaId ("PNP0F13"))
>                     Name (_CRS, ResourceTemplate ()
> 
> PNP ID should be 7 characters...
> 
> Bjorn, do you think we could substitute CID for HID in case HID is
> invalid PNP device ID but CID is valid?
> 

Does something like below help in any way?

-- 
Dmitry


PNPACPI: cope with invalid device IDs

If primary ID (HID) is invalid try locating first valid ID on compatible
ID list before giving up.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/pnp/pnpacpi/core.c      |   27 +++++++++++++++++++++++----
 include/linux/mod_devicetable.h |    1 +
 2 files changed, 24 insertions(+), 4 deletions(-)


diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index f7ff628..1bf1677 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -28,7 +28,7 @@
 #include "../base.h"
 #include "pnpacpi.h"
 
-static int num = 0;
+static int num;
 
 /* We need only to blacklist devices that have already an acpi driver that
  * can't use pnp layer. We don't need to blacklist device that are directly
@@ -157,11 +157,24 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
+static char *pnpacpi_get_id(struct acpi_device *device)
+{
+	struct acpi_hardware_id *id;
+
+	list_for_each_entry(id, &device->pnp.ids, list) {
+		if (ispnpidacpi(id->id))
+			return id->id;
+	}
+
+	return NULL;
+}
+
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
 	acpi_handle temp = NULL;
 	acpi_status status;
 	struct pnp_dev *dev;
+	char *pnpid;
 	struct acpi_hardware_id *id;
 
 	/*
@@ -169,11 +182,17 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	 * driver should not be loaded.
 	 */
 	status = acpi_get_handle(device->handle, "_CRS", &temp);
-	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-	    is_exclusive_device(device) || (!device->status.present))
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	pnpid = pnpacpi_get_id(device);
+	if (!pnpid)
+		return 0;
+
+	if (!is_exclusive_device(device) || !device->status.present)
 		return 0;
 
-	dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));
+	dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid);
 	if (!dev)
 		return -ENOMEM;
 
