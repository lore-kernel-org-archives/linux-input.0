From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table
Date: Wed, 9 Mar 2016 20:50:58 +0100
Message-ID: <20160309195058.GJ22340@mail.corp.redhat.com>
References: <20160308192539.GA23955@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933634AbcCITvD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2016 14:51:03 -0500
Content-Disposition: inline
In-Reply-To: <20160308192539.GA23955@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 08 2016 or thereabouts, Dmitry Torokhov wrote:
> When using the device tree binding OF compatible = "hid-over-i2c" the
> i2c id table also needs to have that name in order to auto load this
> driver, since i2c core reports module alias as i2c:<string> where
> <string> is compatible string of OF binding stripped of manufacturer's
> prefix.

OK, so the story here is during the first submissions, I had something
similar (i2c-hid or so). I was then told that it was not necessary to
use "i2c" in the name given that it was an I2C driver already. But it
looks like when I created the device tree binding, I forgot about it and
messed around a little bit, again.

My apologies, and:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>.

Would it make sense to remove the other name ("hid") which should have
less compatibility issues (all the users *should* be in the kernel
tree).

Cheers,
Benjamin

> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
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
>  	{ "hid", 0 },
> +	{ "hid-over-i2c", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
> 
> -- 
> Dmitry
