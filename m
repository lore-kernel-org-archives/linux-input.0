From: Silvan Jegen <s.jegen@gmail.com>
Subject: Re: [PATCH] HID: roccat: prevent an out of bounds read in
 kovaplus_profile_activated()
Date: Mon, 15 Jan 2018 21:21:11 +0100
Message-ID: <20180115202111.GA12555@myarchbang.localdomain>
References: <20180110093903.yyoknoi7oc2cd5iy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110093903.yyoknoi7oc2cd5iy@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi

On Wed, Jan 10, 2018 at 12:39:03PM +0300, Dan Carpenter wrote:
> We get the "new_profile_index" value from the mouse device when we're
> handling raw events.  Smatch taints it as untrusted data and complains
> that we need a bounds check.  This seems like a reasonable warning
> otherwise there is a small read beyond the end of the array.
> 
> Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me.

Acked-by: Silvan Jegen <s.jegen@gmail.com>


> diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
> index 43617fb28b87..317c9c2c0a7c 100644
> --- a/drivers/hid/hid-roccat-kovaplus.c
> +++ b/drivers/hid/hid-roccat-kovaplus.c
> @@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
>  static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
>  		uint new_profile_index)
>  {
> +	if (new_profile_index >= ARRAY_SIZE(kovaplus->profile_settings))
> +		return;
>  	kovaplus->actual_profile = new_profile_index;
>  	kovaplus->actual_cpi = kovaplus->profile_settings[new_profile_index].cpi_startup_level;
>  	kovaplus->actual_x_sensitivity = kovaplus->profile_settings[new_profile_index].sensitivity_x;
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
