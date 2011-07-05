From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Tue, 5 Jul 2011 14:08:01 -0400
Message-ID: <CAB7Re7X=N8yCCOXvxMAgf8k0y+Mz_+YbJw58tjj69CP24YDhyw@mail.gmail.com>
References: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
	<20110704162628.GC8144@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52158 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab1GESIC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 14:08:02 -0400
Received: by pzk9 with SMTP id 9so2668051pzk.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 11:08:02 -0700 (PDT)
In-Reply-To: <20110704162628.GC8144@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

On Mon, Jul 4, 2011 at 12:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Chris,
>
> On Tue, Jun 28, 2011 at 03:12:28PM -0400, chris.hudson.comp.eng@gmail=
=2Ecom wrote:
>> From: Chris Hudson <chudson@kionix.com>
>>
>> - Added Dmitry's changes
>> - Now using input_polled_dev interface when in polling mode
>> - IRQ mode provides a separate sysfs node to change the hardware dat=
a rate
>>
>
> I am not happy with the fact that this implementation forces users to
> select polled or interrupt-driven mode at compile time. The patch I
> proposed had polled mode support optional and would automatically sel=
ect
> IRQ mode for clients that have interrupt assigned and try to activate
> polled mode if interrupt is not available.
>
>> +
>> +/* kxtj9_set_poll: allows the user to select a new poll interval (i=
n ms) */
>> +static ssize_t kxtj9_set_poll(struct device *dev, struct device_att=
ribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>> +{
>> + =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_clien=
t(dev));
>> +
>> + =A0 =A0 unsigned long interval;
>> + =A0 =A0 int ret =3D kstrtoul(buf, 10, &interval);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 mutex_lock(&tj9->lock);
>> + =A0 =A0 /* set current interval to the greater of the minimum inte=
rval or
>> + =A0 =A0 the requested interval */
>> + =A0 =A0 tj9->last_poll_interval =3D max((int)interval, tj9->pdata.=
min_interval);
>> + =A0 =A0 mutex_unlock(&tj9->lock);
>
> This lock does not make sense. You are protecting update of last_poll=
_interval
> field and this update can not be partial (i.e. only LSB or MSB is
> written) on all our arches, but you do not protect kxtj9_update_odr()
> which alters chip state and does need protection.
>
> I tried bringing forward my changes from the older patch into yours,
> please let me know if the patch below works on top of yours.

Hi Dmitry,
Thanks for all your hard work, and yes it works fine.  There were a
couple of changes proposed by Jonathan that I had already merged into
my version though; should I submit these in a separate patch or resend
the merged version?
Thank you,
Chris

>
> Thanks.
>
> --
> Dmitry
>
>
> Input: ktxj9 - misc fixes
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/misc/Kconfig =A0| =A0 34 ++--
> =A0drivers/input/misc/kxtj9.c =A0| =A0355 +++++++++++++++++++++++----=
----------------
> =A0include/linux/input/kxtj9.h | =A0 18 +-
> =A03 files changed, 220 insertions(+), 187 deletions(-)
>
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 41628d2..0134428 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -230,6 +230,23 @@ config INPUT_KEYSPAN_REMOTE
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the module will
> =A0 =A0 =A0 =A0 =A0be called keyspan_remote.
>
> +config INPUT_KXTJ9
> + =A0 =A0 =A0 tristate "Kionix KXTJ9 tri-axis digital accelerometer"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here to enable support for the Kionix KXTJ9 d=
igital tri-axis
> + =A0 =A0 =A0 =A0 accelerometer.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the module will
> + =A0 =A0 =A0 =A0 be called kxtj9.
> +
> +config INPUT_KXTJ9_POLLED_MODE
> + =A0 =A0 =A0 bool "Enable polling mode support"
> + =A0 =A0 =A0 depends on INPUT_KXTJ9
> + =A0 =A0 =A0 select INPUT_POLLDEV
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you need accelerometer to work in pol=
ling mode.
> +
> =A0config INPUT_POWERMATE
> =A0 =A0 =A0 =A0tristate "Griffin PowerMate and Contour Jog support"
> =A0 =A0 =A0 =A0depends on USB_ARCH_HAS_HCD
> @@ -499,21 +516,4 @@ config INPUT_XEN_KBDDEV_FRONTEND
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called xen-kbdfront.
>
> -config INPUT_KXTJ9
> - =A0 =A0 =A0 tristate "Kionix KXTJ9 tri-axis digital accelerometer"
> - =A0 =A0 =A0 depends on I2C
> - =A0 =A0 =A0 help
> - =A0 =A0 =A0 =A0 If you say yes here you get support for the Kionix =
KXTJ9 digital
> - =A0 =A0 =A0 =A0 tri-axis accelerometer.
> -
> - =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so=
, the module
> - =A0 =A0 =A0 =A0 will be called kxtj9.
> -
> -config KXTJ9_POLLED_MODE
> - =A0 =A0 =A0 bool "Enable polling mode support"
> - =A0 =A0 =A0 depends on INPUT_KXTJ9
> - =A0 =A0 =A0 select INPUT_POLLDEV
> - =A0 =A0 =A0 help
> - =A0 =A0 =A0 =A0 Say Y here if you need accelerometer to work in pol=
ling mode.
> -
> =A0endif
> diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
> index 7faf155..31eae6a 100644
> --- a/drivers/input/misc/kxtj9.c
> +++ b/drivers/input/misc/kxtj9.c
> @@ -75,10 +75,8 @@ struct kxtj9_data {
> =A0 =A0 =A0 =A0struct i2c_client *client;
> =A0 =A0 =A0 =A0struct kxtj9_platform_data pdata;
> =A0 =A0 =A0 =A0struct input_dev *input_dev;
> -#ifdef CONFIG_KXTJ9_POLLED_MODE
> +#ifdef CONFIG_INPUT_KXTJ9_POLLED_MODE
> =A0 =A0 =A0 =A0struct input_polled_dev *poll_dev;
> -#else
> - =A0 =A0 =A0 struct mutex lock;
> =A0#endif
> =A0 =A0 =A0 =A0unsigned int last_poll_interval;
> =A0 =A0 =A0 =A0u8 shift;
> @@ -117,16 +115,32 @@ static void kxtj9_report_acceleration_data(stru=
ct kxtj9_data *tj9)
> =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->dev, "accelerome=
ter data read failed\n");
>
> - =A0 =A0 =A0 x =3D le16_to_cpu(acc_data[0]) >> tj9->shift;
> - =A0 =A0 =A0 y =3D le16_to_cpu(acc_data[1]) >> tj9->shift;
> - =A0 =A0 =A0 z =3D le16_to_cpu(acc_data[2]) >> tj9->shift;
> + =A0 =A0 =A0 x =3D le16_to_cpu(acc_data[tj9->pdata.axis_map_x]) >> t=
j9->shift;
> + =A0 =A0 =A0 y =3D le16_to_cpu(acc_data[tj9->pdata.axis_map_y]) >> t=
j9->shift;
> + =A0 =A0 =A0 z =3D le16_to_cpu(acc_data[tj9->pdata.axis_map_z]) >> t=
j9->shift;
>
> =A0 =A0 =A0 =A0input_report_abs(tj9->input_dev, ABS_X, tj9->pdata.neg=
ate_x ? -x : x);
> =A0 =A0 =A0 =A0input_report_abs(tj9->input_dev, ABS_Y, tj9->pdata.neg=
ate_y ? -y : y);
> - =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Z, tj9->pdata.nega=
te_x ? -y : y);
> + =A0 =A0 =A0 input_report_abs(tj9->input_dev, ABS_Z, tj9->pdata.nega=
te_z ? -z : z);
> =A0 =A0 =A0 =A0input_sync(tj9->input_dev);
> =A0}
>
> +static irqreturn_t kxtj9_isr(int irq, void *dev)
> +{
> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 /* data ready is the only possible interrupt type */
> + =A0 =A0 =A0 kxtj9_report_acceleration_data(tj9);
> +
> + =A0 =A0 =A0 err =3D i2c_smbus_read_byte_data(tj9->client, INT_REL);
> + =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error clearing interru=
pt status: %d\n", err);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> =A0static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_r=
ange)
> =A0{
> =A0 =A0 =A0 =A0switch (new_g_range) {
> @@ -152,7 +166,7 @@ static int kxtj9_update_g_range(struct kxtj9_data=
 *tj9, u8 new_g_range)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int kxtj9_update_odr(struct kxtj9_data *tj9, int poll_interva=
l)
> +static int kxtj9_update_odr(struct kxtj9_data *tj9, unsigned int pol=
l_interval)
> =A0{
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0int i;
> @@ -245,7 +259,7 @@ static int kxtj9_enable(struct kxtj9_data *tj9)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D i2c_smbus_read_byte_data(tj9->=
client, INT_REL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->=
dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "error clearing interrupt: %d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error =
clearing interrupt: %d\n", err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -257,8 +271,27 @@ fail:
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> +static void kxtj9_disable(struct kxtj9_data *tj9)
> +{
> + =A0 =A0 =A0 kxtj9_device_power_off(tj9);
> +}
> +
> +static int kxtj9_input_open(struct input_dev *input)
> +{
> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(input);
> +
> + =A0 =A0 =A0 return kxtj9_enable(tj9);
> +}
> +
> +static void kxtj9_input_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 kxtj9_disable(tj9);
> +}
> +
> =A0static void __devinit kxtj9_init_input_device(struct kxtj9_data *t=
j9,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct input_dev *input_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct input_dev *input_dev)
> =A0{
> =A0 =A0 =A0 =A0__set_bit(EV_ABS, input_dev->evbit);
> =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_X, -G_MAX, G_MAX, =
=46UZZ, FLAT);
> @@ -270,7 +303,104 @@ static void __devinit kxtj9_init_input_device(s=
truct kxtj9_data *tj9,
> =A0 =A0 =A0 =A0input_dev->dev.parent =3D &tj9->client->dev;
> =A0}
>
> -#ifdef CONFIG_KXTJ9_POLLED_MODE
> +static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9=
)
> +{
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!tj9->input_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "input devic=
e allocate failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tj9->input_dev =3D input_dev;
> +
> + =A0 =A0 =A0 input_dev->open =3D kxtj9_input_open;
> + =A0 =A0 =A0 input_dev->close =3D kxtj9_input_close;
> + =A0 =A0 =A0 input_set_drvdata(input_dev, tj9);
> +
> + =A0 =A0 =A0 kxtj9_init_input_device(tj9, input_dev);
> +
> + =A0 =A0 =A0 err =3D input_register_device(tj9->input_dev);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to register inp=
ut polled device %s: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->input_dev->name, e=
rr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(tj9->input_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * When IRQ mode is selected, we need to provide an interface to all=
ow the user
> + * to change the output data rate of the part. =A0For consistency, w=
e are using
> + * the set_poll method, which accepts a poll interval in millisecond=
s, and then
> + * calls update_odr() while passing this value as an argument. =A0In=
 IRQ mode, the
> + * data outputs will not be read AT the requested poll interval, rat=
her, the
> + * lowest ODR that can support the requested interval. =A0The client=
 application
> + * will be responsible for retrieving data from the input node at th=
e desired
> + * interval.
> + */
> +
> +/* Returns currently selected poll interval (in ms) */
> +static ssize_t kxtj9_get_poll(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_attribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 return sprintf(buf, "%d\n", tj9->last_poll_interval);
> +}
> +
> +/* Allow users to select a new poll interval (in ms) */
> +static ssize_t kxtj9_set_poll(struct device *dev, struct device_attr=
ibute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 struct input_dev *input_dev =3D tj9->input_dev;
> + =A0 =A0 =A0 unsigned int interval;
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 error =3D kstrtouint(buf, 10, &interval);
> + =A0 =A0 =A0 if (error < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> +
> + =A0 =A0 =A0 /* Lock the device to prevent races with open/close (an=
d itself) */
> + =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
> +
> + =A0 =A0 =A0 disable_irq(client->irq);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set current interval to the greater of the minimum=
 interval or
> + =A0 =A0 =A0 =A0* the requested interval
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 tj9->last_poll_interval =3D max(interval, tj9->pdata.mi=
n_interval);
> +
> + =A0 =A0 =A0 kxtj9_update_odr(tj9, tj9->last_poll_interval);
> +
> + =A0 =A0 =A0 enable_irq(client->irq);
> + =A0 =A0 =A0 mutex_unlock(&input_dev->mutex);
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_=
poll);
> +
> +static struct attribute *kxtj9_attributes[] =3D {
> + =A0 =A0 =A0 &dev_attr_poll.attr,
> + =A0 =A0 =A0 NULL
> +};
> +
> +static struct attribute_group kxtj9_attribute_group =3D {
> + =A0 =A0 =A0 .attrs =3D kxtj9_attributes
> +};
> +
> +
> +#ifdef CONFIG_INPUT_KXTJ9_POLLED_MODE
> =A0static void kxtj9_poll(struct input_polled_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0struct kxtj9_data *tj9 =3D dev->private;
> @@ -295,7 +425,7 @@ static void kxtj9_polled_input_close(struct input=
_polled_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0struct kxtj9_data *tj9 =3D dev->private;
>
> - =A0 =A0 =A0 kxtj9_device_power_off(tj9);
> + =A0 =A0 =A0 kxtj9_disable(tj9);
> =A0}
>
> =A0static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *=
tj9)
> @@ -325,7 +455,7 @@ static int __devinit kxtj9_setup_polled_device(st=
ruct kxtj9_data *tj9)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unable to register po=
lled device, err=3D%d\n", err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_free_polled_device(poll_dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> @@ -337,66 +467,7 @@ static void kxtj9_teardown_polled_device(struct =
kxtj9_data *tj9)
> =A0 =A0 =A0 =A0input_free_polled_device(tj9->poll_dev);
> =A0}
>
> -#else =A0/* IRQ Mode is enabled */
> -static int kxtj9_input_open(struct input_dev *input)
> -{
> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(input);
> -
> - =A0 =A0 =A0 return kxtj9_enable(tj9);
> -}
> -
> -static void kxtj9_input_close(struct input_dev *dev)
> -{
> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D input_get_drvdata(dev);
> -
> - =A0 =A0 =A0 kxtj9_device_power_off(tj9);
> -}
> -
> -static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9=
)
> -{
> - =A0 =A0 =A0 struct input_dev *input_dev;
> - =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 input_dev =3D input_allocate_device();
> - =A0 =A0 =A0 if (!tj9->input_dev) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev, "input devic=
e allocate failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 tj9->input_dev =3D input_dev;
> -
> - =A0 =A0 =A0 input_dev->open =3D kxtj9_input_open;
> - =A0 =A0 =A0 input_dev->close =3D kxtj9_input_close;
> - =A0 =A0 =A0 input_set_drvdata(input_dev, tj9);
> -
> - =A0 =A0 =A0 kxtj9_init_input_device(tj9, input_dev);
> -
> - =A0 =A0 =A0 err =3D input_register_device(tj9->input_dev);
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to register inp=
ut polled device %s: %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->input_dev->name, e=
rr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(tj9->input_dev);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static irqreturn_t kxtj9_isr(int irq, void *dev)
> -{
> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D dev;
> - =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 /* data ready is the only possible interrupt type */
> - =A0 =A0 =A0 kxtj9_report_acceleration_data(tj9);
> -
> - =A0 =A0 =A0 err =3D i2c_smbus_read_byte_data(tj9->client, INT_REL);
> - =A0 =A0 =A0 if (err < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tj9->client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error =
clearing interrupt status: %d\n", err);
> -
> - =A0 =A0 =A0 return IRQ_HANDLED;
> -}
> +#else
>
> =A0static inline int kxtj9_setup_polled_device(struct kxtj9_data *tj9=
)
> =A0{
> @@ -407,67 +478,22 @@ static inline void kxtj9_teardown_polled_device=
(struct kxtj9_data *tj9)
> =A0{
> =A0}
>
> -/* kxtj9_get_poll: returns the currently selected poll interval (in =
ms) */
> -static ssize_t kxtj9_get_poll(struct device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_attribute *attr, char *buf)
> -{
> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_cl=
ient(dev));
> - =A0 =A0 =A0 return sprintf(buf, "%d\n", tj9->last_poll_interval);
> -}
> -
> -/* kxtj9_set_poll: allows the user to select a new poll interval (in=
 ms) */
> -static ssize_t kxtj9_set_poll(struct device *dev, struct device_attr=
ibute *attr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
> -{
> - =A0 =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_cl=
ient(dev));
> -
> - =A0 =A0 =A0 unsigned long interval;
> - =A0 =A0 =A0 int ret =3D kstrtoul(buf, 10, &interval);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 mutex_lock(&tj9->lock);
> - =A0 =A0 =A0 /* set current interval to the greater of the minimum i=
nterval or
> - =A0 =A0 =A0 the requested interval */
> - =A0 =A0 =A0 tj9->last_poll_interval =3D max((int)interval, tj9->pda=
ta.min_interval);
> - =A0 =A0 =A0 mutex_unlock(&tj9->lock);
> -
> - =A0 =A0 =A0 kxtj9_update_odr(tj9, tj9->last_poll_interval);
> -
> - =A0 =A0 =A0 return count;
> -}
> -/* When IRQ mode is selected, we need to provide an interface to all=
ow the user
> - * to change the output data rate of the part. =A0For consistency, w=
e are using
> - * the set_poll method, which accepts a poll interval in millisecond=
s, and then
> - * calls update_odr() while passing this value as an argument. =A0In=
 IRQ mode, the
> - * data outputs will not be read AT the requested poll interval, rat=
her, the
> - * lowest ODR that can support the requested interval. =A0The client=
 application
> - * will be responsible for retrieving data from the input node at th=
e desired
> - * interval.
> - */
> -static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_=
poll);
> -
> -static struct attribute *kxtj9_attributes[] =3D {
> - =A0 =A0 =A0 &dev_attr_poll.attr,
> - =A0 =A0 =A0 NULL
> -};
> -
> -static struct attribute_group kxtj9_attribute_group =3D {
> - =A0 =A0 =A0 .attrs =3D kxtj9_attributes
> -};
> =A0#endif
>
> =A0static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
> =A0{
> =A0 =A0 =A0 =A0int retval;
> +
> =A0 =A0 =A0 =A0retval =3D kxtj9_device_power_on(tj9);
> =A0 =A0 =A0 =A0if (retval < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return retval;
> +
> =A0 =A0 =A0 =A0retval =3D i2c_smbus_read_byte_data(tj9->client, WHO_A=
M_I);
> =A0 =A0 =A0 =A0if (retval < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&tj9->client->dev, "read err i=
nt source\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0retval =3D retval !=3D 0x06 ? -EIO : 0;
>
> =A0out:
> @@ -476,7 +502,7 @@ out:
> =A0}
>
> =A0static int __devinit kxtj9_probe(struct i2c_client *client,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const s=
truct i2c_device_id *id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t struct i2c_device_id *id)
> =A0{
> =A0 =A0 =A0 =A0const struct kxtj9_platform_data *pdata =3D client->de=
v.platform_data;
> =A0 =A0 =A0 =A0struct kxtj9_data *tj9;
> @@ -487,10 +513,12 @@ static int __devinit kxtj9_probe(struct i2c_cli=
ent *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "client is not i=
2c capable\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0if (!pdata) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "platform data i=
s NULL; exiting\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0tj9 =3D kzalloc(sizeof(*tj9), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!tj9) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> @@ -513,42 +541,46 @@ static int __devinit kxtj9_probe(struct i2c_cli=
ent *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_pdata_exit;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 i2c_set_clientdata(client, tj9);
> +
> =A0 =A0 =A0 =A0tj9->ctrl_reg1 =3D tj9->pdata.res_12bit | tj9->pdata.g=
_range;
> =A0 =A0 =A0 =A0tj9->data_ctrl =3D tj9->pdata.data_odr_init;
>
> -#ifdef CONFIG_KXTJ9_POLLED_MODE
> - =A0 =A0 =A0 err =3D kxtj9_setup_polled_device(tj9);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
> -#else
> - =A0 =A0 =A0 /* If in irq mode, populate INT_CTRL_REG1 and enable DR=
DY. */
> - =A0 =A0 =A0 tj9->int_ctrl |=3D KXTJ9_IEN | KXTJ9_IEA | KXTJ9_IEL;
> - =A0 =A0 =A0 tj9->ctrl_reg1 |=3D DRDYE;
> + =A0 =A0 =A0 if (client->irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If in irq mode, populate INT_CTRL_RE=
G1 and enable DRDY. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->int_ctrl |=3D KXTJ9_IEN | KXTJ9_IE=
A | KXTJ9_IEL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tj9->ctrl_reg1 |=3D DRDYE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_setup_input_device(tj9);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_threaded_irq(client->ir=
q, NULL, kxtj9_isr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"kxtj9-irq", tj9);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
request irq failed: %d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_destroy_input;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D kxtj9_setup_input_device(tj9);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D sysfs_create_group(&client->dev=
=2Ekobj, &kxtj9_attribute_group);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
sysfs create failed: %d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D request_threaded_irq(client->irq, NULL, kxtj9_i=
sr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TR=
IGGER_RISING | IRQF_ONESHOT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "kxtj9-=
irq", tj9);
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "request irq fail=
ed: %d\n", err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_destroy_input;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 err =3D sysfs_create_group(&client->dev.kobj, &kxtj9_at=
tribute_group);
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "sysfs create fai=
led: %d\n", err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_destroy_input;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D kxtj9_setup_polled_device(tj9);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata_exit;
> =A0 =A0 =A0 =A0}
> -#endif
> - =A0 =A0 =A0 i2c_set_clientdata(client, tj9);
> +
> =A0 =A0 =A0 =A0return 0;
>
> -#ifndef CONFIG_KXTJ9_POLLED_MODE
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(client->irq, tj9);
> =A0err_destroy_input:
> =A0 =A0 =A0 =A0input_unregister_device(tj9->input_dev);
> -#endif
> =A0err_pdata_exit:
> =A0 =A0 =A0 =A0if (tj9->pdata.exit)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.exit();
> @@ -561,13 +593,14 @@ static int __devexit kxtj9_remove(struct i2c_cl=
ient *client)
> =A0{
> =A0 =A0 =A0 =A0struct kxtj9_data *tj9 =3D i2c_get_clientdata(client);
>
> -#ifdef CONFIG_KXTJ9_POLLED_MODE
> - =A0 =A0 =A0 kxtj9_teardown_polled_device(tj9);
> -#else
> - =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &kxtj9_attribute_=
group);
> - =A0 =A0 =A0 free_irq(client->irq, tj9);
> - =A0 =A0 =A0 input_unregister_device(tj9->input_dev);
> -#endif
> + =A0 =A0 =A0 if (client->irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &=
kxtj9_attribute_group);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(client->irq, tj9);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(tj9->input_dev)=
;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kxtj9_teardown_polled_device(tj9);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (tj9->pdata.exit)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tj9->pdata.exit();
>
> @@ -620,13 +653,13 @@ MODULE_DEVICE_TABLE(i2c, kxtj9_id);
>
> =A0static struct i2c_driver kxtj9_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D NAME,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &kxtj9_pm_ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &kxtj9_pm_ops,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 .probe =3D kxtj9_probe,
> - =A0 =A0 =A0 .remove =3D __devexit_p(kxtj9_remove),
> - =A0 =A0 =A0 .id_table =3D kxtj9_id,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D kxtj9_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(kxtj9_remove),
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D kxtj9_id,
> =A0};
>
> =A0static int __init kxtj9_init(void)
> diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.=
h
> index cc5928b..0b546bd 100644
> --- a/include/linux/input/kxtj9.h
> +++ b/include/linux/input/kxtj9.h
> @@ -27,19 +27,21 @@
> =A0#define SHIFT_ADJ_4G =A0 =A0 =A0 =A0 =A0 3
> =A0#define SHIFT_ADJ_8G =A0 =A0 =A0 =A0 =A0 2
>
> -#ifdef __KERNEL__
> =A0struct kxtj9_platform_data {
> - =A0 =A0 =A0 int poll_interval; =A0 =A0 =A0/* current poll interval =
(in milli-seconds) */
> - =A0 =A0 =A0 int min_interval; =A0 =A0 =A0 /* minimum poll interval =
(in milli-seconds) */
> + =A0 =A0 =A0 unsigned int min_interval; =A0 =A0 =A0/* minimum poll i=
nterval (in milli-seconds) */
>
> - =A0 =A0 =A0 /* by default, x is axis 0, y is axis 1, z is axis 2; t=
hese can be
> - =A0 =A0 =A0 changed to account for sensor orientation within the ho=
st device */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* By default, x is axis 0, y is axis 1, z is axis 2;=
 these can be
> + =A0 =A0 =A0 =A0* changed to account for sensor orientation within t=
he host device.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0u8 axis_map_x;
> =A0 =A0 =A0 =A0u8 axis_map_y;
> =A0 =A0 =A0 =A0u8 axis_map_z;
>
> - =A0 =A0 =A0 /* each axis can be negated to account for sensor orien=
tation within
> - =A0 =A0 =A0 the host device; 1 =3D negate this axis; 0 =3D do not n=
egate this axis */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Each axis can be negated to account for sensor ori=
entation within
> + =A0 =A0 =A0 =A0* the host device.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0bool negate_x;
> =A0 =A0 =A0 =A0bool negate_y;
> =A0 =A0 =A0 =A0bool negate_z;
> @@ -70,7 +72,5 @@ struct kxtj9_platform_data {
> =A0 =A0 =A0 =A0int (*power_on)(void);
> =A0 =A0 =A0 =A0int (*power_off)(void);
> =A0};
> -#endif /* __KERNEL__ */
> -
> =A0#endif =A0/* __KXTJ9_H__ */
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
