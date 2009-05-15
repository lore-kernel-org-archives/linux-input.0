From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] Input: tsc2007: Remove a useless code and check a
	necessary function is provided or not
Date: Fri, 15 May 2009 09:26:58 +0200
Message-ID: <20090515072658.GB32380@roarinelk.homelinux.net>
References: <483a38b80905142247l31dc77f6sd3deb511fc171f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:49963 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbZEOH07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 03:26:59 -0400
Content-Disposition: inline
In-Reply-To: <483a38b80905142247l31dc77f6sd3deb511fc171f5e@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, May 15, 2009 at 02:47:12PM +0900, Kwangwoo Lee wrote:
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -253,11 +253,11 @@ static int tsc2007_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct tsc2007 *ts;
> -	struct tsc2007_platform_data *pdata = pdata = client->dev.platform_data;
> +	struct tsc2007_platform_data *pdata = client->dev.platform_data;

This change is already in a previous patch of yours.
(http://www.spinics.net/lists/linux-input/msg03404.html)

Manuel Lauss
