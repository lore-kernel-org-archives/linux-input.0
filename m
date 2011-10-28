From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: Linux USB HID should ignore values outside Logical
 Minimum/Maximum range
Date: Fri, 28 Oct 2011 21:27:00 +0200
Message-ID: <1319830020.3467.7.camel@lovely>
References: <op.v3q34la3dsdv5o@localhost> <1319476183.3210.12.camel@lovely>
	 <20111024203204.GA31721@core.coreip.homeip.net>
	 <alpine.LNX.2.00.1110281817380.3541@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53741 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1J1TT0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 15:19:26 -0400
In-Reply-To: <alpine.LNX.2.00.1110281817380.3541@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Denilson Figueiredo de =?ISO-8859-1?Q?S=E1?= <denilsonsa@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 2011-10-28 at 18:23 +0200, Jiri Kosina wrote:
> On Mon, 24 Oct 2011, Dmitry Torokhov wrote:
>=20
> > While input core does not clam or validate the values reported by t=
he=20
> > driver it might make sense to do so in hid-input; I am not sure how=
=20
> > often these limits programmed intorrectly. Jiri i sprobably the bes=
t=20
> > person to answer this question.
>=20
> I haven't met such a device myself yet.
>=20
> On the other hand I feel like just dropping the report on the floor s=
hould=20
> be the proper thing to do.
>=20
>=20
> Christoph, how about the (untested at my side yet) patch below? It'd =
be=20
> nice if you could test with the device you are seeing the problem wit=
h and=20
> let me know.


I don't have this device and I'm not the person who started this thread=
=2E
It's Denilson Figueiredo de S=C3=A1 <denilsonsa@gmail.com> , just see a=
bove.

Denilson, please comment.

Thanks,
 -- Christoph


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
