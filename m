Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804D48422B;
	Thu, 24 Sep 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261139; cv=none; b=EWASo4tdDT/3HFAHXunCSAVw6NEmCU+9r00f2oyyYHodZfBVyjhJUaBgyYYKo+XTvDuHUNg8rIvgyVN+vOyCq2bAcCMepOU/mIM88VYyvZfPwIHD4fT8s73E2wG+TbmLw5bU5yUGWqt+RuuQsPje/GPQmCR8P24fOFZOPiotSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261139; c=relaxed/simple;
	bh=T4eoCY3beb6FIImrfgTMKYKm3HPqG5R8ByKQyPshLkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YI2HVoGFwkJhxZF3Am+IoQ4kxl5l5jtlwjyGRZPOK1uDnsfaobCjIN4VoXMis1chnAeKKmhFXgxp9QVhtpev/FQnu7cf61ePwMF/jwGefBMWxRAs4zf6yLhKMt3sQM4n0/qAUHdRKzNgWgBMSv3AG5Ri5rzzu7VKKQTvBjsRHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YrnfHzOw; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YrnfHzOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+o
	91K5lVbT2dniebC4dw84ZvThaNdc+FPUBeGwv37vM=; b=YrnfHzOw1N2VyxgPyK
	4xBs1fqjgPma7MmAl+yMIPhjgx+3Rz2H2kWhfGrCDWHKtuLC/YcUKmwR1DHvrtT7
	veZA1ceDc4WLMEDZyzTR2vR8+tW29wVevyeM3oe0UxSoiMD7fCMnmYDs8W37itlG
	LHqH9R8U7+fF2ubK1o+9SBu8I=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S2;
	Thu, 24 Sep 2026 22:44:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Rishi Gupta <gupt21@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	"Daniel M. Lambea" <dmlambea@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 00/10] HID: validate short reports in raw_event callbacks
Date: Thu, 24 Sep 2026 22:44:03 +0800
Message-Id: <20260924144414.1192037-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry3JFW3Jw4xCF17JFy7Jrb_yoW8CrykpF
	WkA390yr45ArW7Cw13tw4UCFy5Krs7JFyYvFy0k3W5W3ZYya45XF4S934YqrZ3XF48tr92
	gF4vq39xCFyj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziec_3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AnnImq1N0n2lgAA39

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

