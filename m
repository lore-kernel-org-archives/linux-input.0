From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 7/8] IR: extend ir_raw_event and do refactoring
Date: Wed, 08 Sep 2010 19:54:00 -0300
Message-ID: <4C881408.2030606@infradead.org>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com> <1283808373-27876-8-git-send-email-maximlevitsky@gmail.com> <4C88113C.8040703@infradead.org> <20100908224915.GA6699@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100908224915.GA6699@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em 08-09-2010 19:49, David H=E4rdeman escreveu:
> On Wed, Sep 08, 2010 at 07:42:04PM -0300, Mauro Carvalho Chehab wrote=
:
>> Em 06-09-2010 18:26, Maxim Levitsky escreveu:
>>> diff --git a/drivers/media/IR/ir-rc6-decoder.c b/drivers/media/IR/i=
r-rc6-decoder.c
>>> index f1624b8..d25da91 100644
>>> --- a/drivers/media/IR/ir-rc6-decoder.c
>>> +++ b/drivers/media/IR/ir-rc6-decoder.c
>>> @@ -85,8 +85,9 @@ static int ir_rc6_decode(struct input_dev *input_=
dev, struct ir_raw_event ev)
>>>  	if (!(ir_dev->raw->enabled_protocols & IR_TYPE_RC6))
>>>  		return 0;
>>> =20
>>> -	if (IS_RESET(ev)) {
>>> -		data->state =3D STATE_INACTIVE;
>>> +	if (!is_timing_event(ev)) {
>>> +		if (ev.reset)
>>
>> Again, why do you need to test first for !is_timing_event()?
>=20
> Because the decoder should return early if the event is not a timing=20
> event (the return 0 two lines below)...think carrier report event...

Yeah, I saw that. I was supposed to remove all the comments about that,=
 but I
forgot to remove the last one ;)

Cheers,
Mauro.
