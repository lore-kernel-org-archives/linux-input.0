Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E94B8DED;
	Thu,  2 Jul 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985766; cv=none; b=fTyJYuMclje87Gtvxw9dmJtcGVM0ig4jE50NfTI+ckTimKMSO3bdeXVyIhtqwz6H2yuDKlgNMO/Od4UJq6t3EozXgOGGX0CQyk7apmTFWbtXCtsYJf0cJhequG9w92V5LKJk5dC0G17WLH+ZF4O2wwc/mGsUT9CICEmOj26W7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985766; c=relaxed/simple;
	bh=isWFYA8ybeHHkdHMBHm+E+pTokRVq6BgCHeyjnO+wJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZW3JYD2J7B+w8bEBTAP43gBs31cMeHD7CgCm/q3W2WBFXBk6PTudnXgM04LW9AD8wVztOATGdjqEPMs0bwFsQYO4K24m8LonLd276TBPBMur/zBI+MxqNT/EfsbdVmTs+saSYPlWppZMXUfQL0E0f23xsQGl5Qj3WBttMNB2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=geDx/TS8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="geDx/TS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o+
	RD2Gl/ANOuiF6JqYBAMlYeaEToZ8LmhvFWSqRBxXM=; b=geDx/TS8JgktnxN9Rv
	nHk4yGVotltrm2H2i0wMA0kXgyszwLxz1tNjyz/RO8M7ECm/cGilIFJWkX6mWSK0
	HCXuOdQoIg8kglkG2mMTfN8voE3XtVNXuVYylClhUECvQGoHdYbmaR/KfyAwCgSY
	JOyS2jYc2kMKWmGseExwiZntw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3D1QJNEZqmQaAHQ--.59490S2;
	Thu, 02 Jul 2026 17:48:59 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2 0/2] HID: sensor: custom: Fix fields lifetime issues
Date: Thu,  2 Jul 2026 17:48:54 +0800
Message-Id: <20260702094856.1105555-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D1QJNEZqmQaAHQ--.59490S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4kCF13AFy5ury7CrW8Xrb_yoWkKrX_u3
	yDtF95Kw1DW3WkZa17CFn8J397GrZ7Zw45ZFZYyayftryxXayDGrW8trsIgr17Xa1kJr1U
	KFZ0va4xZwn7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuUDJ3UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgs7qWpGNAuX4QAA36

Hi,

This series fixes lifetime issues around sensor_inst->fields and the
sysfs attributes that can access it.

The first patch fixes the remove path by removing enable_sensor before
freeing the field attributes. enable_sensor_store() can dereference
power_state and report_state, which point into sensor_inst->fields.

The second patch fixes the original field sysfs group leak on probe
failure. It creates the field attributes before exposing enable_sensor,
then unwinds any field groups that were created before a later
sysfs_create_group() failure.

Thanks, Jiri, for the review and for pointing out the UAF concern.

Changes in v2:
- Split the fix into two patches.
- Fix the pre-existing remove path ordering issue.
- Create field attributes before exposing enable_sensor.
- Unwind already-created field sysfs groups on failure.

Haoxiang Li (2):
  HID: sensor: custom: Remove enable_sensor before freeing fields
  HID: sensor: custom: Fix field sysfs group cleanup on failure

 drivers/hid/hid-sensor-custom.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)


base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.25.1

