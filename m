From: "Dan Streetman" <ddstreet@ieee.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated coordinate data for MicroTouch/3M touchscreens
Date: Fri, 14 Nov 2008 16:46:08 -0500
Message-ID: <3fad22b40811141346t5b4f90f8t3bfeaf34023222bc@mail.gmail.com>
References: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com>
	 <20081114213125.GA6995@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:54573 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYKNVqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Nov 2008 16:46:09 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1608745wfd.4
        for <linux-input@vger.kernel.org>; Fri, 14 Nov 2008 13:46:08 -0800 (PST)
In-Reply-To: <20081114213125.GA6995@suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>, daniel.ritz@gmx.ch

Ok - I'll update the patch to invert Y before reporting.

On the issue of whether to use a module param to send raw coordinates
or hw-calibrated coordinates, or to just change the code to report the
hw-calibrated coordinates instead of the raw coordinates, what do you
think?

On Fri, Nov 14, 2008 at 4:31 PM, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
>
>> Note that the Y axis is inverted as reported by the touchscreen, so
>> this reverses the Y min and max (0xffff for the min, 0 for the max).
>> This works fine on my system using the X evdev driver.
>
>> +     // Default min/max xy are the raw values, override if using hw-calib
>> +     if (hwcalib_xy) {
>> +             input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
>> +             input_set_abs_params(usbtouch->input, ABS_Y, 0xffff, 0, 0, 0);
>
> While it does work with the X evdev, please don't do it, and instead do
> the inversion before reporting ABS_Y. Linux input devices should follow
> the (USB) HID specification of axis direction and stick to it. The
> behaviour with reversed min/max is undefined.
>
> --
> Vojtech Pavlik
> Director SuSE Labs
>
