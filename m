From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao
	<fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH v2] HID: add support for Sony RF receiver with USB
 product id 0x0374
Date: Wed, 01 May 2013 09:25:06 +0900
Message-ID: <1367367906.4712.4.camel@nexus>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>
	  <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>
	  <50F52986.2080002@lab.ntt.co.jp>
	 <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>
	 <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:46002 "EHLO
	tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933881Ab3EAAZU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Apr 2013 20:25:20 -0400
In-Reply-To: <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

Hi Jiri,

On Tue, 2013-01-15 at 17:02 +0100, Jiri Kosina wrote:
> On Tue, 15 Jan 2013, Fernando Luis V=C3=A1zquez Cao wrote:
>=20
> > Some Vaio desktop computers, among them the VGC-LN51JGB multimedia =
PC, have
> > a RF receiver, multi-interface USB device 054c:0374, that is used t=
o connect
> > a wireless keyboard and a wireless mouse.
> >=20
> > The keyboard works flawlessly, but the mouse (VGP-WMS3 in my case) =
does not
> > seem to be generating any pointer events. The problem is that the m=
ouse pointer
> > is wrongly declared as a constant non-data variable in the report d=
escriptor
> > (see lsusb and usbhid-dump output below), with the consequence that=
 it is
> > ignored by the HID code.
> >=20
> > Add this device to the have-special-driver list and fix up the repo=
rt
> > descriptor in the Sony-specific driver which happens to already hav=
e a fixup
> > for a similar firmware bug.
>=20
> Applied, thanks.

It looks like after the merge of the the sony and steelseries
branches the hid core hunk was left out, which means that
this fix-up is never applied.

I will be replying to this email with a fix.

Thanks,
=46ernando

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
