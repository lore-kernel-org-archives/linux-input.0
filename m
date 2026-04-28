Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2237478;
	Tue, 28 Apr 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349558; cv=none; b=ehmyI4+QtkOh02B1cD+pzT4AkliKHtFFAkZvSmYsXHGgE2bbyNXiT95zAnDo9tqqqPcb+buvI4HNW2pnGA0667mIORo5AdUD4dhJYTNYxtV5ZdNBv7y14EFbdUO3Un895aGEFM+DsGdezeCGtA2ORws1FQgW/oEY4nAUW1zPgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349558; c=relaxed/simple;
	bh=RdCNYgtTfUx2w+VEsHqK9DmXdFYgykhdOYA8kLFGzXw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tYaKE3goSsCx52nsMqrEukp5/Sl/T9Ibc+/8pXRFiLTpZR0LXVzv2g3FtT5D++soLIiCuy7B077tde+Wl2KcvMdP+LnH0nQnsLj+5Jd8EgfH/G1xwWkyak+o70qkqgbAA+5mZ68ma39qoa0aI62HYcvj4ZRnFuy2uYxqoUNPSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Gidu5s8F; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Gidu5s8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777349550; bh=1Nt6ugEPShLCYKEr6+BVNpxdhANPlQCmEmONk5oMCbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gidu5s8FB3dgC4Y0T8o7Bt6g6MXwJTNjS9D0A7Jlck6mhzAuLqvgWW3BpSPU7WOPF
	 nwWu6E0xsM06WkpZcd+dOOmyfQueniBr/1PaIaISLvfx2KQp268ySG5xSN6tDrBJB5
	 H91rv9r50jYxD94gA9H3NffH9IO4f4KZX5ZtOIXg=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 31AAAA9C; Tue, 28 Apr 2026 12:12:26 +0800
X-QQ-mid: xmsmtpt1777349546tscspmme0
Message-ID: <tencent_BB7C33EB9EA41B7B4B5F1B8B25C0BA13BB08@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XhkF96blYDQH0VPzreY9tKY5JuknvLzdgIEAjNqWLdM9Dg8nldw
	 c62V5Fp7hmu3D5bC+ppaDSTRgBOpo2vrct3aBswas/SwezWrSFP9CEDq7nOZcQkLtcRmsfYkSMBo
	 Wtrn/I+EMDcmgFnqMcob9yLJ5zkXeaX+DHKmzxPQtVK5dTZDdt+DI3oj+LeUjD6qOdHXGepPVIGz
	 7VufDrexR9nyOpG33zaRWDLiV3PC2fVQrDlr7ftO+K574ajdU+yhtp8Pgqo4Xah7zl2+UvWaiTOw
	 cZbOKf4C+RiD7Ysul249AZgSi6xe5R6zRbf3c/E05YQTzGAhSLNLqz4u0fTM9Ew3bo204l7dQVbW
	 TIptGNFIfSS3P3a6sOfPrrMi7sviIym0DwVCjc11+ezkQQOcVX4wccpKXqTbWk8yA8h0m17KCfKV
	 iBowgNClmXRYmJXgIcRwmv4Ix2vJTFvCYjAWpkORkTQaqhnHjPKy8OEeyVYZ4Sgs7Jwcxkn8EdWy
	 SZfhkfRXxEahQc34m3D1Epg/wwkME+gNIA6GLtnHdplkx02pU9T/hyihHDePDhEG0Ymiqo6yRttp
	 wo5bEcAc3RSTP1PuuUUN+6xEh+hgnicY+wQEFIvvwHzQ1FN+y28tu907vN/gO5+bpATC4w2GZE56
	 P8yiT+UkeTkJbrlNJrEu2mulRU7sX/I6gv/btBhp9bvhAU907L5PmiUMlT1ez9LrZzMaxIIO/VCZ
	 i2brY6DLwTD+dPfSsLknwN119rXfSBNzhHIrsRXqoVbNcy28WRYupSGXCsgv6lmPg6+R3LjUy7QG
	 44A/NHdmpRQIvfMJ0SLXHfCV1dZ32q+jl2p/WkCVS3pzNojihg705GaeKrKaNkiT/JVp3vCjnCOk
	 qeT4Hkw+Z7qj0O9bIQPpjc9iCCudC9c8qKWfcjy7PqN7mXspeUYksQm4VKb5sOPju3zJAizzHk3p
	 fjvpBGy3Q8ponppkAd4FdcNZo2BNCUqZEDniMhU0xbLv73FxUCyKjeYW5ZzaAWXNZ56pp4fTV3C4
	 1rBFje17SQ4ckPz2FIyDGdlRVJiBI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hwmon: prevent packets from going to driver for probe
Date: Tue, 28 Apr 2026 12:12:26 +0800
X-OQ-MSGID: <20260428041225.235251-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
References: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race condition exists between hid_input_report() and the point
immediately following the execution of hid_device_io_start() within
corsairpsu_probe(). If the probe operation fails after "io start" has
been initiated, this race condition will result in a uaf vulnerability
[1].

CPU0				CPU1
====				====
corsairpsu_probe()
 hid_device_io_start()
  ... unlock driver_input_lock 
 hid_hw_stop()
  kfree(hidraw)			__hid_input_report()
				 ... acquire driver_input_lock
				 hid_report_raw_event()
				  hidraw_report_event()
				   ... access hidraw's list_lock // trigger uaf

Consequently, when corsairpsu_probe() fails and hid_hw_stop() needs to
be executed, the io_started flag is first cleared while holding the
driver_input_lock to prevent potential race conditions involving input
reports.

[1]
BUG: KASAN: slab-use-after-free in rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
Call Trace:
 hidraw_report_event+0x5d/0x3a0 drivers/hid/hidraw.c:577
 hid_report_raw_event+0x311/0x1730 drivers/hid/hid-core.c:2076
 __hid_input_report drivers/hid/hid-core.c:2152 [inline]
 hid_input_report+0x44e/0x580 drivers/hid/hid-core.c:2174
 hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
 __usb_hcd_giveback_urb+0x3b3/0x5e0 drivers/usb/core/hcd.c:1657
 dummy_timer+0x8a9/0x47d0 drivers/usb/gadget/udc/dummy_hcd.c:2005

Allocated by task 10:
 hidraw_connect+0x57/0x430 drivers/hid/hidraw.c:606
 hid_connect+0x5bf/0x19d0 drivers/hid/hid-core.c:2277
 hid_hw_start+0xa8/0x120 drivers/hid/hid-core.c:2387
 corsairpsu_probe+0xd9/0x3c0 drivers/hwmon/corsair-psu.c:782

Freed by task 10:
 hidraw_disconnect+0x4f/0x60 drivers/hid/hidraw.c:662
 hid_disconnect drivers/hid/hid-core.c:2362 [inline]
 hid_hw_stop+0x101/0x1e0 drivers/hid/hid-core.c:2407
 corsairpsu_probe+0x327/0x3c0 drivers/hwmon/corsair-psu.c:826
 
Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
Tested-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/hwmon/corsair-psu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index dddbd2463f8d..4e766bf32189 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -823,6 +823,7 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
 fail_and_close:
 	hid_hw_close(hdev);
 fail_and_stop:
+	hid_device_io_stop(hdev);
 	hid_hw_stop(hdev);
 	return ret;
 }
-- 
2.43.0

