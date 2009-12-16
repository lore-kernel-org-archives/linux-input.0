From: Alex Chiang <achiang@hp.com>
Subject: Re: synaptics touchpad doesn't click
Date: Tue, 15 Dec 2009 23:52:00 -0700
Message-ID: <20091216065200.GC20352@ldl.fc.hp.com>
References: <20091214014828.GA28402@ldl.fc.hp.com> <20091214173450.GB2373@core.coreip.homeip.net> <20091215034127.GC587@ldl.fc.hp.com> <20091215062628.GA12669@core.coreip.homeip.net> <s5h1viwn3ig.wl%tiwai@suse.de> <20091215073358.GC12669@core.coreip.homeip.net> <s5hvdg8lm5q.wl%tiwai@suse.de> <20091215082518.GD12669@core.coreip.homeip.net> <20091216010506.GA26367@ldl.fc.hp.com> <20091216025934.GA2699@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933285AbZLPGwI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216025934.GA2699@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Dec 15, 2009 at 06:05:06PM -0700, Alex Chiang wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > >
> > > The updated patch is below.
> > > 
> > > -- 
> > > Dmitry
> > 
> > Should I test this one or wait one more iteration to address
> > Takashi's last comments?
> > 
> 
> Actually I think we took the wrong direction with the original patch and
> we should do what other buttonless devices (bcm5974) do: report touchpad
> click as left button and have Synaptics X driver provide enhanced
> support. This way we can have both modes (ClickZones and ClickButtons)
> and users will get to chose (provided that someone takes time to add
> that support to Synaptics driver of course ;) ).
> 
> Could you tell me if the below works for you?

Left clicks work. Right/middle do not (as expected, I guess).

I liked the behaviour of Takashi's patch a little better wrt what
happens when you try to click/drag, because he disabled movement
in the click area.

My vodka consumption is minimal and I don't have the shakes, but
I found it difficult to precisely hit the edge of a window and
click / drag to resize...

/ac
