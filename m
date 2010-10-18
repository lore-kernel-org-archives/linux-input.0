From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Sun, 17 Oct 2010 21:24:28 -0700
Message-ID: <20101018042428.GA23778@core.coreip.homeip.net>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
 <20101018040810.GB7782@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55612 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0JREYg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 00:24:36 -0400
Received: by iwn35 with SMTP id 35so671117iwn.19
        for <linux-input@vger.kernel.org>; Sun, 17 Oct 2010 21:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018040810.GB7782@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: michael.hennerich@analog.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Sun, Oct 17, 2010 at 09:08:10PM -0700, Dmitry Torokhov wrote:
> On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
> > On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com> wrot=
e:
> > > Suppress events where pressure > pressure_max.
> > > These events come typically along with inaccurate X and Y samples=
=2E
> >=20
> > were you going to commit to the blackfin tree ?
> >=20
> > > --- a/drivers/input/touchscreen/ad7877.c
> > > +++ b/drivers/input/touchscreen/ad7877.c
> > > @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt /=3D z1;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Rt =3D (Rt + 2047) >> 12;
> > >
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Sample found inconsistent, pre=
ssure is beyond
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the maximum. Don't report it t=
o user space.
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (Rt > ts->pressure_max)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >=20
> > this has spaces in the middle of your tab indents ...
>=20
> I took care of that on my side...
>=20

BTW, I have a couple more small patches to the driver... Here is the
first:

Input: ad7877 - use attribute group to control visibility of attributes

Instead of manually creating one set of attributes or another set up
is_visible method in attribute group structure to control whether
aux3 or gpio3 attribute is oresented to userspace.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7877.c |   49 +++++++++++++++++++++-------=
--------
 1 files changed, 29 insertions(+), 20 deletions(-)


diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchsc=
reen/ad7877.c
index b7de78e..326d733 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -206,8 +206,8 @@ struct ad7877 {
 	u16 conversion_data[AD7877_NR_SENSE] ____cacheline_aligned;
 };
=20
-static int gpio3;
-module_param(gpio3, int, 0);
+static bool gpio3;
+module_param(gpio3, bool, 0);
 MODULE_PARM_DESC(gpio3, "If gpio3 is set to 1 AUX3 acts as GPIO3");
=20
 /*
@@ -471,7 +471,7 @@ static void ad7877_enable(struct ad7877 *ts)
 #define SHOW(name) static ssize_t \
 name ## _show(struct device *dev, struct device_attribute *attr, char =
*buf) \
 { \
-	struct ad7877	*ts =3D dev_get_drvdata(dev); \
+	struct ad7877 *ts =3D dev_get_drvdata(dev); \
 	ssize_t v =3D ad7877_read_adc(ts->spi, \
 			AD7877_READ_CHAN(name)); \
 	if (v < 0) \
@@ -491,7 +491,7 @@ SHOW(temp2)
 static ssize_t ad7877_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct ad7877	*ts =3D dev_get_drvdata(dev);
+	struct ad7877 *ts =3D dev_get_drvdata(dev);
=20
 	return sprintf(buf, "%u\n", ts->disabled);
 }
@@ -521,7 +521,7 @@ static DEVICE_ATTR(disable, 0664, ad7877_disable_sh=
ow, ad7877_disable_store);
 static ssize_t ad7877_dac_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct ad7877	*ts =3D dev_get_drvdata(dev);
+	struct ad7877 *ts =3D dev_get_drvdata(dev);
=20
 	return sprintf(buf, "%u\n", ts->dac);
 }
@@ -551,7 +551,7 @@ static DEVICE_ATTR(dac, 0664, ad7877_dac_show, ad78=
77_dac_store);
 static ssize_t ad7877_gpio3_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct ad7877	*ts =3D dev_get_drvdata(dev);
+	struct ad7877 *ts =3D dev_get_drvdata(dev);
=20
 	return sprintf(buf, "%u\n", ts->gpio3);
 }
@@ -582,7 +582,7 @@ static DEVICE_ATTR(gpio3, 0664, ad7877_gpio3_show, =
ad7877_gpio3_store);
 static ssize_t ad7877_gpio4_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct ad7877	*ts =3D dev_get_drvdata(dev);
+	struct ad7877 *ts =3D dev_get_drvdata(dev);
=20
 	return sprintf(buf, "%u\n", ts->gpio4);
 }
@@ -615,16 +615,35 @@ static struct attribute *ad7877_attributes[] =3D =
{
 	&dev_attr_temp2.attr,
 	&dev_attr_aux1.attr,
 	&dev_attr_aux2.attr,
+	&dev_attr_aux3.attr,
 	&dev_attr_bat1.attr,
 	&dev_attr_bat2.attr,
 	&dev_attr_disable.attr,
 	&dev_attr_dac.attr,
+	&dev_attr_gpio3.attr,
 	&dev_attr_gpio4.attr,
 	NULL
 };
=20
+static mode_t ad7877_attr_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int n)
+{
+	mode_t mode =3D attr->mode;
+
+	if (attr =3D=3D &dev_attr_aux3.attr) {
+		if (gpio3)
+			mode =3D 0;
+	} else if (attr =3D=3D &dev_attr_gpio3.attr) {
+		if (!gpio3)
+			mode =3D 0;
+	}
+
+	return mode;
+}
+
 static const struct attribute_group ad7877_attr_group =3D {
-	.attrs =3D ad7877_attributes,
+	.is_visible	=3D ad7877_attr_is_visible,
+	.attrs		=3D ad7877_attributes,
 };
=20
 static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad7=
877 *ts)
@@ -787,20 +806,12 @@ static int __devinit ad7877_probe(struct spi_devi=
ce *spi)
 	if (err)
 		goto err_free_irq;
=20
-	err =3D device_create_file(&spi->dev,
-				 gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
-	if (err)
-		goto err_remove_attr_group;
-
 	err =3D input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr;
+		goto err_remove_attr_group;
=20
 	return 0;
=20
-err_remove_attr:
-	device_remove_file(&spi->dev,
-			   gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
 err_remove_attr_group:
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
 err_free_irq:
@@ -814,11 +825,9 @@ err_free_mem:
=20
 static int __devexit ad7877_remove(struct spi_device *spi)
 {
-	struct ad7877		*ts =3D dev_get_drvdata(&spi->dev);
+	struct ad7877 *ts =3D dev_get_drvdata(&spi->dev);
=20
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-	device_remove_file(&spi->dev,
-			   gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
=20
 	ad7877_disable(ts);
 	free_irq(ts->spi->irq, ts);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
