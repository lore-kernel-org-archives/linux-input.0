From: Bastien Nocera <hadess@hadess.net>
Subject: Re: XBox One S Bluetooth controller hid-recorder
Date: Thu, 09 Nov 2017 17:01:08 +0100
Message-ID: <1510243268.2624.37.camel@hadess.net>
References: <1510241150.2624.33.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57051 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdKIQBK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 11:01:10 -0500
In-Reply-To: <1510241150.2624.33.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Self follow-up,

On Thu, 2017-11-09 at 16:25 +0100, Bastien Nocera wrote:
> Hey,
> 
> This is the hid-recorder for that device.
> 
> I started hid-recorder and pressed:
> - up, down, left, right, on the d-pad, then left analog stick, then
> right analog stick
> - Y, A, X, B on the face buttons (that's up, down, left, right
> respectively as well)
> - left button 1, right button 1
> - left trigger (2), right trigger (2)
> - menu ("Select") and Start
> 
> I just realised that I didn't press down the 2 analog sticks, or on
> the
> "vendor" button either. Let me know whether you want a new log with
> those.
> 
> I get this error in the kernel logs:
> [ 6821.181818] hid-generic 0005:045E:02E0.000A: unknown main item tag
> 0x0
> 
> The analog sticks and d-pad seem to work properly, the problems start
> with:
> - button X reports BTN_C instead of BTN_WEST
> - the left and right trigger buttons report BTN_WEST and BTN_Z
> respectively
> - left and trigger analogue triggers report ABS_Z and ABS_RZ, not
> sure
> whether this is expected
> - "Select" reports BTN_TL, "Start" reports BTN_TR

I discussed this with Benjamin on IRC, and it seems there's nothing
here that can't be handled by user-space mappings, such as SDL2's
database.

Valve's SteamOS patch (at least the HID hunk) is really a work-around
for their big picture mode not being able to capture "KEY_MENU" it
seems:
https://github.com/ValveSoftware/steamos_kernel/commit/549c3dc10fa3749b
3999549a2672b14bf0e9786d

There's 2 more problems shown with this device:
- the hid-generic warning above is "the bt stack forgetting to remove
the terminating '0' before forwarding it to HID", which we might want
to fix to avoid bug reports
- the necessity to disable ERTM to correctly pair and connect with the
device. This is currently discussed on linux-bluetooth.

Cheers
