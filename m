From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: atmel_mxt_ts - Add keycodes array example
Date: Mon, 18 Aug 2014 15:20:04 +0200
Message-ID: <53F1FD84.5020901@collabora.co.uk>
References: <1407372486-25881-1-git-send-email-javier.martinez@collabora.co.uk> <1407372486-25881-2-git-send-email-javier.martinez@collabora.co.uk> <53E37329.4020002@itdev.co.uk> <53E4E41D.4070703@collabora.co.uk> <53EDF6B4.7080804@collabora.co.uk> <53EE307E.8060507@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41717 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaHRNUL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2014 09:20:11 -0400
In-Reply-To: <53EE307E.8060507@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Nick,

On 08/15/2014 06:08 PM, Nick Dyer wrote:
>> 
>> Any comments on this? I would really appreciate if you can expand on how
>> this DT property is supposed to be used so I can re-spin the atmel support
>> patch for Peach boards.
> 
> The below patch improves the documentation for the gpio-property. Stephen
> Warren has a good example here:
> https://github.com/swarren/linux-tegra/commit/09789801
> 
> trackpad@4b {
>   compatible = "atmel,maxtouch";
>   reg = <0x4b>;
>   interrupt-parent = <&gpio>;
>   interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
>   linux,gpio-keymap = <0 0 0 BTN_LEFT>;
> };
> 
> This maps BTN_LEFT to the 4th bit of the T19 message. I haven't looked up
> what GPIO number that corresponds to on the mXT224SL that he has, it varies
> with the particular maXTouch device you have.
> 
> Hope this helps.
>

Thanks a lot for the patch and the pointer to Stephen's DTS. I'll do some
experimentation then to figure out the right values since I don't have
proper documentation. Fortunately the Chrome OS 3.8 downstream driver
works on -next so I can use evdev to compare if both drivers behave the same.

> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>

Best regards,
Javier
