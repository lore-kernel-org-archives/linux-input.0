From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Wed, 8 Jan 2014 14:44:23 -0800
Message-ID: <20140108224423.GA27279@core.coreip.homeip.net>
References: <1389217075-28551-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57798 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056AbaAHWo2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 17:44:28 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so2445409pab.34
        for <linux-input@vger.kernel.org>; Wed, 08 Jan 2014 14:44:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389217075-28551-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed, Jan 08, 2014 at 01:37:55PM -0800, Christopher Heiny wrote:
> This is a trivial change to use snprintf rather than sprintf while building
> the diagnostic output buffer.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
>  drivers/input/rmi4/rmi_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index b33074c..43b0e53 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -157,7 +157,7 @@ static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
>  	temp = data->debug_buf;
>  
>  	for (i = 0; i < len; i++) {
> -		n = sprintf(temp, " %02x", buf[i]);
> +		n = snprintf(temp, 3, " %02x", buf[i]);
>  		temp += n;
>  	}
>  

I do not think it is right, as if there is truncation you'd move too
far. In any case please replace the while loop with:

	snprintf(data->debug_buf, data->debug_buf_size, "%*ph", len, buf);

Thanks.

-- 
Dmitry
