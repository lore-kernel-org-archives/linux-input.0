Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E346A60A
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893433; cv=none; b=PhzjVzH4RZAJQPMW1+ZVqemrfybOJR+roib+5BcEx20T3vKqEub/cDeTE6JUlmdZpp0zXGVgOw28sKDXbzr0qGO/FpIm0QalfdHHrwAyFLBPod/ETu24popichZg3DJhJ7TeRh0AlZu0mofmuas/GenvxTqw63hZlDwJkRXJ9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893433; c=relaxed/simple;
	bh=ZsSOdw0mvnKnNrqf7YTUmfeQgEjmG9CIuBVp0jUlpmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gODGon4WeQuEFSK2Ah19NFfpEi0hYId55KuLJKx6MUQt9ajcpKU4tWESQUPlceLx7JP2qKSFWeVYHkhMAwXvh1CyR1ax7lyiqOLScSl0Q3vNB0h0uBjnGyBfaZUAFjPAOCnQJDS/Xlr3vGnBFM8OQZTWIKQXI60Su7dlm2UrLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMKidErK; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMKidErK"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so9163734a12.3
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790893430; x=1791498230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTg3MSL1K+Unl/9lI2krjRczONr/gPCmYuq5ydnuWNc=;
        b=fMKidErKlSHl3sVY7tXnSYAc7zG+FTrU7JyUKy7fBh3yS+XgakpSYs+lHU33je8W7N
         ckYg1e9vbHHqtFQMn4QmnqwYTtYx2d0Qh58SUwVnhYLtur3l5Krk6SYngx4qHQMKUHQk
         RrcGeXNOkvV33jLsugFYGk4A+pevUlX1aAo4vRDuxn2L1/UDhnDZjvWHczbJ/emO0It4
         6Y6YACe+VZ7ZHgwJRsYDfdmC3uIBw5CdG3KZUGb4QYUrPftZt9o6k6AhePxrsKlb/Ats
         bur0FNM8kGKdoGmB/8LGa2911sW6VebTCj257JbXRgiHh0iDGT7BWugWwLYSbmyX/pP4
         P+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893430; x=1791498230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTg3MSL1K+Unl/9lI2krjRczONr/gPCmYuq5ydnuWNc=;
        b=j2//tkur0e5DTnFuzXJ4/sXxv65T2iSgnATjk1OpyFf+6h/2e24CBjTEFUImqTXz2c
         F5Ho3itMCAk2VrhJ2gdi3fbSUZ1zp+GLOQORdIo7ThDKnZIjI6udsZIWqFoIpbr3N20n
         YB2vk/FNC6U1tEyLGDoeasEJHiFgWg3VUFhc9sFVJLi3SlTisAiG8p/cTCQrTjnAN5vx
         2isegX1wklMqjaXzbAdH6Bzbya7SZNkHopHreGKU1qPl/9BZr4ZjqCCfAR5zZLe7GQZH
         AkWGkSIEsXTjdrTT1EeVguxvF4I+yZ504LgGQPLe4lN1goJW5FNBF3wP9mo7bsOHSJgH
         F03g==
X-Forwarded-Encrypted: i=1; AKwUvBxOIhVFPTI+K08maIsTjJX78I10Z8/1ne6b+jFx909rVmyvtqrNFWNsGxkRkaIptTWdC9rl2e/UEemLgQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKSna00H56VzOGG2lwQbw7M4Droy4YbbLXcbCUEgkzOu/Vr4jny
	R0J5vt5Yh03NbFr+YiRfc75m3bVEN2BmC18I0Y3IfAkshKtatSVyCsm5
X-Gm-Gg: AYBFou1U1c/KbeugSO4T2PwJ5q7gPC+l91eFY3AooQZZxuAj+P5sNrqlx+u80u4VCMD
	ELHJgTMVfip4xWK/Nw7x1LODtlbGgi7zfKjqd5+yolGx9VoY9fGRPQDawDUy1mWNUpSYP76WBqg
	YdN9sD1xh6JKjfpcXKJT8aCiLA9YJtpE9X9Qq1Ux1Cb0Jud5fKEsPw0uE+Kwo+9cCZpdOLw4v8V
	JMPqTgB8weBYXLG5eEjPWEj+BpU063FIOqx0yGqCKEuKiwEqbUzUdOwG7m2OQeLVZn7FmDDtF0j
	VRB5rpgyc/lO5Bb93rnCnAgPlXjbq4K5yyjX4+PWsibIRRLE1vINWvOlWXJuEXu4aa+81e+XuxV
	yDHpBgJfNHjfAEybtyAeUYvfE/sVs3l6Ejysf2tu6jNhfFDW77JaOOj25GotXQlmfeKVvdA/z5/
	xEwNqSgjbZRVZLaah97aFJYjBWWvn2BxEiVM+r3o9hegUZW9jEThhIifxElW6/exfDBSRCLotHO
	UD1HMpBdtfZKHDjufuW50472l/HdTRn7XG94gQfTz0=
X-Received: by 2002:a05:6402:1ed0:b0:6ac:b0fb:57b5 with SMTP id 4fb4d7f45d1cf-6af9e2de21fmr435519a12.26.1790893430423;
        Thu, 01 Oct 2026 15:23:50 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d87399esm238935a12.9.2026.10.01.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:23:50 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Fri, 02 Oct 2026 00:23:37 +0200
Subject: [PATCH RFC 3/4] HID: logitech: divert M650 side buttons over Bolt
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-bolt-input-rfc-v1-3-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
In-Reply-To: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bastien Nocera <hadess@hadess.net>
Cc: Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790893419; l=952;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=ZsSOdw0mvnKnNrqf7YTUmfeQgEjmG9CIuBVp0jUlpmA=;
 b=Q2UyUZAba41E/J9wgKKqQYHl2yRpR80S65HkVUYnvCh/Ak3vrIaURf9+ZbpNKTs+taSqoA00z
 UvZuT6ESMbgB24UnBLVMyrZfY+EshMTvibr50BabCnOsnjIwm2D1yy/
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

The M650 uses the 0x1B04 reprogrammable-controls handler for Back and
Forward over Bluetooth by assigning a quirk. Make sure M650 gets the same
quirk when connected through a Bolt receiver too.

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 464685ad21bb..9217ad4a97f4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -5150,6 +5150,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse */
 	  LDJ_DEVICE(0x407f),
 	  .driver_data = HIDPP_QUIRK_RESET_HI_RES_SCROLL },
+	{ /* Signature M650 over Bolt */
+	  LDJ_DEVICE(HIDPP_PRODUCT_SIGNATURE_M650),
+	  .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 

-- 
2.55.0

