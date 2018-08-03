From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date: Fri, 3 Aug 2018 09:53:27 -0700
Message-ID: <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com> <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000f2463305728ac487"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: m.szyprowski@samsung.com, Ravi Chandra Sadineni <ravisadineni@google.com>, Dmitry Torokhov <dtor@google.com>, Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--000000000000f2463305728ac487
Content-Type: text/plain; charset="UTF-8"

Understood. I am trying to reproduce this issue locally. Wanted to know the
version of the kernel so I can give a try.  Marek, can you please confirm
the kernel version.

Thanks,


On Fri, Aug 3, 2018 at 9:08 AM Dmitry Torokhov <dmitry.torokhov@gmail.com>
wrote:

> On Fri, Aug 3, 2018 at 8:51 AM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
> >
> > Hi Marek,
> >
> > Can you please give me little more context ? Snow is still on 3.8.11.
> This patch is not backported to 3.8.11. Are you trying to flash a different
> kernel  on snow?
> >
>
> Ravi, from upstream perspective what kernel Google uses when shipping
> Snow is completely immaterial. Mainline is supposed to work equally
> well on all devices.
>
> Thanks.
>
> --
> Dmitry
>

--000000000000f2463305728ac487
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Understood. I am trying to reproduce this issue locally. W=
anted to know the version of the kernel so I can give a try.=C2=A0=C2=A0<sp=
an style=3D"color:rgb(80,0,80)">Marek, can you please confirm the kernel ve=
rsion.</span><br><br>Thanks,<div><br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">On Fri, Aug 3, 2018 at 9:08 AM Dmitry Torokhov &lt;<a=
 href=3D"mailto:dmitry.torokhov@gmail.com">dmitry.torokhov@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Aug 3, 2018 at 8:5=
1 AM Ravi Chandra Sadineni<br>
&lt;<a href=3D"mailto:ravisadineni@chromium.org" target=3D"_blank">ravisadi=
neni@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Marek,<br>
&gt;<br>
&gt; Can you please give me little more context ? Snow is still on 3.8.11. =
This patch is not backported to 3.8.11. Are you trying to flash a different=
 kernel=C2=A0 on snow?<br>
&gt;<br>
<br>
Ravi, from upstream perspective what kernel Google uses when shipping<br>
Snow is completely immaterial. Mainline is supposed to work equally<br>
well on all devices.<br>
<br>
Thanks.<br>
<br>
-- <br>
Dmitry<br>
</blockquote></div>

--000000000000f2463305728ac487--
