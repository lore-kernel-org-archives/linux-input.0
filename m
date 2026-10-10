Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27326FDBF
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625944; cv=none; b=iuEgK4ddj8Z9gzXj3L6Dy/SY3SpNqiYWtxPaMkXkjCZEYe27CL2DhW3lFng7D3Rdx7WwVoTahwGFefAx5qQyYf5fEUU0iTpfvpPnfH7RYXvDzscnIjp+xLlylaLsIjuGI7kzoyQ6ASMRKJFwW4p4NQagdeCvMUBpqLSXs23sCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625944; c=relaxed/simple;
	bh=mk5d9tC24rGNkVl4N2wjp+2iHC1JHLrMtiHh8SzfUh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+m0Xyj30hBRw0gDZhoU64uX2bKbEeKTaWaMhHBxU4R1TARJiA6E+74d+URQIO4BRPKEflg4GTQKrkadn6rgyDtEjxTlEIZw9e9FmW+oPwQZm2aLtdI8XGsVtVQg29+O/DqSFmfdq5BYtAwUmvQSwTAJDYU95hpQ7zL8ybAtBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUxhHV2k; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUxhHV2k"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-356b1e20700so795595eec.1
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791625942; x=1792230742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pPSekHCdqwAP9xCOYutxpz0IcPAFNRJuReHEkaVZhQ=;
        b=lUxhHV2k/uAbqKhA2n7PabJT4Tl7fqdHUT0j4a2kIRL5jzIuz6CSfXGFgfkmIRD15t
         UTc5mcpsn4VQ8Dv7qj5UV+nQN4KO1ZvjnUfrOULyAHnYX3VmiJBjrpVOz5CqUZRLWPHv
         c3gUsbb392AB8GYlrrLF6jTHOsZouweLlXczdgVGJz+fDL6B5CyIutdsJvXLqohkq8w4
         fsqMY391qdCD99/dtnL1gK8+BdkVCTjOtcfXPP3K7bA7aLibI88ttHWbhuvJsSedbCM6
         7kemg4e+H2Zt39dlaO8q6P/xxdQa8lodxYfY8KBXRMZxNvO9YSb69Louj7KG7um07pSw
         1ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791625942; x=1792230742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pPSekHCdqwAP9xCOYutxpz0IcPAFNRJuReHEkaVZhQ=;
        b=XtuL3IQz8AnL0zU1tMN6+SwrfzyU57KzWX2pSbhGjMvE5Jx9dafOwr9sRGmPiB7Amh
         nMJpptZH41COIX/ZK9xP6g0K+3EFbj5HPRjVU90CaHQZCYvb4srInih7gRazMXQ3kpzl
         gBzY0/tkZ0cFNpTGrULsOjx/QQ1lVYAvAf5CT6z+nVgY0jg89jQUOB5ftE33tMzx8IG0
         7xsFd0mkUECCbigXKGQg11cotS9PCFpqj7Nd72sSj7885ZfLxRKvrbaxjR5RNdN58r4V
         AjPeLbUwMiqfjqyYA+jA2u38U99GSXp2oOrr7f/2bhX640FTSzGm3eMfKOBl0OUmA++X
         SbQA==
X-Forwarded-Encrypted: i=1; AKwUvBzyTeEUbQcRmmU73SVIay/thq8HARfD66EMsiK+dNdjab24VIlYW6y5tUl2R7T0DMcv7soIZEeHI4UKxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKADecevgmu26fmAPNem2AePkMRytDHOzNdXlVvzMkkxpL7B0hV
	c6yloxeau88d5JpJ1iwzUku3tH/LreFYCIaBKCRTRoE+oCLR7vQjf3bqD9HC7s1v
X-Gm-Gg: AYBFou0cO9scOaMHpWVa4Qee6nMYaUqUw1fl5G52mhj4y2tlqmrO0UQXaKcgnjt1x64
	kGD4Km0bQSkEFjWQDA8VtYMWDjSdqy0Q+LfMygDzBWqv/3i9anP1zUqqQPQjKom31YvqzsDfO15
	eQeXPfyVprdVSUQe0RIEgG3mFb/OYT8PEV0bwpfd9GKW9UCsZtYyFz7tDbHYkeNTiP2c03gcwyB
	7gDOf20uMuAoyox01eoE0ntuv0flT1ObnmiZqL6p2XnAlkwg43zOZgURVakZBYk0m5u4aHdpfQX
	xzvpGdQHorc9hR+XNRn2zcYpqOAC9MVZkWGGTSo3/VoUmjMyIcZPAZPHgG1V9wpuCsZGluzv43E
	L0kNbgD4nm8air5qHe0DHdDauvynqXfcwpoLk9s8g2RO0VSVvqGC0QqamU6px9cE3FMbp9FbRCh
	Z3ts9ZAx+E56DT/Oyvk1Vc7RzScmMXFBsHNJH3L8EF6v9M9ddw7DenaFVIGSOZBZCy+nIpjo8qk
	h5UjIAMR/5RClhT0qPqmlyVLUEyjnjZ0KV1Y522Icf1BX9lvvOqZPS2m5u+hgoJPSeQ0k8yZsfC
	I9bdWIPCD+nbFoj1Xiz99DTRJ1lLcCa9zlerOU05PkY=
X-Received: by 2002:a05:701b:454f:10b0:14e:5e6b:e6e2 with SMTP id a92af1059eb24-16a13a7b96emr5516674c88.18.1791625942124;
        Sat, 10 Oct 2026 02:52:22 -0700 (PDT)
Received: from arch.taild3b82f.ts.net ([2401:4900:ad48:72a2:ee93:5e1d:7172:c27b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567bd18sm12615815c88.21.2026.10.10.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:52:21 -0700 (PDT)
From: Krish Gulati <krishgulati7@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krish Gulati <krishgulati7@gmail.com>,
	syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] HID: core: serialize report_descriptor_read() against probe and remove
Date: Sat, 10 Oct 2026 15:21:02 +0530
Message-ID: <20261010095211.12831-1-krishgulati7@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 54f32fd5dff9 ("HID: Make report_descriptor available for
all devices"), the "report_descriptor" sysfs attribute is part of the
device's attribute group, so it exists from device_add() until
device_del(). It reads hdev->rdesc, but that buffer only lives from
hid_open_report() until hid_close_report(), that is, for the duration
of a driver binding. For a driver with a report_fixup() callback,
rdesc is a private copy that hid_close_report() frees, so a read that
races with the driver being unbound accesses freed memory. syzbot
reports this as:

  BUG: KASAN: slab-use-after-free in report_descriptor_read+0xb5/0x100
  Read of size 24 at addr ffff888078d61f00 by task fido_id/7281
  ...
  Allocated by task 10:
   kmemdup_noprof+0x2b/0x70
   hid_open_report+0x1fa/0xf00
   lg_probe+0x29c/0x890
   hid_device_probe+0x46a/0x870
   ...

Because hid_close_report() also clears rdesc and rsize, the same missing
serialization can make the reader see a NULL rdesc with a non-zero
rsize.

Hold the device lock in report_descriptor_read(). The driver core
already holds it across probe and remove, so a read can no longer
overlap with them.

Reported-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com
Tested-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
Fixes: 54f32fd5dff9 ("HID: Make report_descriptor available for all devices")
Cc: stable@vger.kernel.org
Signed-off-by: Krish Gulati <krishgulati7@gmail.com>
---
 drivers/hid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cd..824557a02544 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2270,6 +2270,8 @@ report_descriptor_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct hid_device *hdev = to_hid_device(dev);
 
+	guard(device)(dev);
+
 	if (off >= hdev->rsize)
 		return 0;
 
-- 
2.56.0

