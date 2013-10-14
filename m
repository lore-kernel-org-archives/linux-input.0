From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2 2/2] Input: wacom - add support for three new Intuos
 devices
Date: Mon, 14 Oct 2013 10:27:22 +1000
Message-ID: <20131014002722.GC2256@yabbi.redhat.com>
References: <1381439866-1161-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:50006 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3JNAZw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Oct 2013 20:25:52 -0400
Content-Disposition: inline
In-Reply-To: <1381439866-1161-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

On Thu, Oct 10, 2013 at 02:17:46PM -0700, Ping Cheng wrote:
> This series of models added a hardware switch to turn touch
> data on/off. To report the state of the switch, SW_TOUCH
> is added in include/uapi/linux/input.h.
> 
> The driver is also updated to process wireless devices that do
> not support touch interface.
> 
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v2: Change SW_TOUCH_ENABLED to SW_TOUCH and clear BTN_TOUCH bit 
> for button only interfaces as suggested by Peter Hutterer.
> ---
>  drivers/input/tablet/wacom_sys.c | 16 +++++++-
>  drivers/input/tablet/wacom_wac.c | 87 ++++++++++++++++++++++++++++++++--------
>  drivers/input/tablet/wacom_wac.h |  7 ++++
>  include/uapi/linux/input.h       |  1 +
>  4 files changed, 93 insertions(+), 18 deletions(-)
> 

[...]

> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index fd23a37..ba9e335 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -54,6 +54,8 @@
>  #define WACOM_REPORT_TPCST		16
>  #define WACOM_REPORT_TPC1FGE		18
>  #define WACOM_REPORT_24HDT		1
> +#define WACOM_REPORT_WL_MODE		128
> +#define WACOM_REPORT_USB_MODE		192
>  
>  /* device quirks */
>  #define WACOM_QUIRK_MULTI_INPUT		0x0001
> @@ -81,6 +83,7 @@ enum {
>  	INTUOSPS,
>  	INTUOSPM,
>  	INTUOSPL,
> +	INTUOS_HT,

nitpick: why the underscore? all other intuos enums are one word.

Cheers,
   Peter

>  	WACOM_21UX2,
>  	WACOM_22HD,
>  	DTK,
