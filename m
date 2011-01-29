From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interface for regression testing & input event capture/replay?
Date: Sat, 29 Jan 2011 01:11:06 -0800
Message-ID: <20110129091106.GE26915@core.coreip.homeip.net>
References: <AANLkTim5_sFHphygm2enEDFc7GNKd=M0h6hSvT2QeyCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43544 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab1A2JLN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Jan 2011 04:11:13 -0500
Received: by iyj18 with SMTP id 18so3319863iyj.19
        for <linux-input@vger.kernel.org>; Sat, 29 Jan 2011 01:11:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim5_sFHphygm2enEDFc7GNKd=M0h6hSvT2QeyCP@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Lambert <tlambert@google.com>
Cc: linux-input@vger.kernel.org

Hi Terry,

On Thu, Jan 27, 2011 at 11:58:38AM -0800, Terry Lambert wrote:
> Hi;
> 
> I'm looking for some guidance from Linux/input people...
> 
> I've looked through the archives, and around the net a bit, and I
> haven't been able to find anything to capture events from an arbitrary
> set of inputs, and then replay them back to software attached to those
> inputs.

I do not believe there is anything production - quality but I remember
seeing programs proxying the input from one box to another over the network.

> 
> This would be useful for:
> 
> o Regression testing user space algorithms
> o Training software for gesture recognition
> o Tuning drivers for new hardware to correct self-censor undesirable events
> o Probably lots of other things I haven't thought of
> 
> The multiple event sources requirement comes from using things like
> keyboard modifier keys to change mouse button behaviours.  The most
> obvious example is probably option-click on Apple hardware with a one
> button mouse.
> 
> The basic problems with just opening up /dev/eventX, /dev/eventY, ...
> and listening/injecting are:
> 
> o If a piece of software grabs the input, I don't get events

Right, grab means exclusive access.

> o If I grab the input, the software I'm testing doesn't get events

*nod*

> o If neither of us grabs the input, filters apply

As they should.

> o If the input is grabbed by someone, you can't inject events

Again, grab is exclusive access 

> o It won't work if the event consuming software lives in kernel space

That I am not sure, injected events do get distributed to all
handlers/filters.

> 
> The basic problems with using the filter mechanism are:
> 
> o Filters are applied after grabs, so if it's grabbed the filter is not invoked
>     (I read the thread introducing filters; this makes sense)
> o You can only have one filter at a time
>     (there might already be one)

You should be able to have several filters.

> 
> Has anyone tried to solve this problem before?  Any suggestions?

The canonical way for augmenting input stream in user space would be
with a program that open/grabs one or several event devices, does
processing and loops resulting events back into kernel via uinput (again
creating one or many input devices). Because you create 2nd set of input
devices you avoiding all issues with grabs/exclusive assess with
consumers of your data.

Hope this helps.

-- 
Dmitry
