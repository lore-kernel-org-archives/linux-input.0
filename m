Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1170278753;
	Mon, 16 Feb 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232109; cv=none; b=th1hhvsaXB1nHkRiZPJ6EY6hGHIXOyA1d0Od4dZpdEh3wIsjnqOSaN9KzT5mBfyt2OctUYaimvqYuW0akj28f4PDy279tHaBTTUwEr+i2JjFuc2TnTCDy8+PA02dtvdhjmzI6CQbaIOt9CLsP6Mvl3LIq4MieoOsuW8tFxkcPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232109; c=relaxed/simple;
	bh=EqibijJnjCoomjCSwpuT+MglYbz++KlSUm9yD+w2+qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSd1c9zkLzA0rCzcg13W34F9O5KWG2tChzJyjjBq9jbehTC2P8aiU4Zoaf1Q8ffN6cY1YvfVpYmezBCSJtDdjx46UqLsQn21GLtpS5UKSpT9IYPcva6dJyM3RWFYQnsr9hoKXGYZPvDaHNxWdD/opVxcQJwHiXqDUAPBMGyFPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=bpEPmKm1; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="bpEPmKm1"
Received: from ssp-soft.crpt.local ([10.200.60.21])
	(user=ssp.nesin@crpt.ru mech=LOGIN bits=0)
	by mail.crpt.ru  with ESMTPSA id 61G8sP1t005101-61G8sP1w005101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Feb 2026 11:54:31 +0300
From: Rostislav Nesin <ssp.nesin@crpt.ru>
To: Wolfram Sang <wsa@kernel.org>
Cc: Rostislav Nesin <ssp.nesin@crpt.ru>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Subject: [PATCH] i2c: core-smbus: validate block size in __i2c_smbus_xfer() for native SMBus path
Date: Mon, 16 Feb 2026 15:54:09 +0700
Message-Id: <20260216085409.2550310-1-ssp.nesin@crpt.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-Auth-User: ssp.nesin@crpt.ru
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlfSBsbGEYGDRsBBigLGhgcRhodSFlIWV9IGxsYRgYNGwEGKAsaGBxGGh1IWUhZSFlaSFlYRlpYWEZeWEZaWUhQSFhIWEhfSFhIWEhYSFpRSAoNBgIJBQEGRhwBGxsHARoNGygaDQwACRxGCwcFSFhIWV5IAgEDBxsoAw0aBg0ERgcaD0hYSFpdSAQBBh0QRQFaCygeDw0aRgMNGgYNBEYHGg9IWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIWl1IBQELAAkNBEYSCQEMBQkGKA8FCQEERgsHBUhYSFlfSBsbGEYGDRsBBigLGhgcRhodSFlIXVtIGxESCgccQ15cCwleUVFfXwpbX15YXAsMXgxRKBsREgMJBAQNGkYJGBgbGAccBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 10.200.60.21
X-FE-Envelope-From: ssp.nesin@crpt.ru
X-FE-Policy-ID: 0:9:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=crQvf+nWXHhtv3YkKc/BU+0HMS+C0JJdKXbtBzMmDpU=;
 b=bpEPmKm1j1G1jE6YQh/F9aLJp2m0PBGdxxA4ksfkFm2h3i7leKdzgKNjWHqkv5J3b3MYXA3nNv1o
	9DxxK7ly4sPjaahc+0xcy26fUp8eSa6FhUCbRWeud4+AMuujU5oXqaYMWO34bLqgtD6/QJrpslrE
	OyAT7TYSJZZpHpDHHJw76anaCp4sFMHWuTtPE7o37WIE2yFuKbXXEnLSW0+/zucggrmbeNTigTFT
	G050mYv+FbO+RFjfhbbhqZXxgSix2BmZctMjBTyPl6gcQ1SMgFmnwTd+rhDAEZnQsgk3ZqCT4kl6
	Cezt+ENbhv7do014JrdiLHv2U17+kb5SnyXSRg==

In the native SMBus path, data->block[0] specifies the data length
for block transfers. When the adapter provides a native smbus_xfer,
__i2c_smbus_xfer() calls it without any prior validation of
data->block[0], so every native SMBus adapter (e.g. hid-ft260,
hid-mcp2221) is exposed to out-of-bounds access if userspace passes
block[0] > 32.

This triggered the following out-of-bounds access reported by syzbot
in the hid-ft260 driver:

BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0
drivers/hid/hid-ft260.c:486
Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119

CPU: 0 UID: 0 PID: 6119 Comm: syz.2.65 Not tainted syzkaller #0
PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:194 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
 ft260_smbus_xfer+0x22c/0x640 drivers/hid/hid-ft260.c:736
 __i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:591 [inline]
 __i2c_smbus_xfer+0x4f0/0xf60 drivers/i2c/i2c-core-smbus.c:554
 i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:546 [inline]
 i2c_smbus_xfer+0x200/0x3c0 drivers/i2c/i2c-core-smbus.c:536
 i2cdev_ioctl_smbus+0x237/0x990 drivers/i2c/i2c-dev.c:389
 i2cdev_ioctl+0x361/0x840 drivers/i2c/i2c-dev.c:478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Add validation for data->block[0] > I2C_SMBUS_BLOCK_MAX for
I2C_SMBUS_BLOCK_DATA, I2C_SMBUS_I2C_BLOCK_DATA and
I2C_SMBUS_BLOCK_PROC_CALL cases to avoid out-of-bounds access.

For I2C_SMBUS_BLOCK_DATA validate only on WRITE: on READ the length
comes from the device (Count byte, see smbus-protocol.rst). For
I2C_SMBUS_I2C_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL the write phase
uses block[0] from the caller, so validate in both cases.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64ca69977b37604cd6d9
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Rostislav Nesin <ssp.nesin@crpt.ru>
---
 drivers/i2c/i2c-core-smbus.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -575,6 +575,40 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
+	if (data) {
+		switch (protocol) {
+		case I2C_SMBUS_BLOCK_DATA:
+			if (read_write == I2C_SMBUS_WRITE &&
+			    data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&adapter->dev,
+					"Invalid block write size %d\n",
+					data->block[0]);
+				return -EINVAL;
+			}
+			break;
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&adapter->dev,
+					"Invalid block %s size %d\n",
+					read_write == I2C_SMBUS_READ ?
+						"read" : "write",
+					data->block[0]);
+				return -EINVAL;
+			}
+			break;
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+			if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&adapter->dev,
+					"Invalid block write size %d\n",
+					data->block[0]);
+				return -EINVAL;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
 	xfer_func = adapter->algo->smbus_xfer;
 	if (i2c_in_atomic_xfer_mode()) {
 		if (adapter->algo->smbus_xfer_atomic)
-- 
2.34.1
