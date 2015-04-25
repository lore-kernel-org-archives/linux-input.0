From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] input: goodix: Check the 'data ready' bit before
 reading data
Date: Sat, 25 Apr 2015 14:54:17 +0200
Message-ID: <1429966457.2525.54.camel@hadess.net>
References: <1429958890-10366-1-git-send-email-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44689 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbDYMyV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Apr 2015 08:54:21 -0400
In-Reply-To: <1429958890-10366-1-git-send-email-paul@crapouillou.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2015-04-25 at 12:48 +0200, Paul Cercueil wrote:
> The MSB of the first byte read via I2C seems to indicate whether the
> data is valid (or ready) when an interrupt is raised. Previously, 
> this
> bit was ignored, which resulted in a lot of incorrect detections of
> "finger removed" events.

This seems correct, but the wording doesn't match the language used in 
the Goodix docs that were posted here some time ago[1].

I would have written:
The MSB of the first byte read via I2C at the coordinates address 
indicate whether the data is valid or ready (called "buffer status" in 
the datasheets) when an interrupt is raised. Previously, this bit was 
ignored, which resulted in a lot of incorrect detections of "finger 
removed" events.

And for the commit subject:
input: goodix: Check the 'buffer status' bit before reading data

This seems correct otherwise.

Signed-off-by: Bastien Nocera <hadess@hadess.net>

with the fixed commit message/subject

[1]: Linked from the device tree support patch:
https://patchwork.ozlabs.org/patch/446838/
Page 16, table c, 0x814E is what we read for coordinates

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/input/touchscreen/goodix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index ca19668..9fa6c5f 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -98,6 +98,9 @@ static int goodix_ts_read_input_report(struct 
> goodix_ts_data *ts, u8 *data)
>               return error;
>       }
>  
> +     if (!(data[0] & 0x80))
> +             return -EAGAIN;
> +
>       touch_num = data[0] & 0x0f;
>       if (touch_num > GOODIX_MAX_CONTACTS)
>               return -EPROTO;
