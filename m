From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Sat, 1 Sep 2007 14:51:20 +0200
Message-ID: <20070901125120.GC3251@implementation.famille.thibault.fr>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr> <20070821204951.GC3658@interface.famille.thibault.fr> <20070712191932.GA3947@ucw.cz> <20070901122604.GA3251@implementation.famille.thibault.fr> <20070901123258.GA4612@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070901123258.GA4612@ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

Hi,

Pavel Machek, le Sat 01 Sep 2007 12:32:58 +0000, a =E9crit :
> > > > > They can use the raw xlation for that.
> > > >=20
> > > > For userland, yes.  This is for kernel modules.
> > >=20
> > > And should speakup be a kernel module? Why?
> >=20
> > Because userland only begins quite late in the boot process, and
> > userland may hang.
>=20
> Initrd means userland is started very early on most machines these
> days, and kernel may hang, too.

Very early is not so early, and loading initrd itself may actually fail.
The kernel may indeed hang, but there are more chances to get some
messages before the hang.  Don't _you_ have a VGA screen for getting
earliest failure messages from the kernel?

> > > What is missing? Yes, you may want to do a small kernel module to r=
ead
> > > kernel bootup messages.
> >=20
> > That's what it's all about.
>=20
> But this small module should not need keyboard leds support, as those a=
re not used during
> boot. If all you want is to read kernel bootup messages, you should
> just register a special console. Actually serial console should do.

The problem is that using both a tool for early message and for later
messages is not particularly handy, that's why speakup is actually
used by people both for boot time and afterwards.  People are indeed
considering moving speakup into userland, but some people still _need_
speakup in the kernel for their everyday work.  Having two versions of
speakup (user and kernel) is just asking for more maintain work, and it
happens that speakup already doesn't have many people involved...

Samuel
