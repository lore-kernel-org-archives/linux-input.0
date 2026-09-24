Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF63B5854
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224431; cv=none; b=I9cJL9zvaTf+MNEaL5+D9l0/GKjBkJRoukWGkUos1VTLIVH6raBPDkd4YPmk6PYUlujzlUOfMJlidPmM25jDwchJZJmxpEnR1kfJ4JOKlSMqqJgYmESUeC7N0/xnddtamTJb6p3pYRQ8OBHsPsAg3ruFut3w+qBR6WvWMjg9s18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224431; c=relaxed/simple;
	bh=udQ5SvOfEFJRoSpEeM2DTmvXBIixvY25zbrzK65E2+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVcIAx074VN1+HKMtNE/RHePPvvo8L94EY/6wYDdklWAtGbnmsWtx6yEMwZsXad28fjIGRqMvAy5jo5Z2uGop6uYePTxkgItENGVmgxUCiR1leMf2edBKzyXv/73OEISEGr62KWLoRc9pWJSZV68IM5R247H7cN/DhrVhJftUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIjHevZr; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIjHevZr"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so8586025ad.3
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224429; x=1790829229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4vvzIu3QIeoIKEnWqNtiV06AkWPOeNhNL2yLykrai0=;
        b=IIjHevZr5JUqk9b2CO56O2f6LcacqkD1hzfcD6CjAA3iaexSZF+QoicphYN8AWyjhh
         XumI12HVXAar9JpWoe34etpzhjhv1YpjPL0ewRSATlJXdBwBzcYr8ifeZQkzn5nIQ2xW
         7qB+sC13i9ocED3LXhABxpnHX6brSAaHKo/i4pKv7KriUOENmAezHyFnKPCkZiRvrQWD
         Z4i5InmMwUJRekR7wN1rKzi39s3IVCDtBDIeMT6M9VOvD9TGvwG3iia0R4EMVLao1Ln/
         fr59vuKnNUbQMiG1P+I4xMSYuF2Hh0wcUSRBP0mYYe+g3AOKuDykuJx6GkO59/uzeDWQ
         +Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224429; x=1790829229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4vvzIu3QIeoIKEnWqNtiV06AkWPOeNhNL2yLykrai0=;
        b=nv/7S1/conukngqJ8tvQFLhfNG00+fe7uPptFqHC9gdZXVVdT77o5ZNrcvNjXEm5mp
         8C3gfw160txTTwkG376ifzW98LYdEY7IhDAOkM3E23Xbsil80lFqhZNzx1lw8HVzh8kt
         t0p4AF3JFab/4YWqFm3bDRqFDKQM091tvZLyPr29OXXjZUf4PB3w8bxJ+c48k7+RBXEw
         Lw9TKzuIwiNDmUQwnOi+28gIPzDENW/zM8qwevZpMNAD4iZEfqKNdQUPNYIBC1k1yPeX
         BP0vo8ePOF2mhL8bMOtW0ysAazSX1PTv0XPs4Hncf3TgklszK6gUpyxShUktuidfT7Bm
         N2Qg==
X-Gm-Message-State: AFuF++k214lJzrLwHLP7vzezK0RibNYV3Mn/g4SxRHPy1csrNOjiKQ46
	ySVEFkyng2zwjJ2jyoYOwTsrhgbvvzb2SsgCCx9e4nL+9iv6jxoetwOH
X-Gm-Gg: AYBFou0lBWYekMjNG9uS71Ix/ZSUnGw9E8wflvCgPB0gKNGmDjKlv0Hmg0ddgR3HG/t
	Csa22mCuFiBQiyHWtI9y0Gc8bmcFiRuiyu7pLaIGfVrl8m7C0sOpvbPdrtzx0aVEh+NxdATMEL1
	6ROIVxgosKOY58AlMTn+v4iMRzRvr/5/kUMu+Uw4QClOt9EFJhh1LCfA1kYGwvwn1EY663XBXCH
	JGrMKVFLEPNItBHQr8cd7wIg5TF1dJ2RMwWhz+B41sTIfRv6hp93AO0j8qDKBAAkR7WU8/xjnK/
	Tehq5cUySNBlxjmT241aMfhh3e+sY/Ae1fcIQ8XFoLIeUq0wDGApiww59hsicfA7cSEtqkewLYj
	2PUtkCdSYqDGgmbJEGhRvAx5VwMoZ3XwpEZ0pzNY5G2msW7dY0z5VVqgqEmA0fuPXdTCzOnZruS
	GXFBFm50xaRc4FFb+t7RsTy9edjPk0+ypYt9UnlxPPzr2s3sJt7ns+F9B+c/oCLgeCg4V06SBHe
	uLMVrHySNTmLvBtClC50XaE91+d9RGAWuU7y4Eu
X-Received: by 2002:a17:903:24d:b0:2dd:c100:b2c3 with SMTP id d9443c01a7336-2df7dc48c22mr10231635ad.46.1790224429058;
        Wed, 23 Sep 2026 21:33:49 -0700 (PDT)
Received: from thangnn-Dell.vingroup.local ([101.99.14.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a982esm19662755ad.22.2026.09.23.21.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:33:48 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com,
	lkp@intel.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v3] Input: serio - don't sleep on serio_mutex from drvctl_store()
Date: Thu, 24 Sep 2026 11:32:02 +0700
Message-ID: <20260924043202.719245-1-ngocthang2710.1999@gmail.com>
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
 drivers/input/serio/serio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b02..ebee89adc8a6 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -15,6 +15,7 @@
 #include <linux/serio.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
@@ -357,7 +358,8 @@ static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, c
 	struct device_driver *drv;
 	int error;
 
-	scoped_cond_guard(mutex_intr, return -EINTR, &serio_mutex) {
+	/* Removal holds serio_mutex and waits for us: retry, don't sleep. */
+	scoped_cond_guard(mutex_try, return restart_syscall(), &serio_mutex) {
 		if (!strncmp(buf, "none", count)) {
 			serio_disconnect_port(serio);
 		} else if (!strncmp(buf, "reconnect", count)) {

base-commit: daae2ab46e0cb612f50ca1d86cf50e5962461ae5
-- 
2.43.0

