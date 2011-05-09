From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] Atari input patches
Date: Mon, 9 May 2011 09:10:17 +0200
Message-ID: <BANLkTi=CMAJrkAsKP4_QEaDVSw8Cz_RJfQ@mail.gmail.com>
References: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
	<20110509060048.GA27577@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60852 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1EIHKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2011 03:10:19 -0400
In-Reply-To: <20110509060048.GA27577@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, May 9, 2011 at 08:00, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
> On Sun, May 08, 2011 at 11:17:24AM +0200, Geert Uytterhoeven wrote:
>> Here are 3 patches to fix keyboard and mouse on Atari, after convers=
ion to
>> the "new" (several years old) input framework.
>>
>> =C2=A0 [1/3] input/atari: Use the correct mouse interrupt hook
>> =C2=A0 [2/3] input/atari: Fix atarimouse init
>> =C2=A0 [3/3] input/atari: Fix mouse movement and button mapping
>>
>> Will you take them for 2.6.40, or can I get them in through my m68k =
tree?
>
> I can either take them or you can push them. I do not really have a
> preference. There is nothing in my tree that would conflict with thes=
e
> as far as I know.

In that case I'll push them myself. Thx again!

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
