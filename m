From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/4] resource: Use list_head to link sibling resource
Date: Tue, 12 Jun 2018 12:37:50 +0800
Message-ID: <201806121242.NKm8SoJR%fengguang.wu@intel.com>
References: <20180612032831.29747-3-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180612032831.29747-3-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWMP3drIcvDWNA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/resource.c: In function 'reparent_resources':
>> kernel/resource.c:1005:26: error: passing argument 2 of 'list_add' from incompatible pointer type [-Werror=incompatible-pointer-types]
     list_add(&res->sibling, &p->sibling.prev);
                             ^
   In file included from include/linux/ioport.h:15:0,
                    from kernel/resource.c:14:
   include/linux/list.h:77:20: note: expected 'struct list_head *' but argument is of type 'struct list_head **'
    static inline void list_add(struct list_head *new, struct list_head *head)
                       ^~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/ioport.h:15,
                    from kernel/resource.c:14:
>> kernel/resource.c:1013:26: error: 'new' undeclared (first use in this function); did you mean 'net'?
     list_for_each_entry(p, &new->child, sibling) {
                             ^
   include/linux/kernel.h:963:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   kernel/resource.c:1013:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(p, &new->child, sibling) {
     ^~~~~~~~~~~~~~~~~~~
   kernel/resource.c:1013:26: note: each undeclared identifier is reported only once for each function it appears in
     list_for_each_entry(p, &new->child, sibling) {
                             ^
   include/linux/kernel.h:963:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   kernel/resource.c:1013:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(p, &new->child, sibling) {
     ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/list_add +1005 kernel/resource.c

   983	
   984	/*
   985	 * Reparent resource children of pr that conflict with res
   986	 * under res, and make res replace those children.
   987	 */
   988	int reparent_resources(struct resource *parent, struct resource *res)
   989	{
   990		struct resource *p, *first = NULL;
   991	
   992		list_for_each_entry(p, &parent->child, sibling) {
   993			if (p->end < res->start)
   994				continue;
   995			if (res->end < p->start)
   996				break;
   997			if (p->start < res->start || p->end > res->end)
   998				return -1;	/* not completely contained */
   999			if (first == NULL)
  1000				first = p;
  1001		}
  1002		if (first == NULL)
  1003			return -1;	/* didn't find any conflicting entries? */
  1004		res->parent = parent;
> 1005		list_add(&res->sibling, &p->sibling.prev);
  1006		INIT_LIST_HEAD(&res->child);
  1007	
  1008		/*
  1009		 * From first to p's previous sibling, they all fall into
  1010		 * res's region, change them as res's children.
  1011		 */
  1012		list_cut_position(&res->child, first->sibling.prev, res->sibling.prev);
> 1013		list_for_each_entry(p, &new->child, sibling) {
  1014	                p->parent = new;
  1015			pr_debug("PCI: Reparented %s %pR under %s\n",
  1016				 p->name, p, res->name);
  1017		}
  1018		return 0;
  1019	}
  1020	EXPORT_SYMBOL(reparent_resources);
  1021	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
