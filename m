From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Fix check for disabling unsupported key
Date: Mon, 4 Jan 2016 17:19:42 -0800
Message-ID: <20160105011942.GD11801@dtor-ws>
References: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35231 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbcAEBTq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 20:19:46 -0500
Content-Disposition: inline
In-Reply-To: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: pali.rohar@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jan 03, 2016 at 11:21:16PM +0200, Ivaylo Dimitrov wrote:
> Commit 4ea14a53d8f881034fa9e186653821c4e3d9a8fb ("Input: gpio-keys -
> report error when disabling unsupported key") tried to prevent an
> unsupported key to disabled. Unfortunately it effectively broke the driver
> in a way so no key is possible to be disabled. Fix that by providing the
> correct verify logic.

Hmm, indeed...

> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index bef317f..a371805 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -226,22 +226,32 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>  		goto out;
>  
>  	/* First validate */
> -	for (i = 0; i < ddata->pdata->nbuttons; i++) {
> -		struct gpio_button_data *bdata = &ddata->data[i];
> +	for (i = 0; i < n_events; i++) {

for_each_set_bit()?

OTOH maybe we should do

	bitmap = get_bitmap_events_by_type(type); // new, return keybit or swbit
	if (!bitmap_subset(bits, bitmap, n_events)) {
		error = -EINVAL;
		goto out;
	}

... and leave the rest of the loop as is?

Thanks.

-- 
Dmitry
