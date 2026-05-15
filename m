Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A993FBB53
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859380; cv=none; b=E/dB3UB8yhjKj9H9M++0AkWRI41W3cYTipf5c4NmrLZnYOFgxpUMZetcoy7TvfxU9n+SengLAm0TfMvpRemgO5LFnf6vZDl6CrVJdQC+seatawgbe1aOpbLe4CRqLgnxX42y9JGAvixrXghS4JDwGPfq2DoMf52QRmUUII5eL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859380; c=relaxed/simple;
	bh=OpIq0AuK/NgSg/YHv3ys7p5ccwDBrLi/kqUfTEcAc5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSXt89llTOR31lcP57G0rAbDUFOhCba0smtdgliIGJGHlFCmIRzIrN9DQU/RmoUA8AmMNKw0oLmG+q/Dx6dWKS9dTmQvgW5PnVtn3QDcLoKtWp7GPHbhTJUIRRP/XCOQ39Q7KBdCTlM9cBtOKUb4HPBKL0WftYZ/E1Dqq1dcuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgW3OpPu; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgW3OpPu"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30246cfd41aso5179554eec.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859376; x=1779464176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVj2OPx9OWN6THjcTj10qqvXFzA0offMmw+VDODEVjs=;
        b=FgW3OpPu3RokCuLW1AY8A1txASKChiXaO1UDVO7xAzXEkd0nDGmSC/E0CEdIon2m7F
         hGyBWUp0mqyfmEbKMOatSdqfB5vQntIYhJyzQPIQRYQcAZZVcLUlBQwbbbJAqNQ4AtmH
         EFxB7h3l1jwr+guabC8OQ6Qp9hqaIf1WpoYkEZ+y7Mk4vrMi+QR11xD4dpKSxX8KgSI0
         Jdk4iLW+Z6/4uhcRFpcygRmY5m5sT2HYj7Jjp7Yn8f0LcRvEPF+eys6ye4oyC159buuH
         2OplJXAiWCEui3z4Va27FIn1QhOJOl+dQ1njErgu9/oWfKCdaxbn5a8yLKmw3+HJIq18
         +P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859376; x=1779464176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVj2OPx9OWN6THjcTj10qqvXFzA0offMmw+VDODEVjs=;
        b=aWpzEu93GPW+4UyEf+4eXE5u0tf/Aymc3Gt1yAIpjxPxE2TvZazMtUo8nOnWcmzxGe
         Lbb8aOD+yAiQmGOtDwVBHdGP95KQO11F39CS6Dmipz92VGq9QQLPgGRLB3e6jGJEKc7i
         jEtMzbZitEL0wzd75H1IXN1dcWnQSP8mAI1X2A0mZ1pnC8HbhlcWa9vMm7wCHN/+RsM5
         vd3gQ0k4IeIGCEcezCks3GDWhlJwoXc1uH/gupyexl3j6y0JQJh86eJqdCLDbf41z6PI
         zo20v9YXO006npimK05+8fqcIal/N9W3Jf8x3HzQWyH2T0lTfAoY5CK7j7TFlSEgaqoo
         18MQ==
X-Gm-Message-State: AOJu0YzB0h3UmjXkLJaE6Tahh2VqV4YzVmTWuX13d9WP+mWM0KunhmIo
	EsmmJe+oK53W5WyDZbNb2pqesoSxy4NxM1lxAb0PCFtULR7VQHCPkMH2uQdMlR2Dz7M=
X-Gm-Gg: Acq92OH9WT/YokYTx9b18rQ4iDFPOtp6IoBE9som9Z5Xlj60K0LzSdNa1rbL0STG6QG
	rnvswoKwTZ6jvSiovHvhPjFF3YixzVF4tBgGLl+mI0OM0/wLMyZBmStgJqzPWLuT4S6FWEZsT3E
	+Lik0+PhPtRKW+rVqYFZRDGnnV8zoUtzV/Jtocpd+B9o8VHs1FxpYYbNkE332yNqA/HTpmoYaE5
	OwqCrIRDkuzg/izPcQCAOKbqQuSccnosUfubMx7yA7eiV83/p0GJLvsRqyvGKtWFgrjxuJ9BPgn
	G5Nn9tYgzqZBEX0KHY42ntgd39ZbJEqEYE1WqQmhVR68teE09bAnNYKJ0BgEL2n056T6Lif7knp
	xCyv2/Y7xSkHvP/C9lCok+Q4sgg/EZNHiE9JtvFxm/F5/pLjpIqNtVMKKbckEPRhOGo5MEfrMms
	mFCPUoXrQe+KmoBxxA5aM1zHTzzMizGeypXdOeCVJFSHrsPZzQ6cMC9DMbftPCpihWlfMwe6+cH
	oAzCGnAYbqOdaCc+E17t45KWM8+oFRb4BIOvjSEgFON3yYEM10cvf4cvwpRHMHVFm294f9hM7Fv
	XviXE1mXPZ7z1FscavbqFiQacZFsA1U1RTgweZb9Qg==
X-Received: by 2002:a05:7300:a498:b0:2ed:e12:3773 with SMTP id 5a478bee46e88-303986d6026mr2291069eec.35.1778859375353;
        Fri, 15 May 2026 08:36:15 -0700 (PDT)
Received: from lima-kernel-dev.google.com (ec2-13-52-214-175.us-west-1.compute.amazonaws.com. [13.52.214.175])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm9322064eec.30.2026.05.15.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:36:14 -0700 (PDT)
From: Manish Khadka <maskmemanish@gmail.com>
To: linux-input@vger.kernel.org
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()
Date: Fri, 15 May 2026 21:21:07 +0545
Message-ID: <20260515153607.76175-1-maskmemanish@gmail.com>
X-Mailer: git-send-email 2.43.0
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
hid_go_cfg_remove() tears down sysfs and stops the HID device, ending
with hid_set_drvdata(hdev, NULL), but never drains the delayed work.
If the device is unbound within the 2 ms scheduling delay (a probe
failure rolling back via remove, or a fast rmmod after probe), the
work fires after hid_set_drvdata(NULL) has cleared the back pointer,
leaving cfg_setup() with a NULL or stale drvdata.hdev.

Mirror the sibling driver hid-lenovo-go-s.c, whose hid_gos_cfg_remove()
already calls cancel_delayed_work_sync() on its analogous work, and
drain go_cfg_setup at the top of hid_go_cfg_remove().  The cancel
must come before guard(mutex)(&drvdata.cfg_mutex) because cfg_setup()
acquires that mutex; reversing the order would deadlock.

Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index d4d26c783356..ef69869f0a00 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2408,6 +2408,13 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 
 static void hid_go_cfg_remove(struct hid_device *hdev)
 {
+	/*
+	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay;
+	 * drain it here before tearing down so the workqueue cannot run
+	 * after hid_set_drvdata(NULL) and dereference a stale drvdata.hdev.
+	 */
+	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
+
 	guard(mutex)(&drvdata.cfg_mutex);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
-- 
2.43.0

