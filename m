From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Mon, 27 Aug 2007 16:59:12 +0200
Message-ID: <20070827145912.GB3268@implementation.ifsic.univ-rennes1.fr>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <20070821130233.58faaa8a.akpm@linux-foundation.org> <20070821202251.GB3658@interface.famille.thibault.fr> <20070825010704.GK30705@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070825010704.GK30705@stusta.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Adrian Bunk <bunk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, dtor@mail.ru, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi,

Adrian Bunk, le Sat 25 Aug 2007 03:07:04 +0200, a =E9crit :
> > If they
> > remain in -mm for some time and people don't complain, well that's go=
od
> > too: at least we know how speakup may hook into the kernel when it ge=
ts
> > merged.
> >...
>=20
> Without any users it's dead code noone uses,

Not so much dead: the notify chain will get called anyway, taking
spinlocks, etc. even if nothing is really called.  And people can see
the patches and complain if they think they're bad.

> BTW: Are these the speakup patches that were in -ac five years ago?

No, they are some rework of the way Speakup glues into the kernel.

Samuel
