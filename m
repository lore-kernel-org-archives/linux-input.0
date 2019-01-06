From: nazgul33 <nazgul33@gmail.com>
Subject: Re: [PATCH 2/2] Input: rotaty-encoder - Add DT binding document
Date: Sun, 6 Jan 2019 12:41:36 +0900
Message-ID: <CAEo1RiwW4_j8t4G9amF7NsAmri5WYaYckz5VoZsKM1=saiLEfA@mail.gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-3-nazgul33@gmail.com>
 <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Yes, it's needed.
Even with the same encoder, adjusting steps affects rate of event generatio=
n.
(the steps defines 1 cycle of encoder rotation, and 1 cycle =3D 1 key event=
.)

On Sun, Jan 6, 2019 at 8:11 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
> >
> > Add DT binding document for rotary-encoder, keycode options.
> >
> > Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> > ---
> >  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt=
 b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index f99fe5cdeaec..113640079de3 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -12,6 +12,10 @@ Optional properties:
> >  - rotary-encoder,relative-axis: register a relative axis rather than a=
n
> >    absolute one. Relative axis will only generate +1/-1 events on the i=
nput
> >    device, hence no steps need to be passed.
> > +- rotary-encoder,relative-keys : generate pair of key events. This set=
ting
> > +  behaves just like relative-axis, generating key events. keycode[2]
> > +  corresponds -1/1 events.
> > +- rotary-encoder,relative-keycodes : keycodes for relative-keys
> >  - rotary-encoder,rollover: Automatic rollover when the rotary value be=
comes
> >    greater than the specified steps or smaller than 0. For absolute axi=
s only.
> >  - rotary-encoder,steps-per-period: Number of steps (stable states) per=
 period.
> > @@ -48,3 +52,11 @@ Example:
> >                         rotary-encoder,encoding =3D "binary";
> >                         rotary-encoder,rollover;
> >                 };
> > +
> > +               rotary@2 {
> > +                       compatible =3D "rotary-encoder";
> > +                       gpios =3D <&gpio 21 0>, <&gpio 22 0>;
> > +                       rotary-encoder,relative-keys;
> > +                       rotary-encoder,relative-keycode =3D <103>, <108=
>;
> > +                       rotary-encoder,steps-per-period =3D <2>;
>
> Do you need steps for keys? They weren't required for the relative axis m=
ode.
>
> Thanks.
>
> --
> Dmitry



--=20
=ED=95=9C=EB=8F=99=ED=9B=88 =EB=93=9C=EB=A6=BC.
