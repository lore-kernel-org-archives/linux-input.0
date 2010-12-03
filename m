From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 13:50:08 -0600
Message-ID: <AANLkTikw3HF7CUc-7Enw-SGXztmiZAPUYZEKT1ViDTic@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
	<AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
	<20101203193224.GA21277@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46546 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0LCTuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 14:50:09 -0500
Received: by eye27 with SMTP id 27so5298344eye.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 11:50:08 -0800 (PST)
In-Reply-To: <20101203193224.GA21277@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry:

On Fri, Dec 3, 2010 at 1:32 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> How would the driver know if application that is opened the device
> does not want to be aware of the events that happened before read as
> opposed to the application that simply choses to "batch" events and
> process them at once? The driver might not be able to retrieve the "old"
> state of the hardware. Lets say toggle WIFI button was pressed and
> released while application wasn't reading. Normally kernel would queue
> the events and when userspace read the FD they'd see events, whereas in
> your case events would be lost.

Good question.

What I'm proposing is really useful only for embedded work, where you
have absolute control (or at least understanding) over what the
hardware and driver stack looks like.  If one wanted to see all the
transitions of the WiFi button (to use your example), they'd bind the
hardware to a driver that worked that way.  The system integrator
would make the choice, not the application.

In situations where an application wanted the accumulating behavior
sometimes, and the stateless behavior at other times, then the system
integrator could provide for that by using two different event
interfaces, one for each personality.  I think...

> I'd say applications that really want this behavior simply need to
> go through open/read/close cycles.

Wow, that seems really, really expensive at a sampling rate of 100+Hz.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
