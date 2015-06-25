From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Re: Windows Precision Touchpad support
Date: Thu, 25 Jun 2015 16:51:01 -0500
Message-ID: <558C77C5.40202@dell.com>
References: <CABfYTXR4T2udK1dX2j9FhOUFkQKQ35P4Ra4SqixgqYqkNoMXPQ@mail.gmail.com>	<CAN+gG=FDEGasZQixmATQ-jSe2we6uEez_c6wocii+GTxwi-orw@mail.gmail.com> <CABfYTXTNVTDT2SxqMakJd=RMMG9=FM5RziBBorj3-kR0wPfM2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:27612 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbFYWAm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 18:00:42 -0400
In-Reply-To: <CABfYTXTNVTDT2SxqMakJd=RMMG9=FM5RziBBorj3-kR0wPfM2Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Leuchtenburg <michael@slashhome.org>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Michael,

On 03/29/2015 10:23 AM, Michael Leuchtenburg wrote:
>
> It's true, I do see ABS_X/Y and ABS_MT_POSITION_X/Y. You're right - I
> was confused by the continued presence of the mouse collection. Which
> I shouldn't have been, since there's one in MS's example, though at
> the end rather than the beginning as it is for my device. Sorry, I'm
> new to reading HID descriptors. I'm not sure how the driver is telling
> it the right mode, but it seems to be. I don't ever see the driver
> issuing an input mode feature report to the touchpad when I load
> i2c_hid with debug=1, though. It could be that the firmware and
> platform designers have special cased Linux in some way. Or I could be
> misreading the logs. Regardless, it gets figured out somehow. I do
> wonder if it might have a "PTP" and "actually talking to Windows PTP"
> mode. The amount of other hardware on this system that has some
> detection of Linux vs. Windows is remarkable, so Synaptics having some
> special case for Linux wouldn't surprise me at all.
I checked with some of the team on this recently.  There is a pin that 
is brought high or low based on whether the device should try to come up 
in PTP mode.  If it fails to come up in PTP mode it will fall back to a 
non-PTP mode but then you are using it over a completely different 
interface (PS2).

It's not a matter of some special Linux/Windows detection.


I was curious though, did you make more luck on palm rejection with the 
confidence bit?

