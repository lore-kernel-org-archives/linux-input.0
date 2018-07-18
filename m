From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Date: Wed, 18 Jul 2018 19:36:17 +0300
Message-ID: <CAHp75VdO88ydJQ9GHdaDUmAmzL6QHR=US6JiXZ1R_EEA-xWR1Q@mail.gmail.com>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-2-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180718024944.577-2-bhe@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Baoquan He <bhe@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, brijesh.singh@amd.com, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, baiyaowei@cmss.chinamobile.com, Frank Rowand <frowand.list@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org, Michael Ellerman <mpe@ellerman.id.au>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input <linux-input@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>, Maarten
List-Id: linux-input@vger.kernel.org

On Wed, Jul 18, 2018 at 5:49 AM, Baoquan He <bhe@redhat.com> wrote:
> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> so that it's shared.

Some minor stuff.

> +/**
> + * reparent_resources - reparent resource children of parent that res covers
> + * @parent: parent resource descriptor
> + * @res: resource descriptor desired by caller
> + *
> + * Returns 0 on success, -ENOTSUPP if child resource is not completely
> + * contained by 'res', -ECANCELED if no any conflicting entry found.

'res' -> @res

> + *
> + * Reparent resource children of 'parent' that conflict with 'res'

Ditto + 'parent' -> @parent

> + * under 'res', and make 'res' replace those children.

Ditto.

> + */
> +int reparent_resources(struct resource *parent, struct resource *res)
> +{
> +       struct resource *p, **pp;
> +       struct resource **firstpp = NULL;
> +
> +       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> +               if (p->end < res->start)
> +                       continue;
> +               if (res->end < p->start)
> +                       break;
> +               if (p->start < res->start || p->end > res->end)
> +                       return -ENOTSUPP;       /* not completely contained */
> +               if (firstpp == NULL)
> +                       firstpp = pp;
> +       }
> +       if (firstpp == NULL)
> +               return -ECANCELED; /* didn't find any conflicting entries? */
> +       res->parent = parent;
> +       res->child = *firstpp;
> +       res->sibling = *pp;
> +       *firstpp = res;
> +       *pp = NULL;
> +       for (p = res->child; p != NULL; p = p->sibling) {
> +               p->parent = res;

> +               pr_debug("PCI: Reparented %s %pR under %s\n",
> +                        p->name, p, res->name);

Now, PCI is a bit confusing here.

> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL(reparent_resources);
> +
>  static void __init __reserve_region_with_split(struct resource *root,
>                 resource_size_t start, resource_size_t end,
>                 const char *name)
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
