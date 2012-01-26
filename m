From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Thu, 26 Jan 2012 01:12:50 +0100
Message-ID: <CABxcv=k_e3Pdx=OaLWW-xTGoDXEQKKGWYzcLLWvZEnYBPSv6qw@mail.gmail.com>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
	<CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
	<20120124075430.GA9775@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65191 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2AZAMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jan 2012 19:12:50 -0500
Received: by iacb35 with SMTP id b35so21949iac.19
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2012 16:12:50 -0800 (PST)
In-Reply-To: <20120124075430.GA9775@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas wr=
ote:
>> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
>> <javier@dowhile0.org> wrote:
>> > Cypress TrueTouch(tm) Standard Product controllers are found in
>> > a wide range of embedded devices. This driver add support for a
>> > variety of TTSP controllers.
>> >
>> > Since the hardware is capable of tracking identifiable contacts, m=
ulti-touch
>> > protocol type B (stateful) is used to report contact information.
>> >
>> > The driver is composed of a core driver that process the data sent=
 by
>> > the contacts and a set of bus specific interface modules. This pat=
ch
>> > adds the base core TTSP driver.
>> >
>> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> > ---
>> >
>> > Changes for v10: Fix issues called out by Dmitry Torokhov
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0- Remove use_sleep and put device to sl=
eep unconditionally on suspend
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0- Cleanup cyttsp_power_on() and remove =
cyttsp_bl_app_valid() function
>> >
>> > =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 31 ++
>> > =C2=A0drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A03 +
>> > =C2=A0drivers/input/touchscreen/cyttsp_core.c | =C2=A0682 ++++++++=
+++++++++++++++++++++++
>> > =C2=A0drivers/input/touchscreen/cyttsp_core.h | =C2=A0141 +++++++
>> > =C2=A0include/linux/input/cyttsp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 68 +++
>> > =C2=A05 files changed, 925 insertions(+), 0 deletions(-)
>>
>> Hello Dmitry,
>>
>> Any comments on this version?
>
> Looking at it... If you do not hear from me by Wednesday please ping
> me again.
>
> Thanks.
>
> --
> Dmitry

ping :)

Regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
