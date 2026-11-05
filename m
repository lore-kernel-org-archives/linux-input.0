Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906588;
	b=3qurWzT92ipqNiHIRwFMr3LdgBMykEjLEEpJK/qDHCsiG1OLx+6sWFW+hq3Kd9BdCOnk
	 EzPndxwa3WVHX7V8p83BBruIp26JEp7O3S7F8OKpcapMdNGS73Q5dUeHMGby3BLALFlb/
	 m+cBWJmYiWG4fr+UMyiJiqD3c7l3uhazc7Hj6nOVTtwe7rBGBXpXnvGYuhewIYCLxBTLK
	 skTJsZUswO5V5s3wEB/K0ulNWH9hEQnyN6UqPQo4pJns+asxwOnLyAR3cmE4zALeP5tVu
	 pGz1Mg1ZoHzrjLv6R93Qh4W1L43a6VOATQrVNZ+MkzcLBG78CD5YYjONYzfpESGx+eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906588;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=piwa6L0y3OSJqwaqWxC6psUp+eJFvc86Wh3hKMCc9ig=;
	b=V64qDz7z/5tCMNqtNtFggDe6SxAj5UwFuae43J1yWQv+08vvn9hG1ADLNREGcanaoBbG
	 +0hA4EAQ2oLzxx2SBtrX6Ha7IQtuaXh5EAjbHP/JtRca3bQgRgC03nd1C1iEhPT0SETQz
	 mE5uGiVqxdv+CxA9nZyQbf3iTvVJYHTNcuG2AItA/RklHKKQRb9xCKe3LgxzTxVCB9esn
	 i5351Fpfgv1nyWx6gUxRaOx26+ShWuFa8pNUOhr20oPGLBpvx7mw4Eq2CIfU6RVzGwGwi
	 yaYM7h4HPBGjHM00ZKQQCcjjZobulRgzU0h831B29e8NZIz0Au2O3wFlp6aHYgVcz5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=kx6mBgeF;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=YoGKIHA2;
	arc=none smtp.remote-ip=23.251.234.53
Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB77606D803;
	Thu,  5 Nov 2026 19:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB77606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=kx6mBgeF;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=YoGKIHA2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906587;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=+j2pIrvxTXrtSZxTBa01KQx90R5D0RGa2Yjt5+TzjRI=;
	b=kx6mBgeFqHyoeMXjacjRGLYHCfRZNxVbEjc6ISHMeUa8Hoq759g3u8iR0edkySxx
	IIBlveWt8OyGEmzwUZu4WOMdkh3Xq+lp5G4bMc9i0tlUWv7HYCM06UwiMRviVGonLrO
	GGkd+mtd1Zimdlr1DZXhHDzDqbDensBxwOVIdnRU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906587;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=+j2pIrvxTXrtSZxTBa01KQx90R5D0RGa2Yjt5+TzjRI=;
	b=YoGKIHA2FazVGut9hqDW2kUbBiLWHrLiyCUvKsmWUtP7bKCCLdi+egqtso6pP9rL
	htMxAePU7S7zvgz0gRQL9xqNU0POAL/WWYlQ1wc88m6wxDW8Tg9zHvhl1dEH0gXvRR/
	nDc+tR4qeXFpCwuI6aoDZyxqEigXxziPGcoV7KG0=
In-Reply-To:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v3 5/5] HID: spi-hid: support the Romulus13 QSPI
 touchpad
Message-ID: <010601a1ad2a352e-cafc6394-e047-4904-943f-c7511283da48-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:23:06 +0000
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
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.05-23.251.234.53

Add the Romulus13 touchpad's protocol identifiers and power timing to
the per-compatible data.

A reset loses its touchpad mode even when the =
descriptor CRC is unchanged.
Recreate the HID device after reset so hidraw =
clients such as iptsd reopen
it and reapply the mode without restarting the=
 service.

Wait for the reset response before scheduling the refresh worker=
 and
delay READY until the replacement HID device has been parsed. Preserve
the existing timeout recovery, locking and reset-attempt handling.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 15 ++++++++++-----
 drivers/hid/spi-hid/spi-hid-of.c   | 15 =
+++++++++++++++
 drivers/hid/spi-hid/spi-hid.h      |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index ef5fb11f23..901c8d9ace 100644
--- a/drivers/hid/spi-hid/spi=
-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -280,8 +280,8 @@ static const char *spi_hid_power_mode_string(enum =
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
their HID instance. Devices
+ * that rebind after reset become ready when =
the new HID instance is parsed.
  */
 static int spi_hid_wait_for_reset(str=
uct spi_hid *shid)
 {
@@ -294,7 +294,8 @@ static int =
spi_hid_wait_for_reset(struct spi_hid *shid)
 		return -ETIMEDOUT;
 	}
=20
-	set_bit(SPI_HID_READY, &shid->flags);
+	if (!shid->conf->rebind_after_res=
et)
+		set_bit(SPI_HID_READY, &shid->flags);
 	return 0;
 }
=20
@@ -422,6 +423,9 @@ static int spi_hid_resume(struct spi_hid *shid)
 			schedule_work(&shid->reset_work);
 			return -ETIMEDOUT;
 		}
+		/* Refresh recreates the HID device after a successful handshake. */
+		if (was_reset && shid->conf->rebind_after_reset)
+			return 0;
 		/* HID requests would fail while the device is not ready. */
 		if (!test_bit(SPI_HID_READY, &shid->flags))
 			return 0;
@@ -910,8 +914,9 @@ static void spi_hid_refresh_device(struct spi_hid =
*shid)
 				     (size_t)error);
 	}
=20
-	/* Same report descriptor, so no=
 need to create a new hid device. */
-	if (new_crc32 =3D=3D =
shid->report_descriptor_crc32) {
+	/* Some devices lose userspace-selected =
modes even with the same CRC. */
+	if (new_crc32 =3D=3D =
shid->report_descriptor_crc32 &&
+	    !shid->conf->rebind_after_reset) {
 		shid->reset_attempts =3D 0;
 		set_bit(SPI_HID_READY, &shid->flags);
 		return;
diff --git a/drivers/hid/spi-hid/spi-hid-of.c =
b/drivers/hid/spi-hid/spi-hid-of.c
index 5148b6b1dd..7d3ce1fd89 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of=
.c
@@ -62,6 +62,19 @@ static const struct spi_hid_of_data microsoft_g6_data=
 =3D {
 	.minimal_reset_delay_ms =3D 100,
 };
=20
+static const struct =
spi_hid_of_data romulus13_data =3D {
+	.conf =3D {
+		.=
input_report_header_address =3D 0x1000,
+		.input_report_body_address =3D =
0x1004,
+		.output_report_address =3D 0x2000,
+		.read_opcode =3D 0xeb,
+		.write_opcode =3D 0xe2,
+		.rebind_after_reset =3D true,
+	},
+	.post_power_on_delay_ms =3D 1000,
+	.minimal_reset_delay_ms =3D 300,
+};
+
 static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
 				      struct device *dev)
 {
@@ -176,12 +189,14 @@ static int =
spi_hid_of_probe(struct spi_mem *mem)
 }
=20
 static const struct =
of_device_id spi_hid_of_match[] =3D {
+	{ .compatible =3D "microsoft,=
romulus13-touchpad", .data =3D &romulus13_data },
 	{ .compatible =3D =
"microsoft,g6-touch-digitizer", .data =3D &microsoft_g6_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, spi_hid_of_match);
=20
 static const struct =
spi_device_id spi_hid_of_id_table[] =3D {
+	{ .name =3D =
"romulus13-touchpad", .driver_data =3D (kernel_ulong_t)&romulus13_data },
 	{ .name =3D "g6-touch-digitizer", .driver_data =3D =
(kernel_ulong_t)&microsoft_g6_data },
 	{ }
 };
diff --git =
a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index e87d1cf05e..2b2f62c837 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -17,6 +17,8 @@ struct spi_hid_conf {
 	u32 output_report_address;
 	u8 read_opcode;
 	u8 write_opcode;
+	/* Reconnect hidraw clients when reset loses device-specific state. */
+	bool rebind_after_reset;
 };
=20
 /**
