From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Tue, 13 Oct 2009 18:45:48 +0200
Message-ID: <ac3eb2510910130945w2e87d84bjfa3291989d85375b@mail.gmail.com>
References: <20091006074533.GA28889@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760482AbZJMQrR@vger.kernel.org>
In-Reply-To: <20091006074533.GA28889@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, Greg Kroah-Hartmann <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 6, 2009 at 09:45, Kyungmin Park <kmpark@infradead.org> wrot=
e:

> +/**
> + * haptic_classdev_register - register a new object of haptic_classd=
ev class.
> + * @dev: The device to register.
> + * @haptic_cdev: the haptic_classdev structure for this device.
> + */
> +int haptic_classdev_register(struct device *parent,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct haptic_classdev *haptic_cdev=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 haptic_cdev->dev =3D device_create(haptic_clas=
s, parent, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 haptic_cdev, "%s", haptic_cdev->nam=
e);
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(haptic_cdev->dev))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(hap=
tic_cdev->dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* register the attributes */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D class_create_file(haptic_class, &class=
_attr_enable);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "%=
s: class_create_file(enable) failed\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }

As mentioned in an earlier mail, this needs some explanation. What are
you doing here? Creating a device below a class, and then add a bunch
of attributes to the class itself, instead of the device you created?

All calls to class_create_file() need to go, we can not allow any new
users of this broken interface. As mentioned, if you need
subsystem-wide attributes you need to use a bus and not a class,
classes are flat and can not handle such things properly.

Thanks,
Kay
