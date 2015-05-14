From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [patch] HID: i2c-hid: fix harmless test_bit() issue
Date: Thu, 14 May 2015 10:17:05 -0400
Message-ID: <20150514141705.GB23647@mail.corp.redhat.com>
References: <20150514083330.GB1665@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933797AbbENORO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2015 10:17:14 -0400
Content-Disposition: inline
In-Reply-To: <20150514083330.GB1665@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Antonio Borneo <borneo.antonio@gmail.com>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Andrew Duggan <aduggan@synaptics.com>, Gwendal Grignou <gwendal@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>

On May 14 2015 or thereabouts, Dan Carpenter wrote:
> These defines are used like this:
> 
> 	if (test_bit(I2C_HID_STARTED, &ihid->flags))
> 
> The intent was to use bits 0, 1, and 2 but because of the extra shifts
> we're using bits 1, 2, and 4.  It's harmless becuase it's done
> consistently but it's not the intent and static checkers will complain.
> 
> Fixes: 4a200c3b9a40 ('HID: i2c-hid: introduce HID over i2c specification implementation')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Same as the other one: 

Oops. Looks good to me:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin


> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 92d6cdf..cadec6a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -42,9 +42,9 @@
>  #include <linux/i2c/i2c-hid.h>
>  
>  /* flags */
> -#define I2C_HID_STARTED		(1 << 0)
> -#define I2C_HID_RESET_PENDING	(1 << 1)
> -#define I2C_HID_READ_PENDING	(1 << 2)
> +#define I2C_HID_STARTED		0
> +#define I2C_HID_RESET_PENDING	1
> +#define I2C_HID_READ_PENDING	2
>  
>  #define I2C_HID_PWR_ON		0x00
>  #define I2C_HID_PWR_SLEEP	0x01
