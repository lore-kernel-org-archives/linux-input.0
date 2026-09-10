Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB439C00B
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010497; cv=none; b=JQWsDOMtU5mn1XP7jdNyI/wYwG1J3FL6SR1lEWJcEMzuNOhuEI+IiU9tu5UG/mn8/Q0sZilicTBuL0fin7a702QTP1J8i4r+GgR8quh8Cyc5DV3OWQtcGsFtwQT7YhBhH7gz7LwVqtQF+xXGhlMx0HJ8tzduoSvyJMiPkaLVrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010497; c=relaxed/simple;
	bh=yo2MDFhvnhT1VSXQJAy8INcs1Je44ObhgyQM6+ip/u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4WgQ+fUDz58+g0KlMnYsKlel25N3SlFaQJtW+9/aSjf/oFbsWpQ6UwutlGTmKTKCCN8y4Ija5uiW0TpMI86XJbH2Oockc6OEcZ6IHjTifE7EQGm3qU0n7cVCUsssp8QYgQwZ6iVAoRjYBA1nr4sD1FtftVhPv8BQyF+W7yB/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE0GXt4B; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE0GXt4B"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4bdf2e95fso327847a34.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010494; x=1789615294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0m2EXA4RWU3Xwtz9ppvYXUdEt6FGFiWjjYdvOoJpw/g=;
        b=hE0GXt4BN3EG/vuf7o+8sQCrIeCL0Mv9Hk34glK9mB80bcBH3ngSbc04bfra+HHEkG
         ZNvOpTTxscUOQjMzKHmSPncx2hMikZ2BIzAGnHKOKYJWpj6yvdu6xSodu13Tx9vzxdYa
         905q6UTHmlzFEudrsx+UBKmnUrJPdBDg4DkUcGBPcyrGdNaEuq0VoBwTh/YpYBOtr/u1
         xa47DPqXo0LI5np21UIZQV9kBpoCeX3hsZJSMtRepbBTGd40iqew2+oWyv6G4xcrZ38E
         YhCIug2/tdJLRWn6LxWZR67+l8UuBGm1oLGj29h0bNxhDAN8IfcxTT80PpGSqmwcwj27
         cdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010494; x=1789615294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0m2EXA4RWU3Xwtz9ppvYXUdEt6FGFiWjjYdvOoJpw/g=;
        b=OAnf7vmE4kVv5gmjA4QX0iS6ZxlUozbqFAKYcvcB1hpHzjcV5EiFJMvO4mccLs+AZz
         qQ2JEoFuCkrDWjiI+OSbgNWXJf1m/HhAJcO3e8jdugdPIx/UJeJTaGRC0Y07UzoyZaR+
         uGkKifOFWzOnFvk0CMZwEnG0NuyrYr96JIxBMB/7JrjoBP7A2FFhnSFyy2gBMy+4CVlx
         cbbGLw6D089WcteaqBrD1mtfHK71IiO2RaS4i0+6FDzUd7M9zsslCBkejRSnTCNoL6HR
         M4f5xZsCFnac6QByhlKzgisu8ESPxi9r8u5zamNywTDCn7RbHUeFfQVNADLwzS4SdWQ/
         YHuw==
X-Gm-Message-State: AFuF++n0uD6qZmfRwDxqDHbYaBERdy8TjXWt0IOENhqK3RFtp6LFjyTk
	qGeZ9qAliUkHT6NF3JbfvbI+GmCVdyJ6AdrFBkxdmHIzLFYyngodO03i
X-Gm-Gg: AYBFou0RHSwL33PkeGGyNG4jF+fK62t+Fs485vT6f2SYLuaThzGfkaIppM4WpTK8SzM
	LKoLZLR0vNJbourciAkIu4PKB91tY42Q/9cpoo+l7qo2pgaS6d3xugKF93B23hyYV5HqJwxlGwO
	TuoyyHM2Aq5qZLgW0204FhlxlP0Hi1EZT01lYezbBlS0zehJZBF4NAlV5EZ91IDsZkG2jq/riQS
	VA4Xuh16GCZNBAZKNc+7ZnhLtOEpeFmwD6a5ggnILv19NZMXqaflUJDqIhG8+O2g8HUol9Hz253
	qx7rBHQdY3d3w+Tq02OIsQZ+CYBpEQy1b2n9ePdOd7DV5G/A0X/FlVIugE0wj1BP+sK5N6eRZKg
	TK+pxUgMEZwYil/EWlM5InDKYgHGGG7YKkrWxIx7/6yEDQEc1y3QZ3Y3GAboOGHM1v47g9+jDIk
	eU8Mh9+o0GG93OGVTUcJIRgl93p+kO8d551mU6cGevzISC25cxzqZFSepTYmht37ZLVJ80Vde8/
	M+8PhEgvYVNMLvBfRNYrVEfXPTVwSX2+XiUwP1N+WHx5yv1RZdh8C8cPwzw3/CcDw==
X-Received: by 2002:a05:6830:67d2:b0:7dc:d6b1:48b7 with SMTP id 46e09a7af769-7fb7aec2172mr16246619a34.1.1789010494421;
        Wed, 09 Sep 2026 20:21:34 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:34 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 07/15] HID: hid-oxp: select brightness policy for the new RGB effect
Date: Wed,  9 Sep 2026 22:21:07 -0500
Message-ID: <20260910032115.28669-8-andrei1998@gmail.com>
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

Set the requested effect before constructing its status command, since
monocolor uses maximum hardware brightness and software intensity scaling.
Previously entering or leaving monocolor used the old effect's brightness
policy. Restore the cached effect if either output command fails.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 8d07816..9c22c8e 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -1240,6 +1240,7 @@ static DEVICE_ATTR_RO(enabled_index);
 static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	u8 old_effect;
 	int ret;
 	u8 val;
 
@@ -1250,15 +1251,21 @@ static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
 	val = ret;
 
 	guard(mutex)(&drvdata.rgb_mutex);
+	old_effect = drvdata.rgb_effect;
+	drvdata.rgb_effect = val;
 
 	ret = oxp_rgb_status_store(drvdata.rgb_en, drvdata.rgb_speed,
 				   drvdata.rgb_brightness);
-	if (ret)
+	if (ret) {
+		drvdata.rgb_effect = old_effect;
 		return ret;
+	}
 
 	ret = oxp_rgb_effect_set(val);
-	if (ret)
+	if (ret) {
+		drvdata.rgb_effect = old_effect;
 		return ret;
+	}
 
 	return count;
 }
