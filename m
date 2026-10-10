Received: from e234-54.smtp-out.ap-northeast-1.amazonses.com (e234-54.smtp-out.ap-northeast-1.amazonses.com [23.251.234.54])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4549EC76;
	Sat, 10 Oct 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651476; cv=none; b=lJjLn+jgn7vrFX7mM+8PgpQLohHFJVazR7GpMnmDw1MpqPiTpeY0PRONHFbW0TvFBAjnOYe/437lHTOzzjETq0HE9UKXKyN+QIemtOO9XC62TBtQNdWGmflB9puTW6sdPup9YcHeB1LuPAOo2YC37VNXPgUsRMI90Efv4IhQxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651476; c=relaxed/simple;
	bh=1HTzDcBC99Hgks6xTyBGa4tzohGob9q9bOJQgBqtGZ0=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=jitf3vAo3BI2eUUqVaIM8Kty7grn4kvEsKugneuc9lQYwxX+Wc7iRrpdPVb42ltqRDTa2tq6WF+isVTNc0RHEnVkYLmqs6yOIIXGyOPz2XjGTa4hIpWILBvLKrVGUuimlffKX1IRtlmIVxAzjQetN6ygI+f+RSkqpJZi1jUQASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=fv6muvip; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=OJO7LtyV; arc=none smtp.client-ip=23.251.234.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="fv6muvip";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="OJO7LtyV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651472;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=1HTzDcBC99Hgks6xTyBGa4tzohGob9q9bOJQgBqtGZ0=;
	b=fv6muvipevH0k0YdEqNyP8i4NAgucl4YZDSR8FmO7gptKxQDjVJ3uevKI8G1K0pu
	ahH0DXA5hxupRzx2YQ2FZU0EYAvdRlWWnU7L8a9CvqfIH1Mv7UMslTkCKuS3508GYRO
	iuaupGYsjfzvVdOznnmOlvL5/ZGEnPWzSWx5WNIQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651472;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=1HTzDcBC99Hgks6xTyBGa4tzohGob9q9bOJQgBqtGZ0=;
	b=OJO7LtyVbURESP9M1ywqxF0ZDyaEygdKdl6k5wTfxU+f5OLGR3RgdC6KhYltqlBO
	PxpHKIu/E9IQSe+1sIWufFt89UTpaAJkBp1knwmVoqBrFOF6K8jeGaRd0VotJ2xps0y
	Xh+76kmh6G29YSSMFDk63sDsLMEP0e6IJf3+/ZiA=
In-Reply-To: <20261010165732.43465-1-fqwqf@fqwqf.xyz>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: [RFC PATCH 5/6] HID: spi-hid: support the Romulus13 QSPI touchpad
Message-ID: <010601a126bfe204-a8cc2785-63b1-466b-b96b-2344dddc2bf5-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:51 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.54

Provide the verified Romulus opcodes, register addresses and power/reset
delays. Reset loses the heatmap mode selected by iptsd, even if the
report descriptor is unchanged. Recreate the HID device after the
descriptor refresh so hidraw consumers reconnect and initialize that
mode again.

Wait for the device descriptor handshake after a power-cycle, =
including
on Romulus, so a missing response still triggers the bounded =
recovery
worker and returns -ETIMEDOUT. Defer READY and the old HID resume =
callback
until re-probe on this device. Apply the same policy when rolling =
back
a failed suspend, retaining the original suspend error. Keep the v5
CRC-based refresh and resume behavior for other hardware.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 19 +++++++++++++------
 drivers/hid/spi-hid/spi-hid-of.c   | 20=
 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid.h      |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index 2778d147b202ab663928a851198eca8fe628b16a..=
bd27bc3ea34c5fa65a903dd204800dbdafe3a7bc 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core=
.c
@@ -287,8 +287,9 @@ static const char *spi_hid_power_mode_string(enum =
hidspi_power_state power_state
=20
 /*
  * Wait for the device descriptor =
response after reset; the device then takes
- * requests. Set READY here: =
the report descriptor check that normally sets it
- * needs power_lock, =
which callers hold.
+ * requests. Set READY here for devices that reuse =
their HID instance: the
+ * report descriptor check needs power_lock, which=
 callers hold. Devices that
+ * rebind after reset become ready when their =
new HID instance is parsed.
  */
 static int spi_hid_wait_for_reset(struct =
spi_hid *shid)
 {
@@ -304,7 +305,8 @@ static int spi_hid_wait_for_reset(str=
uct spi_hid *shid)
 		return -ETIMEDOUT;
 	}
=20
-	set_bit(SPI_HID_READY, =
&shid->flags);
+	if (!shid->conf->rebind_after_reset)
+		set_bit(SPI_HID_READY, &shid->flags);
 	return 0;
 }
=20
@@ -366,7 +368,8 @@ static int spi_hid_suspend(struct spi_hid *shid)
 				shid->ops->deassert_reset(shid->ops);
 				enable_irq(shid->spi->irq);
 				if (shid->hid) {
-					if (!spi_hid_wait_for_reset(shid))
+					if (!spi_hid_wait_for_reset(shid) &&
+					    !=
shid->conf->rebind_after_reset)
 						hid_driver_reset_resume(shid->hid);
 				}
 				return error;
@@ -431,6 +434,9 @@ static int =
spi_hid_resume(struct spi_hid *shid)
 			error =3D spi_hid_wait_for_reset(s=
hid);
 			if (error)
 				return error;
+			/* Refresh will recreate the =
HID device after the handshake. */
+			if (shid->conf->rebind_after_reset)
+				return 0;
 		}
 		error =3D hid_driver_reset_resume(shid->hid);
 		if (error) {
@@ -916,8 +922,9 @@ static void spi_hid_refresh_device(stru=
ct spi_hid *shid)
 				     (size_t)error);
 	}
=20
-	/* Same report descriptor, so no need to create a new hid device. */
-	if (new_crc32 =3D=3D shid->report_descriptor_crc32) {
+	/* Some devices lose userspace-selected modes even with the same CRC. */
+	if (new_crc32 =3D=3D shid->report_descriptor_crc32 &&
+	    !shid->conf->rebind_after_reset) {
 		set_bit(SPI_HID_READY, =
&shid->flags);
 		return;
 	}
diff --git a/drivers/hid/spi-hid/spi-hid-of.c=
 b/drivers/hid/spi-hid/spi-hid-of.c
index 51bcb1a1b2a85480044c6514890f790e2=
930f523..3548c2cc450e84098dd5b5cfa6ce85d3ffd43b42 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of=
.c
@@ -56,12 +56,29 @@ static const struct spi_hid_timing_data timing_data =
=3D {
 	.minimal_reset_delay_ms =3D 100,
 };
=20
+static const struct =
spi_hid_timing_data romulus_timing =3D {
+	.post_power_on_delay_ms =3D 1000=
,
+	.minimal_reset_delay_ms =3D 300,
+};
+
 static int =
spi_hid_of_populate_config(struct spi_hid_of_config *conf,
 				      struct device *dev)
 {
 	int error;
 	u32 val;
=20
+	if (device_is_compatible(dev, "microsoft,romulus13-touchpad")) {
+		conf->property_conf =3D (struct spi_hid_conf) {
+			.=
input_report_header_address =3D 0x1000,
+			.input_report_body_address =3D =
0x1004,
+			.output_report_address =3D 0x2000,
+			.read_opcode =3D 0xeb,
+			.write_opcode =3D 0xe2,
+			.rebind_after_reset =3D true,
+		};
+		goto power;
+	}
+
 	error =3D device_property_read_u32(dev, =
"input-report-header-address",
 					 &val);
 	if (error) {
@@ -98,6 +115,7 @@ static int spi_hid_of_populate_config(struct =
spi_hid_of_config *conf,
 		return -ENODEV;
 	}
=20
+power:
 	conf->supply =3D devm_regulator_get(dev, "vdd");
 	if =
(IS_ERR(conf->supply))
 		return dev_err_probe(dev, PTR_ERR(conf->supply),
@@ -206,12 +224,14 @@ static int spi_hid_of_probe(struct spi_mem *mem)
 }
=20
 static const struct of_device_id spi_hid_of_match[] =3D {
+	{ .compatible =3D "microsoft,romulus13-touchpad", .data =3D =
&romulus_timing },
 	{ .compatible =3D "hid-over-spi", .data =3D =
&timing_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_hid_of_match);
=20
 static const struct spi_device_id spi_hid_of_id_table[] =3D {
+	{ "romulus13-touchpad", 0 },
 	{ "hid", 0 },
 	{ "hid-over-spi", 0 },
 	{ }
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-=
hid.h
index dd3a851777a22eefa9005dc6f7a18bf62c5ac6b3..=
ccbb4b9d3aeefa759a7a824ea28f3f9a5450b3b3 100644
--- =
a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -17,6 +17,8 @@ struct spi_hid_conf {
 	u32 output_report_address;
 	u8 read_opcode;
 	u8 write_opcode;
+	/* Reconnect hidraw clients when =
reset loses device-specific state. */
+	bool rebind_after_reset;
 };
=20
 /**
