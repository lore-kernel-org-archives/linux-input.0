From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Tue, 16 Feb 2010 21:22:47 -0800
Message-ID: <20100217052247.GD7160@core.coreip.homeip.net>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:34753 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0BQFWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 00:22:54 -0500
Content-Disposition: inline
In-Reply-To: <1266356185-10324-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-input@vger.kernel.org, marcel@holtmann.org

HI Matthew,

On Tue, Feb 16, 2010 at 04:36:24PM -0500, Matthew Garrett wrote:
> Most laptops have keys that are intended to toggle all device state, not
> just wifi. These are currently generally mapped to KEY_WLAN. As a result,
> rfkill will only kill or enable wifi in response to the key press. This
> confuses users and can make it difficult for them to enable bluetooth
> and wwan devices.
> 
> This patch adds a new keycode, KEY_RFKILL. It indicates that the system
> should toggle the state of all rfkillable devices.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  include/linux/input.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 735ceaf..3294a89 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -594,7 +594,7 @@ struct input_absinfo {
>  #define KEY_NUMERIC_9		0x209
>  #define KEY_NUMERIC_STAR	0x20a
>  #define KEY_NUMERIC_POUND	0x20b
> -
> +#define KEY_RFKILL		0x20c /* Key that controls all radios */
>  #define KEY_CAMERA_FOCUS	0x210
>  

I'd like some breathing room aroung KEY_NUMERIC? Any issues with making
it 247 or 0x211?

-- 
Dmitry
