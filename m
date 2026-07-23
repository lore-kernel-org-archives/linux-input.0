Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3F45D1BE
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820215; cv=none; b=OdTPZorcWOvmXZw+vJBcpLXmgFbwVPIJ6JuEtVgKrJSkr7cC6YRJj5phd3AkEW3e0Xj4DM724QMNTyfROCiaRP/3i6ItqJ1lXefzKct0JJwBTK+OQGH38UhJ4bNncwcQ+221yLZWCzer3/TkT0ydI/S2UZqQYwtLPvTYI+hABPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820215; c=relaxed/simple;
	bh=EHwnDfpKTHBKLjDbOg7K1zPk+bXLu9KD+RIz9v6ndpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul5m+VuDKPjF3uBOFZW/Xeiljb906i/MvwFsknL9Q6XRVcKamtz7lIXNl8dfzqTNui+hYgSMxdxcIkNmtOWprUomOaZQ50kLstv8q//p9A6It0kxd/rtjlk61HbII0WGmzw4TLDei3nUa2ylYMyC0eT2u+46FFfkXDWiyordDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=mVp2XUGF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="mVp2XUGF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c160420289bso114536666b.0
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1784820208; x=1785425008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCeah5PtaC40w3m+OfjkHtjZGFO19xRp2kS9i0vWTUw=;
        b=mVp2XUGFv1NFknNCn4OSAbQnAR5Pk8yMSabtXk0GJ+8C56m3pa2hc/vHl8kVVF18bt
         OPQDybw8s9nDm7apHdvbhjEYq+EIHEY7KUpFzoMGXmxtOCZRiOn5iMAocbEZkOGvNVVB
         o8T0BJ/kfIlhbdNYWp9hhJfHh9Z12IAcvx+53QAKH40lQo+9Y+KGAbDjnZldBObUJK6w
         JLwZ8sSyMOyTelca7rdOfQefyB0nHSb95oDQVNpTvLOdfShPjaLWLh0IhmdQStwuBVu0
         ArKK8tcGedvBUIftDLXlqZ8vLpKqu7V+rmadcvxYLFNbxilVxGR9p5EAsAtyg9fbZM6G
         TiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820208; x=1785425008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCeah5PtaC40w3m+OfjkHtjZGFO19xRp2kS9i0vWTUw=;
        b=pvewodczjAVXig4S6VJef/zDcqeHegFsu4Txf0GFUQFAWUJPsga301Fp17i/hfkli8
         sK6+QAEFE5pouE6GhhWqnuyJYAFpOJClwvFsgGZ/32DHbwn75C4V0605pPTQRvVKCgqI
         Rlc80SZlFhJfT2m29hUOeQKgnHT/7xEHc5XC+jE0iGo8KBhKz9yCEkEkOtHcb0MfTGKz
         C1aQN4RAgozvGtzQq+tCFXa/gNIFRywFCpnGXp/EA2jk96l48XqdwZ9G3eTS13dEY3am
         bVCVsKuPIO9Fk+pMtHeToX7hRswhsetNecDPEinIGGrGTaTLJFA/BmdYJIIdfKY5WSOm
         U95A==
X-Gm-Message-State: AOJu0YxoRLJmEVyd4r1vA+2aTcb+8fqXn8el4K6ZCjaXcmaEVaW1qgT+
	8qdVzixWi5ZGxCvpoktDbp3Bgl+2gSHbUCoh5N+k31UgDJ1XT2MSrWP/cLJ2c5rfHw==
X-Gm-Gg: AR+sD10oj5bEq3vkJSwlIEXDzkkbE926FWjU7B843tSD2vIT3z6+fb19Ujk/jkySEuE
	6QoKihya1QhdPe9+m7sawFLFhGjT1luYxYgaCUWysoU5TbYJD/Eb/fFrvYF+NGlyX2YBD4D4OVp
	2d8lKZyCr18S+mJiyp+a91/sugE7vGHvirvSzc+ONW2cVzKrL42g81/Ryvw+aQz5rR2EkLtCQLt
	yX9tECbA/sIle2vi/OGt+tOqPV01rL5luD5Kyi0ANWPt9E1I2dGIqAlyAG6aZocD11+lnC0xTj0
	4M9RLBQbgYyOIvwlZDmd0kVpLB/SC79reGmn+ck3jMXZh5XHIfUjWzDUsFyzp0MDsuqsr2EHppE
	mtmDnvWhBWqaeNhuSnyEadAjFqAXpLdhRqeHXMWu9gfSRmz6OTz+ame9Ln60bRpdzBJEDidg25X
	d+t/xrMmZuiKBP8+IUKLBOMv6uR/LKx4TQFOG2gJbaEQmAgdndgcPWeasDwHcrZRwU2KfLgP/Xd
	BxDLuZzDovX1v503Iugn/AwUhBvwzgslXRUuZjGfZ2IHxLjBPJD
X-Received: by 2002:a17:907:741:b0:c12:4c93:852b with SMTP id a640c23a62f3a-c1c50b42321mr166886666b.13.1784820207907;
        Thu, 23 Jul 2026 08:23:27 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb385sm250749666b.52.2026.07.23.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:23:27 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v3 2/3] Input: ilitek_ts: handle short I2C transfers
Date: Thu, 23 Jul 2026 17:22:43 +0200
Message-ID: <20260723152244.11252-3-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723152244.11252-1-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
 <20260723152244.11252-1-kristian@mide.dk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that i2c_transfer() returns the expected number of
messages in ilitek_i2c_write_and_read().

Short transfers were previously treated as success, allowing
callers to continue with partially filled buffers. In the report
path that can expose uninitialized stack data through debugging
output and can also confuse packet parsing.

Signed-off-by: Kristian Mide <kristian@mide.dk>
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 86975fa9a..a184d024d 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -131,11 +131,15 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 		error = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 		if (error < 0)
 			return error;
+		if (error != ARRAY_SIZE(msgs))
+			return -EIO;
 	} else {
 		if (write_len > 0) {
 			error = i2c_transfer(client->adapter, msgs, 1);
 			if (error < 0)
 				return error;
+			if (error != 1)
+				return -EIO;
 		}
 		if (delay > 0)
 			fsleep(delay * 1000);
@@ -144,6 +148,8 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 			error = i2c_transfer(client->adapter, msgs + 1, 1);
 			if (error < 0)
 				return error;
+			if (error != 1)
+				return -EIO;
 		}
 	}
 
-- 
2.54.0

