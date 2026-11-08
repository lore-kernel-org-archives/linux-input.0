Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145114;
	b=RPa5Vu9jUI4W06OL70oyP6n6FdFhX6n0Rz3xItQsO8GE8eXawhR083GAvirlxAOmBcM4
	 tHqBungiVhR4es57xSW5HSAC/EucYAYOS+MjQc8/q4o6aUk8ra1AuOHT8bw9W/NJHO537
	 4zNNUSxqp07EjzYQJlHmtDxanwskwja9BKem6KUoIncp5ODQ11tpT9OqNT+RA2/n4DCne
	 MaLCMLAwpXBDv3jNK6EC0u24A77e4S6l85dlgZoOm+MDm1HgIH5azi2X/XvRskVPrYw9T
	 YRWufPtznrDRp0z0EfbUvMagG/MKzv25eF6zBkZN+wwUxjUb+x+uPzZMlX+n/2eGE/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
	b=FMeCT5M1WbdI6VzfcdiD5+id48KioasI+WaKhnibPP003YbsZPRUHwKwUcdZKSkAhm3g
	 81xLZHVabg5W3Dsnq3dncb6xJi8Th1U7SF5uKicsTBNx8cBY3CJQ9GnXWk0L6XJLmSVgL
	 3ZDlafXki+Fhvy1CU/Fdbk4sst45TN9WL63luZrtvvQh5cM34ZqHh/wS2ZeXN3ociGpBB
	 9g1sJxNJMu02hUI5Ne0XM/pBrqexXuZnW529xeAZBwYbvNrzl7vgBh0HAEmbpsD31XpXo
	 Y+qOnbj7fDWxnFQkhnXlf1wmh95e89xPlL7iDVHARS+A8aUB6s5N2qn8Ob1xNuNYXnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OndAluFL;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E58606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 13:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E58606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OndAluFL
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso156929c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145112; x=1794749912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
        b=OndAluFLYQ0ImKAKq1jHnVrqGsXubi2j/NdImWBrrb5hYsZFLTPTaGF3DKFkO/tcoS
         t2DV+AWof8yg+skrFd5sosrJQe/T3NtDsYBQdeg9ivuLcShfR6LGmS93ycc7SvKPKFqk
         vkVtgwCZJKSPUFnUvCIKh7O8Skj5BgOCOcp+BgEtbhXACxwMgwt0KfdjBuWKqcOy2TkJ
         9vVupA1eEDOOuOCOm9dtdIhGZef+5X9gFVBrCdXv7Rvb8y0hH/BhAlQGfxop7xAEPHR/
         wVQvoDCqUZGPEiEzvRXXJ+oVxWrDA1ODwzL8XCbUjZHdHwwMcfbuyHYSq8Hb//WEkqsM
         aAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145112; x=1794749912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxFXA2A8vf97MLqDI2dXStFoDohf1oeX4s7Z28iiyTE=;
        b=T934c3aOHTNuJFADpHx0OeodcVtfQiS+8x8NUwU4oWFYVRBHUgrszBfQDHPns2xwnv
         Z/OgqpzDsK6HmwLxlRh+hvGVXHf7SOOvxdWEvrvEJh33kmlavevY1+fN9woRVRbf5pDX
         14p4AF7+4QoK935Qvqm0QSxxeaQSsMG4jheKQJdW4rQbrYt9T53gjiFwzLQuvS3P3nhi
         qOyJ/AVrLT8/oeh0OEiGFWRhW17wCGBL25e/deBznnF/YnsdEgSnhfaW/OvUydSACfgd
         UjZCe+SGkMSDna4U1J9HTbPc7IICGATdcyTHgh456Fkwyf1ULClZyjEaNm8eonKWPB3g
         tRGg==
X-Forwarded-Encrypted: i=1; AL+hErG1R9t1+LbL6JD5nht8IHdG/ufh0OudHzmrvhz8FcgGAszDh/Tl77tkMZmrWtoY4bd3/Ho+fP8hABPKwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bzvsc7yrEJbt1uMBxdNGwoxG1rTi6lMCHAlf+2ZzTBLZWMROO
	7535I358jwv+iJaFr3GV8Ym7S5PV4yawpGZ+rKqoHNplvp8LIh0HYrny
X-Gm-Gg: AYBFou39wj9gd3pN0VAlCwvDd9yeRMmKiLkrfx1csD2SUMLJ50LI9djpJr8sAZnQrXR
	WTwQ6QN6MED8e5CEB9RS81aL/B0dsAQ8KsdEUMQSOPuqBFIytnKqlehP1xg7jcrWWFCu8ANBBrp
	dwsk7zDHDhxZnAgs7RdvAPUS0vc9SA+tn9qrNXvwVGC0q+bb5UifNe3+d9nKq6OMfTj83UXqUd4
	qEVJTqU3luG3eixYgUcZ5mEFwuOz8UAd2FVBn6MWyC5YqYpHsQurSadAwtzmLs0xQU8IEI0lu+A
	DUMkrW19viX3S2vrbLopg7RpWmlpKQrUbkR97q0EWAbEI58UXzAJQShuc1sgFw4FjeLSM9xxJjh
	B5nxJymfGWPcBGJstQcZRY6HaQOXketdiMjfDZ3Dz/0Vmo5s3WsFkEZUSUsgCuAPO0YES8uKcer
	nEQw3h36sybS0UNM29GQPxArtvlsEbAMFYKFchGjPZTdK8EkKXb1HskAS92HD66w3XDrG3E5WwG
	vSqIixtreucPF5InVStAyMGGaeCviwkQ1dIIxDRotGyo0pHpzS77x3XGk4kZN6MkTNp41FwnO4q
	59Iz3Am4izgoeFbnp998xKAT3N8LsVvOXlKXPxHAOTen5bXVv/OZyPXyeRwLr9BiXySuLA==
X-Received: by 2002:a05:7022:5f1b:b0:1b1:251f:d732 with SMTP id a92af1059eb24-1b39fea9b18mr2244971c88.31.1794145111975;
        Sun, 08 Nov 2026 05:38:31 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37561ccabsm5515696c88.12.2026.11.08.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:38:30 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] HID: microsoft: cancel ff_worker on remove to avoid use-after-free
Date: Sun,  8 Nov 2026 22:38:21 +0900
Message-ID: <20261108133821.535139-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

ms_play_effect() schedules ms->ff_worker to send the force-feedback
report. ms is devm-allocated, so it is freed only after ms_remove()
returns. Commit 1cfc77a64b71 ("HID: microsoft: move FF initialization
to .input_configured()") dropped the cancel_work_sync(&ms->ff_worker)
call that the remove path previously had, so an ff_worker scheduled just
before the device goes away can still run after ms (and ms->hdev,
ms->output_report_dmabuf) has been freed -- a use-after-free.

Cancel ff_worker before hid_hw_stop() in ms_remove(), restoring the
teardown the driver had before the FF-init rework (and matching
hid-bigbenff). cancel_work_sync() is safe even if ff_worker was never
initialized: ms is zero-allocated, so the work reads as idle.

Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/hid/hid-microsoft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493..462fdaf 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -384,6 +384,9 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	cancel_work_sync(&ms->ff_worker);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

