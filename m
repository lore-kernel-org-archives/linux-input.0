From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Tue, 23 Oct 2007 21:58:14 -0400
Message-ID: <1193191094.32696.2.camel@moonpix.desrt.ca>
References: <20070609084800.GR6362@aehallh.com>
	 <200706120120.00494.dtor@insightbb.com> <20070612052316.GX6362@aehallh.com>
	 <200706120135.06428.dtor@insightbb.com> <20070612054031.GY6362@aehallh.com>
	 <20070702152044.GA24665@suse.cz> <20070703164555.GA20370@aehallh.com>
	 <1191035147.7025.28.camel@moonpix.desrt.ca>
	 <d120d5000710230621j3913384cn37dbab1a764de31c@mail.gmail.com>
	 <1193155059.15426.15.camel@moonpix.desrt.ca>
	 <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755054AbXJXB6p@vger.kernel.org>
In-Reply-To: <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Zephaniah E. Hull" <warp@aehallh.com>, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-23-10 at 14:10 -0400, Dmitry Torokhov wrote:
> No, rfkill want to see keypresses, period. It does not care if there
> are other applications also seeing the same keypresses, it just does
> not want keypresses stolen from it.

Right.  This is exactly the problem.  The current grab API exists to
prevent keys from being delivered to normal users, but rfkill still
wants to see them.

No matter how you slice it, if both of these desires are to be satisfied
then there needs to be some sort of a system to differentiate between
rfkill and "normal users".  That's what the priority is here.

> Yes, applications need to decide whether they want to process certain
> events or not. But I think that they shodul do it for themselves, not
> for other applications. Otherwise dependencies are just insane and you
> risk to disturb the peace just by adding another piece in the mix.

I disagree.  Dependencies aren't a problem at all if people merely rely
on the kernel to take care of the appropriate filtering.  Dependencies
only become a problem when X needs to know about "ok... maybe I should
ignore keys that are handled by [hal] [rfkill] [others] etc...".

Cheers
