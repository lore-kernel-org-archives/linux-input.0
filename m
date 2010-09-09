From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: wacom - Add support for Bamboo Pen
Date: Wed, 8 Sep 2010 21:14:22 -0700
Message-ID: <20100909041422.GA11747@core.coreip.homeip.net>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
 <1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51270 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0IIEO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:14:28 -0400
Received: by iwn5 with SMTP id 5so687884iwn.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:14:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pingc@wacom.com

On Wed, Sep 08, 2010 at 11:02:31PM -0500, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> This adds support for Pen on Bamboo Pen and Bamboo Pen&Touch
> devices.  Touchpad is handled by previous Bamboo Touch
> logic.
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
>  drivers/input/tablet/wacom_wac.c |   75 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 2f7ed9a..9cc0cf0 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -904,10 +904,71 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
>  	return 0;
>  }
>  
> +static int wacom_bpt_pen(struct wacom_wac *wacom)
> +{
> +	struct input_dev *input = wacom->input;
> +	unsigned char *data = wacom->data;
> +	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
> +
> +	prox = (data[1] & 0x10) && (data[1] & 0x20);

	prox = (data[1] & 0x30) == 0x30;

?

-- 
Dmitry
