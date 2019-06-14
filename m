From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
Date: Fri, 14 Jun 2019 15:36:03 +0200
Message-ID: <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
 <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com> <5346893.KeHrH3GHoD@linux-lf90.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5346893.KeHrH3GHoD@linux-lf90.site>
Sender: linux-kernel-owner@vger.kernel.org
To: wbauer1@a1.net
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Wolfgang,

On Thu, Jun 13, 2019 at 1:49 PM Wolfgang Bauer <wbauer@tmo.at> wrote:
>
> On Tuesday, 11. Juni 2019, 16:42:37 Benjamin Tissoires wrote:
> > On Tue, Jun 11, 2019 at 2:13 PM Nicolas Saenz Julienne
> >
> > <nsaenzjulienne@suse.de> wrote:
> > > NOTE: I CC'd Wolfgang as he's the one who can test this.
> >
> > I'll wait for Wolfram to confirm that the patch works before pushing then.
>
> My name is Wolfgang, not Wolfram... ;-)

ouch, sorry for that (I am more used to talk to the I2C maintainer apparently)

> But never mind.
>
> I tested the patch meanwhile on top of kernel 5.2.rc4, where the mouse wheel
> actually worked.

Actually, I am a little bit lost here.

The patch mentions a fix of c01908a14bf73, which is in 5.1 final.
So if your mouse works in 5.2.rc4, I am not sure how
HID-a4tech-fix-horizontal-scrolling.patch could break it.

Could you be slightly more specific in what "works" and what doesn't?

Do we have the report descriptors available somewhere?
And if not, could you run hid-recorder from
https://gitlab.freedesktop.org/libevdev/hid-tools and attach the logs
when you move the horizontal wheel?

Cheers,
Benjamin

> As the patch didn't apply cleanly (it's obviously based upon
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=abf82e8f7e9af40a49e3d905187c662a43c96c8f , called "HID-
> a4tech-fix-horizontal-scrolling.patch" below), I added that patch as well.
>
> My results:
> kernel 5.2.rc4 works
> kernel 5.2.rc4 + HID-a4tech-fix-horizontal-scrolling.patch is broken
> kernel 5.2.rc4 + HID-a4tech-fix-horizontal-scrolling.patch +
> HID-input-fix-a4tech-horizontal-wheel-custom-usage.patch (i.e. this patch)
> works again
>
> kernel 5.2.rc4 + HID-input-fix-a4tech-horizontal-wheel-custom-usage.patch
> works as well.
>
> So AFAICT this patch seems to be fine.
>
> For completeness, this is my mouse as listed by lsusb:
> Bus 003 Device 002: ID 09da:000a A4Tech Co., Ltd. Optical Mouse Opto 510D /
> OP-620D
>
> Kind Regards,
> Wolfgang
>
