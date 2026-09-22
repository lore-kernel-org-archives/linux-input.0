Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A451C07E
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111114; cv=none; b=a/l7fGK3LN9ZjsZnjPZPmm/68yT1yTZb1zjOpW3LZfSTKQB4UoP2YGIQFcmAR9s/ePH22Zp/a/1W1UvlLgbZZ608h5qksh9wy34QSH4QwGIsN0pgwiWctXmaY0IZ25r+kg/byvGaO8j9fNCaz9A/LU+dvIbERbsBn/6/erJyH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111114; c=relaxed/simple;
	bh=QNlUH25C7E50LHY3oqo2JuAw8PHVhDd0DcED9togR4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0zJtV3E/VbxvxwM2Axe1j1TghsKzOqSRyk/faaq+ftBXhche0y4urz61T+NXp3sDCbb1Kcu6KUMGVSdMcBMsMwYTSkI3ktE9W3CQuyghO77t3f7Bw3/0JX44B9pHlznNIrzKFMpcfuhuMJAEBynlppIahvbZPVzMqzLlWQnNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlqkrbNA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlqkrbNA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so239256a91.2
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111099; x=1790715899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7rwFgan0mLtbX8Widb//2oeduLN/KJSajKrQlLNQLw=;
        b=YlqkrbNAuI5BbFcK3fBA2tbN+oYIQVaC26uMzgfwQ3N4fkP5ym5hqvAczntU9w70iV
         7ppLJFLz77Ofl5MNwPBM34zhhppzm0r8UzlPaUGD+BOouYXuQXLAA4EHisVYQoXCMUNc
         j4Qtppvn2oKZmcriqvpsH4EUZOXvnowr2lX7dMKU8iTOgGZmuJJok49EO8EKuaNWZi6F
         Vi50EN+kR5RRMoUi6bOeytufKwx6q2N/qDX+IjSNkkq96ua56RxDEido5rstAj4B0Tbz
         1NEjwcRIJfw9ZyOMKOGLYHVVCiJi5P4SjKnWVJpiWohFEeBlTzDtjxF+Mp8XT3kzm9sW
         xWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111099; x=1790715899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7rwFgan0mLtbX8Widb//2oeduLN/KJSajKrQlLNQLw=;
        b=uObFI5ufhy0Q6cJPH6GU/AL7b6PAukJpoBq8b5yMmrKcqh7T66e+qT3pb613aBIWlp
         tHGycT03jLhqMXjlYH5A5v3Ac2eEJYIo7qmb0nELkDs2y5BWayMDYU+a44LCZkUU86Z6
         dAFA+ouSTWMQarC0X9PxV6ofqSC7WMlPc4sjAqlxYaPDo09Gp6RCb/kpL/b28d07NIz3
         VOV3FnpVM5pDmwbTg6pbWJH3CKHW7viIpD5taFY6Dbo+QUXNtSvmsC+dJgyP45kFu2AV
         xFoiqZOM0483e/G0R3hdVZmjuSkkKXBJ52VQvzeXD6IcmYFR0U9+K1JB6Kp4rXBe4uaA
         C7ig==
X-Forwarded-Encrypted: i=1; AKwUvBwmAKTnixm9XJ6uYWOJBuvWajwNTwy9VifZ2XMOAcPeHq+KRZS4U3IGeGIQggc5z65CrCVb3AvDZv7BMA==@vger.kernel.org
X-Gm-Message-State: AFuF++k1ZSFbuwEnGOuw3X3FWsM0LlDRH6AVcjb2n40J6yyZ3B6pez1d
	+spJeDf/SSp/dXzTwjY6dJNqjn1nxBprIJ8jb6E5ZoguGw0aNNXM/VRK
X-Gm-Gg: AYBFou37pLluXLZedXDc+kSuisZh/zYJjagW1Gk915rFzlcVHAzQfScMb5fUEhQxkHl
	bePdToZDRkD1N4UIplg12j2FNtB4hnvni+Y4D6YI2TyvQsj8qPP2UGlkQnq0KLUkLYCQHxnLW3v
	pH436X3KxL/A9i8FPlK6nk6HiI9ukIFvfnQOXYEWOR1dscjW2wM5UwoKIpiW/E/RN5iCvGccwXS
	okgEcSceCYv28YtnaWOjZpvs7an3kXRq9S5Rvh3bD6jTRtBonsAJU7+5I2GwbedWSH4iEwCZUqt
	6TB66pb/mbg48pCmdW6ljFkd7rh6SJJCF47CJICuTLdaLWS72Y9G/5G7qz+uoaDkNf1OYd+lCH8
	eSvcjHSnx7DkE/0lSlTBhP26IzIlIV7Wedvz/yV+zXoPcjjWrR6RlrX4KZ2j77gkyC3OF26ZTIY
	8hRqWw50Btc1MMmh4U1kjHgJwl7snnvVU3MHlwUaqZU/X+QihpvhsyGKVPjhzNCiU6cvx0
X-Received: by 2002:a17:90b:164c:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-3a07e4f35d7mr581261a91.7.1790111099229;
        Tue, 22 Sep 2026 14:04:59 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081324d24sm38262a91.3.2026.09.22.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:04:58 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2] HID: wacom: Write shared touch initial status only once
Date: Tue, 22 Sep 2026 14:04:54 -0700
Message-ID: <20260922210454.22351-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

For consistency with how the shared has_mute_touch_switch is handled during
registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.55.0

