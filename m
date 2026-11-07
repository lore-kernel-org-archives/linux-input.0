Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017356;
	b=W8eX667jibftwjaGkSIvW13cqznywOcM+PB0aN94+sv2NEXM3b+bIok2mDa/52HKl/Ih
	 cG/WAKo/m3Uiyn9t/UehoVZiTXS0S0SBnDC5r3jeClEcTZMQSSeKmrpPPxjk/+b500/1o
	 /cqqUk8Tu9DHcPd6rnMDrXRDlZGXu3VYMTB+hrfTHu6P6vS9ZMt0uYpitrYvjIDjr7P5p
	 wSo6tCmPfmhh0jAGs3rthTTF/ykSipMN58F+HWuJMkeVzpw/hVrr/r6HSS9QooO0C0fiU
	 VtMlEr+mdwpOiEBNa+x88LCQaV9mHjNyQbCg1vDVoCRYXG5v0QxgBkIULFmpPMDMKvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2qAvvGtmJQQmvBJnY//KXBAoQMLJVMG+H1wUmvjA/DA=;
	b=idFpTBEOSeJJvevQAEM28E+yn0ErKNs+cQV+ryccPt+3A1RoaoCPK3R+4qAzwVdFfbq9
	 Za65idrILR6Ei/mGgyvS3QWx+XqkVVosmWOGtrAzp+ahAl6TANd7aiBbnTQ4pbLBotep3
	 5/B6wDF6Y4lsXo3fZ1FIXSJurCGZr7L7uriXakJ0t745vXmEVnahRrWOpbb6tMFga9b1i
	 SVY2Iz8+ECGUW3TvRD4RMY01nyY6ITcGU0HSRGhTGh31NhcbiKWeTZFIQRXya4RcCVF+r
	 8STRoDOe4Wd4wxNgRHzTHybI6IBJzB7nLT2tJ1jWfY5LhQ+7a+n84LjU4DFwZbGCnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vap4hVlx;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D18606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 02:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D18606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vap4hVlx
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so2155758c88.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017355; x=1794622155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qAvvGtmJQQmvBJnY//KXBAoQMLJVMG+H1wUmvjA/DA=;
        b=Vap4hVlx7nVvqer+QKxWQLIo0Bpj+irEq/wK954gzVzkM65hd1VrrB2B73jvZM007u
         vN8n9cALjWgyDvUEp6h2ryKbrz237EWQqglvVTJNeEFMgontX2D2Lljzz35/gEJIj0b1
         dIRyrYYaBWqtybnRVVFTfzGurCz8c9k7tnubayJX+qqmbkhilYJP8U6LFGKsGdZE0DkO
         R+TBri6xe8mpMfK679uAv4efC6IVaCMfaixyUzXxcVUg/qXmCZVhu3SOfVIVHMqm6gx+
         BOYMyGAfvHiOrS1FMVFJp4tUo0p1Q493WEkjGFmf95wEjqGjYT/erVAqYpPqU3G/XLj1
         AGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017355; x=1794622155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qAvvGtmJQQmvBJnY//KXBAoQMLJVMG+H1wUmvjA/DA=;
        b=GQytqy1N1dmeCeJIOW4dp7yjnicD2sDHwT/6O1WBtqM29LHBHF4NlmOB9izf+KXZTL
         Ik1s8GmpZQdfX5ZlQyr0TXCGHwViOPmTv3PZEzEkGsoyxyaHEZ6cNflrn5SIYk1QK332
         RK4ZnfopTOCHRexKsKbfa6ZiERT4ASSjhBLSCo0J7QarH6rMJk0otzcvF//W8UdRDjdX
         7iKOu3OUEygqGNIl+yAS5NO4QizypF+HObginf8uq5A4u6deaeJx/dQE1FVRs4S+gIiF
         vhijeL8COqnjC9K/Nkkz6lMxgD0eU9hDzLqSZu1vUqz4B7TFFsgHgm1C6mWH8Q7SopAE
         dZfg==
X-Gm-Message-State: APuU4Z/Tf4rGc5V5NlUq0tHfX6WfaHt0b31dQ0VgZAtfxdBi8qaiGlQc
	bK3jf3/x+YGpk52BwygtMQgJDuNJWMeP9MvwY2BEQHXal7JjaryCYaRd
X-Gm-Gg: AYBFou3T8NSdcvIm9PKGssEHNMqBcqrvdPiIbmXKLrLYHPYinPrhKdooXURvW/vf00O
	FsqJ4zvFFuxF+ULWjn5TcCf1SPHgOoP1W+oqzPMp7q7r6vRQXpj4FybF4K0PAHOOOKJk8NkgOAa
	awIQo/7Cd6Rce9imdYgKTyr8LgPulBEkeOd/gLW95SCXVtPjKTyZFWenLxoIXE/F8P2IZf+9Dxa
	1baye9CFnvklnXidqE7ffVEQdXqhg/moKqmgQvxnyuHfjPbr7FZ+Y5smoZ4SjfjVb3zqhVZhGU2
	9j/QjFBdcMLjYy2XyNwqXxHockToVxrDy0zmvegRVW1UmhMyXop5zP+bQlqdsRy1eK/xbbL3kZC
	s4nmDHupfuqdv9nCCxhcMEsQyDdttNcQkhxeIKTkcqIiVr9J+9lPSJoAQ6VgM1F7ZDwOlbXIvgl
	W8NrK7ame/FMOLTERdrIGiZMrD41HsEgdsabQYQb7FIFID6jovG8piljrEdglnWASPDsZIyisyn
	mV0uUOdmAnyePK/h9nBMBvZX0+wPrlKM3BGNRJz7WZTiMS6g+OwDjsj0io4e+aaATdicLk06paB
	j8LT4bAkl+Zr4FKxLoBuWvsWjQZfJAvCj2fU2SXUZtfShmj/DWguNyNq7zonlRn746rztRE=
X-Received: by 2002:a05:7022:3c84:b0:1a7:e1c6:6f33 with SMTP id a92af1059eb24-1b25d31d96dmr4197905c88.30.1794017355366;
        Fri, 06 Nov 2026 18:09:15 -0800 (PST)
Received: from localhost ([2409:40c4:100c:32b8:cdcf:1840:88f5:4e8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm13130210eec.10.2026.11.06.18.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:09:14 -0800 (PST)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH v2] Input: synaptics - make InterTouch quirks table driven
Date: Sat,  7 Nov 2026 07:37:51 +0530
Message-ID: <20261107020751.3959748-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
References: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
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
simplify exempting more devices in the future.

Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
Changes in v2:
- Guard synaptics_intertouch_quirk & synaptics_intertouch_blocklist by
#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS to match its only caller
synaptics_intertouch_disabled().

---

 drivers/input/mouse/synaptics.c | 52 ++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1ed9261bff2b..8561256406af 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -213,6 +213,25 @@ static const char * const forcepad_pnp_ids[] = {
 	NULL
 };
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS
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
+#endif
+
 /*
  * Send a command to the synaptics touchpad by special commands
  */
@@ -1814,6 +1833,33 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
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
@@ -1840,10 +1886,8 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
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

