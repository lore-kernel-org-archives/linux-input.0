From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Document no-sleep requirement for playback()
 callback
Date: Mon, 26 Nov 2012 22:42:38 -0800
Message-ID: <20121127064238.GA1989@core.coreip.homeip.net>
References: <1353997935-7210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50802 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab2K0Gmm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 01:42:42 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5694571pad.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 22:42:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353997935-7210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Tue, Nov 27, 2012 at 06:32:15AM +0000, Mark Brown wrote:
> Avoids surprising users.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/linux/input.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 82ce323..0ba0de1 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -475,7 +475,8 @@ extern struct class input_class;
>   * struct ff_device - force-feedback part of an input device
>   * @upload: Called to upload an new effect into device
>   * @erase: Called to erase an effect from device
> - * @playback: Called to request device to start playing specified effect
> + * @playback: Called to request device to start playing specified effect.
> + *            Must not sleep.
>   * @set_gain: Called to set specified gain
>   * @set_autocenter: Called to auto-center device
>   * @destroy: called by input core when parent input device is being

We already have a few lines below:

> * Note that playback(), set_gain() and set_autocenter() are called with
> * dev->event_lock spinlock held and interrupts off and thus may not
> * sleep.

So I doubt they will pay more attention to your addition ;)

Thanks.

-- 
Dmitry
