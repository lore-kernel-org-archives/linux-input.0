Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0253F39C4
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867124; cv=none; b=WrbH45UAszeL6LUFN54ctLwimd4Y0gpIiOyY5iD/QC5OJEgmJ7VdJnvvWXR5UqS4HbM3ZRodZHmMYOB2uAv+8rag3G93LhdumivTMpHihUftsAcr7JwUJT3sN9/22Sfq9zY5QokapZZS+CxK4bSG68ufkYMznESxT7cPUdRP5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867124; c=relaxed/simple;
	bh=lY3mPCtu+bzXQAlyB+1PlAaCjNdyoD9LDvEgTeIHHrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7MhS86gZTBqSAPJ98Z61BI/jeDQkJstiRcyWP2E1Ws3fwPDoWFyNRuRwzWif3JNRwYfzzMkfwHU9a3Q14gZtjuewQEoKwr/4A1prhMIlQ1hJndkCS+1xu6X8IK52poxlgjWigkDMF2Zkhc8V56rNP21OgMRsI1BAdV/+dCVlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz3d/FVn; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz3d/FVn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f30a4601bbso86050eec.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778867121; x=1779471921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whvroEO+X7eMUK2dr+RVLAdwgnO7cj8qqzWq2UgbsyA=;
        b=Iz3d/FVnwTcUwLDSyofYWZ7gvneJjjbNLT7u0sa64WsHijUDLYcnjrz0fAylWQFJFn
         hLuf1J8k9XXjvSX58QXSybWao0s1Akcqsf0grFWug7e1MYE+Udk9Gj1pJH0jIagGIHCR
         yneUB8WMeQbaRjYeqI2H7t86F7VGLHschZATArOcLyJN1+nObeA2EcMHvrPveUBChbXa
         FaIaQx/x90/guFUxtxFuviVTnzPCcF/VD/3eYFpF0TpfhtYq3oRXkSVme8wGVPef0R2F
         tNL2Cf/z9J8UHUPMvpeBEUzK3ONEHcvBg2WbfjgXFFL+ef1VrOusoxZGYX/wdWQTkeLc
         TbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778867121; x=1779471921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whvroEO+X7eMUK2dr+RVLAdwgnO7cj8qqzWq2UgbsyA=;
        b=qRKbqlEO7HdHX1hebUFuWpUy10Yy++UBW1myAJEpBZ8QZd+zT0iVTqO1usZrb3qp3z
         qUPuChz+CgxtJcjQC0eXY0LunGrlG6hcT1vleh20baPyQInFiqJ4k3nVWpYUhIG3r5jV
         eKtJVRE3pzbtwxytm1njR6CW68OIIoCAUCzKzm0lSSS1r6i3syFLzTQpmfkMa6yvni+B
         36+lG7Qezn2XlGqrbEJFh0og4sC/SmPaebO/Rqjo1Kb1GTw0nuebAw5cKX3S0uQnTMXF
         ISrxtvKpI+QwIuKGYszx9oXoIVXHLN04tQegJCcz+/r/kQzBtziTHTQ6k7rgQfKRTao0
         Dg/A==
X-Gm-Message-State: AOJu0YzyiNlf4W1aIX8jREn0sY7h9+NM+OAvswuGWAQyDSIiFBSXZhch
	rMLVqkxZqNKyXvjfXHlPFjVknOSld4G+ZELHfT3FpkSi8hCV5NKOXd4y6IF+XWCA4r0=
X-Gm-Gg: Acq92OGxeryRP0GSl5L4WdpDdK4NxA/oQknYj3g2E5560jF8MsYWDEa1P49fBe401L1
	vRkGAEIT12INhQqnIC6iBjshZo4AFFTtPN6MBQ2lQQJQ3bc92AsegacrpgftflW5zKCOAbiqt08
	+1S9OxofIE7yLCcEliVEc1zmDsdQ4gaqBFWZ9w1MarG+gFYmMiABB7023uBm1WLn9Jyqzm8J9Sr
	lj5TJudV3wEnkGafrY9tz66pyqhix1PF3OgCadvoCv+yl+To119axzBsAzpd5PUX9LA0or9VP+E
	h+CncqX2d9xCytAr4DnW92y7SI7n4ReeY6R1ZaxM0eFMLp/IZM0t6hgHvxeydpXhdCaYOiZalUD
	2KkLYdEKHYBEw/ci6gLl0fQQI8DPJV4B2QOq0biyu04ZRvxIMb/RhDiLrPT4uXrwol1mGl37kDg
	MM0aWgJc0BeXtTxtiCLpaZH+K90Fm3rHBrRMiSe95S5az5JAFcr5GAcm3M222Bw+iHDQGYnMis0
	bDDnT+3/i2V91gU0oEqplKJZV/enCmBf6ETIJ5MQnAwiYgU7NR/u0kBJbPbamCBIRdo4G0rQAeC
	aI6AjYcGZKuka1p7LyT3aXmINZRO6B8=
X-Received: by 2002:a05:7301:688:b0:2e2:5bc5:f8eb with SMTP id 5a478bee46e88-303982c04demr2637806eec.9.1778867121023;
        Fri, 15 May 2026 10:45:21 -0700 (PDT)
Received: from lima-kernel-dev.google.com (ec2-13-52-214-175.us-west-1.compute.amazonaws.com. [13.52.214.175])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm8900318eec.5.2026.05.15.10.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:45:20 -0700 (PDT)
From: Manish Khadka <maskmemanish@gmail.com>
To: linux-input@vger.kernel.org
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()
Date: Fri, 15 May 2026 23:30:11 +0545
Message-ID: <20260515174511.78486-1-maskmemanish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515161830.E6E2BC2BCB3@smtp.kernel.org>
References: <20260515161830.E6E2BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_go_cfg_probe() initialises drvdata.go_cfg_setup and schedules it
to run 2 ms later:

    INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);
    schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2));

cfg_setup() dereferences drvdata.hdev to issue MCU command requests.
hid_go_cfg_remove() tears down sysfs and stops the HID device, but
never drains the delayed work.  If the device is unbound within the
2 ms scheduling delay (a probe failure rolling back via remove, or a
fast rmmod after probe), the work fires after hid_destroy_device()
has dropped its reference and released the underlying hdev struct,
leaving cfg_setup() with a stale drvdata.hdev pointer.

Mirror the sibling driver hid-lenovo-go-s.c, whose hid_gos_cfg_remove()
already calls cancel_delayed_work_sync() on its analogous work, and
drain go_cfg_setup at the top of hid_go_cfg_remove().  The cancel
must come before guard(mutex)(&drvdata.cfg_mutex) because cfg_setup()
acquires that mutex; reversing the order would deadlock.

Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
---

v1 -> v2:
  - Address Sashiko AI review feedback:
    * [Low] Correct the inaccurate description of how drvdata.hdev
      becomes stale.  hid_set_drvdata(hdev, NULL) only clears the
      per-hdev driver_data, not the global drvdata.hdev; the actual
      stale-pointer mechanism is hid_destroy_device()'s put_device()
      releasing the underlying hdev struct.  Commit message and the
      inline comment in hid_go_cfg_remove() are corrected accordingly.
  - The other six review points (ABBA deadlock with sysfs_remove_groups,
    global static drvdata corruption on multi-device/rebind, devm vs.
    explicit teardown race, probe error-path leaks, mcu_property_out
    unconditional return 0, schedule_delayed_work boolean misuse)
    are all valid pre-existing bugs in the driver but predate and are
    independent of this patch.  Each deserves its own fix; will be
    addressed in separate patches.
  Thanks to Sashiko AI review for all seven points.
 drivers/hid/hid-lenovo-go.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index d4d26c783356..b9d8cde53136 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2408,6 +2408,15 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 
 static void hid_go_cfg_remove(struct hid_device *hdev)
 {
+	/*
+	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
+	 * and dereferences drvdata.hdev.  Drain it here before tearing
+	 * down so the workqueue cannot run after hid_destroy_device()'s
+	 * put_device() has released the underlying hdev and dereference
+	 * a stale drvdata.hdev pointer.
+	 */
+	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
+
 	guard(mutex)(&drvdata.cfg_mutex);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
-- 
2.43.0

