From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: i2c-hid: Do not set the ACPI companion field in the
 HID device
Date: Tue, 2 Jun 2015 16:44:22 -0700
Message-ID: <CANLzEksDxGnZfGjKNupma4qfympFBSYS5Ftyu-v8avmkgSAD-w@mail.gmail.com>
References: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36343 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbbFBXoX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2015 19:44:23 -0400
Received: by igbpi8 with SMTP id pi8so99226143igb.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2015 16:44:22 -0700 (PDT)
In-Reply-To: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, Jun 2, 2015 at 2:46 PM, Andrew Duggan <aduggan@synaptics.com> wrote:
> The HID device does not need to know about the ACPI device associated with
> the underlying i2c device. Setting the ACPI companion field in the HID device
> also has the side effect of causing HID to be set as wake capable, since
> acpi_bind_one uses's the companion ACPI device's wakeup flags to set the
> device as wake capable. Which results in power/wakeup files in sysfs for
> the HID device which do not do anything.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Reviewed-by: Benson Leung <bleung@chromium.org>
Tested-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 92d6cdf..0dfb5d1 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1019,7 +1019,6 @@ static int i2c_hid_probe(struct i2c_client *client,
>         hid->driver_data = client;
>         hid->ll_driver = &i2c_hid_ll_driver;
>         hid->dev.parent = &client->dev;
> -       ACPI_COMPANION_SET(&hid->dev, ACPI_COMPANION(&client->dev));
>         hid->bus = BUS_I2C;
>         hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
>         hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
> --
> 2.1.4
>



-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
