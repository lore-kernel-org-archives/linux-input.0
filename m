From: "Roman Bange" <mofasofa123@gmx.de>
Subject: SYN1B7F:00 06CB:2970 UNKNOWN does not work with Kernel 4.2.x
 anymore Edit
Date: Fri, 24 Jul 2015 22:24:49 +0200
Message-ID: <trinity-ab0d9c91-a25d-4070-a658-5126c0e3cac1-1437769488907@3capp-gmx-bs35>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54324 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbbGXUYv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 16:24:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey guys,
the Touchpad of my Acer VN7-571G doesn't work under the upstream mainli=
ne Kernel anymore. Im running Ubuntu 15.04.

I: Bus=3D0018 Vendor=3D06cb Product=3D2970 Version=3D0100
N: Name=3D"SYN1B7F:00 06CB:2970 UNKNOWN"
P: Phys=3D
S: Sysfs=3D/devices/pci0000:00/INT3433:00/i2c-0/i2c-SYN1B7F:00/0018:06C=
B:2970.0001/input/input7
U: Uniq=3D
H: Handlers=3Dmouse0 event7

There were always some errors in dmesg, but the touchpad worked nice. B=
ooting with the new mainline Kernels, it crashes.
Here you can find some reports of a self written test for a variety of =
Kernels: https://www.dropbox.com/sh/fpc809htqzx3hfk/AABDjGPT0I67L-jFqe-=
8RUSFa?dl=3D0
The test contains the output of:
dmesg | grep i2c
dmesg | grep hid
xinput

On the self compiled kernel=C2=A04.2.0-rc3-wl-ath from the ath tree, i =
reverted the only commit from for-4.2/i2c branch:
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hi=
d.c
index 92d6cdf..0dfb5d1 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1019,7 +1019,6 @@ static int i2c_hid_probe(struct i2c_client *clien=
t,
=C2=A0=C2=A0hid->driver_data =3D client;
=C2=A0=C2=A0hid->ll_driver =3D &i2c_hid_ll_driver;
=C2=A0=C2=A0hid->dev.parent =3D &client->dev;
- ACPI_COMPANION_SET(&hid->dev, ACPI_COMPANION(&client->dev));
=C2=A0=C2=A0hid->bus =3D BUS_I2C;
=C2=A0=C2=A0hid->version =3D le16_to_cpu(ihid->hdesc.bcdVersion);
=C2=A0=C2=A0hid->vendor =3D le16_to_cpu(ihid->hdesc.wVendorID);

But the Touchpad still doesnt work.
=C2=A0
Greets,
Roman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
