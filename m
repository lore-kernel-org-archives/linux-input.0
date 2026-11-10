Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.6.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326887;
	b=FCmGlhUUpEJ3+jkmcOtxWcFHItCucy+r0i6pgZMYvAWlMsg28NO7wnJ0+OU8/cx6AjuP
	 0ATNaFAguvswHu5YssFYO+BzIacxHvzapzhGZRnf81iz/9HB0vMO3MtL/kAaUqMBEQVs5
	 mIHVI7eBcNPSxO7VbqsNjIjJBmodk9YtQs9UEYCmoFR43rfEm/BxjeHdwWDlU9nZlvAFG
	 D6BM9oQlZkqfUidrz4NV7fLB5SmPH9X+fbIaoUKseQzbbD3kIFVSalOZwlbx9Tzth7noo
	 HpOk1ONubcaMVoMRZDtGkZFhWEvzn5P1DIl665jPYod7QFPnZ0E909v76WL1hooutlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326887;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer:From:To:Cc:
	 Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:
	 Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=nXZaAGBRf4UciZRAV97Kr7EaxvMvbLbdrcoBmt2p9Q0=;
	b=oetjsQYJhCvS40995FazNWvxBpOUSfxj9Z7goHACXcVaA7VPFUPj3izKsDn5XOmKMIzx
	 yhMKuyWbLw7DcJ3uHzFWIT+64prvoLZl4bIKdPHZ7IB1CdVJLU7dCu4yZRgcsC4UbaKDi
	 p1OroD1/mVvIa4Q0Qr60dkPUVnNThZKrwac+Ub/t1LlIR0+nKNoRl/oh728+lpSQPTDmk
	 /Em9KD+/RFZdXMR/xS9zr0ISy6AKzRcNsOtZ4PoosCPhoo9gucmTjGutHQXZiG1ZgH1aT
	 Xb1VjIQCjtQOvyTnwZrxwe1ePDlqp6ZDzlCy9dzpnvmZSqcrg2yQvXSNU2wva3w3RlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=horotw.dev;
	spf=pass smtp.mailfrom=send.horotw.dev;
	dkim=pass header.d=horotw.dev header.i=@horotw.dev header.a=rsa-sha256 header.s=resend header.b=f6hSg4qS;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=shh3fegwg5fppqsuzphvschd53n6ihuv header.b=OeYmvbrq;
	arc=none smtp.remote-ip=54.240.6.53
Received: from a6-53.smtp-out.eu-west-1.amazonses.com (a6-53.smtp-out.eu-west-1.amazonses.com [54.240.6.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AA606A31C;
	Tue, 10 Nov 2026 16:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horotw.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.horotw.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=horotw.dev header.i=@horotw.dev header.a=rsa-sha256 header.s=resend header.b=f6hSg4qS;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=shh3fegwg5fppqsuzphvschd53n6ihuv header.b=OeYmvbrq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=horotw.dev; t=1794326885;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Q7jGvzifsBcjfG0e/820Z33fDAwfuKWyt8nRK8W513c=;
	b=f6hSg4qSrO5v8T63h4dNX5gUXDuyWSz4dnnjs2kBcbMby0CboGFBsjRM8/rcCsrF
	iwUbTJK7hYVNhZiF4fC7EokTjgzI6t5T+biXxO0b/rdHij+vLFM58bvb7qHlQNonni9
	Q2RHjQKIRJwmR6nX2AAFkDfuhST5zAsjmvlnc9AI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1794326885;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Q7jGvzifsBcjfG0e/820Z33fDAwfuKWyt8nRK8W513c=;
	b=OeYmvbrqAXXW7V1SBHLKB6sCV4TNMbf9ngN5GUDKrYLeTjXfr+sOYLefPFBKlv0p
	3rm2Gc9j+a8dpRpexGTuRksbHurzXwfXh1iS2HEYoytgvMCj78xVBv++dKfWgUTbvQy
	DwF0KBLjLMN+VbCA9r+p704mS65RevnsQVp+K5gE=
X-Mailer: git-send-email 2.43.0
From: HoroTW <git@horotw.dev>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mika.westerberg@linux.intel.com, andy@kernel.org, git@horotw.dev
Subject: [PATCH] HID: i2c-hid: acpi: Add Dell Latitude 7400 2-in-1
 touchscreen power quirk
Message-ID: <010201a1c63771e5-dbbba1f2-8a9f-4dbc-8901-c60927cf5a56-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:08:04 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.OH8L+a2j9VuJMq9Utm7y7N5SZIBUCzGuSCa3PL2C3F9T7RvQnZ1WsPUpJmIAhzgtiQw73eHenzuz9dr01UwDVSVgYd7eFRHl3azv1IlcMxwID9WFheHWTU6HvPuLbPTkJYw4kFg+q28gLw45+PEMDiK6tT0BxCRKqGL3o1b8OL4=:1.eu-west-1.KEYBhYy5skZtLAf2ooWkoQwfhj0g1VAvm2T4fzvEpSk=:AmazonSES
X-SES-Outgoing: 2026.11.10-54.240.6.53

On the Dell Latitude 7400 2-in-1, the Wacom touchscreen (WCOM48CA) does
not work after resume from S3. Resume runs into I2C timeouts for 4 to 37
seconds and then fails:

  [37928.985861] i2c_designware i2c_designware.0: =
controller timed out
  [37928.986100] i2c_hid_acpi i2c-WCOM48CA:00: failed =
to change power setting.
  [37928.986340] i2c_hid_acpi i2c-WCOM48CA:00: PM:=
 dpm_run_callback(): acpi_subsys_resume returns -110

The controller has a power enable on GPP_B21 and an active-low reset on
GPP_B15. The firmware sets both up at boot, but ACPI does not describe
them: TPL0's _CRS only lists the I2C bus and the interrupt, and there is
no _PS0, _PS3 or _PR0. After S3 the firmware leaves both pads low, so
the controller stays unpowered and in reset. pinctrl-intel does not
restore them either, as it only saves pads that the kernel has requested.

Add a DMI quirk that provides the two GPIOs through a GPIO lookup table,
and power_up()/power_down() callbacks that sequence them like i2c-hid-of
does: power on, wait, release reset, wait. Holding the GPIOs from probe
makes pinctrl-intel save and restore the pads, and power_down() drives
them low first, so power_up() always starts from the powered-down state.

As far as I can tell from the BIOS image, the firmware waits about 9 ms
after enabling power before pulsing reset, so use 10 ms. Starting the
first transfer less than 3 ms after releasing reset makes SET_POWER fail
with -121, while 100 ms and 1000 ms both work; use 200 ms for some
margin, as I could not find a datasheet value.

As the touchscreen is not a=
 wakeup source, the controller is now also
powered down in s2idle and for =
hibernation.

Tested on a Latitude 7400 2-in-1 (BIOS 1.39.1) in S3, s2idle =
and
hibernation (pm_test=3Ddevices).

AI notice: I threw an AI coding agent=
 against it which wrote most of
the initial patch, I reviewed everything, =
directed the investigation
and ensured this is a minimal patch. The agent =
ran the initial tests
(via a KVM switch), and I tested it on the device =
myself as well.

Signed-off-by: HoroTW <git@horotw.dev>
---

Notes:
    This is my first kernel patch, so sorry in advance for anything I got
    wrong; I would be glad about any feedback.. I tried hard to match the
    required ettiquete.
   =20
    Background: the Latitude 7400 2-in-1 is =
a nice device, but it has
    issues with S3 sleep. As I did not have much =
time, I threw an AI coding
    agent on it and steered it in the directions=
 that looked promising,
    until it found out what goes wrong and how it =
could be fixed.
    I reviewed all of the code and tried to keep the patch =
minimal,
    while keeping it readable and oriented me on how similar cases=
 were
    handled before.
   =20
    - I looked at i2c-hid-dmi-quirks.c and=
 tried to follow its pattern (DMI
      match, then device name), but kept =
the table in i2c-hid-acpi.c, as
      only this driver uses it, and did not=
 add a bigger structure for a
      single device. My thought was that if =
more models need this, the
      delays could move into the DMI match data,=
 as i2c-hid-of-elan keeps
      them per compatible. I'm happy to rework it=
 if you would prefer it
      differently, e.g. in i2c-hid-dmi-quirks.c or =
drivers/platform/x86.
   =20
    - The GPIOs are only requested for the =
quirked device and with named
      con_ids, so as far as I understand, =
gpiolib-acpi will not fall back
      to _CRS and pick up the touchscreen's=
 GpioInt.
   =20
    - I did not add checks for the return values of the =
GPIO writes in
      power_up(), following i2c-hid-of; =
i2c_hid_core_resume() ignores the
      return value of power_up() anyway.
   =20
    - Only the Wacom WCOM48CA panel was tested. The DSDT can also =
describe
      other panels in the TPL0 node; this quirk does not cover =
them.
   =20
    - Test setup: Latitude 7400 2-in-1 (SKU 08E2, board 0HCNR3=
, Core
      i5-8365U, touch controller 056A:48CA), BIOS 1.39.1. S3 works =
with the
      BIOS "Sleep Mode" set to "Force S3" as well as "OS Automatic
      Selection". Kernel v7.2.14 with i2c-hid.ko and i2c-hid-acpi.ko =
rebuilt
      with this patch: 7 S3 and 5 s2idle cycles, hibernation =
freeze/restore
      (pm_test=3Ddevices) and a driver reload. After every =
resume the touch
      resume callback returned 0 in about 315 ms and the =
controller answered
      HID GET_REPORT; finger input worked after S3. =
Without the patch, one
      S3 cycle reproduced the failure. The patch =
builds cleanly on v7.4-rc2
      with W=3D1 and sparse.
   =20
    - I was not sure whether this is suitable for stable... (I think it is?=
),
      so I did not add a Cc: stable tag and would leave that to you.

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid=
-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 4362c85dfa7e..=
4ff5b4913e78 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -20,11 +20,17 @@
  */
=20
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/device.=
h>
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include =
<linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.=
h>
 #include <linux/pm.h>
+#include <linux/string.h>
=20
 #include "i2c-hid.h"
 #include "i2c-hid-acpi.h"
@@ -32,6 +38,8 @@
 struct i2c_hid_acpi {
 	struct i2chid_ops ops;
 	struct acpi_device *adev;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
 };
=20
 static const struct acpi_device_id i2c_hid_acpi_blacklist[] =3D {
@@ -48,6 +56,92 @@ static const struct acpi_device_id =
i2c_hid_acpi_blacklist[] =3D {
 	{ }
 };
=20
+/*
+ * Dell Latitude 7400 =
2-in-1: the touch controller's power enable (GPP_B21)
+ * and active-low reset (GPP_B15) are missing from ACPI, and the firmware
+ * leaves both low after resume from S3. GPIO offsets use pinctrl-intel's
+ * 32-per-group numbering.
+ */
+static struct gpiod_lookup_table =
dell_latitude_7400_2in1_touch_gpios =3D {
+	.dev_id =3D "i2c-WCOM48CA:00",
+	.table =3D {
+		GPIO_LOOKUP("INT34BB:00", 53, "power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT34BB:00", 47, "reset", GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
+static const struct dmi_system_id i2c_hid_acpi_gpio_quirks[] =3D {
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 7400 2-in-1"),
+		},
+		.driver_data =3D &dell_latitude_7400_2in1_touch_gpios,
+	},
+	{ }
+};
+
+static int i2c_hid_acpi_power_up(struct i2chid_ops *ops)
+{
+	struct i2c_hid_acpi *ihid_acpi =3D container_of(ops, struct i2c_hid_acpi,=
 ops);
+
+	gpiod_set_value_cansleep(ihid_acpi->power_gpio, 1);
+	fsleep(10 * USEC_PER_MSEC);
+	gpiod_set_value_cansleep(ihid_acpi->reset_g=
pio, 0);
+	msleep(200);
+
+	return 0;
+}
+
+static void =
i2c_hid_acpi_power_down(struct i2chid_ops *ops)
+{
+	struct i2c_hid_acpi =
*ihid_acpi =3D container_of(ops, struct i2c_hid_acpi, ops);
+
+	gpiod_set_value_cansleep(ihid_acpi->reset_gpio, 1);
+	gpiod_set_value_cansleep(ihid_acpi->power_gpio, 0);
+}
+
+static int i2c_hid_acpi_setup_power_seq(struct device *dev,
+					struct i2c_hid_acpi *ihid_acpi)
+{
+	struct gpiod_lookup_table =
*gpios;
+	const struct dmi_system_id *id;
+
+	id =3D =
dmi_first_match(i2c_hid_acpi_gpio_quirks);
+	if (!id)
+		return 0;
+
+	/* GPIO lookup tables are keyed by device name */
+	gpios =3D id->driver_data;
+	if (strcmp(dev_name(dev), gpios->dev_id))
+		return 0;
+
+	/*
+	 * Hold the controller in reset until power_up() =
releases it. Leave
+	 * power as the firmware set it up, so the reset =
happens with stable
+	 * power. Owning the GPIOs also makes pinctrl-intel =
save and restore
+	 * them across suspend; power_down() drives both low =
first. The lookup
+	 * table is only needed while requesting them.
+	 */
+	gpiod_add_lookup_table(gpios);
+	ihid_acpi->reset_gpio =3D =
devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	ihid_acpi->power_gpio =3D =
devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
+	gpiod_remove_lookup_table(g=
pios);
+
+	if (IS_ERR(ihid_acpi->reset_gpio))
+		return dev_err_probe(dev, =
PTR_ERR(ihid_acpi->reset_gpio),
+				     "failed to get reset GPIO\n");
+	if (IS_ERR(ihid_acpi->power_gpio))
+		return dev_err_probe(dev, =
PTR_ERR(ihid_acpi->power_gpio),
+				     "failed to get power GPIO\n");
+
+	ihid_acpi->ops.power_up =3D i2c_hid_acpi_power_up;
+	ihid_acpi->ops.power_down =3D i2c_hid_acpi_power_down;
+
+	return 0;
+}
+
 static void i2c_hid_acpi_restore_sequence(struct i2chid_ops *ops)
 {
 	struct i2c_hid_acpi *ihid_acpi =3D container_of(ops, struct i2c_hid_acpi,=
 ops);
@@ -86,6 +180,10 @@ static int i2c_hid_acpi_probe(struct i2c_client =
*client)
 	ihid_acpi->ops.shutdown_tail =3D i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence =3D i2c_hid_acpi_restore_sequence;
=20
+	ret =3D i2c_hid_acpi_setup_power_seq(dev, ihid_acpi);
+	if (ret)
+		return ret;
+
 	acpi_device_fix_up_power(adev);
=20
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
--=20
2.43.0

