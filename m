Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17F443318
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924529; cv=none; b=njqKX3nAnJoIn1coEpmSybrpTEV8VmPqjjOC9sAqJ352FSFShNz4uKBaVdKXAT6zLOKdiuPb9/SkC0GJ5Bc4SdzTSfetmTXuD48zHV//pd/meybao3ftWq05KYvvy1zw3IilUVcn5GaGoupNmLkciz7PXRmVHssaVDlReYX39to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924529; c=relaxed/simple;
	bh=GWJ4EsZYgBrXUXaQIbPxSwPOYVKWU9Py+F12PQI7d6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgessmtH61g1RkEeU0SzN2NOX///u/JAtP3l97jGcJqhJUfPWt4X517843i8DNvnrSHE/3p+verG29bFZgHmnf+mKCt8fcnCAgoq4lyAuRcIcNCyQV+X8LB5/4OApFWHWhFL1T+seQjbYthtpjQj1DFvBh+Yauhkwpcuxx1T5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWfkkyqZ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWfkkyqZ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f4dedd67b8so1242587a34.1
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787924526; x=1788529326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTTPkY3p5/l/xMtKdtMWZFZxgRcLEutJ3JS8D0c6mic=;
        b=SWfkkyqZe7NPDGWoTjxvsokF2LklFJXcM+cp32e3lYOZnwOPhlj65GWdpziT4v1wyK
         nTSLhQK0uDqI2vLeflFVPV8pdNG4YP3GfA1b8cEoLCjgmeMTK7+J7DaxSd/4j736fru8
         D/tFUFfc3+kh50CaL7xEjklTGTvYZpQ/Ig+5aa9ehulfRzSMWlUIVC9UN2AAJ11TsiQR
         pMi062SP4kBKfAQtzPGAgQf5PPa59fRTsIZgygvuV0ZadMBmVq8YHLuEeiKqb9xamR+s
         5GWSQab/pSaUGOOvNzeIA+Ot45ncWoO9jeDQZOi9ZELq63MS43AWGgkGuPf0WD49vj/+
         Sr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924526; x=1788529326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTTPkY3p5/l/xMtKdtMWZFZxgRcLEutJ3JS8D0c6mic=;
        b=p5HScVdyXNpCK7od945HaK4Ual+H+aFKW0we3JtoFkICIIAcpkP8nG036tgS+oQjzO
         2QSu0i+L78Sx8BDrhGgxZTvRQ4i1KiObT8KwWT0vIHldiv9dXtZG0Q8D3TL407RqSSil
         JZS1FFJ7fBUHeL0vIyhnr2uJbUNsksffKwJV8qOx1DNz4G+LUypyRwG/vxp4SVP/jUB7
         TZkX40CQufcBX+Z883ObRp0GvesG5xgK4s4rw9R207cKrSaMeT1QZO1tmlEGuZ2nupAe
         +pr9kYepy5AGy3Wd3VeZXKFkAbT1CuHuPAihbv1u1u3o3QECZn/5qBW27azpw61/9ZYk
         l7Xg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4ld7BCRCwkcXOv37Rt/5bHN+l/iMEcYAPpFYb5xejXsaP+AhJVJ3Jt7QMdyhJ+pgx1NxzZX+U9hRneQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nL+Wn4+KjBkB7weggIGi3WSGzQO1JTvbrRRB6zXTAXwppQ2rwU
	qoN/dtcVLgu6EmAo1zk5n7LksrCAcoAEC5PrCxIT5i8hAq5nqgb7wZ1Z
X-Gm-Gg: AR+sD100htCVVI8bWq03afU5m+V8/YsPiojIMl6zIy6RBNC2vbUpF6m7O/9/jMBcAic
	Ea1Tc+2jnXCOaQx1KQeqWo+A6tn7OxCXswfmrZuNb11uFOD16WuF/NBCAerQUuLuVQIFkvuk4Wa
	ZEATe/PXUNRfE7SMcr+FYCsqI+O+xPZriOVpIom0xrDb8lIN3i7kksWLYX7+Mc6XJ6Usu7LjMUK
	MIgafZAuZvRHmXkaK1hr34WvoRWwKzJK4FIX8GbHjDLBBCkFnjLAVtBNC+e05VjKCZfb5nKcNmR
	Es7LYI7y4Yh4j+5y4dZx9g1k+vod9jkgx4ZkdAkiikbwL/UlCK2eKDXwbn5bp7xQKctArpXXvc6
	ztI2RCeMT4I9gaE3fzK09P8ffnZCQFw9RDWdx0jhKUUg6hRtjjd4Ht1esVMxIc2e7rTwWdMxI7B
	hllFX4D+XVeHPrH7N9V4HpDBVuIvHY/+dsev0H2XLMV5IJpKWjRIn2avihKtRTlVAG7/a5rJafE
	tA=
X-Received: by 2002:a05:6820:3442:b0:6b1:705d:b29e with SMTP id 006d021491bc7-6b1c6729041mr4955953eaf.26.1787924526454;
        Fri, 28 Aug 2026 06:42:06 -0700 (PDT)
Received: from Default ([2409:40f4:101e:9d7e:7e26:7b81:64f6:f32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f80a0a5sm6783557eec.11.2026.08.28.06.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:42:05 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
Date: Fri, 28 Aug 2026 19:11:49 +0530
Message-ID: <20260828134149.128160-1-jeffinphilip14@gmail.com>
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
index 5736f4bc5a50..e235038afec6 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -694,6 +694,7 @@ static int atkbd_event(struct input_dev *dev,
 
 static inline void atkbd_enable(struct atkbd *atkbd)
 {
+	guard(mutex)(&atkbd->mutex);
 	guard(serio_pause_rx)(atkbd->ps2dev.serio);
 
 	atkbd->enabled = true;
@@ -706,6 +707,7 @@ static inline void atkbd_enable(struct atkbd *atkbd)
 
 static inline void atkbd_disable(struct atkbd *atkbd)
 {
+	guard(mutex)(&atkbd->mutex);
 	guard(serio_pause_rx)(atkbd->ps2dev.serio);
 
 	atkbd->enabled = false;
