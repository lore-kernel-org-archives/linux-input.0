From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 17:27:13 -0500
Message-ID: <4B96CB41.9040804@seas.upenn.edu>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <4B96C4A8.3060005@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:47973 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0CIW1Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:27:25 -0500
In-Reply-To: <4B96C4A8.3060005@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

On 03/09/2010 04:59 PM, Henrik Rydberg wrote:
> Rafi Rubin wrote:
>> Since you're considering protocol clarification, what's your opinion on
>> splitting the multi-touch and single touch (possibly emulated) to
>> separate input devices?
>
> The multi-touch protocol was designed to complement single-touch, not replace
> it. The MT events were specifically designed to be ignored by current userland
> applications, so there is no need to separate them into different devices.
>
> On the contrary, the MT protocol is dependent on one of the single-touch events
> BTN_TOUCH or ABS_PRESSURE to be present in the event stream for proper device
> identification and for correct handling of zero-finger events. The latter
> because at least one value (BTN_TOUCH or ABS_PRESSURE) must change state to pass
> through input filtering when no fingers are present. This is what needs
> clarification.
>
>> Also BTN_0 or BTN_TOOL_DOUBLETAP for single touch (or both)?  It seems
>> to me Wacom uses doubletap, whereas my hardware's rdesc defaults to btn0
>> and evdev prefers btn0 as well.
>
> Single touch should be goverened by one of BTN_TOUCH or ABS_PRESSURE.
> BTN_TOOL_DOUBLETAP is a two-finger event.

That definitely makes sense to me.  I really don't know why wacom uses 
double tap there.

Is there any harm in letting through the BTN_0 events?  Is the "rdesc" 
mapping defined by the hardware or hid?

For my device touch contacts look like this:

Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Key.ToolPen
Digitizers.Confidence ---> Key.Btn0
Digitizers.ContactID ---> Sync.Report
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
Digitizers.Width ---> Absolute.MTMajor
Digitizers.Height ---> Absolute.MTMinor
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report

Hence some of my confusion about setting both Touch and another button 
(the ToolPen bit seemed less pertinent).


Rafi
