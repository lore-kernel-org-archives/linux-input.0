Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC93F4854
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145113; cv=none; b=jAfSQm0WzlA58CIgBnrQ4Z3qTsB7o0V1s/wAglS8AAIhEIlXGyy8GcmFEMvgCfMbONwfg0wijr/wRbudtfois4/KhhSax6c8o8Jdmur8z0PTqukU/twn8Sq+hYKbn7Ozm5RGrihHZihI6ULGGPwJAb7+k38A7eR0vBd82fjXidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145113; c=relaxed/simple;
	bh=p4uwMz2WTFH9/V6k8CoBOUE/VHlXlkjMFt6OT/D6t4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pf7xesQFAmV+bpadMgO+nkpjXATRuN8UlI4KO1s2CoUKhKee6rv3zbqdEx9BTlt7Ep3GWTTZAYy6vfp3m9w+W7CFcZQhT0b6qMfdzV6FzrI+vJDD3KRzV5e7scVsf1ZRT8WEgTkbyfO8J9M5GQ/ltjFRosQpy7hWhx4XqmA/pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=KHXwD/Yv; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="KHXwD/Yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786145105; bh=p4uwMz2WTFH9/V6k8CoBOUE/VHlXlkjMFt6OT/D6t4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=KHXwD/YvELJVJXZZw4OtUNF4givwfNOAjjf18QYenk3tMK1pLRU5b/35ghF8BqeGz
	 E+rPEgpyNsdmbE/SSijLXEEHzzD8I6NYiDuZsILfqbVkt3dLRK/REI2Ojlha5Bvzjo
	 nsIxc+CaORQoE3waVjZHjbQPyr8oodY68OhJ6LTORAVo2+5C/8Ft0npdlg9rmgydwW
	 +Yc6i6Pboy86SmM3SZ6YjVsauxwbsjJPHOwpZkYS/sK7TItvDL0lAc2CSuQ7JmoEw5
	 M/dioUQu+O6z8Hu6kq9/fVuiijgSqUcnfmB/Kwi4Vii3s5IEjXWcKQ15SxLY0xPnRE
	 xmwl985wIf1Zg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 2C5A3A058;
	Fri, 07 Aug 2026 16:25:05 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 0/6] HID: steam: Add 2026 Steam Controller support
Date: Fri,  7 Aug 2026 16:23:31 -0700
Message-ID: <20260807232339.2799205-1-vi@endrift.com>
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

This fixes a deadlock that accidentally crept into the last version.

Vicki Pfau (6):
  HID: steam: Refactor registration
  HID: steam: Initial 2026 Steam Controller support
  HID: steam: Fix wording of connect/disconnect logs
  HID: steam: Don't set feature reports when disconnecting
  HID: steam: Clean up locking
  HID: steam: Zero out inputs when disabling gamepad mode

 drivers/hid/hid-ids.h   |    4 +
 drivers/hid/hid-steam.c | 1024 ++++++++++++++++++++++++++++++++-------
 2 files changed, 842 insertions(+), 186 deletions(-)

-- 
2.54.0

