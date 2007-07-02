From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Mon, 2 Jul 2007 17:20:44 +0200
Message-ID: <20070702152044.GA24665@suse.cz>
References: <20070609084800.GR6362@aehallh.com> <200706120120.00494.dtor@insightbb.com> <20070612052316.GX6362@aehallh.com> <200706120135.06428.dtor@insightbb.com> <20070612054031.GY6362@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070612054031.GY6362@aehallh.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 12, 2007 at 01:40:31AM -0400, Zephaniah E. Hull wrote:
> On Tue, Jun 12, 2007 at 01:35:05AM -0400, Dmitry Torokhov wrote:
> > On Tuesday 12 June 2007 01:23, Zephaniah E. Hull wrote:
> > > On Tue, Jun 12, 2007 at 01:19:59AM -0400, Dmitry Torokhov wrote:
> > > > 
> > > > Like I said I would love if xf86-input-evdev did not grab the
> > > > device at all.
> > > 
> > > We have to disable the legacy input handlers somehow, not doing so
> > > simply isn't an option.
> > 
> > I do not follow. If user's xorg.conf does not use /dev/input/mice and
> > does not use "kbd" driver then grabbing is not required, is it? Now,
> > as far as I understand, lack of hotplug support in X is the main
> > obstacle for removing "mouse" and "kbd" drivers, correct?
> 
> Sadly, not quite.
> 
> The problem is that if the user is not using the mouse and kbd drivers
> at all, but is instead using xf86-input-evdev, and no grabbing is done,
> then all key presses end up going to the console.

X still switches to its own VT, so those keys go to the X server via the
console, and GPM also knows about console switching ...

That is a sane way how to prevent the regular console from getting
keypresses/mouse movements.

-- 
Vojtech Pavlik
Director SuSE Labs
