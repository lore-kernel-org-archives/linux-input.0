From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 23:03:02 +0530
Message-ID: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090715133627.GA2538-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Pavel,

On Wed, Jul 15, 2009 at 7:06 PM, Pavel Machek<pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Hi!
>
>> > +static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
>> > +{
>>
>> some documentation about this logic would be great.
>
> Arve, can you help here?
>
>
>> > + =A0 =A0 =A0 int pos[2][2];
>> > + =A0 =A0 =A0 int f, a;
>> > + =A0 =A0 =A0 int base =3D 2;
>> > + =A0 =A0 =A0 int z =3D buf[1];
>> > + =A0 =A0 =A0 int w =3D buf[0] >> 4;
>> > + =A0 =A0 =A0 int finger =3D buf[0] & 7;
>> > + =A0 =A0 =A0 int finger2_pressed;
>> > +
>> > + =A0 =A0 =A0 for (f =3D 0; f < 2; f++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 flip_flag =3D SYNAPTICS_FLIP_X;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (a =3D 0; a < 2; a++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D buf[base +=
 1];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p |=3D (u16)(buf[bas=
e] & 0x1f) << 8;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & flip=
_flag)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D=
 ts->max[a] - p;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & SYNA=
PTICS_SNAP_TO_INACTIVE_EDGE) {
>
>
>> > +static irqreturn_t synaptics_ts_irq_handler(int irq, void *dev_id=
)
>> > +{
>> > + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D dev_id;
>> > +
>> > + =A0 =A0 =A0 disable_irq(ts->client->irq);
>>
>> disable_irq_nosync or convert this to request_threaded_irq(...).
>> Please see recent discussion on linux-input for MAX key switch
>> controller.
>
> Do you have a link? (I replaced it with disable_irq_nosync, if that i=
s
> enough...)
>

link: http://patchwork.kernel.org/patch/35515/

>> > +static int synaptics_ts_probe(
>> > + =A0 =A0 =A0 struct i2c_client *client, const struct i2c_device_i=
d *id)
>> > +{
>>
>> __devinit ?
>
> Ok.
>
>> > + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FU=
NC_I2C)) {
>>
>> check for SMBUS? I have added linux-i2c as this driver has i2c bits,
>> so not removing any code.
>
> I guess this driver is only probed on mach-pxa... on machines that
> have the neccessary hardware.

Because this driver is using smbus i2c apis, it will be good to add
that check too.

>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synaptics_ts_probe:=
 need I2C_FUNC_I2C\n");
>>
>> dev_xxx/pr_xxx friends?
>
> Fixed all occurences.
>
>
>> > + =A0 =A0 =A0 ts->input_dev =3D input_allocate_device();
>> > + =A0 =A0 =A0 if (ts->input_dev =3D=3D NULL) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics: Failed to allocat=
e input device\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_dev_alloc_failed;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 ts->input_dev->name =3D "synaptics-rmi-touchscreen";
>>
>> other parameters of input_dev, like vendor, bus etc.,
>
> Ok, what are those for? I can probably invent some dummy values, but.=
=2E.

May be vendor, product, version would be good to add.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
