From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Tue, 19 Oct 2010 03:31:16 -0600
Message-ID: <4CBE0014020000230002247A@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: tiwai@suse.de
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi all,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 11:26 +0200=EF=BC=8CTa=
kashi Iwai =E6=8F=90=E5=88=B0=EF=BC=9A
> At Mon, 18 Oct 2010 10:47:31 +0200,
> Corentin Chary wrote:
> >=20
> > On Mon, Oct 18, 2010 at 10:25 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:
> > >> On Mon, Oct 18, 2010 at 10:12 AM, Dmitry Torokhov
> > >> <dmitry.torokhov@gmail.com> wrote:
> > >> > On Sun, Oct 17, 2010 at 10:53:04PM -0600, Joey Lee wrote:
> > >> >> +static const struct key_entry acer_wmi_keymap[] =3D {
> > >> >> +     {KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> > >> >> +     {KE_KEY, 0x12, {KEY_BLUETOOTH} },       /* BT */
> > >> >> +     {KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> > >> >> +     {KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */
> > >> >> +     {KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
> > >> >> +     {KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_K=
ey */
> > >> >> +     {KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} }, /* Display Swit=
ch */
> > >> >> +     {KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */
> > >> >
> > >> > We need to standardize this. Some people use F13/F14, here we =
have
> > >> > F22...
> > >> >
> > >>
> > >> The good thing with F* keys, is that they are already mapped in =
X/Qt/SDL/etc..
> > >>
> > >> But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
> > >> Then bind it to XF86XK_TouchpadToggle (what's the right way to d=
o that
> > >> ? keymaps ?)
> > >>
> > >
> > > I wonder who the main consumers of such events will be... X appli=
cations
> > > or daemons that listen turn this into some DBUS signal...
> >=20
> > I guess xbindkeys and tools like qsynaptics should be able to consu=
me
> > such events.
> > HAL also handled some touchpads things, but now that it is deprecat=
ed, who is in
> > charge of doing that ?
>=20
> There seems no standardization forseen, but which daemon (as of local
> user) is used depends on the desktop environment.  For example, it's
> gnome-settings-daemon for GNOME.
>=20

Yes, g-s-d have a plugin to show up touchpad OSD when touchpad toggled.

And, in xkeyboard-config
currently, F22 mapped to XF86TouchpadToggle:

http://cgit.freedesktop.org/xkeyboard-config/commit/?id=3D1d05eda8dfc70=
6d6450cab5883120e0d5e1100c0


diff --git a/symbols/inet b/symbols/inet
index 7300e76..f6cd6ac 100644
--- a/symbols/inet
+++ b/symbols/inet
@@ -119,6 +119,7 @@ xkb_symbols "evdev" {

key <HNGL> { [ Hangul ] };
key <HJCV> { [ Hangul_Hanja ] };
+ key <FK22> { [ XF86TouchpadToggle ] };

// key <I120> { [ ] }; // KEY_MACRO=20
key <I126> { [ plusminus ] };


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
