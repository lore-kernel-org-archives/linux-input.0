Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166469;
	b=WyiAuX5e+dtidrTG3uwFMniR9XhHDOL6qX/QF85ByzJFQokhtMpDc9f035YFBERIJkSb
	 SLR/Xhib9TxdNmIpMGo6DTk4oJ3vb2N+ZTCpqRhv34kyy/Zk0pDBc2GR0V6kdisBlHvTJ
	 xIqUz/InRlNSczofDA5DBHx4PfpV2awgxe+B7t3XYkMqrSghqqG21sNyyjoLlsQo/q83d
	 W9SxkIVo5zgUxyfYb9z0LMd1nF/0zTLrnlDVxUf0pua4nxKf+N/9S2PwkE8rARQeIZeYw
	 20R4wMnfAk7RiLkzjSK2WLZ7iTTGp8FsN+BqRfs53DT5feEudFfu5hWlAI+RqMTKtYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
	b=15uFr0omtoN9b7ek5BYxQV/IjaOQTUq+G+DBvPg5YnN9QdHXFeVgTcxC20bWxCl4BG7X
	 K2HPHNdFS9idZi+5sCYiL6jrKSQiA4HiDSEr/1iHqXfGe78ubmIT8OudsC5lblIiJRl85
	 Z4cXbDqd5PmDUZj03o4NI/Ac3R6HaJ/QYE3cy0n90Md872y60NvU1QMrZIO6sbl2IkZPb
	 +ZU88ngCbmlLkGPUy2qsDRVdQ45451hMgoXzp+Quxr/l2Ls7S5A/c5oI2JcDVriJofbs1
	 5OWxGjbiUJmKWI0VBNwMp2ZrZTcoC56n1Kk0Uno7M59/OpjdXG2Al515zoc2Ocs9V8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQ3g3y2I;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA5606A32C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 09:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAA5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQ3g3y2I
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f04fab527eso506485ad.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795166468; x=1795771268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
        b=rQ3g3y2IL2zrMre3y5vaxvoU2PJFhCxhGGu3jL5PeGB5tkMt3DNDpPCsZuFu4lpNLv
         Nrt1lzQGPj0HHKFbailIiiZNezPcmJHnJGnH1YOQV8g9TO9sNv4kjY/AeTzcGqQg4hTj
         dQdJcmJGK4qfmx09fQ4XRYYFbbdV6wP9MgXBgBmErOPNq/qHfY/t90GhKgOK/Z1fbXF+
         nlNzDhDbHtjlmPKUhSBmAN9h0I/SpSVxBCL5o+uayybp/M7oieExuh0Md/qznytR2NkU
         ZAkvFD9DlQ382LkZZ+Bbx1QDOlt1MsUcKglVu5/77F+C1Dn8JTs4LTYHBc3qkZDpmSt6
         Nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166468; x=1795771268;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
        b=ephHcJ+kvBRhctaGAOJyp3XmY02bP2jG11jx2uc7g9gtE3P02UM4afa4K70JEwdvks
         jYiHUt2otCQiS7vL/2QQWTfCFV+Y6qmG2rNGGhwFINMOWMFtHAoURvFVP3MDaZkAmthe
         StlDKgv7UjWSRJZbgVE77L4KJYwBdjNEhtuuJdkjqa/8aokAe+29jOHB2vClVMbZtBTI
         JpVDXMMQ6mD8ia8UxAAMyIjSGypfGWCACjDWM6xedlL5vdC8vew0w7MMmjUgaXgs5wC7
         PIlYeBQQVSnupdWbQ7hnzvFFxnrFAT2H+kT/IWIfVnGTnDnk1erGAYmHrWS9dmqzVuow
         B7gA==
X-Forwarded-Encrypted: i=1; AL+hErGTOqfPnRhqpCmrEH/+wNDSAFJB2nPQFj2segdgAah9IfTZi4bJJw6z7dax/gI5YqSPvsh3PQXC6ifMEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GQzduUQTRPk83V5/0m5M0NmnfZyljPYpc7vBGWR5fkcuXV1sC
	JPtd6bRJ6RKWoa7FE5ozgx1PEm//z6LbcrgdrCoL2EydAvj25WC7S2OT
X-Gm-Gg: AZFdTZd6Kfa//nJO0W8X0K/AiEU1H3uLC1tb+k8K76Uy/1jIX2yJPCMJlbwZtJiVs+x
	lPjRC96OjF6Mz59wOzkkmFOCtvSXHTaNEUSuMvNGmoPPS2F6+5+YVXcotlxz7M8oTVk7klgP4Cv
	N9oEew+lz9lqRtWCsdqDYmTpfMDuRE/wQ2KCTTmBqu3WQTHqgHrdcj9Ttpw+h0RlOyusZ8PSlyj
	8MhiBwsk1AkuDGPmXW3wUsgE7Qt7baaLilJ8ce3bWUdr+Y9dFjZjS5tYqlAKFyXQLKuiayA6HiY
	06z6+pknSwL0TCHnP3jgJrLrcH9UL3BIT2IWVKKjinfAWbidbjFkrlppT3aDgbfLnTa17Zi44Hu
	TpPvadlZLfSM4ErT7+pwhJWRUVCJ4bYghVcXMFNlOanciL/DXUs+oZZnKftojXdxR86Jr5B4zNY
	LdkXX0Plg1mtJdzFO5DXCZ/YuVKtIP5nj9p8++rLj5tfzeK1lcDImK/FU8LLkOl8bw7RMONOoz4
	52PoDxD07RIe7JPBrbkPNfwn/JQqDjk0POg/1uPhW/PkUs3BdWi2m03pJrnJyMk1GMFtaCd3g6l
	5cep+AWPqyV2sIT+Xj3JctID4yqB1XwDDSFyjI/xkOOL90epwofAsrJUjFMqlirHD+3D8A==
X-Received: by 2002:a17:902:cecb:b0:2f0:45a7:5d10 with SMTP id d9443c01a7336-2f045a76530mr15520125ad.8.1795166467860;
        Fri, 20 Nov 2026 01:21:07 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1482c3sm11409575ad.73.2026.11.20.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:21:07 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
Subject: 
 [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Fri, 20 Nov 2026 15:56:58 +0800
Message-ID: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
sensor hub removal.

sensor_hub_remove() currently holds sensor_data->lock while calling
device_for_each_child(). The child iteration enters the device core and may
acquire the klist lock. Since sensor_data->lock is also acquired with
interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
lock-order inversion.

The callback only needs sensor_data->lock while checking pending.status and
completing pending.ready. Pass sensor_data to the callback and take the lock
only around that short critical section instead of holding it across
device_for_each_child().

This preserves synchronization of pending.status while avoiding the lock-order
dependency between sensor_data->lock and the device core's klist lock.

The syzbot report is available at:
https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29ac9c0dea=
1f

Testing:
- Reproduced the target lockdep warning with the unmodified kernel in 3/3
  two-CPU QEMU runs.
- The warning was absent with this patch in 3/3 equivalent runs.
- Ran the HID selftests against both baseline and patched kernels:
  hid_bpf: 45 passed, 1 skipped, 0 failed
  hidraw: 27 passed, 0 failed
  hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
  hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
- hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=3D2 in both
  kernels because no executable test cases were collected in this minimal
  QEMU environment.
- No KASAN report, use-after-free, Oops, BUG, panic, or general protection
  fault was observed.
- checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.

Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspo=
tmail.com
Closes: https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29=
ac9c0dea1f
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc5..62799c26e6ec3 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -804,9 +804,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
+	struct sensor_hub_data *sensor_data =3D data;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&sensor_data->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sensor_data->lock, flags);
=20
 	return 0;
 }
@@ -814,16 +818,13 @@ static int sensor_hub_finalize_pending_fn(struct device=
 *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
-	unsigned long flags;
=20
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
=20
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
=20
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);

