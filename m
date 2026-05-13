Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1F360EC5;
	Wed, 13 May 2026 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778639996; cv=none; b=SBxjSv4RXyg4Q3mTRClcmCFaAz6H7Gq2m488bxu6q0+DXMI0sl2HxdRe1JAfCmvkrwJjCjpYTGQAM3/l4d5S905mW6hR2nN+lfOJI7TsXyZ0+bU7ocU3bBVFt625Qrqo4ioZjZKAjc+gHMHOoQDaa54+nnOENx+A3XHgRg/VaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778639996; c=relaxed/simple;
	bh=GMv+Sq8HMKoKGapd0eOh4Tzgfs/ypOB5QOX4lE/aYUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmArA8eWGPA/6pBwJ9fD6zg7a1ukaoO/4UhsO96F66AhqAIHmpvj2xeHU96R/rNpWuD1cpY3gqnHLQ+pfYT13ERGH/P0Jkm/Ya6sQ0rjUTHiDkeigSQPLVd2goc9qGZT9pgHrFktpBiQE35M8nxkbIZihpe7Gf7J0Zxndl0THZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XMcrRH0Y; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XMcrRH0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=39tJqH2HhuorU/9OgbY8JK5OiAgqEg+aWU9WNRMm3rw=;
	b=XMcrRH0YnoZMN+EEEmBHeYt21JiZsBUhHHSlv9y5k6bPOsL662g+TAIdaJnIBM
	lc8TGyhIsEwu5wqOeq4dyv2WbGNjqeyDuksPcrmEogPGMfsOuKCPb2y0gcqe1qu1
	/H+wou9uE2ek/4cbzoMAm9nUQfBnh4j3xSL1OoVu82eyQ=
Received: from debian.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD31OBf5ANqvfhMBA--.30455S2;
	Wed, 13 May 2026 10:39:28 +0800 (CST)
From: Kean <rh_king@163.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org
Cc: Kean <rh_king@163.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: lenovo: Fix buffer over-read and unaligned access in X12 Tab raw_event handler
Date: Wed, 13 May 2026 10:40:17 +0800
Message-ID: <20260513024017.198084-1-rh_king@163.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511132854.1351379-1-rh_king%40163.com>
References: <20260511132854.1351379-1-rh_king%40163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31OBf5ANqvfhMBA--.30455S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw13AFW5Zr13trWrZw45GFg_yoW5GrWUpF
	4UC3yqyFZ8tw17Ar10vw1IgFy5Za4kGFy7Cry7Kw15Z3s0yr17XryIq3WYqryYgrs5Wr4Y
	9r4rKr43uF4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_JPErUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC3wCsW2oD5GDNdAAA38

In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
little-endian value via *(__le32 *)data but only guards the access
with a size >= 3 check. If a 3-byte report with ID 0x03 is received,
the code reads one byte beyond the end of the buffer.

Change the size check to >= 4 to match the actual access width.

Additionally, casting a u8 *data pointer directly to __le32 * can
trigger unaligned access faults on architectures that enforce memory
alignment (ARM, MIPS, SPARC). The HID core provides no alignment
guarantee for the data buffer — for example, uhid payloads via
UHID_INPUT2 start at offset 6 in the uhid_event struct, giving only
2-byte alignment.

Use get_unaligned_le32() to safely read the little-endian value
regardless of the buffer's alignment. get_unaligned_le32() already
handles the LE-to-CPU conversion, so the le32_to_cpu() wrapper is
no longer needed.

Signed-off-by: Kean <rh_king@163.com>
---

Thank you for the review!

Both issues you identified are correct. This v2 addresses both memory
safety concerns in one patch:

1. Buffer over-read: size >= 3 → size >= 4 to match the 4-byte access.
2. Unaligned access: *( __le32 *)data cast → get_unaligned_le32(data),
   which safely handles the uhid scenario you described (2-byte alignment
   at offset 6 of uhid_event). get_unaligned_le32() already does the
   LE-to-CPU conversion so le32_to_cpu() is no longer needed.

Regarding the missing key capability registration — you are correct
that these hotkey events would be silently dropped by the input core.
I'll need some time to reproduce and test this on the actual hardware
before submitting a separate patch for it.

 drivers/hid/hid-lenovo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a6b73e03c16b..10c86f4e1467 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -31,6 +31,7 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/workqueue.h>
+#include <linux/unaligned.h>
 
 #include "hid-ids.h"
 
@@ -793,8 +794,8 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	 */
 	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB
 			|| hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2)
-			&& size >= 3 && report->id == 0x03))
-		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));
+			&& size >= 4 && report->id == 0x03))
+		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
 
 	return 0;
 }
-- 
2.47.3

