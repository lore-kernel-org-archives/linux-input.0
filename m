From: Andrew Duggan <andrew.duggan@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table
Date: Wed, 9 Mar 2016 10:37:51 -0800
Message-ID: <CAE7eX3LswXqKRP6yM9ggZR9dy6vby1KST3uCJm7SFDqyx5i_6Q@mail.gmail.com>
References: <20160308192539.GA23955@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34513 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933893AbcCIShx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 13:37:53 -0500
In-Reply-To: <20160308192539.GA23955@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org

On Tue, Mar 8, 2016 at 11:25 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> When using the device tree binding OF compatible = "hid-over-i2c" the
> i2c id table also needs to have that name in order to auto load this
> driver, since i2c core reports module alias as i2c:<string> where
> <string> is compatible string of OF binding stripped of manufacturer's
> prefix.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Tested-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index b921693..a2c6c98 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1191,6 +1191,7 @@ static const struct dev_pm_ops i2c_hid_pm = {
>
>  static const struct i2c_device_id i2c_hid_id_table[] = {
>         { "hid", 0 },
> +       { "hid-over-i2c", 0 },
>         { },
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
> --
> 2.7.0.rc3.207.g0ac5344
>
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
