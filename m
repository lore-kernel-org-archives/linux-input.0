From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Date: Thu, 3 Jan 2019 12:27:39 -0600
Message-ID: <CAL_JsqLoyQDzyhFvXn=DEucdh-9uwvrcXBK38izeGPdQsuv=Zw@mail.gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com> <20181228224707.GA7218@bogus>
 <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQ6iO5bSUkSuPOUXMy46W1kENqg3ev=i+75459wfWAhfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, xc-racer2@live.ca, Simon Shields <simon@lineageos.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 28, 2018 at 4:52 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 28, 2018 at 2:47 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 28 Dec 2018 16:46:07 +0100, =3D?UTF-8?q?Pawe=3DC5=3D82=3D20Chmi=
el?=3D wrote:
> > > From: Jonathan Bakker <xc-racer2@live.ca>
> > >
> > > Document new optional property for setting custom keycodes.
> > >
> > > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > > Changes from v1:
> > >   - Because key codes could be bigger than 255, use ints for keycodes
> > > ---
> > >  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++=
++
> > >  1 file changed, 4 insertions(+)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Shouldn't this be "linux,keycodes" though?

Sigh, yes.

Rob
