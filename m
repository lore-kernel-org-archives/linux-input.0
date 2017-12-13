From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Wed, 13 Dec 2017 19:37:50 +0800
Message-ID: <201712131907.0kW3PRsl%fengguang.wu@intel.com>
References: <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:34908 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbdLMTmh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Dec 2017 14:42:37 -0500
Content-Disposition: inline
In-Reply-To: <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hi Mylène,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on input/next]
[also build test WARNING on v4.15-rc3 next-20171213]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Input-Add-driver-for-Cypress-Generation-5-touchscreen/20171203-203557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
