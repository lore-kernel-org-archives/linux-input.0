Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845432B123;
	Tue, 19 May 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195701; cv=none; b=dW1BiVGlCRELmb2qIbIj8psSxa5R/qTjLHPOx7w9lNQxuZSa/qVzbD6/6ixVxQPAZIrCNrf3lNY2MOK4/i139px6FPJRTm3uW5fhQ29zUpW7MccfKv9BX+B5qu8kGR8dozicK3MotjroBqw6hEsVpVZG9AKJKlhAI8eSF4mYY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195701; c=relaxed/simple;
	bh=aXFXZCrHflZRjlgDhe4ji3Wf5oDXABcFZy9eV8kzVn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3WY99VVO3Ok6Pn2riibRj1vvU3XcCg2ugY84IoMsfcqBtmppq2wa+LsVWFTpxYALqQCp34jIlzFBlGBgiVwhytmGlTEEyP/bsERQya6k9+piXiRCOhD8dbk6474RA+IaOoyDurE5A2PksMWEYH4KDF+7hbgI7Rt5SIaiD0rSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phwe.de; spf=pass smtp.mailfrom=phwe.de; dkim=pass (2048-bit key) header.d=phwe.de header.i=@phwe.de header.b=Cu7pd/7s; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phwe.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phwe.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phwe.de header.i=@phwe.de header.b="Cu7pd/7s"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gKZY03ljTz3wr5;
	Tue, 19 May 2026 15:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phwe.de; s=key2;
	t=1779195652; bh=aXFXZCrHflZRjlgDhe4ji3Wf5oDXABcFZy9eV8kzVn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cu7pd/7ssZYyJedI7qcH57Si264JaKEB3dQoHTl+2KXMUZthTvjjfI3mwAg6/6aMG
	 pYZgpTvb+rroViIoTwdXaqQoDivZrPS137BlStqP2VC2PMZCfeirnrzBycN2PGu02n
	 attq1kEBIu1coDOdoXHSFF3Iv0hpOgA5cS4rE2R13M9+Pzxu+wNv5t1ZfCmaVC+Mk8
	 zbJAnRTfS1s/5gBPc3HvR3ACumX65zXKFJr62R5jtLLamKZ2a9rs28sOrOdmKGg8v9
	 vkl4ccESK8zPNKPStLkxEPaUe2Op1yklPgkxcraIP/bbl7vwxu5Wc6B/lUxVzaN5TM
	 E2aajrA2i04cQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gKZY031Pyz3wqN;
	Tue, 19 May 2026 15:00:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe95c.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gKZXy5n3Qz8tbh;
	Tue, 19 May 2026 15:00:50 +0200 (CEST)
Received: from mandalore.fritz.box (p5dd24ed4.dip0.t-ipconnect.de [93.210.78.212])
	by mxe95c.netcup.net (Postfix) with ESMTPSA id 1BC8B8008F;
	Tue, 19 May 2026 15:00:47 +0200 (CEST)
Authentication-Results: mxe95c;
	spf=pass (sender IP is 93.210.78.212) smtp.mailfrom=kernel@phwe.de smtp.helo=mandalore.fritz.box
Received-SPF: pass (mxe95c: connection is authenticated)
From: Philipp Weber <kernel@phwe.de>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: eadavis@qq.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Subject: [RFC PATCH] HID: core: quiesce input in hid_hw_stop() to prevent
 use-after-free
Date: Tue, 19 May 2026 15:00:14 +0200
Message-ID: <20260519130014.34521-1-kernel@phwe.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
References: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177919564796.2879678.2913490429993368744@mxe95c.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 1BC8B8008F
X-NC-CID: yplIuuZx8Q4o9jPU/qKM6pl6ZOtbzYRDVlCiTjC4NQ==

A driver's probe calls hid_device_io_start() to enable input delivery,
then fails at a later initialization step and unwinds via hid_hw_stop().
The unwind frees struct hidraw via hidraw_disconnect() while in-flight
HID reports may still be running on another CPU, dereferencing the
freed object through hidraw_report_event(). syzbot reports the
resulting use-after-free for the corsair-psu HID driver.

Edward Adam Davis posted a per-driver fix for corsair-psu that adds
an explicit hid_device_io_stop() before hid_hw_stop() in the probe
error path ("hwmon: prevent packets from going to driver for probe",
2026-04-28). Auditing the tree shows 15 drivers call
hid_device_io_start(); 7 also call hid_device_io_stop() and 8 do not:

  drivers calling hid_device_io_start() without a matching
  hid_device_io_stop() before hid_hw_stop():
    drivers/hwmon/corsair-psu.c       (fix posted by Edward)
    drivers/hwmon/corsair-cpro.c
    drivers/hwmon/nzxt-kraken3.c
    drivers/hwmon/nzxt-smart2.c
    drivers/hwmon/gigabyte_waterforce.c
    drivers/hid/hid-logitech-dj.c
    drivers/hid/hid-nintendo.c
    drivers/hid/hid-mcp2221.c

Roughly half of all callers of the API are exposed. Centralize the
quiesce in hid_hw_stop() so callers do not have to remember the
matching stop: if a driver has left hdev->io_started true on entry,
call hid_device_io_stop() before hid_disconnect().

For the 7 drivers that already call hid_device_io_stop() correctly,
hdev->io_started is false on entry, the guard short-circuits, and
behavior is unchanged.

No Fixes: tag because the affected drivers gained their
hid_device_io_start() calls independently over years; the bug is a
class-wide API misuse rather than a regression from one commit.

Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
Signed-off-by: Philipp Weber <kernel@phwe.de>
---
 drivers/hid/hid-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..6b024118d983 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2440,9 +2440,16 @@ EXPORT_SYMBOL_GPL(hid_hw_start);
  *
  * This is usually called from remove function or from probe when something
  * failed and hid_hw_start was called already.
+ *
+ * If the caller enabled HID input via hid_device_io_start() and is unwinding
+ * without an explicit hid_device_io_stop(), quiesce input first so that
+ * in-flight reports cannot reach handlers (e.g. hidraw_report_event) whose
+ * backing objects hid_disconnect() is about to free.
  */
 void hid_hw_stop(struct hid_device *hdev)
 {
+	if (hdev->io_started)
+		hid_device_io_stop(hdev);
 	hid_disconnect(hdev);
 	hdev->ll_driver->stop(hdev);
 }

base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.53.0

