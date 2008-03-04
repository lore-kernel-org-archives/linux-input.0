From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 19:50:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi>
 <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi>
 <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz> <20080304184004.GC531@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-762147138-1204656656=:15209"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:37111 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759688AbYCDSu5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 13:50:57 -0500
In-Reply-To: <20080304184004.GC531@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-762147138-1204656656=:15209
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:

> I've attached the bzipped log.

Thanks. So between these two events:

Mar  4 20:14:31 [kernel] hid-debug: input Button.0001 =3D 1
Mar  4 20:14:31 [kernel] hid-debug: input Button.0002 =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input Button.0003 =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input Button.0004 =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input Button.0005 =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input GenericDesktop.X =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input GenericDesktop.Y =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input GenericDesktop.Wheel =3D 0
Mar  4 20:14:31 [kernel] hid-debug: input Consumer.HorizontalWheel =3D 0
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report (size 6) (numbered)
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report 17 (size 5) =3D  01=
 01 00 00 00
Mar  4 20:14:32 [kernel] hid-debug: input Button.0001 =3D 1
Mar  4 20:14:32 [kernel] hid-debug: input Button.0002 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0003 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0004 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0005 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input GenericDesktop.X =3D 1
Mar  4 20:14:32 [kernel] hid-debug: input GenericDesktop.Y =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input GenericDesktop.Wheel =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Consumer.HorizontalWheel =3D 0
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report (size 4) (numbered)
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report 5 (size 3) =3D  00 =
0e 00
Mar  4 20:14:32 [kernel] hid-debug: input ff00.ff0b =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input ff00.ff0d =3D 14
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report (size 6) (numbered)
Mar  4 20:14:32 [kernel] drivers/hid/hid-core.c: report 17 (size 5) =3D  01=
 01 00 00 00
Mar  4 20:14:32 [kernel] hid-debug: input Button.0001 =3D 1
Mar  4 20:14:32 [kernel] hid-debug: input Button.0002 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0003 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0004 =3D 0
Mar  4 20:14:32 [kernel] hid-debug: input Button.0005 =3D 0

you got autorepeated Key.LeftBtn?

--=20
Jiri Kosina
SUSE Labs
--336216065-762147138-1204656656=:15209--
