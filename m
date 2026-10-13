Received: from e234-58.smtp-out.ap-northeast-1.amazonses.com (e234-58.smtp-out.ap-northeast-1.amazonses.com [23.251.234.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E472F67;
	Tue, 13 Oct 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861064; cv=none; b=j9n/udqfcVC2Y+Cr6liXhUQzvrVNHrpOfMH1nsTIhrY83P36GUQ+6qbpnY+WOWCf+YXk6ySV/h1OFJ7KPxsi4iDwinKbh+CeV7c32GDfVYBkr25dOCTVPYH9oV4ud89PLbzT7f824IV1vDW9z83PWrRuXlpUZAOQ8XCnBkbJh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861064; c=relaxed/simple;
	bh=VR41eEYLUYj8D7pqp0Uun+VJZ5iWT3TvUsAEdzWsKqw=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=H/pDSI8JDVPbbEuIW07cVZrYn5Cuwj96dCg3EeUpbu3CpaH5BF6ycnFLlcJ+7FU8lAwwhJObiiQMjXMTUoyc6MqHrBeZUjljG3FAlA9MPiPkHKrPfsULAUQRvojY8ZGthZDY0b92Su3UKQDcVBkMpeSTK/ZOBTXZ/w96bzC0wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=eb5OPN9y; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=TUw/9o9u; arc=none smtp.client-ip=23.251.234.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="eb5OPN9y";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="TUw/9o9u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791861062;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=VR41eEYLUYj8D7pqp0Uun+VJZ5iWT3TvUsAEdzWsKqw=;
	b=eb5OPN9yNyD7wM+RsUrJW/JjrwUiYzI2tiw/Tu3/KscJDlMPGuUJ+Riwpgj4JV7Z
	LVeP6UjLAgIqLoutNRDJmhgI2ehm0vOLLQpsXT+g33Qzr69RTiEals/EUg9HeTrgQrK
	XmYoL3PXSqJhI6MvLxd8uyowSYdioFee/kWTXQqs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791861062;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=VR41eEYLUYj8D7pqp0Uun+VJZ5iWT3TvUsAEdzWsKqw=;
	b=TUw/9o9uJs61AGf3HfaohRL81PvVWLCPwU/bCR15JUk+ipFdZpo0+6vTeKRu8sGC
	mR1HUgtvLnz8KL4vH79OM5uEfvJaY6d+BP2DP4ayU522T9cgYOl6AhZa8ASCCQIkYUF
	hKATzSEAzTPgUfrcl+EkdX/c2dSXspw/tkvarvvc=
In-Reply-To:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: spi-hid: report a missing reset handshake on
 resume
Message-ID: <010601a1333df91b-244682b7-5c82-4334-85d9-1413351f392b-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:11:01 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.58

Return -ETIMEDOUT when the device descriptor does not arrive after
reset. Do not call the HID reset_resume callback before the device can
accept its requests. Clear READY and schedule the existing bounded
recovery worker on timeout. Apply the same rule when undoing a failed
suspend, retaining the original suspend error.

Report the incomplete =
device resume to the PM core instead of returning
success. The scheduled =
worker may still recover the device asynchronously.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 =
deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c =
b/drivers/hid/spi-hid/spi-hid-core.c
index 1aae7863e87de766444e7eae392335e4=
b1daa85e..0046dfdd82677bb55c5a0b6742cdfaa8fec224c6 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-=
core.c
@@ -255,7 +255,7 @@ static const char *spi_hid_power_mode_string(enu=
m hidspi_power_state power_state
  * requests. Set READY here: the report =
descriptor check that normally sets it
  * needs power_lock, which callers =
hold.
  */
-static void spi_hid_wait_for_reset(struct spi_hid *shid)
+static int spi_hid_wait_for_reset(struct spi_hid *shid)
 {
 	unsigned long timeout =3D msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
 						 SPI_HID_RESP_TIMEOUT);
@@ -263,10 +263,14 @@ static void =
spi_hid_wait_for_reset(struct spi_hid *shid)
 	if (!=
wait_for_completion_timeout(&shid->reset_done, timeout)) {
 		dev_warn(&shid->spi->dev,
 			 "Device descriptor not received after =
reset\n");
-		return;
+		clear_bit(SPI_HID_READY, &shid->flags);
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work=
);
+		return -ETIMEDOUT;
 	}
=20
 	set_bit(SPI_HID_READY, &shid->flags);
+	return 0;
 }
=20
 static int spi_hid_suspend(struct spi_hid *shid)
@@ -326,8 +330,8 @@ static int spi_hid_suspend(struct spi_hid *shid)
 				shid->ops->deassert_reset(shid->ops);
 				enable_irq(shid->spi->irq);
 				if (shid->hid) {
-					spi_hid_wait_for_reset(shid);
-					hid_driver_reset_resume(shid->hid);
+					if (!=
spi_hid_wait_for_reset(shid))
+						hid_driver_reset_resume(shid->hid);
 				}
 				return error;
 			}
@@ -387,8 +391,11 @@ static int =
spi_hid_resume(struct spi_hid *shid)
 		schedule_work(&shid->reset_work);
=20
 	if (shid->hid) {
-		if (was_reset)
-			spi_hid_wait_for_reset(shid);
+		if (was_reset) {
+			error =3D spi_hid_wait_for_reset(shid);
+			if (error)
+				return error;
+		}
 		error =3D =
hid_driver_reset_resume(shid->hid);
 		if (error) {
 			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
--=20
2.53.0

