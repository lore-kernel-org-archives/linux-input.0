Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3962FF662;
	Wed, 18 Feb 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411255; cv=none; b=BqwBHX8qyCqY7RQG1S2lTyMHUZXEPNBYUDj8zIxFstXrL6eSKXg9lO4GFrZi/I1iomYivr1c2YbyVHPa1e9biqVt6IUmxK37NqwcPMVxH6V0e8dVUsNBBfUu/yTx8Q7Nye1+ct+kCzqyxXru/PgW0E8HTL8blRKOZXygg/bnB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411255; c=relaxed/simple;
	bh=RJ3db4P7f6iZL9PjraP8K+gI4ily9Dn6WB2Z9jdSzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/QZ5fcpKAAnhE3+9/bJhNU1OM3WOBH8Rv88jA+9OVUBs3ftjhFd+3zz85sWUzeSGui3w6gx0+WUbiub6o0QJq8/soAeLFH0fMM5j79ceIsa9ti1Nf7BNKv6TcqsS8sob6jbn/NjVOs/h75EvvJqmSJ4ELu0RaBrw2L+Ud6VFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gao72Tz8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gao72Tz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771411254; x=1802947254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJ3db4P7f6iZL9PjraP8K+gI4ily9Dn6WB2Z9jdSzdI=;
  b=gao72Tz8Mf5xEHkMriiy65ftvlgmKSKlobPVoRLgZtXH9yA0DwQ9/Xc6
   juuJiGdIeNEBkTo/sc66JaFj0jifUV1bvDXYOt2hHOY7mzWups+AbnZjz
   GyC7opoSRRzWmYlB+Ix0Fx9OJGO/xWmjRdX+i2EJcSGlxF51ZKa5dwfIj
   PEg2PnaxqPuvWu8bjFBZZK4jbegf4/UiH3SoWcSnQ0qfNQb8IcbeZo+ih
   eGwgnYHtf2McjJlvPL0Ic98p9ULc3cFHk2GbrZEyiDxiChxTrBABobJZ9
   bmaIaf7icDdCMmvB59blasGsQqn6GZNmXNnpPiWHq5MdRnB8Or9AcqJTd
   Q==;
X-CSE-ConnectionGUID: pSL6OD+nSLC8nrS+X2ckgQ==
X-CSE-MsgGUID: 981wdYDBTw6V0y3yZSb+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="76344964"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="76344964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 02:40:51 -0800
X-CSE-ConnectionGUID: sLYSybasRgiOXb5BDWpu0g==
X-CSE-MsgGUID: ETul5zvpTyWNRTSJaFeDtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="214148729"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Feb 2026 02:40:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsez6-000000012HE-1d79;
	Wed, 18 Feb 2026 10:40:44 +0000
Date: Wed, 18 Feb 2026 18:40:09 +0800
From: kernel test robot <lkp@intel.com>
To: Aelin Reidel <aelin@mainlining.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@mainlining.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Aelin Reidel <aelin@mainlining.org>,
	Piyush Raj Chouhan <pc1598@mainlining.org>
Subject: Re: [PATCH 2/3] Input: add support for Goodix GTX8 Touchscreen ICs
Message-ID: <202602181848.DK5Wc0iI-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260218/202602181848.DK5Wc0iI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181848.DK5Wc0iI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181848.DK5Wc0iI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/touchscreen/goodix_gtx8.c: In function 'goodix_gtx8_report_state':
>> drivers/input/touchscreen/goodix_gtx8.c:110:37: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     110 |                         finger_id = FIELD_GET(
         |                                     ^~~~~~~~~
   In file included from include/linux/kernel.h:35,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:17,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/input/touchscreen/goodix_gtx8.c:16:
   drivers/input/touchscreen/goodix_gtx8.c: At top level:
>> drivers/input/touchscreen/goodix_gtx8.c:555:37: error: 'goodix_gtx8_pm_ops' undeclared here (not in a function); did you mean 'goodix_gtx8_probe'?
     555 |                 .pm = pm_sleep_ptr(&goodix_gtx8_pm_ops),
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/input/touchscreen/goodix_gtx8.c:555:23: note: in expansion of macro 'pm_sleep_ptr'
     555 |                 .pm = pm_sleep_ptr(&goodix_gtx8_pm_ops),
         |                       ^~~~~~~~~~~~


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
