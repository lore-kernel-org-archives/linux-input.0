Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6D3655CC
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863333; cv=none; b=LbR3yM6HvCj4cViqEnMbf+oxFAfiAa4XIjC6M6i27y02QISZ5xnIbEou/SgNDrv/Zs4D3PPrTTRthEuLfIPkPJ5JJxtf85fXt8z2S4vuJnqW/2QKfD/s1gU3HpKvt28xBKAhBFKx2NdBi/mUHGyy11zDCbuX6OkgWdC07cHyd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863333; c=relaxed/simple;
	bh=UBE19tqIPsaTPvtDf0UHZJ6EhdOgjl0QpfDIvLv+zc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSaJdADxXSdP2PViBZi2a7UHvaddVpOEeZyAzCLcilvobbcLGIT+P5JDCv53deitO/pZqnUAxNmYMH3kVKW2IFjgPW3LYdiJ7FPYsdH5+3Ii89k/zf62tJTHCivXn3E/gcL4zOAdHwE+5SXWVXLkM16nhEkAjjrbUzOT4/USaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0gkWHTR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0gkWHTR"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f30a4601bbso5747eec.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863331; x=1779468131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOwQSFX5w3NCPHyeBplNdTwoVIjahKIQaTVbweU0MIU=;
        b=N0gkWHTRXiznydaxXDU/ruxNz/mPvTlSuWxs1v2vEaTPZ3upvUcQZKu1tGnavcXxgE
         gRM0EBX1XX+LQ8CH8fykcH1NE+HykDQYBaQxEY5OZQaEk/kkCRzd+EjVELU+JaFqLY7p
         LnjuQUbnKy+8RU35Lz5hr1VKTruwtypjsStyvjsLJZ+j9x2DelRSZzUZD1L6baPk/1is
         m21j5WPzdwBaJKIRoUzYlbJZVX4JjMEDVQ/phr6D8sW31jXv9ULd+DQo3oLZVbTzolVn
         xHKnfonEyjpN+Z7Ob4bsez3ZVMDp1KQJuGnUniBy5JJqYKcar86L9Z8py8VgkhEXlqso
         XBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863331; x=1779468131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOwQSFX5w3NCPHyeBplNdTwoVIjahKIQaTVbweU0MIU=;
        b=Sv9CA5EBSkvZv0srgENRGI3TZPtaVYH73KYn+uuwSltvm6dyHu84DE0AMPT1JZk+v8
         4ZwM/gJ0Sd9KsBVAgsyNKIklsGYalDMmNVJzI5FfeG1YxGwrLe6Os9K0AHXy/chm/HeZ
         z7O0EuZ92LoJC20Gv0fzWm+54UPj8dCX2pYJRA+diSJqVrVEEFGiBHA1MijqwihtHuGi
         oj4ba4Ad7XCOsCkKbHMA/S6S6y3EpBWFk2vOqwf7Fi27r/3/vqLE8zwfLwvt2xJ5dgug
         /hlAn+EZMc0ZMAau633VMfzmav2ScPUcUzjiwPP9Xi1u5e/PeEwt48sM828Bc9pi+Hjh
         cghQ==
X-Gm-Message-State: AOJu0YxyoAE/UhyhCuflf8TXeYwIhpbu9TtDrN55gwCdDjutv6DjRdSy
	xn+SSU57rSQhpC4bU6ZpESyhrytrWeOngPoj5uJLevuYF9/+sZCxS3YKm5xEFMHOr+c=
X-Gm-Gg: Acq92OHHrCcnba5lyrvDG7L3oFdbHsA7Mc1AjM98yoeQBzabFluLvr1GhSx2kktGNCn
	mr2qgTmedTYgH3J6AXJkESmd+S6At/7Wj7T3eYI/qCiC/xhWhDBxcyfOmljioivkpsJAGAkMA9u
	rjD4hqAo6Ie48G1Wx2J5KAdn+7peZ7Ej5X/Q6SZoEZP0fe/+NAZo2teLxQxeGShgg+/lfJEbBL0
	8nVEZujCLH8JaN9VicDzIiwkljqdX6nuMoGNFdd0mHZrEJ+4dAdXKDpSYZTR/Jf3Ul+U0UOdS2g
	C5cRAPsy+aTViMXyE0hfGuM0Bw7aK0iOcso9k1YRZMUN5tNRrRbemwk6HnR+Djmpp4nwLzemDkv
	1lF6ZCan2El/PojU6SlUb+ti+bvqDkmFMfTLHsRHdXRbtAHqxXKQAvUDXu9NEYDCiZ0y/Q6sXpY
	Ey7vcS/+Euo8f19bnz4PleDqEZxUrlBCjSRkXd8jzTB285tQ+zG7LPK67NMtKuvfZCKQc4nIKRe
	5J44AzLHkyYfaM8Uzep+TW/FkfZ3G8VrSeMt+zjltE+k9tddI7/tA8FSiQ4tchJD729t3e7HHaT
	C+XIjP5bZT8EG6Jh3JlGyrJmZkytoaOy4ithDEjWPg==
X-Received: by 2002:a05:7300:e430:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-303982865cfmr2294292eec.4.1778863330556;
        Fri, 15 May 2026 09:42:10 -0700 (PDT)
Received: from lima-kernel-dev.google.com (ec2-13-52-214-175.us-west-1.compute.amazonaws.com. [13.52.214.175])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm7423695eec.20.2026.05.15.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:42:10 -0700 (PDT)
From: Manish Khadka <maskmemanish@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: letsketch: fix UAF on inrange_timer at driver unbind
Date: Fri, 15 May 2026 22:27:00 +0545
Message-ID: <20260515164200.77039-1-maskmemanish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515155838.B4247C2BCB3@smtp.kernel.org>
References: <20260515155838.B4247C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

letsketch_driver does not provide a .remove callback, but
letsketch_probe() arms a per-device timer:

    timer_setup(&data->inrange_timer, letsketch_inrange_timeout, 0);

The timer is re-armed from letsketch_raw_event() with a 100 ms
timeout on every pen-in-range report, and its callback dereferences
data->input_tablet to deliver a synthetic BTN_TOOL_PEN release.

letsketch_data is allocated with devm_kzalloc(), and its input_dev
fields are devm-allocated via letsketch_setup_input_tablet().  On
device unbind (USB unplug or rmmod), the HID core runs its default
teardown and devm cleanup frees both letsketch_data and the input
devices.  Because no .remove callback exists, nothing drains the
timer first: if raw_event armed it within ~100 ms of the unbind,
the pending timer fires on freed memory.  This is a UAF read of
data and of data->input_tablet, followed by input_report_key() /
input_sync() into the freed input_dev.

The same problem can occur on the probe error path: if
hid_hw_start() enabled I/O on an always-poll-quirk device and then
failed, raw_event may have armed the timer before devm releases
data.

Fix by adding a .remove callback that calls hid_hw_stop() first.
hid_hw_stop() synchronously kills the URBs that deliver raw_event(),
so once it returns no path can re-arm the timer.  timer_shutdown_sync()
then drains any in-flight callback and permanently disables further
mod_timer() calls.  Apply the same timer_shutdown_sync() in the probe
error path so the timer is guaranteed not to outlive data.

Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
---

v1 -> v2:
  - Drop the spinlock_t and bool removing fields and their uses
    (and the <linux/cleanup.h> include): hid_hw_stop() synchronously
    kills URBs, so once it returns no raw_event can re-arm the timer
    and an explicit gate is unnecessary.
  - Use timer_shutdown_sync() in place of timer_delete_sync(), which
    also makes the probe error path safe against a stray mod_timer()
    that an always-poll-quirk hid_hw_start() failure could leave
    behind.
  - Drain the timer in the probe error path via a unified
    err_shutdown_timer label.
  Thanks to Sashiko AI review for both points.
 drivers/hid/hid-letsketch.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
index 11e21f988723..b52e93a91ae5 100644
--- a/drivers/hid/hid-letsketch.c
+++ b/drivers/hid/hid-letsketch.c
@@ -296,13 +296,42 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
 
 	ret = letsketch_setup_input_tablet(data);
 	if (ret)
-		return ret;
+		goto err_shutdown_timer;
 
 	ret = letsketch_setup_input_tablet_pad(data);
 	if (ret)
-		return ret;
+		goto err_shutdown_timer;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		goto err_shutdown_timer;
 
-	return hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	return 0;
+
+err_shutdown_timer:
+	/*
+	 * Drain any pending callback and permanently disable the timer
+	 * before devm releases data: if hid_hw_start() enabled I/O on an
+	 * always-poll-quirk device and then failed, raw_event may have
+	 * armed the timer already.
+	 */
+	timer_shutdown_sync(&data->inrange_timer);
+	return ret;
+}
+
+static void letsketch_remove(struct hid_device *hdev)
+{
+	struct letsketch_data *data = hid_get_drvdata(hdev);
+
+	/*
+	 * hid_hw_stop() synchronously kills the URBs that deliver
+	 * raw_event(), so once it returns no path can re-arm
+	 * inrange_timer.  timer_shutdown_sync() then drains any
+	 * in-flight callback and permanently disables further
+	 * mod_timer() calls before devm releases data.
+	 */
+	hid_hw_stop(hdev);
+	timer_shutdown_sync(&data->inrange_timer);
 }
 
 static const struct hid_device_id letsketch_devices[] = {
@@ -315,6 +344,7 @@ static struct hid_driver letsketch_driver = {
 	.name = "letsketch",
 	.id_table = letsketch_devices,
 	.probe = letsketch_probe,
+	.remove = letsketch_remove,
 	.raw_event = letsketch_raw_event,
 };
 module_hid_driver(letsketch_driver);
-- 
2.43.0

