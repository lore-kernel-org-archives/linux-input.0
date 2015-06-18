From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1 linux-next] HID: use swap() in cp_report_fixup()
Date: Thu, 18 Jun 2015 11:01:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506181101290.12753@pobox.suse.cz>
References: <1433953925-23857-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51321 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbbFRJBq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jun 2015 05:01:46 -0400
In-Reply-To: <1433953925-23857-1-git-send-email-fabf@skynet.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, linux-input@vger.kernel.org

On Wed, 10 Jun 2015, Fabian Frederick wrote:

> Use kernel.h macro definition.
> 
> Thanks to Julia Lawall for Coccinelle scripting support.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied to for-4.2/upstream. Thanks.

> ---
>  drivers/hid/hid-cypress.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
> index c4ef3bc..1b764d1 100644
> --- a/drivers/hid/hid-cypress.c
> +++ b/drivers/hid/hid-cypress.c
> @@ -41,13 +41,9 @@ static __u8 *cp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  
>  	for (i = 0; i < *rsize - 4; i++)
>  		if (rdesc[i] == 0x29 && rdesc[i + 2] == 0x19) {
> -			__u8 tmp;
> -
>  			rdesc[i] = 0x19;
>  			rdesc[i + 2] = 0x29;
> -			tmp = rdesc[i + 3];
> -			rdesc[i + 3] = rdesc[i + 1];
> -			rdesc[i + 1] = tmp;
> +			swap(rdesc[i + 3], rdesc[i + 1]);
>  		}
>  	return rdesc;
>  }

-- 
Jiri Kosina
SUSE Labs
