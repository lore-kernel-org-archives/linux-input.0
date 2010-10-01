From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 01 Oct 2010 13:20:39 -0600
Message-ID: <4CA6C12702000023000212DE@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Carlos,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2010-10-01 =E6=96=BC 19:16 +0100=EF=BC=8CCa=
rlos Corbacho =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday 01 October 2010 14:51:27 Lee, Chun-Yi wrote:
> > Add acer wmi hotkey event support. Install a wmi notify handler to
> > transfer wmi event key to key code, then send out keycode through a=
cer
> > wmi input device to userland.
>=20
> What hardware is this for? Up to now, all Acer hardware I'm aware of =
has=20
> always sent key codes. This and the other patch seem to be for someth=
ing=20
> that's quite different to the current batch of hardware supported by =
acer-wmi?
>=20

The hardware is Acer TravelMate 8572, the machine send out key code:
volume up/down, mute, brightness up/down=20
So, the above hotkeys work fine.

But, it send out wmi event for:=20
wifi key (the same with communication key), P key (a special program
key), touchpad, video mode switch.=20

My patch work for translate those wmi event to key code.


Thank's
Joey Lee
