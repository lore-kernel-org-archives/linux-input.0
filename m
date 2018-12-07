From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
Date: Fri, 7 Dec 2018 15:28:07 +0100
Message-ID: <CAN+gG=ErkuyRNprp0b7i93pqPH2J4Tz1KTyVJTLTmBWJV2NeVg@mail.gmail.com>
References: <20181205230336.GA23462@jelly> <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
 <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
 <20181206224605.GA27899@jelly> <20181206225619.GA34001@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206225619.GA34001@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martin.kepplinger@ginzinger.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 6, 2018 at 11:56 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 07, 2018 at 08:46:05AM +1000, Peter Hutterer wrote:
> > On Thu, Dec 06, 2018 at 10:24:11AM +0100, Benjamin Tissoires wrote:
> > > On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
> > > <martin.kepplinger@ginzinger.com> wrote:
> > > >
> > > > On 06.12.18 00:03, Peter Hutterer wrote:
> > > > > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > > > > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> > > > >
> > > > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > >
> > > > Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > >
> > > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > Dmitry, I do not think this one will conflict with the high res wheel
> > > patches, so I think it should be safe to take it through your tree.
> > > If you think it'll be an issue, I can also take it through the HID one.
> >
> > fwiw, patch was made on top of v4.20-rc5, so it shouldn't conflict.
>
> My tree is behind that ;) so I would actually prefer if Benjamin/Jiri
> would take it through their tree with my:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>

OK, thanks Dmitry.

Jiri, I have pushed this in for-4.20/upstream-fixes.

I think the branch has enough now to justify a PR towards Linus.
I believe https://patchwork.kernel.org/patch/10693337/ would be a good
material too, but OTOH, this only happens when the device fails at
probing, so maybe not so urgent.

Cheers,
Benjamin


> Thanks.
>
> --
> Dmitry
