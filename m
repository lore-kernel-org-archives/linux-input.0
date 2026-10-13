Received: from e234-51.smtp-out.ap-northeast-1.amazonses.com (e234-51.smtp-out.ap-northeast-1.amazonses.com [23.251.234.51])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84D47ECE7;
	Tue, 13 Oct 2026 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862126; cv=none; b=L6YVxoW9GVfR8HlYmWvamepDVH1q1wWU5cdxdU5JNk3k1GL3T82r880ZQ9idPo9CSInVCntsD9X8LexW4CUVASOh19og6FPyfjCLBQMgl5+jS2QfylA1D8LysuGKN9GyC10tDD33c3uVBkbvFU03TUnO/Jin1nvH1+oLaC2bqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862126; c=relaxed/simple;
	bh=2lNOZNq/HEHWLqK2iJGb6R9Vo2osSfNOSgfhuGBTAGw=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OpG9A/9e0eC6Ol7gARTlR+v25mzteTEcDoqQlRN0AZUSrjvunlmY6aLUPYeOxHiel8yxjm30MKpI0SY693HEa0R2v9OWy+dccIMGEB8/M9F7nJLikYuq4fZIXgpKFSjJroix55Y86LBQyh4WmxoOwm9jUBkQO+5vufLS/OoP/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=ABpYvkR4; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=rEHonyLL; arc=none smtp.client-ip=23.251.234.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="ABpYvkR4";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="rEHonyLL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791862123;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=2lNOZNq/HEHWLqK2iJGb6R9Vo2osSfNOSgfhuGBTAGw=;
	b=ABpYvkR4qvnG68UHYgUyI2U6XtsSFVGPmn9hCSCYDVdYW7wAiGzgkuFXnwkiFy1X
	JkpcYqxEzQOWMt+vujwZnoqD+UZELrIjsbITupwZGH+qt2eVL4P/9K88hHOIe3yTL30
	6DdOGpy3VG5wbMQ/NJt1BfT6gXyC7vnIlX2zHQaY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791862123;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=2lNOZNq/HEHWLqK2iJGb6R9Vo2osSfNOSgfhuGBTAGw=;
	b=rEHonyLLslihxlrUE0WgES9y/Hh/WAOofeTB/PBeud0HsyvgqCVfVg4iVh5Sx+xW
	5VUDAqYaqPJnU8ZVNVkCGQSxgp1vs5hZ3QA6wLcmAhG4FgjUMuv9VjCEUGPh1csicYT
	qrbIjznZfqIbRjOmRQ8xuSdfn//6/bM8qJV+624Y=
In-Reply-To:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v2 5/6] HID: spi-hid: support the Romulus13 QSPI
 touchpad
Message-ID: <010601a1334e2b1d-2dd339bf-7c38-4bfc-ac78-c97692995f97-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:28:43 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.51

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
930f523..cec149adb505b2e09f210bfb010cb37f618184b1 100644
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
+	{ .name =3D "romulus13-touchpad" },
 	{ "hid", 0 },
 	{ "hid-over-spi", 0 },
 	{ }
diff --git a/drivers/hid/spi-hid/spi-hid.h =
b/drivers/hid/spi-hid/spi-hid.h
index dd3a851777a22eefa9005dc6f7a18bf62c5ac=
6b3..ccbb4b9d3aeefa759a7a824ea28f3f9a5450b3b3 100644
--- a/drivers/hid/spi-hid/spi-hid.h
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
--=20
2.53.0

