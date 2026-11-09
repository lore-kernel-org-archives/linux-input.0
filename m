Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204420;
	b=dYHnkQqCKEpenfSdUKcr7T8oX5tbsPLgtMBATw72MyZmHJTaGkQzuIb9GkmlOOc46J45
	 SsKyS4RHQlgluBlxk3+9CQmyWrQjCNQp1SoHCrupFlnZWQpBc1+NsVbB8PMBur4le3XJ0
	 h1GptY6hwAm5xb8Vx6gmKzkoWfS2yfgKYcTspgNQ7vh/kPZQhli5klONQiu2sfgE4MYIf
	 AKyQh2jxMS50KDx94sy1AKlOR266ZdpFFMD+f8iFz9nmn3/7pKhZyAyDoG0IVA/Ktax9c
	 154MqE9ghFvdyVxk1kxzWRyTklVHi9ODElUEzTW88aGp/pgDSy655fCFDoak5iyVpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
	b=VdQvCyvU1ozfbb6lXLTPJF4OGTsV0FPX9/WAC7dQoiMA1PrFa1VPLWziyrDhd4Oe9+/I
	 wvE/FedgV6h2CzWYYkOPNmxGWLkgIJX4TdSnh/Y2lVDCTlOHB1IBIXMbNYErEOjd8XUuh
	 erMaczTECy0aDAPPoqcuHMbMso8GarEcPQZsuaZNaQ8/458ATGH6VL6cpFKzaHb4lqa5M
	 bHF3pwMFm1Eym3L1/rOh3np61Gz+tpEuqfThDNFXjYSU0Ygn2dtTTcfHkkM9xhHni8TZk
	 RazmTZ2PZzJBy0/mcL5G2jA6VhpwjHYt10Smej2TuCKzJbME4Gmbbf2PByM5ujHoKuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDeq9vm0;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE491606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE491606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDeq9vm0
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1225740eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204419; x=1794809219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
        b=PDeq9vm01rgqhK9bmX/OE7GH1VuLm23QvDHZcZASR1CG5FzPfl69ejROO6OSHTh5Av
         +146DoFfzA/7XNgUDpLF/6NUKyTahSnPOykgCDIqcxGxt8mcJiZ0LPp2rpeZGlY9o1ay
         nSw1hL+32akar+tBTnv/C45ZN20l50zUOa0W5s4DIAGmRjlMAFUGJ519y1/FobQY1lIS
         OMZt32c9RwhrUG22nzMvhoGWT0mHGpfTyb2dnxNM3L1AL/qRTNDMNxPHo7EhLcGC0MAZ
         5aqyvWG8UhY+58BvW8FbrGKqJepydJpUrq7yoYvR8i9KSGbKtbJU6QHsTn6JEsci+zdG
         0iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204419; x=1794809219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
        b=ScXhhQK67MynOOpIRrWSesmhNrBY3/GURQzXwEM/mSJg07ZF6LiiIitvWxfDBXwNbv
         5RuhM2T9j+TDYMVZhQ2J7WUCZFPfuUEFV+8zXbpP/qdYVRbJTUMfCmlP6p/fV765e8T7
         lY0t5GlLrKoxFTrzTNm8Rs3rimzNX0+7QYyGqEfVc3cG5fQYSjGnU0Wcw3QltfqxwIGC
         32uuLueosoo+QmZqsUV7eWpwLOcQaMqOxTgFk2ZGPYP7ZXjATHtR6tL1VHftoMhaYfep
         HFWnFJyqpeIV3SR2vinsoJYY8qU1jyjIZiML4TITKGiWg72LgD6zWZILn0Bnd+0G3OfI
         RWWQ==
X-Forwarded-Encrypted: i=1; AL+hErHBZlrM+HbWq1K6fOEdsGRMZFMt+q4RhJ7nQwlA0ZMddXkZvv4olbkVye75R2WvDmH7hKfOZyNqXgB0ng==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fl17QCRrmKGweeAM13W779YJOjDmxp0XeMGg6l240LooJZucO
	qWDEL0+hmQRge1SdNqMisLrbkWvM6/0BXBYIOJpdhqbdLeKXwPrl/sP9
X-Gm-Gg: AYBFou0ynMIEvBAWH9rgpr2l+S05rXCpXptNB5LjpuNcl1vNbdomNiOb5gtSm4nCflc
	MNRD8XLlQWsGLaTnWdyTWEeOWykuAaBcsj1FcLkENQx6c9usgQlG6FngYp4fbbGlEGgo8hIzKBW
	7olMl+Y+l2o3ld0aM1tCeGYXcMs8fuxN83VQUwlOYVaNDi07yox6vSBeEnsXtrc9XpcdU2ezHda
	NBcbN8hnqlE3xifHW6tCLAAXv+cBFOYqbxp2m/+4u0GKTNmUGDA5OESaxxHkM/RnK6ULeHXyuX6
	LHYCeVfxXLc7H1XUB+UEOu5Z7thRmYpB2PirxCqSGLs+HiINgpT6KnAeGGRwYsjueue0YNKuq+S
	2xLSAwgtctWIOTFv2oABXEsNq2z6BvXXruW5BRu0HTk8i0w/3hJA3019MQ2c5AOPzKfIu5FyPGb
	mVs4VkAFvIBfDUm5J4sbTdI+VSnJ/KV9jV0ku5aR+81wGfhxOZD4rpOuKYW2LaYqPAKm9alZNaB
	HGFaOKv7Om1ErlpkpkwIJJASG3DzsoC3a2gBi+Ug+1HzugpBRmZPCudOyMtQgNUgaQP8438YXjU
	Xi3wJTBk3XSDnNCFhqFeq9vQx1WznsRwcv4g5ff9nEJm/aOA
X-Received: by 2002:a05:7300:6a9c:b0:358:3426:d601 with SMTP id 5a478bee46e88-3725b461998mr5714163eec.2.1794204418800;
        Sun, 08 Nov 2026 22:06:58 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10754270eec.4.2026.11.08.22.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:06:58 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] HID: microsoft: fix use-after-free of ff_worker on teardown
Date: Mon,  9 Nov 2026 15:06:33 +0900
Message-ID: <20261109060633.1231417-1-hj351016@gmail.com>
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
report; ms (and ms->output_report_dmabuf) is devm-allocated and freed
after ms_remove() returns, and the work was never cancelled on teardown,
so ms_ff_worker() could run against freed memory.

hid_hw_stop() in ms_remove() unregisters the input device, whose teardown
(input_ff_flush() -> ms_play_effect()) re-queues ff_worker, and a work
left running after ll_driver->stop() would also issue an output report on
an already-stopped transport. Disable the work with disable_work_sync()
*before* hid_hw_stop(), so it is drained while the transport is still live
and cannot be re-queued during teardown.

ff_worker was only INIT_WORK()'d in ms_input_configured() for
force-feedback devices, so initialise it unconditionally in ms_probe()
(making disable_work_sync() always valid) and also disable it on the
hid_hw_start() error path, whose unwind can likewise schedule it.

Not runtime-tested (requires MS force-feedback hardware).

Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493a6141..5e4218beec92 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -335,7 +335,6 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
 		return 0;
 
 	ms->hdev = hdev;
-	INIT_WORK(&ms->ff_worker, ms_ff_worker);
 
 	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
 						sizeof(struct xb1s_ff_report),
@@ -361,6 +360,13 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hid_set_drvdata(hdev, ms);
 
+	/* ff_worker can be scheduled from input_ff_flush() during a failed
+	 * hid_hw_start() unwind and on removal, so initialise it
+	 * unconditionally before hid_hw_start() rather than only for
+	 * force-feedback devices in ms_input_configured().
+	 */
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
@@ -377,6 +383,7 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				HID_CONNECT_HIDINPUT_FORCE : 0));
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		disable_work_sync(&ms->ff_worker);
 		return ret;
 	}
 
@@ -384,6 +391,16 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	/*
+	 * hid_hw_stop() tears down the input device, whose input_ff_flush()
+	 * -> ms_play_effect() path re-queues ff_worker, and a work still
+	 * running after ll_driver->stop() would issue an output report on a
+	 * stopped transport.  Disable the work first so it is drained while
+	 * the transport is live and cannot be re-queued during teardown.
+	 */
+	disable_work_sync(&ms->ff_worker);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

