From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Mon, 23 Jan 2012 23:54:30 -0800
Message-ID: <20120124075430.GA9775@core.coreip.homeip.net>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
 <CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35639 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab2AXHyh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 02:54:37 -0500
Received: by iacb35 with SMTP id b35so5002587iac.19
        for <linux-input@vger.kernel.org>; Mon, 23 Jan 2012 23:54:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas wrot=
e:
> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> > Cypress TrueTouch(tm) Standard Product controllers are found in
> > a wide range of embedded devices. This driver add support for a
> > variety of TTSP controllers.
> >
> > Since the hardware is capable of tracking identifiable contacts, mu=
lti-touch
> > protocol type B (stateful) is used to report contact information.
> >
> > The driver is composed of a core driver that process the data sent =
by
> > the contacts and a set of bus specific interface modules. This patc=
h
> > adds the base core TTSP driver.
> >
> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> > ---
> >
> > Changes for v10: Fix issues called out by Dmitry Torokhov
> > =A0 =A0 =A0 =A0- Remove use_sleep and put device to sleep unconditi=
onally on suspend
> > =A0 =A0 =A0 =A0- Cleanup cyttsp_power_on() and remove cyttsp_bl_app=
_valid() function
> >
> > =A0drivers/input/touchscreen/Kconfig =A0 =A0 =A0 | =A0 31 ++
> > =A0drivers/input/touchscreen/Makefile =A0 =A0 =A0| =A0 =A03 +
> > =A0drivers/input/touchscreen/cyttsp_core.c | =A0682 +++++++++++++++=
++++++++++++++++
> > =A0drivers/input/touchscreen/cyttsp_core.h | =A0141 +++++++
> > =A0include/linux/input/cyttsp.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 68 +++
> > =A05 files changed, 925 insertions(+), 0 deletions(-)
>=20
> Hello Dmitry,
>=20
> Any comments on this version?

Looking at it... If you do not hear from me by Wednesday please ping
me again.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
