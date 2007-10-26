From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Fri, 26 Oct 2007 13:16:31 -0400
Message-ID: <1193418991.7673.5.camel@moonpix.desrt.ca>
References: <20070609084800.GR6362@aehallh.com>
	 <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com>
	 <1193191094.32696.2.camel@moonpix.desrt.ca>
	 <200710232333.08306.dmitry.torokhov@gmail.com>
	 <20071024153508.GG26573@aehallh.com>
	 <1193290654.15893.2.camel@moonpix.desrt.ca>
	 <20071026164441.GI26573@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764372AbXJZRRX@vger.kernel.org>
In-Reply-To: <20071026164441.GI26573@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Fri, 2007-26-10 at 12:44 -0400, Zephaniah E. Hull wrote:
> A 'filter' cares about a key or two, and might even want to remove it
> from the stream, rfkill is a good example.

The patch introduces two different features that work nicely together
but, by no means have to be used together.

1) set interested events

  By default, -all- events are delivered to an event device.  you only
  get selective delivery when you explicitly use the 'set bits' call.


2) filter

  Filter all events that have been delivered to the user from further
  propagation.


Notice that if you do not use feature #1 then you get all keystrokes
delivered to you (unless someone with a higher priority than you did
some filtering).  If you then use feature #2 then you filter everything
(since everything is delivered to you).



I really do think that this is good for your use case.  Your use of it
would basically involve opening the event device and saying
"ioctl(turn_filter_on);".  The default case is that all keys are
delivered (and therefore blocked from anyone below you).



Cheers
