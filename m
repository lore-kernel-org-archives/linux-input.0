Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDB3563F6
	for <linux-input@vger.kernel.org>; Wed,  7 Oct 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410434; cv=none; b=aRzvEnJhs2qHAdbZwP0/mCqJS3Q3B/OrNAYa5f0Em8YyeofaKySouxgxF7mNxSB5oQjD1B87t3ppKduvZmeOoWAvGQw/rZjFD8oePphLhxzyeZVAYm/wt6d0Qo9RJ4/4CySysLJ50Wokoe7i4FmEp8x5Bl0+6EXg9ipGgX76J8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410434; c=relaxed/simple;
	bh=Ct68b+rCLNKPhle3WjAX2nOyAsy3vaqQllFLahN6aWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTXVZNbW3S/ou3wa7fHJwA9MJMyQHDV4QedJeD1vTHc52oWAmgZMjL6QtfEhEMPhSa5TOlRX7fcy9AbNh1PxhE9pG95iqJMz/K9A3sC3TydRzywesviYWU4wKicoROgK2VBcuOgwr0xxGkmte0YFALu/tKsIHHv4gQMR6ywpABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgKbGZHP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgKbGZHP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc758830601so3018843a12.2
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410433; x=1792015233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9w+vTKEC67XaJ90lkJm0RhINu8lEfisoCkmy2OaUF0=;
        b=LgKbGZHP3N3kBb0Vry8HCwWJLCaPf5cKMlCsqXEBBLulGdDEMlNh06+YWFle9EgKNL
         JZzMOC8pxjhfwuQPmRhiS9XO83jgp/fVXCfSpjswnRoJ1k7fkWhw8cLv8yRSTemuBLUE
         15bCnrmRpfANjwoezUK58NqYuG+mExxYuF/bMf9tFZEJ0dIv0pjkcsEoQlLBl2TQdLwc
         pl5N1SFBMEq67X/xc92De8i8bAfH9gI8l3jvjRHVqMEW7TWzDN5Y9oFunqKZhU/6mwVy
         nLH01Y3BB9y3ruaMoVrPRe4D+hWQ5h08SwzrPVFJXCZIlFJrZfyWHUA5b1seiKQTE7OE
         z0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410433; x=1792015233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9w+vTKEC67XaJ90lkJm0RhINu8lEfisoCkmy2OaUF0=;
        b=Mya9esWeMNDHgFt16PtN9pTrt6Si1B15SjNNBshAJW4lpItk1BLA1OmdwWjeqkoI8S
         HOs2SzLgYH6QiyYqn+Aove3Y6oTNtbLQTzsL/NhE4NDVApxZkwdcBFOcrOQy/9fH37fM
         O95n4jFpuNlO5GVp4J9kg8lPI1NwR9SdJqje8utQ8rheO5FqqEpj8pPn4b9ZR4Fafhp1
         8cAaIb4GmjHIaltwbTjlKQUosjHSXTDutJS3D++n7qfzFxMsEskfpIq0M8JzKfwXXeGA
         Fq/U3geiNPD04Vh5YIUbcaiNzzEJGjmX6TLv2VhSS48rvj6Zk/FKPy86io7x7eILMqqb
         1FCw==
X-Forwarded-Encrypted: i=1; AKwUvBz1MkhiIIYk7rFgZjarFRDlKBragl9HNENwmJP7QBvBdVOP8VtevrZPHn0I0Okgr4rmZGc/K/80BACN/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzNLJbCmmfwooqh1naR5cxM88KsNkPMpBqHXdJguOUqUy6KRXn
	8kAyB7qbJcxkazhWI6i5sO76+AndRewRoRi9qSH/9GrRoqmg+2pkJO87
X-Gm-Gg: AYBFou0TfK9RTOFVB1bHnKdNP15O2yneRKEXsOBHGhRewkM6b/TlHqXzJvAAuAKflDc
	jxd163bPad5S0K1kAi7PFMP35Mcck6/0iAtIy5aPjWE0I7bZW1whAgUaWP4dOWbsXQ4JkPEwYiy
	PEXx5zdoorYbdnwUbbYpz9R98DJSuh1FQhLxxfKHUu5dbro2A+LAerZ9+zLrcwbc0E8zwwmLOyF
	dNbdG7GGfWlMfQz3xSQZxxm2KI2vAq9VWDVnqS3IJc/KUdNYfo5xuGZW0oNcNk4fKxPWK2z+rla
	g6s8dPQd2WUjdS1q3eFDIQzd+dSqV2zYPZUglKsH0QVYsyiWe0hDEFuSh8Da7voCDh4y83spJTS
	/PwZP/rBF7AdHY7Xtvj4Ric3d0PeFPthyJtiOGVkM4zPaTVM/h47ObwT0Nz0mbB7RE1fLMhGwEk
	vjehpUimuEUqJzJxk+pEKdwRZqtpry7z9aqhayNIXt50fK8fLJnGqj8zfopqYK+riLuid7
X-Received: by 2002:a17:90b:1c0a:b0:3a8:7fa3:fd6e with SMTP id 98e67ed59e1d1-3a8a1b40063mr3443846a91.47.1791410432505;
        Wed, 07 Oct 2026 15:00:32 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cc1fbb2sm1151256a91.17.2026.10.07.15.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:00:31 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2 RESEND] HID: wacom: Write shared touch initial status only once
Date: Wed,  7 Oct 2026 15:00:27 -0700
Message-ID: <20261007220027.6449-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

For consistency with how the shared has_mute_touch_switch is handled
during registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
Note: no code change. Just commit comments and code comments change to the existing patchset

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

