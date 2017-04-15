From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH v4 3/5] input: add a EV_SW event for ratchet switch
Date: Sat, 15 Apr 2017 19:50:45 -0300
Message-ID: <20170415195045.764c8642@vento.lan>
References: <cover.1491917052.git.mchehab@s-opensource.com>
        <ac259b5cece918d6f01d45b55fb0135f64f9c6a1.1491917052.git.mchehab@s-opensource.com>
        <20170415180436.GD33447@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170415180436.GD33447@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jonathan Corbet <corbet@lwn.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Stuart Yoder <stuart.yoder@nxp.com>, "David S. Miller" <davem@davemloft.net>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Florian Fainelli <f.fainelli@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Kamil Debski <kamil@wypas.org>, Douglas Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em Sat, 15 Apr 2017 11:04:36 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> Hi Mauro,
> 
> On Tue, Apr 11, 2017 at 10:29:40AM -0300, Mauro Carvalho Chehab wrote:
> > Some mice have a switch on their wheel, allowing to switch
> > between ratchet and free wheel mode. Add support for it.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> >  Documentation/input/event-codes.txt    | 12 ++++++++++++
> >  include/linux/mod_devicetable.h        |  2 +-
> >  include/uapi/linux/input-event-codes.h |  4 +++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
> > index 50352ab5f6d4..5dbd45db9bf6 100644
> > --- a/Documentation/input/event-codes.txt
> > +++ b/Documentation/input/event-codes.txt
> > @@ -206,6 +206,18 @@ Upon resume, if the switch state is the same as before suspend, then the input
> >  subsystem will filter out the duplicate switch state reports. The driver does
> >  not need to keep the state of the switch at any time.
> >  
> > +A few EV_SW codes have special meanings:
> > +
> > +* SW_RATCHET:
> > +
> > +  - Some mice have a special switch for their wheel that allows to change
> > +    between free wheel mode and ratchet mode. When the switch is ratchet
> > +    mode (ON state), the wheel will offer some resistance for movements. It
> > +    may also provide a tactile feedback when scrolled.
> > +
> > +    Note that some mice have a ratchet switch that does not generate a
> > +    software event.  
> 
> So it is still not clear to me why we need the 2 discrete events. Either
> we key off the behavior off the new REL event, or from switch, but not
> both.

The two events are independent. Clicking at the Wheel button just
sets it to free wheel or back to ratchet mode. It doesn't switch
the resolution.

The high resolution events are sent only when userspace sets
the mouse to high resolution mode.

I wrote patch series for Solaar with allows switching between
low resolution and high resolution modes and controls if the
wheel movement is normal or inverted:

	https://github.com/pwr/Solaar/pull/351

It uses the hidraw interface to switch between the two modes.

> Also, it is unclear to me if allocating a new event for "hires" wheel is
> optimal. This still does not solve the question about resolution (how
> high is "hires" and what to do if Logitech will come out with
> ultra-high-resolution wheel next year, or if we need to express
> resolution for other relative events).

How "high" is the resolution can be queried on those devices.
Not sure how to report it to userspace, though. Ok, one application
could query it via hidraw interface (my Solaar patches do that
when solaar is called with the "show" parameter).

Perhaps an ioctl? Or do you have a better idea?

> 
> Thanks.
> 
> > +
> >  EV_MSC:
> >  ----------
> >  EV_MSC events are used for input and output events that do not fall under other
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index a3e8c572a046..79dd7dbf5442 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -292,7 +292,7 @@ struct pcmcia_device_id {
> >  #define INPUT_DEVICE_ID_LED_MAX		0x0f
> >  #define INPUT_DEVICE_ID_SND_MAX		0x07
> >  #define INPUT_DEVICE_ID_FF_MAX		0x7f
> > -#define INPUT_DEVICE_ID_SW_MAX		0x0f
> > +#define INPUT_DEVICE_ID_SW_MAX		0x1f
> >  
> >  #define INPUT_DEVICE_ID_MATCH_BUS	1
> >  #define INPUT_DEVICE_ID_MATCH_VENDOR	2
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index da48d4079511..da83e231e93d 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -789,7 +789,9 @@
> >  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
> >  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
> >  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
> > -#define SW_MAX			0x0f
> > +#define SW_RATCHET		0x10  /* set = ratchet mode,
> > +					 unset: free wheel */
> > +#define SW_MAX			0x1f
> >  #define SW_CNT			(SW_MAX+1)
> >  
> >  /*
> > -- 
> > 2.9.3
> >   
> 



Thanks,
Mauro
