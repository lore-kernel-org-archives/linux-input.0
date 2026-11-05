Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906159;
	b=u3w5OXw8gvBxGbA23AOHDUNJJvqWcY4rRZAuAdd++dw9hh6CR6SEixEMw17dJj5T19Tm
	 2nU9i/IdgoZpWB+9V42MBqY540/lEt59hsjgYl3egJGXTHuHgQTVTtUZf/kZitedPMc3A
	 i53l9/4rD9MzbXXz7NPRXSXDws++Qvd71tAUz+Zj9UAUHtkD8PpUPenB2gWNphUkgsxq+
	 bNS5UDIYW4ALXS6WtLQj+kcf7qLUFDkI4OtLNF8P9xWrBt3Xgc/Ly+7RhbR6Bgq9Hs+Gu
	 c1KVyVwnI2Rlb3/B5n0X9pLRhRFucUdbGBPcvxUKCNHqKlIdAcioSls55EXTaW8nP2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906159;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=X54UwYbSb+05ebANv4YapZ9VY892l93t3mgGNXkFDW0=;
	b=zKrNjSVmiOIRXeq076W1rwY1WUIkBnlYHfVNM1ytKvKftURuBx4tUg9igGcxDl7efG5x
	 JxhuGsWaobXJgflpiMZMlJWcIaPAPg/id8Ez3nqPhvPBlrxVURmKKT8sbvkyW62g0OBli
	 Y7wXUu5llHoM/f436mvGYzsOYRUDyr2jTauGqxA+0dVUcfumgwrvgT1ApYL8hDs2m9zKs
	 nMhEQKDM+hJhLcvkRfWyyArQ5XS5xNbzRqz/WcHwu+5q4DxpReVsQsKG2cv/iw4eeZm3f
	 lLBjC6wzns8x/RCGSZHRpvNaolCOK5nkl3kkVvuaURd+7IYdWnw4Uyk91Q0ZSaysj4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=SXAHvtkE;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=lJjUPlHn;
	arc=none smtp.remote-ip=23.251.234.53
Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FC606A32C;
	Thu,  5 Nov 2026 19:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E28FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=SXAHvtkE;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=lJjUPlHn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906157;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=d2O7nCXpvGkXMgDmCYKjJ0rK7qOQibI0usnaJN2HSr0=;
	b=SXAHvtkErrTe9aBKjtsgGjxxSP5IJBSxaNbRLSTlKSpqYf3ETrKAKb26tqu7j5Ze
	zHI+TVBHPuyBHY0udfSRuzBQH0eZs/bwP4xkFvOV0ZBm/G2v08FW3OBa6kBNC3b4BtH
	mhiLYo76kpQJkL+17lryprnO4TlI6AHKbd3/M134=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906157;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=d2O7nCXpvGkXMgDmCYKjJ0rK7qOQibI0usnaJN2HSr0=;
	b=lJjUPlHnPHLWHsWR/Ux+9ku40WxBsAF35mBfiis1MTLQzudkeRwbXC3cjh6XOp03
	f5d1x3PSY8Fn4EDrUUT6stsyO/QRFtUV7UrvdFR53cIKQimGixGxovb3moH64r23jIv
	jJZRHBctrptc+4L3GxnNMmuX3N7nPIB5lbAqZ8/0=
In-Reply-To:
 <010601a1ad16c6ff-c0275058-3f89-4341-81eb-ca26372f8d70-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1ad16c6ff-c0275058-3f89-4341-81eb-ca26372f8d70-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] HID: spi-hid: propagate reset GPIO errors from
 resume
Message-ID: <010601a1ad23a7b2-efe64de9-4462-4756-81e1-c2004d5ad751-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:15:57 +0000
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

Stop before powering up if reset assertion fails, balancing the IRQ
disabled by suspend. If reset deassertion fails after power-up, return
that error and queue the existing recovery worker. Otherwise resume may
report success although the device remains held in reset.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 =
deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c =
b/drivers/hid/spi-hid/spi-hid-core.c
index fd64d2d2cb..f2b2106600 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-=
core.c
@@ -316,7 +316,7 @@ static int spi_hid_suspend(struct spi_hid *shid)
=20
 static int spi_hid_resume(struct spi_hid *shid)
 {
-	int error;
+	int error =3D 0;
 	struct device *dev =3D &shid->spi->dev;
 	bool was_reset =3D false;
=20
@@ -333,7 +333,12 @@ static int =
spi_hid_resume(struct spi_hid *shid)
 	 * while the device is off.
 	 */
 	if (shid->power_state =3D=3D HIDSPI_OFF) {
-		shid->ops->assert_reset(shi=
d->ops);
+		error =3D shid->ops->assert_reset(shid->ops);
+		if (error) {
+			dev_err(dev, "failed to assert reset: %d\n", error);
+			enable_irq(shid->spi->irq);
+			return error;
+		}
=20
 		shid->ops->sleep_minimal_reset_delay(shid->ops);
=20
@@ -347,11 +352,13 @@ static int spi_hid_resume(struct spi_hid *shid)
 		shid->power_state =3D HIDSPI_ON;
 		reinit_completion(&shid->reset_done)=
;
 		error =3D shid->ops->deassert_reset(shid->ops);
-		if (error)
+		if (error) {
 			dev_err(dev, "%s: failed to deassert reset: %d\n",
 				__func__, error);
-		else
+			set_bit(SPI_HID_ERROR, &shid->flags);
+		} else {
 			was_reset =3D true;
+		}
 	}
=20
 	enable_irq(shid->spi->ir=
q);
@@ -365,6 +372,9 @@ static int spi_hid_resume(struct spi_hid *shid)
 	    test_bit(SPI_HID_ERROR, &shid->flags))
 		schedule_work(&shid->reset_=
work);
=20
+	if (error)
+		return error;
+
 	if (shid->hid) {
 		if (was_reset && spi_hid_wait_for_reset(shid)) {
 			/* No reset response: let recovery retry. */
