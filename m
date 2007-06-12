From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Tue, 12 Jun 2007 01:35:05 -0400
Message-ID: <200706120135.06428.dtor@insightbb.com>
References: <20070609084800.GR6362@aehallh.com> <200706120120.00494.dtor@insightbb.com> <20070612052316.GX6362@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070612052316.GX6362@aehallh.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 12 June 2007 01:23, Zephaniah E. Hull wrote:
> On Tue, Jun 12, 2007 at 01:19:59AM -0400, Dmitry Torokhov wrote:
> > 
> > Like I said I would love if xf86-input-evdev did not grab the
> > device at all.
> 
> We have to disable the legacy input handlers somehow, not doing so
> simply isn't an option.

I do not follow. If user's xorg.conf does not use /dev/input/mice and
does not use "kbd" driver then grabbing is not required, is it? Now,
as far as I understand, lack of hotplug support in X is the main
obstacle for removing "mouse" and "kbd" drivers, correct?
 
> > 
> > But rfkill-input is not a legacy handler. My objection is that with your
> > solution you still will rob handlers such rfkill-input of events.
> 
> Urgh.
> 
> So, any thoughts on how to identify legacy input handlers in the input
> system?

I guess keyboard and mousedev will have to be flagged as such in kernel.

-- 
Dmitry
