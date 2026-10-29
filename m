Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292308;
	b=CFC6btQu9q6bQhH5OlvWnP1uC745FwQV8x0a5RPDEFlusT1AS640J7wOJ7ONDlmvy5od
	 ICJIs0wV+avm0n03TqiBLmdVFdU6JbGLFSpNPrrZEHby6mpCI0+tZNof7k3MaxDO9MVEk
	 Si8KYtsVlfzugXLnBwp2krmsc5ceXN0sjW2W7Fkhqr/4cs7tDglgcM+fJQNZSHanZwHTJ
	 CLGJESQtc6JQG4UV42chuh+FK5x3X04intXK0ZXUOIWOJVrxgVf6vcw9d/ROBCaU9DSsi
	 57k4B/ZlUPP3hjWFdwwLM9p3JyL3kvpmi7r7P7oHHx0dSBhPoTQM5pbeaqCsH7eSZNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rlC3PRcSmwaxdGJVTnjCi+zX4baye9cdvwj9NNfIp1o=;
	b=ohpQIW5bNxXI7Br8/9IkQQSaLBvoY/zNxGMPGtrxOAE2ZgJ8ln8bNrkOn7vAmp6ztYLp
	 5NvJD4inCEitasWYzYATFXITs2tl9BXCPij+dhwCIVsu35g0JRYQgE7wmGPEcAH6nJthp
	 Ee3Re22GOXEthrTsFAOyrX3sRpxSjRhiTnu0fwMaT9uFzjUDlvF0DuY7C1HSCyqP8gBaU
	 dmYU0vxM+M2Kh9R7l1UjHOqE1VHbqO5UXt5pfpt4M2vjc9xk8/+0WBLuFz5dY4F83hFkW
	 TOqs46sFT/ilmOItlify+sBXRfi1jq2XIjUyIp7pBXT/VSLRQpxvYz4/6TmoxEDSQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wj0jQ/4V";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23017606A31E
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 16:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23017606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wj0jQ/4V
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1823662f8f.3
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292306; x=1793897106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlC3PRcSmwaxdGJVTnjCi+zX4baye9cdvwj9NNfIp1o=;
        b=wj0jQ/4VuUyLTdFP1BSxiVCEs/U6nygJhmcIxYFtnVKAYmFHv6thJehw26ay7S1LzT
         JucleO1u2QvRvBS23NYL7YdFYx2vQGzTvgFlDrmfHjrkLETfOeF2YaBC5xewqjPMNleS
         /C7PuxaklKOerkzxfo0ES7eMf8WL1FiEjPtpZEkQ1UTr3Gosvk59gNUfTiMkL0Xw3/G0
         d+gR3uqCvhSRxH7OiQ8XaxZApbvdTV3+v5If3npRXg6BNJY3oXypv2Tqs5bKHCfO9bvU
         FtTQE+UzXc2uEe5D0HpIuPXkKP9PzNxTMJYSfr9bW+CnTe2PeQ5LHAV0LZ8GvbUEKf3A
         XTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292306; x=1793897106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlC3PRcSmwaxdGJVTnjCi+zX4baye9cdvwj9NNfIp1o=;
        b=BGLLYk+D+Nd3+BDmCLrQOOSUiyfmvyzaGBgE2NMnU8vE+nfXfqP3WwVm5emscQ+X4T
         r/Qwa/PY/tG1alHaF06t3Rr3cNtWbTMl3nQl0d4qlRwNYP9vThxgzKKTasnTBJziRm2T
         KhyboEqwdWijaLYgLMd7BLWUllvr5bowJWhAjzPXCQP7b+jnSJCACrFypohqaNGUDl4j
         6TUkaZ8iXCiAudw0MjVujBJkL0bTZz18gUfvU1ndijM2o/PIgQzQyLIsUSZHLbJXjeHr
         oL1IMpO7ZwcffgNc1/30jWHzPNO3lT0IP7GY34FHnctbsGYL54a/76kZfO9D5LTOxrLD
         NqEQ==
X-Gm-Message-State: AFq9FYLK14U9FoeOdb/cANyDHWcgD4pYeE7oMUv4dFdeOHdOemt4ayu+
	F7uK7XB8qsUBXxS1W+c2tpEYICtbuUtdqv+5FGQhKDs6VQFZp8GzZW+/
X-Gm-Gg: AYBFou0oiWxMcEhj0tgsq0NDUi5nYRXRe9TzYHljWZHEI1rY5kevds/htdTxjw+f0d9
	fa8UskgxqfwMsg4LytMYPgJSHU2QPkGnGlQd40oOmbY82tnVli7J1FPoZ1iwGm8GendphUvWIq4
	ALiTUJehzdcTR+BGB1Mz2CAEDA6/Xys5CpEPPnv0VWPuVd9fZYGVewC0msiWgxcQ8NxnlZXMEdS
	KY8X9LzhhYu8QTA+D58fD75fQQR5UFOdK8xWHZgI/qSGKDoe+Hwbve22EHuEjwwzbCgcMEfYtNY
	ATMnAa3V5YVeQaMBT2hMaSIbrQD2myFyOCaKN89DS0IYeyMB/nPZgoRXd4eiwFBjCyO09nt4mbc
	gXTLj5Sece9e/KeOBAUOr87lv372Z+isj1sGQMaDVAli5WM8l/EjHmDH5M9j30dYSUBvWxw19xg
	1a9z/DT+HoA312H0hlkxmKcS4Hh2IYekiBMlG8qTRjXf30CqHPYOUASae6hUnqpQ+PZDGB0wP5l
	X5phg6uN9hlhfErHMG0DSxfKo4GPPmWR+2ap2Nwhgd5IUIjJ7Jg/Y9OEO/vTOQf6Y0+edwyCG++
	kDw/6eYmC/HTPTMNUcfx1DudhGNGF7flq1a301GK1Obp/jXqT/RelYFEG8B1ev5HBdfR9G6O6N4
	Rlg==
X-Received: by 2002:a05:6000:4281:b0:48d:bae6:d7ba with SMTP id ffacd0b85a97d-48e5d5c7104mr12457549f8f.26.1793292305830;
        Thu, 29 Oct 2026 09:45:05 -0700 (PDT)
Received: from Nebula.taila1e315.ts.net ([83.104.75.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6dfb26f3sm224238f8f.46.2026.10.29.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:45:05 -0700 (PDT)
From: Chris Sutherland <csutherland.random@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Sutherland <csutherland.random@gmail.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 17IWC11
Date: Thu, 29 Oct 2026 16:44:44 +0000
Message-ID: <20261029164444.400649-1-csutherland.random@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The IdeaPad Slim 3 17IWC11 (83VS) creates an AT keyboard device but
produces no events after atkbd init. The 15IWC11 (83RR) already skips
deactivate for this EC failure. Add 83VS to that quirk.

Tested on a 7.3.0+ build. Without the quirk the device is silent.
With it, /dev/input/event3 produces events from the internal keyboard.

Signed-off-by: Chris Sutherland <csutherland.random@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 019cfa855..506323002 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1943,6 +1943,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 17IWC11 (83VS) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83VS"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.53.0

