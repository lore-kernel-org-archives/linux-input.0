From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Handling touchscreen buttons
Date: Tue, 25 Sep 2007 11:34:41 -0700
Message-ID: <20070925113441.40035069.Kristoffer.ericson@gmail.com>
References: <20070923213913.15c12c3b.Kristoffer.ericson@gmail.com>
	<200709250144.16495.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709250144.16495.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 25 Sep 2007 01:44:16 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Monday 24 September 2007, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > On my jornada7xx I have 4 buttons on the rightside of the screen (going from Y-low -> Y-high). They are part of the touchscreen.
> > Since they aren't usually used in normal X window handling I was thinking that I should have the driver detect if the touch happend on one of those buttons.
> > The general idea is that I could somehow export detection into /sys so that ordinary applications could make use of them. Example would be that touching one button could be scripted to start an xterm or anything else.
> > 
> > Im interested to know if anyone has any examples or suggestion how to best accomplish this?
> > 
> 
> 
> I'd just send KEY_PROG1 .. KEY_PROG4 events through the same input
> device you send the rest of touchscreen events.
> 
Great idea, big thanx.


> -- 
> Dmitry
