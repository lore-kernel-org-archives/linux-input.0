Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD622192F9
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653871; cv=none; b=FXADR3QXNieshWeLYmvK84ywuMtzyTKn2LsNdalBFh/mgsHS7a+nFtpb1lPDH7/kK9NXqOhobAjGVC9JTP1g6YQM5PgDG9YMwRfDGgkJ6tUTdO8ZU0LiX13Z9GMTA+aRRBwEmTdC/KeLHne85KPeH33GjBXTBwKZ19I8eShRXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653871; c=relaxed/simple;
	bh=/43KOMS60rSwqm+0h6nol2XjGbfCzZZdtTRs+CP2OHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EARTzTwoYVu3/tS/8PdX3CvjAcpw4wCwwmePth+h6wBo3GB6PFByzrg/Sr1V4quL9FlThpNtqyiQWC5VJS87ulgsGe4k3Uh37GnzOwNeViolGHBn59W5FClqPXEYqYpiPvmsQyJ1UvakOTLCuiVutgv0x77BFzR7HmF9DSYkMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzMVeBY7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzMVeBY7"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38f620399a0so3962924a91.2
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653869; x=1788258669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHxpkdrH+ub77zWOCs0hPYLKcUBXeDslDiRjI02XCqo=;
        b=lzMVeBY7ckKUw+lV86tD3L71zaIJ/Z57diaQeYEgxLGIRKI5D+c5mjrME41KzKlzd7
         Qs/bHGeKdWMP7B+Y4AFAx59kKmOz/z+BXqQbmJ/+3++5pgnhT4vB0HNt91/tinmsIMZW
         1tSZghtynl0YRTkue9AKua82u15EW1PhoVRb7t4dMLn+N4Lc6g1RPkb/6/0XTreM0LqN
         nDfG3KkYVlIP6Wz6oFevQrC/hoh3jTLmEjZWkOgsPvY5JDM/3TpKyYcniwpU3H8v3mPs
         jFkem+AKvf52JxOaUSLOFLs37sPOqcbKoCrFzCaCDPy1rcO5r7vSlmEcAOPoZYtgOKri
         m85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653869; x=1788258669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHxpkdrH+ub77zWOCs0hPYLKcUBXeDslDiRjI02XCqo=;
        b=NHTmBWlohQeZ8qLj/C+2P0GardrRx/jAWuR0pQrp14Aky9NgBqM1UrHEaHmGLapTA+
         klVvJ9kmxOKJb8wUKnIOS7FjihYarsMFyj0GiCTnonHRywDbGt65C6yZtJo1+SidI+gr
         SuAgRz1SMle56nt9daR7RJSv4X2bx4lF+1dnvBVVf+Vaw1IB4qUWblOeZrPh0wwDnfhY
         gC7QJ035Qud7NWJoARukuiwdTCJphLEfH8HZTLSQSOuoJf+Rosuq4KHnQVIbIeH987Bh
         RV6IHlpZ3IC28Biei6W8RNcIHTj536r2Nn6kDsAdSgRMZlmUNCQt4RNp3iDBmp0JTjOy
         ChHQ==
X-Gm-Message-State: AFuF++nxChiHzXFFoiA3Qa+SCgKDWrnXabIRSQtyYZJ+t90Uj3Gfn0GC
	3pTLXXsWGtaExMaofBrE7U1u77etmkSA+ajiGgRCwdXHCe8hqmX3ou71
X-Gm-Gg: AR+sD10jlakp7yUZzEhEKK5AA/Y0Y3H2QVBQbaIH6+wVnsCYxlgIqpP1ZuVo9TNKIdJ
	8D9mc6qtBvKl1ms78POBAhaAVRMT970Sdg5OmI+XLnnDbS1pid5eQnN4WqlYhXnc/ei5u2zXY50
	yHgzXnfM7IrxdQbewc9NHlV83+20NCCQYXSJaOzxzHCFhzGAuTobrymCSAZYbGcOtM0+eu4eFoq
	lDK7iO1KlVFYp8k6oc4Ye3BIM+TPIwQ1jp9/48l8JEJDY/OD2qZxqn2j3vst1HVmmLoUBJBu9AV
	cz+NDl6CCDRneQi8jNQIx3/1tjZ3/ZmpPKOdvph7YYkxmbBtxZn0VijQn9TwnFCu7/aMuQ10puG
	RgRToz0lvQr3BZVVArgX24cAbyWBpLfUiGEvXDc4l6NjUBuhmeX0Muo0FgtMhg5HtTJLnunyb09
	kgNY5/I8gwhBVQCGcDi9o/2D14glcaFx+Snq1RT9dBeivEZ6qcY8KzkiXFJHpFcIIvf601Bf299
	gl9t/IJWlUI8sKbAMUsJUGQTbpT9Qul9NzbKfqhlj9/2F6es7X08DV0L7SKdJv8Hie+89YIprIm
	LRtQJLLDs9PtYYH/+CPKAeD9
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr56047468a91.2.1787653869085;
        Tue, 25 Aug 2026 03:31:09 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b17ebasm3358068a91.4.2026.08.25.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:08 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Tue, 25 Aug 2026 18:31:03 +0800
Message-ID: <20260825103104.12090-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
field->maxusage) but indexes the report bits by j * report_size:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

In hid_add_field() the usage array is sized max(usage_index,
report_count), so field->maxusage can be far larger than report_count
when a descriptor lists more usages than its Report Count.  A field
declaring Usage Minimum 0 / Usage Maximum 0x2ffe with Report Count 1
gives maxusage == 12288 while the field's bit region is only 8 bits
wide.  The extract at j == 12287 then reads bit offset 12287 * 8, i.e.
byte 12287 of raw_data + 1, roughly 12 KB past a 2-byte received
report.  __extract() performs no bounds check.

The value read that way is stored into wacom_wac->serial[0] and can be
emitted to userspace as an MSC_SERIAL event by wacom_wac_pen_report(),
so this is an information disclosure and not just an out-of-bounds
read.  A malicious device only has to claim vendor id 0x056a for
hid_scan_report() to place it in HID_GROUP_WACOM and have this driver
bound to it, and a single crafted input report is enough to trigger the
read.

Clamp the inner loop to the field's actual report region with
min(maxusage, report_count), so usages that have no report data behind
them are no longer extracted.

Verified on v6.12.104, whose wacom_sys.c is identical to mainline here,
with a UHID reproducer and with an emulated USB device (raw-gadget): a
hardware watchpoint on wacom_wac->serial[0] fires with an out-of-bounds
heap byte while a 2-byte report is being processed, and no longer fires
once the loop is clamped.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - No code change: the diff is identical to v1.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.

The reproducer is available on request.

Compile-tested on bd5f485f3f02, x86_64 defconfig + CONFIG_HID_WACOM=y.

v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweijie@gmail.com/

 drivers/hid/wacom_sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..1ea8763b68a8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+		unsigned int count = min(field->maxusage, field->report_count);
+
+		for (j = 0; j < count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;
-- 
2.43.0

