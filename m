Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799833976B8;
	Tue,  7 Jul 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408581; cv=none; b=Vnk6IUzQuaIx/ZyheZPjkIHeZIqm/ZIDL7Qaxoud604n6tUQH91cSZg7fwUcyTvOU7JCNxPA8W+8nSgAckAW9Tiej5eb9Yz6xRFK37YFGKvkstNbUzzGup4VTaOA5IoUV6BxOrqWMj+QQtrR34/jLOERKc9JPhFbUWFgsV+LpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408581; c=relaxed/simple;
	bh=xjI1iVkkveTyZ7hEsKdG3O68jk7SBRuM9GmVV+Icae0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RbvP4vDDAv8Fpk4E2HbFQc+gktjjB9RFQN0r52V/0WwlmsuxIKY+4hRfdKhflfcWbnf1kLinOCzVMvexmvhsDRaBRJo9JFQMnYOy7EGecKyN8dYWpZv4KzylQibFcnzlm6OnR5f7dCB/2OskNwtZuR4pC/v/fInIlWDevm+Mn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IjJfVh5M; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IjJfVh5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tg
	lNO5fBuKy0mHgk1cSA7ImpXm9ObpMn8awOSx2Urt4=; b=IjJfVh5MBrLBw2FArI
	tbu0f1oNT3CYvu7oIcHnt+8vJ7zCNjTNsMR+SovwXrzTsNdnEfL/pxOihr6EaFCh
	gjRaHCGsSUH+1K8hMB8/J1Xbefny3bMNzUibg5wG1sNOfbchka2JPKaQK3sbue7K
	p2Nc/UgQ+90MJL18C58F7xXoA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n5Cqp0xq6RclIA--.54200S2;
	Tue, 07 Jul 2026 15:15:55 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v3 0/2] HID: sensor: custom: Fix fields lifetime issues
Date: Tue,  7 Jul 2026 15:15:43 +0800
Message-Id: <20260707071545.3087073-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n5Cqp0xq6RclIA--.54200S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW3JrWkWr43WF48Wr4kJFb_yoW8JFWrpF
	Z5Jw15Kw4ktrZFgFsxAa12gF9Ykr4rJFyqvry0gwn3Ww15Cryktr4rKw1jv3yqqFZ7Kw1U
	G3yFq3ZxCFyDCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJ5rnUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgvBMGpMp6tCkwAA3H

Hi,

This series fixes lifetime issues around sensor_inst->fields and the
sysfs attributes that can access it.

The first patch creates the field attributes before exposing enable_sensor
and removes enable_sensor before freeing the field attributes. This keeps
enable_sensor from accessing power_state and report_state pointers after
the fields array has been freed.

The second patch fixes the original field sysfs group leak on probe
failure by unwinding any field groups that were created before a later
sysfs_create_group() failure.

Changes in v3:
 - Move the enable_sensor registration reorder from patch 2 to patch 1.
 - Add a comment explaining why enable_sensor is removed before fields.
 - Add Reported-by and Link tags for the Sashiko review.
 - Keep patch 2 focused on the field sysfs group cleanup. Tanks, Jonathan!

Changes in v2:
 - Split the fix into two patches.
 - Unwind already-created field sysfs groups on failure. Thanks, Jiri!

Haoxiang Li (2):
  HID: sensor: custom: Fix use-after-free in enable_sensor
  HID: sensor: custom: Fix field sysfs group cleanup on failure

 drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)


base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.25.1

