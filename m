From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS mode
Date: Tue, 21 Jun 2016 09:31:25 +0800
Message-ID: <008b01d1cb5c$a0574a40$e105dec0$@emc.com.tw>
References: <1465306449-28256-1-git-send-email-chiu@endlessm.com> <20160620174251.GC22426@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:34715 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcFUBcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 21:32:17 -0400
In-Reply-To: <20160620174251.GC22426@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Chris Chiu' <chiu@endlessm.com>
Cc: 'Charlie Mooney' <charliemooney@chromium.org>, 'Michele Curti' <michele.curti@gmail.com>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, 'Benson Leung' <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, =?big5?B?tsClQMRQILhnsno=?= <phoenix@emc.com.tw>

Hi Dmitry,

The modification from Chris is a special case.
Because the Touchpad FW is a little different from normal one, It cause
problem in Asus's OBE test. 

That's why Elan's driver use work-around to solve the problem. It's not
tested by other touchpad.

Let me discuss with internal FW team to confirm the harmless of the patch.

B.R  KT
-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Tuesday, June 21, 2016 1:43 AM
To: Chris Chiu; kt.liao@emc.com.tw
Cc: Charlie Mooney; Michele Curti; Krzysztof Kozlowski; Benson Leung;
linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
linux@endlessm.com
Subject: Re: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS
mode

On Tue, Jun 07, 2016 at 09:34:09PM +0800, Chris Chiu wrote:
> When performing a warm reboot from a system which does not correctly 
> support ELAN I2C touchpads, the touchpad will sometimes enter standard 
> mouse mode, cursor then never respond to touchpad event, and making 
> the driver discard the HID reports and flood dmesg with following 
> error messages.
> "elan_i2c i2c-ELAN1000:00: invalid report id data (1)"
> 
> This change is from ELAN's correction. It needs 200ms delay before
> set_mode() so that the mode setting will correctly take effect.

KT, is this feasible?

> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c 
> b/drivers/input/mouse/elan_i2c_core.c
> index 2f58985..95080f9 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -210,18 +210,20 @@ static int __elan_initialize(struct elan_tp_data
*data)
>  		return error;
>  	}
>  
> -	data->mode |= ETP_ENABLE_ABS;
> -	error = data->ops->set_mode(client, data->mode);
> +	error = data->ops->sleep_control(client, false);
>  	if (error) {
>  		dev_err(&client->dev,
> -			"failed to switch to absolute mode: %d\n", error);
> +			"failed to wake device up: %d\n", error);
>  		return error;
>  	}
>  
> -	error = data->ops->sleep_control(client, false);
> +	msleep(200);
> +
> +	data->mode |= ETP_ENABLE_ABS;
> +	error = data->ops->set_mode(client, data->mode);
>  	if (error) {
>  		dev_err(&client->dev,
> -			"failed to wake device up: %d\n", error);
> +			"failed to switch to absolute mode: %d\n", error);
>  		return error;
>  	}
>  
> --
> 2.1.4
> 

Thanks.

-- 
Dmitry

