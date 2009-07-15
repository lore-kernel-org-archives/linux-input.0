From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 15:36:27 +0200
Message-ID: <20090715133627.GA2538@elf.ucw.cz>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650907140320w334864f4uc1ee13ed32fdb874-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi!

> > +static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
> > +{
>=20
> some documentation about this logic would be great.

Arve, can you help here?


> > + =A0 =A0 =A0 int pos[2][2];
> > + =A0 =A0 =A0 int f, a;
> > + =A0 =A0 =A0 int base =3D 2;
> > + =A0 =A0 =A0 int z =3D buf[1];
> > + =A0 =A0 =A0 int w =3D buf[0] >> 4;
> > + =A0 =A0 =A0 int finger =3D buf[0] & 7;
> > + =A0 =A0 =A0 int finger2_pressed;
> > +
> > + =A0 =A0 =A0 for (f =3D 0; f < 2; f++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 flip_flag =3D SYNAPTICS_FLIP_X;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (a =3D 0; a < 2; a++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D buf[base + =
1];
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p |=3D (u16)(buf[base=
] & 0x1f) << 8;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & flip_=
flag)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D=
 ts->max[a] - p;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & SYNAP=
TICS_SNAP_TO_INACTIVE_EDGE) {


> > +static irqreturn_t synaptics_ts_irq_handler(int irq, void *dev_id)
> > +{
> > + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D dev_id;
> > +
> > + =A0 =A0 =A0 disable_irq(ts->client->irq);
>=20
> disable_irq_nosync or convert this to request_threaded_irq(...).
> Please see recent discussion on linux-input for MAX key switch
> controller.

Do you have a link? (I replaced it with disable_irq_nosync, if that is
enough...)

> > +static int synaptics_ts_probe(
> > + =A0 =A0 =A0 struct i2c_client *client, const struct i2c_device_id=
 *id)
> > +{
>=20
> __devinit ?

Ok.

> > + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUN=
C_I2C)) {
>=20
> check for SMBUS? I have added linux-i2c as this driver has i2c bits,
> so not removing any code.

I guess this driver is only probed on mach-pxa... on machines that
have the neccessary hardware.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synaptics_ts_probe: =
need I2C_FUNC_I2C\n");
>=20
> dev_xxx/pr_xxx friends?

=46ixed all occurences.


> > + =A0 =A0 =A0 ts->input_dev =3D input_allocate_device();
> > + =A0 =A0 =A0 if (ts->input_dev =3D=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics: Failed to allocate=
 input device\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_dev_alloc_failed;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 ts->input_dev->name =3D "synaptics-rmi-touchscreen";
>=20
> other parameters of input_dev, like vendor, bus etc.,

Ok, what are those for? I can probably invent some dummy values, but...

> > + =A0 =A0 =A0 set_bit(EV_SYN, ts->input_dev->evbit);
> > + =A0 =A0 =A0 set_bit(EV_KEY, ts->input_dev->evbit);
> > + =A0 =A0 =A0 set_bit(BTN_TOUCH, ts->input_dev->keybit);
> > + =A0 =A0 =A0 set_bit(BTN_2, ts->input_dev->keybit);
> > + =A0 =A0 =A0 set_bit(EV_ABS, ts->input_dev->evbit);
> > +
>=20
> __set_bit or input_set_capability please.

__set_bit is easier, done.

> > +static int synaptics_ts_remove(struct i2c_client *client)
> > +{
>=20
> __devexit

Applied.


> > +static int synaptics_ts_suspend(struct i2c_client *client, pm_mess=
age_t mesg)
> > +{
>=20
> #ifdef CONFIG_PM ?

Yep.

> > +MODULE_DESCRIPTION("Synaptics Touchscreen Driver");
> > +MODULE_LICENSE("GPL");
>=20
> MODULE_ALIAS?

Umm, why? This is loaded from board-*.c files, and I don't think i2c
has enumeration capabilities.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
