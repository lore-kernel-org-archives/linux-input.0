From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom - retrieve maximum number of touch
 points
Date: Fri, 20 Apr 2012 22:56:03 -0700
Message-ID: <20120421055603.GA27551@core.coreip.homeip.net>
References: <1334530224-8395-1-git-send-email-chris@cnpbagwell.com>
 <1334530224-8395-2-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33961 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2DUF4J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Apr 2012 01:56:09 -0400
Received: by dake40 with SMTP id e40so13837130dak.11
        for <linux-input@vger.kernel.org>; Fri, 20 Apr 2012 22:56:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334530224-8395-2-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, Ping Cheng <pingc@wacom.com>

Hi Chris, Ping,

On Sun, Apr 15, 2012 at 05:50:23PM -0500, chris@cnpbagwell.com wrote:
> From: Ping Cheng <pinglinux@gmail.com>
> 
> From the HID usage table when it is supported.
> 
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_sys.c |   22 +++++++++++++-
>  drivers/input/tablet/wacom_wac.c |   59 +++++++++++++++++++++++---------------
>  drivers/input/tablet/wacom_wac.h |    1 +
>  3 files changed, 58 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 1c874ad..469f6ce 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -28,6 +28,7 @@
>  #define HID_USAGE_Y_TILT		0x3e
>  #define HID_USAGE_FINGER		0x22
>  #define HID_USAGE_STYLUS		0x20
> +#define HID_USAGE_CONTACTMAX		0x55
>  #define HID_COLLECTION			0xa1
>  #define HID_COLLECTION_LOGICAL		0x02
>  #define HID_COLLECTION_END		0xc0
> @@ -201,6 +202,20 @@ static int wacom_parse_logical_collection(unsigned char *report,
>  	return length;
>  }
>  
> +static void wacom_retrieve_report_data(struct usb_interface *intf,
> +				       struct wacom_features *features)
> +{
> +	int result = 0;
> +	unsigned char rep_data[2];

You can't use on-stack buffers with USB. I see we allocating memory
elsewhere but I wonder if we should simply piggyback on wacom_wac->data
in all these interrogation methods.

-- 
Dmitry
