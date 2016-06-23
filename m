From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Improve Alps HID Touchpad code
Date: Wed, 22 Jun 2016 17:11:01 -0700
Message-ID: <20160623001101.GE16965@dtor-ws>
References: <1466568668-22272-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34014 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFWALE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 20:11:04 -0400
Received: by mail-pf0-f181.google.com with SMTP id h14so22413836pfe.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jun 2016 17:11:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466568668-22272-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: jikos@kernel.org, benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Wed, Jun 22, 2016 at 01:11:08PM +0900, Masaki Ota wrote:
>  
> -		input_event(hdata->input, EV_KEY, BTN_LEFT, left);
> -		input_event(hdata->input, EV_KEY, BTN_RIGHT, right);
> -		input_event(hdata->input, EV_KEY, BTN_MIDDLE, middle);
> +		input_report_key(hdata->input, BTN_LEFT,
> +			data[1] & 0x1);
> +		input_report_key(hdata->input, BTN_RIGHT,
> +			(data[1] & 0x2) >> 1);
> +		input_report_key(hdata->input, BTN_MIDDLE,
> +			(data[1] & 0x4) >> 2);

There is no really need to do shifts as input_report_key() converts
value to 0/1 for you.

> +
> +		input_sync(hdata->input);
>  
>  		return 1;
>  
>  	case U1_SP_ABSOLUTE_REPORT_ID:
> -		sp_x = (data[2] | (data[3] << 8));
> -		sp_y = (data[4] | (data[5] << 8));
> -		sp_z = (data[6] | data[7]) & 0x7FFF;
> -		left = data[1] & 0x1;
> -		right = (data[1] & 0x2) >> 1;
> -		middle = (data[1] & 0x4) >> 2;
> +		sp_x = get_unaligned_le16(data+2);
> +		sp_y = get_unaligned_le16(data+4);
>  
>  		sp_x = sp_x / 8;
>  		sp_y = sp_y / 8;
>  
> -		input_event(priv->input2, EV_REL, REL_X, sp_x);
> -		input_event(priv->input2, EV_REL, REL_Y, sp_y);
> +		input_report_rel(hdata->input2, REL_X, sp_x);
> +		input_report_rel(hdata->input2, REL_Y, sp_y);
>  
> -		input_event(priv->input2, EV_KEY, BTN_LEFT, left);
> -		input_event(priv->input2, EV_KEY, BTN_RIGHT, right);
> -		input_event(priv->input2, EV_KEY, BTN_MIDDLE, middle);
> +		input_report_key(hdata->input2, BTN_LEFT,
> +			data[1] & 0x1);
> +		input_report_key(hdata->input2, BTN_RIGHT,
> +			(data[1] & 0x2) >> 1);
> +		input_report_key(hdata->input2, BTN_MIDDLE,
> +			(data[1] & 0x4) >> 2);

Same here. Maybe Jiri will fix it up by hand while appplying?

Otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
