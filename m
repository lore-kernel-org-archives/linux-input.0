From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/3 v2] Input: wacom - Support EMR and MFT sensors of
 Cintiq Companion Hybrid
Date: Thu, 29 Aug 2013 11:10:54 +1000
Message-ID: <20130829011054.GB1354@yabbi.redhat.com>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
 <1377537210-2536-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:37725 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3H2Bhp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 21:37:45 -0400
Content-Disposition: inline
In-Reply-To: <1377537210-2536-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, pinglinux@gmail.com

On Mon, Aug 26, 2013 at 10:13:30AM -0700, Jason Gerecke wrote:
> Adds support for the sensors integrated in to the Cintiq Companion
> Hybrid. These sensors use by-and-large the same protocol as the
> Cintiq 24HD touch.
> 
> NOTE: The ExpressKeys on the Cintiq Companion Hybrid are wired to
> both the EMR controller and CPU GPIO pins. It may be necessary to
> disable their functionality in this driver if building a custom
> Android kernel for this device (lest two events be sent to userspace
> for every button press).
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> Changes in v2:
>  * Remove "#if 1" block surrounding conditional ExpressKey reporting
>  * Change to C-style comments

[...]

> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index dfc9e08..f47a5c1 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -80,6 +80,7 @@ enum {
>  	WACOM_22HD,
>  	DTK,
>  	WACOM_24HD,
> +	ASTERIX,
>  	CINTIQ,
>  	WACOM_BEE,
>  	WACOM_13HD,
> -- 
> 1.8.3.4

I assume ASTERIX is some internal codename - can we use the commonly used
name instead?

Cheers,
   Peter
