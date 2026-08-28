Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A493AE713
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895391; cv=pass; b=B/ycJr86JIr4aPs57v38az4+IMuecVxmM7292WUqmBsMMB3nwuffrVJvgNyp2gqboDE1TMAQmwp3bTBmzotSlpdWCN6r04C66ZGMkOIKXvqkG/Zz99DOWTYao/LRwjMQqHFxfWiIwFBpVFvzfkGw68xuR4rGn7fO3qedZaXHVJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895391; c=relaxed/simple;
	bh=HhdfVWdTcT+vi7N3ZCsiVPcTL7NCwYSAZ5je+BcjOQs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=e1i7o/b+VxJkw1K7Cx8ksHijtTNNrXkmZUO1vL/KR5KsbOQvdWAuR8rDXRmClg/LG1IIf76VcxquOANDXWrLaNi0QihpaOuoIKi13Z7rXNCLSqcEvqbbZCADhubFN525bRBSQYAsfK08VxmsDFP8zDGoTOEr4tHcp03oYR2f1aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=nTsJSv9f; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="nTsJSv9f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d710632717so4102975ad.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 22:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895389; cv=none;
        d=google.com; s=arc-20260327;
        b=GDiOow/lRYuZzfFMFzPqVypCyA6eIMu9k6bYPxcCg/gmMd3q0hVFkVaRW63yfT8eZ/
         2chiEMULvSJ152jGZtrhcEto9lHvpCQRzLCD8G8HhhtAx6FBwltjnLg7ee2JVOqOXVSV
         a0TKB05I4XPkAPtNgJ6Bn4lztQT+98OCzbZNRqT9a0iejl6MPYS0vYjfxhZucx11Gq0b
         KjnVA89XIp6CWz2JJUUFL1J+luoWqhWOD5fBh8hPlm+74WVaH/3PojYT70b/RUHTgeQA
         tfx9C0dEtgtT0zqYTyjBq2srNp2LT7NH6PDEQLGg2o8aBzGInTRlAXS0pTk/YOfeaUXj
         28dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=JtzWPQulGkhYvLui8X7NukmC1Uvg0CKXqxWfiy7U+TA=;
        fh=rROFa9Y0HyEzOccLsI/BZ2S8rMHlTJ+ZnCQfyrCNSj4=;
        b=Lr9XuXXG0JJplS3DM6clHDJbwkAlOx9iFKnIL6AiNEwClsJcR8B2vBo+K84mn2ck2O
         v/0PKVHGy7l07/5uqooYpIGFp/MXYKvEt+drtsVzcECSiNlOGuwDMfpPudl9Ujoa0UI+
         hn5yfC4TPi3DVgj5aqoZEE8Xcpv878RkIviut35HP05RvR6f8WejXGbWjN6NW8ukHwta
         4oWuen8u0ipVyIKA5LU67AoqzR7DHxqOR7/d7dKWoD1qYziuXZKvY/CzwA8tI9viBxpb
         pE1UOcd6Y4CsG540fKb/ANsOrcRaieuky24kJw3Jgl0sQBaIfYJa8Qb5VFWF/T1/bILr
         2pWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895389; x=1788500189; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtzWPQulGkhYvLui8X7NukmC1Uvg0CKXqxWfiy7U+TA=;
        b=nTsJSv9fykORSZd9abt6YBnk8IvHXql4UszHk+Cwwpql1TcE40sXhbfXeaQ1LvKBgg
         HKmo3yIEFOSZGhM2YX408M/eZnDIxgh1+QwIzAB7U060WJiQDt4a4iCMECsxjBX/LFQg
         SGQbjiKNAt52wVqTRUXObgH428mi5CX5Hh9jD9PWVuIq1n4qPHjjoa8knYuIqsO5/JGo
         hfyqSNBdDfvIbluxyeHHskMCZOheE958MU79dg/RHJz/P7LB9Xk/rQaxBy0J4ID/SITi
         EEPR5b1ZtAoyqZuOH48WuOMmgoEk2NtqPJgZLAtKybc6mlIT/qr44SFQDwuQpwwD8bet
         6sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895389; x=1788500189;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JtzWPQulGkhYvLui8X7NukmC1Uvg0CKXqxWfiy7U+TA=;
        b=VreFvvxjrxcwmJO2OZfQmFWXebhJkyzDbxYpWWMwp/9IrHf3BBncEFexFpLcwe46hk
         ji71z9xZMIkqsUAn9mS75+640HDYxYxgFPTV1gJoOKz5DJuKTtgWZEkW58YSVBfFqxwW
         8oAXDupyhkJEfMT1AmpkQ64u8KzmNMeKD13ebAABjpUt14WXm2v2kuNHKr8Fyuw+qGBb
         fSp4Hanvag1/uGstDg0ZM6JSd/+qCQyGs2//0pvNRlNZqhYhhhaJhwaUywKqIjzr4zU2
         E+58/jwOEinZQ/KbsX3KIjxXwCehX29/hVzQl2axVdF5QfynlQD2EehsXCm6yFsZXGs7
         bntA==
X-Forwarded-Encrypted: i=1; AHgh+RpoXa8wq3/k6R0oqdxWAjY44dNGFW+sR2uVTK3f8wWtE2SfM/GRLQVpoTcXDdaaWJAKiKQ5H3JQpTI34w==@vger.kernel.org
X-Gm-Message-State: AFuF++navjKzrazgt05R3+V9Y3psbe/of1sayHArxnX6epNBDUj6g006
	aDdDl10/eXdVWUMChw4KljlRK+YzPXJCi+MDPDBtIh/oaiQOTrPStLeJ2C/fnVke4ru0/U4YxNr
	ud9iYhyJv1l/pnE0wDaRwb++s9cKaThLBuEdbDlJS
X-Gm-Gg: AR+sD13641jr/eE6yEq/GVD18/c/a17DOHVg17Hhod6oub88vUxQMg2g5xvW0aPA0sJ
	UqctknumNPcy/U1h0ThLmwFPolyE0HWbWmDOccG6lD9sejodjl4eVw4VJCX/PXGEVp8vG7SMoeO
	iz3vzDLbVopYUH/uPDjnjxn1ZxA/y/VpFWpP+3olpeHEQ8u0m60DbZo2nxK9UDfnXe+9nxcztfj
	iLG5vY3klMhGhdi7555Q61rmCOuPOhI2KAYRzmxv+ggOAdoj5MZOEh3PKxPayXprHSzCt+mamJ7
	HmZ5D+WY2O3MCWzMuxV5Fklya9Cwb+JKIecBQDBem+LDZK2zvkCRlq7vRRUDpjwBHRRlHQSinVZ
	2BO+OUw40AWc87VHDrKJmDr6CtiUS4CtI
X-Received: by 2002:a17:903:1448:b0:2d6:fec3:bd51 with SMTP id
 d9443c01a7336-2d74dc7acbdmr85822865ad.5.1787895388518; Thu, 27 Aug 2026
 22:36:28 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:36:28 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:36:28 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:36:28 -0700
X-Gm-Features: AcwNN1UpjGgm27LVldX_tkCH0Pbs6HI3qUBV5AFS4DZqpMhtJgjpaoKPylRPpB4
Message-ID: <CA+0ovCgaya8JEc4xmBKPbe5AbrPuaK0tUKxuOxQYMsPTQT1ALw@mail.gmail.com>
Subject: [BUG] ish_hw_start -- page fault on a PIO cookie: intel_ish_ipc maps
 an I/O BAR and dereferences it
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: falemi@asu.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/152-hid-intel-ish-ioport-bar-deref/

  BUG: unable to handle page fault for address: 000000000001c078
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:ish_hw_start+0x41/0x2d0
  Call Trace:
   <TASK>
   ish_probe+0x34d/0x460
   pci_device_probe+0x436/0xc90
   really_probe+0x267/0xaf0
   __driver_probe_device+0x1e2/0x350
   driver_probe_device+0x4f/0x240
   __device_attach_driver+0x270/0x410
   bus_for_each_drv+0x258/0x2f0
   __device_attach+0x2c5/0x450
   drivers_probe_store+0x11c/0x220

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
