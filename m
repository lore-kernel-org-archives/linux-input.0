From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Tue, 20 Oct 2009 12:14:46 +0530
Message-ID: <5d5443650910192344v5c396033g55ad8cd85370dbb4@mail.gmail.com>
References: <20091006074533.GA28889@july>
	 <ac3eb2510910130945w2e87d84bjfa3291989d85375b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:48757 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbZJTGom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 02:44:42 -0400
In-Reply-To: <ac3eb2510910130945w2e87d84bjfa3291989d85375b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>, Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartmann <greg@kroah.com>

Hi Kyungmin,

On Tue, Oct 13, 2009 at 10:15 PM, Kay Sievers <kay.sievers@vrfy.org> wr=
ote:
> On Tue, Oct 6, 2009 at 09:45, Kyungmin Park <kmpark@infradead.org> wr=
ote:
>
>> +/**
>> + * haptic_classdev_register - register a new object of haptic_class=
dev class.
>> + * @dev: The device to register.
>> + * @haptic_cdev: the haptic_classdev structure for this device.
>> + */
>> +int haptic_classdev_register(struct device *parent,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 haptic_classdev *haptic_cdev)
>> +{
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 haptic_cdev->dev =3D device_create(haptic_class, paren=
t, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic=
_cdev, "%s", haptic_cdev->name);
>> + =A0 =A0 =A0 if (IS_ERR(haptic_cdev->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(haptic_cdev->dev);
>> +
>> + =A0 =A0 =A0 /* register the attributes */
>> + =A0 =A0 =A0 ret =3D class_create_file(haptic_class, &class_attr_en=
able);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: class_create_file=
(enable) failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__f=
unc__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>
> As mentioned in an earlier mail, this needs some explanation. What ar=
e
> you doing here? Creating a device below a class, and then add a bunch
> of attributes to the class itself, instead of the device you created?
>
> All calls to class_create_file() need to go, we can not allow any new
> users of this broken interface. As mentioned, if you need
> subsystem-wide attributes you need to use a bus and not a class,
> classes are flat and can not handle such things properly.
>
> Thanks,
> Kay
>

Any plan of refreshing these patches?


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
