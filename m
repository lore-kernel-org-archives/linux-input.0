From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alps] Timing patch, revised again :-)
Date: Fri, 4 Dec 2009 15:49:48 -0800
Message-ID: <200912041549.48949.dmitry.torokhov@gmail.com>
References: <1259513695.32495.171.camel@sardelle.necksus.de> <20091204084902.GB22570@core.coreip.homeip.net> <1259963240.27307.213.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49558 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbZLDXtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 18:49:47 -0500
Received: by gxk26 with SMTP id 26so2745735gxk.1
        for <linux-input@vger.kernel.org>; Fri, 04 Dec 2009 15:49:54 -0800 (PST)
In-Reply-To: <1259963240.27307.213.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>

On Friday 04 December 2009 01:47:20 pm Sebastian Kapfer wrote:
> Hi Dmitry,
> 
> thank you.  I've tested it and it basically works.  I still have two
> more nits to pick though :-)
> 
> > Yeah, but due to protocol limitations we can't really do anything about
> > it. It should not desync though.
> 
> It does still occasionally desync (but see below).
> 
> > > I've changed two little things:
> > >
> > > 1. The reporting of buttons went to dev2 sometimes, as bare_ps2_packet
> > > signalled the click on 'dev', not psmouse->dev.  This lead to sticking
> > > buttons.
> > >
> > > 2. We needlessly break the distinction of PS/2 and touchpad on older
> > > models, where it may have been cleanly possible.  (If you don't want to
> > > keep that feature and rather simplify the code, that's fine with me,
> > > too.  But as I said, bare_ps2_packet needs to be fixed up then.)
> >
> > I tend to agree with Dave's preference of routing button data from 3-byte
> > packets to stick only and 6- and 9-byte packets to the pad and sending
> > release to both devices. I think it makes most sense.
> 
> It does, in a way.  All I'm saying is that we're making a promise to
> userspace clients that we can't completely fulfil (i.e. some buttons
> will be reported incorrectly).  Anyway, I really don't want to argue
> about this particular point anymore given Dave's previous attitude.
> 
> 
> What is more worrysome to me is that we're now reporting the same
> physical click on two input layer devices again.  We should not do this,
> because this can lead to spurious double-click events.  Imagine for
> example moving the touchpad while pressing the trackpoint button:
> 
> 6byte -- no buttons set
> 3byte -- left set  (in response to user click)        dev2 down
> 6byte -- left set  (hw copies over from trackpoint)   dev down
> 3byte -- no buttons set (in response to user release) dev2, dev release
> 
> Given unlucky timing and the way X11 reads event data, this is an X11
> double-click.

Hmm, I see... Right, we should not leave it like this.

> 
> Reading the comments in the patch, I'm not sure if you're aware how the
> hardware reports buttons.  When I press the trackpoint button, the
> corresponding bit is set in _all_ packets (3s, 6s, 9s) sent
> subsequently, until I release it.  This is not about pressing two
> buttons at the same time, just one.  Sorry if I'm reading too much into
> that comment and you already know this.
> 
> Given this behaviour of the hw, I'd favour not reporting button presses
> on a device while the corresponding button on the other device is down.
> (Dave called this behaviour 'masking'.)  Code implementing this was in
> the patch I sent to linux-input dated Nov. 11 (see the parts involving
> the btn_state variable).  I have not put it back in the patch below
> because I'd like to await your opinion on this first.

OK, Let me take a look at that patch again.
 
> 
> There is still one failure mode left that causes de-sync.  It happens
> when the else branch in  alps_handle_interleaved_ps2 gets called more
> than once, i.e. we're accidentially reconstructing a 12-, 15- etc byte
> packet.  This was easier to deal with in my first patch, I just
> collected the whole 9 bytes in a buffer and implicitly knew when the
> packet was over.  Example of this happening:
> 
> Dec  4 21:03:22 sardelle kernel: [410740.786121] alps.c: handle: cf
> Dec  4 21:03:22 sardelle kernel: [410740.787499] alps.c: handle: 79
> Dec  4 21:03:22 sardelle kernel: [410740.788688] alps.c: handle: 12
> Dec  4 21:03:22 sardelle kernel: [410740.789979] alps.c: handle: 1f
> Dec  4 21:03:22 sardelle kernel: [410740.791146] alps.c: handle: ff
> Dec  4 21:03:22 sardelle kernel: [410740.792299] alps.c: handle: 1
> <suspect 9byte (really is)>
> Dec  4 21:03:22 sardelle kernel: [410740.796899] alps.c: handle: 4f
> <yup, it is, fold back>

Ah, ok, so when we report all 3 buttons pressed we mistaken it as interleaved 
packet again... Insteado f waiting till 9th byte can't we just forcefully
exit inetrleaved mode (once we processed the bare packet) by doing:

     psmouse->packet[3] &= 0xf7;

?

-- 
Dmitry
