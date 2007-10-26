From: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Fri, 26 Oct 2007 12:44:41 -0400
Message-ID: <20071026164441.GI26573@aehallh.com>
References: <20070609084800.GR6362@aehallh.com> <d120d5000710231110u79ea11a8p38f1fc4654a7fac2@mail.gmail.com> <1193191094.32696.2.camel@moonpix.desrt.ca> <200710232333.08306.dmitry.torokhov@gmail.com> <20071024153508.GG26573@aehallh.com> <1193290654.15893.2.camel@moonpix.desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <1193290654.15893.2.camel@moonpix.desrt.ca>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Ryan Lortie <desrt@desrt.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 25, 2007 at 01:37:34AM -0400, Ryan Lortie wrote:
> On Wed, 2007-24-10 at 11:35 -0400, Zephaniah E. Hull wrote:
> > We need a way to, at the absolute minimum, unbind the keyboard from the
> > text console.  The current solution sucks for things like rfkill.
> > 
> > I'm not convinced that Ryan's fix is any better, but just saying that X
> > should open the console and ignore the characters is simply not an
> > option as far as I am concerned for X.
> 
> Can you think of any other way to separate things like rfkill/evdev from
> things like the text console that's less hacky than my 'priority'
> scheme?

What we really want to give is exclusitivity verses other 'end users',
as opposed the 'filters'.

I'm defining an 'end user' to be a handler that cares about all the
events from a device and plans on doing something with it.

That would be the console layer for keyboards, /dev/input/mice and
/dev/input/mouse<n> for mice, X for both of those, etc.

A 'filter' cares about a key or two, and might even want to remove it
from the stream, rfkill is a good example.

Now, how do we design for that?  Not a clue right now, still thinking
about it really.

Zephaniah E. Hull.
