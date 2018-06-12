From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH v5 2/4] resource: Use list_head to link sibling resource
Date: Tue, 12 Jun 2018 17:10:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1806121708070.3334@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: brijesh.singh-5C7GfCeVMHo@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org, linuxppc-dev@lists.o
List-Id: linux-input@vger.kernel.org

This looks wrong.  After a list iterator, the index variable points to a
dummy structure.

julia

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600
:::::: branch date: 7 hours ago
:::::: commit date: 7 hours ago

>> kernel/resource.c:265:17-20: ERROR: invalid reference to the index variable of the iterator on line 253

# https://github.com/0day-ci/linux/commit/e906f15906750a86913ba2b1f08bad99129d3dfc
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout e906f15906750a86913ba2b1f08bad99129d3dfc
vim +265 kernel/resource.c

^1da177e4 Linus Torvalds 2005-04-16  247
5eeec0ec9 Yinghai Lu     2009-12-22  248  static void __release_child_resources(struct resource *r)
5eeec0ec9 Yinghai Lu     2009-12-22  249  {
e906f1590 Baoquan He     2018-06-12  250  	struct resource *tmp, *next;
5eeec0ec9 Yinghai Lu     2009-12-22  251  	resource_size_t size;
5eeec0ec9 Yinghai Lu     2009-12-22  252
e906f1590 Baoquan He     2018-06-12 @253  	list_for_each_entry_safe(tmp, next, &r->child, sibling) {
5eeec0ec9 Yinghai Lu     2009-12-22  254  		tmp->parent = NULL;
e906f1590 Baoquan He     2018-06-12  255  		INIT_LIST_HEAD(&tmp->sibling);
5eeec0ec9 Yinghai Lu     2009-12-22  256  		__release_child_resources(tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  257
5eeec0ec9 Yinghai Lu     2009-12-22  258  		printk(KERN_DEBUG "release child resource %pR\n", tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  259  		/* need to restore size, and keep flags */
5eeec0ec9 Yinghai Lu     2009-12-22  260  		size = resource_size(tmp);
5eeec0ec9 Yinghai Lu     2009-12-22  261  		tmp->start = 0;
5eeec0ec9 Yinghai Lu     2009-12-22  262  		tmp->end = size - 1;
5eeec0ec9 Yinghai Lu     2009-12-22  263  	}
e906f1590 Baoquan He     2018-06-12  264
e906f1590 Baoquan He     2018-06-12 @265  	INIT_LIST_HEAD(&tmp->child);
5eeec0ec9 Yinghai Lu     2009-12-22  266  }
5eeec0ec9 Yinghai Lu     2009-12-22  267

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
