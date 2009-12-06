From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: Re: [alps] Timing patch, revised again :-)
Date: Sun, 06 Dec 2009 20:53:57 +0100
Message-ID: <1260129237.21632.7.camel@sardelle.necksus.de>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
	 <20091204084902.GB22570@core.coreip.homeip.net>
	 <1259963240.27307.213.camel@sardelle.necksus.de>
	 <200912041549.48949.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756890AbZLFTxy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Dec 2009 14:53:54 -0500
In-Reply-To: <200912041549.48949.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input ML <linux-input@vger.kernel.org>


Hi Dmitry!


On Fr, 2009-12-04 at 15:49 -0800, Dmitry Torokhov wrote:
[...]
> > Given this behaviour of the hw, I'd favour not reporting button pre=
sses
> > on a device while the corresponding button on the other device is d=
own.
> > (Dave called this behaviour 'masking'.)  Code implementing this was=
 in
> > the patch I sent to linux-input dated Nov. 11 (see the parts involv=
ing
> > the btn_state variable).  I have not put it back in the patch below
> > because I'd like to await your opinion on this first.
>=20
> OK, Let me take a look at that patch again.

I think it's pretty straightforward.  Let me know what you think.
=20
> > There is still one failure mode left that causes de-sync.  It happe=
ns
> > when the else branch in  alps_handle_interleaved_ps2 gets called mo=
re
> > than once, i.e. we're accidentially reconstructing a 12-, 15- etc b=
yte
> > packet.  This was easier to deal with in my first patch, I just
> > collected the whole 9 bytes in a buffer and implicitly knew when th=
e
> > packet was over.  Example of this happening:
> >=20
> > Dec  4 21:03:22 sardelle kernel: [410740.786121] alps.c: handle: cf
> > Dec  4 21:03:22 sardelle kernel: [410740.787499] alps.c: handle: 79
> > Dec  4 21:03:22 sardelle kernel: [410740.788688] alps.c: handle: 12
> > Dec  4 21:03:22 sardelle kernel: [410740.789979] alps.c: handle: 1f
> > Dec  4 21:03:22 sardelle kernel: [410740.791146] alps.c: handle: ff
> > Dec  4 21:03:22 sardelle kernel: [410740.792299] alps.c: handle: 1
> > <suspect 9byte (really is)>
> > Dec  4 21:03:22 sardelle kernel: [410740.796899] alps.c: handle: 4f
> > <yup, it is, fold back>
>=20
> Ah, ok, so when we report all 3 buttons pressed we mistaken it as int=
erleaved=20
> packet again... Insteado f waiting till 9th byte can't we just forcef=
ully
> exit inetrleaved mode (once we processed the bare packet) by doing:
>=20
>      psmouse->packet[3] &=3D 0xf7;

Hmm I guess we could do something like this, but IMHO it makes the code
needlessly arcane.  What would be the point?  Save 3 bytes of buffer?
Deliver the mouse movement a microsecond earlier?  Given that the
interleaved packet is somehow a coherent piece of data sent by the
touchpad, I'd store it exactly like that.

Greetings!

--=20
Sebastian Kapfer
 Inst. f=FCr Theoretische Physik I        Office +49-9131-85-2-8450
 Universit=E4t Erlangen                   Mobile +49-160-9577-6436
 Staudtstr. 7, Raum 02.583.             sebastian.kapfer@physik.uni-erl=
angen.de

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
