From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Tue, 20 Jan 2015 12:05:48 +0200
Message-ID: <20150120100548.GG1850@lahna.fi.intel.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
 <20150119153758.GA18115@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbbATKGa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 05:06:30 -0500
Content-Disposition: inline
In-Reply-To: <20150119153758.GA18115@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2015 at 10:37:58AM -0500, Benjamin Tissoires wrote:
> Hi Antonio,
> 
> [adding Mika in CC, he implemented most of the ACPI and GPIO for
> i2c-hid]
> 
> On Jan 17 2015 or thereabouts, Antonio Ospite wrote:
> > Hi,
> > 
> > I am trying to make the Goodix driver (drivers/input/touchscreen/goodix.c)
> > working with a Teclast X98 Air 3G, a tablet based on Intel Bay Trail,
> > but I am new to ACPI and I could use some help.
> > 
> > I am working with a 3.19-rc4 kernel compiled for x86_64.
> > 
> > This is the DSDT section in the UEFI firmware:
> > 
> >             Device (TCS0)
> >             {
> >                 Name (_ADR, Zero)  // _ADR: Address
> >                 Name (_HID, "GODX0911")  // _HID: Hardware ID
> >                 Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
> 
> urgh, this is bad. It declares itself as i2c-hid, but it is not :(
> Anyway, according to your logs, i2c-hid probe() just fails, so it's not
> a big problem.


Actually, I think this device should use i2c-hid. All the ACPI plumbing
is there including _DSM.

What makes you think it should use the goodix driver?

> 
> >                 Name (_S0W, Zero)  // _S0W: S0 Device Wake State
> >                 Name (_DEP, Package (0x02)  // _DEP: Dependencies
> >                 {
> >                     GPO1, 
> >                     I2C5
> >                 })
> >                 Method (_PS3, 0, Serialized)  // _PS3: Power State 3
> >                 {
> >                     If ((^^^I2C5.PMIC.AVBG == One)) {}
> >                 }
> > 
> >                 Method (_PS0, 0, Serialized)  // _PS0: Power State 0
> >                 {
> >                     If ((^^^GPO1.AVBL == One))
> >                     {
> >                         ^^^GPO1.TCD3 = Zero
> >                     }
> > 
> >                     Sleep (0x05)
> >                     If ((^^^I2C5.PMIC.AVBG == One)) {}
> >                     Sleep (0x1E)
> >                     If ((^^^GPO1.AVBL == One))
> >                     {
> >                         ^^^GPO1.TCD3 = One
> >                     }
> > 
> >                     Sleep (0x78)
> >                 }
> > 
> >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >                 {
> >                     Name (RBUF, ResourceTemplate ()
> >                     {
> >                         I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
> >                             AddressingMode7Bit, "\\_SB.I2C4",
> >                             0x00, ResourceConsumer, ,
> >                             )
> >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
> >                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
> >                             )
> >                             {   // Pin list
> >                                 0x0044
> >                             }
> >                     })
> >                     Name (ABUF, ResourceTemplate ()
> >                     {
> >                         I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
> >                             AddressingMode7Bit, "\\_SB.I2C4",
> >                             0x00, ResourceConsumer, ,
> >                             )
> >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
> >                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
> >                             )
> >                             {   // Pin list
> >                                 0x0044
> >                             }
> >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
> >                             )
> >                             {   // Pin list
> >                                 0x001A
> >                             }
> >                     })
> 
> It looks like the GPIOs are correctly declared. The ACPI code should set
> the client->irq auto-magically. It's not the case, so I guess Mika
> should be able to tell us more on that.

The current i2c-hid.c does not cope with GPIO interrupts. I've attached
an experimental patch that should convert the driver to use them.

Antonio, can you try that out and check if i2c-hid driver gets you
working touch screen? Also please add "i2c_hid.debug=1" to the kernel
command line so we can see if it returns proper HID descriptor.

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-HID-i2c-hid-Preliminary-support-for-GPIO-interrupts.patch"

>From 9b7518976295978b28e1ad7a2404a139b0cd9345 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Fri, 3 Oct 2014 17:07:10 +0300
Subject: [PATCH] HID: i2c-hid: Preliminary support for GPIO interrupts

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 70 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index d43e967e7533..fd22e638830f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -144,6 +145,8 @@ struct i2c_hid {
 	unsigned long		flags;		/* device flags */
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
+	struct gpio_desc	*desc;
+	int			irq;
 
 	struct i2c_hid_platform_data pdata;
 };
@@ -782,16 +785,16 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
-	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
+	dev_dbg(&client->dev, "Requesting IRQ: %d\n", ihid->irq);
 
-	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
+	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
 			" ret = %d\n",
-			client->name, client->irq, ret);
+			client->name, ihid->irq, ret);
 
 		return ret;
 	}
@@ -838,6 +841,14 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 }
 
 #ifdef CONFIG_ACPI
+
+/* Default GPIO mapping */
+static const struct acpi_gpio_params i2c_hid_irq_gpio = { 0, 0, true };
+static const struct acpi_gpio_mapping i2c_hid_acpi_gpios[] = {
+	{ "irq-gpios", &i2c_hid_irq_gpio, 1 },
+	{ },
+};
+
 static int i2c_hid_acpi_pdata(struct i2c_client *client,
 		struct i2c_hid_platform_data *pdata)
 {
@@ -863,7 +874,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
-	return 0;
+	return acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
@@ -927,12 +938,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	dbg_hid("HID probe called for i2c 0x%02x\n", client->addr);
 
-	if (!client->irq) {
-		dev_err(&client->dev,
-			"HID over i2c has not been provided an Int IRQ\n");
-		return -EINVAL;
-	}
-
 	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
@@ -952,6 +957,25 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
+	if (client->irq > 0) {
+		ihid->irq = client->irq;
+	} else {
+		ihid->desc = gpiod_get(&client->dev, "irq");
+		if (IS_ERR(ihid->desc)) {
+			dev_err(&client->dev, "Failed to get GPIO interrupt\n");
+			return PTR_ERR(ihid->desc);
+		}
+
+		gpiod_direction_input(ihid->desc);
+
+		ihid->irq = gpiod_to_irq(ihid->desc);
+		if (ihid->irq < 0) {
+			gpiod_put(ihid->desc);
+			dev_err(&client->dev, "Failed to convert GPIO to IRQ\n");
+			return ihid->irq;
+		}
+	}
+
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1014,13 +1038,16 @@ err_mem_free:
 	hid_destroy_device(hid);
 
 err_irq:
-	free_irq(client->irq, ihid);
+	free_irq(ihid->irq, ihid);
 
 err_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 
 err:
+	if (ihid->desc)
+		gpiod_put(ihid->desc);
+
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
@@ -1039,13 +1066,18 @@ static int i2c_hid_remove(struct i2c_client *client)
 	hid = ihid->hid;
 	hid_destroy_device(hid);
 
-	free_irq(client->irq, ihid);
+	free_irq(ihid->irq, ihid);
 
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
+	if (ihid->desc)
+		gpiod_put(ihid->desc);
+
 	kfree(ihid);
 
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
+
 	return 0;
 }
 
@@ -1057,9 +1089,9 @@ static int i2c_hid_suspend(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int ret = 0;
 
-	disable_irq(client->irq);
+	disable_irq(ihid->irq);
 	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(client->irq);
+		enable_irq_wake(ihid->irq);
 
 	if (hid->driver && hid->driver->suspend)
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
@@ -1077,13 +1109,13 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 
-	enable_irq(client->irq);
+	enable_irq(ihid->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
 		return ret;
 
 	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(client->irq);
+		disable_irq_wake(ihid->irq);
 
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
@@ -1098,17 +1130,19 @@ static int i2c_hid_resume(struct device *dev)
 static int i2c_hid_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
-	disable_irq(client->irq);
+	disable_irq(ihid->irq);
 	return 0;
 }
 
 static int i2c_hid_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	enable_irq(client->irq);
+	enable_irq(ihid->irq);
 	i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	return 0;
 }
-- 
2.1.4


--X1bOJ3K7DJ5YkBrT--
