Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793926;
	b=eM1tnM/PmB+jmivDHaGsRCMCrIybXT60EdtAw0XWeUayk2VO6fENH7Kk9q2q0bd1EMk8
	 loxFN4EvlVknM9ALsJem6UWA/DZt02sQqkNu+asQOzxZRfRPoElkIvxFEaJefBZxYym95
	 Uqog7OMtxPWupJQxo/TB+TNpOJJMSLtp9VvrE5rQoG7F1QO9TDejo+acq1vy6TIOZJdie
	 KmCtr+LJ1bEn2ACCzw9p45uXnuspr0w6bjPEhFigVryJWydC49bm0Qc3ioTJ+LO6CWNbE
	 XAIKqRoNxgAHBrYbR5ug1xU5/HnEzVWobnWYEfKoqWkXjeTsjkDibnckXW4oRLkAi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793926;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=97dOnkvrxTJDDGXI2bjgoOzNNjW4n2O1mDB2f7Uxeuk=;
	b=wrjcbrkYAeh2AnU48mN4jP5O7/jaBXd6dUOrP0zEzvajnvIcmx0bRumO8RzeZZbMsPhy
	 QKvhNnD5CX/pfo8ASXsReZ4+ZD3NWMRTaRgTuy96esHoi0FvuZmMgq116q8Lwi9SusbWR
	 Qv7mnAEiX3beku55fnwKr7hl3zJ2SstKsHyINHZs6/aBxR5hHE9WMna7oCVL81BfrYt2y
	 jI9z6ZbZlPPz3f91A3bP7ygkg2S8IPaEOxwIBB+n9+4s/bcZALeKv0dnraRuHouwMJ5QJ
	 muQ0F13UHcjBHl5RAYjwfvpCUSZFGKSRcgeNWb8NH4S+GquegM41bMzwyZManmhyj7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="d/Dbrn4Y";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D652606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 15:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D652606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d/Dbrn4Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795793925; x=1827329925;
  h=date:from:to:cc:subject:message-id;
  bh=KDceSHnlCggfVrA+3Mag/JdEOCQiWzHt9ajWa1aSCaA=;
  b=d/Dbrn4YIFdqjdRWj9bdX8jczNGZhJm6F4Mj+eaPpm6c8uTXJC1vQWap
   KZ2Fuhn7n2KoiqndhEduRyIvZWjpPz9u+rwm0cApwomu3U6I2pmyPqUj9
   etu3CflpnKR+4HBSNuMsAi6vce945zqNG/jQHdTm/soLHNtc39GHG3byn
   0tdkp99RIRnAcuyTUuORpEdgAa243iCAaLtxwDdkzykceNRbwS1FPAKtK
   VDUUqYry7XK2HUOxDalaH5DoS/FFzrFxJOzdCPLqL8Xivb4siPVYv70WS
   Ruo4ARWjhDAFCH5oYC0nt8kdSfWHMWQRtDPlWTrP21ZD0rSJ8Du1JFxil
   A==;
X-CSE-ConnectionGUID: J62hlEySSW+9Cl5KARqFLA==
X-CSE-MsgGUID: qtNinah9RfmKFVs527Vqrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4727052"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4727052"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:38:45 -0800
X-CSE-ConnectionGUID: DrFdi+LcRt+qFXBWhHhYMg==
X-CSE-MsgGUID: DaqYa6c8SWmlYInyHqHhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12711930"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2026 07:38:39 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWy21-000000000DT-1I98;
	Fri, 27 Nov 2026 15:38:37 +0000
Date: Fri, 27 Nov 2026 16:38:30 +0100
From: kernel test robot <lkp@intel.com>
To: Jiri Kosina <jkosina@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: [hid:for-next 4/10] drivers/hid/hidraw.c:34:8: error:
 redefinition of 'hidraw'
Message-ID: <20261127163239.RGvemhVL-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
head:   e61d3737e144924bc27c536a31da8147f1b55554
commit: 3203bc9bc0795c44c25ce7b7762eeb35f73e82c4 [4/10] Merge branch 'for-7.4/upstream-fixes' into for-next
config: hexagon-randconfig-2200-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127163239.RGvemhVL-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 578b1f2d6a9776b63cbb6b86f4cca6208d429f48)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127163239.RGvemhVL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127163239.RGvemhVL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/hidraw.c:34:8: error: redefinition of 'hidraw'
      34 | struct hidraw {
         |        ^
   drivers/hid/hidraw.h:12:8: note: previous definition is here
      12 | struct hidraw {
         |        ^
>> drivers/hid/hidraw.c:45:8: error: redefinition of 'hidraw_report'
      45 | struct hidraw_report {
         |        ^
   drivers/hid/hidraw.h:24:8: note: previous definition is here
      24 | struct hidraw_report {
         |        ^
>> drivers/hid/hidraw.c:50:8: error: redefinition of 'hidraw_list'
      50 | struct hidraw_list {
         |        ^
   drivers/hid/hidraw.h:29:8: note: previous definition is here
      29 | struct hidraw_list {
         |        ^
   3 errors generated.


vim +/hidraw +34 drivers/hid/hidraw.c

bed04b3b8a67df Dmitry Torokhov 2026-10-16  33  
bed04b3b8a67df Dmitry Torokhov 2026-10-16 @34  struct hidraw {
bed04b3b8a67df Dmitry Torokhov 2026-10-16  35  	unsigned int minor;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  36  	int exist;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  37  	int open;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  38  	wait_queue_head_t wait;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  39  	struct hid_device *hid;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  40  	struct device *dev;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  41  	spinlock_t list_lock;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  42  	struct list_head list;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  43  };
bed04b3b8a67df Dmitry Torokhov 2026-10-16  44  
bed04b3b8a67df Dmitry Torokhov 2026-10-16 @45  struct hidraw_report {
bed04b3b8a67df Dmitry Torokhov 2026-10-16  46  	__u8 *value;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  47  	int len;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  48  };
86166b7bcda0bc Jiri Kosina     2007-05-14  49  
bed04b3b8a67df Dmitry Torokhov 2026-10-16 @50  struct hidraw_list {
bed04b3b8a67df Dmitry Torokhov 2026-10-16  51  	struct hidraw_report buffer[HIDRAW_BUFFER_SIZE];
bed04b3b8a67df Dmitry Torokhov 2026-10-16  52  	int head;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  53  	int tail;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  54  	struct fasync_struct *fasync;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  55  	struct hidraw *hidraw;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  56  	struct list_head node;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  57  	struct mutex read_mutex;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  58  	bool revoked;
bed04b3b8a67df Dmitry Torokhov 2026-10-16  59  };
86166b7bcda0bc Jiri Kosina     2007-05-14  60  

:::::: The code at line 34 was first introduced by commit
:::::: bed04b3b8a67dff3fb9157bb92f1ae45343492f7 HID: hidraw: Make hidraw.h private to HID subsystem

:::::: TO: Dmitry Torokhov <dmitry.torokhov@gmail.com>
:::::: CC: Jiri Kosina <jkosina@suse.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
