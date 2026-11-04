Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754080;
	b=QksVVwxVoiqZIWllRIzbeqa17giUArPrpazKqn6P29uGQe87vlZo2GO2oskikPet80S0
	 O7cOGiM/ojMi2Ir3/7VGJPVEWG/CmJ/xbBqBYrdJ8hi+F5OxQxPVnIWmyMDqB9SgyeROa
	 jkVia1UUhMUzoBni/VZLo3+i3wivpplOAtuPD64X2odjCv9MmUHc4TCtLeG9/rZ8ceDOG
	 QgKMcxMjMUxhcykGG7k2TLcjE1Ww1DFUKcd6RNXgFEfEZWmMqfyOngC0KKiI5hfS6NEfG
	 4oQ3cn2bsxZnmRXrAAMVn+BcCs23ypSkKjCf61aV1aRFYCPjUya4T4L5LHZcKE4YF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
	b=dPlm5QqqiGELfyQHlUSjOkjYG4R5NKYp1fxoaMIBHMWG9v3NxJvkg+SjjU861CkXwudU
	 oa+OHOltLd0irQSgSbypQvHNQVLiqLLbBJw3zbwQkc6B2oGY6PCG8H/vx27bBCRcCB4sy
	 Sb2/SRGMUR4NH2v+K7Lf7vC7ffjqUCLB5AMMcok0qfciP5tIY5YJjlRlOgUsi6X0Aer7Y
	 ch64ix9yGDTxYbB6QM9/8lbQvjBDbrD4ZK/kk/6HdEpAFTEsD5E1lI78r5t+MkN799XyX
	 ztbsG6ZdN0fHm75Fl5gAFCsSYswC7vdl3wcJOKT+qD4mNuya85ZVV58LNx2ub7rQWBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fxtGkGQ/";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64247606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64247606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxtGkGQ/
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a594d313a3so136982b3a.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754080; x=1794358880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
        b=fxtGkGQ/e3SEPh5a8AjEoYn26wg1dJ34Ppl3KR1DHLV0CawI/lmAmOqUJAMJOXbeCE
         iCh3OZR1LaoTZ558K+0cxmHH1JHE30gfIoPzUbm8GfRffrICBlNalS7/fAcahhSI83iy
         ubBfE6m8PWU/r+oJ70dp35XIYWx8Vr7yal69hm2X+Z8jeuLQHsfzKXfek+DsNBaBD3D4
         RMHmgrdLgpke4ZWXm50a7XdxsSa0c3XM7P06rMlz6p7izYoOEPhfEL4xIBOq7ln8XTdJ
         eBSG31SVJaGWetGrlgYKk2zzvuU5d1qOAMnf4Sk3Mk2dF+Yyhcgg77kT5c9pn4T6MN0i
         SVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754080; x=1794358880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
        b=MzxnbWbvSDAEHbH8zRwcQ0Tj2z1OX5yzULHzy+eSJm5N3Sra736JwPnItnHJLfLs/j
         //EpGmhXW24U0ls0On6O0pdqQiFU4Fn1OJqshrAfeKmXdcGsjOixa09lHfB/bDNXWv3Y
         JTh1lJles6K5lEkfhEpGymCOOLklPgCI6CRgJb3unMNN5a4Hxar9JV64pBmhye28FKHu
         DhLQ1Djlm6y9TB8wEC+TAaC+ApBlMu2ME2WQeXRIcdwqvDnvAqm6LJcuJrlc+oVsbyJ9
         SMKt2JJOBVTsGKSaUTHVvtw2HihLSkltQccE9je3zvqAV+/nJPjBoGhNIbCi59mZOfdd
         LRFw==
X-Forwarded-Encrypted: i=1; AKwUvBwDMuPeBe4UtzGshZMcp1RFtoOiPHGDp0buz094mAoC2MV3czP7WemIzK50BYAGnG7lLicatoQLscPCPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+auuhKIEA7mWSwsOkEUOtLlPedu2Z3MKVaybqauPW4NrmY9QMe
	stmLgdnXXLcIPJnTzRGDqDcoZttO8A8zO2GRFt4RoeXqoNvOBMi4ogSJ
X-Gm-Gg: AYBFou0te3y1b4yPl9LL3UoYYsVSYWofqJ+ptyo2+3RLSgU2BkqFyFh5MkpvGr/qOJ2
	szCj7NrPCPswP7oomXNri9Q0luJmrLg5wk9R8JwVfWF7GPoVo6BMpEh7CgzfOhfDQxe36ad1srJ
	5AyNvFEFNF5P0cSWZkN8xSMkqy/4v/8hP+GES811YbZJRo3BkqPdmLOFq0VeTD9lZy8uBKAzCRW
	PBSImTnNRQaClFtpeRFMjBTWjZWUIqoVTs/Z/98aDttFui/5fA/HKwyDYRzWw7IEM8Y0C1OeRdn
	ueyTrsi6O+erUOoVFMiq/IMiJiLW8EwkgtyjdhnlPV03T0wWlz332ZLUDRZ7UmbVfjh2PLdtqnA
	ZcgRBubhT/vL5OFigFbA4BOU5RZFluZFo6jy51eO6NKYggQIZb5q8A4AFiNjfv3lLlMzJYwEJ2Y
	SGOERj9VwF9TBtFtCWf3nATxlwAn3y3hShuTdAOLMpdVOJEkdoZ6YICUlPo3v65OvnWe8Oi71YB
	Z1XCmkH5QmIokhEVTSDdg9Z1z2fBKu5lqmoz11/5pLXKM9keD5RKmKGEth2WV/OuWgVpVyuNAW4
	h5M3qE8Ctbkaaoc9p5ygSjlkFis=
X-Received: by 2002:a05:6a00:1826:b0:887:1bcc:3c25 with SMTP id d2e1a72fcca58-8a9bfafa034mr11795129b3a.51.1793754079609;
        Tue, 03 Nov 2026 17:01:19 -0800 (PST)
Received: from fedora ([2607:fb92:3002:e79f:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09c028df7sm174967b3a.57.2026.11.03.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:01:17 -0800 (PST)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] HID: wacom: Access shared touch input by rcu_dereference()
Date: Tue,  3 Nov 2026 18:01:08 -0700
Message-ID: <20261104010108.21895-1-ping.cheng@wacom.com>
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

Allow the __rcu-annotated wacom_wac->shared->touch_input to be accessed
inside an RCU read-side critical section by using rcu_dereference().

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/
Fixes: 9183319a5ba4 ("Input: wacom - Setup SW_MUTE_DEVICE according to the order of input registration")
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
The patch is based on for-7.4/wacom branch
---
 drivers/hid/wacom_wac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cf459c16b39a..ef6480338b2c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4414,7 +4414,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case HID_GENERIC:
-		if (wacom_wac->shared) {
+		if (wacom_wac->shared && wacom_wac->has_mute_touch_switch) {
 			/*
 			 * The setup of touch switch capability can only be done
 			 * here for those devices, such as Cintiq Pro 13 and 16,
@@ -4425,11 +4425,12 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 			 * stylus first or touch first. This path covers the touch
 			 * input first case.
 			 */
-			if (wacom_wac->has_mute_touch_switch &&
-			    wacom_wac->shared->touch_input) {
-				input_set_capability(wacom_wac->shared->touch_input,
-				    EV_SW, SW_MUTE_DEVICE);
-			}
+                        struct input_dev *touch_input;
+
+                        guard(rcu)();
+                        touch_input = rcu_dereference(wacom_wac->shared->touch_input);
+			if (touch_input)
+				input_set_capability(touch_input, EV_SW, SW_MUTE_DEVICE);
 		}
 		break;
 
-- 
2.56.0

