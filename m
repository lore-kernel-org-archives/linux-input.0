Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B04C0401
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863741; cv=none; b=nphiyi4V7N2V7Z9oBhdI7KdogzhwZeMasgSa+XCDuEqNA1+B8zArn3qkcJc4+A4uN+ZBMVPUB3yUQTwZBNGeOwCssJ/AOUyV3bEo2P/Y2AyBlhMzzZaXX+udNA8M7ZLAwBtpL0A4lKUES3bnXveR/iqyQQHz5cprNESGjy8wk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863741; c=relaxed/simple;
	bh=AzEf92rQByuJuKJJnHc2XBy7tlpCKwpl7xoqSU03BM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umJdbn8ydOwF4PdsWerwtr0m+YHhK9e96RdEykQzAnXYKjvE19o2OeLsHjM+wIAV7hzl0+e/SI2xgYO+e/CD5huydpC5Q0zOe22vQH9RCWWI3OvyTNU/vH/aC485qItw/t8QtfmwmvlRMj93cY1Sx26w6ck9kXHH+xBSBSNnVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XwDxVVDG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XwDxVVDG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso128895e9.2
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778863734; x=1779468534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwh7aeOviQT71oREIh9KxBgfm5BgvsPkProc8IH4GUI=;
        b=XwDxVVDGo7maY+C+2wPzPRAJdhyrbipPPK/dsy/D75h5smZwoYgH966stpF4ZJkPLA
         EeEBJuGRTBWmaqd3jBfGX7/BjRPJcn/DLznCOHtOgRhx5UTMwhyrdreoEzRBCy9F5kWt
         oIg5F8/hb7HiddSZ5y+zaCFgpxgrjlYOa8jWREIQI+FUqklqI6qfSdJJBLMCV+lKR4ox
         QWXTfmOlHHU5VTHL0/3HqdX1In5DMNBx9+rSDwGx7qjaexVPvKQHD/0T1CQNXJ2JScFd
         HPAG/0XIp5kyZqbSB9Phh2Dur3LsnxVsXpYPI83sA2kgrqeWX8c3D1KrOkapb8Ol/9Z+
         wqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863734; x=1779468534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwh7aeOviQT71oREIh9KxBgfm5BgvsPkProc8IH4GUI=;
        b=YCF10RIEDjmvIotms+TekCqzenreHNwbNWcOKAZiik/6OkOIhgHsBYvVrBHCDWQGME
         TBiRJ0S5uQpemvvoUzOBlcBcu69Yv4ixeWH9ZgomNKM61Jc03dpSD3mgZt+GaEC+CO+L
         WwDmHCgdQ0XDt0WxN35IdAEP+X+Ak8+MMMWLEcyz0ptfRuJ5dCs+5W+nmE9SuuW6bjOe
         KFRaeY/AGz1YzzZyj4fiqRnLXYuGW+GxEz6R673NcKGUhY+xXXa1lRYsCJSFjDIYlfH0
         mpvQrWImczTCyD20E7cLLnyJu8vU0HYxLmVFPRteNQ/5hApKW727j5j6DxmexjkunXhm
         EsTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vu2ImsOyiy8WqF7PHB2YU3282A70k7jykWwO3kG0VgHLNoHWiW5fHVDz0MB5Rh1edBB2q1yQ66oROkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzQSzKrtvZQgRh1iODkk0Op0YXPE05h8D6fwY+Bj7sFoSs5Wn
	CqzkIRA+JL0Y8JJcc2HNSMW9TJbqaexp4MLQ0xADKhloPTtxGWG7nVUWqBAjkiBcpmE=
X-Gm-Gg: Acq92OECYLn6yF2RdhPWbuShta69ydqg//wNG7gCsVgaZrOM0ECILHgYdeMXdMMHQhn
	FYsBHyMNXHjrnup1OBqUZGjY9vCG6Zltb06LWuq+o4L0d7ZiZIuJkdvkwcsQzeq6gDaCrwxQ8P4
	KZ1GFbS7NwDDA84wdh8NCCf5cGx5rggULH9S3aWxIjkb7Cg/2JCbkMoXhS+39+EboMLqneLGigB
	5KmiDKtsjRfEz+lv7KEX6bNtyRvuRZConmjpidkBo1NaEMb3zcxwWPXjTdA0LjHk9NuWZMuArqg
	1F8edGFrTJzJQaE9DG9CECrHL1uMl7FAS7VTOoO5PSYK1NvHt1iPWMpx6A/VRPkumMb5PvxJZaU
	wG2nZt3HTOg43EHRErw4672TfHsGR1MUP/6EeksG4oT4dooCMxc76mKWgc89h3nAln9P5fCDSmm
	zKxAZQrR8NzOfoVU9dcwEowpcgoScdFwcKp5bPckUeUH16S9f5nNHZeJu5RqJFar3LzOOGlp613
	zA/VEMafLAUC/s=
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48fe5fcdec2mr76295825e9.4.1778863734141;
        Fri, 15 May 2026 09:48:54 -0700 (PDT)
Received: from localhost (p200300f65f47db047ce9331f6697a627.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7ce9:331f:6697:a627])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48febc56f89sm22421295e9.3.2026.05.15.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:48:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Support Opensource <support.opensource@diasemi.com>,
	Nick Dyer <nick@shmanahar.org>,
	Hans de Goede <hansg@kernel.org>,
	Job Noorman <job@noorman.info>,
	=?utf-8?q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kees Cook <kees@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yauhen Kharuzhy <jekhor@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Minseong Kim <ii4gsp@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Josua Mayer <josua@solid-run.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	David Heidelberg <david@ixit.cz>,
	Petr Hodina <petr.hodina@protonmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1] Input: Use named initializers for arrays of i2c_device_data
Date: Fri, 15 May 2026 18:48:47 +0200
Message-ID: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=46012; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=AzEf92rQByuJuKJJnHc2XBy7tlpCKwpl7xoqSU03BM0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqB05wrzBXh8FmRtrNoeCoTNHTwePcIoDlBVmq5 n1LbFCssy6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagdOcAAKCRCPgPtYfRL+ Tm3eCACGEmkd2EwoFBmSnqzSvPRUdAyUSa2XaaKExrLt7oGyuk1O3hEASyR0Owupl9lhPrzIpk1 Ll0BVbqqwzN0ejJyhKwVXb6QMSjFq9TZOpNnO+6Z95B3gN3b8Cg3mluTpWeZAr2YqANZDtwjvoJ UaiSOvXvdVdAeAi9zcWR03X5xUDBJFK7MAd0zNikoH81FzKmzt+mKEu6iMMmq+tysYLXYxX8s2+ e22jgL55ncERVWwTJzF1bxwe32oTlKzHo1Vl0B8CIxe34+cmitJbK+FyMZw8ymmU9K/a4dzftXU zQEHDVMrK6XKW9mnX3qGNpLX5jXbLQo2+/aOh283UwBhzQWf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
	
	 struct i2c_device_id {
	 	char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;     /* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };
	
	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
	index 66ada7ffbc80..94aa4dc002c5 100644
	--- a/drivers/input/touchscreen/ili210x.c
	+++ b/drivers/input/touchscreen/ili210x.c
	@@ -969,7 +969,7 @@ static int ili210x_i2c_probe(struct i2c_client *client)
	 
		chip = device_get_match_data(dev);
		if (!chip && id)
	-		chip = (const struct ili2xxx_chip *)id->driver_data;
	+		chip = id->driver_data_ptr;
		if (!chip)
			return dev_err_probe(&client->dev, -ENODEV, "unknown device model\n");
	 
	@@ -1049,10 +1049,10 @@ static int ili210x_i2c_probe(struct i2c_client *client)
	 }
	 
	 static const struct i2c_device_id ili210x_i2c_id[] = {
	-	{ .name = "ili210x", .driver_data = (long)&ili210x_chip },
	-	{ .name = "ili2117", .driver_data = (long)&ili211x_chip },
	-	{ .name = "ili2120", .driver_data = (long)&ili212x_chip },
	-	{ .name = "ili251x", .driver_data = (long)&ili251x_chip },
	+	{ .name = "ili210x", .driver_data_ptr = &ili210x_chip },
	+	{ .name = "ili2117", .driver_data_ptr = &ili211x_chip },
	+	{ .name = "ili2120", .driver_data_ptr = &ili212x_chip },
	+	{ .name = "ili251x", .driver_data_ptr = &ili251x_chip },
		{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ili210x_i2c_id);

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that.

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

 drivers/input/joystick/adafruit-seesaw.c        |  2 +-
 drivers/input/joystick/as5011.c                 |  2 +-
 drivers/input/joystick/qwiic-joystick.c         |  2 +-
 drivers/input/keyboard/adp5588-keys.c           |  4 ++--
 drivers/input/keyboard/cap11xx.c                | 14 +++++++-------
 drivers/input/keyboard/cypress-sf.c             |  2 +-
 drivers/input/keyboard/dlink-dir685-touchkeys.c |  2 +-
 drivers/input/keyboard/lm8323.c                 |  2 +-
 drivers/input/keyboard/lm8333.c                 |  2 +-
 drivers/input/keyboard/max7359_keypad.c         |  2 +-
 drivers/input/keyboard/mpr121_touchkey.c        |  2 +-
 drivers/input/keyboard/qt1070.c                 |  2 +-
 drivers/input/keyboard/qt2160.c                 |  2 +-
 drivers/input/keyboard/tca8418_keypad.c         |  2 +-
 drivers/input/keyboard/tm2-touchkey.c           |  2 +-
 drivers/input/misc/ad714x-i2c.c                 | 10 +++++-----
 drivers/input/misc/adxl34x-i2c.c                |  2 +-
 drivers/input/misc/apanel.c                     |  2 +-
 drivers/input/misc/atmel_captouch.c             |  2 +-
 drivers/input/misc/bma150.c                     |  6 +++---
 drivers/input/misc/cma3000_d0x_i2c.c            |  2 +-
 drivers/input/misc/da7280.c                     |  2 +-
 drivers/input/misc/drv260x.c                    |  8 ++++----
 drivers/input/misc/drv2665.c                    |  2 +-
 drivers/input/misc/drv2667.c                    |  2 +-
 drivers/input/misc/kxtj9.c                      |  2 +-
 drivers/input/misc/mma8450.c                    |  2 +-
 drivers/input/misc/pcf8574_keypad.c             |  2 +-
 drivers/input/mouse/cyapa.c                     |  2 +-
 drivers/input/mouse/elan_i2c_core.c             |  2 +-
 drivers/input/mouse/synaptics_i2c.c             |  2 +-
 drivers/input/rmi4/rmi_i2c.c                    |  2 +-
 drivers/input/rmi4/rmi_smbus.c                  |  2 +-
 drivers/input/touchscreen/ad7879-i2c.c          |  4 ++--
 drivers/input/touchscreen/ar1021_i2c.c          |  2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c        | 10 +++++-----
 drivers/input/touchscreen/auo-pixcir-ts.c       |  2 +-
 drivers/input/touchscreen/bu21013_ts.c          |  2 +-
 drivers/input/touchscreen/bu21029_ts.c          |  2 +-
 drivers/input/touchscreen/cy8ctma140.c          |  2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c       |  2 +-
 drivers/input/touchscreen/cyttsp5.c             |  2 +-
 drivers/input/touchscreen/cyttsp_i2c.c          |  2 +-
 drivers/input/touchscreen/eeti_ts.c             |  2 +-
 drivers/input/touchscreen/egalax_ts.c           |  2 +-
 drivers/input/touchscreen/elants_i2c.c          |  6 +++---
 drivers/input/touchscreen/exc3000.c             |  8 ++++----
 drivers/input/touchscreen/goodix.c              |  2 +-
 drivers/input/touchscreen/hideep.c              |  2 +-
 drivers/input/touchscreen/himax_hx83112b.c      |  4 ++--
 drivers/input/touchscreen/hynitron-cst816x.c    |  2 +-
 drivers/input/touchscreen/ili210x.c             |  8 ++++----
 drivers/input/touchscreen/ilitek_ts_i2c.c       |  2 +-
 drivers/input/touchscreen/max11801_ts.c         |  2 +-
 drivers/input/touchscreen/melfas_mip4.c         |  2 +-
 drivers/input/touchscreen/migor_ts.c            |  2 +-
 drivers/input/touchscreen/mms114.c              |  2 +-
 drivers/input/touchscreen/novatek-nvt-ts.c      |  4 ++--
 drivers/input/touchscreen/pixcir_i2c_ts.c       |  4 ++--
 drivers/input/touchscreen/raydium_i2c_ts.c      |  4 ++--
 drivers/input/touchscreen/rohm_bu21023.c        |  2 +-
 drivers/input/touchscreen/s6sy761.c             |  2 +-
 drivers/input/touchscreen/silead.c              | 12 ++++++------
 drivers/input/touchscreen/sis_i2c.c             |  4 ++--
 drivers/input/touchscreen/st1232.c              |  4 ++--
 drivers/input/touchscreen/stmfts.c              |  2 +-
 drivers/input/touchscreen/tsc2004.c             |  2 +-
 drivers/input/touchscreen/tsc2007_core.c        |  2 +-
 drivers/input/touchscreen/wacom_i2c.c           |  2 +-
 drivers/input/touchscreen/wdt87xx_i2c.c         |  2 +-
 drivers/input/touchscreen/zet6223.c             |  2 +-
 drivers/input/touchscreen/zforce_ts.c           |  2 +-
 72 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
index c248c15b849d..5835ed1e29e1 100644
--- a/drivers/input/joystick/adafruit-seesaw.c
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -304,7 +304,7 @@ static int seesaw_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id seesaw_id_table[] = {
-	{ SEESAW_DEVICE_NAME },
+	{ .name = SEESAW_DEVICE_NAME },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 7b4d61626898..5fca92bf9df0 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -337,7 +337,7 @@ static void as5011_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id as5011_id[] = {
-	{ MODULE_DEVICE_ALIAS },
+	{ .name = MODULE_DEVICE_ALIAS },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, as5011_id);
diff --git a/drivers/input/joystick/qwiic-joystick.c b/drivers/input/joystick/qwiic-joystick.c
index 6f989d00d3ec..c471afc7862b 100644
--- a/drivers/input/joystick/qwiic-joystick.c
+++ b/drivers/input/joystick/qwiic-joystick.c
@@ -126,7 +126,7 @@ MODULE_DEVICE_TABLE(of, of_qwiic_match);
 #endif /* CONFIG_OF */
 
 static const struct i2c_device_id qwiic_id_table[] = {
-	{ KBUILD_MODNAME },
+	{ .name = KBUILD_MODNAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, qwiic_id_table);
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 414fbef4abf9..8d14d0f69d4e 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -842,8 +842,8 @@ static int adp5588_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(adp5588_dev_pm_ops, adp5588_suspend, adp5588_resume);
 
 static const struct i2c_device_id adp5588_id[] = {
-	{ "adp5588-keys" },
-	{ "adp5587-keys" },
+	{ .name = "adp5588-keys" },
+	{ .name = "adp5587-keys" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp5588_id);
diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 0c17cbaa3d27..2447c1ae2166 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -651,13 +651,13 @@ static const struct of_device_id cap11xx_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
-	{ "cap1106", (kernel_ulong_t)&cap1106_model },
-	{ "cap1126", (kernel_ulong_t)&cap1126_model },
-	{ "cap1188", (kernel_ulong_t)&cap1188_model },
-	{ "cap1203", (kernel_ulong_t)&cap1203_model },
-	{ "cap1206", (kernel_ulong_t)&cap1206_model },
-	{ "cap1293", (kernel_ulong_t)&cap1293_model },
-	{ "cap1298", (kernel_ulong_t)&cap1298_model },
+	{ .name = "cap1106", .driver_data = (kernel_ulong_t)&cap1106_model },
+	{ .name = "cap1126", .driver_data = (kernel_ulong_t)&cap1126_model },
+	{ .name = "cap1188", .driver_data = (kernel_ulong_t)&cap1188_model },
+	{ .name = "cap1203", .driver_data = (kernel_ulong_t)&cap1203_model },
+	{ .name = "cap1206", .driver_data = (kernel_ulong_t)&cap1206_model },
+	{ .name = "cap1293", .driver_data = (kernel_ulong_t)&cap1293_model },
+	{ .name = "cap1298", .driver_data = (kernel_ulong_t)&cap1298_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
diff --git a/drivers/input/keyboard/cypress-sf.c b/drivers/input/keyboard/cypress-sf.c
index 335b72efc5aa..4b2ae07f315c 100644
--- a/drivers/input/keyboard/cypress-sf.c
+++ b/drivers/input/keyboard/cypress-sf.c
@@ -209,7 +209,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(cypress_sf_pm_ops,
 				cypress_sf_suspend, cypress_sf_resume);
 
 static const struct i2c_device_id cypress_sf_id_table[] = {
-	{ CYPRESS_SF_DEV_NAME },
+	{ .name = CYPRESS_SF_DEV_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cypress_sf_id_table);
diff --git a/drivers/input/keyboard/dlink-dir685-touchkeys.c b/drivers/input/keyboard/dlink-dir685-touchkeys.c
index 4184dd2eaeeb..bf94367f6b64 100644
--- a/drivers/input/keyboard/dlink-dir685-touchkeys.c
+++ b/drivers/input/keyboard/dlink-dir685-touchkeys.c
@@ -128,7 +128,7 @@ static int dir685_tk_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dir685_tk_id[] = {
-	{ "dir685tk" },
+	{ .name = "dir685tk" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dir685_tk_id);
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index e19442c6f80f..7b48f0cf62ef 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -788,7 +788,7 @@ static int lm8323_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(lm8323_pm_ops, lm8323_suspend, lm8323_resume);
 
 static const struct i2c_device_id lm8323_id[] = {
-	{ "lm8323" },
+	{ .name = "lm8323" },
 	{ }
 };
 
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 384baabf9924..34be5b2e476d 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -194,7 +194,7 @@ static int lm8333_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm8333_id[] = {
-	{ "lm8333" },
+	{ .name = "lm8333" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm8333_id);
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index c10726b5e4d1..f8fb44bc4915 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -270,7 +270,7 @@ static int max7359_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(max7359_pm, max7359_suspend, max7359_resume);
 
 static const struct i2c_device_id max7359_ids[] = {
-	{ "max7359" },
+	{ .name = "max7359" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max7359_ids);
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 47edc161ec77..a1a102855590 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -322,7 +322,7 @@ static int mpr_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
 
 static const struct i2c_device_id mpr121_id[] = {
-	{ "mpr121_touchkey" },
+	{ .name = "mpr121_touchkey" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mpr121_id);
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index b255b997e279..e31cb115a954 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -233,7 +233,7 @@ static int qt1070_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(qt1070_pm_ops, qt1070_suspend, qt1070_resume);
 
 static const struct i2c_device_id qt1070_id[] = {
-	{ "qt1070" },
+	{ .name = "qt1070" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, qt1070_id);
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 53f5255fd19d..e64adaca10ff 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -393,7 +393,7 @@ static int qt2160_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id qt2160_idtable[] = {
-	{ "qt2160" },
+	{ .name = "qt2160" },
 	{ }
 };
 
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 68c0afafee7b..eb5be644f236 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -354,7 +354,7 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tca8418_id[] = {
-	{ "tca8418", 8418, },
+	{ .name = "tca8418", .driver_data = 8418 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tca8418_id);
diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 55d699d9037d..967bbe553c06 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -326,7 +326,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
 				tm2_touchkey_suspend, tm2_touchkey_resume);
 
 static const struct i2c_device_id tm2_touchkey_id_table[] = {
-	{ TM2_TOUCHKEY_DEV_NAME },
+	{ .name = TM2_TOUCHKEY_DEV_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 2adb7a058362..c3cb561512ed 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -72,11 +72,11 @@ static int ad714x_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad714x_id[] = {
-	{ "ad7142_captouch" },
-	{ "ad7143_captouch" },
-	{ "ad7147_captouch" },
-	{ "ad7147a_captouch" },
-	{ "ad7148_captouch" },
+	{ .name = "ad7142_captouch" },
+	{ .name = "ad7143_captouch" },
+	{ .name = "ad7147_captouch" },
+	{ .name = "ad7147a_captouch" },
+	{ .name = "ad7148_captouch" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad714x_id);
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 5ea0ce42a507..84665c612f3c 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -96,7 +96,7 @@ static int adxl34x_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl34x_id[] = {
-	{ "adxl34x" },
+	{ .name = "adxl34x" },
 	{ }
 };
 
diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index d43aebd785b7..3eb02a64acfb 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -192,7 +192,7 @@ static void apanel_shutdown(struct i2c_client *client)
 }
 
 static const struct i2c_device_id apanel_id[] = {
-	{ "fujitsu_apanel" },
+	{ .name = "fujitsu_apanel" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, apanel_id);
diff --git a/drivers/input/misc/atmel_captouch.c b/drivers/input/misc/atmel_captouch.c
index f9744cf0ca80..fc4abea68479 100644
--- a/drivers/input/misc/atmel_captouch.c
+++ b/drivers/input/misc/atmel_captouch.c
@@ -257,7 +257,7 @@ static const struct of_device_id atmel_captouch_of_id[] = {
 MODULE_DEVICE_TABLE(of, atmel_captouch_of_id);
 
 static const struct i2c_device_id atmel_captouch_id[] = {
-	{ "atmel_captouch" },
+	{ .name = "atmel_captouch" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_captouch_id);
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 4cc2a0dcaa75..0ef282932095 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -536,9 +536,9 @@ static int __maybe_unused bma150_resume(struct device *dev)
 static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
 static const struct i2c_device_id bma150_id[] = {
-	{ "bma150" },
-	{ "smb380" },
-	{ "bma023" },
+	{ .name = "bma150" },
+	{ .name = "smb380" },
+	{ .name = "bma023" },
 	{ }
 };
 
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index f892c5b1e4bd..14be6d4682d0 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -90,7 +90,7 @@ static const struct dev_pm_ops cma3000_i2c_pm_ops = {
 };
 
 static const struct i2c_device_id cma3000_i2c_id[] = {
-	{ "cma3000_d01" },
+	{ .name = "cma3000_d01" },
 	{ }
 };
 
diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index e4a605c6af15..77fcf868dca2 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -1305,7 +1305,7 @@ MODULE_DEVICE_TABLE(of, da7280_of_match);
 #endif
 
 static const struct i2c_device_id da7280_i2c_id[] = {
-	{ "da7280", },
+	{ .name = "da7280" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da7280_i2c_id);
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e2089d6ac850..6c5c4c53753b 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -630,10 +630,10 @@ static int drv260x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
 
 static const struct i2c_device_id drv260x_id[] = {
-	{ "drv2604" },
-	{ "drv2604l" },
-	{ "drv2605" },
-	{ "drv2605l" },
+	{ .name = "drv2604" },
+	{ .name = "drv2604l" },
+	{ .name = "drv2605" },
+	{ .name = "drv2605l" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, drv260x_id);
diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 46842cb8ddd7..4f8c1f69aa63 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -281,7 +281,7 @@ static int drv2665_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(drv2665_pm_ops, drv2665_suspend, drv2665_resume);
 
 static const struct i2c_device_id drv2665_id[] = {
-	{ "drv2665" },
+	{ .name = "drv2665" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, drv2665_id);
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index f952a24ec595..97309984fa7c 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -458,7 +458,7 @@ static int drv2667_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(drv2667_pm_ops, drv2667_suspend, drv2667_resume);
 
 static const struct i2c_device_id drv2667_id[] = {
-	{ "drv2667" },
+	{ .name = "drv2667" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, drv2667_id);
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index eb9788ea5215..6b3495ba5763 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -525,7 +525,7 @@ static int kxtj9_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(kxtj9_pm_ops, kxtj9_suspend, kxtj9_resume);
 
 static const struct i2c_device_id kxtj9_id[] = {
-	{ NAME },
+	{ .name = NAME },
 	{ }
 };
 
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 0c661140fb88..a2888d1ff58f 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -200,7 +200,7 @@ static int mma8450_probe(struct i2c_client *c)
 }
 
 static const struct i2c_device_id mma8450_id[] = {
-	{ MMA8450_DRV_NAME },
+	{ .name = MMA8450_DRV_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8450_id);
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 14fc6c6cf699..a831fcc851f7 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -189,7 +189,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(pcf8574_kp_pm_ops,
 				pcf8574_kp_suspend, pcf8574_kp_resume);
 
 static const struct i2c_device_id pcf8574_kp_id[] = {
-	{ DRV_NAME },
+	{ .name = DRV_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf8574_kp_id);
diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 6e0d956617a1..47000c30e4d8 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1456,7 +1456,7 @@ static const struct dev_pm_ops cyapa_pm_ops = {
 };
 
 static const struct i2c_device_id cyapa_id_table[] = {
-	{ "cyapa" },
+	{ .name = "cyapa" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cyapa_id_table);
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..294e775510d5 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1399,7 +1399,7 @@ static int elan_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(elan_pm_ops, elan_suspend, elan_resume);
 
 static const struct i2c_device_id elan_id[] = {
-	{ DRIVER_NAME },
+	{ .name = DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, elan_id);
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 6f3d5c33b807..d4cf982f1263 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -607,7 +607,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(synaptics_i2c_pm, synaptics_i2c_suspend,
 				synaptics_i2c_resume);
 
 static const struct i2c_device_id synaptics_i2c_id_table[] = {
-	{ "synaptics_i2c" },
+	{ .name = "synaptics_i2c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 3c0c5fd44702..e11d0acb9b96 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -365,7 +365,7 @@ static const struct dev_pm_ops rmi_i2c_pm = {
 };
 
 static const struct i2c_device_id rmi_id[] = {
-	{ "rmi4_i2c" },
+	{ .name = "rmi4_i2c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rmi_id);
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index f3d0b40721df..6de68c602558 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -413,7 +413,7 @@ static const struct dev_pm_ops rmi_smb_pm = {
 };
 
 static const struct i2c_device_id rmi_id[] = {
-	{ "rmi4_smbus" },
+	{ .name = "rmi4_smbus" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rmi_id);
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index e5b99312c3d9..c1ccdf86b74c 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -42,8 +42,8 @@ static int ad7879_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad7879_id[] = {
-	{ "ad7879" },
-	{ "ad7889" },
+	{ .name = "ad7879" },
+	{ .name = "ad7889" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7879_id);
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 8a588202447d..aa43fc1549df 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -164,7 +164,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ar1021_i2c_pm,
 				ar1021_i2c_suspend, ar1021_i2c_resume);
 
 static const struct i2c_device_id ar1021_i2c_id[] = {
-	{ "ar1021" },
+	{ .name = "ar1021" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 87c6a10381f2..ec86c46c8622 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3413,11 +3413,11 @@ MODULE_DEVICE_TABLE(acpi, mxt_acpi_id);
 #endif
 
 static const struct i2c_device_id mxt_id[] = {
-	{ "qt602240_ts" },
-	{ "atmel_mxt_ts" },
-	{ "atmel_mxt_tp" },
-	{ "maxtouch" },
-	{ "mXT224" },
+	{ .name = "qt602240_ts" },
+	{ .name = "atmel_mxt_ts" },
+	{ .name = "atmel_mxt_tp" },
+	{ .name = "maxtouch" },
+	{ .name = "mXT224" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mxt_id);
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 401b2264f585..6c6ebebacba9 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -618,7 +618,7 @@ static int auo_pixcir_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id auo_pixcir_idtable[] = {
-	{ "auo_pixcir_ts" },
+	{ .name = "auo_pixcir_ts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 6baebb7ec089..d1bdccc56fc8 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -597,7 +597,7 @@ static int bu21013_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bu21013_dev_pm_ops, bu21013_suspend, bu21013_resume);
 
 static const struct i2c_device_id bu21013_id[] = {
-	{ DRIVER_TP },
+	{ .name = DRIVER_TP },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bu21013_id);
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index 68d9cd55ceeb..339fee1622fb 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -442,7 +442,7 @@ static int bu21029_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bu21029_pm_ops, bu21029_suspend, bu21029_resume);
 
 static const struct i2c_device_id bu21029_ids[] = {
-	{ DRIVER_NAME },
+	{ .name = DRIVER_NAME },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, bu21029_ids);
diff --git a/drivers/input/touchscreen/cy8ctma140.c b/drivers/input/touchscreen/cy8ctma140.c
index 2d4b6e343203..0ac48eff3376 100644
--- a/drivers/input/touchscreen/cy8ctma140.c
+++ b/drivers/input/touchscreen/cy8ctma140.c
@@ -322,7 +322,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(cy8ctma140_pm,
 				cy8ctma140_suspend, cy8ctma140_resume);
 
 static const struct i2c_device_id cy8ctma140_idtable[] = {
-	{ CY8CTMA140_NAME },
+	{ .name = CY8CTMA140_NAME },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, cy8ctma140_idtable);
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 54d6c4869eb0..33ad4f0512a0 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -267,7 +267,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(cy8ctmg110_pm,
 				cy8ctmg110_suspend, cy8ctmg110_resume);
 
 static const struct i2c_device_id cy8ctmg110_idtable[] = {
-	{ CY8CTMG110_DRIVER_NAME, 1 },
+	{ .name = CY8CTMG110_DRIVER_NAME, .driver_data = 1 },
 	{ }
 };
 
diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 47f4271395a6..73c397e44da4 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -938,7 +938,7 @@ static const struct of_device_id cyttsp5_of_match[] = {
 MODULE_DEVICE_TABLE(of, cyttsp5_of_match);
 
 static const struct i2c_device_id cyttsp5_i2c_id[] = {
-	{ CYTTSP5_NAME },
+	{ .name = CYTTSP5_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index cb15600549cd..17524f7e944d 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -103,7 +103,7 @@ static int cyttsp_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id cyttsp_i2c_id[] = {
-	{ CY_I2C_NAME },
+	{ .name = CY_I2C_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 492e19a28a74..b12602bc368e 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -266,7 +266,7 @@ static int eeti_ts_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(eeti_ts_pm, eeti_ts_suspend, eeti_ts_resume);
 
 static const struct i2c_device_id eeti_ts_id[] = {
-	{ "eeti_ts" },
+	{ .name = "eeti_ts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, eeti_ts_id);
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index eb3cc2befcdf..76cf8085553f 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -219,7 +219,7 @@ static int egalax_ts_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id egalax_ts_id[] = {
-	{ "egalax_ts" },
+	{ .name = "egalax_ts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, egalax_ts_id);
diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 835d91dff0a4..17175adcaebb 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1615,9 +1615,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(elants_i2c_pm_ops,
 				elants_i2c_suspend, elants_i2c_resume);
 
 static const struct i2c_device_id elants_i2c_id[] = {
-	{ DEVICE_NAME, EKTH3500 },
-	{ "ekth3500", EKTH3500 },
-	{ "ektf3624", EKTF3624 },
+	{ .name = DEVICE_NAME, .driver_data = EKTH3500 },
+	{ .name = "ekth3500", .driver_data = EKTH3500 },
+	{ .name = "ektf3624", .driver_data = EKTF3624 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, elants_i2c_id);
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 78c0911ba6e2..037bb35238a3 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -432,10 +432,10 @@ static int exc3000_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id exc3000_id[] = {
-	{ "exc3000", EETI_EXC3000 },
-	{ "exc80h60", EETI_EXC80H60 },
-	{ "exc80h84", EETI_EXC80H84 },
-	{ "exc81w32", EETI_EXC81W32 },
+	{ .name = "exc3000", .driver_data = EETI_EXC3000 },
+	{ .name = "exc80h60", .driver_data = EETI_EXC80H60 },
+	{ .name = "exc80h84", .driver_data = EETI_EXC80H84 },
+	{ .name = "exc81w32", .driver_data = EETI_EXC81W32 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, exc3000_id);
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f8798d11ec03..2c48ad8ee2e6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1523,7 +1523,7 @@ static int goodix_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
 
 static const struct i2c_device_id goodix_ts_id[] = {
-	{ "GDIX1001:00" },
+	{ .name = "GDIX1001:00" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index 62041bcca83d..58e00c314ace 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -1081,7 +1081,7 @@ static int hideep_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hideep_i2c_id[] = {
-	{ HIDEEP_I2C_NAME },
+	{ .name = HIDEEP_I2C_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hideep_i2c_id);
diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 896a145ddb2b..0aa67dfacbad 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -406,8 +406,8 @@ static const struct himax_chip hx83112b_chip = {
 };
 
 static const struct i2c_device_id himax_ts_id[] = {
-	{ "hx83100a", (kernel_ulong_t)&hx83100a_chip },
-	{ "hx83112b", (kernel_ulong_t)&hx83112b_chip },
+	{ .name = "hx83100a", .driver_data = (kernel_ulong_t)&hx83100a_chip },
+	{ .name = "hx83112b", .driver_data = (kernel_ulong_t)&hx83112b_chip },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, himax_ts_id);
diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index b64d7928e18f..47d9cd7412d1 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -226,7 +226,7 @@ static int cst816x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id cst816x_id[] = {
-	{ .name = "cst816s", 0 },
+	{ .name = "cst816s" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cst816x_id);
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 3bf524a6ee20..66ada7ffbc80 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -1049,10 +1049,10 @@ static int ili210x_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ili210x_i2c_id[] = {
-	{ "ili210x", (long)&ili210x_chip },
-	{ "ili2117", (long)&ili211x_chip },
-	{ "ili2120", (long)&ili212x_chip },
-	{ "ili251x", (long)&ili251x_chip },
+	{ .name = "ili210x", .driver_data = (long)&ili210x_chip },
+	{ .name = "ili2117", .driver_data = (long)&ili211x_chip },
+	{ .name = "ili2120", .driver_data = (long)&ili212x_chip },
+	{ .name = "ili251x", .driver_data = (long)&ili251x_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ili210x_i2c_id);
diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 0706443792ba..3de0fbf8da38 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -639,7 +639,7 @@ static int ilitek_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ilitek_pm_ops, ilitek_suspend, ilitek_resume);
 
 static const struct i2c_device_id ilitek_ts_i2c_id[] = {
-	{ ILITEK_TS_NAME },
+	{ .name = ILITEK_TS_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ilitek_ts_i2c_id);
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index f39633fc8dc2..3996e4a61ff7 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -213,7 +213,7 @@ static int max11801_ts_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max11801_ts_id[] = {
-	{ "max11801" },
+	{ .name = "max11801" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max11801_ts_id);
diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 10fccf4e5bb1..fd6c0ac301a2 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1536,7 +1536,7 @@ MODULE_DEVICE_TABLE(acpi, mip4_acpi_match);
 #endif
 
 static const struct i2c_device_id mip4_i2c_ids[] = {
-	{ MIP4_DEVICE_NAME },
+	{ .name = MIP4_DEVICE_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mip4_i2c_ids);
diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index 993d945dcd23..9d221e340404 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -211,7 +211,7 @@ static int migor_ts_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(migor_ts_pm, migor_ts_suspend, migor_ts_resume);
 
 static const struct i2c_device_id migor_ts_id[] = {
-	{ "migor_ts" },
+	{ .name = "migor_ts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, migor_ts_id);
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index af462086a65c..9597214d9d3c 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -667,7 +667,7 @@ static int mms114_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mms114_pm_ops, mms114_suspend, mms114_resume);
 
 static const struct i2c_device_id mms114_id[] = {
-	{ "mms114" },
+	{ .name = "mms114" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mms114_id);
diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
index 708bfb933ddd..0f771f681952 100644
--- a/drivers/input/touchscreen/novatek-nvt-ts.c
+++ b/drivers/input/touchscreen/novatek-nvt-ts.c
@@ -326,8 +326,8 @@ static const struct of_device_id nvt_ts_of_match[] = {
 MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
 
 static const struct i2c_device_id nvt_ts_i2c_id[] = {
-	{ "nt11205-ts", (unsigned long) &nvt_nt11205_ts_data },
-	{ "nt36672a-ts", (unsigned long) &nvt_nt36672a_ts_data },
+	{ .name = "nt11205-ts", .driver_data = (unsigned long)&nvt_nt11205_ts_data },
+	{ .name = "nt36672a-ts", .driver_data = (unsigned long)&nvt_nt36672a_ts_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index c6b3615c8775..1ca5920846df 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -580,8 +580,8 @@ static const struct pixcir_i2c_chip_data pixcir_tangoc_data = {
 };
 
 static const struct i2c_device_id pixcir_i2c_ts_id[] = {
-	{ "pixcir_ts", (unsigned long) &pixcir_ts_data },
-	{ "pixcir_tangoc", (unsigned long) &pixcir_tangoc_data },
+	{ .name = "pixcir_ts", .driver_data = (unsigned long)&pixcir_ts_data },
+	{ .name = "pixcir_tangoc", .driver_data = (unsigned long)&pixcir_tangoc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pixcir_i2c_ts_id);
diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index f2d33ad86fd2..0256055abcef 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1219,8 +1219,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(raydium_i2c_pm_ops,
 				raydium_i2c_suspend, raydium_i2c_resume);
 
 static const struct i2c_device_id raydium_i2c_id[] = {
-	{ "raydium_i2c" },
-	{ "rm32380" },
+	{ .name = "raydium_i2c" },
+	{ .name = "rm32380" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, raydium_i2c_id);
diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index 295d8d75ba32..a5c06b7423c0 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -1144,7 +1144,7 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rohm_bu21023_i2c_id[] = {
-	{ BU21023_NAME },
+	{ .name = BU21023_NAME },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, rohm_bu21023_i2c_id);
diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index e1518a75a51b..0f24a9b73063 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -520,7 +520,7 @@ MODULE_DEVICE_TABLE(of, s6sy761_of_match);
 #endif
 
 static const struct i2c_device_id s6sy761_id[] = {
-	{ "s6sy761" },
+	{ .name = "s6sy761" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, s6sy761_id);
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 5ccc96764742..44d7141103f4 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -776,12 +776,12 @@ static int silead_ts_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(silead_ts_pm, silead_ts_suspend, silead_ts_resume);
 
 static const struct i2c_device_id silead_ts_id[] = {
-	{ "gsl1680" },
-	{ "gsl1688" },
-	{ "gsl3670" },
-	{ "gsl3675" },
-	{ "gsl3692" },
-	{ "mssl1680" },
+	{ .name = "gsl1680" },
+	{ .name = "gsl1688" },
+	{ .name = "gsl3670" },
+	{ .name = "gsl3675" },
+	{ .name = "gsl3692" },
+	{ .name = "mssl1680" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, silead_ts_id);
diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
index a625f2ad809d..4fa93cd31ee4 100644
--- a/drivers/input/touchscreen/sis_i2c.c
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -374,8 +374,8 @@ MODULE_DEVICE_TABLE(of, sis_ts_dt_ids);
 #endif
 
 static const struct i2c_device_id sis_ts_id[] = {
-	{ SIS_I2C_NAME },
-	{ "9200-ts" },
+	{ .name = SIS_I2C_NAME },
+	{ .name = "9200-ts" },
 	{ /* sentinel */  }
 };
 MODULE_DEVICE_TABLE(i2c, sis_ts_id);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 9b266927b7fe..c2dcfce5003d 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -453,8 +453,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
 				st1232_ts_suspend, st1232_ts_resume);
 
 static const struct i2c_device_id st1232_ts_id[] = {
-	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
-	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
+	{ .name = ST1232_TS_NAME, .driver_data = (unsigned long)&st1232_chip_info },
+	{ .name = ST1633_TS_NAME, .driver_data = (unsigned long)&st1633_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 8af87d0b6eb6..f84127e182fe 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -785,7 +785,7 @@ MODULE_DEVICE_TABLE(of, stmfts_of_match);
 #endif
 
 static const struct i2c_device_id stmfts_id[] = {
-	{ "stmfts" },
+	{ .name = "stmfts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stmfts_id);
diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
index 787f2caf4f73..130aeb735b65 100644
--- a/drivers/input/touchscreen/tsc2004.c
+++ b/drivers/input/touchscreen/tsc2004.c
@@ -43,7 +43,7 @@ static int tsc2004_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tsc2004_idtable[] = {
-	{ "tsc2004" },
+	{ .name = "tsc2004" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsc2004_idtable);
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 524f14eb3da2..5e332395aa75 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -407,7 +407,7 @@ static int tsc2007_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tsc2007_idtable[] = {
-	{ "tsc2007" },
+	{ .name = "tsc2007" },
 	{ }
 };
 
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index fd97a83f5664..dd7c2a8a831b 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -253,7 +253,7 @@ static int wacom_i2c_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_resume);
 
 static const struct i2c_device_id wacom_i2c_id[] = {
-	{ "WAC_I2C_EMR" },
+	{ .name = "WAC_I2C_EMR" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index bdaabb14dc8c..1af309252092 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -1140,7 +1140,7 @@ static int wdt87xx_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(wdt87xx_pm_ops, wdt87xx_suspend, wdt87xx_resume);
 
 static const struct i2c_device_id wdt87xx_dev_id[] = {
-	{ WDT87XX_NAME },
+	{ .name = WDT87XX_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wdt87xx_dev_id);
diff --git a/drivers/input/touchscreen/zet6223.c b/drivers/input/touchscreen/zet6223.c
index 943634ba9cd9..a341142f3708 100644
--- a/drivers/input/touchscreen/zet6223.c
+++ b/drivers/input/touchscreen/zet6223.c
@@ -236,7 +236,7 @@ static const struct of_device_id zet6223_of_match[] = {
 MODULE_DEVICE_TABLE(of, zet6223_of_match);
 
 static const struct i2c_device_id zet6223_id[] = {
-	{ "zet6223" },
+	{ .name = "zet6223" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zet6223_id);
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index a360749fa076..4bfc9560bd6c 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -831,7 +831,7 @@ static int zforce_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id zforce_idtable[] = {
-	{ "zforce-ts" },
+	{ .name = "zforce-ts" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zforce_idtable);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

