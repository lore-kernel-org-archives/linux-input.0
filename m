From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/misc: PCF8574 I2C keypad
	input device driver
Date: Tue, 9 Mar 2010 16:27:48 -0500
Message-ID: <8bd0f97a1003091327y5f5596eelb60b3c52694517b1@mail.gmail.com>
References: <20100309180906.GA19814@core.coreip.homeip.net>
	<1268168513-7431-1-git-send-email-vapier@gentoo.org> <20100309212127.GA29333@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61853 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab0CIV2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 16:28:12 -0500
Received: by gwb15 with SMTP id 15so3800779gwb.19
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 13:28:11 -0800 (PST)
In-Reply-To: <20100309212127.GA29333@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Tue, Mar 9, 2010 at 16:21, Dmitry Torokhov wrote:
> On Tue, Mar 09, 2010 at 04:01:53PM -0500, Mike Frysinger wrote:
>> From: Bryan Wu <cooloney@kernel.org>
>>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> ---
>> v2
>> =C2=A0 =C2=A0 =C2=A0 - process all feedback from Dmitry except for t=
hreaded irqs; that'll have to be done later
>
> Could I ask why? As it stands the remove() is racy WRT to a work
> running. But if you simply add cancel_work_sync() you'll risk leaving
> unbalanced enable_irq()/disable_irq().

ive never worked with threaded irq handlers before.  i'll have to read
about them before i can do the work.  i'm not suggesting you take the
driver now as is ... having it on a list in case someone else wants a
mostly-ok driver.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
