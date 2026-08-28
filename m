Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA844C508
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921687; cv=none; b=iy8L5ifhVw/W89mQ4voW3n87SXfN60qsNdgc3qI0lIIpttMBGH5F4W56imsZedH5aJq74ZjQnKYy9I1S4kjohN6OAFRSvRGJpaH0rzLELDDLoHuACExMr4USfDRccHjzyJ0ZN7C7844OdYMgzD0Z7xzMCNriQAdVa6IOWdJkl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921687; c=relaxed/simple;
	bh=wc+vvhQ+dNmyiyK6AVxTIJHxL2dc2ZcZe9QfHmSZUIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRABGJtS3XvIvymD/WiohOplsuLdqFTMZwV7qH//wvjgPEValnx7l80VdtWRIL9aeBLdgZY89S5epJqyn+GkYLYbmgLAoxv8l8IvdcVDhlmepzcW9FsySTlMDKinHhwRmQrsUFiqRVmVUkjFab3X43OJD5LfM3oepuGmlgS6COE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMI88nze; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMI88nze"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1085461a12.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787921685; x=1788526485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/VYSNIA4jxHryEAnHq111uwk8QXMnh2ArI3dQwMk8M=;
        b=LMI88nze3W6yNjIZFdB9lRCJb93m0gwTAgk/fWO3AyBmjJcLeNMjGGN5SgE11pu9Bc
         AN/sJdLPpTvPaZaZRhI0RuYF/vId6HlqwtA1PbYLF1TQHf8/v7/Q02zxiQx3wxLRxXA/
         uPrbFp3LC9cDKVyoVp7L45feor/16yIg/g21P18LYdSq+4TidhnVCARVYRQxoBszGqCW
         CQpBxkhJ4g2p9A2pbImBZ1CbkCN1dK70Ck/cCjrI/+VCPqwZzGTipYxLdCLk12mvuiDR
         6pziSXmdD8aE5hLGyhUnHjjfUKwALGf0hRqBsdCxVb8q8eQPTK7BtH+nZ7bJYMUbwVO5
         CSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921685; x=1788526485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/VYSNIA4jxHryEAnHq111uwk8QXMnh2ArI3dQwMk8M=;
        b=feMzEemMzvk8kr+HRtO5/hGe1yNkLZZdRde5ImBPzG1EmXNyNhP1RIVU9zJmT8cpTO
         LC7sHPX9tIsS+58lgCgsBmbgwbOn+vj6s95TIP51G0TYzdsAuimDBmffkZzPAdV9gzDr
         rJFjjfs1yxSR97xHroZy8egXCvOCz3/l1fUj6XgHhKu7tgNlHTE1CpJWj5GMIIv4L9yX
         4W09SwZZrq8tY3FGeKWWVtRu0jtUqFZDzNIvCluU8LV1wlVRMf8p7Hw21QOWi3mEXoa3
         MKhEpF48vlY2jMhc4/yMRGw2aMDwVQWlniqxxS/w5IFExoVxYY9Dw1gEBEkPPKVtow3N
         0Chg==
X-Forwarded-Encrypted: i=1; AHgh+RoS21GRUa1NqXif/OpqGSBbBUaHeUbruPpBYNcJqqlqlJN8dJNPJg6sfRwKbnF/UNy2qxxoEkCqHx3TIQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lrairqvubSOICdQdvCPLkZr0c5FfPrYQLqjZf2KpFzaL3dYXnE
	RO9kGNf4ZHChgI81rX0JM1NQs+xZykwhBC96rg+NqY8Uvoqj9YfUdrmK
X-Gm-Gg: AR+sD11gnPeiAOBJiSYR6wG73+7fZiV4oFQHoD7Sl61S1PPPTjMD1xzq1WYcUcl4g4r
	PSX0MT5lmHxUDCjv+hsaec8U6dEwPOA//lEAgoPnUg2gW4QgzwD/mfgBBG02RM6RI92nPpxFQP7
	YCeiv+VimXH3nWlKPTukl8NP+HpmiLzi1nN3bz/LFCee/b1NhM28hnOb72IiBKTnurAcJpxUXf2
	QLnQX08D7AqZd34GfkYNqWGbsZ8uT0679Q2QFBmX6YPoIXgomlqs8W5ch7oW3rGIOMl1GnvqqBG
	Q0ZJoqrJG9fB1HPmV2m4JoVU1oKjP5j2eLEaMmSyUgnM4JHtsYehxPAgFvCOqlrosyHI7FklhOW
	mzfDj1bAgv/ohyf5ZZcSCYqPUKLDh0DQEeyeap3qlvm2UkU4vvLS5CeMHwQ5EeIo/LuneYmcViA
	kwjYbT0Rs9v9HNk7IGqHYDx4ackcqvuZ2eGVdz+u/iOaruW8t+mcWmhPwmSuEMZMBD
X-Received: by 2002:a17:90b:440c:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-396d0eab08bmr13666774a91.6.1787921685323;
        Fri, 28 Aug 2026 05:54:45 -0700 (PDT)
Received: from Default ([2409:40f4:101e:9d7e:7e26:7b81:64f6:f32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc898dsm5897027c88.9.2026.08.28.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:54:44 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
Date: Fri, 28 Aug 2026 18:24:30 +0530
Message-ID: <20260828125430.11470-1-jeffinphilip14@gmail.com>
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
index 5736f4bc5a50..056aa98f13e2 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -706,6 +706,7 @@ static inline void atkbd_enable(struct atkbd *atkbd)
 
 static inline void atkbd_disable(struct atkbd *atkbd)
 {
+	guard(mutex)(atkbd->mutex);
 	guard(serio_pause_rx)(atkbd->ps2dev.serio);
 
 	atkbd->enabled = false;
