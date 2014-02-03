From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3 RESEND] mfd: tc3589x: Reform device tree probing
Date: Mon, 3 Feb 2014 11:02:01 +0000
Message-ID: <20140203110201.GV13529@lee--X1>
References: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
 <20140123133141.GD8586@lee--X1>
 <CACRpkdZjRG=cmWHmmFNS+=guCwQoFpu8T3r4YHr6t_XihvmaWA@mail.gmail.com>
 <20140123151123.GE8586@lee--X1>
 <CACRpkdaX7AO3C-N+OMCqtQvFUmHmVRfMhPqGY2LciZQHT7iq+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:65332 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaBCLCI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 06:02:08 -0500
Received: by mail-we0-f170.google.com with SMTP id w62so2026822wes.29
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 03:02:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdaX7AO3C-N+OMCqtQvFUmHmVRfMhPqGY2LciZQHT7iq+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>

> >> > Patch looks good to me. Is there any reason why we should rush t=
his in
> >> > for v3.14, or is it okay to go to -next?
> >>
> >> No rush, but it's been on review like forever so unless there is
> >> some noise from the DT people at -rc1 I'd be very happy if you
> >> could apply patches 1 & 2 by then.
> >
> > I'm just waiting for their Ack. If I don't have it soon I'll review=
 it
> > myself and any changes will have to come in via subsequent patch
> > submissions.
> >
> > I think it's sensible to head for v3.15 for this set.
>=20
> So now that v3.14-rc1 is out can we queue this stuff?

Queued.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
