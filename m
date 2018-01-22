From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH 2/2] Input: sur40: Improve a size determination in
 sur40_probe()
Date: Mon, 22 Jan 2018 08:02:52 +0100
Message-ID: <8b3fb313-b69d-f381-dde8-212a85b5a90e@posteo.de>
References: <a7e25da3-587a-f0e8-d574-8066b340d9a6@users.sourceforge.net>
 <11e0b313-f8c2-93ec-0324-24b30053a586@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:50152 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeAVHCz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 02:02:55 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 8E92520E08
        for <linux-input@vger.kernel.org>; Mon, 22 Jan 2018 08:02:54 +0100 (CET)
In-Reply-To: <11e0b313-f8c2-93ec-0324-24b30053a586@users.sourceforge.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Echtler <floe@butterbrot.org>, Johan Hovold <johan@kernel.org>, Martin Kaltenbrunner <modin@yuri.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 2018-01-20 22:30, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 20 Jan 2018 22:16:14 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Martin Kepplinger <martink@posteo.de>

> ---
>  drivers/input/touchscreen/sur40.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index c7a0a92b2044..946e1a0328b4 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -550,7 +550,7 @@ static int sur40_probe(struct usb_interface *interface,
>  		return -ENODEV;
>  
>  	/* Allocate memory for our device state and initialize it. */
> -	sur40 = kzalloc(sizeof(struct sur40_state), GFP_KERNEL);
> +	sur40 = kzalloc(sizeof(*sur40), GFP_KERNEL);
>  	if (!sur40)
>  		return -ENOMEM;
>  
> 

