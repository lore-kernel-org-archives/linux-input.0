Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407661;
	b=Yd86TzrFd+MwU9CjTUtOhFsNhHx2i6yhSHrIZS/Esn04Oy5IL4QCiAnZDOKdSCsnSDmx
	 dkWSZ8gkanHIZtRXb3JLG802FmrIt71pAp6PNiXe+14jXK3bS6SPzZwn/Wbk44wWt0aq8
	 8YoLo6rck/kJb9abbn8pYw6QeXaOf9zFET8tylN9T4Pg3mR961/lEPRJd9/G+m5q6TB8Q
	 Rd8rnYCpwXeul/q5hKEbebR5beAaDgvoeMLFX+Jl64ayU/Mr9f25at6PtMoTYQijupFut
	 4L8lZSRarOUBYbv3u19CBdwM03SrhGidrjTNaZwgXqUlBx5Hb1EGxSEDiG3IVtVXD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
	b=MHum4VclY+/qPfE/eNKolmvzPXIQdy5w/mLwz2fAl+2KL+9Sm0Mjg21okkqwuuk4Cwp7
	 Gxbpnos7JqcAEz5cu5Uc3ovUiQlp44Jf6zzQKIZjIE2JrqoZ+a+oQI9s4WBsNwOzAv5S8
	 V3LXlDxQDAx1MCFoySvsxOVIcagH9JkOmNMlrvjprHuOmjQPDyWKgVNuCcZauGG+yBQLx
	 05UZv0klmEvJ7qUPnCIbQWmHTDdtS5Z2hBPFFrf1Tv3qn3WCp1oJCBfPauAWgxv7oUev3
	 8YHFrc/THUxr5++6LCXaogwXoUbPcqG6V1Us0CsDGm4ig045/jtF3+zjsMK6zMXzIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4Uwpo3;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF4606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFF4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4Uwpo3
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3869b68caecso3510932eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407660; x=1796012460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
        b=eK4Uwpo3OKwscpby5O/wJ5Bh319RVVMB0zpKY4nFAgZAx03B21O7A3MiS2Rlzeh50n
         KOuE3NNZA3kT65dCRNR/B6YZIuTmX+PbA3vBkYSOdz4EsnZ9mN/GG5HFG1avcJSb7fDA
         rqE7qyzjkRFtbdiHg8okLo3qcAaP9zOcIqHlSO8jPJD4N7d5GqzjCDIM8Vjdeap2WLe7
         B4XbZ+jVWN018SGjCOpLeM6uO/7otJLCU6IyI6lmCSrsiBBnfPX2/oSpHkcx8y7wd7Yp
         tfciEHHKWsN6Kwz6z1AB0B+GVCsdiihgmHmQe+q842rOkZPAuSFYdFrjdKahyjJ6rdRV
         vYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407660; x=1796012460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
        b=UtDF/3gbM19EMEA5rOpRiPtWqkjFRjYfbzqHATgDXGH3O7pKoneHPn4sQzs1Hbzaqj
         NnZssBsKkRrjtK3B4nva6IKfpJIpA/7jaPxHqKLnbuZPL5CUO3eLPkYGTDrmqQaoc7PP
         TC8qwwVgETapJMQbfiY4Oz9UF3COnS/XSTYJFwar0kgkuakzCr/41hRwjlpulwrwFksR
         zO4XKWSIIoP2HFUtx6wtPB+Vr4Yla9W7XyM5ZsoLC07w3qyQASmRcnh/7NFg0eTyg3QH
         xnN3bCapOeZgtX6REPN0mF6WBLcUpQPKdeUgSzUufqyE2xPWYVBfui3HmwI+hCfkztmE
         X24A==
X-Forwarded-Encrypted: i=1; AL+hErH2alTygxwmPxmsFNaGAZOxaaygk/NJRAyecLYV1tquszvUM1xnZaXwdMBGfDGD7YQVxqVOH8lh8/gUbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ADaO/o6XqVPseKIk/xqTSkPT49y6iqxREWSPoBkN0SOhRF/Sc
	UfkxikEykup/MQ6ypm/iR54QnkiisIWITfNfCeH2KTScnVHJKrzz6amQ
X-Gm-Gg: AZFdTZfVejjsK5YjZ3rrPM2umwCYRJpDeXvmzpxqmm6k3m1NOOn7wP4vAHMSIiHNEKW
	aJ4Bw7Gfa10/gIxZiB33v/0bFyJj5ydTrKORXn8vgRNMsbQ1WagwTlJBqY5tUQ553MNj+bVvGxX
	8td3pdxyqXYYriId1z4ofQMIQyvYcPF1ix5cLYGA2/GqGmG60v0Mwpc3tqQ/2LFuh4sDG8xZe0Q
	XRlrKgQmSxSmNxeJPveIfOJ3I/wnCgVjX26i7RgcetyQi+sYPqLRGEWNcMycUmOcRnay7SRCcNn
	eeK1WKvewBuoXX81EvLs+Ot1ZEVllSY7Skg9Kij/F1BEPY90GiwDVrp+jH/KEdhQg0nns88chnt
	OA2p4KhyB613FQ7CCufY454B9aL5NtvHWe8xbqZys8Dd2kmeg7J3hFJDaq3FBFJ0eQYXKWEFeKa
	koiTijiTzCrzxMy3wYdIik7yJYHvGhEim7DlnUup3GFdAY4jVtmg3K74Eb1QNH996dEYlt8bqfI
	/y3X59uDw32s4t0UMoZSs5jEQpDcQOEFzub2bOHApFVy9xHsEuGToePHFSlUl8sDS1AxrU2p9Ap
	KXvJy0SumU7AoZ+oC9ok7NqPkEENQJEm2RKnJM5niB1IeKY1FS/1upoZcdZ4OFu0uqr0ms7lkR3
	jlF+p7w07TtrYmQeK9ZE393lcxTOpEmUbMy+0V4xin02ewHQ=
X-Received: by 2002:a05:7301:6188:10b0:386:9ba8:2864 with SMTP id 5a478bee46e88-3869ba82acfmr6273464eec.0.1795407660013;
        Sun, 22 Nov 2026 20:21:00 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:20:59 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] HID: wacom: check the input device in the shared report helpers
Date: Mon, 23 Nov 2026 04:20:10 +0000
Message-ID: <dcd2a9920a0f7a7da8b85e1b133d61e2585472c4.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event(). Log a
warning on the first occurrence so the condition is not silently
swallowed.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ab89a11d6740..c7bf0e5988e5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (!touch_max)
 		return 0;
 
@@ -4254,9 +4260,16 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev) {
+		pr_warn_once("%s: input_dev is NULL\n", __func__);
+		return;
+	}
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.43.0

