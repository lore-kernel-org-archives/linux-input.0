Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754852;
	b=z/XEp2qgNVGwq7flAAhhlR/JCiHTVh83y+f06tE4OeTKqZI48ubXgcfkUqQy/6qtXPV+
	 hnM8aKEWi29jT42WW+RU/e1Zf5DcVvpBfx7alUx5QebZ/uUNwsQz8p+YoN1WlCT/S0DQp
	 kZEnr22uPevq4kcu0WCope+Xiu7vW05Kf9o/jBdJM4IvOfNujydqK9IiUaKojtFaACFTE
	 qMEkckCWsYZMR02NqXbxEqyv0AYdrZ8PiFIp+dQKVHbWHkxOl40Jp1fagld6JhAIYj9ZD
	 yxYBtKzMaSfmffKGz757msVKTSP7aVl3Fgcu6kuD00Ww4pNoDyPLf7oVtEPeQ1Bt91w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
	b=af34s1FW0BkhN7IgPQHOH2cUmzoHuBCyybkrwtBgwYldq3D0Yg3F3dV1CqmI9cMkAKHj
	 7WloMcg0gz78Z6qIXj1ASHxPhC0/TFSS0r6SwoxktAQ225xcPoJa//RVigyz9Ew8Cb2Wm
	 wAcV0Wf9lmep7+M3QdV57aCyqhca/ThFzthob0nBwlqVtfgafH6e16JKqkc2KDlIQGUct
	 14FvtARRJEQTytFhKPKuZQHq4SY7sjB3V+byRtg2YGnC3JdSosKpmdDYki1DKVf639blk
	 /Tg1rSmQdy66vnMnkDNw9TVgZbL3kZ3szeT5FoRfOuehMofC+7+vvJwz4Ok9HQepUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ol94ZQlx;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888F606A33B
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 04:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0888F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ol94ZQlx
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-386d1859e1cso2032533eec.0
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795754851; x=1796359651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
        b=Ol94ZQlxOoTaBFfHL0ERXTVVQTimop0+0lnXX1HmTO0ROCsV69CcS/y2RK4v9juJ0r
         d+y3QpFVJ4IHlP11MNIXe2MhH0HJuWzO8X/JcMjXF7AB7Kxfs9Q3+NvuToBHmPCtWzE+
         /ypA1pzmTot/+RNUhaGiO5aPhQ3Zf3TWhaFi5AWJVdvQGGyo48HiAybttIZFQFWwuiij
         TxIw8pcxRtxo/JRnHR3GtYYedeZ6XD8EPvDESt/+OpT6p4tjhLwAXBY/xY4qKuIc9+9m
         9X3Kdr7cBG0YWpoDfJ01tzg2MvJAFhW5iNOFN0bE5Jr30cr3/ilPCNdwroK8n8PT0N+i
         77lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754851; x=1796359651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
        b=wza9A6QAZFXX7I8ztFoR/Q7KucGX0pR6r+E5l82dMMQggDR55VEoXWtDyV+hcOye1L
         NZG/tlGZWF5jQlc4ycadonCZPLF/6Ak327/j0PP85KJDdVadTdi+WRGSyCxJqhXwgYeG
         7okkzBRXS5Sj+AD0H1ayiDuZ+vsP+Zp+gpfEpmN4ybebHHdSGZsPfp96c7JOgafOZcMT
         ej7lWm4IUlHJD+HBGC0ayL76xr816AIaFUlVownmEfC/qZrtHHHBif91zv2FC4sC8L3T
         AA6Ug3VC/UeVOWV0S+1Gel2IgUC+ugdTMXh7+rqUWG08vrAWxDPYF2Zq7lCb703bCBGH
         E+iw==
X-Gm-Message-State: APuU4Z8U0ywsrwgEeCbBJynn7+zSVz+FywXVR7VQuS0gEKYIOZEF8NQ4
	KI/t9q/rsNqAl0td6sNxXjgMdhJTdEyAXdOY95PKYuVYnS6qTC/oLMTm
X-Gm-Gg: AZFdTZcfiyLXXbZNS9hBD293CApViN/TaNQ9CzSzj/bJM4rJIKCZgW8wZJj9fIixWTi
	h6Qh4rOzpHBYv6zJMFBAxZbpgUH9T/MDy1BqCWDulVK/8huG7sSirapRWZdUvQ7dOIGHXUXDZi5
	cCJ/iOtNSGJTBW4MrhQz5zGE/SMF5BqMP/mQJApUmWvmB1PwAMoRs99qvOIaIBsDJoOfUGO61t5
	LmXWOzDdYTkpmzSTuMpqE5BhenOtHR3k9IuwMZPT9cCWIt3hS0bVqGhqx/T0E6rT2ICOAfY2tuY
	2n/DahDLZlcHnyy1MpOnV1ZitGrx2dl+Ny+fFY+obTKOYM7lPTyAC9NhugXoJiNK3aFs6iO9L3L
	Kt9SIbmjvY2sUx646nGf9gJP77kfCEq8E5LdSXDXO3GnOjOOa4quNAM2NNrYdFR2KcpVfpKv0ML
	geDhqR3nlZeNmuSXtAtQAJAAujLY605eKf2D7raJTlh716cioLmtQ6BcvRbnbCpD9dOwxGYpuSq
	/U7SM1km1e74h5S44euOVpPyPxb9Y06vcp5efACMC97alCFZmiFY1NReLMjcEpcGAmvZd9uglHN
	sSgXN08mdnlqJ3gRAIHCXm+Wlgya1iJ+
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id 5a478bee46e88-386ab85a718mr15451088eec.27.1795754851116;
        Thu, 26 Nov 2026 20:47:31 -0800 (PST)
Received: from archlinux ([114.79.176.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm77084648eec.26.2026.11.26.20.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:47:30 -0800 (PST)
From: Gururaj Naik <gururajnaik166@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] HID: amd_sfh: Add DMI quirk for Dell Inspiron 7405 2-in-1
Date: Fri, 27 Nov 2026 10:17:17 +0530
Message-ID: <20261127044717.129941-3-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127044717.129941-1-gururajnaik166@gmail.com>
References: <20261127044717.129941-1-gururajnaik166@gmail.com>
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

On the Dell Inspiron 7405 2-in-1 (Ryzen 7 4700U, BIOS 1.20.0), the MP2
firmware does not respond to sensor enable commands when intr_disable
is true, causing sensor discovery to fail with:

  pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0

This matches the behavior seen on the HP ProBook x360 435 G7 and ASUS
VivoBook Flip 14 models in dmi_sfh_table[]. Add a DMI entry for the Dell
Inspiron 7405 2n1 calling mp2_disable_intr so interrupts remain enabled
for MP2 commands, enabling the accelerometer, gyroscope, magnetometer,
and operating-mode sensors.

Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Cc: stable@vger.kernel.org
Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index fafba3ec9ced..aeeabc3be2b6 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -335,6 +335,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420IA"),
 		},
 	},
+	{
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7405 2n1"),
+		},
+	},
 	{}
 };
 
-- 
2.56.0

