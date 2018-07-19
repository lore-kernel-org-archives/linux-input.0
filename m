From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Date: Thu, 19 Jul 2018 23:17:53 +0800
Message-ID: <20180719151753.GB7147@localhost.localdomain>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180718153326.b795e9ea7835432a56cd7011-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel@vge
List-Id: linux-input@vger.kernel.org

Hi Andrew,

On 07/18/18 at 03:33pm, Andrew Morton wrote:
> On Wed, 18 Jul 2018 10:49:44 +0800 Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
> > is used to load kernel/initrd/purgatory is supposed to be allocated from
> > top to down. This is what we have been doing all along in the old kexec
> > loading interface and the kexec loading is still default setting in some
> > distributions. However, the current kexec_file loading interface doesn't
> > do like this. The function arch_kexec_walk_mem() it calls ignores checking
> > kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
> > all resources of System RAM from bottom to up, to try to find memory region
> > which can contain the specific kexec buffer, then call locate_mem_hole_callback()
> > to allocate memory in that found memory region from top to down. This brings
> > confusion especially when KASLR is widely supported , users have to make clear
> > why kexec/kdump kernel loading position is different between these two
> > interfaces in order to exclude unnecessary noises. Hence these two interfaces
> > need be unified on behaviour.
> 
> As far as I can tell, the above is the whole reason for the patchset,
> yes?  To avoid confusing users.


In fact, it's not just trying to avoid confusing users. Kexec loading
and kexec_file loading are just do the same thing in essence. Just we
need do kernel image verification on uefi system, have to port kexec
loading code to kernel. 

Kexec has been a formal feature in our distro, and customers owning
those kind of very large machine can make use of this feature to speed
up the reboot process. On uefi machine, the kexec_file loading will
search place to put kernel under 4G from top to down. As we know, the
1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
it. It may have possibility to not be able to find a usable space for
kernel/initrd. From the top down of the whole memory space, we don't
have this worry. 

And at the first post, I just posted below with AKASHI's
walk_system_ram_res_rev() version. Later you suggested to use
list_head to link child sibling of resource, see what the code change
looks like.
http://lkml.kernel.org/r/20180322033722.9279-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Then I posted v2
http://lkml.kernel.org/r/20180408024724.16812-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Rob Herring mentioned that other components which has this tree struct
have planned to do the same thing, replacing the singly linked list with
list_head to link resource child sibling. Just quote Rob's words as
below. I think this could be another reason.

~~~~~ From Rob
The DT struct device_node also has the same tree structure with
parent, child, sibling pointers and converting to list_head had been
on the todo list for a while. ACPI also has some tree walking
functions (drivers/acpi/acpica/pstree.c). Perhaps there should be a
common tree struct and helpers defined either on top of list_head or a
~~~~~
new struct if that saves some size.

> 
> Is that sufficient?  Can we instead simplify their lives by providing
> better documentation or informative printks or better Kconfig text,
> etc?
> 
> And who *are* the people who are performing this configuration?  Random
> system administrators?  Linux distro engineers?  If the latter then
> they presumably aren't easily confused!

Kexec was invented for kernel developer to speed up their kernel
rebooting. Now high end sever admin, kernel developer and QE are also
keen to use it to reboot large box for faster feature testing, bug
debugging. Kernel dev could know this well, about kernel loading
position, admin or QE might not be aware of it very well. 

> 
> In other words, I'm trying to understand how much benefit this patchset
> will provide to our users as a whole.

Understood. The list_head replacing patch truly involes too many code
changes, it's risky. I am willing to try any idea from reviewers, won't
persuit they have to be accepted finally. If don't have a try, we don't
know what it looks like, and what impact it may have. I am fine to take
AKASHI's simple version of walk_system_ram_res_rev() to lower risk, even
though it could be a little bit low efficient.

Thanks
Baoquan
