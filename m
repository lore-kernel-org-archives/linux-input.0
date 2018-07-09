From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
Date: Mon, 9 Jul 2018 11:04:03 +0800
Message-ID: <20180709030403.GJ3047@MiWiFi-R3L-srv>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
 <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, brijesh.singh-5C7GfCeVMHo@public.gmane.org, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eric Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Josh Triplett <josh@josh>
List-Id: linux-input@vger.kernel.org

On 07/08/18 at 08:48pm, Andy Shevchenko wrote:
> On Sun, Jul 8, 2018 at 5:59 AM, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On 07/05/18 at 01:00am, kbuild test robot wrote:
> 
> > However, I didn't find below branch. And tried to open it in web
> > broswer, also failed.
> 
> While this is kinda valid point...
> 
> > Could you help have a look at this?
> 
> ...isn't obvious that you didn't change the file mentioned in a report?
> Just take latest linux-next and you will see.

Yes, it's clear to me. Just want to use the way to cross compile them on
ia64 and mips, hope I can find out all missed places on these ARCHes.
Now I think I can apply patches on linux-next, and use the config
attached to compile. Thanks.

> 
> 
> >> All error/warnings (new ones prefixed by >>):
> >>
> >> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>      .child = &rc32434_res_pci_mem2
> >>               ^
> >>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
> >> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
> >>     static struct resource rc32434_res_pci_mem1 = {
> >>                                                   ^
> >>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
> >>     static struct resource rc32434_res_pci_mem2 = {
> >>                                                   ^
> >>    cc1: some warnings being treated as errors
> >>
> >> vim +57 arch/mips/pci/pci-rc32434.c
> >>
> >> 73b4390f Ralf Baechle 2008-07-16  50
> >> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
> >> 73b4390f Ralf Baechle 2008-07-16  52          .name = "PCI MEM1",
> >> 73b4390f Ralf Baechle 2008-07-16  53          .start = 0x50000000,
> >> 73b4390f Ralf Baechle 2008-07-16  54          .end = 0x5FFFFFFF,
> >> 73b4390f Ralf Baechle 2008-07-16  55          .flags = IORESOURCE_MEM,
> >> 73b4390f Ralf Baechle 2008-07-16  56          .sibling = NULL,
> >> 73b4390f Ralf Baechle 2008-07-16 @57          .child = &rc32434_res_pci_mem2
> >> 73b4390f Ralf Baechle 2008-07-16  58  };
> >> 73b4390f Ralf Baechle 2008-07-16  59
> >>
> >> :::::: The code at line 57 was first introduced by commit
> >> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
> >>
> >> :::::: TO: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> >> :::::: CC: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> >>
> >> ---
> >> 0-DAY kernel test infrastructure                Open Source Technology Center
> >> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> >
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
