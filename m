Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096749;
	b=Ny03Ofh+EOUoh51rHqxuHnuNN6KZwBo+6aSihXOO88r71Ae14ldXic+CAtX8Grh1Yvx8
	 2/XoVbASFuQvznq70EOY0NpRvpahtZyCLiCUtfn4HOUNs2pLfC09iAw8eEpd8CeQuNypX
	 RY22HaI4HrDP9k4Dz2J++/6PA3ljVDywXB0nvVJX0rqjX/wyJY4fKl7lBENVYThPvYdHY
	 brgxez/nzePHwAoqDJQAjAbW2n62RBlnNXemVu0Lj+cm7BiJAGn/giCXbjQnG4IneY/iI
	 VfZt0FpeZErgO+3e3Mx8EyTfhSy6ZMzqxNNSUkiAQ8PqzpH4PGfDuU9GF6/ItNusFCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
	b=DcAFdCJO28Y2/oIrSegiA6fyPyqta7lSbk7tvcOHj7lRgqL717LUVdmZu9OLkLIqBWN4
	 5isCB/AdhxydIHAFGGuRgHIhNjak0dTEzRSA+nq5Z2xVAXpw2uGivefgmpYZmgQJvN/uz
	 ut5QeoYsKlH1wuky+W4+grCU5KxM+0pEZNDjXXme3W1fWycqYCzxll5yvTA4HiS0Z1ZNe
	 mlfwY56wGtFyw48p3WnYEdmWIuKU9JJ9j7+T+cqJ8FPPFyQSa2ZASzG2Ta8q2Chb6gBn+
	 35QVOAjUAtALaH31Ym0kC93NLIPRSTeZQxOL8dCUgk8fa9V+I2FuX/fMbYZE5agQb4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P48FoCU2;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421D606A32F
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 00:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6421D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P48FoCU2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2eb0f1b592bso269935ad.1
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794096748; x=1794701548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
        b=P48FoCU2wJLuOW0KvMaQuorD4bSsAXGz0958TAY4PSp1uQZOn2l2Zl98oZ08R42vL5
         XqpiwXtmXaOPqg2GomlOeekqpRjWYs/24dJ9uKCF3FRL0BECVCZjRkRWDh0HWto71KxC
         h8CJLG9PwqIr8MU4A0BtRMwxxKswSUr0vYKF9SCjhG+MfFw7QCyqwkE9L3Vp+Kg32W69
         uTtyTgpY7ij5PCuiwHjWLxvvsViLr0BJn3E7ssYSp01C5a7qqvvZJZay1eD1AdPN77OF
         EPrnk2Hk2QGwjEI+CBlU2zPqyLH+0MLDJn9cTsfCdun/TMWwe7whJc/ki9yUrWfV3+66
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096748; x=1794701548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
        b=a5/uWEZFN57Lz7deqrPo6Gj09rSMosItv5/VQp5H6GaGcYIbkAwn0rc1B6ikSbN4VW
         VjyvkN7nigaxm+oxRScpM37ABNv384ebfFXMm3fi8277sU21MbgRUL/ugbhKHI8OoJt/
         popaUnJSevpKbps+eqTDIFSmePLr4JVnBm1UgWJdLeNdUppRUc15rWTQGgMDkunHaFSx
         BtXO+p1RGGh7ONHL7IlAgA6Dojhazoe7zuJAQhAWQrW3R5m8q/ZGrRQieP9dpe36LpLn
         +QsW6bNIHvegcgxgc3oGkA3FH88LYLWpJNhkJX4jKYAQsHCYuXPM8xgIEEkepj9hY/Cx
         EBYA==
X-Gm-Message-State: APuU4Z8aI/4Qtdz9es92hODEudQiTuU0ijQAyUbysVe4r9YKTgdk1pfh
	NS5HrrhhU/EwkShgss8sXWdm6Qulu5i8+7RJ05oQJkSMqfWZBtSz+IcP
X-Gm-Gg: AYBFou11GNjs/qeNkZrZp1n0GJ0deMKNHfbIKvTv8oIx1hqX0ABpypxX7RcT7sgyUeG
	pIpUoCKjzSm39etnfQt6Y6HLAMZ0RVsi0bZWGrlwLS4czuwgMTUHSWWKkuff8BFVwWsoKquB0EG
	i4yIeB509rDt2SPvLZjHh6VrZFhedQoGAfr2+1ADGKe8qVQmsFZHKhm9GJF89YlYB7EFIHJHKhP
	cS50OyW2YEqCfXAqOeXUPbnVGOOW7SWHECzsDcTk2FTdWM9mTo+BZHH9LhhRGvo0AUsiO/zOkVy
	3qaqY0UB++oYun6Y0sTuiOcubcRRkmrIXQWPDxtgvMZJ4Xyiq9/w8cyzwL0k2tFt/92lkt/X93M
	gSv17xz8twdhA4R220BOZuQelXceD5C4as7Zi9YKMYQc7mhqZAsthric8yccMXD1w6h1sVSSk2L
	Jg+/I9EuAhoG8dzdVmoEMwYeqM+JkVtgkgjeimQ1Xv3OG3QwDyr6i5OpvvUKpAE/YI7/BZC+Ffq
	EDmHkUwZqEj4oxfOKndGVOppSO5tqII5PwupuqIUOquLBiZhWbN2e1aet2JNbV9AsAOrk17ZSDo
	/jJbwCI1iV0DDDbspsdEgdFZC9+M0Lv9Hg7ysrg7YckvN3sh5C5c+L6Y1AtHx2UQ4E4blNqFICm
	h2t1iPS2feEagD7nJmtwWg70/kRxZnMsAs8JXMga09N7itmJpI2lJ4qwnBU3n8Au2
X-Received: by 2002:a17:902:f612:b0:2ed:18cc:d3a4 with SMTP id d9443c01a7336-2ed83784326mr1769335ad.46.1794096747574;
        Sat, 07 Nov 2026 16:12:27 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([203.94.55.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81712282sm614905ad.50.2026.11.07.16.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:12:25 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>,
	Brenton Simpson <appsforartists@google.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: sony: fix sleeping in atomic context in RB3 Pro raw event handler
Date: Sun,  8 Nov 2026 13:10:58 +1300
Message-ID: <20261108001057.29776-2-sanjay.govind9@gmail.com>
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

Rock Band 3 Pro instruments only send navigation reports until they
receive a magic SET_REPORT feature request. When such a report is seen,
rb3_pro_instrument_raw_event() sends that request directly through
rb3_pro_instrument_enable_full_report(), which does a GFP_KERNEL
allocation and a synchronous hid_hw_raw_request().

The raw event handler is called from the URB completion handler in
softirq context, and on USB hid_hw_raw_request() ends up in
usb_control_msg(), which sleeps. Plugging in an RB3 Pro instrument
therefore triggers:

  BUG: scheduling while atomic
  ...
  softirq: huh, entered softirq 0 HI ... preempt_count 101, exited with 0

This was reported on a Mustang guitar (12ba:2430).

Move the request to process context by registering
rb3_pro_instrument_enable_full_report() as the send_output_report
callback of the existing state worker. The raw event handler now only
schedules the work, keeping the 8 second rate limit. The state worker
is already cancelled by sony_cleanup() on remove and on probe failure,
and sony_schedule_work() is a no-op once cancellation has started, so
no new teardown is needed.

Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---

Notes:
    Reproduced and tested with a Santroller device emulating a 12ba:2430
    guitar: without the fix, 'BUG: scheduling while atomic' is logged every
    8 seconds; with the fix no more warnings are logged.
    
    The fix and changelog were written with the help of an AI coding
    assistant (Claude Opus 5.5).

 drivers/hid/hid-sony.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 50f5ad6bbeb4..9ee175f9e58d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -630,7 +630,7 @@ static int ghl_init_urb(struct sony_sc *sc, struct usb_device *usbdev,
  * Sending HID_REQ_SET_REPORT enables the full report. Without this
  * Rock Band 3 Pro instruments only report navigation events
  */
-static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
+static void rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
 {
 	struct hid_device *hdev = sc->hdev;
 	static const u8 report[] = { 0x00, 0xE9, 0x00, 0x89, 0x1B,
@@ -647,14 +647,14 @@ static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
 
 	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
 	if (!buf)
-		return -ENOMEM;
+		return;
 
 	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(report),
 				  HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		hid_dbg(hdev, "failed to enable full report: %d\n", ret);
 
 	kfree(buf);
-
-	return ret;
 }
 
 static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -1098,10 +1098,10 @@ static int rb3_pro_instrument_raw_event(struct sony_sc *sc, u8 *rd, int size)
 	if (size < 25 || rd[24] != 0x02)
 		return 0;
 
-	/* Only attempt to enable full report every 8 seconds */
+	/* Only attempt to enable full report every 8 seconds, from the worker */
 	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
 		sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
-		rb3_pro_instrument_enable_full_report(sc);
+		sony_schedule_work(sc);
 	}
 
 	return 0;
@@ -2217,6 +2217,7 @@ static int sony_input_configured(struct hid_device *hdev,
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 
 		sony_init_raw_event_handler(sc, rb3_pro_instrument_raw_event);
+		sony_init_output_report(sc, rb3_pro_instrument_enable_full_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
-- 
2.56.0

