From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [linux-pm] [PATCH 4/5] input: gpio-keys: switch to new dev_pm_ops
Date: Fri, 7 Aug 2009 15:39:26 +0200
Message-ID: <74d0deb30908070639y6e949d0dr9ebf2f6144130208@mail.gmail.com>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	 <200908060251.55157.rjw@sisk.pl>
	 <20090806125909.GJ19257@buzzloop.caiaq.de>
	 <200908061719.44068.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:44438 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZHGNj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 09:39:27 -0400
In-Reply-To: <200908061719.44068.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Mack <daniel@caiaq.de>, linux-pm@lists.linux-foundation.org, Phil Blundell <pb@handhelds.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Aug 6, 2009 at 5:19 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Thursday 06 August 2009, Daniel Mack wrote:
>> On Thu, Aug 06, 2009 at 02:51:55AM +0200, Rafael J. Wysocki wrote:
>> > On Thursday 06 August 2009, Daniel Mack wrote:
>> > > On Wed, Aug 05, 2009 at 10:15:52PM +0200, pHilipp Zabel wrote:
>> > > > On Wed, Aug 5, 2009 at 8:29 PM, Daniel Mack<daniel@caiaq.de> w=
rote:
>> > > > > -static int gpio_keys_resume(struct platform_device *pdev)
>> > > > > +static int gpio_keys_resume(struct device *dev)
>> > > > > =A0{
>> > > > > - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev=
->dev.platform_data;
>> > > > > + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev-=
>platform_data;
>> > > > > =A0 =A0 =A0 =A0int i;
>> > > > >
>> > > > > - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> > > > > + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
>> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbut=
tons; i++) {
>> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_k=
eys_button *button =3D &pdata->buttons[i];
>> > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (button->w=
akeup) {
>> > > > > @@ -251,19 +251,27 @@ static int gpio_keys_resume(struct pla=
tform_device *pdev)
>> > > > >
>> > > > > =A0 =A0 =A0 =A0return 0;
>> > > > > =A0}
>> > > > > +
>> > > > > +static struct dev_pm_ops gpio_keys_pm_ops =3D {
>> > > > > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D gpio_keys_suspend,
>> > > > > + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =3D gpio_keys_suspend,
>> > > > > + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D gpio_keys_resume,
>> > > > > + =A0 =A0 =A0 .thaw =A0 =A0 =A0 =A0 =A0 =3D gpio_keys_resume=
,
>> > > >
>> > > > I'm not sure I understand hibernation correctly, but isn't
>> > > > .freeze/.thaw about saving state and halting/resuming the devi=
ce
>> > > > operation only?
>> >
>> > It is.
>> >
>> > > > It seems to me that enabling system wakeup functionality shoul=
d go
>> > > > into .poweroff. (See <linux/pm.h>)
>> >
>> > That's correct.
>> >
>> > And .restore() plays the role of ".resume() from hibernation".
>>
>> Hence, In case of this driver which only calls disable_irq/enable_ir=
q,
>> setting .poweroff and .restore seems to suffice?
>
> I'll have a look at the driver. =A0Still, it seems .suspend and .resu=
me should be
> set too, shouldn't they?

=2Esuspend/.resume need to be set. But I think .restore is not needed,
as the effects of calling enable_irq_wake in .poweroff are already
completely reverted by rebooting the system and restoring the memory
image that was captured before .poweroff was called.

>> From afa35cebccf49a24613e711afb8009fb6aadce0e Mon Sep 17 00:00:00 20=
01
>> From: Daniel Mack <daniel@caiaq.de>
>> Date: Wed, 5 Aug 2009 15:28:54 +0200
>> Subject: [PATCH 3/3] input: gpio-keys: switch to new dev_pm_ops
>>
>> The callbacks for the implemented functions are .poweroff and .resto=
re,
>> as they only care for {dis,en}able_irq(). Renamed the functions
>> to reflect that.
>>
>> Signed-off-by: Daniel Mack <daniel@caiaq.de>
>> Cc: Phil Blundell <pb@handhelds.org>
>> Cc: linux-input@vger.kernel.org
>> ---
>> =A0drivers/input/keyboard/gpio_keys.c | =A0 26 ++++++++++++++++-----=
-----
>> =A01 files changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyb=
oard/gpio_keys.c
>> index efed0c9..8e670d4 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -216,12 +216,12 @@ static int __devexit gpio_keys_remove(struct p=
latform_device *pdev)
>>
>>
>> =A0#ifdef CONFIG_PM
>> -static int gpio_keys_suspend(struct platform_device *pdev, pm_messa=
ge_t state)
>> +static int gpio_keys_poweroff(struct device *dev)
>> =A0{
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.platfo=
rm_data;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform_da=
ta;
>> =A0 =A0 =A0 int i;
>>
>> - =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> + =A0 =A0 if (device_may_wakeup(dev)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->nbuttons; i++) =
{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_keys_button =
*button =3D &pdata->buttons[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (button->wakeup) {
>> @@ -234,12 +234,12 @@ static int gpio_keys_suspend(struct platform_d=
evice *pdev, pm_message_t state)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int gpio_keys_resume(struct platform_device *pdev)
>> +static int gpio_keys_restore(struct device *dev)
>> =A0{
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.platfo=
rm_data;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform_da=
ta;
>> =A0 =A0 =A0 int i;
>>
>> - =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> + =A0 =A0 if (device_may_wakeup(dev)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->nbuttons; i++) =
{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_keys_button =
*button =3D &pdata->buttons[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (button->wakeup) {
>> @@ -251,19 +251,25 @@ static int gpio_keys_resume(struct platform_de=
vice *pdev)
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> +
>> +static struct dev_pm_ops gpio_keys_pm_ops =3D {
>> + =A0 =A0 .poweroff =A0 =A0 =A0 =3D gpio_keys_poweroff,
>> + =A0 =A0 .restore =A0 =A0 =A0 =A0=3D gpio_keys_restore,
>
> Should .suspend and .resume really be NULL?
>
>> +};
>> +
>> +#define GPIO_KEYS_PM_OPS (&gpio_keys_pm_ops)
>> +
>> =A0#else
>> -#define gpio_keys_suspend =A0 =A0NULL
>> -#define gpio_keys_resume =A0 =A0 NULL
>> +#define GPIO_KEYS_PM_OPS NULL
>> =A0#endif
>>
>> =A0static struct platform_driver gpio_keys_device_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D gpio_keys_probe,
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(gpio_keys_remove=
),
>> - =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D gpio_keys_suspend,
>> - =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D gpio_keys_resume,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "gpio-keys",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D GPIO_KEYS_PM_OPS,
>> =A0 =A0 =A0 }
>> =A0};
>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
