From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/3] resource: Use list_head to link sibling resource
Date: Sun, 8 Apr 2018 17:09:44 +0800
Message-ID: <20180408090944.GF19345@localhost.localdomain>
References: <20180408024724.16812-2-bhe@redhat.com>
 <201804081223.lLuGQOqa%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201804081223.lLuGQOqa%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yaowei Bai <baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh@linuxfoundat>
List-Id: linux-input@vger.kernel.org

On 04/08/18 at 01:55pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180406]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sparc/kernel/ioport.c: In function 'sparc_io_proc_show':
> >> arch/sparc/kernel/ioport.c:672:9: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>             ^
>    arch/sparc/kernel/ioport.c:672:37: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>                                         ^

Thanks, will change and repost.

> 
> vim +672 arch/sparc/kernel/ioport.c
> 
> ^1da177e4 Linus Torvalds     2005-04-16  666  
> e7a088f93 Alexey Dobriyan    2009-09-01  667  static int sparc_io_proc_show(struct seq_file *m, void *v)
> ^1da177e4 Linus Torvalds     2005-04-16  668  {
> e7a088f93 Alexey Dobriyan    2009-09-01  669  	struct resource *root = m->private, *r;
> ^1da177e4 Linus Torvalds     2005-04-16  670  	const char *nm;
> ^1da177e4 Linus Torvalds     2005-04-16  671  
> e7a088f93 Alexey Dobriyan    2009-09-01 @672  	for (r = root->child; r != NULL; r = r->sibling) {
> c31f76518 Sam Ravnborg       2014-04-21  673  		if ((nm = r->name) == NULL) nm = "???";
> e7a088f93 Alexey Dobriyan    2009-09-01  674  		seq_printf(m, "%016llx-%016llx: %s\n",
> 685143ac1 Greg Kroah-Hartman 2006-06-12  675  				(unsigned long long)r->start,
> 685143ac1 Greg Kroah-Hartman 2006-06-12  676  				(unsigned long long)r->end, nm);
> ^1da177e4 Linus Torvalds     2005-04-16  677  	}
> ^1da177e4 Linus Torvalds     2005-04-16  678  
> e7a088f93 Alexey Dobriyan    2009-09-01  679  	return 0;
> ^1da177e4 Linus Torvalds     2005-04-16  680  }
> ^1da177e4 Linus Torvalds     2005-04-16  681  
> 
> :::::: The code at line 672 was first introduced by commit
> :::::: e7a088f935180b90cfe6ab0aaae8a556f46885fe sparc: convert /proc/io_map, /proc/dvma_map to seq_file
> 
> :::::: TO: Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> :::::: CC: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
