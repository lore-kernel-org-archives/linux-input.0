From: Cedric Sodhi <manday@gmx.net>
Subject: Re: Rotation Sensor in EEE Slate
Date: Mon, 21 May 2012 21:01:04 +0000
Message-ID: <20120521210104.GA3945@slate.Speedport_W723_V_Typ_A_1_00_092>
References: <20120521184502.GA1926@engine.Speedport_W723_V_Typ_A_1_00_092>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36123 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753314Ab2EUTDi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 15:03:38 -0400
Content-Disposition: inline
In-Reply-To: <20120521184502.GA1926@engine.Speedport_W723_V_Typ_A_1_00_092>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

> On 18/05/12 11:49, Cedric Sodhi wrote:
> > Hello everyone,
> >=20
> > my EEE Slate Tablet PC just returned from repairs where it had Wind=
ows
> > reinstalled. This enables me to verify that it actually *does* have=
 a
> > rotation sensor - something, of which I had not been so certain sin=
ce I
> > installed Linux, because I found no trace of any such device on the=
 PCI
> > Bus(ses).
> >=20
> > Windows Shows "Asus G Sensor", Location "Unknown". Before I go abou=
t
> > uninstalling Windows, is there any more information I could try to
> > obtain? Do you have any idea how to get this sensor working in Linu=
x?
> Hi,
> This is a bit a shot in the dark, but I've seen that there are some
> x86 Asus tablets which got android support. Apparently the
> accelerometer support is done via an extension to the "asus-laptop"
> module (which work via special ACPI interfaces). See:
> https://github.com/rbraken/wetab-ICS-device-tree/blob/master/kernel_m=
ods/asus-laptop/asus-laptop.c
>=20
> Maybe your hardware has the same/similar interface to the
> accelerometer. For a quick look, you could try to strings/disassemble
> the ACPI tables and look for a method like "XLRX".
>=20
> Well, all said, none of this requires Windows, sorry ;-)
>=20
> Good luck!
> =C9ric

Thank you for the suggestions but I did not get far with that. The patc=
h
to asus-laptp.c is far over my head, but I have the vague idea that it
does not make the sensor any more known to my OS than it currently is.

There really is absolutely no trace of any sensor anywhere where I'd
understand it. Again, I'm no match for ACPI tables - my pathetic attemp=
t
to grep for "sensor" in the disassembled tables failed as expected.

I also tried to grep for XLRX in the DSDT, but there was no match.

Thanks though
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
