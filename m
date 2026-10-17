Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56B385D91
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201213; cv=none; b=aAzGcpbmJQuzkNW+CRxXLciHM1MZkgMBe6YlNrFNgwbnNyKkeEtfdDvCrcbRRd6rziaYlxfM5oBIcaHsKr6p/WqO4w2YSlC322ZtQogw2WeBBPsNmRWk8ylWpWYl8uPaIbeSgNf7U+EOlN2tuSwYBL1ty9ZgUtZH3Wjh+8HQxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201213; c=relaxed/simple;
	bh=4urCyMVaiNsaJ5oTpbhYdSXWJFtAQ+6atKPamaiUKok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QePDnKG1gW0n90Kc7QiaVcbuKnhGOF50LYWwbaaT4FXEDxjKsf8oqszIqjYysXkBxjHjZIFZ7tnP5bKnr2G/wwQ9G1+OQLSficodQ4haffynsA1soUQ3EFMp2wsh1pcyHEXzaOcaXq6qsmprK0RwnVO1GAhKz6y6LJpXDY520cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsMtwl7Y; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsMtwl7Y"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15756f82e8aso1083148c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201210; x=1792806010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOueiXluXjDj/m0cQAsVf7wLNjXdqluvAn8HpEkfgJc=;
        b=FsMtwl7YAxjF1zetKNovxXluFmVFsyLCH4DY/lHqdbRb+3E1zHjArs7Mq+eRYwe/Tc
         prZSZMhbZ/0ovMeTYaRvPPxxnPy0CmmwsMnh7F4PgY4p/tbXflnBXEAFMW6C8oXH/tj7
         nyd7h31x6c15W5xHH8ZBMF44iTACLO8FM+p/9CNu2WuXnHBt07p4tEUAvRVuvOT2hBTe
         K9t7On1H7e1ixGNjA1rXldhj4G2oPe+qmj/U5IZoT4pgWleJKsqFruQJ7SaAU6eNfWxj
         vQpLBhB9se6Is7MKTUvf1kynkpLU1JvMMLr/jhuMhZLtY9QlryEvlv8GrktMxqBD7Y9/
         gFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201210; x=1792806010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOueiXluXjDj/m0cQAsVf7wLNjXdqluvAn8HpEkfgJc=;
        b=sEo8609ct9KV+16IVahGpvm4YednXYssGrS/OghX7aaz+wC+GtFyPZxPuHcviJUOI3
         sImRAeOZme/d52EqD1c4XDMjfHx/92qMCB+iMqGG2MtdA7ha751bBRsz+La8ulp+fZxL
         wxkHq8hXBZc+4Ho7YZ9u5FIM0/7Kg9tgC6JgE3FzCbOa+R1ZAz4RtgyAS9/hHgmmyGcN
         q2ZSgTyLOOopBSGkIk+97xmsIQw8uvR3MX7tv4i83xqBeY0afAU4TEGlj6/9lB3Q+Z+f
         hm7AQFvJ9mHhaoEVykjX6bap7rHO2/8wLesqSSpbDcEaV+wRXHvWqc5XnWx2MIG0ulk1
         30jQ==
X-Forwarded-Encrypted: i=1; AKwUvByL/sUMRFqf/YmAf+4xv4P67x7z3xKPDqKyl6OTVmtg/bvxVohSmZadNlX24DxqdwPlkY5kICr+/x/jSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3G0UDD5NYa2Q0DnBd2/O1I3SvUGenCZob8o934xubU2ab4cMg
	NPp5rE3KVW5WAjaOy/D1dj50piiqfFwzd/e61YjQwbf5s3QUUVnaPMVa
X-Gm-Gg: AYBFou0tu/TEFZH2nsxN7OBjzx3jrzzSoLZe+vi8Wviw0EQOwXXFPAtMjpQJeyRlxB/
	bZVI/iOewoJU6jRnY2yMJqBJIkLsuF6SZ0ODOmzgzDzekSZtLQJnGDv8D9DUNLPfLztG/xXJmm/
	BjVKtM1ufjna1HwSYQ9JZrGx/IYC8kE1/z8ANB4P4FIMQ6mSGdZNm8VMolZrI7xgslpdWN9Sg12
	FxnTaK+wPCHjTh2/5wHaZyPIYmK1yBHHVf2eubEWF62LFwsrhGkQgAinMj7Zmu+ffcGlC1g9k/v
	mMWCuSzjlWFyBnwr/FDdvwzBwQQ1Rc4gPBoiDI0CG1SYcLYyuvMp2zaaLNx31WcaZA+vBiWI4N0
	WLfLOfFz0WK6jkF1Ht4CSjt4zHeoTbU2Ecp34Q2U1Mv9Cxo2UWCatx/KsBsrOlYYvkRjpt3mxGl
	Mx+Smxfqv3jTjCProGdDdu4HwveMZGXiz++t4rXgkRc3do4twgAYGDhr50UHOapIWdRXEkwcftW
	OmScozL5ZkEJQcuLWkg6VWKsnu8mrz0jsCYa/W1MIh5oRaf1QgbEyJd6RYAp2ScvrHYYtfEsu0=
X-Received: by 2002:a05:7022:f401:b0:184:60dc:c381 with SMTP id a92af1059eb24-1851238b5cdmr2818837c88.23.1792201210084;
        Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:09 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 03/11] HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup
Date: Fri, 16 Oct 2026 18:39:48 -0700
Message-ID: <20261017013956.2440130-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_gos_cfg_remove() calls a mutex before canceling delayed work. That
delayed work function calls mcu_property_out(), which holds the same mutex.
Prevent deadlock by removing the mutex. Additionally, since
cancel_delayed_work has the potential to re-arm, switch to
disable_delayed_work.

Retaking the mutex before removing attributes could deadlock on store()
as well, so don't retake the mutex.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index e979527ece8e..b27e82ec9b76 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1445,9 +1445,9 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
-	guard(mutex)(&drvdata.cfg_mutex);
-	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
+
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.55.0

