Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B690306B31
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206674; cv=none; b=fg0q3Et+TLg7humuIIREKiHlpS224Czs+BRyqMX7mcHV6zOIXZV0ogaAXNyPjuWOj2LN6th6P4S5cEZj69OvToUo+5la1q028sDo8R2ugC2m/uNZKkhzstPPgghlbw/RuchK+LKUxfb33Ac30rM/8sdszKlbzDWY82z+KJQ8dPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206674; c=relaxed/simple;
	bh=LhbpTciPxj0wP8t7qiwasHS6QvXT2yZAybDYkl8F7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DeTPoW3qQnfHnwEZr3Yqo6frnv3ofnVgxuAn2bFXeOJM8GibxBkO1BPV4sxsfC/UF25wEM2ZW77KgTt49oubLEpXHL2KVNqDSoSus3SNAffPgCvB9xbI4G3VU12GdiFKITcd/ipF3LU28H6PWvwPeA0RQZEKPKR134+b19MF3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VcOLe/Pi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VcOLe/Pi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-448528f4e69so2580046f8f.3
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779206671; x=1779811471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbx0+aqnrkSkqh+rpmBcYUsC9GAmtR5s68W84csX/OU=;
        b=VcOLe/Pib1mE/zWL8bsYfgKM6NST9OeKFjf/hcV1iX8zCmE53lJPYYlSbGgVKtYW0q
         N+YN+fmBxqXgGbfbE6vcu82fPYFO+Ny7OV0H3HM4MPPvcHotAoyU8zuCoIX0AjQ066jk
         iBWAuE9oDGWAeOQU2YTN2PKdSgZdJgLv6Y+6xUfdd31hKgxL2SvkEYD/I1Sw4R/ycqxN
         ZvWSQ65f7sWJTFQ9xpqev3xaoX6aPs+t63XIHratM2oZyojPOtK7DhX1HPAL6llLqVNz
         Q67lru+o1PGOuddV8vd9ElO5nBpQWiEBbbKPUwHtXTiCOBnZ2AwCeTqmTUjJ9dTWaF5O
         ClOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206671; x=1779811471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbx0+aqnrkSkqh+rpmBcYUsC9GAmtR5s68W84csX/OU=;
        b=Two9SogtZoyrlUXMQLyaOkCHMSt4yuYG04wGkAgAByvf8g80DWMEW3dwXoHk60c8KU
         jm30HVmb9hv8KzD8mjvKRmDrD++Qr6Op59KeGrLKINnTv5txWz9SP9xdcjkS0t75cVnM
         isG+MnnYUiqWSPun3ilfO1CQ1GnQ1Gsd0BeymSucAGu2vfOvtVgh0j+AYtp/8Yd0MDAO
         iv/CC2lqVJR4ziHDq6i/yYLOMzQtSXrmVLiplm2ZN3p92yWcOdlH4FNCYFzi8RLfe7FD
         Ni3Qe3y2EM9i6s/cTeVuROivc1HxrM4cTxAsuHb/+QmImm8LnONCe06J5UuUll65GGDC
         kQhA==
X-Gm-Message-State: AOJu0Yzk4oUM9ivp5LC2YKER6Y8DK46gtQivTw25hvvsg5QSI+2GLEnR
	v6WYFuOQTsRXQVQpjXuiNmWGyFE3NyoJoqRDdJVK6c3XtIm3lLULgFS6RtGwpgfjjGg=
X-Gm-Gg: Acq92OF57VH2mv+odjL3dtS2lmGJVSG1iS1PKYzKVeMH+kxZG9DfMLWjnhrMOJNCInV
	7SvL+dT8Irt7xsICVJocZJuB78JwG8qPT0jEFmBsQLOhjOdo2ma3t/NCJNME+/Vdm5laZajDJLz
	tzr4geJ+e9zK4eUxxL6yGdYWUp4+jZPOi47W+oocry6js6ks2SJJIYI8ldev6EXWaH3jZhtE4zd
	lIYOVVDdHVtEGoh7DlUMHqSgX2KsTaVLmfytZ3Duw8SLc7RFju3R9oxBED+Kfr3/h9qZb1k5v3S
	ObU0Th7wHOH4AqoELliN6V5dHjZ2n2G/lqXp6U+thPShrRu4Rp22qicguT4GPaUUmP9iGJBA7ah
	fRDCXBLXqslMJJmy1ei4w6ETYn8h3EJTsRWxuGoMUwngPXKj2lRYCsP4iczSeiKVYkVcOLF7YBG
	pw9V/vVAE5T0mNNclxD4S5Er4zWqTdFprD+a5TXwzjK9XS3cvr7MBYzf91q4A+FHnt3va2i/W3u
	0XQCyvpEPvtWjc=
X-Received: by 2002:a05:6000:178b:b0:451:bee9:17c8 with SMTP id ffacd0b85a97d-45e5c57d3c0mr34106186f8f.6.1779206670852;
        Tue, 19 May 2026 09:04:30 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ec3b18fsm43175492f8f.11.2026.05.19.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:04:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] HID: i2c-hid-of: Use named initializers for struct i2c_device_id
Date: Tue, 19 May 2026 18:04:20 +0200
Message-ID: <20260519160420.1597193-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=LhbpTciPxj0wP8t7qiwasHS6QvXT2yZAybDYkl8F7ZA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDIoEh8IS1HwVcK+Gt3O7WoUMxeohf2NUK5/Bm d51BT5+UqCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagyKBAAKCRCPgPtYfRL+ TpkSB/9Rh5CbpsngE3N1vMNE8wbBycT5z68OQ82K57I/4Z+zLYC+Kt0KQ0uTtJiZY35sn338Tsf RPB8s0kiQJk+CXs3j3UnRFD6Ngt170r+c7EmGD/nTHIuHC4G6zEHO/arkv+JhNuzJm0nMec4rui f7U0xaw9dfNvr+oESToQihFvxL4Ji/5IHuE+t6Aide8xjhAPNzhmlAuMqvc3Q/ip5IKA3RMoOw2 thOfyLDjM/NI/fjrZ/G9297+4PRVkZlVardz9lPyeC5OTK+PJ9YRrg7uwqqfw41xDQFDMMOalkV wnwvV4fybrFih+azx0HcObZFGFoq3/56FJ4/7BKu2tEI8ZhG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as this driver doesn't
make use of .driver_data, so apart from the better readability this is
only about consistency with other subsystems.

This is the only i2c driver under drivers/hid, so this is the only patch
needed to adapt the whole subsystem to the new style for initializing
i2c_device_id arrays.

Best regards
Uwe

 drivers/hid/i2c-hid/i2c-hid-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 57379b77e977..59393d71ddb9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -144,8 +144,8 @@ MODULE_DEVICE_TABLE(of, i2c_hid_of_match);
 #endif
 
 static const struct i2c_device_id i2c_hid_of_id_table[] = {
-	{ "hid" },
-	{ "hid-over-i2c" },
+	{ .name = "hid" },
+	{ .name = "hid-over-i2c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_hid_of_id_table);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

