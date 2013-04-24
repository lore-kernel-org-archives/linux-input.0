From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Drivers: HID: fix warnings: from is u16 which never <
 0
Date: Wed, 24 Apr 2013 16:33:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304241632560.29143@pobox.suse.cz>
References: <5160FC50.6080503@asianux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab3DXOdJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Apr 2013 10:33:09 -0400
In-Reply-To: <5160FC50.6080503@asianux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: linux-input@vger.kernel.org

On Sun, 7 Apr 2013, Chen Gang wrote:

> 
>   from is u16 which never < 0.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/hid/hid-icade.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
> index 09dcc04..76b5a75 100644
> --- a/drivers/hid/hid-icade.c
> +++ b/drivers/hid/hid-icade.c
> @@ -159,7 +159,7 @@ static const struct icade_key icade_usage_table[30] = {
>  
>  static const struct icade_key *icade_find_translation(u16 from)
>  {
> -	if (from < 0 || from > ICADE_MAX_USAGE)
> +	if (from > ICADE_MAX_USAGE)
>  		return NULL;
>  	return &icade_usage_table[from];
>  }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
