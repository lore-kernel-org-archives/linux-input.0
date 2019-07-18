From: Jeremy Cline <jcline@redhat.com>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
Date: Thu, 18 Jul 2019 11:46:26 -0400
Message-ID: <20190718154626.GC25351@laptop.jcline.org>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
 <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com>
 <5346893.KeHrH3GHoD@linux-lf90.site>
 <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: wbauer1@a1.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 14, 2019 at 03:36:03PM +0200, Benjamin Tissoires wrote:
> Hi Wolfgang,
> 
> On Thu, Jun 13, 2019 at 1:49 PM Wolfgang Bauer <wbauer@tmo.at> wrote:
> >
> > On Tuesday, 11. Juni 2019, 16:42:37 Benjamin Tissoires wrote:
> > > On Tue, Jun 11, 2019 at 2:13 PM Nicolas Saenz Julienne
> > >
> > > <nsaenzjulienne@suse.de> wrote:
> > > > NOTE: I CC'd Wolfgang as he's the one who can test this.
> > >
> > > I'll wait for Wolfram to confirm that the patch works before pushing then.
> >
> > My name is Wolfgang, not Wolfram... ;-)
> 
> ouch, sorry for that (I am more used to talk to the I2C maintainer apparently)
> 
> > But never mind.
> >
> > I tested the patch meanwhile on top of kernel 5.2.rc4, where the mouse wheel
> > actually worked.
> 
> Actually, I am a little bit lost here.
> 
> The patch mentions a fix of c01908a14bf73, which is in 5.1 final.
> So if your mouse works in 5.2.rc4, I am not sure how
> HID-a4tech-fix-horizontal-scrolling.patch could break it.
> 
> Could you be slightly more specific in what "works" and what doesn't?
> 

For what it's worth, at least one user has hit this issue in Fedora
starting on stable kernel v5.1.17[0] which has commit abf82e8f7e9a
("HID: a4tech: fix horizontal scrolling"). Applying this patch on top of
v5.1.18 fixed the issue for them.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1730762


Regards,
Jeremy
