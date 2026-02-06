Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66316DC28;
	Fri,  6 Feb 2026 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352589; cv=none; b=TpH6ePuym90Wd3e0TBD3TJs+FQ9Qe8YB4QefKJww/+YTV5FiXYV5RG6J2SfL4sQ/GyXBNGURYe/w7JleyRafdi4x7Rh1bkfLcu9F5GhxSsX/Q9kFHqThrFBMQp6w2x9EbtQj3zcTsAU7MaGdwNAHosnjJp+MVXRnkKshtDpr9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352589; c=relaxed/simple;
	bh=x2BN6nqlcGHK2E4pZxtQEowE6pkO/1TIIwXh0jf5QWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0L7CRlzIXvUXtWlv/tj6BdSlP7lTwkdvwhk0y/tD/XXhxpxtZ6niMVtEUJri5P+fKW98ZoMskbqtas+MpweWOQLuBr83mT5RY9e8o5SbcCfcOW3qbpHb5n7oWkb9Edx+48JABZsifGBqeC/nR0s+Vj9so7996FJkQayB0VcXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=a7GkbmC8; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="a7GkbmC8"
Received: from ssp-soft.crpt.local ([10.200.60.21])
	(user=ssp.nesin@crpt.ru mech=LOGIN bits=0)
	by mail.crpt.ru  with ESMTPSA id 6164a169004286-6164a16C004286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Feb 2026 07:36:12 +0300
From: Rostislav Nesin <ssp.nesin@crpt.ru>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Rostislav Nesin <ssp.nesin@crpt.ru>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Subject: [PATCH] HID: ft260: fix block size validation in SMBus transfers
Date: Fri,  6 Feb 2026 11:36:00 +0700
Message-Id: <20260206043600.780298-1-ssp.nesin@crpt.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-Auth-User: ssp.nesin@crpt.ru
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlfSBsbGEYGDRsBBigLGhgcRhodSFlIWV9IGxsYRgYNGwEGKAsaGBxGGh1IWUhZSFlaSFlYRlpYWEZeWEZaWUhQSFhIWEheSFhIWEhYSFlQSAoNBhwBGxsoAw0aBg0ERgcaD0hYSFpdSAQBBh0QRQFaCygeDw0aRgMNGgYNBEYHGg9IWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIWl1IBQELAAkNBEYSCQEMBQkGKA8FCQEERgsHBUhYSFlfSBsbGEYGDRsBBigLGhgcRhodSFlIXVtIGxESCgccQ15cCwleUVFfXwpbX15YXAsMXgxRKBsREgMJBAQNGkYJGBgbGAccBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 10.200.60.21
X-FE-Envelope-From: ssp.nesin@crpt.ru
X-FE-Policy-ID: 0:9:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=rzfGCQV1vd3fE2K/Z35H/Vih9KGN5iZHJ9A2WW6ram4=;
 b=a7GkbmC8HJLqUQ0UqunzWt+hVfSB7WrwNpwobm+mvFeJd/j6hlH126RVoIzrmBYDnyzlQPj45kF7
	8jAfe18EZxNa4qvvG9in0EflSXe/Doz05bG8NiDWdM2J3d49fsN+yEhu/JmDa1exHOIMwuSKdfMU
	PiXuvmYMmL24LiBAHtBPEP0ZR5u8AqUSnKb5l2tNhoCuEjOYx/mcOgvd28TkyomqhqBCRgGCCitG
	3OQ+6vpbKd9ukdh6+fXrkI8tjxWBbiXODmVJh60AuCQPJTi7PXJV4STAaCkiWFUMC3jo+rU1VBiU
	XeqXsm4ZkdY3HoFejj4xzrE/7XNVwHn04fmv6Q==

In ft260_smbus_xfer(), data->block[0] specifies the data length for
block transfers. Without proper validation, a caller can set block[0]
to a value larger than I2C_SMBUS_BLOCK_MAX (32), causing out-of-bounds
access in both ft260_smbus_write() and ft260_i2c_read(). This
triggered the out-of-bounds access reported by syzbot.

BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119

CPU: 0 UID: 0 PID: 6119 Comm: syz.2.65 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

Add validation for data->block[0] > I2C_SMBUS_BLOCK_MAX + 1 at the
start of I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_I2C_BLOCK_DATA cases to
protect both read and write paths.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64ca69977b37604cd6d9
Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Rostislav Nesin <ssp.nesin@crpt.ru>
---
 drivers/hid/hid-ft260.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 79505c64dbfe..7bd858e40826 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -659,6 +659,10 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 		}
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1) {
+			ret = -EINVAL;
+			goto smbus_exit;
+		}
 		if (read_write == I2C_SMBUS_READ) {
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
@@ -675,6 +679,10 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 		}
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1) {
+			ret = -EINVAL;
+			goto smbus_exit;
+		}
 		if (read_write == I2C_SMBUS_READ) {
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
-- 
2.34.1
