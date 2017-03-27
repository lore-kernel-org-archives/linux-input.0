From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH RFC 3/4] input: add a EV_SW event for ratchet switch
Date: Mon, 27 Mar 2017 09:27:31 -0300
Message-ID: <20170327092731.3fd5db9a@vento.lan>
References: <cover.1490481944.git.mchehab@s-opensource.com>
        <c48652786b1e139503834f67b1a5037ff677a174.1490481944.git.mchehab@s-opensource.com>
        <20170327015357.GE21915@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34331
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752686AbdC0MhM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 08:37:12 -0400
In-Reply-To: <20170327015357.GE21915@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Stuart Yoder <stuart.yoder@nxp.com>, Hans Verkuil <hans.verkuil@cisco.com>, Douglas Anderson <dianders@chromium.org>, Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>

Em Mon, 27 Mar 2017 11:53:57 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Sat, Mar 25, 2017 at 07:49:41PM -0300, Mauro Carvalho Chehab wrote:
> > Some mouses have a switch on their wheel, allowing to switch
> > between ratchet or free wheel mode. Add support for it.  
> 
> I understand the want to support it because it's there but what do you
> expect this to be used for?
> 
> tbh, I wouldn't know what to do with this information, short of displaying
> some OSD to inform the user. Which is rather superfluous since the physical
> change will feel obvious anyway.

For this particular device, the main reason is because it is there :-)
As adding support for it is trivial, I don't see any reason why not
adding it.

Yet, applications could use it, in order to switch between a "discrete" 
mode, where one wheel position corresponds to one line of scroll, and
movements below a threshold would be ignored.


> 
> A Documentation/input/event-codes.txt hunk would be welcomed here too
> btw.

Sure. Will do on a next patch series, once we agree about the high
resolution wheel movements API.
> 
> Cheers,
>    Peter
> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> >  include/linux/mod_devicetable.h        | 2 +-
> >  include/uapi/linux/input-event-codes.h | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index 8a57f0b1242d..73534c591b40 100644
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
> > index 23b2d377af59..a3eafd0527f1 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -782,7 +782,9 @@
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
> >   



Thanks,
Mauro
