From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] input/keyboard: new OpenCores Keyboard Controller
	driver
Date: Mon, 14 Sep 2009 14:02:18 -0400
Message-ID: <8bd0f97a0909141102l5fa309f4ua1bedd0f1ac99295@mail.gmail.com>
References: <1252911864-19233-1-git-send-email-vapier@gentoo.org>
	<1252950003-9451-1-git-send-email-vapier@gentoo.org> <200909141049.50705.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:38122 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbZINSKL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 14:10:11 -0400
In-Reply-To: <200909141049.50705.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <cooloney@kernel.org>

On Mon, Sep 14, 2009 at 13:49, Dmitry Torokhov wrote:
> On Monday 14 September 2009 10:40:03 am Mike Frysinger wrote:
>> +struct opencores_kbd {
>> + =C2=A0 =C2=A0 struct input_dev *input;
>> + =C2=A0 =C2=A0 struct resource *addr_res;
>> + =C2=A0 =C2=A0 struct resource *irq_res;
>> + =C2=A0 =C2=A0 unsigned short *keycode;
>> +};
>
> Why do we allocate keycode table separately form the main structure?

the double alloc looked a little funny, but i didnt dive deep into the
details.  but as you point this out, it seems to make sense to me.
any problems with that change Javier ?

i.e. we do:
struct ... { ... unsigned short keycode[NUM_KEYS]; }
rather than doing two calls to kmalloc

> I think I still have some reservations with the notion that we can ju=
st
> have exact "scancode" - KEY_* mapping and hardware producers will adj=
ust
> the hardware to follow the deriver but I guess it's OK...

considering this is a piece of "hardware" implemented in FPGAs, i
think it's ok too.  if someone really needs more flexibility, then
they're free to extend the driver and submit a patch :).
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
