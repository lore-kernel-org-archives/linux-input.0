From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Sat, 18 Jun 2016 21:45:34 +0200
Message-ID: <20160618194534.GI24234@mail.corp.redhat.com>
References: <1466196443.21223.1.camel@gmail.com>
 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
 <20160617211142.GH24234@mail.corp.redhat.com>
 <1466275994.2669.11.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbcFRTpj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 15:45:39 -0400
Content-Disposition: inline
In-Reply-To: <1466275994.2669.11.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Jun 18 2016 or thereabouts, Dennis Chen wrote:
> On Fri, 2016-06-17 at 23:11 +0200, Benjamin Tissoires wrote:
> > On Jun 17 2016 or thereabouts, Jiri Kosina wrote:
> > > This would mean that both hid-multitouch and hid-microsoft would
> > > claim=C2=A0support for this device, which isn't really going to p=
rovide
> > > consistent=C2=A0user experience. Is MT_CLS_EXPORT_ALL_INPUTS suff=
icient
> > > to provide=C2=A0complete functionality by hid-multitouch? If so, =
the
> > > support from=C2=A0hid-microsoft should be dropped.
>=20
> I find MT_CLS_EXPORT_ALL_INPUTS to make the Type Cover 3 near
> completely functional. I'll send a PATCHv2 to drop hid-microsoft
> support. However, hid-microsoft provided Caps-Lock LED control, which
> hid-multitouch does not; I'm not sure how to fix this.=C2=A0

That's the entire purpose of the series I mentioned below. It adds
the keyboard support, caps lock and multitouch, so there is nothing mor=
e
to fix once it is in. The benefit is that MT_CLS_EXPORT_ALL_INPUTS
exports far too many input devices while the series exports only the
required ones.

>=20
> > Also, please see if the series with the 2 following patches is not
> > sufficient enough:
> > http://www.spinics.net/lists/linux-input/msg44576.html
> > http://www.spinics.net/lists/linux-input/msg44577.html
> >=20
> > If you just adapt the second patch to add your ids, it should
> > hopefully be working (though the surface book is not for some unkno=
wn
> > reasons
> > yet).
>=20
> I'll test this out sometime this week, and get back to you.=C2=A0
>=20

Thanks.

Cheers,
Benjamin




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
