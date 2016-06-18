From: =?iso-8859-1?Q?Cl=E9ment?= Vuchener <clement.vuchener@gmail.com>
Subject: Re: [PATCH] Input: input-event-codes - add keycodes for gaming
 peripherals
Date: Sat, 18 Jun 2016 10:33:00 +0200
Message-ID: <20160618083300.GA5265@untxi.home>
References: <tolga@cevel.net>
 <1450992327-16281-1-git-send-email-tolga@cevel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34549 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcFRIdJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 04:33:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so2682720wmz.1
        for <linux-input@vger.kernel.org>; Sat, 18 Jun 2016 01:33:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1450992327-16281-1-git-send-email-tolga@cevel.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tolga Cakir <tolga@cevel.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Any comment on this? I would be interested in this kind of key codes for
Corsair gaming keyboards.

On Thu, Dec 24, 2015 at 10:25:27PM +0100, Tolga Cakir wrote:
> Gaming peripherals without onboard memory or with switchable software macro,
> like Logitech G510 / G700 / G710 / G710+, Microsoft Sidewinder X4 / X6 or
> Corsair K90, have many keys in common. This patch adds the most common physical
> keys among gaming peripherals, so they can be used by existing and future kernel
> modules.
> 
> Included are keycodes for profile management, macro recording and macro keys.
> While some gaming peripherals have a seperate key for each profile (KEY_M[1-3]),
> others have a single key, which loops through profiles (KEY_BANK_SWITCH).
> 
> Almost all gaming peripherals only support up to 3 profiles, so KEY_M[1-3]
> should be sufficient. For macro keys, KEY_[G1-30] should cover all use cases.
> Microsoft Sidewinder X6 has 30 unique macro keys and is followed by the Logitech
> G13 with 25 macro keys.
> 
> Signed-off-by: Tolga Cakir <tolga@cevel.net>
> ---
>  include/uapi/linux/input-event-codes.h | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 87cf351..81e1f17 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -611,6 +611,43 @@
>  #define KEY_KBDINPUTASSIST_ACCEPT		0x264
>  #define KEY_KBDINPUTASSIST_CANCEL		0x265
>  
> +#define KEY_BANK_SWITCH		0x270	/* used by gaming peripherals */
> +#define KEY_M1			0x271	/* Profile Management */
> +#define KEY_M2			0x272
> +#define KEY_M3			0x273
> +#define KEY_MR			0x274	/* Macro Record */

On Corsair keyboards, there is one physical MR key, but it sends
differents events when it starts or stops the recording. So is a single
KEY_MR key code better or should we have KEY_MR_TOGGLE and KEY_MR_START and KEY_MR_STOP
key codes?

> +
> +#define KEY_G1			0x275	/* Macro Keys */
> +#define KEY_G2			0x276
> +#define KEY_G3			0x277
> +#define KEY_G4			0x278
> +#define KEY_G5			0x279
> +#define KEY_G6			0x27a
> +#define KEY_G7			0x27b
> +#define KEY_G8			0x27c
> +#define KEY_G9			0x27d
> +#define KEY_G10			0x27e
> +#define KEY_G11			0x27f
> +#define KEY_G12			0x280
> +#define KEY_G13			0x281
> +#define KEY_G14			0x282
> +#define KEY_G15			0x283
> +#define KEY_G16			0x284
> +#define KEY_G17			0x285
> +#define KEY_G18			0x286
> +#define KEY_G19			0x287
> +#define KEY_G20			0x288
> +#define KEY_G21			0x289
> +#define KEY_G22			0x28a
> +#define KEY_G23			0x28b
> +#define KEY_G24			0x28c
> +#define KEY_G25			0x28d
> +#define KEY_G26			0x28e
> +#define KEY_G27			0x28f
> +#define KEY_G28			0x290
> +#define KEY_G29			0x291
> +#define KEY_G30			0x292
> +
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
>  #define BTN_TRIGGER_HAPPY2		0x2c1
> -- 
> 2.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
