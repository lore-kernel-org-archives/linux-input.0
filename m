Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450C2D7398
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389270; cv=none; b=Tpp2I5nUri15JSFShZJpAKh8Dp8d+rhbTCtuV04RfiCHjJF92qP3ASiRF6h0lgePm+dxiin1xCUyvDs86XRYTINseEO3OChW7wC/7OcwQnagf7dS8TSJ9fJV5zVzUN0p9U5XccyRSBBAiJKEH39BOeRPPytnh3MJOsUfJEoocK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389270; c=relaxed/simple;
	bh=sRBa9s/DMoZneZ+Z7d7oF8DMN+Hfr4zCrmcFWb1anfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j4pFS5OVFUcCD/3jnL3Y4/mpwRjVUMnRZGblaIp4owvlFEcuhV+W5v1pJFeIzKo1Q1gchFSxHD1mjddnhkl4WUcPg14PEXoXXnsJNCCGA5I5b9B6BoimUXvwDDqROmOs3ZeT9smo2+X5xkRKZPwTMNrbBw6+b0MT+a7B5xQLrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bldsGytl; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bldsGytl"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1370417c01cso2705079c88.1
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781389268; x=1781994068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=swtkzWRFeUwnFileCnelscOmM5RaJwc75aJZMlmtirE=;
        b=bldsGytl7uevuFpnDz3cyCffFvlxZMP9tLbHQbGO2pcECRmaOxuwswG5WHFXw2o2/B
         36PVciQvZbYWPL4X7rW9L7avwBG0FmL0Vty/AJC/CdMmymah6JOpdSFZcDsfvpcEmODZ
         ESIcAp2NAnO52SVvhGQpPajbZv7DcSET6izRXnXzPzAMowPlUezim9fQWCnTtBmmRjRR
         jcj/c1Tjiw+eF6mos9CEZMBhsNyQDj6uOHymafStzvxDpznRGWWJcLy1hBl3QhZyQ+1f
         mPxsQTTnkTfQFhCAVdmMeL0aANVBuGDeyzYAuNBXqM+QXISzMxg87k6PDn8xn2BFNnZo
         hH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389268; x=1781994068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swtkzWRFeUwnFileCnelscOmM5RaJwc75aJZMlmtirE=;
        b=UqZjbAD6a//p1b56ecMaBM7Ygqf4hK3eIYGfl9inu14mrlz+Lmnr6ndWVMWOyuhiBW
         1GGOENsIjb0z8ISmcd0gwJxVvWQh7YB4PmmggKTejRw7Mggz/vW7oIP4SrhH3gzxJ79T
         rA9oqk2oB+enI97kMUyhU5t1DGhrK8fm/5sWxBMttXkZFhrNWpP1otu9eH0LT8hw6Bcd
         ONSvKHvYxmOjg0Aa3a/GtMTrv6kVZQ74wE6inTbEMVDOSmcdyEUSfBdRDrmfcEqqIOpf
         jq37MwlkA1QECQc620yc/2Tnvl4B4F9kTCKyaCQmNF7W3qbP06zi8ZaTwvZlyA3H7NbI
         OsGA==
X-Forwarded-Encrypted: i=1; AFNElJ/5y6NZfgVa0uEUI65IPgP7ro/X1TbfBhKhgZaE7GgsxUgJ81xDbS5rhdMVPOIJ4K1IZAeuddeqvIFzmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtK4fwUBNi6BzF2rQHCPiZjZ4iZp3IQGe8j9EKRCgHmbSA3gm
	ERVAFjYfgXL27qNMK+aU9Bb3J5iARkbMDUjR0fkayjy+QEYNVI3Gb/NneT1Y7Dcj
X-Gm-Gg: Acq92OH6unUGwn1XjIqAfkT5Hn3c/P7oOC4tftq6r5bS3Oo7Ocl949v+LGWyDicWRsF
	HHgooIZ0aU0TE+QgSs0SIiqrVVCSfD5bEMOy29dWzW5UUzI8/BElDAnkEXJow55sVylqQSABCyC
	nJwrUTN8H/dVh8DAEUjglTwK9AvCPjrcl7c1A9yeP3EkSaFug3fHpHNg0VpenDGOXjY1uzmQdGb
	tiqk1WqgWVzuAazcI6NbHkxG5lU+c/Xxr9JdqYaPRxUt5s8xoOov8FPzJ8ue4J1aNX0k1l1UrF/
	ZmQSVau234nDzZo5dHdeYdCquyda8J/dKBQMLHUjiZolBFp7N+41LGdTWoPnZEzk7R4xWsdt/Nd
	6fOfoLM6MGrEeA3r4pGxWnH/aJ3BEaIKSPrdvyXbJXo1x+Qh7+qs6+acbzZSqoRz9qQkQcM4yIp
	zfukVOoa3P1XtLd4Ah/gw8j1aEN9ANglWIcL6nkd0JsU9EB5WGHTYXDQxARZEiUZPQAuWZtDWf1
	BSYIDIPv694BSW/ogwEPYNqh8jUnmyeF2ErC4qoBkZ8HnKbpYQimTcSpfxqmEIH8Oj2bsuJqqLf
	0I9DdEnXMuoI2vKcWw==
X-Received: by 2002:a05:7300:8181:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-308200c58e0mr4686992eec.32.1781389268030;
        Sat, 13 Jun 2026 15:21:08 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm8605834eec.19.2026.06.13.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:21:07 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marge Yang <Marge.Yang@tw.synaptics.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - correct CONFIG_RMI4_F34 macro name in comment
Date: Sat, 13 Jun 2026 15:21:02 -0700
Message-ID: <20260613222105.101418-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in the synaptics-rmi4 driver incorrectly refers to
CONFIG_RMI4_F34 instead of CONFIG_RMI4_F34. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab15..7d0ae80dc8ea 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -127,7 +127,7 @@ static inline int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
 static inline void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
 {
 }
-#endif /* CONFIG_RMI_F34 */
+#endif /* CONFIG_RMI4_F34 */
 
 extern struct rmi_function_handler rmi_f01_handler;
 extern struct rmi_function_handler rmi_f03_handler;
-- 
2.43.0

