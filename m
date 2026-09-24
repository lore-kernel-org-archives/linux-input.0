Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214483C870E;
	Thu, 24 Sep 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260191; cv=none; b=cJgNCERUpooWYbz+lQegMpBTKr8+N2VOjMJntOz21B4yL1ESLYt5kmzHwwmKRe8N3ncLiPTnj8pRhaKkM3pC9+WAuNCujc3uk/QlX3q2R2SHCn8Xxt7e+2hm0yAw6KAWVnq+aZBgLC+TFBAB2BzuBNuCVETOKWUghFGnOiPHVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260191; c=relaxed/simple;
	bh=r2gmN7WrWu1Ug7uWrg2mtgGaDmUErw4rQ62PZ/znh/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAORW4xecxo7pEGEvjY4vArbjPvm76iC1YqRxotepfQiFORY9gSH0GIpFOAggwD4uPi5F0A9wjsds3eVTe8L3Nvz1tTFkhSnphUrE2R5+fkRk8QZ3M3oCqKWBC/UDRm9cJFYPpd9YasIvuE6AttjBmFhij31+Q04MHsCq28Jpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ey2q4dZ7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ey2q4dZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dq
	mpuW1+0sC+uV0rZeK2nMPxxS9VPdyyYNYsqhvt/eg=; b=ey2q4dZ7bXwauv8gya
	uo1kDQlGDJa140Zw62HKhUOaGtlR5cGTIN9HHpOLjw9fRWKjIl2Lzx3ANBkiH5TQ
	ksJnVomDy87JXEtUBpxumm3WrVmB4BNsaFybPHpG2qtC3o91hzpzEj6oZG2MiFBm
	E2gPi+mIC83n9gga9S6/tfoWo=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S2;
	Thu, 24 Sep 2026 22:29:21 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/7] HID: roccat: validate raw report lengths
Date: Thu, 24 Sep 2026 22:29:10 +0800
Message-Id: <20260924142918.1177952-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy5trW8urW7Jw4kGrWDCFg_yoW8JFy8pF
	Wqka90krWrGrWkG34DXw1UC34Dtrs7JFW3KF10k3WUur1rJFyDXFWY9ayjqrZ8XF18JrZ7
	WF4qqw1kC3Wjvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizBTUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgEFP2q1M8EAiQAA3R

Roccat raw event callbacks receive the report before HID core validates
and pads its length.  Seven callbacks inspect fixed-format reports without
first ensuring that the complete report was received.

Add per-driver length checks before parsing or forwarding these reports.
The first five patches protect helpers which read fixed fields, while the
konepure and ryos patches additionally prevent a fixed-size copy of a
truncated report into the Roccat character-device event stream.

Each patch is independent and fixes the driver named in its subject.

Jiale Yao (7):
  HID: roccat: isku: reject short button reports
  HID: roccat: koneplus: reject short button reports
  HID: roccat: konepure: reject short button reports
  HID: roccat: kovaplus: reject short button reports
  HID: roccat: pyra: reject short button reports
  HID: roccat: ryos: reject short special reports
  HID: roccat: savu: reject short special reports

 drivers/hid/hid-roccat-isku.c     | 3 +++
 drivers/hid/hid-roccat-koneplus.c | 3 +++
 drivers/hid/hid-roccat-konepure.c | 3 +++
 drivers/hid/hid-roccat-kovaplus.c | 3 +++
 drivers/hid/hid-roccat-pyra.c     | 3 +++
 drivers/hid/hid-roccat-ryos.c     | 3 +++
 drivers/hid/hid-roccat-savu.c     | 3 +++
 7 files changed, 21 insertions(+)

-- 
2.34.1

