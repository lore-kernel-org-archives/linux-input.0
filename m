From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH v2 4/6 RESEND] ARM: pxa27x_keypad: added wakeup event
 handler for keypad interrupts
Date: Sun, 5 Sep 2010 11:28:51 -0400
Message-ID: <AANLkTik7H3qdbRa3NHKFyMvaFRJpisqs0=U-h7sxZQy4@mail.gmail.com>
References: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com>
	<1283552891-13966-5-git-send-email-mark.brown314@gmail.com>
	<4C834E9B.5080505@compulab.co.il>
	<AANLkTikOs0a45bfZ4jRd1_ROvcUMPmnwvcicpm1RZFCc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61441 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab0IEP24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Sep 2010 11:28:56 -0400
In-Reply-To: <AANLkTikOs0a45bfZ4jRd1_ROvcUMPmnwvcicpm1RZFCc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Sep 5, 2010 at 6:46 AM, Eric Miao <eric.y.miao@gmail.com> wrote=
:
> On Sun, Sep 5, 2010 at 4:02 PM, Igor Grinberg <grinberg@compulab.co.i=
l> wrote:
>> =A0On 09/04/10 01:28, Mark F. Brown wrote:
>>> mach-mmp needs to clear wake event in order to clear the keypad int=
errupt
>>>
>>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>>> ---
>>> =A0arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | =A0 =A01 +
>>> =A0drivers/input/keyboard/pxa27x_keypad.c =A0 =A0 =A0 =A0 | =A0 10 =
++++++++++
>>> =A02 files changed, 11 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/=
arm/plat-pxa/include/plat/pxa27x_keypad.h
>>> index 7b4eadc..73dacda 100644
>>> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
>>> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
>>> @@ -52,6 +52,7 @@ struct pxa27x_keypad_platform_data {
>>>
>>> =A0 =A0 =A0 /* key debounce interval */
>>> =A0 =A0 =A0 unsigned int =A0 =A0debounce_interval;
>>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*clear_wakeup_event)(void);
>>
>> I understand, this is a bit late... but still I want to ask a questi=
on:
>> As I understand, the clear_wakeup_event() function is called in inte=
rrupt context,
>> wouldn't it be wiser to add a comment on this, so platform (current/=
future) code
>> will be aware and will make no heavy stuff in it (accidentally).
>>
>
> A comment will be good to have indeed, not just explaining the contex=
t
> this function will be running, but also a bit about why this is intro=
duced.
>
> Mark,
>
> If you come up with an updated patch, I'll help rebase my tree.
>
>>> =A0};
>>>
>>> =A0extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_da=
ta *info);
>>> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input=
/keyboard/pxa27x_keypad.c
>>> index 0610d10..b36d2be 100644
>>> --- a/drivers/input/keyboard/pxa27x_keypad.c
>>> +++ b/drivers/input/keyboard/pxa27x_keypad.c
>>> @@ -330,11 +330,21 @@ static void pxa27x_keypad_scan_direct(struct =
pxa27x_keypad *keypad)
>>> =A0 =A0 =A0 keypad->direct_key_state =3D new_state;
>>> =A0}
>>>
>>> +static void clear_wakeup_event(struct pxa27x_keypad *keypad)
>>> +{
>>> + =A0 =A0 struct pxa27x_keypad_platform_data *pdata =3D keypad->pda=
ta;
>>> +
>>> + =A0 =A0 if (pdata->clear_wakeup_event)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 (pdata->clear_wakeup_event)();
>>> +}
>>> +
>>> =A0static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_=
id)
>>> =A0{
>>> =A0 =A0 =A0 struct pxa27x_keypad *keypad =3D dev_id;
>>> =A0 =A0 =A0 unsigned long kpc =3D keypad_readl(KPC);
>>>
>>> + =A0 =A0 clear_wakeup_event(keypad);
>>> +
>>> =A0 =A0 =A0 if (kpc & KPC_DI)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa27x_keypad_scan_direct(keypad);
>>>
>>
>> --
>> Regards,
>> Igor.
>>
>>
>

Ok will do!

-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
