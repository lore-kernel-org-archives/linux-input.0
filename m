From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Mon, 20 Jun 2016 11:59:34 +0200
Message-ID: <20160620095934.GN24234@mail.corp.redhat.com>
References: <1466196443.21223.1.camel@gmail.com>
 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
 <20160617211142.GH24234@mail.corp.redhat.com>
 <1466275994.2669.11.camel@gmail.com>
 <20160618194534.GI24234@mail.corp.redhat.com>
 <1466369282.15726.7.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37515 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbcFTKAv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 06:00:51 -0400
Content-Disposition: inline
In-Reply-To: <1466369282.15726.7.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Jun 19 2016 or thereabouts, Dennis Chen wrote:
> On Sat, 2016-06-18 at 21:45 +0200, Benjamin Tissoires wrote:
> >=C2=A0
> > That's the entire purpose of the series I mentioned below. It adds
> > the keyboard support, caps lock and multitouch, so there is nothing
> > more to fix once it is in. The benefit is that
> > MT_CLS_EXPORT_ALL_INPUTS exports far too many input devices while
> > the series exports only the required ones.
> >=20
>=20
> Ah. Sorry, I misunderstood.=C2=A0

no worries.

>=20
> I've tested the patches you sent. There is one major issue: the
> keyboard/touchpad no longer functions after a disconnect. However, on=
 a
> clean bootup of the Surface Pro 3, I can confirm that the keyboard
> seems fully functional, i.e. touchpad works, CAPS LOCK LED is toggled=
,
> etc.=C2=A0

When you say disconnect, you mean disconnecting the cover and
re-attaching it?=20
If so, I can't understand why it would fail with my patches but
not without. Could you send the dmesg after disconnet/reconnect
and some hid-recorder[1] trace after re-attaching the device when
the keyboard is not working?

Cheers,
Benjamin


[1] http://bentiss.github.io/hid-replay-docs/


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
