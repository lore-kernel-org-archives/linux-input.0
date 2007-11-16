From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] remove dead MAC_ADBKEYCODES
Date: Fri, 16 Nov 2007 16:09:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711161609180.23728@anakin>
References: <1195142010.14001.21.camel@hammer.suse.cz>
	<Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
	<d120d5000711160525p225f4b4o30eab6d01b289cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <d120d5000711160525p225f4b4o30eab6d01b289cda@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Linux/m68k <linux-m68k@vger.kernel.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: linux-input@vger.kernel.org

On Fri, 16 Nov 2007, Dmitry Torokhov wrote:
> On Nov 16, 2007 4:44 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Wrong mailing list ;-)
> >
> > On Thu, 15 Nov 2007, Stanislav Brabec wrote:
> > > It seems, that current kernel source code contains no traces of
> > > MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
> > > more.
> > >
> > > Attached patch removes them from configuration files.
> > >
> > > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> >
> > Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> >
> 
> Geert, are you going to push it through your tree?

Yes, I'll add it to my queue for 2.6.25.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
