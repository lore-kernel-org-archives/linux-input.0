From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: driver for the Goodix touchpanel
Date: Wed, 24 Sep 2014 10:14:11 -0400
Message-ID: <CAN+gG=GhkFHK+yo=FxTOhRM7NrFo6ii64tFQsoKjthtDt+TYRQ@mail.gmail.com>
References: <1411511293.29315.16.camel@hadess.net>
	<20140924004510.GC16747@core.coreip.homeip.net>
	<1411567548.29315.19.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:63423 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaIXOOM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 10:14:12 -0400
Received: by mail-qa0-f44.google.com with SMTP id x12so3243808qac.31
        for <linux-input@vger.kernel.org>; Wed, 24 Sep 2014 07:14:12 -0700 (PDT)
In-Reply-To: <1411567548.29315.19.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

Hi Dmitry,

Thanks for the review. As a foreword, most of the things you mentioned
were left over from the original driver that we did not spot. Anyway,
enough of excuses, let's go in details.


On Wed, Sep 24, 2014 at 10:05 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2014-09-23 at 17:45 -0700, Dmitry Torokhov wrote:
>> Hi Bastien,
>
> Hey Dmitry,
>
> As a reference, Benjamin and I have a downstream/stand-alone repository
> for the driver, as we needed to greatly modify the original Android
> driver.
>
> I'm making all the changes there before pushing them for review to you,
> which might make it easier for you to review.
>
> See: https://github.com/hadess/gt9xx
>
> <snip>
>> > +#define GOODIX_INFO(fmt, arg...)       pr_info("<<-GTP-INFO->> "fmt"\n", ##arg)
>> > +#define GOODIX_ERROR(fmt, arg...)      pr_err("<<-GTP-ERROR->> "fmt"\n", ##arg)
>>
>> Let's use standard dev_xxx()
>
> Done.

Yep. I was not sure about keeping that or not, but we can drop the
defines entirely and rely on dev_xxx as you suggest.

>
>> > +
>> > +static const char *goodix_ts_name = "Goodix Capacitive TouchScreen";
>> > +static const unsigned long goodix_irq_flags[] = {
>> > +   IRQ_TYPE_EDGE_RISING  | IRQF_ONESHOT,
>> > +   IRQ_TYPE_EDGE_FALLING | IRQF_ONESHOT,
>> > +   IRQ_TYPE_LEVEL_LOW    | IRQF_ONESHOT,
>> > +   IRQ_TYPE_LEVEL_HIGH   | IRQF_ONESHOT
>> > +};
>>
>> I'd rather you pulled out IRQF_ONESHOT and specified it explicitly in
>> request_threaded_irq().
>
> Done.
>
>> > +
>> > +/**
>> > + * goodix_i2c_read - read data from a register of the i2c slave device.
>> > + *
>> > + * @client: i2c device.
>> > + * @reg: the register to read from.
>> > + * @buf: raw write data buffer.
>> > + * @len: length of the buffer to write
>> > + */
>> > +static int goodix_i2c_read(struct i2c_client *client,
>> > +                           u16 reg, u8 *buf, int len)
>> > +{
>> > +   struct i2c_msg msgs[2];
>> > +   u8 wbuf[2] = { reg >> 8, reg & 0xff };
>>
>> cpu_to_be16()?
>
> Fixed (hopefully)

You should be more confident Bastien :)

>
>> > +
>> > +   msgs[0].flags = !I2C_M_RD;
>>
>> I2C_M_RD is not a boolean, do not negate it.

Ouch, I have seen that and forgot about it. We will set the flags to 0 directly.

>
> Done.
>
>> > +   msgs[0].addr  = client->addr;
>> > +   msgs[0].len   = 2;
>> > +   msgs[0].buf   = wbuf;
>> > +
>> > +   msgs[1].flags = I2C_M_RD;
>> > +   msgs[1].addr  = client->addr;
>> > +   msgs[1].len   = len;
>> > +   msgs[1].buf   = buf;
>> > +
>> > +   return i2c_transfer(client->adapter, msgs, 2);
>>
>>       return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
>>
>> I really need to get that i2c_transfer_exact() going again.
>
> Done.
>
>> > +}
>> > +
>> > +/**
>> > + * goodix_i2c_write - write data to the i2c slave device.
>> > + *
>> > + * @client: i2c device.
>> > + * @reg: the register to read to.
>> > + * @buf: raw write data buffer.
>> > + * @len: length of the buffer to write
>> > + */
>> > +static int goodix_i2c_write(struct i2c_client *client,
>> > +                           u16 reg, u8 *buf, int len)
>> > +{
>> > +   struct i2c_msg msg;
>> > +   int ret;
>> > +   u8 *wbuf;
>> > +
>> > +   wbuf = kzalloc(len + 2, GFP_KERNEL);
>> > +   if (!buf)
>> > +           return -ENOMEM;
>> > +
>> > +   wbuf[0] = reg >> 8;
>> > +   wbuf[1] = reg & 0xFF;
>>
>> Again cpu_to_be16().
>
> Done.
>
>> > +   memcpy(&wbuf[2], buf, len);
>> > +
>> > +   msg.flags = !I2C_M_RD;
>>
>> Same here, not boolean.
>

sigh. sorry.

> Done.
>
> <snip>
>> > +/**
>> > + * goodix_ts_work_func - Process incoming IRQ
>> > + *
>> > + * @ts: our goodix_ts_data pointer
>> > + *
>> > + * Called when the IRQ is triggered. Read the current device state, and push
>> > + * the input events to the user space.
>> > + */
>> > +static void goodix_ts_work_func(struct goodix_ts_data *ts)
>> > +{
>> > +   u8  end_cmd[1] = {0};
>> > +   u8  point_data[1 + 8 * GOODIX_MAX_TOUCH + 1];
>> > +   int touch_num;
>> > +   int i;
>> > +
>> > +   touch_num = goodix_ts_read_input_report(ts, point_data);
>> > +   if (touch_num < 0)
>> > +           goto exit_work_func;
>> > +
>> > +   for (i = 0; i < touch_num; i++)
>> > +           goodix_ts_parse_touch(ts, &point_data[1 + 8 * i]);
>> > +
>> > +   input_mt_sync_frame(ts->input_dev);
>> > +   input_sync(ts->input_dev);
>> > +
>> > +exit_work_func:
>> > +   if (goodix_i2c_write(ts->client,
>> > +                           GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
>> > +           GOODIX_INFO("I2C write end_cmd error");
>>
>> Why did you need to pull it out of goodix_ts_irq_handler()?

I can surely get a very good reason, but I will have to digg too much
for it to be acceptable :)
We will drop goodix_ts_work_func() (I did not liked the name BTW) and
merge the code in the irq handler directly.

>
> True, moved now.
>
>> > +}
> <snip>
>> > +/**
>> > + * goodix_read_version - Read goodix touchscreen version
>> > + *
>> > + * @client: the i2c client
>> > + * @version: output buffer containing the version on success
>> > + */
>> > +static int goodix_read_version(struct i2c_client *client, u16 *version)
>> > +{
>> > +   int ret;
>> > +   int i;
>> > +   u8 buf[6];
>> > +
>> > +   ret = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
>> > +   if (ret < 0) {
>> > +           GOODIX_ERROR("GTP read version failed");
>> > +           return ret;
>> > +   }
>> > +
>> > +   if (version)
>> > +           *version = get_unaligned_le16(&buf[4]);
>> > +
>> > +   for (i = 0; i < 4; i++) {
>> > +           if (!buf[i])
>> > +                   buf[i] = 0x30;
>>
>>                       buf[i] = '0';
>>
>> but what if they happen to have some other nonprintable garbage there?
>
> True. Not sure what to do here, Benjamin?

So at first i was thinking at just using %*ph in the following
message, but then I realized about the char part of it.
I guess we will just drop the previous for loop, and have the message as follow:
dev_info(..., "IC VERSION: %6ph", buf);

>
>> > +   }
>> > +   GOODIX_INFO("IC VERSION: %c%c%c%c_%02x%02x",
>> > +                     buf[0], buf[1], buf[2], buf[3], buf[5], buf[4]);
>> > +
>> > +   return ret;
>> > +}
> <snip>
>> > +/**
>> > + * goodix_request_irq - Request the IRQ handler
>> > + *
>> > + * @ts: our goodix_ts_data pointer
>> > + *
>> > + * Must be called during probe
>> > + */
>> > +static int goodix_request_irq(struct goodix_ts_data *ts)
>> > +{
>> > +   int ret;
>> > +
>> > +   ret = devm_request_threaded_irq(&ts->client->dev,
>> > +                                   goodix_i2c_writets->client->irq, NULL,
>> > +                                   goodix_ts_irq_handler,
>> > +                                   goodix_irq_flags[ts->int_trigger_type],
>> > +                                   ts->client->name,
>> > +                                   ts);
>> > +   if (ret) {
>> > +           GOODIX_ERROR("Request IRQ failed! ERRNO:%d.", ret);
>> > +           return -1;
>> > +   }
>> > +
>> > +   disable_irq_nosync(ts->client->irq);
>>
>> Why nosync? And why do you need to disable? Yo just need to request it
>> later, after you've done querying the device. And why a separate funcion
>> for basically one statement?
>
> Removed, and merged into the calling function.
>
>> > +   return 0;
>> > +}
>> > +
>> > +/**
>> > + * goodix_request_input_dev - Allocate, populate and register the input device
>> > + *
>> > + * @ts: our goodix_ts_data pointer
>> > + *
>> > + * Must be called during probe
>> > + */
>> > +static int goodix_request_input_dev(struct goodix_ts_data *ts)
>> > +{
>> > +   int ret;
>> > +
>> > +   ts->input_dev = devm_input_allocate_device(&ts->client->dev);
>> > +   if (ts->input_dev == NULL) {
>> > +           GOODIX_ERROR("Failed to allocate input device.");
>> > +           return -ENOMEM;
>> > +   }
>> > +
>> > +   ts->input_dev->evbit[0] = BIT_MASK(EV_SYN) |
>> > +                             BIT_MASK(EV_KEY) |
>> > +                             BIT_MASK(EV_ABS);
>> > +
>> > +   input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
>> > +                           ts->abs_x_max, 0, 0);
>> > +   input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
>> > +                           ts->abs_y_max, 0, 0);
>> > +   input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
>> > +   input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>> > +
>> > +   input_mt_init_slots(ts->input_dev, GOODIX_MAX_TOUCH,
>> > +                       INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>> > +
>> > +   ts->input_dev->name = goodix_ts_name;
>> > +   ts->input_dev->phys = "input/ts";
>> > +   ts->input_dev->id.bustype = BUS_I2C;
>> > +   ts->input_dev->id.vendor = 0x0416;
>> > +   ts->input_dev->id.product = 0x1001;
>> > +   ts->input_dev->id.version = 10427;
>> > +
>> > +   ret = input_register_device(ts->input_dev);
>> > +   if (ret) {
>> > +           GOODIX_ERROR("Failed to register %s input device",
>> > +                     ts->input_dev->name);
>> > +           return -ENODEV;
>>
>> Why -ENODEV instead of ret?
>
> Fixed.
>
>> > +   }
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static int goodix_ts_probe(struct i2c_client *client,
>> > +           const struct i2c_device_id *id)
>> > +{
>> > +   int ret;
>> > +   struct goodix_ts_data *ts;
>> > +   u16 version_info;
>> > +
>> > +   GOODIX_INFO("GTP I2C Address: 0x%02x", client->addr);
>> > +
>> > +   if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>> > +           GOODIX_ERROR("I2C check functionality failed.");
>> > +           return -ENODEV;
>> > +   }
>> > +   ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
>> > +   if (ts == NULL) {
>>
>>       if (!ts)
>>
>> is a preferred form (by me at least).
>
> Fixed here and in goodix_request_input_dev().
>
>> > +           GOODIX_ERROR("Alloc GFP_KERNEL memory failed.");
>> > +           return -ENOMEM;
>> > +   }
>> > +
>> > +   ts->client = client;
>> > +   i2c_set_clientdata(client, ts);
>> > +
>> > +   ret = goodix_i2c_test(client);
>> > +   if (ret < 0) {
>> > +           client->addr = 0x5d;
>>
>> Umm, why? Let's trust board code/i2c core  to configure the i2c device
>> properly.

This is also a left over from the original driver. They used to change
the address in case of a reset of the device to check if it was in
bootloader mode or not. We just missed this one.

>
> Done.
>
>> > +           ret = goodix_i2c_test(client);
>> > +           if (ret < 0) {
>> > +                   GOODIX_ERROR("I2C communication ERROR!");
>> > +                   return -ENODEV;
>> > +           }
>> > +           GOODIX_INFO("GTP I2C new Address: 0x%02x", client->addr);
>> > +   }
>> > +
>> > +   goodix_read_config(ts);
>> > +
>> > +   ret = goodix_request_input_dev(ts);
>> > +   if (ret < 0) {
>> > +           GOODIX_ERROR("GTP request input dev failed");
>> > +           return ret;
>> > +   }
>> > +
>> > +   ret = goodix_request_irq(ts);
>> > +   if (ret < 0)
>> > +           return ret;
>> > +
>> > +   ret = goodix_read_version(client, &version_info);
>> > +   if (ret < 0) {
>> > +           GOODIX_ERROR("Read version failed.");
>> > +           return ret;
>> > +   }
>> > +
>> > +   enable_irq(ts->client->irq);
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static const struct i2c_device_id goodix_ts_id[] = {
>> > +   { "GDIX1001:00", 0 },
>> > +   { }
>>
>> Do we have to have this table?
>
> Yep, otherwise the driver won't detect the device. Benjamin tried to
> remove it as well ;)
>
> <snip>
>>
>> Thanks.
>
> Thank YOU for the thorough review.
>

Cheers,
Benjamin
