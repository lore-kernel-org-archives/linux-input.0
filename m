From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH v2 35/37] input: add a EV_SW event for ratchet switch
Date: Thu, 6 Apr 2017 21:16:05 -0300
Message-ID: <20170406211605.4267094a@vento.lan>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
        <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
        <20170405120303.GA21280@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170405120303.GA21280@jelly>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Stuart Yoder <stuart.yoder@nxp.com>, "David S. Miller" <davem@davemloft.net>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Florian Fainelli <f.fainelli@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Ping Cheng <pinglinux@gmail.com>, Douglas Anderson <dianders@chromium.org>, Kamil Debski <kamil@wypas.org>
List-Id: linux-input@vger.kernel.org

Em Wed, 5 Apr 2017 22:03:03 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Tue, Apr 04, 2017 at 09:22:35AM -0300, Mauro Carvalho Chehab wrote:
> > Some mouses have a switch on their wheel, allowing to switch  
> 
> isnt' the plural of mouse mice? (non-native english speaker myself)

Yeah, true. I'll fix on a next review.
> 
> > between ratchet or free wheel mode. Add support for it.  
> 
> s/or/and/
> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> >  Documentation/input/event-codes.rst    | 16 ++++++++++++++++
> >  include/linux/mod_devicetable.h        |  2 +-
> >  include/uapi/linux/input-event-codes.h |  4 +++-
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> > index 0c8591d39bc6..93f14f0ddb3d 100644
> > --- a/Documentation/input/event-codes.rst
> > +++ b/Documentation/input/event-codes.rst
> > @@ -239,6 +239,22 @@ Upon resume, if the switch state is the same as before suspend, then the input
> >  subsystem will filter out the duplicate switch state reports. The driver does
> >  not need to keep the state of the switch at any time.
> >  
> > +A few EV_SW codes have special meanings:
> > +
> > +* SW_RATCHET:
> > +
> > +  - Some mouses have a special switch at their wheel that allows to change
> > +    from free wheel mode to ratchet mode.  
> 
> "between free wheel mode and ratchet mode"
> 
> > +
> > +    When such switch is ratchet mode (ON state), the wheel will offer some  
> 
> s/such/the/
> 
> > +    resistance for movements movement. It will also provide a tactile
> > +    feedback when scrolled.  
> 
> this is too specific, you cannot guarantee that all devices in the future
> have exactly that behaviour. I would just skip the second sentence.

I just wanted to let it clear about what's the difference between ratchet
and free wheel mode. As a non-native speaker, I had to research myself
about what the heck "ratchet" means, as I never heard this word before ;)

To be frank, when I received this mouse, I had some troubles to adapt
to it, as on other mice I have here, the wheel is used generate the
mid button event. On this specific model, there's a small button on
south of the wheel the mid button event.

> > +
> > +    When pressed while in ratchet mode, the wheel will switch to free wheel
> > +    mode (OFF state). In this mode, it will offer no resistance to wheel
> > +    movements nor any tactile feedback. Pressing again returns to ratchet
> > +    mode.  
> 
> nack to this, this is your device but not all future devices will have this
> behaviour. e.g. some devices have the ratchet switch below (i.e. south of)
> the weel. Just describe the effect the switch has, not the physical
> behaviour.

Ok, I'll remove it. What about this:

* SW_RATCHET:

  - Some mice have a special switch at their wheel that allows to change
    between free wheel mode and ratchet mode via a ratchet switch.

    When the switch is ratchet mode (ON state), the wheel will offer some
    resistance for movements. It may also provide a tactile feedback when 
    scrolled.

Regards,
Mauro
