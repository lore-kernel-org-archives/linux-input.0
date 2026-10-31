Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413815;
	b=rV46JiiYWdjwUAqtteEJuiryJOGqsPSY7A0sNj4Kgzpi40/f6Idw3yaLwfE6q4uKAmWZ
	 gVmWgpx6OsqUKw5MCd3Md2MESSPXU/qOS3wH6eX1hUrdIE51KwOwM3+5da/OtSw5fO6+H
	 lFEaTJaO+vcF3Bm4921WMF86DtsZUg6zEQlHDFq8BpC0f1ksmbBHTZ+Ah+mzs9/LgqHGx
	 Tca43PYomxMfVoGvtvCG5CJtVi7rwBaNn2OUjEcrkzSOYdFj5pNmxggn01a+lDUeKMm/S
	 cwDB2sNQmqQSjg+SwK/nEcbCg4YYIIScUAhkd+kj74JZ11/qAGswsQF+lHwZdKeNZQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413815;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iXEfWoEoCIsoSXFk+YAPuSVr2iL1r/DA8iHiRGeTNng=;
	b=vlRRa0QwZDciqEj3GK6/AwnbA6zjy8bI9or5P+avhkFnaFHJSPHunKy8avLUGFA654Ur
	 pBSWY40rMh/gVAcRiQ+JaMDbJ1O8/kcnbtavMAaw14yio4g0dZ60zLll2I3fcI03uJ9MI
	 sC6s0sjrlvSnFAOyekgV+Ru4QhO4tMDrYZm52/YqDvrugBd4mldVxP4lF7NtCGJi6dfwS
	 uc4ZZiplyMAYcyp98Od3hwZe9Q7XxN897nAzPAxlX20nhr4nQ5YUglBhCMUr+szf+TRxP
	 Ou8ZTMWklsW0oDCtyZxSWnvjYTQySMcFC44iYSZrDEG3GYwWXwtXlopQZT/2pZ+SEnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HfWhxp1z;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F109606A324;
	Sat, 31 Oct 2026 02:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F109606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HfWhxp1z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793413813; x=1824949813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h8PaQbBDKI0jqP5gTeMuq/q/Fqlc1DTYURIQU8hM5M4=;
  b=HfWhxp1zyAFnHh3W4bzEINkO/PdJgschA+XUlksv8AhlhweMhg4JvKDw
   hMY6IIqbTtQa8d13U2JNhAPAGOome3LVMeLaNMC85N0D+MeV0HGqfq9lw
   Hz0WLZqfFj3hoiEgVxYjjF707bJBF5aAJDOL+n6OFjc2S6RN23KPPQ9/L
   9VbdUk+Kr54w3R6EbDo6j/6yUD9FIh9B5qzqEIvZpOyQxx84n12uDvV9J
   vhgvnoX5MPerwvDIOuhGCHyYiruusgr3ZAaBh2GozNTykzOpmbhisom6M
   7Gjx3B7DVQnTElHEl1vVr28WkP5FiJZg6nfbVUnWbmaijuRiPu6PlusFh
   w==;
X-CSE-ConnectionGUID: u/x7669GQDuanOi5WRKrug==
X-CSE-MsgGUID: q5A5tIi4Sfy9ht58+T0yWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2092824"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2092824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:30:12 -0700
X-CSE-ConnectionGUID: +oZpC2cgSoiPM9sOCppUbg==
X-CSE-MsgGUID: 1+FMKCFgS7KiG4pSqZalyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5667170"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2026 19:30:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMyrA-00000000cSu-38RG;
	Sat, 31 Oct 2026 02:30:08 +0000
Date: Sat, 31 Oct 2026 10:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: ahmad baghereslami <ahmad.b1995@gmail.com>, dmitry.torokhov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahmad baghereslami <ahmad.b1995@gmail.com>
Subject: Re: [PATCH] Input: synaptics - support the touchpad LED on RMI
 function $30
Message-ID: <202610311023.UR64jYrp-lkp@intel.com>
References: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030070821.1716595-1-ahmad.b1995@gmail.com>

Hi ahmad,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ahmad-baghereslami/Input-synaptics-support-the-touchpad-LED-on-RMI-function-30/20261030-103821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261030070821.1716595-1-ahmad.b1995%40gmail.com
patch subject: [PATCH] Input: synaptics - support the touchpad LED on RMI function $30
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20261031/202610311023.UR64jYrp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610311023.UR64jYrp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610311023.UR64jYrp-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/input/mouse/synaptics.o: in function `synaptics_disconnect':
>> drivers/input/mouse/synaptics.c:1678:(.text+0x3ec): undefined reference to `led_classdev_unregister'
   /usr/bin/ld: drivers/input/mouse/synaptics.o: in function `led_classdev_register':
>> include/linux/leds.h:274:(.text+0x12c9): undefined reference to `led_classdev_register_ext'
   collect2: error: ld returned 1 exit status


vim +1678 drivers/input/mouse/synaptics.c

  1668	
  1669	PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_IRUGO, NULL,
  1670			    synaptics_show_disable_gesture,
  1671			    synaptics_set_disable_gesture);
  1672	
  1673	static void synaptics_disconnect(struct psmouse *psmouse)
  1674	{
  1675		struct synaptics_data *priv = psmouse->private;
  1676	
  1677		if (priv->has_rmi_led)
> 1678			led_classdev_unregister(&priv->rmi_led);
  1679	
  1680		/*
  1681		 * We might have left a breadcrumb when trying to
  1682		 * set up SMbus companion.
  1683		 */
  1684		psmouse_smbus_cleanup(psmouse);
  1685	
  1686		if (!priv->absolute_mode &&
  1687				SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
  1688			device_remove_file(&psmouse->ps2dev.serio->dev,
  1689					   &psmouse_attr_disable_gesture.dattr);
  1690	
  1691		synaptics_reset(psmouse);
  1692		kfree(priv);
  1693		psmouse->private = NULL;
  1694	}
  1695	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
