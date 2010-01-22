From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] Input: xilinx_ps2 - Use resource_size
Date: Fri, 22 Jan 2010 05:57:41 -0700
Message-ID: <7164dbba-98d5-4697-8a83-e6f6ac2feab2@SG2EHSMHS012.ehs.local>
References: <1264145155-5383-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sg2ehsobe005.messaging.microsoft.com ([207.46.51.79]:36717 "EHLO
	SG2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751783Ab0AVNOF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2010 08:14:05 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <1264145155-5383-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


> -----Original Message-----
> From: Tobias Klauser [mailto:tklauser@distanz.ch]
> Sent: Friday, January 22, 2010 12:26 AM
> To: Dmitry Torokhov; linux-input@vger.kernel.org; John Linn
> Cc: Tobias Klauser
> Subject: [PATCH] Input: xilinx_ps2 - Use resource_size
> 
> Use the resource_size inline function instead of manually calculating
> the resource size.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/input/serio/xilinx_ps2.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/xilinx_ps2.c
b/drivers/input/serio/xilinx_ps2.c
> index ebb22f8..4d835e9 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -270,7 +270,7 @@ static int __devinit xps2_of_probe(struct
of_device *ofdev,
>  	drvdata->irq = r_irq.start;
> 
>  	phys_addr = r_mem.start;
> -	remap_size = r_mem.end - r_mem.start + 1;
> +	remap_size = resource_size(r_mem);
>  	if (!request_mem_region(phys_addr, remap_size, DRIVER_NAME)) {
>  		dev_err(dev, "Couldn't lock memory region at
0x%08llX\n",
>  			(unsigned long long)phys_addr);
> @@ -344,7 +344,7 @@ static int __devexit xps2_of_remove(struct
of_device *of_dev)
>  	if (of_address_to_resource(of_dev->node, 0, &r_mem))
>  		dev_err(dev, "invalid address\n");
>  	else
> -		release_mem_region(r_mem.start, r_mem.end - r_mem.start
+ 1);
> +		release_mem_region(r_mem.start, resource_size(r_mem));
> 
>  	kfree(drvdata);
> 
> --
> 1.6.3.3
> 

Thanks for the patch.

Acked-by: John Linn <john.linn@xilinx.com>

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


