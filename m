From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driver forbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 10:46:40 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <1251777330-16994-2-git-send-email-21cnbao@gmail.com><1251777330-16994-3-git-send-email-21cnbao@gmail.com> <8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:64395 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbZIBCqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2009 22:46:44 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 02, 2009 3:31 AM
>To: Barry Song
>Cc: dbrownell@users.sourceforge.net; dtor@mail.ru;=20
>dmitry.torokhov@gmail.com;=20
>spi-devel-general@lists.sourceforge.net;=20
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input=20
>driver forbutton/scrollwhell/slider/touchpad
>
>On Mon, Aug 31, 2009 at 23:55, Barry Song wrote:
>> ad7142/ad7147 are Programmable Controllers for Capacitance=20
>Touch Sensors.
>> The chips don't restrict the specific usage, and it can be=20
>used as button/
>> slider/scrollwheel/touchpad etc. depending on the hardware=20
>connection.
>> One special target board can include one or several these components=
=2E
>>
>> The driver is independent of special boards. It gets the components
>> layout information from the platform_data, registers related devices=
,
>> fullfills the algorithms and state machines for these components and
>> report related input events to up level.
>
>seems you didnt address all the comments i posted after your=20
>first commit ...
>
>please add this line before the #include's:
>#define pr_fmt(fmt) "ad714x: " fmt
>this will fix all of your dev_*() output so that it is=20
>properly prefixed

=46ixed.

>
>> +#define AD714x_SPI_ADDR =A0 =A0 =A0 =A00x1C
>> +#define AD714x_SPI_ADDR_SHFT =A0 11
>> +#define AD714x_SPI_READ =A0 =A0 =A0 =A01
>> +#define AD714x_SPI_READ_SHFT =A0 10
>> +
>> +#define AD714X_PWR_CTRL =A0 =A0 =A0 =A0 =A0 0x0
>> +#define AD714x_STG_CAL_EN_REG =A0 =A0 0x1
>> +#define AD714X_AMB_COMP_CTRL0_REG 0x2
>> +#define AD714x_PARTID_REG =A0 =A0 =A0 =A0 0x17
>> +#define AD7147_PARTID =A0 =A0 =A0 =A0 =A0 =A0 0x1470
>> +#define AD7142_PARTID =A0 =A0 =A0 =A0 =A0 =A0 0xE620
>> +#define AD714x_STAGECFG_REG =A0 =A0 =A0 0x80
>> +#define AD714x_SYSCFG_REG =A0 =A0 =A0 =A0 0x0
>
>your AD714X and AD714x needs to be consistent
=46ixed.
>
>> +struct ad714x_button_drv {
>> + =A0 =A0 =A0 ad714x_device_state state;
>> + =A0 =A0 =A0 /* Unlike slider/wheel/touchpad, all buttons point to
>> + =A0 =A0 =A0 =A0* same input_dev instance */
>
>either put the comment on one line and do:
>/* fooo */
>or use proper comment style where the last */ is on a line by itself
>/*
> * foo
> */
>this applies to many comments in this file

=46ixed.

>
>> +struct ad714x_chip {
>> + =A0 =A0 =A0 unsigned short h_state;
>> + =A0 =A0 =A0 unsigned short l_state;
>> + =A0 =A0 =A0 unsigned short c_state;
>> + =A0 =A0 =A0 unsigned short adc_reg[STAGE_NUM];
>> + =A0 =A0 =A0 unsigned short amb_reg[STAGE_NUM];
>> + =A0 =A0 =A0 unsigned short sensor_val[STAGE_NUM];
>> +
>> + =A0 =A0 =A0 struct ad714x_platform_data *hw;
>> + =A0 =A0 =A0 struct ad714x_driver_data *sw;
>> +
>> + =A0 =A0 =A0 bus_device *bus;
>> + =A0 =A0 =A0 int (*read) (bus_device *, unsigned short, unsigned sh=
ort *);
>> + =A0 =A0 =A0 int (*write) (bus_device *, unsigned short, unsigned s=
hort);
>
>using function pointers is pure overhead in your current
>implementation.  create a ad714x_read macro that expands to either the
>spi or the i2c version depending on which is enabled.
Using macro can be a choice. But I don't think it can save much overhea=
d here.=20
=46unction pointers encapsulates the object better.
>
>> +static void stage_use_com_int(struct ad714x_chip *ad714x,=20
>int start_stage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int end_stage)
>> +{
>
>all funcs in here really should have ad714x_ symbol prefixes.  if i
>saw a crash and it just said "stage_xxx", it isnt immediately obvious
>where this symbol is coming from.

=46ixed.

>
>> +static int stage_cal_highest_stage(struct ad714x_chip=20
>*ad714x, int start_stage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int end_stage)
>> +{
>> + =A0 =A0 =A0 int max_res =3D 0;
>> + =A0 =A0 =A0 int max_idx =3D 0;
>> + =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 for (i =3D start_stage; i <=3D end_stage; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ad714x->sensor_val[i] > max_res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_res =3D ad714x->se=
nsor_val[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_idx =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>
>should the loop limit really be "<=3D" and not "<" ?  seems to be this
>way throughout, so maybe the logic is correct ...

It's <=3D.

>
>> +static int stage_cal_abs_pos(struct ad714x_chip *ad714x,=20
>int start_stage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int end_stage, int highest_stage, int =
max_coord)
>> +{
>> + =A0 =A0 =A0 int a_param, b_param;
>> +
>> + =A0 =A0 =A0 if (highest_stage =3D=3D start_stage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[start_s=
tage + 1];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[start_s=
tage] +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[sta=
rt_stage + 1];
>> + =A0 =A0 =A0 } else if (highest_stage =3D=3D end_stage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[end_sta=
ge] *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (end_stage - start_sta=
ge) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[end=
_stage - 1] *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (end_stage - start_sta=
ge - 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[end_sta=
ge] +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[end=
_stage - 1];
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[highest=
_stage] *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - start=
_stage) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[hig=
hest_stage - 1] *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - start=
_stage - 1) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[hig=
hest_stage + 1] *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - start=
_stage + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[highest=
_stage] +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[hig=
hest_stage - 1] +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[hig=
hest_stage + 1];
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return (max_coord / (end_stage - start_stage)) *=20
>a_param / b_param;
>> +}
>
>do the local vars really need "_stage" suffix ?  if you trimmed that,
>i imagine it'd make the code a bit easier to digest.
Yes. It need the _stage suffix. Otherwise, nobody know what's started, =
what's ended.
>
>> +/* One button can connect to multi postive and negative of CDCs
>> + * Multi-buttons can connect to same postive/negative of one CDC
>
>please run a spell checker on your comments ...
>postive -> positive
>

=46ixed

>> +static int ad714x_hw_detect(struct ad714x_chip *ad714x)
>
>should be __devinit
>
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ad714x->bus->dev, "Fail to de=
tect=20
>AD714x captouch,\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read I=
D is %04x\n", data);
>
>line continuation in strings produces awful output
>

=46ixed

>> +static int ad714x_hw_init(struct ad714x_chip *ad714x)
>> ...
>> +       return 0;
>> ...
>> +       ad714x_hw_init(ad714x);
>
>considering you always return 0 and you never check the return, this
>should be a void function
>
>and ad714x_hw_init should be __devinit

=46ixed.

>
>> + =A0 =A0 =A0 drv_data =3D kzalloc(sizeof(struct=20
>ad714x_driver_data), GFP_KERNEL);
>
>sizeof(*drv_data) ... applies to every alloc in this driver
>
>> + input[alloc_idx-1]->id.bustype =3D BUS_I2C;
>
>you set bustype to I2C in common code even though this will be
>executed for both SPI and I2C interfaces

There is a BUS_I2C, but no BUS_SPI. So people may use other serial type=
 to imply.=20
Do you think we should add a macro in input.h? I am really suprised why=
 the macro hasn't been added until now.=20

>
>> + =A0 =A0 =A0 if (ad714x->bus->irq > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(ad714x->b=
us->irq,=20
>ad714x_interrupt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x=
_interrupt_thread,=20
>IRQF_TRIGGER_FALLING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ad714=
x_captouch", ad714x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ad714x->bus->=
dev, "Can't=20
>allocate irq %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ad714x->bus->irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ad714x->bus->dev, "IRQ not c=
onfigured!\n");
>> +
>> +       return 0;
>
>since the driver requires an IRQ in order to work, this should error
>out rather than warn and return success
>
>also, wouldnt it make more sense to request the IRQ first and then
>fail rather than doing all the memory/input allocation only to find
>out the IRQ is already taken ?
>

Ok

>> +int ad714x_spi_read(struct spi_device *spi, unsigned short reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short *data)
>
>you're missing "static" here and in a few other functions

=46ixed

>
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 unsigned short tx[2];
>> + =A0 =A0 =A0 unsigned short rx[2];
>> + =A0 =A0 =A0 struct spi_transfer t =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D tx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rx_buf =3D rx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 4,
>> + =A0 =A0 =A0 };
>> + =A0 =A0 =A0 struct spi_message m;
>> +
>> + =A0 =A0 =A0 tx[0] =3D (AD714x_SPI_ADDR << AD714x_SPI_ADDR_SHFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (AD714x_SPI_READ << AD714x_SPI_READ_SH=
=46T) | reg;
>> +
>> + =A0 =A0 =A0 spi_message_init(&m);
>> + =A0 =A0 =A0 spi_message_add_tail(&t, &m);
>> + =A0 =A0 =A0 ret =3D spi_sync(spi, &m);
>
>cant you use spi_write_then_read() ?  dont let the u8* prototype scare
>you, it should work with writing 16bits and then reading 16bits.

I have never been scared by any u8* or something else. I only prefer to=
 use raw spi API, which can show the bottom level timing and SPI bus fe=
ature better.=20
In fact, I prefer to use raw i2c API too.=20

>
>> +int ad714x_spi_write(struct spi_device *spi, unsigned short reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short data)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 unsigned short tx[2];
>> + =A0 =A0 =A0 struct spi_transfer t =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D tx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 4,
>> + =A0 =A0 =A0 };
>> + =A0 =A0 =A0 struct spi_message m;
>> +
>> + =A0 =A0 =A0 tx[0] =3D (AD714x_SPI_ADDR << AD714x_SPI_ADDR_SHFT) | =
reg;
>> + =A0 =A0 =A0 tx[1] =3D data;
>> +
>> + =A0 =A0 =A0 spi_message_init(&m);
>> + =A0 =A0 =A0 spi_message_add_tail(&t, &m);
>> +
>> + =A0 =A0 =A0 ret =3D spi_sync(spi, &m);
>> + =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "SPI write error\n"=
);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>
>seems like spi_write() would be better
>
>> +static int __devexit ad714x_i2c_remove(struct i2c_client *client)
>> +{
>> +       struct ad714x_chip *chip =3D i2c_get_clientdata(client);
>> +       ad714x_remove(chip);
>> +
>> +       return 0;
>> +}
>
>return ad714x_remove(chip);

=46ixed.

>
>of course, if you simply created a macro "ad714x_get_chipdata" and had
>it evaluate to either the spi or i2c version depending on the
>interface enabled, this function could be in common code rather than
>duplicating it for the two interfaces
>

In fact, dev_set_drvdata and dev_get_drvdata can be used in spi/i2c pro=
be and remove. Then the probe/remove can be unified.
But at the beginning, I prefer to keep this little redundancy, which ma=
ybe make the code more readable.=20
Maybe I will use a unified probe/remove for SPI/I2C too, Let me think..=
=2E

>same goes for the module init/exit functions
>
>> +static struct spi_driver ad714x_spi_driver =3D {
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "ad714x_captouch",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus =A0 =A0=3D &spi_bus_type,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>
>i'm pretty sure you dont need to set .bus yourself

=46ixed.

>
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D ad714x_spi_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad714x_spi_rem=
ove),
>> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D ad714x_suspend,
>> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D ad714x_resume,
>
>there is a new power management opts struct in 2.6.31 that=20
>should be used

Ok

>
>> +static int __init ad714x_init(void)
>> +{
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 ret =3D spi_register_driver(&ad714x_spi_driver);
>> + =A0 =A0 =A0 if (ret !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to register ad=
714x=20
>SPI driver: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>

Ok

>pr_err(), no need for the braces, and no need to output the ret value.
> this is the module init function which means that error will be
>passed back up to userspace and it can handle displaying it.  in that
>case, it might as well read:
>{
>    return spi_register_driver(&ad714x_spi_driver);
>}

=46ixed

>
>> + =A0 =A0 =A0 u8 tx[4];
>> +
>> + =A0 =A0 =A0 /* Do raw I2C, not smbus compatible */
>> + =A0 =A0 =A0 tx[0] =3D (reg & 0xFF00) >> 8;
>> + =A0 =A0 =A0 tx[1] =3D (reg & 0x00FF);
>> + =A0 =A0 =A0 tx[2] =3D (data & 0xFF00) >> 8;
>> + =A0 =A0 =A0 tx[3] =3D data & 0x00FF;
>
>the masks are pretty useless (and i wouldnt be surprised if gcc doesnt
>optimize all of them away) since you're already loading into a u8
>tx[4] =3D {
>    reg >> 8,
>    reg,
>    data >> 8,
>    data,
>};
>
>> + =A0 =A0 =A0 u8 tx[2];
>> +
>> + =A0 =A0 =A0 /* Do raw I2C, not smbus compatible */
>> + =A0 =A0 =A0 tx[0] =3D (reg & 0xFF00) >> 8;
>> + =A0 =A0 =A0 tx[1] =3D (reg & 0x00FF);
>
>same here
>
>> + =A0 =A0 =A0 *data =3D rx[0];
>> + =A0 =A0 =A0 *data =3D (*data << 8) | rx[1];
>
>erm, this is funky.  why cant you do it with one assignment ?
>
>> +MODULE_DESCRIPTION("ad714x captouch driver");
>
>please use a description like you did in the Kconfig

=46ixed

>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
