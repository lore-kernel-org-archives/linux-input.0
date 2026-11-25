Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645085;
	b=nNWQLu5byVNgForiTj430FIuDkKkn/jalSUQi0deTzMoRgjhTtHYtJ646js25+yJi6Lv
	 0g3pb4CtcvhiAZauUrmI0yjGSDCO/e1shAmkJrsBHZt5aH6Q6QYkRJYxu6gWOAeGPgrAd
	 MlvJpg/3ZAhCq1NhKhU+V9ai54B0dsdyNZ8Swm6eqkVnJSuCCf2fLnaVPC1fiScpbBGQy
	 yWzoO0/37NnChg3Xj5VTNr5dbJaOBHTZFhKQcuCgRsS9GiGqNcyVxkWQTdCW1voNFGuTq
	 oaL+lTTIPl06LQq2F6SBtACzc5lEc1VWkIqsQomjckxwhpvYyyVh9m6H+EgbJIrU5uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ipuY/GPGnzCJlnHWCO1S3xz7owRUdE8H+HL99PrQAY=;
	b=zOHI7eXzLl7achA13S5OCgjtik7pbb4SyDQcPGiej8EF288G2E+Z+IjQ8TPDUJju2l9B
	 Vsnjt0DBys8szGeC2mUjPc9x9PzPjOU5pM7dny12k/JCIIxxxU0wf/WwZU1m6zLH/m5TM
	 5x66yOrxWBdEjfWzB9oDGSmnxahXwY8Xg9Zv48k3YBfSWWWS/ZlQdzd2SRCCBppWXR21e
	 UsYnaARlKhVw1b2rxvdNBxncyKF1A9GdDjiuGAMeX0XUVuorE3xGpn9Fy4Vq3y+3WmfQo
	 FrMjkULjx3VGaRqGg1Lo+i9HNZrafjbCzI/yLWzLlg0m6AJTMHTneAg6FjlhaI42PAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4C4hDru;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE0606A32C
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 22:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAE0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4C4hDru
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-385d8a00598so9370847eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795645085; x=1796249885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ipuY/GPGnzCJlnHWCO1S3xz7owRUdE8H+HL99PrQAY=;
        b=d4C4hDruGezjryJjUXDGrcMNv91JTeaHoH02IBRRrhMTYsm+KdaIq8zPvV135GrEUc
         cvTs7SLLqIRI3xDB36dHNrwLjadHZcmthjeYZBAcbMxsjuMh6oR1Xuj7J8OhSDZxXLWh
         HRNsSiqMMhd1VVny4P3EaxuOdbqriGk/39ad7BTzpvIXsVMvfLzWWJ5nH4uow1MRDTeY
         UhRPjh+jgIiUaw8Au4cOkmXtrbFuYujQGXJAvddaXTjGjbNpXX2RlpIR0po5hxehRSXu
         Rl6cw/hPk0q9VfnwoiSJaYbhSkZwBtCc8ZoEGexB5piGnbQYaLNac+56G22AemftWcA+
         dLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645085; x=1796249885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ipuY/GPGnzCJlnHWCO1S3xz7owRUdE8H+HL99PrQAY=;
        b=Jur0gKpME9lJeOLPzzsR4psk3kOpHICLiTDZQYqMoNZTwXDgf+IaFRzPo6zv4d58fm
         cFLQq2PPZ3F6y3nhyC9bOUQEJD0zustWRD3qJ0+S9rPwDuYR+qVIoyAoIPB90TzCT5d3
         50EfCmPtkLM4qbPaIgJdYKrLeVCCdNQz6kORuRMJM0N4Q44y1D1jY9R/14WXM012ABBw
         wIJ1sKOr2q0fFAWswpW71ZED8GUqU+2XT1SwFrsaJVVxBPXSjK9y+h2GPQ8RsrUj7yNy
         QUPopT8LnfovPKVm3Yfg1ZhybFN8Gx6pFprQx9IVdio/ZJ+iCH14IyiBH/iaj72EaeUO
         zWkw==
X-Forwarded-Encrypted: i=1; AL+hErF+rezTYvJHhXFMyH4rSXtK5fAoRclPgOkfF41RNSmSucXqiTgdOSvkjGim67+yk2wStC/DMjGdMwbH6A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8kvwZs1H2kdiwrI7PD/u7PfzYIDo76PZnxAyR4ut60ZWi7b7yS
	77pYKuggRwPZ3H+SpHt4Oc36GpQ0Y0xHyn/rotx8ihRsiUsWSXJd2Da8
X-Gm-Gg: AZFdTZfpO8S/BjM94OAWh2tCzjiQ7sEfsSOB6iw1k6LlvOk9HkugCMCYDn7dG++CbX2
	J6OtOclaDpX8RlHyhULVLXbClvZ5ITtSOKo/GWqGfyS6ukIv4QfwkvcYL2s5jQTjLrlpR66eTW8
	PvTDgJR3G08e8ZgsnPnaiiGAlsnrcrOb4e6pjtCWqNJr0sk55oINJjXdVUXs1aiCoOfRBf8td+g
	KXIcHz28YxxnZS6omLCvyF4DHUfIO24xIZfVk23T5dxHFWqk/jqRXqs6uBMlJSyqoUqiE0FLX6q
	Stc0SMsd+hR2xV7cowh/pCklAf/n2pY6yAY0noaU38NJJVhaHtgT9pwHhD33IUFN2Wxi4m5IIl3
	b1c6+HdRE0oa9dxzuKMw44FNLYQRsmtsLc0RGMJhKd1ceCl8T0HLPhkMmvhK7Qg1j1FMmuKATvj
	MxEr0Xw4OQAfAOEEjjeNqzuGUfAebx/KXYOhvNa+zWS0FbGTR6NMGOX3MEPfnIAbyob7A41oEZ4
	3AKv0KUrfuG6tL9HaJ6YkRxyCsog510NdIMc+P4Eoa6T6ukM0PERgvzqfkgXQm3kXDuzFAGtT4/
	JRtA/40E/uPY7MQyXfd2hw==
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr7456394eec.32.1795645084664;
        Wed, 25 Nov 2026 14:18:04 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm69581357eec.5.2026.11.25.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:18:04 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 1/3] docs: ABI: mlxreg-io: Drop the second shutdown_unlock entry
Date: Wed, 25 Nov 2026 22:17:56 +0000
Message-ID: <20261125221758.2535044-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125221758.2535044-1-takano32@gmail.com>
References: <20261125221758.2535044-1-takano32@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e29dd3821df ("Documentation/ABI: Add new attribute for
mlxreg-io sysfs interfaces") added shutdown_unlock as a new attribute,
but sysfs-driver-mlxreg-io already described it in the October 2021
block.  The tree ended up with two entries for the same file, and with
two different defaults: the older one says "Default is 1", the newer
one says "Default value is 0".

Keep the entry that came first, which documents the behaviour in full
and carries the kernel version the attribute appeared in, and drop the
later copy.

Which default applies is a property of the board's CPLD, not of the
driver: mlxreg_io_attr_show() returns the register bit as it is.

Verification: get_abi.py --dir Documentation/ABI validate no longer
reports shutdown_unlock twice.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
Changes in v2:
- The documents are fixed before the checker is added, so the tree
  does not gain warnings in the middle of the series.
- The internal MCU protocol_version entry points at the top-level
  attribute; v1 gave it the prefix of the removable controller's
  group, which made it name the same file as that entry.
- The checker keeps its warning for an entry without a file, counts
  lines rather than occurrences, and drops an unused loop key.

 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index f59461111221..00cff8965b22 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -741,18 +741,6 @@ Description:	This file, when set 1, indicates that access to protected
 
 		The file is read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/shutdown_unlock
-Date:		May 2025
-KernelVersion:	6.16
-Contact:	Vadim Pasternak <vadimp@nvidia.com>
-Description:	When ASICs are getting overheated, system protection
-		hardware mechanism enforces system reboot. After system
-		reboot ASICs come up in locked state. To unlock ASICs,
-		this file should be written 1
-		Default value is 0.
-
-		The file is read/write.
-
 What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/*-00**/mlxreg-io.*/hwmon/hwmon*/boot_progress
 Date:		May 2025
 KernelVersion:	6.16
-- 
2.53.0

