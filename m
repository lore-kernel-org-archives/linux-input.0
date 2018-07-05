From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Date: Thu, 5 Jul 2018 18:09:39 +0800
Message-ID: <20180705100939.GD1225@MiWiFi-R3L-srv>
References: <20180704041038.8190-1-bhe@redhat.com>
 <20180704041038.8190-2-bhe@redhat.com>
 <CAHp75VfWLcQq4XGM3RyfO_ENx=3=WrCEhtOw+a0Sfwz_OpQ0UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfWLcQq4XGM3RyfO_ENx=3=WrCEhtOw+a0Sfwz_OpQ0UQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Josh Triplett <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob
List-Id: linux-input@vger.kernel.org

On 07/04/18 at 07:46pm, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 7:10 AM, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> > and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> > so that it's shared.
> 
> With couple of comments below,

Sure, will fix these and repost with your reviewed-by, thanks. Should be
after I reproduce and fix those issues reported by test robot.

> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> P.S. In some commit message in this series you used 'likt' instead of 'like'.
> 
> >
> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/microblaze/pci/pci-common.c | 37 -------------------------------------
> >  arch/powerpc/kernel/pci-common.c | 35 -----------------------------------
> >  include/linux/ioport.h           |  1 +
> >  kernel/resource.c                | 39 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 40 insertions(+), 72 deletions(-)
> >
> > diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> > index f34346d56095..7899bafab064 100644
> > --- a/arch/microblaze/pci/pci-common.c
> > +++ b/arch/microblaze/pci/pci-common.c
> > @@ -619,43 +619,6 @@ int pcibios_add_device(struct pci_dev *dev)
> >  EXPORT_SYMBOL(pcibios_add_device);
> >
> >  /*
> > - * Reparent resource children of pr that conflict with res
> > - * under res, and make res replace those children.
> > - */
> > -static int __init reparent_resources(struct resource *parent,
> > -                                    struct resource *res)
> > -{
> > -       struct resource *p, **pp;
> > -       struct resource **firstpp = NULL;
> > -
> > -       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> > -               if (p->end < res->start)
> > -                       continue;
> > -               if (res->end < p->start)
> > -                       break;
> > -               if (p->start < res->start || p->end > res->end)
> > -                       return -1;      /* not completely contained */
> > -               if (firstpp == NULL)
> > -                       firstpp = pp;
> > -       }
> > -       if (firstpp == NULL)
> > -               return -1;      /* didn't find any conflicting entries? */
> > -       res->parent = parent;
> > -       res->child = *firstpp;
> > -       res->sibling = *pp;
> > -       *firstpp = res;
> > -       *pp = NULL;
> > -       for (p = res->child; p != NULL; p = p->sibling) {
> > -               p->parent = res;
> > -               pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
> > -                        p->name,
> > -                        (unsigned long long)p->start,
> > -                        (unsigned long long)p->end, res->name);
> > -       }
> > -       return 0;
> > -}
> > -
> > -/*
> >   *  Handle resources of PCI devices.  If the world were perfect, we could
> >   *  just allocate all the resource regions and do nothing more.  It isn't.
> >   *  On the other hand, we cannot just re-allocate all devices, as it would
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index fe9733ffffaa..926035bb378d 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1088,41 +1088,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  EXPORT_SYMBOL(pcibios_align_resource);
> >
> >  /*
> > - * Reparent resource children of pr that conflict with res
> > - * under res, and make res replace those children.
> > - */
> > -static int reparent_resources(struct resource *parent,
> > -                                    struct resource *res)
> > -{
> > -       struct resource *p, **pp;
> > -       struct resource **firstpp = NULL;
> > -
> > -       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> > -               if (p->end < res->start)
> > -                       continue;
> > -               if (res->end < p->start)
> > -                       break;
> > -               if (p->start < res->start || p->end > res->end)
> > -                       return -1;      /* not completely contained */
> > -               if (firstpp == NULL)
> > -                       firstpp = pp;
> > -       }
> > -       if (firstpp == NULL)
> > -               return -1;      /* didn't find any conflicting entries? */
> > -       res->parent = parent;
> > -       res->child = *firstpp;
> > -       res->sibling = *pp;
> > -       *firstpp = res;
> > -       *pp = NULL;
> > -       for (p = res->child; p != NULL; p = p->sibling) {
> > -               p->parent = res;
> > -               pr_debug("PCI: Reparented %s %pR under %s\n",
> > -                        p->name, p, res->name);
> > -       }
> > -       return 0;
> > -}
> > -
> > -/*
> >   *  Handle resources of PCI devices.  If the world were perfect, we could
> >   *  just allocate all the resource regions and do nothing more.  It isn't.
> >   *  On the other hand, we cannot just re-allocate all devices, as it would
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index da0ebaec25f0..dfdcd0bfe54e 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -192,6 +192,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
> >  struct resource *lookup_resource(struct resource *root, resource_size_t start);
> >  int adjust_resource(struct resource *res, resource_size_t start,
> >                     resource_size_t size);
> > +int reparent_resources(struct resource *parent, struct resource *res);
> >  resource_size_t resource_alignment(struct resource *res);
> >  static inline resource_size_t resource_size(const struct resource *res)
> >  {
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 30e1bc68503b..d1cbf4b50e17 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -983,6 +983,45 @@ int adjust_resource(struct resource *res, resource_size_t start,
> >  }
> >  EXPORT_SYMBOL(adjust_resource);
> >
> > +/*
> 
> /** ?
> 
> > + * reparent_resources - reparent resource children of parent that res covers
> > + * @parent: parent resource descriptor
> > + * @res: resource descriptor desired by caller
> > + *
> > + * Reparent resource children of 'parent' that conflict with 'res'
> > + * under 'res', and make 'res' replace those children.
> 
> Describe error codes, please.
> 
> > + */
> > +int reparent_resources(struct resource *parent, struct resource *res)
> > +{
> > +       struct resource *p, **pp;
> > +       struct resource **firstpp = NULL;
> > +
> > +       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> > +               if (p->end < res->start)
> > +                       continue;
> > +               if (res->end < p->start)
> > +                       break;
> > +               if (p->start < res->start || p->end > res->end)
> > +                       return -ENOTSUPP;       /* not completely contained */
> > +               if (firstpp == NULL)
> > +                       firstpp = pp;
> > +       }
> > +       if (firstpp == NULL)
> > +               return -ECANCELED; /* didn't find any conflicting entries? */
> > +       res->parent = parent;
> > +       res->child = *firstpp;
> > +       res->sibling = *pp;
> > +       *firstpp = res;
> > +       *pp = NULL;
> > +       for (p = res->child; p != NULL; p = p->sibling) {
> > +               p->parent = res;
> > +               pr_debug("PCI: Reparented %s %pR under %s\n",
> > +                        p->name, p, res->name);
> > +       }
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(reparent_resources);
> > +
> >  static void __init __reserve_region_with_split(struct resource *root,
> >                 resource_size_t start, resource_size_t end,
> >                 const char *name)
> > --
> > 2.13.6
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
