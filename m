From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3 RESEND] mfd: tc3589x: Reform device tree probing
Date: Thu, 23 Jan 2014 15:11:23 +0000
Message-ID: <20140123151123.GE8586@lee--X1>
References: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
 <20140123133141.GD8586@lee--X1>
 <CACRpkdZjRG=cmWHmmFNS+=guCwQoFpu8T3r4YHr6t_XihvmaWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:50538 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaAWPLa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 10:11:30 -0500
Received: by mail-we0-f173.google.com with SMTP id t60so1319216wes.32
        for <linux-input@vger.kernel.org>; Thu, 23 Jan 2014 07:11:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdZjRG=cmWHmmFNS+=guCwQoFpu8T3r4YHr6t_XihvmaWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>

> > Patch looks good to me. Is there any reason why we should rush this=
 in
> > for v3.14, or is it okay to go to -next?
>=20
> No rush, but it's been on review like forever so unless there is
> some noise from the DT people at -rc1 I'd be very happy if you
> could apply patches 1 & 2 by then.

I'm just waiting for their Ack. If I don't have it soon I'll review it
myself and any changes will have to come in via subsequent patch
submissions.

I think it's sensible to head for v3.15 for this set.

> The third one can be applied out-of-order to the input tree after
> that.

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
