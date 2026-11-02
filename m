Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620729;
	b=RrwighuXVH2NjZGBmmnJEWRK8atNg2xdhyv/cp7B8TEMmXXPOkySc3XP5BsvynTgiBjq
	 kNGEp0bo0FwFfBwUhXBJ8GnDQFQU/AQfjuEDpc7khxyLDiaPTfRJqz5nts8BGT2/A78dP
	 v3sR/UBAixNjF1yeJ8feAguuvFKwsCMTwxaGstB122EiGHzDSOwn0NSD5Jew6uU8aEZ9h
	 OldZNQMmN+ZRlyRAZhWCGX4PW6GLsRFhqPkiArZnBaiympqpMWi5eKmiYYbUyq5VarClg
	 9qEnVusyD3najJN3l/TB4i3bumlvKDemaOZ6muPbd3EkzXXkuFKCEgmOg/Z7ED8G4qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620729;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=zVFQMgQShU+vaSouBXtBcMxrLmbWMH7wOx1Se8cHqJM=;
	b=eq9cyFwC0ACGWaNfrI6miRsvkFjhHHPxHXGlhUQWuAJTWP0gbMNA1RnjefzuD0CCLaBU
	 uuTCJjnGzqXxy3jM2eajk8dxi0L3fivrPudhPZR95mE1+yWz4Ey1oTRTBqJ9D0lcqYN0X
	 jIfV+g3u9vKYwBXuhK21wMqNUOgUzmBSXLTLm79E8fZesjO4xjVjzlNA3AUSGOdHKjjVL
	 WsoAgrODzEJe4OLbkFIXM+tk+xNF4vpr5330jbBdds+ECDep4QwJN+9/ZB0wENx8rh5p+
	 Z2OzxXmetdQi/CJkLPTZLHUrl9ddwalvRCkwLKIGCJzDedTnHf1K+sGi3TXK2Vra5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=G5lBgGCj;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20C606A339;
	Mon,  2 Nov 2026 11:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F20C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=G5lBgGCj
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2350;
	Mon, 2 Nov 2026 19:58:45 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Tomasz =?utf-8?q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Oleg Makarenko <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Anssi Hannula <anssi.hannula@gmail.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.11607321878213733518@stu.pku.edu.cn>
Subject: [PATCH] HID: pidff: validate effect type usage indexes
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
X-HM-Tid: 0aa19c204d3403a2kunmab045f0fe84ea
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSR1JVkNPSBhMTEtKGUNITlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTU
	NVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=G5lBgGCjnE6KtnruIUQG9Z2kNXtf8IikOjnk6yykDutdvFR/Smdwmpoag6TBuio8Ugnkz5natvmPIfhv2JYY6Z2d7lv6jgn0L8Nt56bku1WRso8ip/pMhoGr8TYnxoWdLauHnBMhLPsTy7DyXc7PAcFtqKtygYqnpG1GSpex3z4=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=zVFQMgQShU+vaSouBXtBcMxrLmbWMH7wOx1Se8cHqJM=;
	h=date:mime-version:subject:message-id:from;

pidff_find_special_keys() records usage positions as one-based values, but
pidff_find_effects() uses those values directly as array indexes.  The
Create New Effect and Set Effect fields are independently allocated and
need not have the same number of usages, so a malformed descriptor can
make the lookup leave the Set Effect usage array.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in hid_pidff_init_with_quirks
  Read of size 4
  hid_pidff_init_with_quirks
  universal_pidff_probe
  hid_device_probe
  uhid_device_add_worker

Convert the stored position back to a zero-based index and validate it
against both fields before comparing the usages.

The reproducer is rejected without a KASAN report with this change.

Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 drivers/hid/usbhid/hid-pidff.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 22951b7ecd174..5e4a937237d55 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1373,9 +1373,16 @@ static int pidff_find_effects(struct pidff_device *pid=
ff,
=20
 	for (i =3D 0; i < ARRAY_SIZE(pidff_effect_types); i++) {
 		int pidff_type =3D pidff->type_id[i];
+		int usage_index;
=20
-		if (pidff->set_effect_type->usage[pidff_type].hid !=3D
-		    pidff->create_new_effect_type->usage[pidff_type].hid) {
+		if (!pidff_type)
+			continue;
+
+		usage_index =3D pidff_type - 1;
+		if (usage_index >=3D pidff->set_effect_type->maxusage ||
+		    usage_index >=3D pidff->create_new_effect_type->maxusage ||
+		    pidff->set_effect_type->usage[usage_index].hid !=3D
+		    pidff->create_new_effect_type->usage[usage_index].hid) {
 			hid_err(pidff->hid,
 				"effect type number %d is invalid\n", i);
 			return -1;
--=20
2.39.5 (Apple Git-154)
