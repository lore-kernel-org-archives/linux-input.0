From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] HID: add support for PenMount dual-touch panel
Date: Thu, 28 Apr 2011 16:58:01 +0200
Message-ID: <BANLkTi=7_qi7OPnToa1Pta5Eq2-M7Rc0QA@mail.gmail.com>
References: <1303291155-3148-1-git-send-email-salt@salt.com.tw>
	<20110420094700.GA2258@polaris.bitmath.org>
	<BANLkTin7Q3fD3vg90qCk12MGaVEvLBe0Mg@mail.gmail.com>
	<20110420100759.GA2436@polaris.bitmath.org>
	<alpine.LNX.2.00.1104211115570.12035@pobox.suse.cz>
	<BANLkTinND+uw=JYS4WbwNLAX8P5SF1VGqw@mail.gmail.com>
	<20110421115843.GA7837@polaris.bitmath.org>
	<BANLkTimku6reQpkNZ9-WUvhvv0pm+gSrSg@mail.gmail.com>
	<BANLkTi=XZ+VHP8bpDy3yuovi=kM2va3J2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51558 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969Ab1D1O6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 10:58:04 -0400
Received: by wwa36 with SMTP id 36so3215652wwa.1
        for <linux-input@vger.kernel.org>; Thu, 28 Apr 2011 07:58:03 -0700 (PDT)
In-Reply-To: <BANLkTi=XZ+VHP8bpDy3yuovi=kM2va3J2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, PenMount <penmount.touch@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, PenMount <salt@salt.com.tw>

Hi Richard,

On Thu, Apr 28, 2011 at 16:16, Richard Nauber
<richard.nauber@googlemail.com> wrote:
> Pardon my latency,
> but I was busy during the holidays...
>
> Benjamin, is my testing still required? I could give the patch a try

Well, Henrik made the tests for us. But you can still give a try (I
don't remember which device Henrik had).

> on this beauty:
> Bus 002 Device 002: ID 0eef:480e D-WAV Scientific Co., Ltd
> when it is needed. But I see that your new patches are already
> accepted by Jiri and a breakage on my device is not very likely,
> right?!

Yep, the patch has already been accepted. But if it's not working, we
can still re-patch on top of it ;-)

Cheers,
Benjamin

>
> Greetings,
> Richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
