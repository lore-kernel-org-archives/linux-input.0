From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] input: sh_keysc: 8x8 MODE_6 fix
Date: Thu, 16 Jun 2011 08:12:18 +0900
Message-ID: <20110615231211.GC28947@verge.net.au>
References: <20110615143340.21798.61858.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58015 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1FOXMX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 19:12:23 -0400
Content-Disposition: inline
In-Reply-To: <20110615143340.21798.61858.sendpatchset@t400s>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Wed, Jun 15, 2011 at 11:33:40PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The MODE_6 support in sh_keysc.c is incorrect without
> this patch. According to the data sheet for G4, AP4 and
> AG5 KEYSC MODE_6 is 8x8 keys. Bump up MAXKEYS to 64 too.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by: Simon Horman <horms@verge.net.au>

Do we also need to update the platform data for ag5evm
which is currently using SH_KEYSC_MODE_6 but with 49
entries in its keysc_platdata.keycodes ?

> ---
> 
>  drivers/input/keyboard/sh_keysc.c |    2 +-
>  include/linux/input/sh_keysc.h    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- 0001/drivers/input/keyboard/sh_keysc.c
> +++ work/drivers/input/keyboard/sh_keysc.c	2011-06-15 17:59:27.000000000 +0900
> @@ -32,7 +32,7 @@ static const struct {
>  	[SH_KEYSC_MODE_3] = { 2, 4, 7 },
>  	[SH_KEYSC_MODE_4] = { 3, 6, 6 },
>  	[SH_KEYSC_MODE_5] = { 4, 6, 7 },
> -	[SH_KEYSC_MODE_6] = { 5, 7, 7 },
> +	[SH_KEYSC_MODE_6] = { 5, 8, 8 },
>  };
>  
>  struct sh_keysc_priv {
> --- 0001/include/linux/input/sh_keysc.h
> +++ work/include/linux/input/sh_keysc.h	2011-06-15 17:48:05.000000000 +0900
> @@ -1,7 +1,7 @@
>  #ifndef __SH_KEYSC_H__
>  #define __SH_KEYSC_H__
>  
> -#define SH_KEYSC_MAXKEYS 49
> +#define SH_KEYSC_MAXKEYS 64
>  
>  struct sh_keysc_info {
>  	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3,
> 
