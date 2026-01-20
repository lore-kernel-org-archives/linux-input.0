Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849740F8EB;
	Tue, 20 Jan 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916832; cv=none; b=WZ6hs2ta4Rarj8NLnNvLrPzyaWV089CI4RGWT8z1sFQ3/OZg0dMUT9bZTMs7R/vkJpWNG3c2iD9i15N2tQhXnQe9ZyA8Q2HmfMkWynlxP1RP5CBPyD+2iOB8IpLvvqG03C64SLzIutqjbnRACtWHBLmnGp7zKtR18fWYbVy4Z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916832; c=relaxed/simple;
	bh=epbOfAwD46ntY0+fjIUDM/Klp9Xl2CN6eKrlmBlGHCE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SYjUMMpKmeLkg/rBNTuZLqgaLn1HrBm/CFGrK74a7lic+1ZDwbgGr9Y1DBDxTQeu9Kpe29s4y233gi+eF35yZ9yjnNhdQd35gOeLjKoOezrqucw6cRphh7DDiq08RxDTZuaRPd/xPqv44DULqxN7dqgr+gGConTpD3Qa0c5DEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qMDj/OoW; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qMDj/OoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768916824; bh=se9ePcQMTkGkqL6FrfNqRIDaSwuRSTd93lMRLzgM/r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qMDj/OoWyf4giWpdzUJ3UhzueKF6Gm2VJYxd1py+O5kVNFXabq8TRkylwXbqe1+9k
	 my2aziQTVsJ24yAxHvIcTebgq+4KsxqOqBnlGdOmlTp0nNhAnKWQRAVe1KKFxLZ8ji
	 RazVK84o6zsHVOg4LosGBt7B3IpudK4UCoiRJI9w=
Received: from lxu-ped-host.. ([114.244.57.237])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id BC22CC84; Tue, 20 Jan 2026 21:47:02 +0800
X-QQ-mid: xmsmtpt1768916822t7fhi46nr
Message-ID: <tencent_9443A8C45A37693763A6D7D3658367896405@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcs93bXl2qHOLHR0KT9AZgRMMKBSmWy1wj0U9r+2hfX2s5DOIsCEz
	 iDAXst9ONZ/7YNVv8P2QjqqX6cAhp/EgoG0Xrg2vLdqTZnbtb4oih5U7Hn531so8k2xejulqpnb2
	 NAmt4SkL0QKFvhMP3ba6rWzJDC2gGSXk29vWRNrPyFnJQlLTTIpy3MU7Sk2GTnBBBqMusCUE1aBc
	 fAu8zbLplNGq+pcwio9r7iuSXol6c+pgYYkYqxAPMYKLiaZDCMGYwqmHdT5NxcKgPyYdxtYscDSy
	 oE30s20sKkpArFWp9FPhQMzBD/bMh5ifhh3oGZ5qBZeAR8cM6faLqxJ6+6w7wAvypexpH/Krh14E
	 bQnh3qe0zZAEXpTI1UYgB/DAepyZLtoXYdzxYgOow1vKNkipI1KTyzY9hUS6AYZcGdX5n26z1QZd
	 y9yP/Uq2hJugXztEwg5idFzauix8eXF7EugN1wR9DYF7suHhGQDIY8eneWeL0AbfZP/+1BCkcK1t
	 y8MRU1ocCDsZ46zQB2LhWOI9ArSlRtWDfTCa74XTw/rG/JgMwPGzWW7aAhoItYxDR9QI2FIDDA4W
	 2sXUtaZ1AH0bNVAHeiOiRcJ2Jua5oNfmj85mYfImpkiwp9SIluBFUdFCeSjQRosdXoa7GfQv2bEN
	 rs9j3z28t4DaD7/WGcMT3aUike/D9iY3uNJlFA/sdJywzkd3zW1rYZPC0G19p1b612taNi1Ac4l3
	 kLlR8zSu9ek7cm9Sn9mDXXdDCQvzCNFZl6Rig1jJmR27caZccOBF6gw0JpEPWCwmOTheNrZPFW32
	 rJy3mm4wVm1NdVM9kG72jDZ12jHOSFNKqetH/d5hqjv+Eut7Huh/xjN13TAy9JP8nB50JXbw6AQQ
	 QcgsKs/RJaYlEwQ4mjkxsFnr6Qps6RIP6bNPWCghnLyco9Hnm7aEgSwq0NkQJck8sU6hoS39jXFe
	 2rCFg7GRbrofhYIJFnToSZwSb5O6fvpY6iXrBNb42lAGt1U1WdzeFi/Gr+HRxwpr+h5kqMyenuec
	 lOP4BtxfaUDiYJcbARdaS43hYvyoH5wDw3DlhX8A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.zaidman@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] i2c: add sanity check for input SMBus data length
Date: Tue, 20 Jan 2026 21:47:02 +0800
X-OQ-MSGID: <20260120134702.864692-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <696eedec.a00a0220.203946.0001.GAE@google.com>
References: <696eedec.a00a0220.203946.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value passed to block[0] in the user-constructed data is too large,
exceeding the length that data for SMBus messages can accommodate. This
triggered the out-of-bounds access reported by syzbot [1].

Adding relevant data size checks in the smbus ioctl can prevent this
out-of-bounds access.

[1]
BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119
Call Trace:
 ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
 ft260_smbus_xfer+0x22c/0x640 drivers/hid/hid-ft260.c:736

Reported-by: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64ca69977b37604cd6d9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/i2c/i2c-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e9577f920286..6725a49d6921 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -378,6 +378,14 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 	    (read_write == I2C_SMBUS_WRITE)) {
 		if (copy_from_user(&temp, data, datasize))
 			return -EFAULT;
+
+		if (temp.block[0] > datasize) {
+			dev_dbg(&client->adapter->dev,
+				"user input data size (%u) is too big "
+				"in ioctl I2C_SMBUS.\n",
+				temp.block[0]);
+			return -EINVAL;
+		}
 	}
 	if (size == I2C_SMBUS_I2C_BLOCK_BROKEN) {
 		/* Convert old I2C block commands to the new
-- 
2.43.0

