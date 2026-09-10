Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30414387363
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010491; cv=none; b=Zl6/YxpwYoQyygBmwVXmSSoSiIAUm5mkX/mEQM75dTWsH0bmYyZWCEW4XT5u6HKlWRiyYT17uWEOREgTE54Jp13TEsOut8vVqLswbt0B5V9V6XxsiBFoHABA/oQO/1mzYdfegNkVbkuNKPgbqs578M4SNyLdLoHEPVl05AGFaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010491; c=relaxed/simple;
	bh=fUw52Q8KyFVDA140W88rVTkiznLG/tQsbaNZPy244T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBKNMn4HdJLvehnM+qklVWWaglKIJz+9ZoloDZLdqYniExFlcxNB7gkpDQzjykyBhtcqFONUxJ1rGpy2tJhaelL2apbYze29d78UyMuho2sHWZTAX0IjQhthTve0U0ZEADF3hAR+bwKJV5YBGCGneajcVRumIqkRF1b3ZTat/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA6qKRz+; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6qKRz+"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46af36be149so1557522fac.3
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010489; x=1789615289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Op8qEawLmjCmD3fm/ve6G52a6gnFB0iRG70Dt9TzKTY=;
        b=GA6qKRz+JSRfhOCMtQfN5atgBMlSjV20HOsOONkNtZ9oqA4isKBxidqJ8oN/qe5gPk
         h+9iQtHhEzPXonbCI9+67Epd7m6UCVuoQsTrLNqEVcJ9F3ep00tYdqhWQk4t0pD6fnpQ
         suoCknUB/qarOGBYhJsUWl6HKWfySgMnAvCiHYsjlgR69+3guZwuNJUV1adiLvXryx9S
         ApCXmDbtPgLXXBExpuPfIEqZhkt+6i0C/OZFtSe6I8q5woTJEQJGch/B4wdycA1ORP/T
         DcACPyeFfe5VfYwooxbij4MT0Y0BppwQMx6PPV9ytSJYofI6ONVewJNon9IzYQV20UI/
         6Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010489; x=1789615289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Op8qEawLmjCmD3fm/ve6G52a6gnFB0iRG70Dt9TzKTY=;
        b=P2vt2wU/p024BkZ5ywzs9TF5Ky6BPutetGEfbFzmyJOHGFt5vPKnByucMIxkbsu+So
         LCWjAIqoOI/77aDfqD/yErU3hcwykLu9TFMAhS86u17poq+3SR8WzLXRl98AhwcEPKWW
         smaV6wLIBrUANWZsdFzzD477dMM1mQi3JnQHWITzEbTpzwCxP+6kjKzNHAI8LoEeiq8P
         Gf5Tu+JUN97HQ4HcTgf6dEyguoUizkghfTLNcur1pgyKExD04rAi3LOhMSgu4qo5DV60
         xAlFLRTyJb4DoiXdnkKkPm/LiG9x5Cv0Jywiu6VWYdjWVePSxf2T9R1VTeE/MDwt8W74
         7WhA==
X-Gm-Message-State: AFuF++kEoMIg8BT7uDyph8W/yvoQcAUChUeaXKCeGvTj/UGIC8J7cfla
	wIHt3Z+KvfCTRlJ1ueuyOCoBxF5XdUxrhF37g0liJeSruvBTTqikaEjV
X-Gm-Gg: AYBFou27V5Zn14JmbsxXev8MBsQHuFQOt8BTOztGeZ4Cg+KG8Fg8LGK3OuLZIlnO+1/
	FCJRB8uREtW1tjvopEmI2K/ZTpzihU+9zk4T+NB9j5cBkYHPkxVh7Y3NvnKabSs8CKqQhC0W69V
	bdyPJLyv7chdj0RabFIYrzCZ+0iHE08h9hV5hEGNVzE9FTq/SR6bebiyz6ZQqW+XniUds+/bAs0
	oaLgl4xYaL5Oap4bSvjePj4KWepY5rp7LNozql/c9saGGq61YCWhPkXzYOEYv7Lt4u4sf6jJpou
	+blHEKKU4xW0NAjS46FkvpStfQ0l/UvSm4lyuhO0vvcWpTEpW6PrrEtCWGyy64wO88JQr471tWA
	w+0Rh01+ThL4DqzaK8gzP6Lrhx8wUMnBFoVKPK0v4aQM3oUQQy0mDo9TcSpwB+DkOXsXwtJscVi
	8m7k6SIcT+EiFjpPm5fY232/MybcTDX2ygElaHtr+F2xKP6p/iiURCeSCuTCQ+kk97OKnWgTW+J
	dNcI6zc9dAeJXQ4ZLtb5c8Semp7gjX0KOiRQi7x52LM+1QzlkrUdnUthgdZluB6Qw==
X-Received: by 2002:a05:6830:368b:b0:7e9:d593:896f with SMTP id 46e09a7af769-7fb79dd122bmr20984742a34.1.1789010488832;
        Wed, 09 Sep 2026 20:21:28 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:28 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] HID: hid-oxp: fix default M1 and M2 key mappings
Date: Wed,  9 Sep 2026 22:21:01 -0500
Message-ID: <20260910032115.28669-2-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default button map intends to assign F15 and F16 to M1 and M2, but
the selected mapping table indexes resolve to F16 and F17. Use indexes
47 and 48 so the programmed usages match the existing comments.

Assisted-by: LLM
Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index d2ded6b..3f2be80 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -607,9 +607,9 @@ static void oxp_set_defaults_bmap_2(struct oxp_bmap_page_2 *bmap)
 	bmap->btn_dright.button_idx = BUTTON_DRIGHT;
 	bmap->btn_dright.mapping_idx = 15;
 	bmap->btn_m1.button_idx = BUTTON_M1;
-	bmap->btn_m1.mapping_idx = 48; /* KEY_F15 */
+	bmap->btn_m1.mapping_idx = 47; /* KEY_F15 */
 	bmap->btn_m2.button_idx = BUTTON_M2;
-	bmap->btn_m2.mapping_idx = 49; /* KEY_F16 */
+	bmap->btn_m2.mapping_idx = 48; /* KEY_F16 */
 }
 
 static void oxp_page_fill_data(char *buf, const struct oxp_button_idx *buttons,
