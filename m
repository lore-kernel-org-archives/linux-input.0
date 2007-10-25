From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Thu, 25 Oct 2007 01:37:34 -0400
Message-ID: <1193290654.15893.2.camel@moonpix.desrt.ca>
References: <20070609084800.GR6362@aehallh.com>
	 <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com>
	 <1193191094.32696.2.camel@moonpix.desrt.ca>
	 <200710232333.08306.dmitry.torokhov@gmail.com>
	 <20071024153508.GG26573@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760696AbXJYFie@vger.kernel.org>
In-Reply-To: <20071024153508.GG26573@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Wed, 2007-24-10 at 11:35 -0400, Zephaniah E. Hull wrote:
> We need a way to, at the absolute minimum, unbind the keyboard from the
> text console.  The current solution sucks for things like rfkill.
> 
> I'm not convinced that Ryan's fix is any better, but just saying that X
> should open the console and ignore the characters is simply not an
> option as far as I am concerned for X.

Can you think of any other way to separate things like rfkill/evdev from
things like the text console that's less hacky than my 'priority'
scheme?

Cheers
