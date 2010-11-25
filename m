From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/4] Add acer wmi hotkey events support
Date: Wed, 24 Nov 2010 18:54:53 -0700
Message-ID: <4CEE5C9D02000023000246D8@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, corentincj@iksaif.net, Takashi Iwai <tiwai@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Carios,=20

=46irst, Thank's for your review and take care. :-)

=E6=96=BC =E4=B8=89=EF=BC=8C2010-11-24 =E6=96=BC 19:28 +0000=EF=BC=8CCa=
rlos Corbacho =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wednesday 24 November 2010 17:39:36 Lee, Chun-Yi wrote:
> > Add acer wmi hotkey event support. Install a wmi notify handler to
> > transfer wmi event key to key code, then send out keycode through a=
cer
> > wmi input device to userland.
> >=20
> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > Acked-by: Dmitry Torokhov <dtor@mail.ru>
> > Acked-by: Thomas Renninger <trenn@suse.de>
> > Acked-by: Jiri Benc <jbenc@suse.cz>
>=20
> Please fix the typo. Otherwise:
>=20
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
>=20
> [..]
>=20
> > +static const struct key_entry acer_wmi_keymap[] =3D {
> > +	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> > +	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
> > +	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> > +	{KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */
>=20
> s/Aracade/Arcade/

=46ixed the typo issues, then I re-sand 1/4 patch.


Thank's a lot!
Joey Lee
