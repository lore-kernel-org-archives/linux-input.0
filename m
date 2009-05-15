From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH] TSC2007: private data for platform callbacks.
Date: Fri, 15 May 2009 13:25:41 +0900
Message-ID: <483a38b80905142125l6f3be674m3b7ef9083cfcbdeb@mail.gmail.com>
References: <20090514100909.GA23626@roarinelk.homelinux.net>
	 <5d5443650905140328v319e673o2f7b865e21619486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:34683 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZEOEZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 00:25:40 -0400
In-Reply-To: <5d5443650905140328v319e673o2f7b865e21619486@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Trilok Soni <soni.trilok@gmail.com>, Kwangwoo Lee <kwangwoo.lee@gmail.com>, linux-kernel@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Manual,

On Thu, May 14, 2009 at 7:28 PM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Manuel,
>
> CCing linux-input mailing list, so not deleting any code from this
> e-mail while replying.
>
> On Thu, May 14, 2009 at 3:39 PM, Manuel Lauss
> <mano@roarinelk.homelinux.net> wrote:
>> Add a private data field to the tsc2007 platform data and pass this
>> to the callbacks.
>
> I hope that you have created this patch on top of two recently posted
> patches by Kwangwoo Lee
> to merge changes from Thierry.
>
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> ---
>> =A0drivers/input/touchscreen/tsc2007.c | =A0 52 ++++++++++++++++++++=
+++-----------
>> =A0include/linux/i2c/tsc2007.h =A0 =A0 =A0 =A0 | =A0 10 ++++---
>> =A02 files changed, 41 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/tou=
chscreen/tsc2007.c
>> index 948e167..5c4242d 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>> @@ -83,10 +83,35 @@ struct tsc2007 {
>> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pendown;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>>
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*get_pend=
own_state)(void);
>> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*clear_pe=
nirq)(void);
>> + =A0 =A0 =A0 struct tsc2007_platform_data *pd;

Why is this pd is contained in struct tsc2007?

>> =A0};
>>
>> +/* ask platform for pendown state */
>> +static inline int ts_get_pendown_state(struct tsc2007 *ts)
>> +{
>> + =A0 =A0 =A0 return ts->pd->get_pendown_state(ts->pd->priv);

Is it required in get_pendown_state() function in your platform?
The function just return true/false indicating the pendown state.

>
> So, we don't need check here, like this:
>
> if (ts->pd->get_pendown_state)
> =A0 =A0 =A0 =A0 =A0ret =3D =A0ts->pd->get_pendown_state(ts->pd->priv)=
;
>
>> +}
>> +
>> +/* ask platform to clear pendown irq if available */
>> +static inline void ts_clear_penirq(struct tsc2007 *ts)
>> +{
>> + =A0 =A0 =A0 if (ts->pd->clear_penirq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pd->clear_penirq(ts->pd->priv);
>> +}
>> +
>> +static inline void ts_init_platform_hw(struct tsc2007 *ts)
>> +{
>> + =A0 =A0 =A0 if (ts->pd->init_platform_hw)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pd->init_platform_hw(ts->pd->priv)=
;
>> +}
>> +
>> +static inline void ts_exit_platform_hw(struct tsc2007 *ts)
>> +{
>> + =A0 =A0 =A0 if (ts->pd->exit_platform_hw)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pd->exit_platform_hw(ts->pd->priv)=
;
>> +}
>> +
>> +
>> =A0static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>> =A0{
>> =A0 =A0 =A0 =A0s32 data;
>> @@ -129,7 +154,7 @@ static void tsc2007_send_event(void *tsc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt =3D z2;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt -=3D z1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt *=3D x;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt *=3D ts->x_plate_ohms;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt *=3D ts->pd->x_plate_ohms;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt /=3D z1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rt =3D (rt + 2047) >> 12;
>> =A0 =A0 =A0 =A0} else
>> @@ -204,7 +229,7 @@ static enum hrtimer_restart tsc2007_timer(struct=
 hrtimer *handle)
>>
>> =A0 =A0 =A0 =A0spin_lock_irqsave(&ts->lock, flags);
>>
>> - =A0 =A0 =A0 if (unlikely(!ts->get_pendown_state() && ts->pendown))=
 {
>> + =A0 =A0 =A0 if (unlikely(!ts_get_pendown_state(ts) && ts->pendown)=
) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct input_dev *input =3D ts->input=
;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&ts->client->dev, "UP\n");
>> @@ -235,14 +260,13 @@ static irqreturn_t tsc2007_irq(int irq, void *=
handle)
>>
>> =A0 =A0 =A0 =A0spin_lock_irqsave(&ts->lock, flags);
>>
>> - =A0 =A0 =A0 if (likely(ts->get_pendown_state())) {
>> + =A0 =A0 =A0 if (likely(ts_get_pendown_state(ts))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_irq_nosync(ts->irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hrtimer_start(&ts->timer, ktime_set(0=
, TS_POLL_DELAY),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0HRTIMER_MODE_REL);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (ts->clear_penirq)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->clear_penirq();
>> + =A0 =A0 =A0 ts_clear_penirq(ts);
>>
>> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&ts->lock, flags);
>>
>> @@ -253,7 +277,7 @@ static int tsc2007_probe(struct i2c_client *clie=
nt,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_devi=
ce_id *id)
>> =A0{
>> =A0 =A0 =A0 =A0struct tsc2007 *ts;
>> - =A0 =A0 =A0 struct tsc2007_platform_data *pdata =3D pdata =3D clie=
nt->dev.platform_data;
>> + =A0 =A0 =A0 struct tsc2007_platform_data *pdata =3D client->dev.pl=
atform_data;
>
> This change shows that you need to rebase based on two patches
> submitted by Lee recently.
>
>> =A0 =A0 =A0 =A0struct input_dev *input_dev;
>> =A0 =A0 =A0 =A0int err;
>>
>> @@ -283,12 +307,8 @@ static int tsc2007_probe(struct i2c_client *cli=
ent,
>>
>> =A0 =A0 =A0 =A0spin_lock_init(&ts->lock);
>>
>> - =A0 =A0 =A0 ts->model =A0 =A0 =A0 =A0 =A0 =A0 =3D pdata->model;
>> - =A0 =A0 =A0 ts->x_plate_ohms =A0 =A0 =A0=3D pdata->x_plate_ohms;
>> - =A0 =A0 =A0 ts->get_pendown_state =3D pdata->get_pendown_state;
>> - =A0 =A0 =A0 ts->clear_penirq =A0 =A0 =A0=3D pdata->clear_penirq;
>> -
>> - =A0 =A0 =A0 pdata->init_platform_hw();
>> + =A0 =A0 =A0 ts->pd =3D pdata;
>> + =A0 =A0 =A0 ts_init_platform_hw(ts);
>>
>> =A0 =A0 =A0 =A0snprintf(ts->phys, sizeof(ts->phys),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s/input0", dev_name(&client->dev))=
;
>> @@ -335,10 +355,8 @@ static int tsc2007_probe(struct i2c_client *cli=
ent,
>> =A0static int tsc2007_remove(struct i2c_client *client)
>> =A0{
>> =A0 =A0 =A0 =A0struct tsc2007 =A0*ts =3D i2c_get_clientdata(client);
>> - =A0 =A0 =A0 struct tsc2007_platform_data *pdata;
>>
>> - =A0 =A0 =A0 pdata =3D client->dev.platform_data;
>> - =A0 =A0 =A0 pdata->exit_platform_hw();
>> + =A0 =A0 =A0 ts_exit_platform_hw(ts);
>>
>> =A0 =A0 =A0 =A0free_irq(ts->irq, ts);
>> =A0 =A0 =A0 =A0hrtimer_cancel(&ts->timer);
>> diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007=
=2Eh
>> index c6361fb..45582b3 100644
>> --- a/include/linux/i2c/tsc2007.h
>> +++ b/include/linux/i2c/tsc2007.h
>> @@ -7,11 +7,13 @@ struct tsc2007_platform_data {
>> =A0 =A0 =A0 =A0u16 =A0 =A0 model; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* 2007. */
>> =A0 =A0 =A0 =A0u16 =A0 =A0 x_plate_ohms;
>>
>> - =A0 =A0 =A0 int =A0 =A0 (*get_pendown_state)(void);
>> - =A0 =A0 =A0 void =A0 =A0(*clear_penirq)(void); =A0 =A0 =A0 =A0 =A0=
/* If needed, clear 2nd level
>> + =A0 =A0 =A0 int =A0 =A0 (*get_pendown_state)(void *priv);
>> + =A0 =A0 =A0 void =A0 =A0(*clear_penirq)(void *priv); =A0 =A0/* If =
needed, clear 2nd level
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt source */
>> - =A0 =A0 =A0 int =A0 =A0 (*init_platform_hw)(void);
>> - =A0 =A0 =A0 void =A0 =A0(*exit_platform_hw)(void);
>> + =A0 =A0 =A0 int =A0 =A0 (*init_platform_hw)(void *priv);
>> + =A0 =A0 =A0 void =A0 =A0(*exit_platform_hw)(void *priv);
>> +
>> + =A0 =A0 =A0 void =A0 =A0*priv; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* passed to callbacks */
>> =A0};
>>
>> =A0#endif
>> --
>> 1.6.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>
>
>
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Regards,

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
