From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] Input: wacom - isolate input registration
Date: Mon, 06 Feb 2012 11:22:37 +0800
Message-ID: <4F2F477D.3040507@cn.fujitsu.com>
References: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com> <1328496376-28502-2-git-send-email-chris@cnpbagwell.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49646 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab2BFEAP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Feb 2012 23:00:15 -0500
In-Reply-To: <1328496376-28502-2-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com

On 02/06/2012 10:46 AM, chris@cnpbagwell.com wrote:

> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> Although this better co-locates input registration logic,
> the main goal is to make it easier to optionally create
> input devices or delay creation to later time periods.
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
>  drivers/input/tablet/wacom_sys.c |   53 +++++++++++++++++++++++--------------
>  1 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index c9588ee..43e82e9 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -822,6 +822,37 @@ static void wacom_destroy_leds(struct wacom *wacom)
>  	}
>  }
>  
> +static int wacom_register_input(struct wacom *wacom)
> +{
> +	struct input_dev *input_dev;
> +	struct usb_interface *intf = wacom->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
> +	int error;
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = wacom_wac->name;
> +	input_dev->dev.parent = &intf->dev;
> +	input_dev->open = wacom_open;
> +	input_dev->close = wacom_close;
> +	usb_to_input_id(dev, &input_dev->id);
> +	input_set_drvdata(input_dev, wacom);
> +
> +	wacom_wac->input = input_dev;
> +	wacom_setup_input_capabilities(input_dev, wacom_wac);
> +
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		input_free_device(input_dev);
> +		wacom_wac->input =  0;

				  ^^^
spare space here. and better use NULL?

Thanks
-Wanlong Gao
