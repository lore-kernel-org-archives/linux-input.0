From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Sat, 25 Aug 2007 03:07:04 +0200
Message-ID: <20070825010704.GK30705@stusta.de>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <20070821130233.58faaa8a.akpm@linux-foundation.org> <20070821202251.GB3658@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070821202251.GB3658@interface.famille.thibault.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, dtor@mail.ru, Jiri
List-Id: linux-input@vger.kernel.org

On Tue, Aug 21, 2007 at 10:22:51PM +0200, Samuel Thibault wrote:
> Hi,
>=20
> Andrew Morton, le Tue 21 Aug 2007 13:02:33 -0700, a =C3=A9crit :
> > On Tue, 21 Aug 2007 02:57:18 +0200
> > Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> >=20
> > > Some external modules like Speakup need to use the PC keyboard to c=
ontrol
> > > them and also need to get keyboard feedback (caps lock status, etc.=
)
> > >=20
> > > This adds a keyboard notifier that such modules can use to get the =
keyboard
> > > events and possibly eat them, at several stages:
> >=20
> > Adding hooks for non-merged modules is considered sinful.  Making the=
se new
> > exports EXPORT_SYMBOL_GPL might ease the pain.
>=20
> That should be fine.
>=20
> I'll soon propose a notifier for the console writes too, same story.
>=20
> > Is there any prospect of getting at least one of these "external modu=
les
> > like Speakup" merged into mainline?
>=20
> I'm working on it.  The problem is that the current code quality is
> still far from mainline requirements (though improving over time).  Thi=
s
> hook (and the other one I'll post) is a step toward merging.  If these
> hooks can go mainline, then great, that will make life easier for the
> few distributions that want to provide speakup as modules.=20

How long does it take you for getting the first users submitted for=20
review? If you are working on it it should be in the order of "a few=20
months", and earlier merging would anyway gain you only one or two=20
kernel releases.

> If they
> remain in -mm for some time and people don't complain, well that's good
> too: at least we know how speakup may hook into the kernel when it gets
> merged.
>...

Without any users it's dead code noone uses, and complaints will most=20
likely not occur until you submit the first users for review...

> Samuel

cu
Adrian

BTW: Are these the speakup patches that were in -ac five years ago?

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
