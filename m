From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: wacom - read 3rd gen Bamboo Touch HID data
Date: Thu, 20 Oct 2011 19:53:16 -0700
Message-ID: <201110201953.16567.dmitry.torokhov@gmail.com>
References: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com> <1318814981-30607-6-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48685 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1JUCx0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Oct 2011 22:53:26 -0400
Received: by pzk36 with SMTP id 36so8491653pzk.1
        for <linux-input@vger.kernel.org>; Thu, 20 Oct 2011 19:53:26 -0700 (PDT)
In-Reply-To: <1318814981-30607-6-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com

On Sunday, October 16, 2011 06:29:40 PM chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
>  drivers/input/tablet/wacom_sys.c |   48
> ++++++++++++++++++++++++++++++++++++- 1 files changed, 46
> insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c
> b/drivers/input/tablet/wacom_sys.c index 5e1539c..d19886a 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -28,7 +28,9 @@
>  #define HID_USAGE_Y_TILT		0x3e
>  #define HID_USAGE_FINGER		0x22
>  #define HID_USAGE_STYLUS		0x20
> -#define HID_COLLECTION			0xc0
> +#define HID_COLLECTION			0xa1
> +#define HID_COLLECTION_LOGICAL		0x02
> +#define HID_COLLECTION_END		0xc0
> 
>  enum {
>  	WCM_UNDEFINED = 0,
> @@ -165,6 +167,34 @@ static void wacom_close(struct input_dev *dev)
>  		usb_autopm_put_interface(wacom->intf);
>  }
> 
> +static int wacom_parse_logical_collection(unsigned char *report,
> +					  struct wacom_features *features)
> +{
> +	int length = 0;
> +
> +	if (features->type == BAMBOO_PT) {
> +
> +		/* Logical collection is only used by 3rd gen Bamboo Touch */
> +		features->pktlen = WACOM_PKGLEN_BBTOUCH3;

Compile dies here because WACOM_PKGLEN_BBTOUCH3 is defined in the
next patch.

Please make sure the series is bisectable.

Thanks.

-- 
Dmitry
