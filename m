From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
Date: Wed, 7 Sep 2016 11:30:22 +0200
Message-ID: <3d89b80c-d211-11ba-a3c5-a1c6e754f1e1@gmail.com>
References: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
 <CAN+gG=EiFgVKdwc0J-UBDtAg2SkGqJQB9--CL7BL8ZDn7dXD7g@mail.gmail.com>
 <1473200056.6178.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36782 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbcIGJa0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 05:30:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so1983798wmf.3
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2016 02:30:25 -0700 (PDT)
In-Reply-To: <1473200056.6178.1.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin Johnstone <johnstone.colin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>



On 09/07/2016 12:14 AM, Colin Johnstone wrote:
> On Mon, 2016-09-05 at 12:19 +0200, Benjamin Tissoires wrote:
>> > Hi Colin,
>> > 
>> > On Sat, Sep 3, 2016 at 8:33 PM, Colin Johnstone
>> > <johnstone.colin@gmail.com> wrote:
>>> > > 
>>> > > [1.] One line summary of the problem: Touchscreen does not work,
>>> > > dmesg
>>> > > shows errors "i2c_hid i2c-ELAN0732:00: failed to reset device",
>>> > > "i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and "i2c_hid:
>>> > > probe of i2c-ELAN0732:00 failed with error -61" occur during boot.
>> > 
>> > -61 is -ENODATA, which is raised when we timed-out when waiting for
>> > the interrupt line.
>> > 
>> > To confirm this, please provide a dmesg from the boot with
>> > i2c_hid.debug=1 appended to the kernel command line.
>> > 
>>> > > 
>>> > > 
>>> > > [2.] Full description of the problem/report: This is on an HP Eny
>>> > > x360
>>> > > M6-AR004DX laptop with 7th-generation AMD FX CPU. The touchscreen
>>> > > is
>>> > > not recognized at all; it appears the screen is using GPIO
>>> > > interrupts
>>> > > as I have to build with AMD GPIO support to receive these errors,
>>> > > otherwise I see a "failed to get GPIO interrupt" error.
>>> > > 
>> > 
>> > So this is more likely either a failure of us retrieving the GPIO, or
>> > a misconfiguration of those. I'd be interested if you could share the
>> > output of acpidump (as root) as well.
>> > 
>> > Cheers,
>> > Benjamin
> My apologies, the previous dmesg output was incorrect. I had an issue
> with my grub config and was booting the wrong kernel build. Here's the
> correct output, with AMD GPIO support:

Thanks for the updated dmesg.

So it looks like the interrupt is never served, which leads to timeout while
resetting the device.

The question now is: are we enabling the GPIO as Interrupt properly or is the
bug in AMD GPIO?

Could you try applying the following patch? It should retrieve the information
of level trigger from ACPI which might help (though I have no big hope):

---

commit ebdb645c5cbf70c745527169c99b82c01e74231e
Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed Sep 7 10:59:58 2016 +0200

    HID: i2c-hid: retrieve the GPIO parameters from ACPI
    
    Instead of forcing the level triggers of the GPIO INT,
    we can count on ACPI to set it up for us.
    
    *NOTE: this currently breaks other Int sources than GpioInt*
    
    Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index d0b1355..feacd9f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -145,7 +145,6 @@ struct i2c_hid {
 	unsigned long		flags;		/* device flags */
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
-	struct gpio_desc	*desc;
 	int			irq;
 
 	struct i2c_hid_platform_data pdata;
@@ -819,9 +818,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "Requesting IRQ: %d\n", ihid->irq);
 
-	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-			client->name, ihid);
+	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq, IRQF_ONESHOT,
+				   client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
@@ -1021,16 +1019,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		ihid->irq = client->irq;
 	} else if (ACPI_COMPANION(&client->dev)) {
-		ihid->desc = gpiod_get(&client->dev, NULL, GPIOD_IN);
-		if (IS_ERR(ihid->desc)) {
-			dev_err(&client->dev, "Failed to get GPIO interrupt\n");
-			return PTR_ERR(ihid->desc);
-		}
-
-		ihid->irq = gpiod_to_irq(ihid->desc);
+		ihid->irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
 		if (ihid->irq < 0) {
-			gpiod_put(ihid->desc);
-			dev_err(&client->dev, "Failed to convert GPIO to IRQ\n");
+			dev_err(&client->dev, "Failed to request IRQ\n");
 			return ihid->irq;
 		}
 	}
@@ -1108,9 +1099,6 @@ err_pm:
 	pm_runtime_disable(&client->dev);
 
 err:
-	if (ihid->desc)
-		gpiod_put(ihid->desc);
-
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
@@ -1134,9 +1122,6 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
-	if (ihid->desc)
-		gpiod_put(ihid->desc);
-
 	kfree(ihid);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));

---

I couldn't find a working device in your DSDT that would be using the GPIO from your chip
(HPQ6007 seemed a good candidate, but it fails probing at a different step).

Cheers,
Benjamin
