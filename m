From: Rosen Penev <rosenp@gmail.com>
Subject: Re: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
Date: Sat, 30 Jun 2018 11:57:32 -0700
Message-ID: <CAKxU2N8HGcJer5v3vDHMnHH1gAeAhHDdNDZS-yL+a2Ung_PiNg@mail.gmail.com>
References: <20180617014216.4043-1-rosenp@gmail.com> <20180624.150445.1006140718276550233.teika@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180624.150445.1006140718276550233.teika@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: teika@gmx.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jan.steffens@gmail.com, waltercool@slash.cl
List-Id: linux-input@vger.kernel.org

On Sat, Jun 23, 2018 at 11:05 PM Teika Kazura <teika@gmx.com> wrote:
>
> Hi, Rosen. Thank you for your patch. (@Jan Steffens and @Pablo Cholaky: T=
hanks for your reports.) But I'm afraid some more work is necessary. Let me=
 propose some points.
Too much work for me. I'll just use the kernel pareameter.
>
> I'm not a kernel developer, but have been working on this issue to help t=
hem. (See https://www.spinics.net/lists/linux-input/msg55950.html )
>
> 0.
> Could you resend it, cc-ing to the relevant developers. (Use the one of m=
y reply here. You can use <kernel src tree>/scripts/get_maintainer.pl next =
time.) Otherwise, it is unlikely to be noticed by them.
>
> 1.
> You added your device to forcepad_pnp_ids[], but I guess it should be smb=
us_pnp_ids[].
>
> When making the patch again, please use the kernel 4.17 or newer, because=
 smbus_pnp_ids was changed recently.
>
> If it works by using smbus_pnp_ids, please test it for a week or so, espe=
cially making sure that suspend/resume works without any problem.
>
> 2.
> Though it's my personal impression, the change description looked somewha=
t personal. At the same time, it's important, guaranteeing the stability of=
 the patch.- I know you originally reported it last August [1]. Furthermore=
, there have been two other users [2] who reported SMBus worked for the sam=
e device, namely SYN1219. (They two are cc-ed to in this reply.)
>
> You can use "$ git format-patch --cover-letter"; it will generate a "cove=
r-letter", the introductory part of the patch, explaining the acceptability=
 of the patch to kernel developers. (For an example, see https://www.spinic=
s.net/lists/linux-input/msg57041.html)
>
> So the full description can be given in the cover letter, and the real pa=
tch description can be something like "This enables SMBus for xxx", being a=
lmost identical to the email subject.
>
> 3. This is not essential, but the style of the email subject that the dev=
ice maintainer prefers might be:
> ------------------------------------------------------------------------
> [PATCH v2] Input: synaptics - Enable RMI4 for Clevo P870DM laptops
> ------------------------------------------------------------------------
> after looking at this tree [3]. ("v2" meaning version 2, due to the above=
 change.) You can feed "--subject-prefix=3D'PATCH v2'" to "$ git format-pat=
ch".
>
> 4. If you want to give the credit for my reply, you can add
> ------------------------------------------------------------------------
> Suggested-by: Teika Kazura <teika@gmx.com>
> ------------------------------------------------------------------------
> after Signed-off-by. It's completely ok without it. :-)
>
> [1] https://marc.info/?l=3Dlinux-input&m=3D150284057602358&w=3D2
> [2] https://marc.info/?l=3Dlinux-input&m=3D150049625613055&w=3D2
>     https://marc.info/?l=3Dlinux-input&m=3D150094561111026&w=3D2
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/
>
> Best regards,
> Teika (Teika kazura)
>
>
> From: Rosen Penev <rosenp@gmail.com>
> Subject: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
> Date: Sat, 16 Jun 2018 18:42:16 -0700
>
> > I have been testing this for half a year with no issues to report.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/syna=
ptics.c
> > index 55d33500d55e..23f5bb2cf9da 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] =3D {
> >  };
> >
> >  static const char * const forcepad_pnp_ids[] =3D {
> > +     "SYN1219",
> >       "SYN300D",
> >       "SYN3014",
> >       NULL
> > --
> > 2.17.1
> >
