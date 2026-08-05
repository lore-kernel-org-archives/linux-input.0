Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24039D3C0
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894782; cv=none; b=HnPCAVjDpKeN7wad/G/GZcZVJtdFpzodzYvv8T4THa4xlXnpbmERKlZf+8cY+IH3tbeXmfTI6WXx4A6U8EjjL7XHWxyOVgwR6s6wtz9Z7F531kVCkUQkujhp33LR44Cdp9Cw3i9+8VlHhMpyu3ghBfnwX4ydj08bJGnZDyMNTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894782; c=relaxed/simple;
	bh=XN/FqHQavtS5jseBygfU+jJ77zWv76QkzBlSwhcx5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idkkaC5868HYPpWciw80lDZ1zn/E4m8how2xE+mAU6Sxy9213sRZcg8g0ZS7f5T1lZcv9utUsARfVtcZNte1gQJMQTPPTvwbzEX0XIYUmkVRU07q8OM28JVNGzGpULPQP6ehIWl46zv41yCoVGGado+lfv48s9oxxhUjU/o2r60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=mwyTlGHl; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="mwyTlGHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785894768; bh=XN/FqHQavtS5jseBygfU+jJ77zWv76QkzBlSwhcx5nc=;
	h=From:To:Cc:Subject:Date:From;
	b=mwyTlGHl85nE2+6JXelp3SKOklJHMajdk+bEz63Xz1p5h06y4FMPEhK48tk2l9qR+
	 hyhWKs6Vw99bKwLJnuTnWqAvYN/N9hq1APJu4/ne39t4DMVHo2N4sAxuY8bIcnEUPD
	 ipU7qGsxNOAFrsYQksglS/7JCvnaz9ck+yn+AG4VPEOfWId7G5lV/+JHu71hHWYz/P
	 P9hI4FIFeZdlnKe0OhEtOQ5UOdvVVDEV0wP2qO/+WrYvczl0ERG7bncyGIQfpSP3SQ
	 B/ykJLsP8HkVvHz2a1dr5HtcnI123rUjLFPlSuOVvtsPmH7cFh5bpsDHXS1Yr9JfbK
	 k7cICCtA2IrBg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 2B658A070;
	Tue, 04 Aug 2026 18:52:48 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 0/5] HID: steam: Add 2026 Steam Controller support
Date: Tue,  4 Aug 2026 18:51:01 -0700
Message-ID: <20260805015116.3884465-1-vi@endrift.com>
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

Vicki Pfau (5):
  HID: steam: Initial 2026 Steam Controller support
  HID: steam: Fix wording of connect/disconnect logs
  HID: steam: Don't set feature reports when disconnecting
  HID: steam: Clean up locking
  HID: steam: Zero out inputs when disabling gamepad mode

 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1005 ++++++++++++++++++++++++++++++++-------
 2 files changed, 827 insertions(+), 182 deletions(-)

-- 
2.54.0

