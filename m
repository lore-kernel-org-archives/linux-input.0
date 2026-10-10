Received: from e234-61.smtp-out.ap-northeast-1.amazonses.com (e234-61.smtp-out.ap-northeast-1.amazonses.com [23.251.234.61])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F7443C15;
	Sat, 10 Oct 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651460; cv=none; b=JD+WD4KcrbuIjMAicw7PyttNzI1OaQ/L6PUlc8xyj5JFicUdOconCZQP5EShAKwWJrB44LMnrHBgb0mwmp4ZqXG402YKLat0bQJsfc9joduZONnSbWIAbkZ6DVIJNHcgmt8kuD8CIN7AJjr+tOPVU2P9zr5QyvC6Ym6AMFAhFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651460; c=relaxed/simple;
	bh=9JcSRtyRAhz+XZ5XFkspqWRdnvPFrWSssDJOFE3d5oc=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=Htecwe6UHxkrqC+tNoXCpqoawiBfSvehsLZtQSScESLC35/ek5uTc5O7+GxWdyPL2ws08Avw3wAGo5aji+n8C6O3qLsO63roqfLUh6U5M1+lr/h2SRjHYQ7LWrt5Q8hZOLaH6TZalBXjdLZu17skX62EyKMeM9jU8wjZWYcivRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=Sj1UJwBF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=lzkECGrk; arc=none smtp.client-ip=23.251.234.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="Sj1UJwBF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="lzkECGrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651458;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=9JcSRtyRAhz+XZ5XFkspqWRdnvPFrWSssDJOFE3d5oc=;
	b=Sj1UJwBFO2vVPTKsjLquKIF5SPm8tMtv0kUfU3rlOIh8RPh5D3NlhLPqf+U6E753
	EcOFojjY9asXfAE4OE9wwBFSh/2cETbsZdm3HmWDmsnOxjJaEeadOJKtEU2u6juyDVR
	qhNIvIFiRqUX7YZWT+Pf891GwarMUXb0I0x4Owsw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651458;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=9JcSRtyRAhz+XZ5XFkspqWRdnvPFrWSssDJOFE3d5oc=;
	b=lzkECGrkzW1syU/Vp3XNpjFIAKWFyiiArUxJEqf9UeFO4H+HYsdVWJWCfZEiSehb
	0IxpieF3fwxR7LBc7QpaQ9Rwv4yRSD4o46fPMGSBbOfArxDeW3sQjYUxMw047aO3qoC
	t170u/GCfXvEDuZ9nLI6uwlFx+rF2wqde65fTXWE=
In-Reply-To: <20261010165718.43433-1-fqwqf@fqwqf.xyz>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: spi-hid: report a missing reset handshake on
 resume
Message-ID: <010601a126bfab19-4f37fe09-8dca-47ac-add6-e9795eb800a4-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.61

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
