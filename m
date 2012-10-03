From: Daniel Drake <dsd@laptop.org>
Subject: Re: Communicating tablet mode status to userspace
Date: Wed, 3 Oct 2012 08:52:31 -0600
Message-ID: <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
	<20121002233640.GB8542@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <20121002233640.GB8542@core.coreip.homeip.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 2, 2012 at 5:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Why can't you change event device ownership to the local user?  Then you
> can read and act upon events.

That would work, I guess.

However, it sounds like your suggesting that we add some custom rules
in OLPC's own builds and leave it at that. I'm not sure what
user/group we could use for a generic rule matching this hardware.

The disadvantage here is that it doesn't work as a global solution to
the problem - every embedded distro in the same situation would have
to add a custom rule thing, and "generic distros" would have no such
solution at this time.

Maybe not such a big deal while OLPC is the only user. But I did come
across another request for SW_TABLET_MODE access:
https://bugs.freedesktop.org/show_bug.cgi?id=43935

Or would a udev rule making the OLPC switch device (and potentially
similar devices on other platforms in future) world-readable on all
distros be accepted?

Thanks,
Daniel
