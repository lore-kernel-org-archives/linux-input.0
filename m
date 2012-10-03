From: Greg KH <greg@kroah.com>
Subject: Re: Communicating tablet mode status to userspace
Date: Wed, 3 Oct 2012 08:05:42 -0700
Message-ID: <20121003150542.GA8460@kroah.com>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
 <20121002233640.GB8542@core.coreip.homeip.net>
 <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 03, 2012 at 08:52:31AM -0600, Daniel Drake wrote:
> On Tue, Oct 2, 2012 at 5:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Why can't you change event device ownership to the local user?  Then you
> > can read and act upon events.
> 
> That would work, I guess.
> 
> However, it sounds like your suggesting that we add some custom rules
> in OLPC's own builds and leave it at that. I'm not sure what
> user/group we could use for a generic rule matching this hardware.

That shouldn't be a custom rule, other distros bind the keyboard / mouse
to the local user in order to handle the multi-seat situation properly.
That should all be done already in the console-kit logic (or whatever
handles it now.)

Have you looked into that?

greg k-h
