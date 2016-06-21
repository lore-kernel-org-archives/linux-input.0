From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS mode
Date: Tue, 21 Jun 2016 07:42:13 -0700
Message-ID: <CAD8Lp44NHiSfPjzYkPCm1jX1Jb2E071WY4_OdCpJv0H7ivEoSg@mail.gmail.com>
References: <1465306449-28256-1-git-send-email-chiu@endlessm.com>
	<20160620174251.GC22426@dtor-ws>
	<008601d1cbba$124c2230$36e46690$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:32830 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbcFUOm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 10:42:27 -0400
Received: by mail-io0-f175.google.com with SMTP id t74so17759588ioi.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 07:42:18 -0700 (PDT)
In-Reply-To: <008601d1cbba$124c2230$36e46690$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Chiu <chiu@endlessm.com>, Charlie Mooney <charliemooney@chromium.org>, Michele Curti <michele.curti@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

On Tue, Jun 21, 2016 at 6:40 AM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@e=
mc.com.tw> wrote:
> KT, is this feasible?
> [KT] After internal discussion, we don't agree this patch.
>     It's a work-around to fix firmware bug for specific touchpad and =
not
> tested by other device.

=46or better or worse, Linux often takes on the responsibility of
working around firmware bugs. This is a real issue that affects
multiple Asus laptops; you'll have no touchpad input upon reboot from
any OS that drives the touchpad in "generic hid" mode (e.g. older
version of Linux, some embedded OS, etc).

If the sleep is really that controversial, we could make it specific
to the ELAN1000 model that is the one in question here?

Thanks
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
