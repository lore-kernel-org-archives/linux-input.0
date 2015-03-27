From: Jean Delvare <jdelvare@suse.de>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of
 mice
Date: Fri, 27 Mar 2015 16:59:29 +0100
Message-ID: <1427471969.26270.7.camel@chaos.site>
References: <1427448571.5783.41.camel@suse.de>
	 <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com>
	 <1427463666.5783.55.camel@suse.de>
	 <alpine.LNX.2.00.1503271609120.6781@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42017 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbbC0P7d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 11:59:33 -0400
In-Reply-To: <alpine.LNX.2.00.1503271609120.6781@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oneukum@suse.de>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Johan Hovold <johan@kernel.org>, linux-input <linux-input@vger.kernel.org>

Le Friday 27 March 2015 =C3=A0 16:10 +0100, Jiri Kosina a =C3=A9crit :
> On Fri, 27 Mar 2015, Oliver Neukum wrote:
> > Keeping things as is is fine by me but then I will need to add a lo=
t of=20
> > quirky devices.
>=20
> I am still surprised that all of a sudden there is such a large flow =
of=20
> new devices that need it, and we didn't have a single one a few month=
s=20
> ago.
>=20
> Given the fact that this all is being reported by single entitty, is =
it a=20
> possibility that they have some other faulty HW instead? Such as the =
HUB=20
> suspending at random incorrect points in time?

I agree, I start wondering if maybe we've been barking up the wrong tre=
e
since the beginning. I very much would like to know if all these
"faulty" mouses would be so faulty when used on a different system.

--=20
Jean Delvare
SUSE L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
