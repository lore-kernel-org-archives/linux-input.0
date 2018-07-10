From: Ye Xiaolong <xiaolong.ye-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [kbuild-all] [PATCH v6 2/4] resource: Use list_head to link
 sibling resource
Date: Tue, 10 Jul 2018 08:59:28 +0800
Message-ID: <20180710005927.GG10005@yexl-desktop>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180708025946.GI3047@MiWiFi-R3L-srv>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec@li
List-Id: linux-input@vger.kernel.org

Hi,

On 07/08, Baoquan He wrote:
>Hi,
>
>On 07/05/18 at 01:00am, kbuild test robot wrote:
>> Hi Baoquan,
>> 
>> I love your patch! Yet something to improve:
>> 
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.18-rc3 next-20180704]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>Thanks for telling. 
>
>I cloned 0day-ci/linut to my local pc.
>https://github.com/0day-ci/linux.git
>
>However, I didn't find below branch. And tried to open it in web
>broswer, also failed.
>

Sorry for the inconvenience, 0day bot didn't push the branch to github successfully,
Just push it manually, you can have a try again.

Thanks,
Xiaolong


>
>> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180704-121402
>> config: mips-rb532_defconfig (attached as .config)
>> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.2.0 make.cross ARCH=mips 
>
>I did find a old one which is for the old version 5 post.
>
>[bhe@linux]$ git remote -v
>0day-ci	https://github.com/0day-ci/linux.git (fetch)
>0day-ci	https://github.com/0day-ci/linux.git (push)
>[bhe@dhcp-128-28 linux]$ git branch -a| grep Baoquan| grep resource
>  remotes/0day-ci/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600
>
>Could you help have a look at this?
>
>Thanks
>Baoquan
>
>> 
>> All error/warnings (new ones prefixed by >>):
>> 
>> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      .child = &rc32434_res_pci_mem2
>>               ^
>>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
>> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem1 = {
>>                                                   ^
>>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem2 = {
>>                                                   ^
>>    cc1: some warnings being treated as errors
>> 
>> vim +57 arch/mips/pci/pci-rc32434.c
>> 
>> 73b4390f Ralf Baechle 2008-07-16  50  
>> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
>> 73b4390f Ralf Baechle 2008-07-16  52  	.name = "PCI MEM1",
>> 73b4390f Ralf Baechle 2008-07-16  53  	.start = 0x50000000,
>> 73b4390f Ralf Baechle 2008-07-16  54  	.end = 0x5FFFFFFF,
>> 73b4390f Ralf Baechle 2008-07-16  55  	.flags = IORESOURCE_MEM,
>> 73b4390f Ralf Baechle 2008-07-16  56  	.sibling = NULL,
>> 73b4390f Ralf Baechle 2008-07-16 @57  	.child = &rc32434_res_pci_mem2
>> 73b4390f Ralf Baechle 2008-07-16  58  };
>> 73b4390f Ralf Baechle 2008-07-16  59  
>> 
>> :::::: The code at line 57 was first introduced by commit
>> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
>> 
>> :::::: TO: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
>> :::::: CC: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>_______________________________________________
>kbuild-all mailing list
>kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
>https://lists.01.org/mailman/listinfo/kbuild-all
