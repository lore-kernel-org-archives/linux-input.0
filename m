From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: add support for Sony RF receiver with USB product
 id 0x0374
Date: Tue, 15 Jan 2013 17:02:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>  <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>  <50F52986.2080002@lab.ntt.co.jp> <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

On Tue, 15 Jan 2013, Fernando Luis V=C3=A1zquez Cao wrote:

> Some Vaio desktop computers, among them the VGC-LN51JGB multimedia PC=
, have
> a RF receiver, multi-interface USB device 054c:0374, that is used to =
connect
> a wireless keyboard and a wireless mouse.
>=20
> The keyboard works flawlessly, but the mouse (VGP-WMS3 in my case) do=
es not
> seem to be generating any pointer events. The problem is that the mou=
se pointer
> is wrongly declared as a constant non-data variable in the report des=
criptor
> (see lsusb and usbhid-dump output below), with the consequence that i=
t is
> ignored by the HID code.
>=20
> Add this device to the have-special-driver list and fix up the report
> descriptor in the Sony-specific driver which happens to already have =
a fixup
> for a similar firmware bug.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
