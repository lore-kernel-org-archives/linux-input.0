From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Fri, 4 Dec 2009 10:42:53 -0500
Message-ID: <9e4733910912040742y251d9fddr254260a328683c88@mail.gmail.com>
References: <BDodf9W1qgB@lirc> <4B14EDE3.5050201@redhat.com>
	 <4B1524DD.3080708@redhat.com> <4B153617.8070608@redhat.com>
	 <A6D5FF84-2DB8-4543-ACCB-287305CA0739@wilsonet.com>
	 <4B17AA6A.9060702@redhat.com>
	 <20091203175531.GB776@core.coreip.homeip.net>
	 <20091203163328.613699e5@pedra>
	 <20091204100642.GD22570@core.coreip.homeip.net>
	 <20091204121234.5144836b@pedra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20091204121234.5144836b@pedra>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jarod Wilson <jarod@wilsonet.com>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Fri, Dec 4, 2009 at 9:12 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
>> In-kernel decoding:
>>

[IR physical device] =3D> [IR receiver driver] =3D> [LIRC core] =3D>
[decoder] =3D> [IR core] =3D> [input core] =3D> [evdev]
                                                  ||
                                                   =3D> [Lirc API devic=
e]>>
>> Hardware decoder:
>> [IR physical device] =3D> [IR receiver driver] =3D> [IR core]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0=3D> [input core] =3D> [evdev]

My hope is that 90% of users can achieve "just works" via these two
models. There will need to be several default device/keymaps installed
to avoid the need to configure. For example, have udev install a
default map from Motorola DVR IR to Linux keycodes. Installing that
map creates a new evdev device.  Myth can then look for that device by
default and listen to it. Now the user just needs to set their
programmable remote to send Motorola DVR and everything should "just
work". Pick similar default maps/evdev device for music players and
home automation. Sophisticated users can change these default maps by
editing the udev scripts.

Long term the goal is to get IR profiles for Linux DVR, music player,
home automation, etc in to the IR database. Then we won't have to
override the profile for another company's device.

I believe it is a requirement to send the decoded IR events up to user
space (EV_IR). That would handle the case of the air conditioner
remote. It also allows construction of an app that automatically
searches the IR database for mapping tables. Normal apps would just
ignore these events.

Installing a map is what triggers the creation of another evdev
device. There should be one evdev device per map installed. The
current input API design does not provide for a way to do this.

The only solution I see to automatic device creation is to monitor
unmapped EV_IR events and search for them in the IR database. When a
match is found, install the map from the database - which then
triggers the creation of a new evdev device and the EV_IR event won't
be unmapped any more. Searching is not a simple process since the same
IR code often appears in more than one map. Some human intervention
will probably be required.

[IR physical device] =3D> [IR receiver driver] =3D> [LIRC core] =3D>
[decoder] =3D> [IR core] =3D> [input core] =3D> [evdev]
                                                  ||
                                                            ||
                                                   =3D> [Lirc API
device]                                               =3D=3D> [EV_IR
events]

The EV_IR events also allow a user space protocol decoder to inject
those events back into the input subsystem where they will flow
through the mapping tables.

The in-kernel protocol decoders should be designed as a set of modules
with the pulse data being simultaneously supplied to all modules. That
will make it easy to work on the protocol converters - just
insmod/rmmod as you make changes. These engines can be extracted from
the LIRC code and turned into modules.

Where are IR repeat bits going to be handled?

--=20
Jon Smirl
jonsmirl@gmail.com
