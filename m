From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] HID: input: enable Totem on the Dell Canvas 27
Date: Thu, 16 Nov 2017 01:26:31 +0000
Message-ID: <7b055fc2b544421f9981f6450041df62@ausx13mpc124.AMER.DELL.COM>
References: <20171110102635.325-1-benjamin.tissoires@redhat.com>
 <20171114085043.GA29518@jelly> <20171114182610.cfqsnwj7lu2by7pu@dtor-ws>
 <20171115125326.GF403@mail.corp.redhat.com>
 <7d0ebb0aa5c74504ab43611fffe27ba6@ausx13mpc120.AMER.DELL.COM>
 <20171116010118.GA667@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171116010118.GA667@jelly>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: peter.hutterer@who-t.net
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > > I had a chat with Peter this morning. TL;DR is I'll need to rework on
> > > this more heavily to provide the final version with MT axes, and skip
> > > the single device implementation. I have no ideas if the Dell Canvas
> > > can report more than one totem, but the report descriptor would say s=
o,
> > > so we better have a proper implementation instead of having one for
> > > single device capable and one for multiple devices.
> >
> > The Canvas can only support one large totem at a time.
>=20
> that's the current version but I doubt this will remain so for the upcomi=
ng
> years. We can support one totem through the MT protocol but it'll be hard=
 to
> support multiple totems through the single touch protocol. So better safe
> than sorry.
>=20

As I'm told the limitation is a function of what Windows 10 supports. =20
