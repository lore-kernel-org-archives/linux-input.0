From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input : wacom - Simplify type check for newer V5
 devices
Date: Wed, 21 Nov 2012 13:13:57 -0800
Message-ID: <20121121211357.GC25470@core.coreip.homeip.net>
References: <1353523360-6431-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36295 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856Ab2KUVOF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 16:14:05 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so5364926pbc.19
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 13:14:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353523360-6431-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Nov 21, 2012 at 10:42:40AM -0800, Ping Cheng wrote:
> The updated type enum enables this implementation.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_wac.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 7554a04..f09f39e 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -467,9 +467,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
>  	/* general pen packet */
>  	if ((data[1] & 0xb8) == 0xa0) {
>  		t = (data[6] << 2) | ((data[7] >> 6) & 3);
> -		if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
> -                    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
> -		    (features->type >= WACOM_21UX2 && features->type <= WACOM_24HD)) {
> +		if ((features->type >= INTUOS4S && features->type <= WACOM_24HD)) {

This has extra parenthesis.

Anyway, applied both, thanks Ping.

-- 
Dmitry
