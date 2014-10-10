From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/3] cap11xx: Add support for various cap11xx devices
Date: Fri, 10 Oct 2014 10:29:52 -0700
Message-ID: <20141010172952.GA32974@dtor-ws>
References: <1412914983-3742-1-git-send-email-mranostay@gmail.com>
 <1412914983-3742-3-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48803 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbaJJR35 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2014 13:29:57 -0400
Content-Disposition: inline
In-Reply-To: <1412914983-3742-3-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: galak@codeaurora.org, zonque@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Matt,

On Thu, Oct 09, 2014 at 09:23:02PM -0700, Matt Ranostay wrote:
> @@ -63,7 +60,25 @@ struct cap11xx_priv {
>  	struct input_dev *idev;
>  
>  	/* config */
> -	unsigned short keycodes[CAP11XX_NUM_CHN];
> +	unsigned int num_channels;
> +	u32 keycodes[];

Any particular reason you decided to keep num_channels field givfen that
the same data is accessible through priv->idev->keycodemax?

Thanks.

-- 
Dmitry
