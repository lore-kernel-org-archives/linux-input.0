From: Peter Hutterer <peter.hutterer-Pf4JEFdB4epeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Thu, 18 Feb 2010 14:29:58 +1000
Message-ID: <20100218042958.GA19756@barra.bne.redhat.com>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
 <20100217052247.GD7160@core.coreip.homeip.net>
 <20100217180342.GA22522@srcf.ucam.org>
 <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
 <20100217184502.GA23573@srcf.ucam.org>
 <1266432575.678.980.camel@localhost.localdomain>
 <20100217223450.GC22561@barra.bne.redhat.com>
 <20100218041636.GA19037@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100218041636.GA19037-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Christian Lamparter <chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 17, 2010 at 08:16:37PM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 18, 2010 at 08:34:50AM +1000, Peter Hutterer wrote:
> > On Wed, Feb 17, 2010 at 06:49:35PM +0000, Bastien Nocera wrote:
> > > On Wed, 2010-02-17 at 18:45 +0000, Matthew Garrett wrote:
> > > > On Wed, Feb 17, 2010 at 07:43:56PM +0100, Christian Lamparter wrote:
> > > > 
> > > > > Wait wait... do you can get another KEY_?
> > > > > 
> > > > > The reason: Some new devices come with a WPS "Push Button".
> > > > > And there's no code for them yet.
> > > > 
> > > > What's a WPS button? There's no fundamental issue with getting new KEY_ 
> > > > codes defined, but bear in mind that anything greater than 255 won't be 
> > > > seen by X at present.
> > > 
> > > Won't be seen by most X applications. The server should definitely see
> > > it, so should applications that use XInput2-aware widget sets.
> > > 
> > > (Which obviously means not much at all right now).
> > 
> > Because XKB2 never happened we don't actually have any way of configuring
> > keysyms in the server for keys > 255 or getting this layout information to
> > the client. So XI2 applications that want to use higher keycodes are reliant
> > on the keycode itself which is strictly speaking random - at least the
> > protocol makes no guarantee that they remain fixed.
> > 
> > In practice that's not quite true and the keycodes are likely to remain
> > fixed but relying on that hurt us quite badly in the keyboard -> evdev
> > conversion.
> >
> 
> FWIW the event codes defines in linux/input.h form ABI and thus will not
> be changed (exception is adding aliases better describing intended key
> usage, such as KEY_COFFEE -> KEY_SCREENLOCK).

of course. the problem that would arise is that if a driver starts using a
different source for keycodes - such as happend when we changed from the old
keyboard driver to evdev. for years the keycodes remained the same and
applications relied on them. when we then started using evdev as the
keyboard driver a number of keycodes changed and some apps misbehaved.
(you may remember the Up/PrintScreen issues).

It is in fact still somewhat of an issue if you're using evdev and the kbd
driver at the same time - though the sensible use-cases for this scenario
are somewhat narrow.

Relying on keycodes - even if they're abi - is generally dangerous as it
circumvents the keyboard layouts configured by the users. After some talks
to our input methods guys it was shown that some input methods only work on
a qwerty layout but break rather badly on a azerty layout. And an anecdote
from our office - a password generator dongle started typing in wrong
passwords when it was accidentally configured with dvorak instead of qwerty.
Since the dongle could only send keycodes - which were then converted into
the keysyms depending on the layout - some of the passwords didn't match up
anymore. 

So - for client applications to rely on keycodes is a time-bomb, we really
need to get our act together and allow for 32-bit keycode layout
configuration in X.

Cheers,
  Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
