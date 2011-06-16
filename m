From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH v4] input: Add support for Kionix KXTJ9 accelerometer
Date: Thu, 16 Jun 2011 15:41:59 -0400
Message-ID: <BANLkTinc2kpyEEGkVbq5jAngQmqM5oG7ug@mail.gmail.com>
References: <1306449620-21879-1-git-send-email-chudson@kionix.com>
	<20110531080337.GB13855@core.coreip.homeip.net>
	<BANLkTimcW=Mmczhr-zfor8JUy6CGOr6+CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44305 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060Ab1FPTmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 15:42:00 -0400
Received: by pvg12 with SMTP id 12so1271123pvg.19
        for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 12:41:59 -0700 (PDT)
In-Reply-To: <BANLkTimcW=Mmczhr-zfor8JUy6CGOr6+CA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, Chris Hudson <chudson@kionix.com>

On Tue, Jun 7, 2011 at 2:04 PM, Christopher Hudson
<chris.hudson.comp.eng@gmail.com> wrote:
> Hi Dmitry,
>
> My apologies for the delayed reply. =A0I couldn't get your patch to
> apply cleanly to my tree, but I was able to manually add the changes.
> I liked many of these changes, but there were 2 main issues when
> testing on the hardware:
>
> - There is no poll interval selection available in irq mode.

I just re-read this and realized that it probably created some
confusion.  The issue is that the output data rate of the sensor
controls the frequency of interrupts in IRQ mode.  We need to allow
for control of the data rate (otherwise the sensor will be locked at a
single ODR when using the data ready interrupt), so it seems to make
the most sense to use the same sysfs control whether in polling or IRQ
mode.  Any thoughts?

> I was planning to add my previous versions of get_poll and set_poll t=
o the
> #else branch of CONFIG_KXTJ9_POLLED_MODE, and create this sysfs group
> in the client->irq branch in probe. =A0Unfortunately, this seems to
> render the use of input_polled_dev a bit redundant. =A0What do you th=
ink
> about this implementation?
>
> - For some reason, whenever I try to use le16_to_cpu followed by a
> bit-shift operation without first storing the results to memory I end
> up with garbled data. =A0What seems to be happening is the bit-shift =
is
> being performed before the le16_to_cpu operation. =A0I've tried vario=
us
> implementations with parentheses to try to separate the two
> operations, but the only thing I have found to work is to store the
> results of the le16_to_cpu operation first, then bit-shift the result
> in another operation:
> x =3D le16_to_cpu(acc_data[tj9->pdata.axis_map_x]);
> x >>=3D tj9->shift;
> Note that I also preserved the axis_map platform data variable in thi=
s
> implementation; was it your intent to do away with this feature?
>
>
> On Tue, May 31, 2011 at 4:03 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Chris,
>> On Thu, May 26, 2011 at 06:40:20PM -0400, Chris Hudson wrote:
>>> Quite a few changes this time around (thanks Jonathan and Dmitry!):
>>> - The sysfs node for poll_interval was changed to emulate input_pol=
ldev. =A0I
>>> =A0 could not actually use input_polldev because some commands need=
 to be sent
>>> =A0 to the hardware when the poll interval is changed.
>>> - Locking cleaned up throughout
>>> - Cleared up distinction between IRQ and polling modes: if client->=
irq, then
>>> =A0 irq mode is enabled. =A0Removed register bits required for irq =
from the header;
>>> =A0 these will be set in the driver if client->irq is populated.
>>> - Put .suspend and .resume into struct dev_pm_ops.
>>> - Many other smaller changes, unnecessary variables removed, etc.
>>>
>>> Signed-off-by: Chris Hudson <chudson@kionix.com>
>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Could you please tell me how badly the patch below breaks the device=
?
>>
>> Thanks!
>>
>> --
>> Dmitry
>>
>>
>> Input: KXTJ9 assorted changes
>>
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>>
>> =A0drivers/input/misc/Kconfig | =A0 27 +-
>> =A0drivers/input/misc/kxtj9.c | =A0654 ++++++++++++++++++++++-------=
---------------
>> =A02 files changed, 344 insertions(+), 337 deletions(-)
>>
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 567f3d2..7010623 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -209,6 +209,23 @@ config INPUT_KEYSPAN_REMOTE
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the module will
>> =A0 =A0 =A0 =A0 =A0be called keyspan_remote.
>>
>> +config INPUT_KXTJ9
>> + =A0 =A0 =A0 tristate "Kionix KXTJ9 tri-axis digital accelerometer"
>> + =A0 =A0 =A0 depends on I2C
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 If you say yes here you get support for the Kionix=
 KXTJ9 digital
>> + =A0 =A0 =A0 =A0 tri-axis accelerometer.
>> +
>> + =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If s=
o, the module
>> + =A0 =A0 =A0 =A0 will be called kxtj9.
>> +
>> +config KXTJ9_POLLED_MODE
>> + =A0 =A0 =A0 bool "Enable polling mode support"
>> + =A0 =A0 =A0 depends on INPUT_KXTJ9
>> + =A0 =A0 =A0 select INPUT_POLLDEV
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Say Y here if you need accelerometer to work in po=
lling mode.
>> +
>> =A0config INPUT_POWERMATE
>> =A0 =A0 =A0 =A0tristate "Griffin PowerMate and Contour Jog support"
>> =A0 =A0 =A0 =A0depends on USB_ARCH_HAS_HCD
>> @@ -467,14 +484,4 @@ config INPUT_XEN_KBDDEV_FRONTEND
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the
>> =A0 =A0 =A0 =A0 =A0module will be called xen-kbdfront.
>>
>> -config INPUT_KXTJ9
>> - =A0 =A0 =A0 tristate "Kionix KXTJ9 tri-axis digital accelerometer"
>> - =A0 =A0 =A0 depends on I2C && SYSFS
>> - =A0 =A0 =A0 help
>> - =A0 =A0 =A0 =A0 If you say yes here you get support for the Kionix=
 KXTJ9 digital
>> - =A0 =A0 =A0 =A0 tri-axis accelerometer.
>> -
>> - =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If s=
o, the module
>> - =A0 =A0 =A0 =A0 will be called kxtj9.
>> -
>> =A0endif
>> diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
>> index ef83182..1536bf4 100644
>> --- a/drivers/input/misc/kxtj9.c
>> +++ b/drivers/input/misc/kxtj9.c
>> @@ -61,63 +61,86 @@ static const struct {
>> =A0 =A0 =A0 =A0unsigned int cutoff;
>> =A0 =A0 =A0 =A0u8 mask;
>> =A0} kxtj9_odr_table[] =3D {
>> - =A0 =A0 =A0 {
>> - =A0 =A0 =A0 3, =A0 =A0 =A0ODR800F}, {
>> - =A0 =A0 =A0 5, =A0 =A0 =A0ODR400F}, {
>> - =A0 =A0 =A0 10, =A0 =A0 ODR200F}, {
>> - =A0 =A0 =A0 20, =A0 =A0 ODR100F}, {
>> - =A0 =A0 =A0 40, =A0 =A0 ODR50F}, {
>> - =A0 =A0 =A0 80, =A0 =A0 ODR25F}, {
>> - =A0 =A0 =A0 0, =A0 =A0 =A0ODR12_5F},
>> + =A0 =A0 =A0 { 3, =A0 =A0ODR800F },
>> + =A0 =A0 =A0 { 5, =A0 =A0ODR400F },
>> + =A0 =A0 =A0 { 10, =A0 ODR200F },
>> + =A0 =A0 =A0 { 20, =A0 ODR100F },
>> + =A0 =A0 =A0 { 40, =A0 ODR50F =A0},
>> + =A0 =A0 =A0 { 80, =A0 ODR25F =A0},
>> + =A0 =A0 =A0 { 0, =A0 =A0ODR12_5F},
>> =A0};
>>
>> =A0struct kxtj9_data {
>> =A0 =A0 =A0 =A0struct i2c_client *client;
>> =A0 =A0 =A0 =A0struct kxtj9_platform_data pdata;
>> - =A0 =A0 =A0 struct mutex lock;
>> - =A0 =A0 =A0 struct delayed_work input_work;
>> =A0 =A0 =A0 =A0struct input_dev *input_dev;
>> -
>> - =A0 =A0 =A0 bool hw_initialized;
>> - =A0 =A0 =A0 bool enabled;
>> +#ifdef CONFIG_KXTJ9_POLLED_MODE
>> + =A0 =A0 =A0 struct input_dev *input_polled_dev;
>> +#endif
>> + =A0 =A0 =A0 unsigned int last_poll_interval;
>> =A0 =A0 =A0 =A0u8 shift;
>> - =A0 =A0 =A0 u8 resume[RESUME_ENTRIES];
>> + =A0 =A0 =A0 u8 ctrl_reg1;
>> + =A0 =A0 =A0 u8 data_ctrl;
>> + =A0 =A0 =A0 u8 int_ctrl;
>> =A0};
>>
>> =A0static int kxtj9_i2c_read(struct kxtj9_data *tj9, u8 addr, u8 *da=
ta, int len)
>> =A0{
>> - =A0 =A0 =A0 int err;
>> -
>> =A0 =A0 =A0 =A0struct i2c_msg msgs[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =3D tj9->client->addr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D tj9->client->flags,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.buf =3D &addr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D tj9->client-=
>addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D tj9->client=
->flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =3D &addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =3D tj9->client->addr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D tj9->client->flags | I2C=
_M_RD,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =3D len,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.buf =3D data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D tj9->client-=
>addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D tj9->client=
->flags | I2C_M_RD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =3D data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0};
>> - =A0 =A0 =A0 err =3D i2c_transfer(tj9->client->adapter, msgs, 2);
>>
>> - =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 return i2c_transfer(tj9->client->adapter, msgs, 2);
>> =A0}
>>
>> -static int kxtj9_verify(struct kxtj9_data *tj9)
>> +static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
>> =A0{
>> - =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 s16 acc_data[3]; /* Data bytes from hardware xL, xH, y=
L, yH, zL, zH */
>> + =A0 =A0 =A0 s16 x, y, z;
>> + =A0 =A0 =A0 int err;
>>
>> - =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(tj9->client, WHO_AM_I=
);
>> - =A0 =A0 =A0 if (ret < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "read err i=
nt source\n");
>> - =A0 =A0 =A0 if (ret !=3D 0x06)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> + =A0 =A0 =A0 err =3D kxtj9_i2c_read(tj9, XOUT_L, (u8 *)acc_data, 6)=
;
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "accelerome=
ter data read failed\n");
>> +
>> + =A0 =A0 =A0 x =3D le16_to_cpu(acc_data[0]) >> tj9->shift;
>> + =A0 =A0 =A0 y =3D le16_to_cpu(acc_data[1]) >> tj9->shift;
>> + =A0 =A0 =A0 z =3D le16_to_cpu(acc_data[2]) >> tj9->shift;
>> +
>> + =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.negate_x=
 ? -x : x);
>> + =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.negate_y=
 ? -y : y);
>> + =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Z,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.negate_x=
 ? -y : y);
>> + =A0 =A0 =A0 input_sync(tj9->input_dev);
>> +}
>>
>> - =A0 =A0 =A0 return ret;
>> +static irqreturn_t kxtj9_isr(int irq, void *dev)
>> +{
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 /* data ready is the only possible interrupt type */
>> + =A0 =A0 =A0 kxtj9_report_acceleration_data(tj9);
>> +
>> + =A0 =A0 =A0 err =3D i2c_smbus_read_byte_data(tj9->client, INT_REL)=
;
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error clearing interr=
upt status: %d\n", err);
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0}
>>
>> =A0static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_=
range)
>> @@ -126,17 +149,21 @@ static int kxtj9_update_g_range(struct kxtj9_d=
ata *tj9, u8 new_g_range)
>> =A0 =A0 =A0 =A0case KXTJ9_G_2G:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->shift =3D SHIFT_ADJ_2G;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> +
>> =A0 =A0 =A0 =A0case KXTJ9_G_4G:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->shift =3D SHIFT_ADJ_4G;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> +
>> =A0 =A0 =A0 =A0case KXTJ9_G_8G:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->shift =3D SHIFT_ADJ_8G;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> +
>> =A0 =A0 =A0 =A0default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 tj9->resume[RES_CTRL_REG1] =3D (tj9->resume[RES_CTRL_R=
EG1] & 0xE7)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | new_g_range;
>> +
>> + =A0 =A0 =A0 tj9->ctrl_reg1 &=3D 0xe7;
>> + =A0 =A0 =A0 tj9->ctrl_reg1 |=3D new_g_range;
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> @@ -145,72 +172,40 @@ static int kxtj9_update_odr(struct kxtj9_data =
*tj9, int poll_interval)
>> =A0{
>> =A0 =A0 =A0 =A0int err;
>> =A0 =A0 =A0 =A0int i;
>> - =A0 =A0 =A0 u8 config;
>> - =A0 =A0 =A0 u8 temp =3D 0;
>>
>> =A0 =A0 =A0 =A0/* Use the lowest ODR that can support the requested =
poll interval */
>> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(kxtj9_odr_table); i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 config =3D kxtj9_odr_table[i].mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->data_ctrl =3D kxtj9_odr_table[i].=
mask;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (poll_interval < kxtj9_odr_table[i=
].cutoff)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (tj9->enabled =3D=3D true) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9-=
>client, CTRL_REG1, temp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9-=
>client, DATA_CTRL, config);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D tj9->resume[RES_CTRL_REG1];
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9-=
>client, CTRL_REG1, temp);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Cancel and restart polling if not i=
n irq mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tj9->client->irq) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sy=
nc(&tj9->input_work);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(=
&tj9->input_work,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 msecs_to_jiffies(poll_interval));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>> - =A0 =A0 =A0 tj9->resume[RES_DATA_CTRL] =3D config;
>> -
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> -static int kxtj9_hw_init(struct kxtj9_data *tj9)
>> -{
>> - =A0 =A0 =A0 int err;
>> - =A0 =A0 =A0 u8 buf =3D 0;
>> -
>> - =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, CTRL_RE=
G1, buf);
>> - =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, DATA_CT=
RL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 tj9->resume[RES_DATA_CTRL]);
>> - =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 if (tj9->client->irq) /* only write INT_CTRL_REG1 if i=
n irq mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9-=
>client, INT_CTRL1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 tj9->resume[RES_INT_CTRL1]);
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, CTRL_RE=
G1, 0);
>> =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>>
>> - =A0 =A0 =A0 err =3D kxtj9_update_g_range(tj9, tj9->pdata.g_range);
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 DATA_CTRL, tj9->data_ctrl);
>> =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>>
>> - =A0 =A0 =A0 buf =3D (tj9->resume[RES_CTRL_REG1] | PC1_ON);
>> - =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, CTRL_RE=
G1, buf);
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CTRL_REG1, tj9->ctrl_reg1);
>> =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>> - =A0 =A0 =A0 tj9->resume[RES_CTRL_REG1] =3D buf;
>>
>> - =A0 =A0 =A0 err =3D kxtj9_update_odr(tj9, tj9->pdata.poll_interval=
);
>> - =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 return 0;
>> +}
>>
>> - =A0 =A0 =A0 tj9->hw_initialized =3D true;
>> +static int kxtj9_device_power_on(struct kxtj9_data *tj9)
>> +{
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 if (tj9->pdata.power_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D tj9->pdata.power_on();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> @@ -218,319 +213,306 @@ static int kxtj9_hw_init(struct kxtj9_data *=
tj9)
>> =A0static void kxtj9_device_power_off(struct kxtj9_data *tj9)
>> =A0{
>> =A0 =A0 =A0 =A0int err;
>> - =A0 =A0 =A0 u8 buf;
>>
>> - =A0 =A0 =A0 buf =3D tj9->resume[RES_CTRL_REG1] & PC1_OFF;
>> - =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, CTRL_RE=
G1, buf);
>> + =A0 =A0 =A0 tj9->ctrl_reg1 &=3D PC1_OFF;
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CTRL_REG1, tj9->ctrl_reg1);
>> =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->dev, "soft powe=
r off failed\n");
>> +
>> =A0 =A0 =A0 =A0if (tj9->pdata.power_off)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.power_off();
>> - =A0 =A0 =A0 tj9->resume[RES_CTRL_REG1] =3D buf;
>> - =A0 =A0 =A0 tj9->hw_initialized =3D false;
>> =A0}
>>
>> -static int kxtj9_device_power_on(struct kxtj9_data *tj9)
>> +static int kxtj9_enable(struct kxtj9_data *tj9)
>> =A0{
>> =A0 =A0 =A0 =A0int err;
>>
>> - =A0 =A0 =A0 if (tj9->pdata.power_on) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D tj9->pdata.power_on();
>> + =A0 =A0 =A0 err =3D kxtj9_device_power_on(tj9);
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client, CTRL_RE=
G1, 0);
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 DATA_CTRL, tj9->data_ctrl);
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 /* only write INT_CTRL_REG1 if in irq mode */
>> + =A0 =A0 =A0 if (tj9->client->irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9-=
>client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 INT_CTRL1, tj9->int_ctrl);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 if (!tj9->hw_initialized) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(40);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_hw_init(tj9);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_device_power_off=
(tj9);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 return 0;
>> -}
>> + =A0 =A0 =A0 err =3D kxtj9_update_g_range(tj9, tj9->pdata.g_range);
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> -static void kxtj9_get_acceleration_data(struct kxtj9_data *tj9, s16=
 *xyz)
>> -{
>> - =A0 =A0 =A0 int err;
>> - =A0 =A0 =A0 /* Data bytes from hardware xL, xH, yL, yH, zL, zH */
>> - =A0 =A0 =A0 s16 acc_data[3];
>> + =A0 =A0 =A0 tj9->ctrl_reg1 |=3D PC1_ON;
>> + =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(tj9->client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CTRL_REG1, tj9->ctrl_reg1);
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> - =A0 =A0 =A0 err =3D kxtj9_i2c_read(tj9, XOUT_L, (u8 *)acc_data, 6)=
;
>> + =A0 =A0 =A0 err =3D kxtj9_update_odr(tj9, tj9->pdata.poll_interval=
);
>> =A0 =A0 =A0 =A0if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "accelerome=
ter data read failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> - =A0 =A0 =A0 acc_data[0] =3D le16_to_cpu(acc_data[0]);
>> - =A0 =A0 =A0 acc_data[1] =3D le16_to_cpu(acc_data[1]);
>> - =A0 =A0 =A0 acc_data[2] =3D le16_to_cpu(acc_data[2]);
>> + =A0 =A0 =A0 err =3D i2c_smbus_read_byte_data(tj9->client, INT_REL)=
;
>> + =A0 =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error clearing interr=
upt: %d\n", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 acc_data[0] >>=3D tj9->shift;
>> - =A0 =A0 =A0 acc_data[1] >>=3D tj9->shift;
>> - =A0 =A0 =A0 acc_data[2] >>=3D tj9->shift;
>> + =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 =A0 xyz[0] =3D (tj9->pdata.negate_x) ? (-acc_data[tj9->pda=
ta.axis_map_x])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : (acc_data[tj9->pdata.axis_map_x]=
);
>> - =A0 =A0 =A0 xyz[1] =3D (tj9->pdata.negate_y) ? (-acc_data[tj9->pda=
ta.axis_map_y])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : (acc_data[tj9->pdata.axis_map_y]=
);
>> - =A0 =A0 =A0 xyz[2] =3D (tj9->pdata.negate_z) ? (-acc_data[tj9->pda=
ta.axis_map_z])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : (acc_data[tj9->pdata.axis_map_z]=
);
>> +fail:
>> + =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> + =A0 =A0 =A0 return err;
>> +}
>>
>> - =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_X, (int) xyz[0]);
>> - =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Y, (int) xyz[1]);
>> - =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Z, (int) xyz[2]);
>> - =A0 =A0 =A0 input_sync(tj9->input_dev);
>> +static void kxtj9_disable(struct kxtj9_data *tj9)
>> +{
>> + =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> =A0}
>>
>> -static irqreturn_t kxtj9_isr(int irq, void *dev)
>> +static int kxtj9_input_open(struct input_dev *input)
>> =A0{
>> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev;
>> - =A0 =A0 =A0 int ret;
>> - =A0 =A0 =A0 s16 xyz[3];
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(input);
>>
>> - =A0 =A0 =A0 /* data ready is the only possible interrupt type */
>> - =A0 =A0 =A0 kxtj9_get_acceleration_data(tj9, xyz);
>> + =A0 =A0 =A0 return kxtj9_enable(tj9);
>> +}
>>
>> - =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(tj9->client, INT_REL)=
;
>> - =A0 =A0 =A0 if (ret < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error=
 clearing interrupt status: %d\n", ret);
>> +static void kxtj9_input_close(struct input_dev *dev)
>> +{
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(dev);
>>
>> - =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 =A0 kxtj9_disable(tj9);
>> =A0}
>>
>> -static int kxtj9_enable(struct kxtj9_data *tj9)
>> +static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj=
9,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct input_dev *input_dev)
>> =A0{
>> - =A0 =A0 =A0 int err =3D 0;
>> -
>> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
>> - =A0 =A0 =A0 if (tj9->enabled =3D=3D false) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_device_power_on(tj9);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->=
dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "error during power-on: %d\n", err);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_read_byte_data(tj9->=
client, INT_REL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->=
dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "error clearing interrupt: %d\n", err);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tj9->client->irq) /* queue pollin=
g if not in irq mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(=
&tj9->input_work,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_=
to_jiffies(tj9->pdata.poll_interval));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->enabled =3D true;
>> - =A0 =A0 =A0 }
>> -err0:
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>> -
>> - =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
>> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_X, -G_MAX, G_MAX, =
=46UZZ, FLAT);
>> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Y, -G_MAX, G_MAX, =
=46UZZ, FLAT);
>> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Z, -G_MAX, G_MAX, =
=46UZZ, FLAT);
>> +
>> + =A0 =A0 =A0 input_dev->name =3D "kxtj9_accel";
>> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
>> + =A0 =A0 =A0 input_dev->dev.parent =3D &tj9->client->dev;
>> =A0}
>>
>> -static int kxtj9_disable(struct kxtj9_data *tj9)
>> +static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj=
9)
>> =A0{
>> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
>> - =A0 =A0 =A0 if (tj9->enabled =3D=3D true) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tj9->client->irq) /* cancel polli=
ng if not in irq mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sy=
nc(&tj9->input_work);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->enabled =3D false;
>> + =A0 =A0 =A0 struct input_dev *input_dev;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
>> + =A0 =A0 =A0 if (!tj9->input_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "input devi=
ce allocate failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 tj9->input_dev =3D input_dev;
>> +
>> + =A0 =A0 =A0 input_dev->open =3D kxtj9_input_open;
>> + =A0 =A0 =A0 input_dev->close =3D kxtj9_input_close;
>> + =A0 =A0 =A0 input_set_drvdata(input_dev, tj9);
>> +
>> + =A0 =A0 =A0 kxtj9_init_input_device(tj9, input_dev);
>> +
>> + =A0 =A0 =A0 err =3D input_register_device(tj9->input_dev);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to register in=
put polled device %s: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->input_dev->name, =
err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(tj9->input_dev);
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static void kxtj9_input_work_func(struct work_struct *work)
>> +#ifdef CONIFG_KXTJ9_POLLED_MODE
>> +static void kxtj9_poll(struct input_polled_dev *dev)
>> =A0{
>> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D container_of(work, struct k=
xtj9_data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_work.work);
>> - =A0 =A0 =A0 s16 xyz[3];
>> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev->private;
>> + =A0 =A0 =A0 unsigned int poll_interval =3D dev->poll_interval;
>>
>> - =A0 =A0 =A0 kxtj9_get_acceleration_data(tj9, xyz);
>> + =A0 =A0 =A0 kxtj9_report_acceleration_data(tj9);
>>
>> - =A0 =A0 =A0 schedule_delayed_work(&tj9->input_work,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(tj9->=
pdata.poll_interval));
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>> + =A0 =A0 =A0 if (poll_interval !=3D tj9->last_poll_interval) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_update_odr(tj9, poll_interval);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->last_poll_interval =3D poll_inter=
val;
>> + =A0 =A0 =A0 }
>> =A0}
>>
>> -static int kxtj9_input_open(struct input_dev *input)
>> +static int kxtj9_polled_input_open(struct input_polled_dev *dev)
>> =A0{
>> - =A0 =A0 =A0 return kxtj9_enable(input_get_drvdata(input));
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev->private;
>> +
>> + =A0 =A0 =A0 return kxtj9_enable(tj9);
>> =A0}
>>
>> -static void kxtj9_input_close(struct input_dev *dev)
>> +static void kxtj9_polled_input_close(struct input_polled_dev *dev)
>> =A0{
>> - =A0 =A0 =A0 kxtj9_disable(input_get_drvdata(dev));
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev->private;
>> +
>> + =A0 =A0 =A0 kxtj9_disable(tj9);
>> =A0}
>>
>> -static int kxtj9_input_init(struct kxtj9_data *tj9)
>> +static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *t=
j9)
>> =A0{
>> - =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 struct input_polled_dev *poll_dev;
>>
>> - =A0 =A0 =A0 if (!tj9->client->irq) /* only use input_work if not i=
n irq mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_DELAYED_WORK(&tj9->input_work, kx=
tj9_input_work_func);
>> - =A0 =A0 =A0 tj9->input_dev =3D input_allocate_device();
>> - =A0 =A0 =A0 if (!tj9->input_dev) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "input devi=
ce allocate failed\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> + =A0 =A0 =A0 poll_dev =3D input_allocate_polled_device();
>> + =A0 =A0 =A0 if (!poll_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to allocate po=
lled device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 tj9->input_dev->open =3D kxtj9_input_open;
>> - =A0 =A0 =A0 tj9->input_dev->close =3D kxtj9_input_close;
>>
>> - =A0 =A0 =A0 input_set_drvdata(tj9->input_dev, tj9);
>> + =A0 =A0 =A0 tj9->polled_dev =3D poll_dev;
>> + =A0 =A0 =A0 tj9->input_dev =3D poll_dev->input;
>>
>> - =A0 =A0 =A0 set_bit(EV_ABS, tj9->input_dev->evbit);
>> + =A0 =A0 =A0 poll_dev->private =3D tj9;
>> + =A0 =A0 =A0 poll_dev->poll =3D kxtj9_poll;
>> + =A0 =A0 =A0 poll_dev->open =3D kxtj9_polled_input_open;
>> + =A0 =A0 =A0 poll_dev->close =3D kxtj9_polled_input_close;
>>
>> - =A0 =A0 =A0 input_set_abs_params(tj9->input_dev, ABS_X, -G_MAX, G_=
MAX, FUZZ, FLAT);
>> - =A0 =A0 =A0 input_set_abs_params(tj9->input_dev, ABS_Y, -G_MAX, G_=
MAX, FUZZ, FLAT);
>> - =A0 =A0 =A0 input_set_abs_params(tj9->input_dev, ABS_Z, -G_MAX, G_=
MAX, FUZZ, FLAT);
>> + =A0 =A0 =A0 kxtj9_init_input_device(tj9, poll_dev->input);
>>
>> - =A0 =A0 =A0 tj9->input_dev->name =3D "kxtj9_accel";
>> - =A0 =A0 =A0 tj9->input_dev->id.bustype =3D BUS_I2C;
>> - =A0 =A0 =A0 tj9->input_dev->dev.parent =3D &tj9->client->dev;
>> -
>> - =A0 =A0 =A0 err =3D input_register_device(tj9->input_dev);
>> + =A0 =A0 =A0 err =3D input_register_polled_device(poll_dev);
>> =A0 =A0 =A0 =A0if (err) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to register in=
put polled device %s: %d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->input_dev->name, =
err);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to register po=
lled device, err=3D%d\n", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_polled_device(poll_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0return 0;
>> -err1:
>> - =A0 =A0 =A0 input_free_device(tj9->input_dev);
>> -err0:
>> - =A0 =A0 =A0 return err;
>> =A0}
>>
>> -/* kxtj9_delay_show: returns the currently selected poll interval (=
in ms) */
>> -static ssize_t kxtj9_get_poll(struct device *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 device_attribute *attr, char *buf)
>> +static kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
>> =A0{
>> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_c=
lient(dev));
>> - =A0 =A0 =A0 return sprintf(buf, "%d\n", tj9->pdata.poll_interval);
>> + =A0 =A0 =A0 input_unregister_polled_device(tj9->poll_dev);
>> + =A0 =A0 =A0 input_free_polled_device(tj9->poll_dev);
>> =A0}
>>
>> -/* kxtj9_delay_store: allows the user to select a new poll interval=
 (in ms) */
>> -static ssize_t kxtj9_set_poll(struct device *dev, struct device_att=
ribute *attr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>> +#else
>> +
>> +static inline int kxtj9_setup_polled_device(struct kxtj9_data *tj9)
>> =A0{
>> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_c=
lient(dev));
>> - =A0 =A0 =A0 unsigned long interval;
>> - =A0 =A0 =A0 int ret =3D kstrtoul(buf, 10, &interval);
>> - =A0 =A0 =A0 if (ret < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 return -ENOSYS;
>> +}
>>
>> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
>> - =A0 =A0 =A0 /* set current interval to the greater of the minimum =
interval or
>> - =A0 =A0 =A0 the requested interval */
>> - =A0 =A0 =A0 tj9->pdata.poll_interval =3D max((int)interval, tj9->p=
data.min_interval);
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>> +static inline void kxtj9_teardown_polled_device(struct kxtj9_data *=
tj9)
>> +{
>> +}
>> +#endif
>>
>> - =A0 =A0 =A0 kxtj9_update_odr(tj9, tj9->pdata.poll_interval);
>> +static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
>> +{
>> + =A0 =A0 =A0 int retval;
>>
>> - =A0 =A0 =A0 return count;
>> -}
>> -static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set=
_poll);
>> + =A0 =A0 =A0 retval =3D kxtj9_device_power_on(tj9);
>> + =A0 =A0 =A0 if (retval < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>>
>> -static struct attribute *kxtj9_attributes[] =3D {
>> - =A0 =A0 =A0 &dev_attr_poll.attr,
>> - =A0 =A0 =A0 NULL
>> -};
>> + =A0 =A0 =A0 retval =3D i2c_smbus_read_byte_data(tj9->client, WHO_A=
M_I);
>> + =A0 =A0 =A0 if (retval < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "read err i=
nt source\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>>
>> -static struct attribute_group kxtj9_attribute_group =3D {
>> - =A0 =A0 =A0 .attrs =3D kxtj9_attributes
>> -};
>> + =A0 =A0 =A0 retval =3D retval !=3D 0x06 ? - EIO : 0;
>> +
>> +out:
>> + =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> + =A0 =A0 =A0 return retval;
>> +}
>>
>> =A0static int __devinit kxtj9_probe(struct i2c_client *client,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id *id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con=
st struct i2c_device_id *id)
>> =A0{
>> - =A0 =A0 =A0 int err =3D -1;
>> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D kzalloc(sizeof(*tj9), GFP_K=
ERNEL);
>> - =A0 =A0 =A0 if (tj9 =3D=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to allocate me=
mory for module data\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> + =A0 =A0 =A0 const struct kxtj9_platform_data *pdata =3D client->de=
v.platform_data;
>> + =A0 =A0 =A0 struct kxtj9_data *tj9;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_FU=
NC_I2C | I2C_FUNC_SMBUS_BYTE_DATA)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "client is not i=
2c capable\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 if (client->dev.platform_data =3D=3D NULL) {
>> +
>> + =A0 =A0 =A0 if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "platform data =
is NULL; exiting\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC=
_I2C |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 I2C_FUNC_SMBUS_BYTE_DATA)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "client not i2c =
capable\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> +
>> + =A0 =A0 =A0 tj9 =3D kzalloc(sizeof(*tj9), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!tj9) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to allocate me=
mory for module data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 mutex_init(&tj9->lock);
>> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
>> +
>> =A0 =A0 =A0 =A0tj9->client =3D client;
>> - =A0 =A0 =A0 i2c_set_clientdata(client, tj9);
>> + =A0 =A0 =A0 tj9->pdata =3D *pdata;
>>
>> - =A0 =A0 =A0 memcpy(&tj9->pdata, client->dev.platform_data, sizeof(=
tj9->pdata));
>> - =A0 =A0 =A0 if (tj9->pdata.init) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D tj9->pdata.init();
>> + =A0 =A0 =A0 if (pdata->init) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D pdata->init();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 err =3D sysfs_create_group(&client->dev.kobj, &kxtj9_a=
ttribute_group);
>> - =A0 =A0 =A0 if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> + =A0 =A0 =A0 err =3D kxtj9_verify(tj9);
>> + =A0 =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "device not reco=
gnized\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 tj9->resume[RES_CTRL_REG1] =3D tj9->pdata.res_12bit | =
tj9->pdata.g_range;
>> - =A0 =A0 =A0 tj9->resume[RES_DATA_CTRL] =3D tj9->pdata.data_odr_ini=
t;
>> + =A0 =A0 =A0 tj9->ctrl_reg1 =3D tj9->pdata.res_12bit | tj9->pdata.g=
_range;
>> + =A0 =A0 =A0 tj9->data_ctrl =3D tj9->pdata.data_odr_init;
>>
>> =A0 =A0 =A0 =A0if (client->irq) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_threaded_irq(client->i=
rq, NULL, kxtj9_isr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_RISING | =
IRQF_ONESHOT, "kxtj9-irq", tj9);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: request ir=
q failed: %d\n", __func__, err);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err5;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if in irq mode, populate INT_CTRL_R=
EG1 and enable DRDY */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->resume[RES_INT_CTRL1] =3D KXTJ9_I=
EN | KXTJ9_IEA | KXTJ9_IEL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->resume[RES_CTRL_REG1] |=3D DRDYE;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If in irq mode, populate INT_CTRL_R=
EG1 and enable DRDY. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->int_ctrl |=3D KXTJ9_IEN | KXTJ9_I=
EA | KXTJ9_IEL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->ctrl_reg1 |=3D DRDYE;
>>
>> - =A0 =A0 =A0 err =3D kxtj9_input_init(tj9);
>> - =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_setup_input_device(tj9);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
>>
>> - =A0 =A0 =A0 err =3D kxtj9_device_power_on(tj9);
>> - =A0 =A0 =A0 if (err < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> - =A0 =A0 =A0 tj9->enabled =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_threaded_irq(client->i=
rq, NULL, kxtj9_isr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"kxtj9-irq", tj9);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, =
"request irq failed: %d\n", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_destroy_input=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 err =3D kxtj9_verify(tj9);
>> - =A0 =A0 =A0 if (err < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "device not reco=
gnized\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err5;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_setup_polled_device(tj9)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>> -
>> + =A0 =A0 =A0 i2c_set_clientdata(client, tj9);
>> =A0 =A0 =A0 =A0return 0;
>>
>> -err5:
>> - =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> -err4:
>> +err_destroy_input:
>> =A0 =A0 =A0 =A0input_unregister_device(tj9->input_dev);
>> -err3:
>> - =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute=
_group);
>> -err2:
>> +err_pdata_exit:
>> =A0 =A0 =A0 =A0if (tj9->pdata.exit)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.exit();
>> -err1:
>> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
>> -err0:
>> +err_free_mem:
>> =A0 =A0 =A0 =A0kfree(tj9);
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>> @@ -539,50 +521,69 @@ static int __devexit kxtj9_remove(struct i2c_c=
lient *client)
>> =A0{
>> =A0 =A0 =A0 =A0struct kxtj9_data *tj9 =3D i2c_get_clientdata(client)=
;
>>
>> - =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute=
_group);
>> - =A0 =A0 =A0 if (client->irq)
>> + =A0 =A0 =A0 if (client->irq) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(client->irq, tj9);
>> - =A0 =A0 =A0 input_unregister_device(tj9->input_dev);
>> - =A0 =A0 =A0 kxtj9_device_power_off(tj9);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(tj9->input_dev=
);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_teardown_polled_device(tj9);
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0if (tj9->pdata.exit)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.exit();
>> +
>> =A0 =A0 =A0 =A0kfree(tj9);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -#ifdef CONFIG_PM
>> -static int kxtj9_resume(struct device *dev)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int kxtj9_suspend(struct device *dev)
>> =A0{
>> - =A0 =A0 =A0 return kxtj9_enable(i2c_get_clientdata(to_i2c_client(d=
ev)));
>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(client);
>> + =A0 =A0 =A0 struct input_dev *input_dev =3D tj9->input_dev;
>> +
>> + =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
>> +
>> + =A0 =A0 =A0 if (input_dev->users)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_disable(tj9);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
>> + =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int kxtj9_suspend(struct device *dev)
>> +static int kxtj9_resume(struct device *dev)
>> =A0{
>> - =A0 =A0 =A0 return kxtj9_disable(i2c_get_clientdata(to_i2c_client(=
dev)));
>> -}
>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(client);
>> + =A0 =A0 =A0 struct input_dev *input_dev =3D tj9->input_dev;
>> + =A0 =A0 =A0 int retval =3D 0;
>>
>> -static const struct dev_pm_ops kxtj9_pm_ops =3D {
>> - =A0 =A0 =A0 .suspend =3D kxtj9_suspend,
>> - =A0 =A0 =A0 .resume =3D kxtj9_resume,
>> -};
>> + =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
>> +
>> + =A0 =A0 =A0 if (input_dev->users)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_enable(tj9);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
>> + =A0 =A0 =A0 return retval;
>> +}
>> =A0#endif
>>
>> +static SIMPLE_DEV_PM_OPS(kxtj9_pm_ops, kxtj9_suspend, kxtj9_resume)=
;
>> +
>> =A0static const struct i2c_device_id kxtj9_id[] =3D {
>> - =A0 =A0 =A0 {NAME, 0},
>> - =A0 =A0 =A0 {},
>> + =A0 =A0 =A0 { NAME, 0 },
>> + =A0 =A0 =A0 { },
>> =A0};
>>
>> =A0MODULE_DEVICE_TABLE(i2c, kxtj9_id);
>>
>> =A0static struct i2c_driver kxtj9_driver =3D {
>> =A0 =A0 =A0 =A0.driver =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D NAME,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> -#ifdef CONFIG_PM
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =3D &kxtj9_pm_ops,
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &kxtj9_pm_ops,
>> + =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0.probe =3D kxtj9_probe,
>> =A0 =A0 =A0 =A0.remove =3D __devexit_p(kxtj9_remove),
>> =A0 =A0 =A0 =A0.id_table =3D kxtj9_id,
>> @@ -592,13 +593,12 @@ static int __init kxtj9_init(void)
>> =A0{
>> =A0 =A0 =A0 =A0return i2c_add_driver(&kxtj9_driver);
>> =A0}
>> +module_init(kxtj9_init);
>>
>> =A0static void __exit kxtj9_exit(void)
>> =A0{
>> =A0 =A0 =A0 =A0i2c_del_driver(&kxtj9_driver);
>> =A0}
>> -
>> -module_init(kxtj9_init);
>> =A0module_exit(kxtj9_exit);
>>
>> =A0MODULE_DESCRIPTION("KXTJ9 accelerometer driver");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
