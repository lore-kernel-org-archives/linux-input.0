Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591336;
	b=o7Z4HWW+3JhNgk7SE36prGDABZXtx3mVVtM5WwKQys+KYuN8Y6GEp9Y9ISiSq+cZwDGW
	 E/N+B3+auWxRjUuf6wGhA9iWfl7U3qksCj3V3iSn8qlXAek2lQVz4dT0GK7UHpbAocOxk
	 Pyx5YPvvIYYlCQxPWs+whA8r6ulWF0fhubkDkzVBBEHcwGmIO3XTbGAjAOqAEtI3fUbXO
	 t8JOphy1NLKAGELMLWm0H3l32GQGpe0LqoU4TLi4BF+N0kF2fiKzCgKwNmwJ3iTApG+90
	 DRAEbrrBYJXY5AGSKMXwIMXZLvow0TbknLOCtZMLFTCWP5kwy9VJ09QnywMgTGGB/wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=umIzXWQdNDay57Wfnlh/2+Wjvhy6i5HPsdMezTs6JT4=;
	b=t94oudf4e8nX3F0EMmLMH4him+WAlBaxqBTYRHwiq3SkM4hx/Cw6RJdGYT5tLUAs9hG6
	 bDgelQyR9A3ysBny7TcnNMFhIq8ohXcRfX+o8pq5RV7FWdcpgSykGEs84ZOZI9cXC0/Wy
	 wIi9jA2q6cVH+xVuhtNh5QNwAVYQGlWjxG0urLCyL7MqQR0J+0wM9Ks9toxu7yV4cseSf
	 svbGiTgu3p0qqMLtVpQsI30pCEnj8tlgP/JS2hiLQVXkecuG+Q63ceJQ1VdRyWvQLvKS1
	 H5eh6raLwicaltPFALkIsRdKMrzti3Ku789DaKEKEtfoICByOw9CSQpinM2K4QuP7zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=e7ltQSeu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8B606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=e7ltQSeu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so54963535e9.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591334; x=1796196134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=umIzXWQdNDay57Wfnlh/2+Wjvhy6i5HPsdMezTs6JT4=;
        b=e7ltQSeuZwReH6a/+p+2G0PshsvEhE6QDFxuy6XzzdFU0m66W3NiSJ1eW8f5pF44Mi
         YnNLhOtQpnoczgYbaecsKwlm57gnOqb7nz2/4DAKtu6wr5PGuJM58N+lsFTi9KR473pq
         v1BOO6BepaTPAV3eYitt5h6CQdT56A1n5hzKKTTRMuzJ76tlpcDz04KgweNWYKtSRJV6
         Xffn9KFwIwzlaW0XeP/HBQ5BopVpq/SghpRTAFSiNTyhw022pZHDPSMeEc1wXsc8yMFF
         Dd2LHg8+Mlst3qiHUi7teZDddcdXLsmt1+g7qQdk1BwTAPLg28nK77Y9mzCpHMYkGqwu
         Ww8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591334; x=1796196134;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umIzXWQdNDay57Wfnlh/2+Wjvhy6i5HPsdMezTs6JT4=;
        b=N5ggHf82dcX/dgWpLdOyoD4UofXpYTKLRQBiLCPmdv5V9m2UiMtWtAqxV1phO/ZZWT
         UCG0Q+kY5EdiwR1i9UzRo3WStf0zCRCpS0cuQyAwIgPWrW20++VqZ7SqXCXhwUXD1FHa
         VvACRdtNSIq8gbMMbz16zJwHIjKiowrB7CES8sYJZYQEu9lXwEnNMCfW+YyeRQJqMCQQ
         aYY0miOItR4R3c6d8uKC3/11pEmsKLbfaSnt6ra+O/BXncJFo32iGko8skDoHXF6otVm
         7lndsPr7bp3NAM38HsPoy4dIQ5CEsgetPnnPipB+3An9obv1mrp2rwvQiyBRXeV/35Ke
         uSlw==
X-Forwarded-Encrypted: i=1; AL+hErGUdJMxls6X/eRpEVQpgPKJpr7GvJmztMuawZYfUE3/VBxpleoArV+pI9bWOsIRQ2F0TtY7OpdHM/TIDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qsph2RYXGVpiBrlhGsPKXyq+bn6XY7aGb+vR0kCiMbr/xd0jU
	sb0P6i0Y1WmCTbsgbDAiyaylGS7lQ/72Nm/Uss3QqkjOwpL/s2RgGv6szmN8eTp4t3w=
X-Gm-Gg: AZFdTZcd6x3gyjic6BVWaw7G0pkJpP4rhE3A3tf5eTf3fnVKRxq317dMicbxlbNlY6y
	dT42srIns61cPAXISx4ZYeVnL5BSTm60ZR6XN4qxmYsQCIJQ8ZGL8aKJE7kA+L6+laEPoBEHEdu
	bLX2/i5OH3P9gy3f2REMkb0IkGjqyAf3eujcDaTSZAlSlipaQrzLsG+jkCytnckHVUp4FH1cqrj
	9R4vxDlzDWZouoUnDueDAmnt9meen6HdRrKFRb5O73xzzO1QaH893X1tztPXL2enFcT4Q5GgIt6
	xRke40vrjrjIKlBueJ+YM/axvU24ooadRUY2gdFG/BQaWrPCSgq+NjnW3RGquLYGFkjD3vL0g0y
	r4yXXSX5LK4+SNG4Ey4oEeY5sq3Rk6EvBdwQYVqiD+9FnHOIg4pzq+qZBbtvMUD3N8zICvv/s2/
	k1/KOHVqVmdiO1q+nsO8r44coPLh+5FS0nYhQpLCEJ/cKuCakiI4ZNOW5rqSAbW+l2ko+5ubIzF
	D0VI6keOAxth+JckqJCTD5QU4IJGF9H4eyHwq2NV8FHD/M4UXhjTDgdlzr2MHgLWdKQsAgd/qTt
	D3X9uNJnrwEuqXOdkcj71wuTe6icZBNE8Q==
X-Received: by 2002:a05:600c:1115:b0:4bb:a602:6c8b with SMTP id 5b1f17b1804b1-4bba60271damr13131425e9.14.1795591334258;
        Tue, 24 Nov 2026 23:22:14 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884b39b6sm453947725e9.12.2026.11.24.23.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:13 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 2/9] HID: i2c-hid: Use designated initializer for hid_device_id
Date: Wed, 25 Nov 2026 08:21:34 +0100
Message-ID:  <52586d870a6dfb31d6bc42f946388a2d30d716ec.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1ImbJgJFVUNa/gHBfoMyngpPi9/AkALjP7WrwDilvhE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoyBQq1qlIgZIkeoJD3eDCodAJfVeyE13IXEw KQdxl7+RkKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMgQAKCRCPgPtYfRL+ TnsvB/9eobm4hvIjjUe4iO+R3GgP8Bf+wC5ITS33k0GipuPkw3TF3iFRWKX540rgEDf8TCoiPF1 aEUeFgTPguEe5k9TXMOtuSpY6SPA7Md2gozn2U1SPvfWyYHhPn0axSUqtZe+WgRQ1canpiScXRU dqfVNOopJdO3dMgW9mcdH6on7cOVPimihReUavVOd1xYQGtTHiCvYLg8fAoq52QMg+bGjPKJsZF NNrKSk1bUvN8S/lltqCGKixy3Mee5V9wY3Mavm8ovTJMiv9EfcnFVgbyKsIBOFCZVAIkV5xG6Hl +PMiC0X7mUDKjA+avyw69b0j7THtoDomft16X0NURaX2hK/E
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct hid_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 83b9bc4b02e6..c1f81154f6ab 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -419,7 +419,7 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 
 static const struct hid_device_id i2c_hid_elan_flipped_quirks = {
 	HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, USB_VENDOR_ID_ELAN, 0x2dcd),
-		HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT
+	.driver_data = HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT,
 };
 
 /*
-- 
2.47.3

