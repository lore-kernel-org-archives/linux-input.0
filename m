From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
Date: Sun, 8 Jul 2018 20:48:22 +0300
Message-ID: <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180708025946.GI3047@MiWiFi-R3L-srv>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Baoquan He <bhe@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, brijesh.singh@amd.com, Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, baiyaowei@cmss.chinamobile.com, Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input <linux-input@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, devicetree <devicetree@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.>
List-Id: linux-input@vger.kernel.org

On Sun, Jul 8, 2018 at 5:59 AM, Baoquan He <bhe@redhat.com> wrote:
> On 07/05/18 at 01:00am, kbuild test robot wrote:

> However, I didn't find below branch. And tried to open it in web
> broswer, also failed.

While this is kinda valid point...

> Could you help have a look at this?

...isn't obvious that you didn't change the file mentioned in a report?
Just take latest linux-next and you will see.


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
>> 73b4390f Ralf Baechle 2008-07-16  52          .name = "PCI MEM1",
>> 73b4390f Ralf Baechle 2008-07-16  53          .start = 0x50000000,
>> 73b4390f Ralf Baechle 2008-07-16  54          .end = 0x5FFFFFFF,
>> 73b4390f Ralf Baechle 2008-07-16  55          .flags = IORESOURCE_MEM,
>> 73b4390f Ralf Baechle 2008-07-16  56          .sibling = NULL,
>> 73b4390f Ralf Baechle 2008-07-16 @57          .child = &rc32434_res_pci_mem2
>> 73b4390f Ralf Baechle 2008-07-16  58  };
>> 73b4390f Ralf Baechle 2008-07-16  59
>>
>> :::::: The code at line 57 was first introduced by commit
>> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
>>
>> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>



-- 
With Best Regards,
Andy Shevchenko
