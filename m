From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 18 Jan 2012 08:02:36 +0100
Message-ID: <CABxcv==ekC0NDmiPdp6T7mBkyu46MQ456YHaRQzSr5pcG+98iQ@mail.gmail.com>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
	<20120116131424.GA6113@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57248 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab2ARHCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 02:02:37 -0500
Received: by iagf6 with SMTP id f6so5527440iag.19
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 23:02:36 -0800 (PST)
In-Reply-To: <20120116131424.GA6113@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Mon, Jan 16, 2012 at 2:14 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Javier,
>
>> Cypress TrueTouch(tm) Standard Product controllers are found in
>> a wide range of embedded devices. This driver add support for a
>> variety of TTSP controllers.
>>
>> Since the hardware is capable of tracking identifiable contacts, mul=
ti-touch
>> protocol type B (stateful) is used to report contact information.
>>
>> The driver is composed of a core driver that process the data sent b=
y
>> the contacts and a set of bus specific interface modules. This patch
>> adds the base core TTSP driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>
>> Changes for v9 suggested by Henrik Rydberg:
>> =C2=A0 =C2=A0 - Simplify cyttsp_bl_app_valid() function
>> =C2=A0 =C2=A0 - Remove retry logic since is already done in ttsp[rea=
d | write]_block_data
>>
>> =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 31 ++
>> =C2=A0drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A03 +
>> =C2=A0drivers/input/touchscreen/cyttsp_core.c | =C2=A0703 ++++++++++=
+++++++++++++++++++++
>> =C2=A0drivers/input/touchscreen/cyttsp_core.h | =C2=A0141 ++++++
>> =C2=A0include/linux/input/cyttsp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 69 +++
>> =C2=A05 files changed, 947 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/input/touchscreen/cyttsp_core.c
>> =C2=A0create mode 100644 drivers/input/touchscreen/cyttsp_core.h
>> =C2=A0create mode 100644 include/linux/input/cyttsp.h
>
> Looks reasonable now, so
>
> =C2=A0 =C2=A0Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
>
> Thanks for your patience.
>
> Henrik

Hello Dmitry,

Any comments on this version of the patch-set?

Thanks a lot and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
