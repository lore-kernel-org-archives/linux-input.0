From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 2/5] Input: tca8418_keypad - use dev_get_platdata() to
 retrieve platform data
Date: Thu, 29 Nov 2012 14:48:40 +0100
Message-ID: <20121129144840.41d5efa8@avionic-0020.adnet.avionic-design.de>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
	<1352911688-5001-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49707 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab2K2Nsm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 08:48:42 -0500
In-Reply-To: <1352911688-5001-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Nov 2012 08:48:05 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> We need to use proper accessor functions instead of directly poking into
> various structures.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alban Bedel <alban.bedel@avionic-design.de>

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 4618ce0..7f2869f 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -283,7 +283,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  {
>  	struct device *dev = &client->dev;
>  	const struct tca8418_keypad_platform_data *pdata =
> -						client->dev.platform_data;
> +						dev_get_platdata(dev);
>  	struct tca8418_keypad *keypad_data;
>  	struct input_dev *input;
>  	const struct matrix_keymap_data *keymap_data = NULL;

