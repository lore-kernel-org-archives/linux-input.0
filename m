From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Synaptics touchscreen for HTC Dream: check that smbus is available
Date: Sat, 8 Aug 2009 15:40:50 +0200
Message-ID: <20090808134049.GA13083@elf.ucw.cz>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090721102153.GE4133@elf.ucw.cz> <5d5443650907210334k3f562cebsc665511a161c8639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650907210334k3f562cebsc665511a161c8639-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> >> Because this driver is using smbus i2c apis, it will be good to ad=
d
> >> that check too.
> >
> > So I should do something like
> >
> > if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_D=
ATA))
> > =A0 =A0 =A0 =A0...
> >
> > in addition?
>=20
> Yes.

Ok, here it is.

---=20

Check that SMBUS APIs are available in touchscreen driver.
   =20
Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/stagin=
g/dream/synaptics_i2c_rmi.c
index dc1e3c7..6e23276 100644
--- a/drivers/staging/dream/synaptics_i2c_rmi.c
+++ b/drivers/staging/dream/synaptics_i2c_rmi.c
@@ -373,6 +373,12 @@ static int __devinit synaptics_ts_probe(
 		goto err_check_functionality_failed;
 	}
=20
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DAT=
A)) {
+		pr_err("synaptics_ts_probe: need I2C_FUNC_SMBUS_WORD_DATA\n");
+		ret =3D -ENODEV;
+		goto err_check_functionality_failed;
+	}
+
 	ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
 	if (ts =3D=3D NULL) {
 		ret =3D -ENOMEM;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
