From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 0/4] resource: Use list_head to link sibling resource
Date: Tue, 12 Jun 2018 11:28:27 +0800
Message-ID: <20180612032831.29747-1-bhe@redhat.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org
Cc: brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org, linuxppc-dev@lists.o
List-Id: linux-input@vger.kernel.org

This patchset is doing:
1) Replace struct resource's sibling list from singly linked list to
list_head. Clearing out those pointer operation within singly linked
list for better code readability.
2) Based on list_head replacement, add a new function
walk_system_ram_res_rev() which can does reversed iteration on
iomem_resource's siblings.
3) Change kexec_file loading to search system RAM top down for kernel
loadin, using walk_system_ram_res_rev().

Note:
This patchset passed testing on my kvm guest, x86_64 arch with network
enabling. The thing we need pay attetion to is that a root resource's
child member need be initialized specifically with LIST_HEAD_INIT() if
statically defined or INIT_LIST_HEAD() for dynamically definition. Here
Just like we do for iomem_resource/ioport_resource, or the change in
get_pci_domain_busn_res().


Links of the old post (Boris pointed out that we should use
https://lkml.kernel.org/r/Message-ID, while it can't be opened from
my side, so paste all of them here.):
v4:
https://lkml.kernel.org/r/20180507063224.24229-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
https://lkml.org/lkml/2018/5/7/36

v3:
https://lkml.kernel.org/r/20180419001848.3041-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
https://lkml.org/lkml/2018/4/18/767

v2:
https://lkml.kernel.org/r/20180408024724.16812-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
https://lkml.org/lkml/2018/4/7/169

v1:
https://lkml.kernel.org/r/20180322033722.9279-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
https://lkml.org/lkml/2018/3/21/952

Changelog:
v4->v5:
  Add new patch 0001 to move duplicated reparent_resources() to
  kernel/resource.c to make it be shared by different ARCH-es.

  Fix several code bugs reported by test robot on ARCH powerpc and
  microblaze.
v3->v4:
  Fix several bugs test robot reported. Rewrite cover letter and patch
  log according to reviewer's comment.

v2->v3:
  Rename resource functions first_child() and sibling() to
  resource_first_chils() and resource_sibling(). Dan suggested this.

  Move resource_first_chils() and resource_sibling() to linux/ioport.h
  and make them as inline function. Rob suggested this. Accordingly add
  linux/list.h including in linux/ioport.h, please help review if this
  bring efficiency degradation or code redundancy.

  The change on struct resource {} bring two pointers of size increase,
  mention this in git log to make it more specifically, Rob suggested
  this.

v1->v2:
  Use list_head instead to link resource siblings. This is suggested by
  Andrew.

  Rewrite walk_system_ram_res_rev() after list_head is taken to link
  resouce siblings.

Baoquan He (4):
  resource: Move reparent_resources() to kernel/resource.c and make it
    public
  resource: Use list_head to link sibling resource
  resource: add walk_system_ram_res_rev()
  kexec_file: Load kernel at top of system RAM if required

 arch/arm/plat-samsung/pm-check.c            |   6 +-
 arch/microblaze/pci/pci-common.c            |  41 +----
 arch/powerpc/kernel/pci-common.c            |  39 +----
 arch/sparc/kernel/ioport.c                  |   2 +-
 arch/xtensa/include/asm/pci-bridge.h        |   4 +-
 drivers/eisa/eisa-bus.c                     |   2 +
 drivers/gpu/drm/drm_memory.c                |   3 +-
 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++---
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/namespace_devs.c             |   6 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/parisc/lba_pci.c                    |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |  21 ++-
 kernel/kexec_file.c                         |   2 +
 kernel/resource.c                           | 259 ++++++++++++++++++----------
 20 files changed, 244 insertions(+), 227 deletions(-)

-- 
2.13.6
