From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Date: Sun, 6 May 2018 14:30:14 +0800
Message-ID: <20180506063014.GG19030@localhost.localdomain>
References: <20180419001848.3041-2-bhe@redhat.com>
 <201804261137.HPgv5SSG%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201804261137.HPgv5SSG%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yaowei Bai <baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.o>
List-Id: linux-input@vger.kernel.org

On 04/26/18 at 11:23am, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180419-223752
> config: xtensa-common_defconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/xtensa/lib/pci-auto.c:22:0:
>    arch/xtensa/include/asm/pci-bridge.h: In function 'pcibios_init_resource':
> >> arch/xtensa/include/asm/pci-bridge.h:74:15: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->sibling = NULL;
>                   ^
>    arch/xtensa/include/asm/pci-bridge.h:75:13: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->child = NULL;

Thanks, below fix can fix it.

diff --git a/arch/xtensa/include/asm/pci-bridge.h b/arch/xtensa/include/asm/pci-bridge.h
index 0b68c76ec1e6..f487b06817df 100644
--- a/arch/xtensa/include/asm/pci-bridge.h
+++ b/arch/xtensa/include/asm/pci-bridge.h
@@ -71,8 +71,8 @@ static inline void pcibios_init_resource(struct resource *res,
 	res->flags = flags;
 	res->name = name;
 	res->parent = NULL;
-	res->sibling = NULL;
-	res->child = NULL;
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 }
 
 

>                 ^
> 
> vim +74 arch/xtensa/include/asm/pci-bridge.h
> 
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  65  
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  66  static inline void pcibios_init_resource(struct resource *res,
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  67  		unsigned long start, unsigned long end, int flags, char *name)
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  68  {
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  69  	res->start = start;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  70  	res->end = end;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  71  	res->flags = flags;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  72  	res->name = name;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  73  	res->parent = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23 @74  	res->sibling = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  75  	res->child = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  76  }
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  77  
> 
> :::::: The code at line 74 was first introduced by commit
> :::::: 9a8fd5589902153a134111ed7a40f9cca1f83254 [PATCH] xtensa: Architecture support for Tensilica Xtensa Part 6
> 
> :::::: TO: Chris Zankel <czankel-66fqrpuXKgGB+jHODAdFcQ@public.gmane.org>
> :::::: CC: Linus Torvalds <torvalds-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
