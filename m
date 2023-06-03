Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B9C7EE2C
	for <linux-input@archiver.kernel.org>; Sat,  3 Jun 2023 00:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjFCAf6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCAf5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Jun 2023 20:35:57 -0400
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA7E40
        for <linux-input@vger.kernel.org>; Fri,  2 Jun 2023 17:35:56 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 46124A283;
        Fri,  2 Jun 2023 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1685752554; bh=ZAZpPwxkoZ7ZPdtOxaDFvfiY16asilkEqtlPOYHzwvU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HUnTpOKYAafwyBtJtNQufabkSMb82W/m/tqb4Q9sHqc7vOr/riGtM7K+uQPyH4Jsq
         X/DFfgelXDKtct+GKDmmI+uBaHbGUMvOL+tK/vk2C2Qudbo8teLIBeaVWoXNbGc/YV
         xOltiWu0uMN+LwgaTgHTjU2WN2rTlN1I6r6Sx7896Pa8JBP2CU1ws2UYb6rA+Y08JC
         oCuIEsyTHa9YNdgxcQiQqZfmsDlm3PEpOJZjLBifZ2mGI8IiX89UoxPl8LzdjmiwfD
         pUHudtWtkgkrmzT1b7YnE4KaB8Vv9dkmzUCYBYvlAC/oWm1IbRFsv7JGMuZ0c8PCFN
         xj6q0hkAXv+eQ==
Message-ID: <81e284e7-7d2d-6ccd-8bac-e20616ede754@endrift.com>
Date:   Fri, 2 Jun 2023 17:35:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Input: xpad - Move Xbox 360 magic packet sending
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-input@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
References: <20230502031202.1018440-1-vi@endrift.com>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <20230502031202.1018440-1-vi@endrift.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 5/1/23 20:12, Vicki Pfau wrote:
> This moves the sending of the magic packet introduced in db7220c48d8d from
> xpad_probe to xpad_start_input to ensure that xpad->dev->dev exists in the
> event that an error occurs. This should also fix issues with suspend that may
> occur with some controllers.
> 
> Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")
> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  drivers/input/joystick/xpad.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 50ecff681b89..40abea92c393 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1720,6 +1720,27 @@ static int xpad_start_input(struct usb_xpad *xpad)
>  			return error;
>  		}
>  	}
> +	if (xpad->xtype == XTYPE_XBOX360) {
> +		/*
> +		 * Some third-party controllers Xbox 360-style controllers
> +		 * require this message to finish initialization.
> +		*/
> +		u8 dummy[20];
> +
> +		error = usb_control_msg_recv(xpad->udev, 0,
> +					     /* bRequest */ 0x01,
> +					     /* bmRequestType */
> +					     USB_TYPE_VENDOR | USB_DIR_IN |
> +						USB_RECIP_INTERFACE,
> +					     /* wValue */ 0x100,
> +					     /* wIndex */ 0x00,
> +					     dummy, sizeof(dummy),
> +					     25, GFP_KERNEL);
> +		if (error)
> +			dev_warn(&xpad->dev->dev,
> +				 "unable to receive magic message: %d\n",
> +				 error);
> +	}
>  
>  	return 0;
>  }

It's been a month and this fixed version of the patch never got any replies. Did it just get overlooked? Or does the fact that the old version got reverted mean I need to change the description in some capacity?
