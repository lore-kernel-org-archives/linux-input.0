From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Tue, 9 Feb 2010 09:05:22 +0800
Message-ID: <f17812d71002081705q7723c388re8582d1186802340@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	<f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	<bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	<bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
	<20100208113306.GN9007@buzzloop.caiaq.de> <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:8400 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0BIBFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 20:05:43 -0500
Received: by qw-out-2122.google.com with SMTP id 9so776838qwb.37
        for <linux-input@vger.kernel.org>; Mon, 08 Feb 2010 17:05:42 -0800 (PST)
In-Reply-To: <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Zyngier <maz@misterjones.org>
Cc: Daniel Mack <daniel@caiaq.de>, Jebediah Huang <jebediah.huang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 8, 2010 at 8:32 PM, Marc Zyngier <maz@misterjones.org> wrot=
e:
>> I just saw that there is indeed no support for irq line handling in =
this
>> driver. In order to use these lines as input for something like the
>> gpio_keys driver, support for that should be added. I never used thi=
s
>> driver and can't say whether it is under active development.
>
> It should be rather easy to introduce something similar to what I did=
 for
> the pca953x driver (http://patchwork.kernel.org/patch/77418/)
>
> MAX732x seems a lot saner than PCA953x, as it has at least a hardware
> interrupt mask...

Well, I'd say max732x is a chip of heavy simplification, input/output d=
irection
of each pin is normally hardcoded, depending on the chip model used, th=
ere
seems no such interrupt mask registers for SW use really.


>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M.
> --
> And if you don't know where you're going, any road will take you ther=
e...
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
