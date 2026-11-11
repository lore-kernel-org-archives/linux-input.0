Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379828;
	b=2dkRkbm1A9deH41cFtu7HptIIzuJAukb1eGzLlC/v/JBcXKI/tlXNYiJDI6a2wvTHCM+
	 q42dXuM2ki+DTMFoNlVq+IghIewYttqIEDdqpSPDB/+15h1LCRs9WwTBtJBZYTJfsZxqx
	 ndzKZChEtKx6eydmGI/YV+keVd8/V8NGEuYl8KMUoiMgQBL1MeLK6j6TrmyHSWD8Jp8z/
	 4s/aSes+2RHf8wq3jhsVaPNwfONeaThrLpGguZiMgtqd1WhSrXUjH00nbd9yf1IHoPUTP
	 wXn2EIvf9bwxRv6TxRAMu63CKYINEwII5T1k4so/i8e/hOQ/XDoZ1l9hSZ8i66PpETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379828;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Le+YZZZAVtQ6dYj04E/guqQMLSAl7frsNrjCH0EA0Sc=;
	b=rH1JRQnB4NDZatCBsZyordvQdb2xaVUl4bAomaqQAWO7dk0l5Mwm4xYYo5wyt03HGFMU
	 FBYUMrroFDGvyurGUlqp8jKVg/Qyeb9Q2+JXNjF6a05G1rp2rtpYz9tG5b9hzDa3hfxnr
	 fT4l6NyPsU68oMXQKY6iR4CfFuAKh6qm3u0VMWlcBqNEs3l4xq1ES3j9sv4rjHhm7mQOr
	 QtC0pd3mwlqHSPXO7VcC8dPRxoGrKTWznfzocL8naOy+fWw6bt48Vk7DtaqyoZ9NqBdJo
	 RKCnNXknua2UAd0gRHg6fYnhndacKm0ipEtGpVqT/uIzt1V7fHHVRpK3oZ3Dbyx4ncg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=fHEbu3aX;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F2606A321
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5F2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=fHEbu3aX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794379827; bh=d8vh8FEZmhtNWjstP+pkbFIg4AQRr58+DHsXuOeARj8=;
	h=From:To:Cc:Subject:Date:From;
	b=fHEbu3aXU4MiklqWOhoFG4V2+QMQYAyu7L29hDb7zq55JWQAOtsoq/c4k9IFOm7By
	 4NCcJwSrqpE676oVesLYr2cz9PNCX+hoJJop1N8d2m8DdbrGMQ7U6rfIWzM/zt4q+9
	 fl0B4UzlUjfKxjyXJYDTyNDX/afDi3IN9BH5AVbyje5q5gatBmIwdiEgM7O0lmMgta
	 8Pz34UA3+fuR4z6zHAXx5iSSrhT452eUeoxhcf2gXXgNrkYhAWkiXf8nj/VLIvDFaZ
	 DUuQ6mJ+ZSUlGgifp4eeKU7yYL6HhcRaff2CWCY6iAzTqZYg44g3DDot7GlA9v3ATX
	 vSDqBUCZVlOWA==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id CB8E0A021;
	Tue, 10 Nov 2026 22:50:26 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/3] HID: nintendo-switch2-usb: Fix potential deadlock on teardown
Date: Tue, 10 Nov 2026 22:49:54 -0800
Message-ID: <20261111065001.3626071-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
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

As reported by Sashiko, there is a narrow window in which cancel_work_sync
on the message in work can block due to the work waiting on the mutex that
the canceling thread holds. By moving the pointer clearing and unlocking
the mutex before calling cfg->shutdown we can avoid this deadlock.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261006061619.2005967-1-vi%40endrift.com?part=1
Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller driver")
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 4d40f67f3e64..d235de6868a2 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -4292,6 +4292,7 @@ int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg_intf *cfg
 	mutex_lock(&ns2->lock);
 	if (ns2->cfg) {
 		ret = -EBUSY;
+		mutex_unlock(&ns2->lock);
 		goto out;
 	}
 	cfg->parent = ns2;
@@ -4301,15 +4302,16 @@ int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg_intf *cfg
 		ret = switch2_init_controller(ns2);
 
 	if (ret < 0) {
+		ns2->cfg = NULL;
+		mutex_unlock(&ns2->lock);
 		if (cfg->shutdown)
 			cfg->shutdown(cfg);
 		cfg->parent = NULL;
-		ns2->cfg = NULL;
+	} else {
+		mutex_unlock(&ns2->lock);
 	}
 
 out:
-	mutex_unlock(&ns2->lock);
-
 	if (ret < 0)
 		kref_put(&ns2->refcount, switch2_kref_put);
 	return ret;
-- 
2.54.0

