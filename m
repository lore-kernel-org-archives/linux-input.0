Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB416367B7E
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497340; cv=none; b=tO7lRz7BP1+Q9RmRgvTG6icwt9siQLhwvpzF8Eqh+aPLMn+u4SjbEtQLD4zlcEIF4pBrHtMtDzSoHUbZPTfZdcGU2Ejr1jJ3yCAcRhqySiIU/MqFa4me3UVQdQ3VS72BYQttMihHu+g6WGlikFjK273/hk34HFnM4gF0yu0kS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497340; c=relaxed/simple;
	bh=NFSwerRALXlOFSN7lX5GhnIdiyv+BGv/J0cgE+xjJOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTAOLkP4a54Y0ClXU/oN/L6zBuK+PKr4M1RUPdqWcGX7oHxc1Aenv3UNoTEqSrAI3kw0EZZcBTI+DMZNmU6fRQDZkfU+Oa841QQUeUIWtmFP20zpNLzDyT2s/KGbXzsyCJqer3WQKjbqzQudKxnyEQa3c0lF1sb63XmTreoN7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=TaBpwMxC; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="TaBpwMxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497332; bh=NFSwerRALXlOFSN7lX5GhnIdiyv+BGv/J0cgE+xjJOc=;
	h=From:To:Cc:Subject:Date:From;
	b=TaBpwMxChKh+HURPd2fdQfy1I/tJyJMfpVUsI0UbxrCqmbqgmMMjtLYWFhkoIL7gw
	 kxyqLCuwfkxnEFCxoJ3DgRtXMTw3d1b5EfUGrUFmfkxs9VTxr1mU67qVhg7lDx4hw2
	 abqpYXDqNXU3HMwWeyF77cmT1uTI2HjS/m0SM2ZdGIzKm1P2RtsQP9jiiBdY3yyT5y
	 vPMQcHGiU/gmbPc30Ege6XdPq90HeLjbVigyd4gbc/YejjSgRNVDf/XQJ6LVbLMB44
	 4IYyzi9i6MRaWDKHXy0+o4wUy6aw6j+GDgyf8MZ2yLve0QHxaDIDTcmua7E6UDA3dq
	 H8KOzY0b5mulg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3DCADA058;
	Tue, 11 Aug 2026 18:15:32 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 0/6] HID: steam: Add 2026 Steam Controller support
Date: Tue, 11 Aug 2026 18:13:51 -0700
Message-ID: <20260812011401.3250968-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second half of a series that modernizes the hid-steam
controller. It adds support for the new 2026 Steam Controller, with feature
parity compared to the 2015 model and the Steam Deck drivers, as well as
some smaller cleanup. The biggest cleanup is cleaning up the somewhat lax
locking practices, but a few more minor things exposed to userspace include
logging improvements and zeroing inputs when switching from gamepad mode to
lizard mode.

This has a little bit of code cleanup and fixes some lock safety issues.

Vicki Pfau (6):
  HID: steam: Refactor registration
  HID: steam: Initial 2026 Steam Controller support
  HID: steam: Fix wording of connect/disconnect logs
  HID: steam: Don't set feature reports when disconnecting
  HID: steam: Clean up locking
  HID: steam: Zero out inputs when disabling gamepad mode

 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1033 ++++++++++++++++++++++++++++++++-------
 2 files changed, 848 insertions(+), 189 deletions(-)

-- 
2.54.0

