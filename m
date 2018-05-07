From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] resource: Use list_head to link sibling resource
Date: Mon, 7 May 2018 23:50:22 +0800
Message-ID: <201805072210.H1bsHs9Y%fengguang.wu@intel.com>
References: <20180507063224.24229-2-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180507063224.24229-2-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov@gmail.c
List-Id: linux-input@vger.kernel.org

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc4 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180507-144345
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/plat-samsung/pm-check.c: In function 's3c_pm_run_res':
>> arch/arm/plat-samsung/pm-check.c:49:18: error: invalid operands to binary != (have 'struct list_head' and 'void *')
      if (ptr->child != NULL)
          ~~~~~~~~~~ ^~
>> arch/arm/plat-samsung/pm-check.c:50:19: error: incompatible type for argument 1 of 's3c_pm_run_res'
       s3c_pm_run_res(ptr->child, fn, arg);
                      ^~~
   arch/arm/plat-samsung/pm-check.c:46:13: note: expected 'struct resource *' but argument is of type 'struct list_head'
    static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
                ^~~~~~~~~~~~~~
>> arch/arm/plat-samsung/pm-check.c:60:7: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
      ptr = ptr->sibling;
          ^

vim +49 arch/arm/plat-samsung/pm-check.c

549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  45  
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  46  static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  47  {
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  48  	while (ptr != NULL) {
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @49  		if (ptr->child != NULL)
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @50  			s3c_pm_run_res(ptr->child, fn, arg);
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  51  
05fee7cf arch/arm/plat-samsung/pm-check.c Toshi Kani 2016-01-26  52  		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
05fee7cf arch/arm/plat-samsung/pm-check.c Toshi Kani 2016-01-26  53  				== IORESOURCE_SYSTEM_RAM) {
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  54  			S3C_PMDBG("Found system RAM at %08lx..%08lx\n",
840eeeb8 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  55  				  (unsigned long)ptr->start,
840eeeb8 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  56  				  (unsigned long)ptr->end);
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  57  			arg = (fn)(ptr, arg);
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  58  		}
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  59  
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @60  		ptr = ptr->sibling;
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  61  	}
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  62  }
549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  63  

:::::: The code at line 49 was first introduced by commit
:::::: 549c7e33aeb9bfe441ecf68639d2227bb90978e7 [ARM] S3C: Split the resume memory check code from pm.c

:::::: TO: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
:::::: CC: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
