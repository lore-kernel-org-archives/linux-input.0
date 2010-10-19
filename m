From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Tue, 19 Oct 2010 03:35:48 -0600
Message-ID: <4CBE0124020000230002248C@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: corentin.chary@gmail.com, Stefan Dirsch <sndirsch@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 01:25 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:
> > On Mon, Oct 18, 2010 at 10:12 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Sun, Oct 17, 2010 at 10:53:04PM -0600, Joey Lee wrote:
> > >> +static const struct key_entry acer_wmi_keymap[] =3D {
> > >> +     {KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> > >> +     {KE_KEY, 0x12, {KEY_BLUETOOTH} },       /* BT */
> > >> +     {KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> > >> +     {KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */
> > >> +     {KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
> > >> +     {KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key =
*/
> > >> +     {KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} }, /* Display Switch =
*/
> > >> +     {KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */
> > >
> > > We need to standardize this. Some people use F13/F14, here we hav=
e
> > > F22...
> > >
> >=20
> > The good thing with F* keys, is that they are already mapped in X/Q=
t/SDL/etc..
> >=20
> > But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
> > Then bind it to XF86XK_TouchpadToggle (what's the right way to do t=
hat
> > ? keymaps ?)
> >=20
>=20
> I wonder who the main consumers of such events will be... X applicati=
ons
> or daemons that listen turn this into some DBUS signal...
>=20

As I know,
X-input will transfer the keycode to x-keycode (XF22), then mapping the
x-keycode to x-symbol (XF86XK_TouchpadToggle).
Then some daemon or userland applications can grab it.

Thank's
Joey Lee
