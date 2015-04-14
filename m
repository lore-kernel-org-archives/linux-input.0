From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Hidden dependency of i2c-hid on GPIOLIB
Date: Tue, 14 Apr 2015 12:03:51 +0200
Message-ID: <7007524.JGeOHMMZVW@xps13>
References: <2014782.heKI7XOhuD@xps13> <20150414095924.GB1677@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35839 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbbDNKDy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 06:03:54 -0400
In-Reply-To: <20150414095924.GB1677@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tuesday 14 April 2015 12:59:24 Mika Westerberg wrote:
> On Tue, Apr 14, 2015 at 12:55:20AM +0200, Gabriele Mazzotta wrote:
> > Hi,
> > 
> > my touchpad stopped working because of a485923efbb8 ("HID: i2c-hid:
> > Add support for ACPI GPIO interrupts"). It turned out that I need
> > CONFIG_GPIOLIB. I think this dependency should be made explicit or the
> > driver should not depend on it.
> 
> Using GPIOs should be optional. Gpiolib stubs functions out whenever it
> is not enabled.
> 
> However, I made a mistake when GPIOs are fed to the driver. If gpiolib
> is not enabled acpi_dev_add_driver_gpios() returns -ENXIO and prevents
> your touchpad from working.
> 
> I think it is alright to ignore the error here. Can you try if below
> patch helps?

Sorry for not being more specific. Yes, the problem is that
acpi_dev_add_driver_gpios() returns -ENXIO if CONFIG_GPIOLIB is not set.

> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index ab4dd952b6ba..b427c11d4cd3 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -877,7 +877,8 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
>  	pdata->hid_descriptor_address = obj->integer.value;
>  	ACPI_FREE(obj);
>  
> -	return acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
> +	acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
> +	return 0;
>  }
>  
>  static const struct acpi_device_id i2c_hid_acpi_match[] = {
