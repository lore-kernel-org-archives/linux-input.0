From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [patch 3/3] Convert drivers/media/dvb/ttpci/budget-ci.c to use
 ir-core
Date: Thu, 08 Apr 2010 20:30:37 -0300
Message-ID: <4BBE671D.7070308@infradead.org>
References: <20100402185827.425741206@hardeman.nu> <20100402190255.774628605@hardeman.nu> <4BBE51C2.8060505@infradead.org> <20100408230948.GB18316@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408230948.GB18316@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgSMOkcmRlbWFu?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

David H=C3=A4rdeman wrote:
> On Thu, Apr 08, 2010 at 06:59:30PM -0300, Mauro Carvalho Chehab wrote=
:
>> david@hardeman.nu wrote:
>>> This patch converts drivers/media/dvb/ttpci/budget-ci.c to use ir-c=
ore
>>> rather than rolling its own keydown timeout handler and reporting k=
eys
>>> via drivers/media/IR/ir-functions.c.
>>
>> Hmm... had you test this patch? It got me an error here:
>=20
> Sorry, I must have sent you the wrong one :)
>=20
>> drivers/media/dvb/ttpci/budget-ci.c: In function =E2=80=98msp430_ir_=
init=E2=80=99:
>> drivers/media/dvb/ttpci/budget-ci.c:228: error: implicit declaration
>> of function =E2=80=98ir_input_init=E2=80=99
>> drivers/media/dvb/ttpci/budget-ci.c:228: error: =E2=80=98struct budg=
et_ci_ir=E2=80=99
>> has no member named =E2=80=98state=E2=80=99
>>
>> The fix is trivial. Just drop this line:
>>
>>        ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);
>>
>> It shouldn't cause any troubles, since the only things this function
>> currently do are:
>>        ir->ir_type =3D ir_type;
>>
>>        if (repeat)
>>                set_bit(EV_REP, dev->evbit);
>>
>> As the repeat is inside ir-core, and the ir struct is not used
>> anymore, this removal
>> should cause no harm.
>>
>> So, I am dropping the line at the code I'm committing at v4l-dvb.git=
,
>> to avoid bisect
>> breakages.
>=20
> You're entirely correct, that line should have been dropped (I even s=
ent
> the same thing as part of my latest patch series before I read this
> mail, but if you can fixup the original patch that'd be even better).

While I don't care much on experimental trees, I always do a make allye=
sconfig
and try to compile all drivers before pushing on my master tree. This h=
elps
to avoid some silly mistakes to go upstream ;)

--=20

Cheers,
Mauro
