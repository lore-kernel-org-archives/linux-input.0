From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: RE: [RFC] input: syfs switches for SKE keypad
Date: Wed, 06 Oct 2010 12:48:38 +0300
Message-ID: <1286358518.26914.23.camel@4fid08082>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
	 <20101005174106.GA21399@core.coreip.homeip.net>
	 <4CAC340B.90207@codeaurora.org>
	 <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58297 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab0JFJtv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 05:49:51 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Sundar R IYER <sundar.iyer@stericsson.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>

On Wed, 2010-10-06 at 10:56 +0200, ext Sundar R IYER wrote:
> Hi,
> 
> >-----Original Message-----
> >From: Trilok Soni [mailto:tsoni@codeaurora.org]
> >Sent: Wednesday, October 06, 2010 2:02 PM
> >
> >I agree with Dmitry. Meego people or you should explain the real end-to-end
> >usecase first. Why it can't fit anywhere else?
> 
> I don't know the full details; but what I can think of (or did I read it somewhere?)
> is events like phones with slider keypad; you can power save keypad controller
> when the keypad is not active. And these events are probably issued from the user
> space to the kernel and that's why the requirement probably. And I do remember
> Samu mentioning about unwanted wakeup events which were avoided via these switches.
> 
> Adding Samu who can explain more on this.

This is how I see this issue

I tried to push enable / disable entries to generic input layer to avoid
driver specific controls. That was not accepted.

The need for keypad locking is not following any global PM transition.
In phones (like N900), global suspend / resume is not used at all. Phone
is running all the time. For example phone must be able to handle
incoming calls all the time. Instead suspend / resume, system is in deep
idle state as much as possible. Wake up from that takes couple of
milliseconds and everything is running again. Powers, clocks and any
extra activity must be turned off when ever possile depending on the
overall system state.

For input devices this means that keypad, touch controller etc. are
turned off or partially disabled for example when the screen is blanked.
Meanwhile system may still have other activity ongoing like mp3
playback. When the screen is off, there must be some way to tell to
touch controller that please turn off and save some power. This not
following pm transitions. On the other hand, disable entry may trig
pm_runtime suspend transifion for that device.

For mobile devices it is not acceptable to filter events away at some
upper SW layer depending on the system state. The HW which generates
those events may not generate events at all to allow longer CPU sleep
periods.

In ideal world it would be nice to control device states based on for
example user count. However, there are several listeners for input
devices and it is hard or impossible to have them all to follow overall
state transition (screen blanked etc.). Instead, there is some system
state controller in the userspace who is responsible to get all the HW
in the correct state. Separate disable / enable entries makes life much
easier.

Hopefully this clears out our point of view.

Regards,
Samu

> 
> >We should not fill in features very specific to userspace frameworks. I see lately
> >lot of Android and Meego specific bits into TS and Keypad drivers from many
> >folks.
> >
> 
> Yeah. IMO it is because people want to mainline and push out all drivers more and more;
> And as of today most of these drivers and HW are tested and delivered on such frameworks :)
> 
> Regards,
> Sundar
> 
> 

