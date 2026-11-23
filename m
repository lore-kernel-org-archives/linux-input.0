Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407675;
	b=JtzLGJoyneoi6LHpWHNbqV+tHh1374nC4HxpmpFVgfvpRBEfAx8V8eRF4GZ+6ckA+ctb
	 9Gy9qOKZEoCaJpmBUa4j77sgHxy4ILUNDLwSKlNfDGqpoKRkNe6GnQzOqnx2IVpWyzsJt
	 5r68B3vpzYvViaRtofQdGB/jXZcpDbPzS/KOLHBATIQtnAOSkOfrSxuHAFDV2JFrun48t
	 GyShY5hP2fuzkjNR9aWkd5SEjOFXaHLL0eNTMqZka6ICSYBA8+7FG1Q7VZ4pawQEbyhYf
	 PP3sOra0rbWedEV7ZqB3Re5hsTVVWYaHB9cAta78RJV12W1Sd2aKeQZpxbbYtVLQ6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
	b=RkEfX6lfM4Ijxh+aghCj/a0EJGqPY8MqGKRJF2Vnw/l4WRIEhGxQ8gvSA6yL7F466jnh
	 pmVmFlQNFQTfr7DAojj4oKqIFI/WOwfJpM3dbQzBRIDzYfReY2ir3za8XXB55oAoOE7i4
	 K6P/TT8uCQnfjOXh38aUjLQpuqVkb9n99+umVBtH8c8oDGEg8dEkOoW5hgEOfC/yRpspW
	 S9SGhtO3lsej6FpSULJj3txhBVU7N9hxx+trR95bJ1yhT/lADHaFHph9hWvfqrmp1i7UG
	 VLWz5NukBN0QlVwQwocRU/mzM1tQrm7g5SB9+/b7NKPiBP55z8VPyxe2QRSV9TF3e6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a++1msNE;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF47606A684
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF47606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a++1msNE
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-382f4710a17so4915091eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407673; x=1796012473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
        b=a++1msNELjCBBUe4+xupGZNZ5/B5lHc/WI64n3cKoQyuZ+DdaEzNCqqoEfsqjKW3ug
         oM5i0Hz/l/CE0JS+wgWSBzk2nFPJftbQdAmPflY+lx5Xi69nr9Tw/m4sSRWWP4/Fztu+
         IcrMwIbyQ4cifeRYBV9WWYSgJyyBKiGkcz0B6JYueIjMzR46nf5uqYq9lsS8tJRhubxS
         t/wSWFBDbsSMr9mf6yz62c9/7bHLrjIK4/it6PBuEKKDV3DWcZB/OwjCe/npE6bW/kbh
         8G1NhZIzQERmeGN/XvSQtymJkMCEa1Fe/pIxPyJTcIBk3s449y3rgxsNOFImGXqqY7Bg
         OM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407673; x=1796012473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lcAY4q+qNuXrOlRujle6G1kafferflNNP255tdpCqI=;
        b=c1YWQtTdbT/cyxjbVvi/TiyLSNmNGgaM23BU0VeKgn739S2N3yRJdrx1g/aOsGEDnm
         5QP0K1e4nlj/UWcd3ZODZDhpW50yhjk3FQlorzbg7Im8c3w1sHpf1S8EqV+F6rQGSUgS
         fL4YQy0igWWLt9+Lxkpy/gm737oPvHUBzX/VcWi8LrciiCqkPPv5/D4PNTabiL+/eghw
         zRIbLsHm6QQ2kZACXPPkwNvGnbtWSK/qVtFK87+wMpgdeFQ0lSLpbEqca0qknxDhnFd0
         tpuF7X1HmaaUi779cvCpj4uwSpVX7QZS97+9DnmpTWl1atqj8DHF4vHtC7gcmg+o0Z/+
         M35Q==
X-Forwarded-Encrypted: i=1; AL+hErGw1dHkFWGafyH9Yu+FWWpdFtBIhK+31jwWNQIHhvOql5EUotwuH9XyCIB+LEiNCrrj94p9KetlpAeHkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8rVswgkrW/0GQS78wC+vkVPenb4zlPppGUZ+E0XSTAc/IB9bcg
	Xi8roNnNmhR3sf5lLJtSauloYkGlRAH7xM+C7++BvsG1q7Qv+ACb9K5x
X-Gm-Gg: AZFdTZcoQ4H/5vUm5dgeo8kArs2vKJqblGgWbm7Y2SHc16mz2Hk1hVVVlYFAQriELkj
	zL1L5fi1XmTcVUzeuQpffwBVCeuP/1cEAfYn1/j8UqdDtzUvgUeXsZ50A1+PFvcXLyL0nKX4XTP
	hKTJmFmjKpKF8FsokiaeabiIKU0nD3l9yWwYNvaYc4RbJ3F5dqgFyxdjtN+2ABMoEnpqzDKfSMk
	JAu7j87IlN9/ag8w1cR6Xotvbv4mHR8i8nVp/y2Iwz0xB3s2Oj9jIxAR7o+Hu8wTYnbTb4k2LgD
	RJRMmNCrqskZU9uCK0Tvs1DYsrVgVURSJtvN0GWEtXV3goB0YbDGrjJWeW7rml8pUnZ15W04ZN9
	Ah6fE82X0gSR0oYs8otlX3miL6gp5nlbuY1OFEaCTHcuKVDhhE09yOAgB2/bORKJ7nECLNwiV74
	OzF5kFVWQObd9mDMcn875OFpleM501NHNGLtkSwm5TOoRm0eVOBpblyd5DvcoabcB2C9b5TQsoo
	EQmL2/V3RE8gr6GpIiVnQu7DvavgT4RU4pujIbPWg2GJlQuehEpqvC4o1tv6kF66ednUk4hacsF
	m7HfnO4L5EUOvN1H6Hvz2v0+r+gSGioq/lnGIIZok7ZhMT1KzrysqVJLi1X6NiTDtktr5P0wg6R
	acXtvEpx2FGQLFZ8iSv5UUO5DKXc5rjYKfVBnETl+nHdlKyU=
X-Received: by 2002:a05:693c:65c5:b0:386:b5ce:4627 with SMTP id 5a478bee46e88-386b5ce496bmr502496eec.30.1795407673528;
        Sun, 22 Nov 2026 20:21:13 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:13 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Mon, 23 Nov 2026 04:20:15 +0000
Message-ID: <289785de10fffc66131938162155c1c3e3743a90.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index db8d3432dbd7..c48f957f8970 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1489,6 +1489,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1660,6 +1666,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3450,6 +3462,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.43.0

