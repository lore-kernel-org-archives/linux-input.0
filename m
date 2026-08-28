Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EC15746F
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925830; cv=none; b=Y7HmSQV8ZjTRty1Zv8G+HXdwxw8FdbtwiG1H/+ZjyT9znHRR9ygNBIrSJNJiD6BaV5MWUvuD8AMD9MjYooc7t0VS45dPc0TY2mvtQFiS+LHaJjqRZwE16R7Gza1zDt4zYzsRYT0SVsl8yPRRZDWXjKeffO6boZHOQCLATQtKq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925830; c=relaxed/simple;
	bh=sWCjOchFpM6d/asknsANdAqdWuKgQsqJQeGpORMMkcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcOyHWKXjcLG1RS0hoxX6bRxcQFukXv/vhWqZ51oxyhCYkCYv8MihvqUbmDRGZ8KBwL9jkpQqjJQHNZC7HcpW23DQRj55PlXDdWrf61zyWDrX5HXQaIvw0BHkbgW/F7kZmRAqdBsO0g8kJOX0QB95HnPrt2TPiAqkuHDuADsbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWHBtlfJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWHBtlfJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso1347801a91.3
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787925828; x=1788530628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jpc4UopHI5TTc/u5p11DlrHMFjXp00rJXPcYkmn7WPI=;
        b=KWHBtlfJueaURhXQHbFAW5zaLdXOQzdkzuwNi4NNByYK9RIlTmO2YY1b7n0Ir9nFWo
         GGa25ngBNDT+gSZ6x6rqm0NcLU3O2mTw2CYhb+I/4T/ZrH99Wgz8CF/I2gVTQsZTp83+
         Im3RlK/tqCK0rzFSZrvgEciapv5nuDAdtjLjl8Sv4yRTWO7VbTRNreg87ZAJ2uVE70st
         ijOpJRaSZZVOUJe+Lwzv+xtXXijYc8wYN8cGNfa+81V/ExAwKBgQbY+li3PpmlNa2rYq
         8aU59R3y4TWAb9jbdoE08H0xMeakMhO8ldLMCB3roLMa6kkoPFeFnd20slaNZ8OaCn3K
         ZXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925828; x=1788530628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jpc4UopHI5TTc/u5p11DlrHMFjXp00rJXPcYkmn7WPI=;
        b=VxywI+TyVpWL7MfIUCYIjMP28S2E0UgjV/89r/C/A2j3PMq0Huu8vxgKLX7zpnf8tH
         3gDb+ncfLDrVI+YS1iuX3RxFeM4NnSN6mFIUzcKQKdVD1X6G+ACc9D+iQ7RCe4H7f4HS
         0C+FQkbtAGc64Nez2atFhPkBhniiok+jBzwOSlmGQKS3DNd/+DiZFunOzsrPIWVYMoBu
         4BsI2P8hxggdUcMiqw3dEbFZ03m3olktd+WpTnf8jG+j9sKNyiUDuMblWogYF3aAiGVh
         v9OvqEhE48d5+kRtAJU3/yVc4doOVTXhMRT8LHpH0JfeBxBagVqAfUou2NckObJPGITn
         pzzw==
X-Gm-Message-State: AFuF++klNotN50Xf4kNgM2j02gYQZ1xv0cKeqUNy1TRXK+j6z3o/PPo5
	kb+YxMg8XikLWqJ2ENQ9Ho9+MySCx9+HC8YS3HHCRaxv5IBJiT058IGFAWazpg==
X-Gm-Gg: AR+sD1204s5y+zfnh7hDr2I2OnnPVcthhOCo7JImkKzplS1flilkjgWeLCFYMZqOAMg
	z1Vzwc+4WoclLiD0DdNZsqg4p8qy+hdEVNlOobVvXNbCpi4C0AD5ib/04pUYKP/vYdHIwncSwok
	CsYRiXxeEo4xknfOAIYr3zhyczA1b3gkptstwvlX0YQFGo+Or9erp7oV3Ym8HmnyWjSIkVPd2Xe
	1KPVxyPB9QpeNV4+gww+43LBnyuL5jhoffrh3dmeNJiB577bfWzLt33cVm1Tk9PEs5z1m9PxQs9
	VkBc9JSN5cs8JT0CpA+QvnflTd9XWM96HZD/tIbY7bgkHmxFbPoqgTQr3H0vpt9r5jtZUx5meU3
	Sz5WO28PXIc9UvkUDQ+73I0mIOwvAe5FwH2/Um9K1XwNfFroIdRHG/Mp+aNNEBlRCOpdmwP/cKJ
	Dnw0qBDOCniICgbDms8MK4XQxl+qT+6BT5JkCsnh3cASpsQ2yfy16cXbtVtmW45Enb
X-Received: by 2002:a17:90b:6cd:b0:398:9bd4:d14 with SMTP id 98e67ed59e1d1-3989bd40db9mr149856a91.19.1787925828032;
        Fri, 28 Aug 2026 07:03:48 -0700 (PDT)
Received: from Default ([2409:40f4:101e:9d7e:7e26:7b81:64f6:f32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bc825sm7107186eec.9.2026.08.28.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:03:47 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
Date: Fri, 28 Aug 2026 19:33:30 +0530
Message-ID: <20260828140330.134760-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
References: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 818bebeb63dd

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5736f4bc5a50..bfad2e2ac937 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -961,7 +961,9 @@ static void atkbd_disconnect(struct serio *serio)
 {
 	struct atkbd *atkbd = atkbd_from_serio(serio);
 
+	scoped_guard(mutex_intr, &atkbd->mutex) {
 	atkbd_disable(atkbd);
+	}
 
 	input_unregister_device(atkbd->dev);
 
