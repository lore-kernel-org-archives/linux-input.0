From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Date: Thu, 26 Jul 2018 15:12:43 +0200
Message-ID: <20180726131242.GI28386@dhcp22.suse.cz>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
 <20180723143443.GD18181@dhcp22.suse.cz>
 <20180725064813.GI6480@MiWiFi-R3L-srv>
 <20180726125957.GH28386@dhcp22.suse.cz>
 <20180726130904.GL6480@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180726130904.GL6480@MiWiFi-R3L-srv>
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
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel@vger
List-Id: linux-input@vger.kernel.org

On Thu 26-07-18 21:09:04, Baoquan He wrote:
> On 07/26/18 at 02:59pm, Michal Hocko wrote:
> > On Wed 25-07-18 14:48:13, Baoquan He wrote:
> > > On 07/23/18 at 04:34pm, Michal Hocko wrote:
> > > > On Thu 19-07-18 23:17:53, Baoquan He wrote:
> > > > > Kexec has been a formal feature in our distro, and customers owning
> > > > > those kind of very large machine can make use of this feature to speed
> > > > > up the reboot process. On uefi machine, the kexec_file loading will
> > > > > search place to put kernel under 4G from top to down. As we know, the
> > > > > 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> > > > > it. It may have possibility to not be able to find a usable space for
> > > > > kernel/initrd. From the top down of the whole memory space, we don't
> > > > > have this worry. 
> > > > 
> > > > I do not have the full context here but let me note that you should be
> > > > careful when doing top-down reservation because you can easily get into
> > > > hotplugable memory and break the hotremove usecase. We even warn when
> > > > this is done. See memblock_find_in_range_node
> > > 
> > > Kexec read kernel/initrd file into buffer, just search usable positions
> > > for them to do the later copying. You can see below struct kexec_segment, 
> > > for the old kexec_load, kernel/initrd are read into user space buffer,
> > > the @buf stores the user space buffer address, @mem stores the position
> > > where kernel/initrd will be put. In kernel, it calls
> > > kimage_load_normal_segment() to copy user space buffer to intermediate
> > > pages which are allocated with flag GFP_KERNEL. These intermediate pages
> > > are recorded as entries, later when user execute "kexec -e" to trigger
> > > kexec jumping, it will do the final copying from the intermediate pages
> > > to the real destination pages which @mem pointed. Because we can't touch
> > > the existed data in 1st kernel when do kexec kernel loading. With my
> > > understanding, GFP_KERNEL will make those intermediate pages be
> > > allocated inside immovable area, it won't impact hotplugging. But the
> > > @mem we searched in the whole system RAM might be lost along with
> > > hotplug. Hence we need do kexec kernel again when hotplug event is
> > > detected.
> > 
> > I am not sure I am following. If @mem is placed at movable node then the
> > memory hotremove simply won't work, because we are seeing reserved pages
> > and do not know what to do about them. They are not migrateable.
> > Allocating intermediate pages from other nodes doesn't really help.
> 
> OK, I forgot the 2nd kernel which kexec jump into. It won't impact hotremove
> in 1st kernel, it does impact the kernel which kexec jump into if kernel
> is at top of system RAM and the top RAM is in movable node.

It will affect the 1st kernel (which does the memblock allocation
top-down) as well. For reasons mentioned above.
-- 
Michal Hocko
SUSE Labs
