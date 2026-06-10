Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756E425CD2
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104306; cv=none; b=CWXGlKvL4wBR41cHkeT4TYZIvKhAMboLXqwf014zu/Xsf4I2QFJHxNwaiZwe2JuDAKMP1LWHFpRQk9KO/EyE77J+/ZRZXcR4+8hT84j45laCrgaftmoOzjuYrUfPWgcjcIM0Me+gRMFzwcRc9ptDWc5s5uKHN+b+YXITvWsU9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104306; c=relaxed/simple;
	bh=r5wvLahjB4zWxzRimyIkAmElMr1BKspEuFSEmiB5RMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJb5ep5ysewDC4JAXm1zWQUH0dui233dqSxdujNX/xe0008+AmsJaK4QvNp85yiRYXV9qJvXgMn/h4ZOrfZMVfR5RTCCU7zPSgaDKcVIr/vn6krAfWQfkoL3kkig8E4rvGhiW2scHs26brlJZwqi4Uf+Rsn1xNaxsLAFDYpuy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=knREN7zI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="knREN7zI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so47359115e9.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104303; x=1781709103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvDPpcYD4pwkugLT1skXsvI4tmiT1n9X2eJlA86aMJ4=;
        b=knREN7zI9H3Zd7UyD/BwGeWfzh2J8RA90yXhMmrag9pF2LcTBqB7FYg/7Do4Z0eiy7
         WgmICQjE6e842r+97L6p8Snc1LYnBFsB1sgf8StkTKadtPvIis0OX8Ns+AxAZCflT/Uq
         aRAj0oTrbccYaW8EOV6y/kLp7T1obPOwHXjDeOe+t+74z3cGRganEZ/kFe2GMuHE0ex3
         fdYJaGHZUSh3z/SQsPnj2V4NVy9qffa3HFcmyxjf3/EO1biAyOKbJGUEWhJd9j6OmAOX
         HGgq47IN3S7O/fybnB3kzPa2uBjt08n6BT86PhpsCcTV+84azlRMf/sy+cZgdP9nI8Ow
         +ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104303; x=1781709103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JvDPpcYD4pwkugLT1skXsvI4tmiT1n9X2eJlA86aMJ4=;
        b=RvRfW6sXoEeUbxocrufdqGc3NqJmDVry3o2JwlBYR4Uz2Xu5OPXyXqmxylLEnW+JmR
         va08xfEsWTKTaGthGbRsdL++53yCeR62zhr+lHFqSaO/DUNVAMHUk6y8sZTSNy/OcT1P
         yXVmUrZIPskmPLmcjHfoPYMtGTQHH4RsHlbnzahfAZjHFRWaIZm2qU6ZmhnozkDysBmP
         NGx5TFnTokUIAESW58oLpnvqUQOu8lKqCLm0z+EtOzjGSI1wH/1kJu6Ioh5X7rHbcd8g
         77s4hi62drnGcxPUIgPwuEXjQj9uvkHEF0mkOabhMaC/dQjNtyqQFOjzNwW68LkANBhx
         VKYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WEvP7DlsPVn+9zPZbMo7i8E4xEfu8J3UMkf6p/FyhMazB+Wg8n93MuTxEeX5GGV+0WcJbqjmXN1nbvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuduKKcRct8LHbU9082g3VFMXoOKIrOwyem3rUjbmRbsorhx/h
	jJ33L6EMGFfdJcTm3TwcYl/jVviYwYko93Zn1R7SsDRqHPXyn2cbPdAmolOLYYkmAp/v7lx5aGc
	Ktu1E
X-Gm-Gg: Acq92OGSuuMB3/DdtquFSLWaA6kF8mIu2tqWLdtFDaQh6gd2KGvjixNRakVdnDZx5ZM
	ZSWpH1vU5inlODtlFAyAebLTRACr/QGw/BBKozxxBxQgSeBx4C+GOqR+zbX0JMKrO5AGHdu3VYf
	GpRbMfFEDNCbCFhmL8ISILAHO04EiHF31LSU0tDkF3R+zkIvEvyBSkPEBuDl8O/HEmRv/cPM0A4
	nuitE/JR7SPsIDTSiwE8LmIs6CqkVaj7bTQ4tD3N/lc+yAs2fmP6EE0y4/INWPiyv9XpPX1q2iJ
	IorrhE5kWkX9oL3hP8WrrFHXl9ferRXAG8ltnvIl0c8UjlNwLCyK8tWNl6e2Y8G2MVFc1H/XkEU
	7L83IEs5akhbzaEP8Ifs0C/mQ+PbwHFGkamBXSjmy6cQ1CkCRaSEcBetNSMSIGjgjabefZ48aPq
	PJYgqrV4e/S210HnXpaxmv9iEFa3jrHJJgppe2BxJNX+Ll2qrRe5Y=
X-Received: by 2002:a05:600c:34c3:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490c2599e11mr443325885e9.7.1781104302878;
        Wed, 10 Jun 2026 08:11:42 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:42 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:31 +0100
Subject: [PATCH v2 08/12] HID: hid-ite: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-8-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=1900;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=r5wvLahjB4zWxzRimyIkAmElMr1BKspEuFSEmiB5RMA=;
 b=gZfyoMFAwd/qGyYCfDPhlraFS9Tpx3ZKnNOem4Tb715fquFjXI/q+Ud28j6+mREM98vRphd2h
 zBH8+SL3zgtBbEO5EV/VItibAaerzK7xzcvIkhbbpvk5hySeVZvemkO
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing, lets fix this and set the whole of 'hid_device_id' struct
as the drvdata and then simply use its integer 'driver_data' field for
quirks, which shall make the code cleaner, type-safe, consistent and
more readable.

This makes the cast to (void *) during storage a bit safer (just to
suppress the const qualifier warning) and the cast to (unsigned long)
during retrieval is removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-ite.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ite.c b/drivers/hid/hid-ite.c
index 8e42780a2663..63908f24b524 100644
--- a/drivers/hid/hid-ite.c
+++ b/drivers/hid/hid-ite.c
@@ -15,7 +15,9 @@
 
 static const __u8 *ite_report_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long quirks = id->driver_data;
 
 	if (quirks & QUIRK_TOUCHPAD_ON_OFF_REPORT) {
 		/* For Acer Aspire Switch 10 SW5-012 keyboard-dock */
@@ -44,7 +46,8 @@ static int ite_input_mapping(struct hid_device *hdev,
 		int *max)
 {
 
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long quirks = id->driver_data;
 
 	if ((quirks & QUIRK_TOUCHPAD_ON_OFF_REPORT) &&
 	    (usage->hid & HID_USAGE_PAGE) == 0x00880000) {
@@ -94,7 +97,7 @@ static int ite_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)id->driver_data);
+	hid_set_drvdata(hdev, (void *)id);
 
 	ret = hid_open_report(hdev);
 	if (ret)

-- 
2.43.0

