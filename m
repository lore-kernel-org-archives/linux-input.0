From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] remove dead MAC_ADBKEYCODES
Date: Fri, 16 Nov 2007 08:25:24 -0500
Message-ID: <d120d5000711160525p225f4b4o30eab6d01b289cda@mail.gmail.com>
References: <1195142010.14001.21.camel@hammer.suse.cz>
	<Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stanislav Brabec <sbrabec@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: linux-input@vger.kernel.org

On Nov 16, 2007 4:44 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Wrong mailing list ;-)
>
> On Thu, 15 Nov 2007, Stanislav Brabec wrote:
> > It seems, that current kernel source code contains no traces of
> > MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
> > more.
> >
> > Attached patch removes them from configuration files.
> >
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
>
> Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>

Geert, are you going to push it through your tree?

-- 
Dmitry
