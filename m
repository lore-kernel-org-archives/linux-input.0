From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] Input: wacom - Fail on missing features
Date: Thu, 7 Jan 2010 11:08:38 -0800
Message-ID: <201001071108.38253.dmitry.torokhov@gmail.com>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org> <20100107183009.GA13036@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44586 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0AGTIq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 14:08:46 -0500
In-Reply-To: <20100107183009.GA13036@wavehammer.waldi.eu.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastian Blank <waldi@debian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thursday 07 January 2010 10:30:09 am Bastian Blank wrote:
> The driver needs a correct setup feature list, fail if it is not
> correctly set.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>
> ---
>  drivers/input/tablet/wacom_sys.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c
>  b/drivers/input/tablet/wacom_sys.c index 41a631b..c44b9f0 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -534,6 +534,9 @@ static int wacom_probe(struct usb_interface *intf,
>  const struct usb_device_id *i struct input_dev *input_dev;
>  	int error = -ENOMEM;
> 
> +	if (!features)
> +		return -EIO;
> +

-EINVAL is probably better.

>  	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
>  	wacom_wac = kzalloc(sizeof(struct wacom_wac), GFP_KERNEL);
>  	input_dev = input_allocate_device();
> 

-- 
Dmitry
