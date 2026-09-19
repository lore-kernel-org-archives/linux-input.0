Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A12472A6
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821972; cv=none; b=SmNxDnsmRxtsshySHQdtEKuoVoyBe1om4ESwGKbETbrJao8IUHOIvIAXNc24/QGxWOyUml42Ld3fhLTkZijXK9tJEzKDC5L/rl0EC6MuEQy0kEJSuVpWYYxeNL9Qo7+vJP6Eu9yK/Cz4gIGOoCI40J7+puz/JPyURtd69D/+7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821972; c=relaxed/simple;
	bh=ni44iwwOBdXWZhwAMWSEdLuNIEgQHha1arOyS3hPP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPqqy7Xph+XmWJACutS/X3toBBNUItReYUgxcYsj4Y7qSTaq+/nbp3tQdCz0Pen4LfjJwt30Nlg9NXqlozYCk13+aqmI1hUZzAGOMgSFgQoxFVOyP2tsrue4tHRTtSz8rhetQz3rpCcAjpi/9BxZ3PqoyfPVYcl4O3kf7LAFgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7DT/OkT; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7DT/OkT"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eefae4so4812095ad.0
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789821970; x=1790426770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHarfBm/2Lwn8RhgpUebc10L/RTVf+2oe3HM+fTBOeg=;
        b=C7DT/OkT0Aswe929HPmd2e6TNH6iCJTr/QHyb79iP35P2myISnTPgW0SYTNCNTaavv
         A9kgbYly+sh6g/eqd6SdVDgLliZ1sjIrzSCwLB/4jW8M4y4S19Gp2p5Qq7Rme/SRZYk2
         aE0UzstF+f8tBsps+ADssDs3QOWN68XCRwzQQccqHJ5srNRjElybM66KgjS7cJ41zWoh
         v7ABUYzgmIkLtCE+u7I5D2IKtz1zoGK/fiUnujX7X+8JgNqyVvMavLbIJtjwC0x9Y/us
         TokSTJpOj5wLnOzRFXYAtHzdR/VheG17DWdNMGXXEmK8oZbpSzFzy0bpJCWBX0Il9n9W
         tS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821970; x=1790426770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHarfBm/2Lwn8RhgpUebc10L/RTVf+2oe3HM+fTBOeg=;
        b=Nd8SO/32GwGIqgwMGFlTycMhJmOSbWlC+q5eF7RdK58f72oDRyDSwVrjiY5qu8X0Ve
         rAF4k6vwf056h6S+FIrLAv3kA1Qd+NvgR79b2mZ9z7nm32Pmcne07bdJr6Zl7cgfXtPd
         aIVdUnLI0iQwTtVP59lNNP08XA0MGn2CaO/PYp3dmYBoCfb7ScqvuNFhwFwbw+AJV+66
         Bs1XVOHTU6N89x1fNbSw74Ca6ascazJjCl1WVa1Ic/R3tRowhy1b3TWcmpA7pwCXAGDZ
         wpMPV2mO+1ezYRrnC82VcKFLk9aFiMbQWuYvvYrQFkDw354c4NUvCYOQY44CvS2Gr5/G
         AQEg==
X-Forwarded-Encrypted: i=1; AKwUvBwGoGxzHRAN2W0AM15cxX60Wa4jsFq5Y4BFjsSo56x2qlURbH7aE/T5O/MkVrOur9ZJdLI+earDye9ppA==@vger.kernel.org
X-Gm-Message-State: AFuF++lji/fGF2Xs9vWkHX12jG24rTOOvTLTVvJT6fZ1ZEssgVf/kdWl
	KZdLwLSEhQsdWSw24Dxm4u75pDM4awvexkXuxM5xtEgp9ZAFvpAPqDSOppOpJw==
X-Gm-Gg: AYBFou0Rg9PVaZrNL3HnCrGn3d9Fcnf+qX77mi7F8BdMTdihfRIs+L6L1pjMWMReBLm
	truR5Yc1A+FxAIhcmCKTDFaFMZQT6TOFOL/qdUJPvGY1wDUI5ExCqCp9BoYRelU73mzhpwTQHI+
	FzXEZ0iwERpvu5EsUnyo3nRJD1F6rQ2xSsttQ0Y8liMQ0jKBtjkwww6o21gwQYT7Bt4G1gTJANb
	YR9w4DQAbv5w768qjsMxdHMCHDnd3ZfXielwtgiYoIwv0yoIjfCErTS39MKKnm0caXikNEuvNhs
	TlBjfcY5tYZ1sU1mmPs0yR84lyjyDE3qItgX16TPrLAbZmu4H+8AyxgutYkONgaakHOiLQd7Kx0
	qjtVatQ6u9b89kLIK+xFY06zZ8mBpc5Kt+LsnR0zJVPpdUWT4If6lzp+UauOkAYngXjXMvN466i
	jK4YO4YiYfWuY5a1w5umf6WylMHkNa9/cPcMQwivbm+Q/4zLI6T25B4UbZDAeY/mtN+qUJAYcVl
	s60xUuG95xbBGNq
X-Received: by 2002:a17:902:968d:b0:2dd:c100:2522 with SMTP id d9443c01a7336-2ddc10025c8mr16867405ad.43.1789821969883;
        Sat, 19 Sep 2026 05:46:09 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17eb03dsm9769945ad.71.2026.09.19.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:46:09 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com
Subject: [PATCH] Input: serio - don't sleep on serio_mutex from drvctl_store()
Date: Sat, 19 Sep 2026 19:46:04 +0700
Message-ID: <20260919124604.210505-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing to the drvctl attribute takes serio_mutex while holding the
attribute's kernfs active reference. serio_unregister_port() does the
opposite: it holds serio_mutex and device_del() then waits for active
references to drain in kernfs_drain(). If a drvctl write is in flight
when the port is unregistered, the writer waits for serio_mutex and the
unregistering task waits for the writer, and neither makes progress.
Interruptibility of the lock does not help, as nothing signals the writer.

lockdep reports it as:

  WARNING: possible circular locking dependency detected
  repro/4908 is trying to acquire lock:
   (kn->active){++++}-{0:0}, at: __kernfs_remove+0x34c/0xb90
  but task is already holding lock:
   (serio_mutex){+.+.}-{4:4}, at: serio_unregister_port+0x1b/0x40
   drvctl_store
   sysfs_kf_write
   ...
   kernfs_drain
   device_del
   serio_destroy_port
   serio_unregister_port
   userio_char_release

Use mutex_trylock() and restart the syscall when the mutex is busy, so
the active reference is dropped before waiting. Once the port is being
removed the retried write fails with -ENODEV.

Reported-by: syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Root cause: drvctl_store() runs with the attribute's kernfs active reference
held and then takes serio_mutex. serio_unregister_port() takes serio_mutex and
then device_del() -> kernfs_drain() waits for all active references to drop.
A drvctl write that is in flight when the port is unregistered therefore waits
for serio_mutex while the unregistering task waits for that writer: a real
AB-BA deadlock, not just a lockdep false positive. mutex_lock_interruptible()
does not help as nobody signals the writer.

Reproduced in QEMU (x86_64, syzbot config, lockdep): a small program creates
and closes /dev/userio ports in a loop while 4 threads write "psmouse" to the
new port's drvctl. Unpatched kernel: the same circular-dependency splat as the
syzbot report (kn->active <-> serio_mutex, drvctl_store vs
serio_unregister_port/userio_char_release). An earlier, cruder run also left
the unregistering task blocked for >143s (hung task). Patched kernel: 20
create/close rounds complete, no lockdep report, no hang.

Fix: take serio_mutex with mutex_trylock() and restart_syscall() if busy, so
the active reference is dropped before waiting; once removal has begun the
retried write fails with -ENODEV. The only former failure, -EINTR on a signal,
is now covered by the normal syscall restart path.

The Fixes tag points at the original import: the lock order predates git
history (serio_sem) and I could not find a narrower commit.

 drivers/input/serio/serio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b02..811e65fd4eb3 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -357,7 +357,8 @@ static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, c
 	struct device_driver *drv;
 	int error;
 
-	scoped_cond_guard(mutex_intr, return -EINTR, &serio_mutex) {
+	/* Port removal holds serio_mutex and drains us: don't wait for it. */
+	scoped_cond_guard(mutex_try, return restart_syscall(), &serio_mutex) {
 		if (!strncmp(buf, "none", count)) {
 			serio_disconnect_port(serio);
 		} else if (!strncmp(buf, "reconnect", count)) {
-- 
2.43.0

