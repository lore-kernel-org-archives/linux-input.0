From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource
 sibling
Date: Mon, 9 Apr 2018 12:05:20 -0400 (EDT)
Message-ID: <nycvar.YSQ.7.76.1804091133330.28462@knanqh.ubzr>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>, Keith Busch <keith.busch@intel.com>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org, Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>, =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Jonathan Derrick <jonathan.derrick@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundatio>
List-Id: linux-input@vger.kernel.org

On Mon, 9 Apr 2018, Rob Herring wrote:

> +Nico who has been working on tinification of the kernel.
> 
> On Mon, Apr 9, 2018 at 4:08 AM, Baoquan He <bhe@redhat.com> wrote:
> > The struct resource uses singly linked list to link siblings. It's not
> > easy to do reverse iteration on sibling list. So replace it with list_head.
> 
> Why is reverse iteration needed?
> 
> > And code refactoring makes codes in kernel/resource.c more readable than
> > pointer operation.
> 
> resource_for_each_* helpers could solve that without the size increase.
> 
> > Besides, type of member variables of struct resource, sibling and child, are
> > changed from 'struct resource *' to 'struct list_head'. Kernel size will
> > increase because of those statically defined struct resource instances.
> 
> The DT struct device_node also has the same tree structure with
> parent, child, sibling pointers and converting to list_head had been
> on the todo list for a while. ACPI also has some tree walking
> functions (drivers/acpi/acpica/pstree.c). Perhaps there should be a
> common tree struct and helpers defined either on top of list_head or a
> new struct if that saves some size.
> 
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> >   Make sibling() and first_child() global so that they can be called
> >   out of kernel/resource.c to simplify code.
> 
> These should probably be inline functions. Or exported if not.
> 
> >
> >   Fix several code bugs found by kbuild test robot.
> >
> >   Got report from lkp that kernel size increased. It's on purpose since
> >   the type change of sibling and child inside struct resource{}. For
> >   each struct resource variable, it will cost another 16 bytes on x86 64.
> 
> The size increase should be mentioned in the commit log. More
> generally, the size increase is 2 pointers.

Tiny kernels have much fewer resources anyway, and usually run on 
platforms with 32-bit pointers, so this probably won't matter much in 
the end.

This is if reverse iteration is actually needed as you say though.
Unless I'm mistaken, resource iteration doesn't happen that often, and 
not in critical paths either.

Making the code clearer while keeping the same structure size could be 
considered with the help of llist.h instead.


Nicolas
