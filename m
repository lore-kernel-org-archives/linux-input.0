From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100
 touch object
Date: Thu, 6 Aug 2015 12:51:28 +0200
Message-ID: <55C33C30.9080807@de.bosch.com>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
 <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:16021 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbbHFKvc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 06:51:32 -0400
In-Reply-To: <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17.03.2015 15:00, Javier Martinez Canillas wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
>
> Add support for the new T100 object which replaces the previous
> T9 multitouch touchscreen object in recent maXTouch devices.
> T100 provides improved reporting with selectable auxiliary
> information, and a type field for hover/stylus/glove reporting.
>
> The hovering finger support was based on Chung-Yih's work in
> the ChromiumOS downstream kernel:
>
> https://chromium-review.googlesource.com/#/c/219280/
>
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> [javier: Factor out T9 and T100 init functions and rework hover support]
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>   drivers/input/touchscreen/atmel_mxt_ts.c | 323 +++++++++++++++++++++++++++++--
>   1 file changed, 302 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 95ee92a91bd2..749371761669 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
...
> @@ -1612,9 +1856,8 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
>   	input_dev->open = mxt_input_open;
>   	input_dev->close = mxt_input_close;
>
> -	__set_bit(EV_ABS, input_dev->evbit);
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);


Having this patch in mainline as commit 
b23157dc74272ac8ebffd1a566e3e822dbc3e65f [1] breaks our Atmel touch.

It seems that above

+	set_bit(EV_ABS, input_dev->evbit);

is missing in the version which went into mainline? Re-adding it makes 
it work for us, again.

Opinions?

Best regards

Dirk

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/touchscreen/atmel_mxt_ts.c?id=b23157dc74272ac8ebffd1a566e3e822dbc3e65f



