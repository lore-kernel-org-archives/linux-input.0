From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Mon, 18 Oct 2010 01:25:25 -0700
Message-ID: <20101018082525.GE8655@core.coreip.homeip.net>
References: <4CBC6D60020000230002205C@novprvlin0050.provo.novell.com>
 <20101018081218.GA8655@core.coreip.homeip.net>
 <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:
> On Mon, Oct 18, 2010 at 10:12 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Oct 17, 2010 at 10:53:04PM -0600, Joey Lee wrote:
> >> +static const struct key_entry acer_wmi_keymap[] =3D {
> >> + =A0 =A0 {KE_KEY, 0x01, {KEY_WLAN} }, =A0 =A0 /* WiFi */
> >> + =A0 =A0 {KE_KEY, 0x12, {KEY_BLUETOOTH} }, =A0 =A0 =A0 /* BT */
> >> + =A0 =A0 {KE_KEY, 0x21, {KEY_PROG1} }, =A0 =A0/* Backup */
> >> + =A0 =A0 {KE_KEY, 0x22, {KEY_PROG2} }, =A0 =A0/* Aracade */
> >> + =A0 =A0 {KE_KEY, 0x23, {KEY_PROG3} }, =A0 =A0/* P_Key */
> >> + =A0 =A0 {KE_KEY, 0x24, {KEY_PROG4} }, =A0 =A0/* Social networkin=
g_Key */
> >> + =A0 =A0 {KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} }, /* Display Switc=
h */
> >> + =A0 =A0 {KE_KEY, 0x82, {KEY_F22} }, =A0 =A0 =A0/* Touch Pad On/O=
ff */
> >
> > We need to standardize this. Some people use F13/F14, here we have
> > F22...
> >
>=20
> The good thing with F* keys, is that they are already mapped in X/Qt/=
SDL/etc..
>=20
> But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
> Then bind it to XF86XK_TouchpadToggle (what's the right way to do tha=
t
> ? keymaps ?)
>=20

I wonder who the main consumers of such events will be... X application=
s
or daemons that listen turn this into some DBUS signal...

--=20
Dmitry
