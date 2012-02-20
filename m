From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics - add second variant of two-button
 clickpad
Date: Mon, 20 Feb 2012 11:48:12 +0100
Message-ID: <4F4224EC.5000400@gmail.com>
References: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45737 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2BTKsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Feb 2012 05:48:19 -0500
Received: by pbcun15 with SMTP id un15so6155822pbc.19
        for <linux-input@vger.kernel.org>; Mon, 20 Feb 2012 02:48:19 -0800 (PST)
In-Reply-To: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 02/14/2012 05:21 AM, Chase Douglas wrote:
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> There are two models of Dell netbooks (Inspiron 1011 and 1012 IIRC) with
> two-button clickpads that do not match the current two-button clickpad bit
> mask. I don't have any docs to tell me which bits are which, but this bit
> seems the most probably. For reference, the caps bits for these netbooks are:
> 
> caps: 0xd04713/0xa40000/0x2a0000
> 
>  drivers/input/mouse/synaptics.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index fd26ccc..816d7bd 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -80,6 +80,7 @@
>   */
>  #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
>  #define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
> +#define SYN_CAP_CLICKPAD2BTN2(ex0c)	((ex0c) & 0x200000) /* 2-button ClickPad */
>  #define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
>  #define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & 0x002000)
>  #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)

Dmitry, would you be able to comment on this soon? We're approaching
kernel freeze in Ubuntu and I want to have this patch in there if it
makes sense.

Thanks,

-- Chase
