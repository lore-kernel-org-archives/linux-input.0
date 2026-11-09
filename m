Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254395;
	b=sl2V8RVC1NjeixTSwu5wFPnbZt1GQlvQHN7g2NLd3qQcLlG9eZWWTNeyZxGl861ICyk2
	 fTR6b95CWg2W2N2ncJjrhZZWMV3BiSB3v6QXk4L9B2yNc0CyAcPzqLjQabo6eLxD0C65D
	 7VRBAsClpYyWDovevpHBo7VZT6cEpDBUrLfIpzNBL0ygI9JJ1O3iEzXqbIX9lz+7n1LVj
	 zqExErI4+MmKG4TOv7eqBDyRT/FNEkgv82A3aNswyq2yYGmDwdKPeGLZfuqkfHHAKVE+m
	 i2UtthyGRcVj6Z/OLwDsT36bN457cgc3eo2fsR8KKKuTjQRcYEy09lESFOi0AQcw4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bOwPx07Y5dGndVLgscD/JsYB//gpuKGzmabRmxhjMbQ=;
	b=umByKgvNMJwlFVZsaUwaYW4/UNoSfdlGD4wHkhqecT401mB15oXiz5JkElh5Mnoxq3H8
	 6nlkJQN67QexUmBx7OVG932BbNb9/suse15wQuNdefvLilgPq5t6+d8LahIU6O4XxT+0E
	 cCif7Pp7IASAzS6tIkBQDYZ5KIRBQC6+hPNlAJerwqmQYhr5JiUXT3AB+BdoGQ4BdecMc
	 NSIL731IxJaeZDwLct/RDmJcjSoyiUN9KYLuaa1f/qSThgPh1yZEeWzqnqkEE12DkN74/
	 ku3N6g5m2G0zUmieYEbEKjmoHudZ7zq76AxKSto8SBiTB7xSWYOQ7DIy6Xd+HgMqeMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G5iaP4Jl;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82168606A325;
	Mon,  9 Nov 2026 19:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82168606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G5iaP4Jl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254395; x=1825790395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+xjPhcUiRHthyVAsrjw15Nk6/h5NQZTve3QpMEaEYY=;
  b=G5iaP4Jln+xPPQV5tO8Bi+ULKge0kpf6003HSprLlWq+qiTwXiWSCUQC
   P67lpRS73CiKTWTaZYs3lHLMWMxrxlI+ezHVHZtkesBc4q7DyZeHft43S
   EKM1kWffRYPUS4NSm2ipwNdJjAauVFo6Slqe+Xbh8GxHBCczVTaWe01hV
   WXb8mt5UDTUe9WN64ChhVQi8WlpSbMdbUwcAX5Hs/fMgvoeqkerb9V+hE
   Qctp0BjfvOesjVRUdQ59R8Kb51LWpqApK/2pewjarai15kCzszAwMlIhn
   GRze4Be/gZ20ZjD8ZqljNEsSItsGGyNwgM3Z2lZD4lyQqLu1lv0eWehw1
   g==;
X-CSE-ConnectionGUID: MNrXZwaxSOqgjCwnoMwpLw==
X-CSE-MsgGUID: SI9AeG1jSF29ToNm4oCNlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986556"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986556"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:54 -0800
X-CSE-ConnectionGUID: buYK8KfoSnCGqYVTyA1exw==
X-CSE-MsgGUID: Q+ZEx3t9QpCJZeoc0hqk3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090652"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:53 -0800
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
Subject: [PATCH v3 0/7] HID: sensor: custom: use-after-free after remove
Date: Mon,  9 Nov 2026 11:59:42 -0800
Message-ID: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

This is v3 version with changes suggested by shashiko-bot and Jonathan.
Also rebased on top of 7.4-rc2 kernel release.

This patch series is essentially the same version that was sent to
Semyon for testing.

Following a feedback review conducted with various AI models, it was
suggested to break each change into individual, separate patches. This
makes perfect sense, which is why this series now contains more patches.

Additionally, these reviews identified issues in the adjacent probe and
removal code when active sensor instances are present. I have addressed
those issues in this version as well.

v3:
- Address comment on patch 6/7 by Shashiko on useless goto
and suggestion to remove sensor_hub_remove_callback() for
err_remove_dev_if.
- On patch 4/7 : HID: sensor: custom: Fix state lifetime during removal
Rename goto as suggested by Jonathan

For using guard(), need a follow up patch as that will be a cleanup.


Srinivas Pandruvada (7):
  HID: sensor-hub: Synchronize callback removal with raw events
  HID: sensor: custom: Set owner for misc device
  HID: sensor: custom: Disable sensor before hub close on removal
  HID: sensor: custom: Fix state lifetime during removal
  HID: sensor: custom: Serialize misc device reads
  HID: sensor: custom: Register enable attribute after misc device
  HID: sensor-hub: Remove clients before stopping hardware

 drivers/hid/hid-sensor-custom.c | 118 +++++++++++++++++++++++---------
 drivers/hid/hid-sensor-hub.c    |  27 ++++++--
 2 files changed, 108 insertions(+), 37 deletions(-)

-- 
2.56.0

