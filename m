Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845794;
	b=mf9QhrZes3F9AnBL+1CwzgLsU2V60tsU5j7Ml5mefObd5Zl9iC472LxflZ/r+TTI5E7C
	 ZHUnTAAYe6TpLkX+UwRruaneJxC2AHwBBD1EcDMPsckjQ8csYHuNrCesxOJHF+dvH22lg
	 UnZi1D6qMcUFkN5bQzwuGHggThsMUVRSKubYGk+8f1wFdMdfzKgmeBwoAOAWx852pCPsc
	 czMgd7kxQ7ZNYGAlkJ40yRBKkci1fkWnZUh86MhrksK5HUnnkxAGGgWqsZZyJ4EmlJDUj
	 5msvrhZYnFuU4mfVoz4andFuSvJNOuQFxYGXHaF3OKm3c6Aidueijbd9nrc1NDbOY8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6tUAthxewYs0vo1lb/ilxgjE4AqKR03nZ2p+PAynKMw=;
	b=aI1FgmWMycY2Az8EO2PGU33sfvPuFc097liijMN9wlWH8nkhbZmSvz5CaiNMpBtgRI27
	 aRUwtVB3kL9WSKUjQPD5Zb1S8yTgUnvAo6Y3TtsTK+XdpxVs5amRCLIOVxN9UkvUSxpGC
	 ZMC4vPwv3gfDaPsgpuciw2utrhATu7EW9OHYkP6wZ5gtEKtsWd4pExFHX2hkAVldhUthZ
	 n4OzpVdldD0S56h+aiqMnBBQ7W8vDijCnDMR+u91lYCspGWSYMS6nfFiFcyCjvSgqwL8I
	 ELdvDlffAZLl2AVowfqNICmLKrw5E0ENri17nPVoNmMDPdQTYNnXFCjhF6EKrddoFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKgpZnIZ;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5B606A31C
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 06:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E5B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKgpZnIZ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38699cf08dfso11330515eec.1
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 22:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795845793; x=1796450593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tUAthxewYs0vo1lb/ilxgjE4AqKR03nZ2p+PAynKMw=;
        b=zKgpZnIZ5/XW8UnZRIbwBUn2TSWHieTAne4g/6pYgQCVoQx2Pjd7NHmFluJ5Q+Raee
         3EJw7zlA0mFaLHE1F8bzN8PToUNtCyODIv3Kd9sdyHdlR0n9n9xxI4qAKb3keLJPaCji
         +25Xz24oUtcCkR3yByBGDM6qCot4xkxVA0EFY3bH8QuU6LQjfwSVs8PT236MJ1jH5Qg3
         46HAn56jgjr0lvLV2xOPZz7YPtcs/Ou3btUbW72jj5ryQvOJWrufXL7imqVTPQ+tT7XC
         ih5kYNHCW1vBSvwoP0wTOrusQcEr4CFjpxpRKnN1jdu+PfzEF4fv8RZ+HihVRt+yGZjO
         mkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795845793; x=1796450593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tUAthxewYs0vo1lb/ilxgjE4AqKR03nZ2p+PAynKMw=;
        b=HYMsbMmntOubD+wk8JhL97DeQ/IFVajOOSVXRFeI8ITu+B6IAqh6+6ZcEukPVPLNoj
         16nNB2EJrWMv4Nu+RFa72QEw1dElL6/L9RvyjWjw7MvVeU7eYvfa+j49LwS+ZCH3ScJc
         ERY+6XGrC/9WIJwTtFozVxz7u5xPk7drzTspIaphkMhNhc5Dlax1GDOR2pXugm+SLN1h
         QranufANqV+lHKk+5YaVFR73AOg4o1xu7rzkKlFwMDx6y1XTg3npM9QZnqRAD0ZLxqTM
         rQ4o2k/9xckrIDLCoU8/oKrrfWHCoNGKZrG+zOwAs83muwoee12IKJWrk5BC+RBruTY4
         YOoA==
X-Gm-Message-State: APuU4Z9wZZbgTwi39Qo4OlIKB4x16md4HjKBNiWa/3ym7teGBRONK9Z7
	Nd3ufz3wY//vPq7iibGKm9glaNpV4XaTVZUPydG07tA49ydLAY+ZkWTuAFhudw==
X-Gm-Gg: AZFdTZf6FjbofO49gmtRJu8cVKi7k3OuTZr0fNomj2IdPqf2xRBSCJ8UxJVM/q6xysp
	M6ITpg+hwlIO24mEOA5UINLWylXiiTbMXbwu4S3lwOqP5c2x4rES5Nv5ZLlZJhfWyzSY1J2tPGI
	YU7LWexQeeAhtJKeivhL1YqjerJV7WZQ9aDrRZaqmW2KsQiug106Z+lLGAPNsdlW2+aUSe+zq+i
	KZLSbkBW94leuqNRzCa/lVI5/+pE9ANK2lp+pymp3PEHyEyjVwvvwARJa4p1mXJxyTNmaB2fuR9
	D6kC9EZ00frqybY4oh2G0wLUBYJ6Q17f6txBB7S0MS0QqIE2yWSjp7tXJnSKujECTgThwRlnUDP
	4SeARgnZBLPczvvmArH1muHXDNogMJcDhxO0aiGUAFiZ5RyanmWBMEJKU97Ru7JkyDQmCBjVCEg
	uHX99fuYySyNskZqOCqFHRqu2JcWwj0IZ+mKq03jJlFB2oMjZiFJ7Ho8xLb0f3JnwvSAMcpnvGq
	bAJc2ekO9DfP/4Kb2Mi7QvoVE73rlo8mumBAhfZLkASWnXdcup6ZKNt02mOJLIUEda2s5lEaLQU
	+O+Ut/AXmFOcVIz2zPMqE+8PacDlIfH9RdxTbtYvZ7eCUxMXsrgGJA==
X-Received: by 2002:a05:7300:d40e:b0:386:bc40:1508 with SMTP id 5a478bee46e88-386cfc4cb54mr9661873eec.14.1795845792958;
        Fri, 27 Nov 2026 22:03:12 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm69698879eec.8.2026.11.27.22.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:03:12 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Subject: [PATCH] HID: google: check the report count in hammer_get_folded_state()
Date: Sat, 28 Nov 2026 14:03:08 +0800
Message-Id: <20261128060308.4131815-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

hammer_get_folded_state() reads the folded state from the GET_REPORT
buffer at field->report_offset. A device can declare the folded field
with a Report Count of zero. Such a field takes no space in the report,
so the read can go up to four bytes past the buffer.

Skip fields with a Report Count of zero, as the HID core does.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: df7b622906f2 ("HID: google: Get HID report on probe to confirm tablet switch state")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hid/hid-google-hammer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 6296eb686ca9..25a600efe1ba 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -457,6 +457,10 @@ static void hammer_get_folded_state(struct hid_device *hdev)
 	for (a = 0; a < report->maxfield; a++) {
 		struct hid_field *field = report->field[a];
 
+		/* Ignore if report count is out of bounds. */
+		if (field->report_count < 1)
+			continue;
+
 		if (field->usage->hid == HID_USAGE_KBD_FOLDED) {
 			u32 value = hid_field_extract(hdev, buf+1,
 					field->report_offset, field->report_size);
-- 
2.34.1

