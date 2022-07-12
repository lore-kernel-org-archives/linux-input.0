Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86042CCA47C
	for <linux-input@archiver.kernel.org>; Tue, 12 Jul 2022 05:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGLFaD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGLFaD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Jul 2022 01:30:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C8E655B5;
        Mon, 11 Jul 2022 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657603802; x=1689139802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cr8GrVmkx46KeWT9vcp6f7dRU0NCrlnLhelee+qjp5s=;
  b=jOxm2al9fZhhKZfxmHHxsCb8ZwDwqmHiToISf1EqJp7zxCoybvjxg0zC
   3wz2u2E4j9nHNhawgVFoCOQpDup5DaD6B5lSUlj+T03XuNguOtvPUWGtZ
   9/piVI5N7Nz2zh7hjbEGq07MTseaOi/tR46KFsico8sBlCSucLh1pgdIQ
   fZUsIwjhWv5yIZrS07B39Ww/lk2E3GkUyoaCD4m9cjDUnMFIzNHak5Tic
   se6ofvw98o5KY5QyNl/KgO2KgXa5h2t22HX1fvMI9AtDVi+F+TmDWwbvg
   IwTmAIzUeaP9ovnq6JeCaSBwNWQc0c+PynKp1anxgwkqbPgaEPLYQRAWO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348819376"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="348819376"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 22:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="684644474"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2022 22:29:59 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB8T8-0001kf-RB;
        Tue, 12 Jul 2022 05:29:58 +0000
Date:   Tue, 12 Jul 2022 13:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/10] input: keyboard: adp5588-keys: support gpi key
 events as 'gpio keys'
Message-ID: <202207121357.JpS5DGdP-lkp@intel.com>
References: <20220708093448.42617-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708093448.42617-2-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi "Nuno,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on next-20220711]
[cannot apply to brgl/gpio/for-next hid/for-next linus/master v5.19-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-S/adp5588-keys-refactor-and-fw-properties-support/20220708-173730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220712/202207121357.JpS5DGdP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/input/keyboard/adp5588-keys.c:342 adp5588_gpio_irq_handle() warn: unsigned 'hwirq' is never less than zero.

vim +/hwirq +342 drivers/input/keyboard/adp5588-keys.c

   333	
   334	static void adp5588_gpio_irq_handle(struct adp5588_kpad *kpad, int key_val,
   335					    int key_press)
   336	{
   337		unsigned int irq, gpio = key_val - GPI_PIN_BASE, irq_type, hwirq;
   338		struct i2c_client *client = kpad->client;
   339		struct irq_data *desc;
   340	
   341		hwirq = adp5588_gpiomap_get_hwirq(kpad->gpiomap, gpio, kpad->gc.ngpio);
 > 342		if (hwirq < 0) {
   343			dev_err(&client->dev, "Could not get hwirq for key(%u)\n", key_val);
   344			return;
   345		}
   346	
   347		irq = irq_find_mapping(kpad->gc.irq.domain, hwirq);
   348		if (irq <= 0)
   349			return;
   350	
   351		desc = irq_get_irq_data(irq);
   352		if (!desc) {
   353			dev_err(&client->dev, "Could not get irq(%u) data\n", irq);
   354			return;
   355		}
   356	
   357		irq_type = irqd_get_trigger_type(desc);
   358	
   359		/*
   360		 * Default is active low which means key_press is asserted on
   361		 * the falling edge.
   362		 */
   363		if ((irq_type & IRQ_TYPE_EDGE_RISING && !key_press) ||
   364		    (irq_type & IRQ_TYPE_EDGE_FALLING && key_press))
   365			handle_nested_irq(irq);
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
