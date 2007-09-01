From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Sat, 1 Sep 2007 19:33:29 +0200
Message-ID: <20070901173329.GB12644@implementation>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr> <20070821204951.GC3658@interface.famille.thibault.fr> <20070712191932.GA3947@ucw.cz> <20070901122604.GA3251@implementation.famille.thibault.fr> <20070901123258.GA4612@ucw.cz> <20070901125120.GC3251@implementation.famille.thibault.fr> <20070901172301.GA4275@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070901172301.GA4275@ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

Hi,

Pavel Machek, le Sat 01 Sep 2007 17:23:02 +0000, a =E9crit :
> Hi!
>=20
> > > > Because userland only begins quite late in the boot process, and
> > > > userland may hang.
> > >=20
> > > Initrd means userland is started very early on most machines these
> > > days, and kernel may hang, too.
> >=20
> > Very early is not so early, and loading initrd itself may actually fa=
il.
> > The kernel may indeed hang, but there are more chances to get some
> > messages before the hang.  Don't _you_ have a VGA screen for getting
> > earliest failure messages from the kernel?
>=20
> No. I'm using framebuffer, that's initialized quite late in boot
> process. Plus many users just use bootsplash. I do use vga mode for
> heavy debugging, but that's quite unusual.

But that's what some people do for their work, so they need it.

> So... you actually have speech-enabled grub/lilo/something?

That's in project too (and there's no reason it shouldn't be done).

Samuel
