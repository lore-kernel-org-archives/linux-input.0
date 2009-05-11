From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] Input: add MAX7359 key switch controller driver, v2
Date: Mon, 11 May 2009 11:34:54 +0900
Message-ID: <4d34a0a70905101934j320c03abl7e39af4fbfdf1f62@mail.gmail.com>
References: <4A04E5EA.7000103@samsung.com> <5d5443650905091027w2b60f2ael520373790e6414c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f129.google.com ([209.85.221.129]:36005 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbZEKCfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2009 22:35:15 -0400
In-Reply-To: <5d5443650905091027w2b60f2ael520373790e6414c7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi Trilok,

On Sun, May 10, 2009 at 2:27 AM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Kim,
>
> On Sat, May 9, 2009 at 7:39 AM, Kim Kyuwon <q1.kim@samsung.com> wrote=
:
>> The Maxim MAX7359 is a I2C interfaced key switch controller which pr=
ovides
>> microprocessors with management of up to 64 key switches.
>> This patch adds support for the MAX7359 key switch controller.
>>
>> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
>
>
> Thanks for implementing review comments. Please add
>
> Reviewed-by: Trilok Soni <soni.trilok@gmail.com>

Sorry, I didn't know I should put the "Reviewed-by" in the reviewed
patch.(I'm still kernelnewbie :) ) If possible, I want Dmitry to add
"Reviewed-by" when he sends this driver to mainline, or I will send
new patch again.

Thanks again for you reviewing.

Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
