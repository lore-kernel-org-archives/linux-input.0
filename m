Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823255;
	b=lPKqBNPiQ9NfBMqLiNWtkt2lwyfNc/t9baWoLDSWsqe2qKQWQhOSyTJ1QQ1I4ADKrZ6d
	 vKvVuqgn8ec9Kss1VwcAs2wQje09ixcHrIXcScimPUteDHvnZ/TwSIj6wrK/wOMV5nubN
	 IllQhytr4yFozibMwF78K8qABmyb7WeILj7BeubfDFtQuNLnKEKiVHXqwCFt2BLi1wRGR
	 Wb8ZbrtM2BLVz5cBX0qYYP7/6UoHwDxArWpn81gm0RiglHYRgmzgQNh0XWPcyigGoufy9
	 f1vyrIqynAicWdsbh4jpDzYKHheTqGKF8ZqkIHRiyaRE7k/mE9dpVofMNkMf5wStAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4PH5m3KVIwIBaRvHWnFW7UIkZKClI0X9XZgk8BD37Mo=;
	b=qNwtLSTgYIJuri4L+z3XIY7LajEEuIsm1uK13pqN13C9SleY2y9/jidT9Gpi53F8zfk6
	 OC6YUCIUmtHAm3rWzsUAZz7eniwY121CCkynNyOMA9RfsFHzVq+ubIUKqkv0lQZnvmRxQ
	 5CFXB4LJ+3l/lv4sL9SoMUTINwqXzIHPNy+yjX5nb/R/irzsJXMOd1q9c3sJZIgqN0khw
	 4+/5r/C/QbiW2reCUXBd4k11SHep5TwTufXJNkqOCzQ/WgDNbn2lPNVp7XWnY922r+JP5
	 HG5LWIWUiOqNrVBXZKfQROBiEAaOJghTuq0ETb3pz2HutFReXn/s85joFtHyhpgebgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GVpdbQVi;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F316081775;
	Wed,  4 Nov 2026 20:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F316081775
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GVpdbQVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823254; x=1825359254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mY0OgZkfBn3Rh2ZVN06sX8LX9BZ6W9zKpgjYrPWUHgk=;
  b=GVpdbQVikY3Pff/7V8lXbjMQXPLV51lsBsm9QEzhZD6ocxAL62/DX1hw
   bF1oLVMYensOQHK5X8iJhLaA/jFuu4fbj6o3Ypfh8/y9LiPWSEuFb6Via
   /YC2wavjAxJQnbcbM3Y5yN8WMbXliBhG0LtAhNXrl+VYDRvbOWnszgCx9
   yhUhsiDAhSQGV5gguoc+EmdPCb0gNG02iJgnRTp19mMeyXqqU3QY+j7gR
   HvylZDEx0q4W3F5f96qwYnplPM2yHqoDkghpPReu+AXjd6U5GUVVrRrVZ
   dmGgGcfhkOG6tf7qvG6U1C2VMYUpGQQZKeXxw/8upXrEYZ9euQ3zEUqFn
   g==;
X-CSE-ConnectionGUID: zBieSQo+RpqDrWzSvFIYBw==
X-CSE-MsgGUID: CQWprpL/QcCQcTlt9hHtnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589123"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: sylHUVQSTNCrpKwZ73aa4g==
X-CSE-MsgGUID: dBfMYtZBQ/mvsZGW6EfsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925622"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2026 12:14:09 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simeon@maryasin.name,
	lixu.zhang@intel.com,
	crofts@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/7] HID: sensor: custom: use-after-freec after remove
Date: Wed,  4 Nov 2026 12:13:56 -0800
Message-ID: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 for patch " [PATCH] HID: sensor-custom: Synchronize
misc-device teardown with file lifetime".

This patch series is essentially the same version that was sent to
Семён for testing.

Following a feedback review conducted with various AI models, it was
suggested to break each change into individual, separate patches. This
makes perfect sense, which is why this series now contains more patches.

Additionally, these reviews identified issues in the adjacent probe and
removal code when active sensor instances are present. I have addressed
those issues in this version as well.

Srinivas Pandruvada (7):
  HID: sensor: hub: Synchronize callback removal with raw events
  HID: sensor: custom: Set owner for misc device
  HID: sensor: custom: Disable sensor before hub close on removal
  HID: sensor: custom: Fix state lifetime during removal
  HID: sensor: custom: Serialize misc device reads
  HID: sensor: custom: Register enable attribute after misc device
  HID: sensor: hub: Remove clients before stopping hardware

 drivers/hid/hid-sensor-custom.c | 121 +++++++++++++++++++++++---------
 drivers/hid/hid-sensor-hub.c    |  27 +++++--
 2 files changed, 110 insertions(+), 38 deletions(-)

-- 
2.56.0

