Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285005;
	b=SmPNyI1G85Wqx1WiawXAMwTWzMMFpheAxM7psljhogInQvlv/sQyJsQbEKbXFxaMFNfO
	 TbQ8trGsGHKNPGNQG3aZdQMSkEvX1XNNic17dv4r8LN5zjpbjbyH+GohVAvtS8BmRgvz6
	 FAhhjWE/o9oAmuUxUMtv0MZdn6ZCrTxViLlQhaBRGJfL5ROm9IyXAmh6mH/i6J3LG2yP5
	 VbbfLBf25Bo0Zd401xWNET594eSYBYR65SG+YSd+TVGkSMRRaCopypwUE2MsnLCHKyjJX
	 DgFeuNyO6fhMdp/fTFyRcACihFET3AIYPjy4t3LPAY1VkylCHLNyZfDWjkMD3D/d1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=stxCnrlGC2A4AcV24vYYzmqcDrFf7sMGldsWecvMla0=;
	b=G7/s8mTkadqel3USUgEVwxpzmTsfCjNN7F9l4+3nac+3bO/KT4H/QAH55rL/Kurfwpp3
	 dJntqbdp807FqcvMTk3JmvaH0yiX/NF+kJocvzlSipr2tjWqJ2lEOSL9otAwH8Sp80kRR
	 4TfEmsQuTKkSWf7+/hb588GE172Yk2oD35/GGiAdvstNlQL63Q4xcC/2wiGl54+J8G0LW
	 3ZY8/rk0Tg8i0gHgUoIZ7niUdL2jmck2+ySRQjbe3Fete3vQpBWHfFhdsGMFxr5294b4x
	 hr8+ROvBWQdP1fLxlXbuG0VCuIePLzBNiFhu6klN6Pez3ICgagfcSO7G9W67tz4c5kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYmDBB+e;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4E606A326
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYmDBB+e
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53665358476so15231071cf.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 20:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285004; x=1794889804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=stxCnrlGC2A4AcV24vYYzmqcDrFf7sMGldsWecvMla0=;
        b=nYmDBB+e2zfOChsZe2iLOKg2FPKLIJNpck+WFm4vCEJ/ef1hnNs8QkFka3ynthr63F
         XkwSDVUzJGTtRKa9ISBP+st+PuxJDVkmiReawGH6EbqP3guYafPvURfWj4NKl5EFrzrj
         N1Hn+gS81a+aOmqtFusyfiZVtWq8JM2Lr4djeSL8gK0OVZ0w3lZoVONXEX6bM7swBqCI
         P5zdgv10O3qxD1/R8L8KFucKU5GH+3BFa3eTdH5JzGjv7Y4pjAqWse7JEMKVtpPo4Jo5
         kVe2f75kDhj2ihNcHbD5iaglHiinfEul4e9qSjYiEQ2KvyF3mMQu7LeSMJT+D1p0RTH5
         zN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285004; x=1794889804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stxCnrlGC2A4AcV24vYYzmqcDrFf7sMGldsWecvMla0=;
        b=J/PmgKdxsb2cYNM8gw1rr8fihQkjyEAlrQsjUu+fH48u7PBj5Gc/Y8a1kUwfs7Exj4
         tGMxbrzu86DF4px9gsFecRO0ourf3Kj8lTnpuwsKTN38CDnHLksaJCNQLMRRPzeMT3i6
         1N3UEf1cnkVPt87eNQWPutvhOl6YLD/GHuh/bJgfdH1mpWUhH6VMdezVivE42HQJy9Wt
         iRP5PtaRSLX7Edj17h7jRY4QFdW/og21iJR/xMrGPRi1fzReYvUND0bD4MDNifCNSTTs
         fjJt0vVF5BBeI2s/e3p1aTRA6FzPOgC/iOo6+Bl2DgcWpeGPxKGlbtCzHmkWGtERF1cX
         Bjzw==
X-Gm-Message-State: APuU4Z/NzsSX2KOKvpC6DX3gzXFk1AFCyjNlxhj8G3vt5aFZuC0AWe0m
	b6/WsLkHaiIn4Hd3HKwBmr6ne4iYf70KI+uGD3p6pvh1AGiLf3V0fo4=
X-Gm-Gg: AYBFou1/djBBD2UCzWGxDnIayaftypdYLMmaReT/f8foCUcFAMLj2eX3DIK8JHKbr9m
	DH/QhR3jf0z0vEolX3/moNl2Cxjkm18fBsgcd3opBqDjjFavDGQZAJtpIT4j8WwO4GLOUnaiTwV
	+089P1A6jmWo6+O55owhcKaAfrgscCu6T0bg9QDi2wo4fuMflqsR+s0CZWXF0KRWkOp0Ff41ofu
	JJfIpxlbK53pLev4he/px+kQqXMrsT8FGGhsI2JU+hBimsh6CxBzFvW0vMIbCeNyCd1EYH71XRM
	phE03dMKp8jUEnPkpGMK67rB4W8Pp81hXoskxvNPPR0nEh7ltV8RNztTXZVVB2ZZN1txJb/A5+w
	xau+hrGrTOB9BmOM64MvImQl8w2Bp/hWDQfGSSNPQrOtoYPc2HQ3SpYg4ligrA/mRnNaSNsfTNW
	GpEXLdlE+tCN5z1ToK/G/zN0h4Xm3ScT7lqZlERpQjAG4CSpJ9zAGaPfngL/XBYxRT+3wX4cS1G
	NmmlhwxT05EGtNW07u+lMYIve83eOCj4DocJGLKwVFTHrZQv6F/BXA4F4dkUlWMU9G6OU9Qabko
	iTIq7AG9j0owifc/A7oZyzqdAQgJG0Tp5OZSk5u2ovQA/KvbysGoAa9XIUARQ+s0ZbG5Vq4luYx
	BqNsLl9asuO3jKBuxn0yCsr7WY/iG0T6CZbUfg2GhsVsrF8xAtnvFnkmclKZs47rt
X-Received: by 2002:ac8:5f12:0:b0:536:8843:c2bf with SMTP id d75a77b69052e-5552a76da88mr20758921cf.67.1794285003678;
        Mon, 09 Nov 2026 20:30:03 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b44e6fcsm14363231cf.10.2026.11.09.20.30.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:03 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] HID: magicmouse: disable the multitouch work on removal
Date: Mon,  9 Nov 2026 23:30:01 -0500
Message-ID: <20261110043001.56615-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

During USB runtime reset-resume, usbhid can call magicmouse_reset_resume()
without serialization against HID driver unbind. The USB interface
remains bound to usbhid, so this callback can queue msc->work after
magicmouse_remove() cancels it. The delayed work can then run after
devres frees msc.

Use disable_delayed_work_sync() to drain the work and reject later
queueing. Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 4253fe22b137 ("HID: magicmouse: re-enable multitouch after reset-resume")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index a01e84a18ded..525ffc64a2f0 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -1032,7 +1032,7 @@ static void magicmouse_remove(struct hid_device *hdev)
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 
 	if (msc) {
-		cancel_delayed_work_sync(&msc->work);
+		disable_delayed_work_sync(&msc->work);
 		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
 		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
 			timer_delete_sync(&msc->battery_timer);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

