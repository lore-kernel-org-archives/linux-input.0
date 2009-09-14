From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] HAPTIC: add HAPTIC class
Date: Mon, 14 Sep 2009 16:05:52 +0530
Message-ID: <5d5443650909140335h6a81c684h2846c5365e144425@mail.gmail.com>
References: <4AA62BFF.2050703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754950AbZINKf5@vger.kernel.org>
In-Reply-To: <4AA62BFF.2050703@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kmpark@infradead.org, dg77.kim@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Kyungmin Park,

> +
> +static ssize_t haptic_value_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t size)
> +{
> + =A0 =A0 =A0 struct haptic_classdev *haptic_cdev =3D dev_get_drvdata=
(dev);
> + =A0 =A0 =A0 ssize_t ret =3D -EINVAL;
> + =A0 =A0 =A0 char *after;
> + =A0 =A0 =A0 unsigned long state =3D simple_strtoul(buf, &after, 10)=
;

s/simple_strtoul/strict_strtoul. code looks clean, but let's scan it
through scripts/checkpatch.pl.

> diff --git a/drivers/haptic/haptic.h b/drivers/haptic/haptic.h
> new file mode 100644
> index 0000000..888aaa3
> --- /dev/null
> +++ b/drivers/haptic/haptic.h
> @@ -0,0 +1,35 @@
> +/*
> + * =A0Haptic Core
> + *
> + * =A0Copyright (C) 2008 Samsung Electronics
> + * =A0Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __HAPTIC_H_INCLUDED
> +#define __HAPTIC_H_INCLUDED
> +
> +#include <linux/device.h>
> +#include <linux/rwsem.h>
> +#include <linux/haptic.h>
> +
> +static inline void haptic_set_value(struct haptic_classdev *haptic_c=
dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enum haptic_value value)
> +{
> + =A0 =A0 =A0 if (value > HAPTIC_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D HAPTIC_FULL;
> + =A0 =A0 =A0 haptic_cdev->value =3D value;
> + =A0 =A0 =A0 if (!(haptic_cdev->flags & HAPTIC_SUSPENDED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic_cdev->set(haptic_cdev, value);
> +}
> +
> +static inline int haptic_get_value(struct haptic_classdev *haptic_cd=
ev)
> +{
> + =A0 =A0 =A0 return haptic_cdev->value;
> +}

You had mentioned in Kconfig help text that haptics set/get APIs can
be accessed from kernel drivers too, I am not able to understand that
from this code.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
