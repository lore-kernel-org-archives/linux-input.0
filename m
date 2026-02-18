Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15772FD7BE;
	Wed, 18 Feb 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421399; cv=none; b=NnbIRzODWF8+46lkXqIr6/IymJAr7DpSSbQeM2hb0ETwt2VgpMsEEmyzDGi1iAmQbcpdbml8ujhnnPv+OoR+KPzGbJf39FDGdqZ0u3d/DQxwGJKvJzAZi9vmY4AFsTr1xvSzAK71anT+cgm/UR4HS02xPHWGjy8MtQo5r9gO6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421399; c=relaxed/simple;
	bh=+eEDQP7ZC+Sn7kLzL0NEWHh05rcZXqlQQIEzWs0DxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBBjJ946VoAEobVW0mosKYNRLNCcR2lNVPQKk/Qd8hQ/Vipt6FUcLAvW9aJrpWbnw1l/YFOgQargvvMIWyCDm/3SrvPcifl7zg+M8RPQFcywagqiG/lfR1r1+oscpoQas3EeImMeJwfVdL11hN5FvvOmZ/d8hpCZ12rnbs9R/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTXg9L3Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTXg9L3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771421398; x=1802957398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eEDQP7ZC+Sn7kLzL0NEWHh05rcZXqlQQIEzWs0DxtA=;
  b=iTXg9L3QjcJGmZGwJfzHj5LvLIq7/6MHSZXXufH675aOhyUPwGgNZ1lo
   fths+1YDowTq3325CawCXjxOG7Qj7JtnBuaIvXY2NJubWjK40WKUFeer8
   pMEo5Xw98cL/TZ3E+Mf84gioERUGuHSWoGnFuf95r/uTjacmNKurCtKbb
   l361tM/PyJqTjis2OUEYNkP0cCc+BMEcqkuUGuezibXXpHpSk8/FVtQo7
   k9DGpQa1mUVNOKw5x+qzU+xlICAVOaPhiaqsHMeH375m/4+wOk09UHfvr
   EDG4GmMbmOmf3RU2zMvhY4yr2KerK5QGqets6lRAUnl7hjrnfTXwg1ZoL
   g==;
X-CSE-ConnectionGUID: bs9PubYfTPuoNxddtyPrkg==
X-CSE-MsgGUID: dsN50TnrS52eR//c+pmEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97956449"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="97956449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:29:57 -0800
X-CSE-ConnectionGUID: Izloa6RIRcudyY2e/WdIxA==
X-CSE-MsgGUID: dQzn2tmzSRSZRYfKJ5n1tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212553047"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Feb 2026 05:29:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vshck-000000012Nc-1WO1;
	Wed, 18 Feb 2026 13:29:50 +0000
Date: Wed, 18 Feb 2026 21:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Aelin Reidel <aelin@mainlining.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@mainlining.org,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Aelin Reidel <aelin@mainlining.org>,
	Piyush Raj Chouhan <pc1598@mainlining.org>
Subject: Re: [PATCH 2/3] Input: add support for Goodix GTX8 Touchscreen ICs
Message-ID: <202602182104.ONBwXzkn-lkp@intel.com>
References: <20260218-gtx8-v1-2-0d575b3dedc5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-gtx8-v1-2-0d575b3dedc5@mainlining.org>

Hi Aelin,

kernel test robot noticed the following build errors:

[auto build test ERROR on fe9e3edb6a215515d1148d32a5c445c5bdd7916f]

url:    https://github.com/intel-lab-lkp/linux/commits/Aelin-Reidel/dt-bindings-input-document-Goodix-GTX8-Touchscreen-ICs/20260218-075424
base:   fe9e3edb6a215515d1148d32a5c445c5bdd7916f
patch link:    https://lore.kernel.org/r/20260218-gtx8-v1-2-0d575b3dedc5%40mainlining.org
patch subject: [PATCH 2/3] Input: add support for Goodix GTX8 Touchscreen ICs
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260218/202602182104.ONBwXzkn-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602182104.ONBwXzkn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602182104.ONBwXzkn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/touchscreen/goodix_gtx8.c:110:16: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     110 |                         finger_id = FIELD_GET(
         |                                     ^
   drivers/input/touchscreen/goodix_gtx8.c:135:14: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     135 |         touch_num = FIELD_GET(GOODIX_GTX8_TOUCH_COUNT_MASK, touch_num);
         |                     ^
   2 errors generated.


vim +/FIELD_GET +110 drivers/input/touchscreen/goodix_gtx8.c

    87	
    88	static void goodix_gtx8_report_state(struct goodix_gtx8_core *cd, u8 touch_num,
    89					     union goodix_gtx8_touch *touch_data)
    90	{
    91		union goodix_gtx8_touch *t;
    92		int i;
    93		u8 finger_id;
    94	
    95		for (i = 0; i < touch_num; i++) {
    96			t = &touch_data[i];
    97	
    98			if (cd->ic_data->ic_type == IC_TYPE_NORMANDY) {
    99				input_mt_slot(cd->input_dev, t->normandy.finger_id);
   100				input_mt_report_slot_state(cd->input_dev,
   101							   MT_TOOL_FINGER, true);
   102	
   103				touchscreen_report_pos(cd->input_dev, &cd->props,
   104						       __le16_to_cpu(t->normandy.x),
   105						       __le16_to_cpu(t->normandy.y),
   106						       true);
   107				input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
   108						 t->normandy.w);
   109			} else {
 > 110				finger_id = FIELD_GET(
   111					GOODIX_GTX8_FINGER_ID_MASK_YELLOWSTONE,
   112					t->yellowstone.finger_id);
   113				input_mt_slot(cd->input_dev, finger_id);
   114				input_mt_report_slot_state(cd->input_dev,
   115							   MT_TOOL_FINGER, true);
   116	
   117				touchscreen_report_pos(cd->input_dev, &cd->props,
   118						       __be16_to_cpu(t->yellowstone.x),
   119						       __be16_to_cpu(t->yellowstone.y),
   120						       true);
   121				input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
   122						 t->yellowstone.w);
   123			}
   124		}
   125	
   126		input_mt_sync_frame(cd->input_dev);
   127		input_sync(cd->input_dev);
   128	}
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
