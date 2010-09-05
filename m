From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2 4/6 RESEND] ARM: pxa27x_keypad: added wakeup event
 handler for keypad interrupts
Date: Sun, 5 Sep 2010 18:46:56 +0800
Message-ID: <AANLkTikOs0a45bfZ4jRd1_ROvcUMPmnwvcicpm1RZFCc@mail.gmail.com>
References: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com>
 <1283552891-13966-5-git-send-email-mark.brown314@gmail.com> <4C834E9B.5080505@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C834E9B.5080505@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Mark F. Brown" <mark.brown314@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Sep 5, 2010 at 4:02 PM, Igor Grinberg <grinberg@compulab.co.il>=
 wrote:
> =C2=A0On 09/04/10 01:28, Mark F. Brown wrote:
>> mach-mmp needs to clear wake event in order to clear the keypad inte=
rrupt
>>
>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>> ---
>> =C2=A0arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | =C2=A0 =C2=A0=
1 +
>> =C2=A0drivers/input/keyboard/pxa27x_keypad.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 10 ++++++++++
>> =C2=A02 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/a=
rm/plat-pxa/include/plat/pxa27x_keypad.h
>> index 7b4eadc..73dacda 100644
>> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
>> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
>> @@ -52,6 +52,7 @@ struct pxa27x_keypad_platform_data {
>>
>> =C2=A0 =C2=A0 =C2=A0 /* key debounce interval */
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0debounce_interval;
>> + =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*clea=
r_wakeup_event)(void);
>
> I understand, this is a bit late... but still I want to ask a questio=
n:
> As I understand, the clear_wakeup_event() function is called in inter=
rupt context,
> wouldn't it be wiser to add a comment on this, so platform (current/f=
uture) code
> will be aware and will make no heavy stuff in it (accidentally).
>

A comment will be good to have indeed, not just explaining the context
this function will be running, but also a bit about why this is introdu=
ced.

Mark,

If you come up with an updated patch, I'll help rebase my tree.

>> =C2=A0};
>>
>> =C2=A0extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_=
data *info);
>> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/=
keyboard/pxa27x_keypad.c
>> index 0610d10..b36d2be 100644
>> --- a/drivers/input/keyboard/pxa27x_keypad.c
>> +++ b/drivers/input/keyboard/pxa27x_keypad.c
>> @@ -330,11 +330,21 @@ static void pxa27x_keypad_scan_direct(struct p=
xa27x_keypad *keypad)
>> =C2=A0 =C2=A0 =C2=A0 keypad->direct_key_state =3D new_state;
>> =C2=A0}
>>
>> +static void clear_wakeup_event(struct pxa27x_keypad *keypad)
>> +{
>> + =C2=A0 =C2=A0 struct pxa27x_keypad_platform_data *pdata =3D keypad=
->pdata;
>> +
>> + =C2=A0 =C2=A0 if (pdata->clear_wakeup_event)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdata->clear_wakeup_eve=
nt)();
>> +}
>> +
>> =C2=A0static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *de=
v_id)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct pxa27x_keypad *keypad =3D dev_id;
>> =C2=A0 =C2=A0 =C2=A0 unsigned long kpc =3D keypad_readl(KPC);
>>
>> + =C2=A0 =C2=A0 clear_wakeup_event(keypad);
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (kpc & KPC_DI)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pxa27x_keypad_scan_=
direct(keypad);
>>
>
> --
> Regards,
> Igor.
>
>
