From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date: Mon, 07 Jan 2019 19:53:20 +0100
Message-ID: <5195258.Y6g2Bltml4@acerlaptop>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com> <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com> <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, xc-racer2@live.ca, Simon Shields <simon@lineageos.org>
List-Id: linux-input@vger.kernel.org

Dnia czwartek, 3 stycznia 2019 19:27:39 CET Rob Herring pisze:
> On Fri, Dec 28, 2018 at 4:52 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Dec 28, 2018 at 2:47 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, 28 Dec 2018 16:46:07 +0100, =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Ch=
miel?=3D wrote:
> > > > From: Jonathan Bakker <xc-racer2@live.ca>
> > > >
> > > > Document new optional property for setting custom keycodes.
> > > >
> > > > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > > ---
> > > > Changes from v1:
> > > >   - Because key codes could be bigger than 255, use ints for keycod=
es
> > > > ---
> > > >  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 =
++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Shouldn't this be "linux,keycodes" though?
>=20
> Sigh, yes.
>=20
> Rob
I'll send v3 version with this property name fixed (both in documentation a=
nd in driver).

Thanks
