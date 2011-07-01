From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] input: wacom - Wacom Bamboo Pen D4 has 1024 pressure
 level
Date: Fri, 1 Jul 2011 07:18:21 +0200
Message-ID: <20110701051821.GA5071@polaris.bitmath.org>
References: <1308960898-20435-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:56017 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1GAFQz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 01:16:55 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 089EEEAE32
	for <linux-input@vger.kernel.org>; Fri,  1 Jul 2011 07:16:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308960898-20435-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Fri, Jun 24, 2011 at 05:14:58PM -0700, Ping Cheng wrote:
> Instead of 512.
> 
> Reported-by: David Foley <favux.is@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---

Perhaps one could elaborate the commit message a bit - in particular
since the text mentions 512, whereas the patch seems to change from
256?

>  drivers/input/tablet/wacom_wac.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 2ea0d2e..1cbb9a8 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1462,7 +1462,7 @@ static const struct wacom_features wacom_features_0xD3 =
>  	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
>  	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0xD4 =
> -	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255,
> +	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
>  	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0xD6 =
>  	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
> -- 

Thanks,
Henrik
