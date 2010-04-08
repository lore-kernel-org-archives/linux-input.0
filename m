From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [patch 3/3] Convert drivers/media/dvb/ttpci/budget-ci.c to use
	ir-core
Date: Fri, 9 Apr 2010 01:09:48 +0200
Message-ID: <20100408230948.GB18316@hardeman.nu>
References: <20100402185827.425741206@hardeman.nu> <20100402190255.774628605@hardeman.nu> <4BBE51C2.8060505@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:42416 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933775Ab0DHXJt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 19:09:49 -0400
Content-Disposition: inline
In-Reply-To: <4BBE51C2.8060505@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Thu, Apr 08, 2010 at 06:59:30PM -0300, Mauro Carvalho Chehab wrote:
>david@hardeman.nu wrote:
>> This patch converts drivers/media/dvb/ttpci/budget-ci.c to use ir-co=
re
>> rather than rolling its own keydown timeout handler and reporting ke=
ys
>> via drivers/media/IR/ir-functions.c.
>
>Hmm... had you test this patch? It got me an error here:

Sorry, I must have sent you the wrong one :)

>drivers/media/dvb/ttpci/budget-ci.c: In function =E2=80=98msp430_ir_in=
it=E2=80=99:
>drivers/media/dvb/ttpci/budget-ci.c:228: error: implicit declaration o=
f function =E2=80=98ir_input_init=E2=80=99
>drivers/media/dvb/ttpci/budget-ci.c:228: error: =E2=80=98struct budget=
_ci_ir=E2=80=99 has no member named =E2=80=98state=E2=80=99
>
>The fix is trivial. Just drop this line:
>
>        ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);
>
>It shouldn't cause any troubles, since the only things this function c=
urrently do are:
>        ir->ir_type =3D ir_type;
>
>        if (repeat)
>                set_bit(EV_REP, dev->evbit);
>
>As the repeat is inside ir-core, and the ir struct is not used anymore=
, this removal
>should cause no harm.
>
>So, I am dropping the line at the code I'm committing at v4l-dvb.git, =
to avoid bisect
>breakages.

You're entirely correct, that line should have been dropped (I even sen=
t=20
the same thing as part of my latest patch series before I read this=20
mail, but if you can fixup the original patch that'd be even better).


--=20
David H=C3=A4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
