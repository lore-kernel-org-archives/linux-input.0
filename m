Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666043E073;
	Fri, 31 Jul 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513128; cv=none; b=ZZ3EFpKK2rJsb30J/5t5DRbyZxFl+DnWeqI0U4ed6/GanOKHS6WjbIP+fBuNn6oqPdqAq5awIfr0KsvC2VSHt4+9+h+IEDnN3VQ8OVMLmUtPolj+93FFq4rHMWXGCkejNG21fvBtqGx5JxYwcBldaBs2VKPd3U/puaO4MeIgtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513128; c=relaxed/simple;
	bh=B358ZI8dZdISJ63uCMg2vF83T+NYz9bDJNChIVfgM/Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Kqx6E5WraQYUqEvpHCNI/WjTEDQpAuwQ5u5Pb6aHVqvw+RxRt2Lw2MxP9aAOFNsjfJ9a54tagz8Tgbg/NO3f+GbU6RQgQ6EFyf0NhfezmqA/qi67+0SYSo7HKDudA4cbgRFEjuI4a5AnTpcpAQw+oIAbzVPgUKu68fsrYDFyGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XUC4lVDt; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XUC4lVDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785513118;
	bh=G1qwPVGYnyLpAR3ki8IFHy64BmmOlhe9sTXdnYpIqPA=;
	h=From:To:Cc:Subject:Date;
	b=XUC4lVDtT9wYVy9XURFh7+yV82SQsYdYhKcgwv/dOqgAKIuX43BGOkdAcCu6Cc/dt
	 4uM0COeKImljyFckbd1AXLU3D5Nk326sDJVs41091PveM+5kw8wH9JFki/C5IGiPOI
	 btpt+D2Kaj8kcFCIiWsR0M5zx/IO20iJDPAKVihs=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id CF804C10; Fri, 31 Jul 2026 23:51:56 +0800
X-QQ-mid: xmsmtpt1785513116tacda3r1c
Message-ID: <tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznMP3v2wWYxkXiVIW37ccy8/LUYiFZcAljty40VHw3MG1K2Q3VPd
	 dEmw+4JHo/8KaEYjc5LhksXfb/aMYjMpQjGlx67X/OAC4EpbA8GDyKV/BCa/a+YZ05I5PNm8ECQH
	 C5S71PDswK93tW6Kv3tU/sQimLe0Bb8GsCLmeyDxAhu1p+AkgE3EcP2xb79cH655Sq5R68Bb6R1A
	 xOWGKtMclNShlNKsSlDVJYpCkpG3Q/zqD7o+rdh9sH4vW9SmBxlQ020FFpGtGLWs57xvenRwl+q4
	 ZyPq/iHjLS7Pl3Esxd1an+z3Fsc+QmY8Ghw+dlRdZahGmY6UdjvquG0CxOEo/Hi8Iqmfs51V1ON0
	 RY8zLJHLYrxgCEGMq1nPks6+XuBzUGngB9mLhZxalEVoG1CP6iuqApAepWFF+s1hrONz7zLLDQZ1
	 BtIs2Db2M5MejHqpTotSs9roGXh2Exw9OKkZx8YKJZUzmItn4S4TWWZopRDo6FuNByd7+AJnIdb8
	 yFnRbXcfpdNk+d4pZwFilhzdcUNVb91rY8yVt2Caj7lO65ZE5ZV3B8r9Z+FS6XoJofWQgCVJfhux
	 uH/t3AKZoc4VhkSFGu9a9GXCMgy3Nb1XwmOWRfbkO1wl+lQEm0ZFm3JJqTD+Y9M/3vHHTvb/g6EV
	 QN7H+LbK2y6XM+yyEDDj4NKWKxHhbwJCp3t2LhP1wFXZHnfWhxDOoPgt573FKN6zS0Tr/9bZd6l6
	 hgrpbqMRlipaVg+lQMXVsU89J+RnMvDkaocmhjwIxZS7MS9IaFkClo99g18IIH4OjgnYfZwyMVt7
	 //kftywDseSht3Vi2jAB7kIG8ggXqRMa9E3bmD4Wj4+NWt7Iu6V/baSx3SpjJouOaIYvqHUXxKJ8
	 QRIr5ah5K9edGb9xloxVYviinEAU/vxc/TdSrCOHjWBMOX7P/DRG6DJsiGBWrtTiQNroomBc+VLY
	 jC5dTfEtnIZ9IvVhFqGbJNi78TOutIgwqzVcYkrDbMhbjMzaiGNsi98ynYa2biDSNYU4L38Qwdyi
	 apyg4jspnSHPIF68VleFG80UHGMFlPGAxxNqcNzYwbLvNqqvKNncGGchcyR6+Ay7sbCuU6cf+CuL
	 bSWvJb/x21pZTiXTiNzsK3I6dpnQvbHHTlchSy
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shen Yongchao <grayhat@foxmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES
Date: Fri, 31 Jul 2026 23:51:55 +0800
X-OQ-MSGID: <20260731155156.1956762-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HOSTIF_DM_ENUM_DEVICES response handler takes the HID device
count from the first payload byte of the ISH firmware response
(max 255) and stores it in hid_dev_count without any bounds
check.  This value propagates to num_hid_devices and is used to
index five fixed-size arrays in struct ishtp_cl_data
(MAX_HID_DEVICES = 32): report_descr[], report_descr_size[],
hid_sensor_hubs[], hid_descr[], and hid_descr_size[].

If the firmware reports more than 32 devices, hid_ishtp_cl_init()
writes past all five arrays, corrupting subsequent struct fields
(including work_struct members with embedded function pointers)
and potentially adjacent heap objects.

Clamp hid_dev_count to MAX_HID_DEVICES at the single point where
it enters the driver (process_recv, ENUM_DEVICES branch), which
covers both the probe and the reset paths.

This is a data-validation hardening fix: the ISH firmware is
within the platform trust boundary (loaded via CSME).

This patch was drafted with AI assistance.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Assisted-by: Hermes:kimi-k3
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 6d64008..6ea9979 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				break;
 			}
 			client_data->hid_dev_count = (unsigned int)*payload;
+			if (client_data->hid_dev_count > MAX_HID_DEVICES)
+				client_data->hid_dev_count = MAX_HID_DEVICES;
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
 						cl_data_to_dev(client_data),
-- 
2.43.0

