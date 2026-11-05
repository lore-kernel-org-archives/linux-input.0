Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852820;
	b=Z5Ix9GCwrcMbFz4oVOqH7A+1uC6RbFuCfceoy4tMRqHnOzzBqzXcG66UIGNtPoeKLU90
	 RfHXlNPRNxhwftKSno0Mz10yvpVSXQMlVPbEYykemS90faKNY7KeAbJGPbSlHcTbPMphE
	 6ILazuzcNZnYPAHjxlCQhnnD0Nlbpu8V4wc5Nthqv8vUvXIkkwkZ+AlQfZGlAZmPij3YS
	 BfLYt2fR98nCSzVk3I1lxamQsdqnpG8h2q4cCsk6eol+dO/tR0RbxcQ1BsFrNMnmsgjj0
	 ri5KVXN9rw6q+a4mNwYy5VExwxAWYb3ke45UXgycfRxZ2+3yQxz0TnsvoNDUnbJnD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6Dx9GlhWSYYSjKrkLodD2g0q9NIvhIS/VlB9UxsGFr0=;
	b=j9U7BzylDnmgujGkVaASjwi2evsG9/j/bQHM5T2lhAb/2ZYK3tkq66Jn3cocvDrjUgmv
	 L7ClnGXBiHyEZSTkDYaZpv+S/NtEZWZFrAfnumqS4vkch7dodZu3ybGlTapkxniUylrlP
	 oOv0TA99oM46jzKJZRnyzCBYTKif4AFiIBnqNERvAyfm1DwfPfiPPWq1+l0vylH6LAnnX
	 W8kgPMB08a1TfaM28ptZNLcWzcBLQ0seDZkrHzXPl08THI/cyseuYdsGU2JLji56t75Gd
	 Q2y1aIJnRrnxlkrTtt0/jaqvdb0s5keaNPGgOG4mz9lrWJbsC/7TbrSnHBGKg5zXhCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHAH4Mpa;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEE606A329
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 04:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CBEE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHAH4Mpa
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2195741eec.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 20:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852819; x=1794457619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Dx9GlhWSYYSjKrkLodD2g0q9NIvhIS/VlB9UxsGFr0=;
        b=mHAH4Mpad64UJiZp5ruoCr59wzblMsRYZTtIuYxJvK2sy90W600cldVglwDrg5IuXe
         DhdGmi3PraSVBjy8GTEHDNTMSktut754GjoIvoGR2QOerY9k9bG5QdXtsIEwY5e8nTfb
         ETXdl1fQ+tILXuBOa/qzy/Ve0ZIIAzb3ioZ+AwWMD+n50KYSxr+xyxo+9mxR0trd541m
         oVe2U3Sk8+KRG8nccZxt/Q8mvO81BoJQWksoG7g47ctyiyGntGURexdOHql6IGD8K2lT
         CiqaAIBu9tt05b/81TVS1gnILr6lfRm5giaqVJvIaWPPmE/ogtze4qVn+wf9lTutoQM7
         BayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852819; x=1794457619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Dx9GlhWSYYSjKrkLodD2g0q9NIvhIS/VlB9UxsGFr0=;
        b=ruJOebI5WTx/XylvZTJx/G49N97W+6PJtZlQGWneypEe8o9quYAKDjTYdLlwHdY960
         WpvmCpHVt5XlFeMX+wW5kL5ggtD/zoVmZTHrW9DxX0LSI/2rFBWJ59OdkrjcYRzU/mxl
         aTsSjqsmeH3QttOzIfNUK6tvGshvdUb91gLrp/+Tv0OBJPKIG+30AivV3IpeLVsbo+Ul
         a1ArGCFVdVAfGLbySS6I6TIC8cQquTZVoMSGBOTU35ucOz+LE8V7M97sV6p0BDu0cXc7
         CYOoK3Fts/U1nYlR2yRkOhQLj7gXavBjMwamaVkYl9N2GUij9ibis0dH8HKnuuoLOZhr
         D6ig==
X-Gm-Message-State: APuU4Z81lSo6bY1dQyx7cJEPXTcJk14UNkrm7xa0K3WpXdMP80iYtZ9r
	rv2Sci+JnJDG9Z/fAUryOcHAynRZZMzGFY7oqe170lfTTxcyxYJ1Toke
X-Gm-Gg: AYBFou1Zr1Kkr0CC22kjXsfw+RscNkFmyYmdANhRiKtGzz0illXjklzMZyo4Fwr9+AH
	wbHhbs6tetgPqomJV3Q3GMp0e1vZ02ORVQwCfGKF+TJ6eh/Wq35aOlpdP61Aw2+XbeYRlMVWg8N
	HCvcRlzU9DwTYpJp9V+sGM1lP66QCzdbJfhbopKuwUjGsItdkSAZc0mpVvPYt1hTpE7p4f5yS77
	OCFMeVqbd2oMXTNjIAFRb4/L6HfT9hjNp+R1i6Hw8gyBpOVyVbMcLf/8ENS/prs5ASoYcs6QzJE
	kS4OHM+WOMyqqjuWXyikZqxM3wrFgYDaWyEYxun9E+V4QagoGWxqus7I09wjlp3GAq9ZNPbn5vL
	sKVZCOvqmlOlomsZ8D4tT9q5Ul4XeHYhzHDPSjNIQYaE6fjttDI0o7l5GqeZkrjYLWU63A2c8CK
	HiFGUvEwh7N7P4Aq0HTDD/NnYVyOdRUdQIaod+2Awuakk36f7giIs59aT/jpOz0B3Ws+SAHujsS
	NdKJ06zyMgGSwx9GYMx5ORNqfdv7UYzaYyrNtLGkkNnLZq7sTedQy87tekpduTb2hT1WwxvG5ZO
	9JbwCFa9rTD8owTPpgHiMU3R2EevemYNXsn3DDbGxJ3p+UG93jn2JAH4OMm8xe/VK+no
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id 5a478bee46e88-36a4242b2ebmr25756867eec.32.1793852819028;
        Wed, 04 Nov 2026 20:26:59 -0800 (PST)
Received: from localhost ([2409:40c4:1ac:755d:6be:3eb8:a598:dec5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fe477sm11383276eec.17.2026.11.04.20.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:26:58 -0800 (PST)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH] Input: synaptics - make InterTouch quirks table driven
Date: Thu,  5 Nov 2026 09:56:14 +0530
Message-ID: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
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

Move the device specific InterTouch quirk into a dedicated table to
simplify exempting more devices in future.

Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
 drivers/input/mouse/synaptics.c | 50 ++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1ed9261bff2b..748ade2004c3 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -213,6 +213,23 @@ static const char * const forcepad_pnp_ids[] = {
 	NULL
 };
 
+struct synaptics_intertouch_quirk {
+	u32 board_id;
+	const char *pnp_id;
+};
+
+/*
+ * List of devices with broken board revisions.
+ */
+static const struct synaptics_intertouch_quirk
+synaptics_intertouch_blocklist[] = {
+	{
+		/* ThinkPad T440p */
+		.board_id = 2722,
+		.pnp_id = "LEN0036",
+	},
+};
+
 /*
  * Send a command to the synaptics touchpad by special commands
  */
@@ -1814,6 +1831,33 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
+/*
+ * synaptics_intertouch_disabled - check if InterTouch should be disabled
+ * for a given touchpad based on its board revision.
+ *
+ * Returns true if the touchpad's board ID and PNP ID match a known broken
+ * entry in the synaptics_intertouch_blocklist table.
+ */
+static bool synaptics_intertouch_disabled(struct psmouse *psmouse,
+					  const struct synaptics_device_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(synaptics_intertouch_blocklist); i++) {
+		const struct synaptics_intertouch_quirk *quirk =
+			&synaptics_intertouch_blocklist[i];
+
+		if (info->board_id == quirk->board_id &&
+		    psmouse_matches_pnp_id(psmouse,
+					   (const char * const []) {
+						   quirk->pnp_id, NULL
+					   }))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * synaptics_setup_intertouch - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
@@ -1840,10 +1884,8 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 			return -ENXIO;
 		}
 
-		/* Disable intertouch on known-broken T440p board revisions */
-		if (info->board_id == 2722 &&
-		    psmouse_matches_pnp_id(psmouse,
-					   (const char * const []){"LEN0036", NULL})) {
+		/* Disable intertouch on known-broken board revisions */
+		if (synaptics_intertouch_disabled(psmouse, info)) {
 			psmouse_info(psmouse,
 				     "Disabling intertouch for board id %u\n",
 				     info->board_id);
-- 
2.56.0

