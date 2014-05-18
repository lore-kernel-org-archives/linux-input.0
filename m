From: Kieran Kunhya <kierank@obe.tv>
Subject: Re: usbhid: PicoLCD 256x64 USB error -71
Date: Sun, 18 May 2014 20:44:13 +0100
Message-ID: <CAK+ULv6XasQOcqckg4OtM+e82aotYAQ-XD0TsNn-9M7kpHP+Lg@mail.gmail.com>
References: <032001cf7156$31a75610$94f60230$@obe.tv>
	<20140518203718.5422588f@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41883 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaERToP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 15:44:15 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so4703260wev.33
        for <linux-input@vger.kernel.org>; Sun, 18 May 2014 12:44:14 -0700 (PDT)
In-Reply-To: <20140518203718.5422588f@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org

On 18 May 2014 19:37, Bruno Pr=C3=A9mont <bonbons@linux-vserver.org> wr=
ote:
> I successfully tried on:
> - Gigabyte mainboard (GA-A75M-UD2H) (USB2 & USB3 ports) [3.15-rc5, 64=
bit]
> - Acer Travelmate 66x [3.15-rc2, 32bit]
> - Commell LE-365 [3.14, 32bit]
> - IEI KINO-690S1 [3.14, 64bit]

It works fine on other machines, but not with the ASRock IMB-181D
board from time to time. Sometimes it does start correctly, however.
The behaviour is very confusing since Windows seems to work reliably.

> Did some previous kernel release work?

I have tried a selection of kernels in the 3.0 series.

> Could you provide verbose lsusb output and firmware version for your =
PicoLCD?

I will provide this information within a few days and also verify the
pins are correct.

Regards,

Kieran Kunhya
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
