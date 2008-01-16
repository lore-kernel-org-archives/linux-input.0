From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: support for Logitech Wave
Date: Wed, 16 Jan 2008 23:00:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1836595100-1200520848=:15647"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:36936 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbYAPWAx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 17:00:53 -0500
In-Reply-To: <20080116215824.GA3797@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@welho.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Timo Aaltonen <tjaalton@cc.hut.fi>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1836595100-1200520848=:15647
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Jan 2008, Taneli V=E4h=E4kangas wrote:

> I tried the same on a Creative Prodikeys keyboard, but can't see any=20
> events for some keys (most notably none of the "piano" keys work). Is=20
> there anything that can be done to make it work?

Hi Taneli,

yes. Could you please grab reasonably recent kernel (2.6.24-rc<anything>=20
would be ok), compile it with CONFIG_HID_DEBUG, modprobe the 'hid' module=
=20
with 'debug=3D1' parameter, and send me the output from the time you connec=
t=20
the keyboard and from pressing the non-working keys? It should be trivial=
=20
to fix then.

Thanks,

--=20
Jiri Kosina
---1747641777-1836595100-1200520848=:15647--
