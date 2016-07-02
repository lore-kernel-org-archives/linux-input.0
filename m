From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] Input-at32psif: Remove OOM messages in
 psif_probe()
Date: Sat, 2 Jul 2016 21:29:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1607022129020.2042@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net> <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net> <1c2a98cb-e853-7b4c-3c5b-1e3ee70c67fb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46407
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751328AbcGBT3U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Jul 2016 15:29:20 -0400
In-Reply-To: <1c2a98cb-e853-7b4c-3c5b-1e3ee70c67fb@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org



On Sat, 2 Jul 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 2 Jul 2016 20:34:18 +0200
> 
> Delete two debug messages because Linux will usually provide
> an appropriate information for a memory allocation failure.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/serio/at32psif.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
> index fcb769a..b30503d 100644
> --- a/drivers/input/serio/at32psif.c
> +++ b/drivers/input/serio/at32psif.c
> @@ -210,15 +210,13 @@ static int __init psif_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	psif = kzalloc(sizeof(struct psif), GFP_KERNEL);
> -	if (!psif) {
> -		dev_dbg(&pdev->dev, "out of memory\n");
> +	if (!psif)
>  		return -ENOMEM;
> -	}
> +

Why add a blank line here?

>  	psif->pdev = pdev;
>  
>  	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!io) {
> -		dev_dbg(&pdev->dev, "out of memory\n");
>  		ret = -ENOMEM;
>  		goto out_free_psif;
>  	}
> -- 
> 2.9.0
> 
> 
