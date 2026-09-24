Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CA381AE3;
	Thu, 24 Sep 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259236; cv=none; b=p5N6BRU/O2CFjHmZbLfD8X2ajmvTL0ykTIEhBLcp8o66Gb8vOXZrXVIJm/U1fXtoLirpWFs5Qgrh2qUsdfxI82yyny72dYAHNfn2epliNxQS9Eab6NOBJ0zacoOEZhuV4LTQzsRelCBQXV3oBZVE0rHyzzY5Cf9TCcrxMBTRQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259236; c=relaxed/simple;
	bh=T4eoCY3beb6FIImrfgTMKYKm3HPqG5R8ByKQyPshLkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jx7yUNfHe1cV8ajuUzPjdbnekbKp6+bOO/6hQS2DHz31MEIIpXKtugAy2Mw40gRKpYAfK7fi3FXpRlH5o1ztCUzZvwxFlyYj6rWoajdFJDYKpIg9y/l9iYJAalwnKxigfeIUljHtIXPZRA6YUsKXONGUQZq/LQx/fsZFcbb5RUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OVnkFkud; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OVnkFkud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+o
	91K5lVbT2dniebC4dw84ZvThaNdc+FPUBeGwv37vM=; b=OVnkFkudWhAlivJkA7
	gj36YsRDLZyB5YJPKyg9P07eJ0TqhBKRsrc7+dFWmMDM8RpnpN3tc9XjR2cYIBCd
	lWGgVkR5u9vJ28N6SL2Ax9rI8wdP4kxTlF0HFK+QKImP58d2QC4CxytiCH5aGI6U
	Qzh/eFui+Cgb8TR/I2xs5WAWc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S2;
	Thu, 24 Sep 2026 22:13:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	"Daniel M. Lambea" <dmlambea@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 00/10] HID: validate short reports in raw_event callbacks
Date: Thu, 24 Sep 2026 22:13:15 +0800
Message-Id: <20260924141326.1154421-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry3JFW3Jw4xCF17JFy7Jrb_yoW8CrykpF
	WkA390yr45ArW7Cw13tw4UCFy5Krs7JFyYvFy0k3W5W3ZYya45XF4S934YqrZ3XF48tr92
	gF4vq39xCFyj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEubyLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgkWUGq1MAnEiQAA3q

__hid_input_report() calls a driver's raw_event callback before
hid_report_raw_event() validates the received length against the report
descriptor.  A raw_event callback must therefore validate size before
accessing fixed offsets or casting data to a protocol structure.

Ten HID drivers currently access fields beyond the received length when a
device supplies a truncated report.  Add protocol-specific checks before
those accesses.  The patches are independent and each changes one driver.

The mcp2200, pxrc, and zydacron cases were reproduced with a fake HID
transport under KASAN.  Their individual commit messages include the
relevant reports.  The remaining paths were verified by following their
fixed-offset accesses from raw_event.

This follows the local raw_event size check added to hid-asus by commit
47669bec44fe ("HID: asus: refactor the two workqueues and init sequence").

Jiale Yao (10):
  HID: alps: reject short input reports
  HID: cougar: reject short special-key reports
  HID: cp2112: validate response report lengths
  HID: elo: reject short touchscreen reports
  HID: logitech-dj: validate unnumbered keyboard reports
  HID: mcp2200: validate READ_ALL response length
  HID: mcp2221: validate response report length
  HID: prodikeys: validate fixed-format MIDI reports
  HID: pxrc: reject short input reports
  HID: zydacron: validate key report length

 drivers/hid/hid-alps.c        | 8 +++++++-
 drivers/hid/hid-cougar.c      | 3 +++
 drivers/hid/hid-cp2112.c      | 9 ++++++++-
 drivers/hid/hid-elo.c         | 3 +++
 drivers/hid/hid-logitech-dj.c | 3 +++
 drivers/hid/hid-mcp2200.c     | 5 +++++
 drivers/hid/hid-mcp2221.c     | 2 +-
 drivers/hid/hid-prodikeys.c   | 7 ++++++-
 drivers/hid/hid-pxrc.c        | 3 +++
 drivers/hid/hid-zydacron.c    | 3 +++
 10 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.34.1

