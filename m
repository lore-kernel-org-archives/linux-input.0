From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Sat, 1 Sep 2007 21:36:52 +0200
Message-ID: <20070901193652.GD12644@implementation>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr> <20070821204951.GC3658@interface.famille.thibault.fr> <20070712191932.GA3947@ucw.cz> <20070901122604.GA3251@implementation.famille.thibault.fr> <20070901123258.GA4612@ucw.cz> <20070901125120.GC3251@implementation.famille.thibault.fr> <20070901172301.GA4275@ucw.cz> <20070901173329.GB12644@implementation> <20070901181845.GA4839@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070901181845.GA4839@ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

Pavel Machek, le Sat 01 Sep 2007 18:18:45 +0000, a =E9crit :
> > > > Very early is not so early, and loading initrd itself may actuall=
y fail.
> > > > The kernel may indeed hang, but there are more chances to get som=
e
> > > > messages before the hang.  Don't _you_ have a VGA screen for gett=
ing
> > > > earliest failure messages from the kernel?
> > >=20
> > > No. I'm using framebuffer, that's initialized quite late in boot
> > > process. Plus many users just use bootsplash. I do use vga mode for
> > > heavy debugging, but that's quite unusual.
> >=20
> > But that's what some people do for their work, so they need it.
>=20
> How many such users are out there?

You know that it's a question that just can't be answered.  There are
such people, and their employment depend on this.

> > > So... you actually have speech-enabled grub/lilo/something?
> >=20
> > That's in project too (and there's no reason it shouldn't be done).
>=20
> I'd say kernel debugging is hard without accessible bootloader

A bootloader with only two entries is not so difficult to use blindly.

Samuel
