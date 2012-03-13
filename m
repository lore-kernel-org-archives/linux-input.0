From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: hid-lg4ff add support for G27 LEDs
Date: Tue, 13 Mar 2012 09:23:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203130922110.18356@pobox.suse.cz>
References: <1331565459-1892-1-git-send-email-simon@mungewell.org>    <alpine.LNX.2.00.1203121645050.18356@pobox.suse.cz>    <be2be8d04b58ce75fcba9798fcb4e4fa.squirrel@mungewell.org>    <20120312180738.GD14020@sirena.org.uk>   
 <3391c87c6cc142e1b50b73eb78e70dc8.squirrel@mungewell.org>    <20120312183235.GA28451@opensource.wolfsonmicro.com> <03eaca06ba2629f55144daa5a386c74b.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03eaca06ba2629f55144daa5a386c74b.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: simon@mungewell.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 12 Mar 2012, simon@mungewell.org wrote:

> >> The LEDs on the G27 are very much more specific, mounted on the yoke of
> >> the gaming wheel.
> >
> >> Would this require the use/complexity of the LED subsystem?
> >
> > Well, it'd mean that applications that know how to drive LEDs will be
> > able to use the LEDs on this wheel with less per device knowledge which
> > seems like a useful thing and if someone wants to remap a LED to "new
> > mail" or whatever that'll be easier (nethack has the mailer daemon
> > deliver a scroll of mail!).
> 
> I'm not familiar with the LED subsystem, but my concerns would be that
> this would add a whole load of code to implement.

Not really, it's rather simple to use and as Mark said, it's a proper 
infrastructure to use here.

We already have HID drivers which are using this -- you can look at 
PicoLCD or Wiimote drivers and you'll see that it's indeed fairly simple.

> PS. I don't really care about email when screaming around Laguna Seca ;-)

:))

-- 
Jiri Kosina
SUSE Labs
