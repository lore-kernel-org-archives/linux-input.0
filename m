From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Tue, 21 Aug 2007 22:22:51 +0200
Message-ID: <20070821202251.GB3658@interface.famille.thibault.fr>
References: <20070821005718.GD3658@interface.famille.thibault.fr> <20070821130233.58faaa8a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070821130233.58faaa8a.akpm@linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, dtor@mail.ru, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi,

Andrew Morton, le Tue 21 Aug 2007 13:02:33 -0700, a =E9crit :
> On Tue, 21 Aug 2007 02:57:18 +0200
> Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
>=20
> > Some external modules like Speakup need to use the PC keyboard to con=
trol
> > them and also need to get keyboard feedback (caps lock status, etc.)
> >=20
> > This adds a keyboard notifier that such modules can use to get the ke=
yboard
> > events and possibly eat them, at several stages:
>=20
> Adding hooks for non-merged modules is considered sinful.  Making these=
 new
> exports EXPORT_SYMBOL_GPL might ease the pain.

That should be fine.

I'll soon propose a notifier for the console writes too, same story.

> Is there any prospect of getting at least one of these "external module=
s
> like Speakup" merged into mainline?

I'm working on it.  The problem is that the current code quality is
still far from mainline requirements (though improving over time).  This
hook (and the other one I'll post) is a step toward merging.  If these
hooks can go mainline, then great, that will make life easier for the
few distributions that want to provide speakup as modules.  If they
remain in -mm for some time and people don't complain, well that's good
too: at least we know how speakup may hook into the kernel when it gets
merged.

Working on braille support is also in my plan BTW.

Samuel
