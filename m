From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Date: Tue, 8 May 2018 20:11:23 +0800
Message-ID: <20180508121123.GI30581@MiWiFi-R3L-srv>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
 <20180507011429.GG30581@MiWiFi-R3L-srv>
 <20180508114845.GA19459@WeideMacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180508114845.GA19459-1F0jQSPB5oJ4KljauMffTLjjLBE8jN/0@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yaowei Bai <baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.>
List-Id: linux-input@vger.kernel.org

On 05/08/18 at 08:48pm, Wei Yang wrote:
> On Mon, May 07, 2018 at 09:14:29AM +0800, Baoquan He wrote:
> >Hi Wei Yang,
> >
> >On 04/26/18 at 09:18am, Wei Yang wrote:
> >> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
> >> >The struct resource uses singly linked list to link siblings. It's not
> >> >easy to do reverse iteration on sibling list. So replace it with list_head.
> >> >
> >> 
> >> Hi, Baoquan
> >> 
> >> Besides changing the data structure, I have another proposal to do the reverse
> >> iteration. Which means it would not affect other users, if you just want a
> >> reverse iteration.
> >> 
> >> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
> >> is a better solution to your first proposal in
> >> https://patchwork.kernel.org/patch/10300819/.
> >> 
> >> Below is my proposal of resource reverse iteration without changing current
> >> design.
> >
> >I got your mail and read it, then interrupted by other thing and forgot
> >replying, sorry.
> >
> >I am fine with your code change. As I said before, I have tried to change
> >code per reviewers' comment, then let reviewers decide which way is
> >better. Please feel free to post formal patches and joining discussion
> >about this issue.
> 
> Yep, while I don't have a real requirement to add the reverse version, so what
> is the proper way to send a patch?
> 
> A patch reply to this thread is ok?

I am not sure either. Since my patches are still under reviewing. And
you have pasted your patch. It depends on maintainers, mainly Andrew and
other reviewers who have concerns.
