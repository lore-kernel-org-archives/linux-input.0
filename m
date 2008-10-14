From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add KD_X console mode to avoid keyboard passthrough
Date: Mon, 13 Oct 2008 23:12:44 -0400
Message-ID: <20081014031244.GE8594@anvil.corenet.prv>
References: <20081012174710.GA5206@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:8767 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733AbYJNDMt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2008 23:12:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so473476ywe.1
        for <linux-input@vger.kernel.org>; Mon, 13 Oct 2008 20:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081012174710.GA5206@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Matthew,

On Sun, Oct 12, 2008 at 06:47:10PM +0100, Matthew Garrett wrote:
> When using the evdev input driver, X currently claims the devices 
> exclusively in order to prevent characters leaking through to the 
> underlying VT. This has the downside that other consumers of input 
> events no longer receive the keys - rfkill and mouseemu no longer work 
> in the kernel, and hal is unable to pass through input events. Removing 
> the exclusive access results in events being passed through to the 
> underlying VT, which may result in leaking sensitive information.
> 
> This patch adds an extra KD_X mode. It's semantically identical to 
> KD_GRAPHICS, except that keyboard events are no longer sent to the 
> console device. This allows X to avoid exclusive access without breaking 
> any applications which depend upon the existing KD_GRAPHICS semantics.
> 

Is this really needed? The current X does not leak anything onto its VT
and the new one should not have either, unless they forget to switch
virtual console into raw mode. Plus, if you make everything work with
KD_GRAPHICS you don't have to have new kernel.

> 
> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> index 7b3a212..b0b8285 100644
> --- a/drivers/char/keyboard.c
> +++ b/drivers/char/keyboard.c
> @@ -1298,6 +1298,10 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
>  static void kbd_event(struct input_handle *handle, unsigned int event_type,
>  		      unsigned int event_code, int value)
>  {
> +	struct vc_data *vc = vc_cons[fg_console].d;
> +
> +	if (vc->vc_mode == KD_X)
> +		return;

This surely kills SysRq handling.

>  	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
>  		kbd_rawcode(value);
>  	if (event_type == EV_KEY)
-- 
Dmitry
