From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Spurious touchpad events with closed LID
Date: Mon, 26 Jun 2017 10:03:12 -0700
Message-ID: <20170626170312.GB4965@dtor-ws>
References: <201706261854.53970@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34400 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdFZRDP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 13:03:15 -0400
Content-Disposition: inline
In-Reply-To: <201706261854.53970@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 26, 2017 at 06:54:53PM +0200, Pali Rohár wrote:
> Hi!
> 
> When I'm using dock with external input devices (keyboard + mouse) and 
> LID is closed, I'm getting spurious touchpad events and random mouse 
> clicks and movements.
> 
> It is because top part of LID is above touchpad and probably generates 
> touch pushes.
> 
> Year (or two?) when I had conversation with ALPS people I was told that 
> Windows driver is automatically turning touchpad off when ACPI LID close 
> event is received (and similarly turn touchpad on).
> 
> Maybe Linux should do similar thing? Random movement or touchpad clicks 
> is really annoying. But I'm not sure if kernel or userspace should do 
> this job... What do you think?

It is a matter of policy (deciding when device is "usable") and this
should be controlled from userspace. Kernel should provide necessary
knobs for it though. For a long time I was saying that it should be done
at device core level, but I do not think we will ever get there.

On ChromeOS input devices export "inhibit" attribute that basically
overrides open/close count and prevents delivery of events to userspace,
and power management driver controls this attribute together with wake
up and others. This allows us to implement policies like "the touchpad
should only be active and a wakeup source while the device is in laptop
mode, but not in tablet or tent mode, or when lid is closed", "disable
keyboard in tablet mode or when list is closed", etc.

Drivers can also implement inhibit/uninhibit methods that can put
inhibited devices into lower power mode. I am not too happy with the
implementation (I'd like to see if we could merge inhibit/uninhibit and
open/close), that is why I haven't pushed it upstream yet.

Thanks.

-- 
Dmitry
