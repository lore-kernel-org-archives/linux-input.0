Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746772;
	b=wHeSy6UYQbKM/c2sVvl5WfLc2V5OkzokRmQAgHvMjfoUw48yWbyjP/vi9uwxYxxWgTvA
	 srMDyXdJ+3+0Rs+0gO6jtedj4auy+YTOOzcVAOYWDbNCNmCigRHy3c+Yl3aZtc2RbyXTM
	 do93IgfRJUADKMNmDxnuZQCtgg0LPIjoQQudPEclUBFpFhnKxGqIidyPF+VqCk/J0dP06
	 omusSDfzClQYPAnnK3YAvCP+N2jIe3A2j4UvNNita+hxph+ttl88IGGLs+3tbypqZtK+d
	 3mw3Jf/uNL3m1sSCuU64itlHdRxc/tsI/cmjFEwdm2waueEzKfcYAhBcu9UGDI0ZOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/nRVFFdVoOcvMQfARJukXiW43LqdQgC1g8x/9aYkCas=;
	b=ZpE7Ot41qil2Pr1pJDi9Yzb2VRASmGynnQFlp+HuuR9/4SE9YiEK7XlZJliatwKqkp1V
	 kyMty6G3MpWuKdbZ49ThckgobtlPkOWz1eFTR0ChH/7o9GElsQ6RLOYcfDgFqrvIKWNfs
	 8dDcWjtQLCBbcVlCiuJEHkjdHbTLH0ElselnTBldFuFi/M/2IbuQh5cpV4FpDPwBUX4SB
	 wtcvwaT5a2SUdO2wuhPQ94Nie+cjy9tKCRobjFbKwqVCO+S6pmkqp1WkcsiheF/MRFkKc
	 VGZ17XPNBKX3OvMFcVH1ckOo5Eh6cqUNjeXNGRPQjRBWo/62H9yaw8rL7zwKAcj++bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4ZsMtqs;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68B606D804
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 22:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C68B606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4ZsMtqs
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so87175eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746771; x=1794351571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nRVFFdVoOcvMQfARJukXiW43LqdQgC1g8x/9aYkCas=;
        b=X4ZsMtqsF0WW7V3d8FDaw9tcvLPi2S0pP0wgANHkQGOijlXdtd2pznDL27mKtsqi0O
         nBWuXqccUiLR3st/E0uY0K9cC3u3TfiLvJ7xRCyTYx2J2WPCGmoMA2uDJZ0PYlyxkC7T
         NnoBWAi/oYQPAGxu9NyeEeOBXUUEJJ/2PK4SFunEKIvcke3DmRtq0jWuQ9co3LbMYZPw
         7xW9Om6gbTqP3SPVb7TbGQH/oHRkOE5CR0yuhV+/UDX2gTqwfs6rYT/BE7OL9a1EF0D6
         5s6pmXa3dIJm56AF4aV7MG+yG5oqQonAdS7uNE/yrZA7w57UeSWckTrCkXkRg6fcOjaG
         adkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746771; x=1794351571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nRVFFdVoOcvMQfARJukXiW43LqdQgC1g8x/9aYkCas=;
        b=WOh1M0E8elLPfnDMjXT7I+1ptdbffrqons8wPmfmSHe/rPTr145kBFaSOy9xBWk79I
         8RYiXzdkEI2Dc3uf6ycMXj5GoEcv5LdwMy7SHrTRGmk5S9jOthDSg2y6PBdk1p1YjMwg
         Fn6Vzj/wQarcHvACxBMHcfoKK9/nfF6CZpKHRIOGqGYaLL3P+GNYn8hRdJtnPlGrpL00
         bI7h4uNpCp2/3Z42kdOBZNneUE/ddsd5W3OUe2/7gB4RWNCb5DEjHsA/Lj7971fS0Vqz
         vQhZuxGdvLs3xKmHz8erg1KsdBOyXQW26RSXGopHJEuYUu3OPTTOFbL17BMVuDFZXz5p
         8PfA==
X-Forwarded-Encrypted: i=1; AKwUvBwsnZTIBd56JSJncASMt7AOf+MfEuyhVhYgH36VKGTR9keSryyKzGl25a9/nh7NkC94K4mX+xL388qY7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+UN9uKJIwy3wFCrl2RNJSuDy3dSqdwupORqfTo54AHzAW/JWo7
	tTp8JokNGkLGRXMZxecSSmiByOlk0VXRlWhm7XoqmpePWpfED6B7JrAd
X-Gm-Gg: AYBFou3d6p35qt7XTBZjEHPlFa7SZkZtMjb+ZzRnKP/TqdBjSqNwS+JeD+eZESX51VO
	MZnBmWUWBs8uYQTmnPK1gQNjwHrZ9UoIhsaJfeA0ZI8uqD/JsHCZbpWCTnpP9KkivmATbOJzGyT
	gc6fQeLsAWxx8Vv7Jfr/AtHRQM41VpaR7E2CKr2qp/CA6fh0iEeMa0wwF/FzbdoWytZVgBll57k
	A7EJX3Pe//RoPLbvQoTB9wsIp7lmpGde7f2a6ihaBogW2/5t9RvflfICS7X3VwI0vG+FIYv2nE5
	Ng/hAsjcaRtKkHF9tD00y5xfL4Gqwpc/mB5SvCCDGwJchIZWyfLfG96SleyrxkmohPNNl7+7Ofv
	+cE5iEK9q50EwY18p1ZcT4wwSMOBsNafU1bPeYNKxiwY+7ZQSX0KE6c5pHTsEKqheQ6VmoKuh6f
	wrTwTEeNV5QdWv/Ji+jonsjaslJOR1vVzTgIlvgPILA2YeCco4RUd6XpHbFf6mnjlB4AQQSXc2Y
	xGF80rzirOYh3tX3I7Emsm/GpAhrco979m+jfB8yMqPBkBwRnmHcTJw6fS7FM3zFb/FoZI6nPdO
	0IHq+rA/zUEXKKDo4InfklWBQ2Zsxs9utsdBS2rZGiLiZKPlrPtIO8mkVjLvwhGxIoxgFjqDo10
	Q2249eNicuidNMh4z
X-Received: by 2002:a05:701b:42d4:10b0:143:2967:c0b1 with SMTP id a92af1059eb24-1ac5b7e1cdfmr22675097c88.25.1793746770941;
        Tue, 03 Nov 2026 14:59:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm1187111eec.8.2026.11.03.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:59:29 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: stmfts - validate slot ID in touch events
Date: Tue,  3 Nov 2026 14:58:42 -0800
Message-ID: <20261103225923.3892612-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
References: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
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

Both FTS4 and FTS5 contact and release reporting functions extract a
4-bit slot/touch ID (values 0 to 15) from the event payload. However,
the driver initializes only STMFTS_MAX_FINGERS (10) multi-touch slots.

Passing a slot ID greater than or equal to STMFTS_MAX_FINGERS to
input_mt_slot() is silently rejected by the input core without updating
mt->slot, which causes subsequent slot state, coordinate, or release
reports to corrupt or release the previously active slot.

Validate that the slot ID is strictly less than STMFTS_MAX_FINGERS in
stmfts_report_contact_event(), stmfts_report_contact_release(),
stmfts5_report_contact_event(), and stmfts5_report_contact_release(),
logging a warning and returning early when an invalid slot ID is
encountered.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmfts.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 3613c7f2ab15..25d127aa8642 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -232,6 +232,12 @@ static void stmfts_report_contact_event(struct stmfts_data *sdata,
 	u8 orientation = event[6];
 	u8 area = event[7];
 
+	if (slot_id >= STMFTS_MAX_FINGERS) {
+		dev_warn(&sdata->client->dev,
+			 "invalid slot ID %u\n", slot_id);
+		return;
+	}
+
 	input_mt_slot(sdata->input, slot_id);
 
 	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
@@ -250,6 +256,12 @@ static void stmfts_report_contact_release(struct stmfts_data *sdata,
 {
 	u8 slot_id = (event[0] & STMFTS_MASK_TOUCH_ID) >> 4;
 
+	if (slot_id >= STMFTS_MAX_FINGERS) {
+		dev_warn(&sdata->client->dev,
+			 "invalid slot ID %u\n", slot_id);
+		return;
+	}
+
 	input_mt_slot(sdata->input, slot_id);
 	input_mt_report_slot_inactive(sdata->input);
 
@@ -282,6 +294,12 @@ static void stmfts5_report_contact_event(struct stmfts_data *sdata,
 	int distance = 0;
 	unsigned int tool;
 
+	if (touch_id >= STMFTS_MAX_FINGERS) {
+		dev_warn(&sdata->client->dev,
+			 "invalid slot ID %u\n", touch_id);
+		return;
+	}
+
 	switch (touch_type) {
 	case STMFTS_TOUCH_TYPE_STYLUS:
 		tool = MT_TOOL_PEN;
@@ -340,6 +358,12 @@ static void stmfts5_report_contact_release(struct stmfts_data *sdata,
 	/* format: touch ID is in high 4 bits of event[1] */
 	u8 touch_id = (event[1] & STMFTS_MASK_TOUCH_ID) >> 4;
 
+	if (touch_id >= STMFTS_MAX_FINGERS) {
+		dev_warn(&sdata->client->dev,
+			 "invalid slot ID %u\n", touch_id);
+		return;
+	}
+
 	input_mt_slot(sdata->input, touch_id);
 	input_mt_report_slot_inactive(sdata->input);
 }
-- 
2.56.0.385.gac671c819a-goog

