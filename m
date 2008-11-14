From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
	coordinate data for MicroTouch/3M touchscreens
Date: Fri, 14 Nov 2008 22:31:25 +0100
Message-ID: <20081114213125.GA6995@suse.cz>
References: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40751 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751437AbYKNVcI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Nov 2008 16:32:08 -0500
Content-Disposition: inline
In-Reply-To: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Streetman <ddstreet@ieee.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>, daniel.ritz@gmx.ch

On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:

> Note that the Y axis is inverted as reported by the touchscreen, so
> this reverses the Y min and max (0xffff for the min, 0 for the max).
> This works fine on my system using the X evdev driver.

> +	// Default min/max xy are the raw values, override if using hw-calib
> +	if (hwcalib_xy) {
> +		input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
> +		input_set_abs_params(usbtouch->input, ABS_Y, 0xffff, 0, 0, 0);

While it does work with the X evdev, please don't do it, and instead do
the inversion before reporting ABS_Y. Linux input devices should follow
the (USB) HID specification of axis direction and stick to it. The
behaviour with reversed min/max is undefined.

-- 
Vojtech Pavlik
Director SuSE Labs
