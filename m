From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Thu, 12 Jul 2007 19:19:32 +0000
Message-ID: <20070712191932.GA3947@ucw.cz>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr> <20070821204951.GC3658@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070821204951.GC3658@interface.famille.thibault.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Engelhardt <jengelh@computergmbh.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Tue 2007-08-21 22:49:51, Samuel Thibault wrote:
> Hi,
>=20
> Jan Engelhardt, le Tue 21 Aug 2007 22:42:24 +0200, a =E9crit :
> > >- keycodes: even before translation into keysym.
> >=20
> > They can use the raw xlation for that.
>=20
> For userland, yes.  This is for kernel modules.

And should speakup be a kernel module? Why?

It looks doable from userland:

/dev/vcsa tells you what is on screen. Maybe you need to add poll()
support?

/dev/input allows you to get keys pressed.

What is missing? Yes, you may want to do a small kernel module to read
kernel bootup messages. Anything more?
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
