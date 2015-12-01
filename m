From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Input: wacom_w8001 - handle touch error case
 correctly
Date: Tue, 1 Dec 2015 14:01:56 -0800
Message-ID: <20151201220156.GE3740@dtor-ws>
References: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
 <1448854696-32625-3-git-send-email-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36271 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbbLAWCA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 17:02:00 -0500
Received: by pacdm15 with SMTP id dm15so17869331pac.3
        for <linux-input@vger.kernel.org>; Tue, 01 Dec 2015 14:01:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448854696-32625-3-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

On Mon, Nov 30, 2015 at 01:38:14PM +1000, Peter Hutterer wrote:
> If a device failed at the pen setup and gets a zero reply from the touch
> device, we need to return an error. Otherwise we have a device with
> nothing but a name and the EV_KEY and EV_ABS bits.

But if device does not fail pen setup (err_pen == 0) we should not
return error, which you will !err_pen || !err_touch will be 1.

Additionally we better return proper error codes to the upper layer
instead of a boolean value.

> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 222006e..cdebf8e 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -385,7 +385,7 @@ static int w8001_setup(struct w8001 *w8001)
>  	struct input_dev *dev = w8001->dev;
>  	struct w8001_coord coord;
>  	struct w8001_touch_query touch;
> -	int error;
> +	int error, err_pen, err_touch;
>  
>  	error = w8001_command(w8001, W8001_CMD_STOP, false);
>  	if (error)
> @@ -400,8 +400,8 @@ static int w8001_setup(struct w8001 *w8001)
>  	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
>  
>  	/* penabled? */
> -	error = w8001_command(w8001, W8001_CMD_QUERY, true);
> -	if (!error) {
> +	err_pen = w8001_command(w8001, W8001_CMD_QUERY, true);
> +	if (!err_pen) {
>  		__set_bit(BTN_TOUCH, dev->keybit);
>  		__set_bit(BTN_TOOL_PEN, dev->keybit);
>  		__set_bit(BTN_TOOL_RUBBER, dev->keybit);
> @@ -426,13 +426,15 @@ static int w8001_setup(struct w8001 *w8001)
>  	}
>  
>  	/* Touch enabled? */
> -	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
> +	err_touch = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
>  
>  	/*
>  	 * Some non-touch devices may reply to the touch query. But their
>  	 * second byte is empty, which indicates touch is not supported.
>  	 */
> -	if (!error && w8001->response[1]) {
> +	if (!err_touch && w8001->response[1]) {
> +		err_touch = 1;

Huh? Let's do:

	if (!err_touch && !w8001->response[1])
		err_touch = -ENXIO;

	if (!err_touch) {
		...
	}

> +
>  		__set_bit(BTN_TOUCH, dev->keybit);
>  		__set_bit(BTN_TOOL_FINGER, dev->keybit);
>  
> @@ -491,7 +493,7 @@ static int w8001_setup(struct w8001 *w8001)
>  
>  	strlcat(w8001->name, " Touchscreen", sizeof(w8001->name));
>  
> -	return 0;
> +	return !err_pen || !err_touch;

	return !err_pen || !err_touch ? 0 : -ENXIO;

>  }
>  
>  /*
> -- 
> 2.5.0
> 

Thanks.

-- 
Dmitry
