Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794921975;
	b=q059YibiqY8F2XX5MlGCNIRsVQvvNYiAZ1K8hj/XbYnvGIBvMkDsNY3EkYkwIvFn2AZG
	 T54I7cxlnfrHDHEwxRCTje8cndDh65AyHHD6LqbBfUdgH/bvxRxjg9jvToLLQikOkVBhm
	 qNElSAybtc8IpJd/D+UDP/+xntwNP5YHHXcAq4/WPOE/T8t7ZaCKLvBJA4nIlM4Y1oIes
	 wuJ5PEoU8Lw+gSWOUYrGK7Ht2jSswg7/glWgXhkcBQcO4sBVZwitMiXuJwb/oQ3oFTmYy
	 CiWpy7MUF5bmyvNUPBhBeKIYhVRGsMM+XczuVQYw3IGTwAcZ32NmjeV8jnK67h4aAJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921975;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=JLgV/lBDqG6GZ1zXBD8D34tpWmlQDGgMfYhw/O/fKmw=;
	b=nKn/ACvcdq97PBogufbF9vcCCbs0LY7xEE5cVe4Q8cy7ZPdp6RorQAJ454DgAhxau4YY
	 fEPTyJ4m+iMUUT+3ycfnSylO/HzTDRNeRezahRjuwOr8CYRlwe8CmZHrj7vCOTckF0Dfg
	 aqbaLYA8cDsKWbxg0c+bodk1qWlqZuXVe5Rv3SnjA5j3H0Wjcm0ugVERNzDJDqIPJJs4T
	 2DEvsSd/asSbtwgt2y2VgWgqhOIMhsoY/99dV3PQokc+EFBVsJxCSrPzHqBdB6hbOd/4F
	 a3THz+Ip9ZlxV4VOdA5Pr5nCfV67aQ+DRcuehCDKNWU/+p/RmoJrlshhMa4V2hFeNvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ommer.net;
	spf=fail smtp.mailfrom=ommer.net;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XZRcdpBt;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=sPrGpKkk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59D606A330;
	Tue, 17 Nov 2026 13:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD59D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ommer.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ommer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XZRcdpBt;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=sPrGpKkk
ARC-Seal: i=1; a=rsa-sha256; t=1794921972; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JePVK9fehY7HHm8ZzZmyyIUWwFiiZZfhE5EnZ0AEaG/jlcRgdXt5dJ65AUBkLfkg45
    ygX74FB0kFVFXd0vroWFG1IF5+ORyEr7ts1DVXTbBMxPuW/4OgQjpvpHjcs7aT8gtiSA
    qFvn+qeITRhoBAVlTravMLpL5gAg8TF5imBus9WskifY6m7cd+QVyUoPW4+u50/9rAXx
    Cor0/CwJeeAL15Iacbz9Eldh8ghYSzqIa2AizQVMQ+JgL0SHo82byOeW8DKemnBC0m46
    Od59FoowBcHKhfsKIQwcGwa0PnkDrZaSfJEnDluyCyCg+O3ryGs7GDdz9L4msOi0KBfN
    zQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921972;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JLgV/lBDqG6GZ1zXBD8D34tpWmlQDGgMfYhw/O/fKmw=;
    b=ivNC4Sy1kz6ZhXgKPr4QvBotFT68NQ/TFHk3sh+2p1Qna/fljk80eW8Z254e/gDyBf
    R3WUCjJzXwdZBjdkqDotdjICdOykDGMpPED3NQPYC9Ez8H+P32l99yUiCGRBsEjMyQml
    K068Sqd+ksy1OusJlM82HOVkW7ctQfjvC64WrZRrcjdqAQ7a7jpzOES0EG6fWs5VkVCU
    RCVfLxys2qjikDP7nMuic2OxEzd0W0xqyPlWWNReqU9RoiA7XyJvsOpZUzCp7BV9GTt4
    WG2NXL1YIST0jUzzwvPWt01HUx1p1EAfWdXCzRAwwAwuDZZXmMEWKovWr3+CeOITY4Nd
    PsGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921972;
    s=strato-dkim-0002; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JLgV/lBDqG6GZ1zXBD8D34tpWmlQDGgMfYhw/O/fKmw=;
    b=XZRcdpBtKkVP6fhWeMm/bBPX/NP0o//wxOue0I0bdFddAZhipeIVErIyPfjjDO3ymT
    lkUBh5PZDBYZ4sC443kspnaFyYe7kfamHumhpZ6vNHxmnj48xnD+hkBG0yHWbHsUgEFs
    n30MktV0c2bkKvgyoShNA563XgwlCGJ3zmiKKchD+UmGqkujDdw2QCWcty9VJfX8I6ZH
    Zs/egacuaWIrrlbpP84jFi7EQoqtqfyMt2MEez8Z5Dfh3nrr3ZZ1Sl5HPVM+Ee7MBjE1
    XPG38pXZyNbgq8ULzKhQEAJm30lPfZoBJSn767kVWpACaV4BM1NtMzDL9tqyEFmdgPXA
    eVYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794921972;
    s=strato-dkim-0003; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JLgV/lBDqG6GZ1zXBD8D34tpWmlQDGgMfYhw/O/fKmw=;
    b=sPrGpKkkDPjE219C0HVU/1PJG+bDT9uBKrGCocs/Jj/ptvZCg7tndSstLTIhyue6lf
    lcNx2KZbQAgNdCgb+HDg==
X-RZG-AUTH: ":JGkKZ0mIdPJLfj3rk5MOrv6kH/tvwFubxUqMvsWOyVXJkOABZnPqvKUstHY8FQgnq3rT6NoXCyjULwIut1Tf8meVypGj6A=="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id n2f42d2AHDQCvuM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 14:26:12 +0100 (CET)
From: Henri Ommer <henri@ommer.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri@ommer.net>
Subject: [PATCH v2 1/3] input: himax_hx83112b: Make reset optional
Date: Tue, 17 Nov 2026 14:26:11 +0100
Message-ID: <20261117132611.12145-1-henri@ommer.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Some versions of Himax touchscreen chips do not have a reset GPIO. In the downstream driver these chips are only reset for firmware flashes.
Since firmware flashes aren't implemented in this driver, resets can be skipped.

Signed-off-by: Henri Ommer <henri@ommer.net>
---
 drivers/input/touchscreen/himax_hx83112b.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 345ece27fe74..3521b05d509f 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -132,6 +132,14 @@ static int himax_bus_read(struct himax_ts_data *ts, u32 address, void *dst,
 
 static void himax_reset(struct himax_ts_data *ts)
 {
+	/*
+	 * Some versions of himax touchscreen chips do not contain a reset
+	 * GPIO. The downstream driver only resets these chips for firmware
+	 * updates (which aren't implemented in this driver)
+	 */
+	if (!ts->gpiod_rst)
+		return;
+
 	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
 
 	/* Delay copied from downstream driver */
@@ -349,7 +357,7 @@ static int himax_probe(struct i2c_client *client)
 		return error;
 	}
 
-	ts->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	ts->gpiod_rst = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	error = PTR_ERR_OR_ZERO(ts->gpiod_rst);
 	if (error) {
 		dev_err(dev, "Failed to get reset GPIO: %d\n", error);
-- 
2.56.0

