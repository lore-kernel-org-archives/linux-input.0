From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 01 Oct 2010 11:37:48 -0600
Message-ID: <4CA6A90C02000023000212D2@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: corentin.chary@gmail.com
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2010-10-01 =E6=96=BC 16:03 +0200=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> On Fri, Oct 1, 2010 at 3:51 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com=
> wrote:
> > Add acer wmi hotkey event support. Install a wmi notify handler to
> > transfer wmi event key to key code, then send out keycode through a=
cer
> > wmi input device to userland.
> >
> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
>=20
> Hi Lee,
> You'll probably want to take a look at the sparse keymap library. Usi=
ng
> it would remove a lot of code from this patch.
> Thanks
>=20

Thank's for your suggestion, I just goolge it:
 http://www.spinics.net/lists/linux-input/msg10336.html

And, you are right, it's a very good framework for keymap handler.
I will modify patch to use sparse keymap library.

I believe it already available in newest kernel.
Does it already in 2.6.32 kernel? Because I also need backport those 2
patches to 2.6.32.x kernel.


Thank's
Joey Lee
