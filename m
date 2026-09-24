Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F63DA7D6
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222762; cv=none; b=LqzW3JOzD1BWisbBAhwCmfI8jk8I/bWeSN0Dz+Umm14qyPErymX9W4l+C6Z90GyeZU/pQLpdwD8B9wovjgJHiojk87X1dUj8e8cxfGmlswyTBp7i1QZgWCaIr0gK0AJcpTUyc8IvZb0QtWmAUvEr+om/CIuNg1VSHgrHMmsWRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222762; c=relaxed/simple;
	bh=VhwDNULfRsTeeYNpUUXF068Y8WCwNp3CrlFHi6vQTXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh7L4S4dbg5BTIhzSnYCrMj7aTBzQW+HeqC+GNa/9VY8dcY0Hv7ApqasRG2yNLSlxNDnOwyDnkwhaEBCFE4GT5BzYQUiiKOiGMHg/+SaWmkXk8/C/2VEdEHCrhNpo2vW00s11W8bGm4+9RWv6meGd3a519PtqOLhCzKKbyJFIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM1jF3Ch; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM1jF3Ch"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so729286a91.0
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790222761; x=1790827561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhZF8mPv+fRcVNjbFSDLsT1qu+MWxdYp9Nch/L7zjGE=;
        b=IM1jF3Ch1SJSP5lcp/+aJJ0Dt2dnzKRD/RR+zaViSZmfFXdEBdWxHu8TVhs6obz4Cp
         hY/dR+9TU3CNJspwZRUcdY6vG+GPJ9tm3aygGF89YXNrEar8B5Q0ITq/0Ra8R7uSbD0l
         YSYK+PGISsjjGQHebxAL63rnGAwhTJqwdNhbFy42MvNlsD0dmn4GGF6ScAttobhceV5a
         ojXZAKpBkuPqDc/gfqNhlkHUbztLPGL4wD5W8mQ89nYApExZrp+VI6ZUZrWRhP2zELPC
         g9qpt39HgnopKcgH72zdQKJEL/0xZtpQKS5wcQMH0mybYtPBWELJHzO7/HocI9rrn27X
         kvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790222761; x=1790827561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhZF8mPv+fRcVNjbFSDLsT1qu+MWxdYp9Nch/L7zjGE=;
        b=cUz/qYSLgnI9tJrKnRRDWs/X7i+QYr/Vm3aV14Kaqsh2Yhjvc1i9Nt0fOs/5gOM9wG
         XYVuWGs/cFgOEmtcSgSBkPXYyQglaDtzirHMXgJiSolH0J4XlTIlpSwovCHRDr6Pa7yE
         dEv5TPtPMkMLk8Z3TKUFF7UHl/xSJG54zTZj/QtTDdFzrjlAt9G1A1jaYCUra5WM21QI
         LRBr3TQnH4+IB7AiD33L2gnchK4cxg3F4t9u4sxDxmkzIqaUwiov0dXW5C/kY4xemVN+
         uy/onLDZOZslGiIGRgYmDKD2CAhA4y1WS3usJqgzBO1DkIAKcpzwRwY96Gt1HAH/Go/v
         J/5Q==
X-Gm-Message-State: AFuF++nD2wMVXDD3tHxJphCxKfKpor5gb/k6I0gaFetBPJoX4dxHWx8L
	6wBEQghNc6AZk2HVGWlbidu4u4z+2Y8RfcQExZnRndJL4CpPU/2Z09za
X-Gm-Gg: AYBFou3xNSUU9xpydkCzhbMrY6f20AUU7hA0IVEWMHu8xGUyM96VrhNoBmJ6/46R38q
	hV6n2MZwyGvqQL3ri0J6q4Fgc5hnnnirb19E5JOdMMPuICmNXtIQAep4ZTH/0zLZICDZpcDZpwq
	iwKF7uIR8SFBWZZnYP086fRb+/87Eib7Tl5Z5f+wcELqooLeqFNMoJmXQ7k4B5srXnI9RQSoZsO
	VZ4hxXlW1qXwo0il1q1a9F0Rvi3VC2P7exVmqNeOsp7ADFXFLD+yAx0/CyPBFmbAlhy4RWPgesR
	dlMqPViyxe7xRp+WBMy6jih8HnlNeqigu9xSJPz4+2r0kP72/CSiqZK4LTSiyUJp1GDDK17ZnA6
	o+dLfOjiFXnrXnj+VlJRdMtltfUzA0FeF5rL6p46s4JZAbG7S9Sk9MeGBHCVieohcqrV7jJ9Ekf
	K/qPT4B+8Zz+bg57dGdX+ExIOyGDAcZsgIDFQh6fPXZuSoRox51qz9J1rRRm3DDNCiqWnhN/YzA
	fc4nM8u6uQyS3/q8Up1eT70ko/g46wwezMoCL4=
X-Received: by 2002:a17:90a:d410:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-3a098651f1emr672367a91.14.1790222760570;
        Wed, 23 Sep 2026 21:06:00 -0700 (PDT)
Received: from thangnn-Dell.vingroup.local ([101.99.23.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09e359a9bsm259410a91.3.2026.09.23.21.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:06:00 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com,
	lkp@intel.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] Input: serio - don't sleep on serio_mutex from drvctl_store()
Date: Thu, 24 Sep 2026 11:04:30 +0700
Message-ID: <20260924040430.711439-1-ngocthang2710.1999@gmail.com>
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
 drivers/input/serio/serio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b02..5b650421e066 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -357,7 +357,8 @@ static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, c
 	struct device_driver *drv;
 	int error;
 
-	scoped_cond_guard(mutex_intr, return -EINTR, &serio_mutex) {
+	/* Port removal holds serio_mutex and drains us: don't wait for it. */
+	scoped_cond_guard(mutex_try, return -EAGAIN, &serio_mutex) {
 		if (!strncmp(buf, "none", count)) {
 			serio_disconnect_port(serio);
 		} else if (!strncmp(buf, "reconnect", count)) {

base-commit: daae2ab46e0cb612f50ca1d86cf50e5962461ae5
-- 
2.43.0

