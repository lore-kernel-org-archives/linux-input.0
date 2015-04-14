From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Hidden dependency of i2c-hid on GPIOLIB
Date: Tue, 14 Apr 2015 12:59:24 +0300
Message-ID: <20150414095924.GB1677@lahna.fi.intel.com>
References: <2014782.heKI7XOhuD@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52721 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbbDNJ72 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 05:59:28 -0400
Content-Disposition: inline
In-Reply-To: <2014782.heKI7XOhuD@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, Apr 14, 2015 at 12:55:20AM +0200, Gabriele Mazzotta wrote:
> Hi,
> 
> my touchpad stopped working because of a485923efbb8 ("HID: i2c-hid:
> Add support for ACPI GPIO interrupts"). It turned out that I need
> CONFIG_GPIOLIB. I think this dependency should be made explicit or the
> driver should not depend on it.

Using GPIOs should be optional. Gpiolib stubs functions out whenever it
is not enabled.

However, I made a mistake when GPIOs are fed to the driver. If gpiolib
is not enabled acpi_dev_add_driver_gpios() returns -ENXIO and prevents
your touchpad from working.

I think it is alright to ignore the error here. Can you try if below
patch helps?

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ab4dd952b6ba..b427c11d4cd3 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -877,7 +877,8 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
-	return acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
+	acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
+	return 0;
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
