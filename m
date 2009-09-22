From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Tue, 22 Sep 2009 08:41:36 -0300
Message-ID: <f20381800909220441l57e7b636qdb96f6528505c7c2@mail.gmail.com>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
	 <20090915042612.GB1132@core.coreip.homeip.net>
	 <f20381800909210835h66d695f2i10d95c3ed040efe7@mail.gmail.com>
	 <20090922055252.GA9658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55406 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbZIVLlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 07:41:32 -0400
Received: by yxe37 with SMTP id 37so4127445yxe.33
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 04:41:36 -0700 (PDT)
In-Reply-To: <20090922055252.GA9658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello,

2009/9/22 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Raphael,
>
>
> I don't think we need a Kconfig entry for debugging. A person who wan=
ts
> to debug such driver can easily turn on debugging manually.

Ok.

>
> We normally try to allocate all necessary resources in probe() so tha=
t
> if device is bound to a driver it should work unless it is broken. Si=
nce
> there is no way to shut off IRQs while IRQ handler is registered it d=
oes
> not make sense to have open and close if we allocate IRQ in probe().

Agreed.

>
> Please take a look at the latest version that I have in 'for-linus'
> branch in my tree on kernel.org and shout if you see something wrong.

How am I supposed to do that?

>
> Thanks.
>
> --
> Dmitry
>



--=20
Raphael Derosso Pereira
Engenheiro de Computa=E7=E3o
msn: rderossopereira@hotmail.com
Skype: rderossopereira
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
