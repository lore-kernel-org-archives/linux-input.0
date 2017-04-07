From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 4/4] hid-logitech-hidpp: add support for ratchet switch
Date: Fri, 7 Apr 2017 17:33:48 +0200
Message-ID: <20170407153347.GD13764@mail.corp.redhat.com>
References: <cover.1491564565.git.mchehab@s-opensource.com>
 <f088d8bd1dc2cd4c937d251453b692322a7f3e18.1491564565.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755811AbdDGPdx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Apr 2017 11:33:53 -0400
Content-Disposition: inline
In-Reply-To: <f088d8bd1dc2cd4c937d251453b692322a7f3e18.1491564565.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>

On Apr 07 2017 or thereabouts, Mauro Carvalho Chehab wrote:
> Logitech Anywhere MX2 and MX master produce events for
> the wheel ratchet/free wheel button. Add support for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index c208a5107511..6177087ffaca 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1406,6 +1406,19 @@ static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
>  			return ret;
>  	}
>  
> +	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
> +					  CMD_MOUSE_GET_WHEEL_RATCHET,
> +					  params, 16, &response);

Like in the other patch, there is no need to have '16' here when there
is no parameters.

Cheers,
Benjamin

> +	if (ret > 0) {
> +		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
> +			__func__, ret);
> +		return -EPROTO;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	hrd->ratchet = response.fap.params[0] & 0x01;
> +
>  	params[0] = invert     ? 0x4 : 0  |
>  		    high_res   ? 0x2 : 0  |
>  		    hidpp_mode ? 0x1 : 0;
> @@ -1945,10 +1958,11 @@ static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
>  			input_report_rel(hrd->input, REL_HIRES_WHEEL, delta);
>  		else
>  			input_report_rel(hrd->input, REL_WHEEL, delta);
> +	} else if (data[3] == 0x10) {
> +		hrd->ratchet = data[4] & 0x01;
> +		input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
>  	}
>  
> -	/* FIXME: also report ratchet events to userspace */
> -
>  	return 1;
>  }
>  
> @@ -1961,6 +1975,11 @@ static void high_res_populate_input(struct hidpp_device *hidpp,
>  
>  	__set_bit(REL_WHEEL, hrd->input->relbit);
>  	__set_bit(REL_HIRES_WHEEL, hrd->input->relbit);
> +	__set_bit(EV_SW, hrd->input->evbit);
> +	__set_bit(SW_RATCHET, hrd->input->swbit);
> +
> +	/* Report current state of the ratchet switch */
> +	input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
>  }
>  
>  
> -- 
> 2.9.3
> 
