From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Date: Thu, 26 Apr 2018 09:18:37 +0800
Message-ID: <20180426011837.GA79340@WeideMacBook-Pro.local>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180419001848.3041-2-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yaowei Bai <baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Patrik Jakobsson <patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg
List-Id: linux-input@vger.kernel.org

On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
>The struct resource uses singly linked list to link siblings. It's not
>easy to do reverse iteration on sibling list. So replace it with list_head.
>

Hi, Baoquan

Besides changing the data structure, I have another proposal to do the reverse
iteration. Which means it would not affect other users, if you just want a
reverse iteration.

BTW, I don't think Andrew suggest to use linked-list directly. What he wants
is a better solution to your first proposal in
https://patchwork.kernel.org/patch/10300819/.

Below is my proposal of resource reverse iteration without changing current
design.

>From 5d7145d44fe48b98572a03884fa3a3aa82e3cef9 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 24 Mar 2018 23:25:46 +0800
Subject: [PATCH] kernel/resource: add walk_system_ram_res_rev()

As discussed on https://patchwork.kernel.org/patch/10300819/, this patch
comes up with a variant implementation of walk_system_ram_res_rev(), which
uses iteration instead of allocating array to store those resources.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/ioport.h |   3 ++
 kernel/resource.c      | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..473f1d9cb97e 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -277,6 +277,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+		    int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 769109f20fb7..d4ec5fbc6875 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -73,6 +73,38 @@ static struct resource *next_resource(struct resource *p, bool sibling_only)
 	return p->sibling;
 }
 
+static struct resource *prev_resource(struct resource *p, bool sibling_only)
+{
+	struct resource *prev;
+	if (NULL == iomem_resource.child)
+		return NULL;
+
+	if (p == NULL) {
+		prev = iomem_resource.child;
+		while (prev->sibling)
+			prev = prev->sibling;
+	} else {
+		if (p->parent->child == p) {
+			return p->parent;
+		}
+
+		for (prev = p->parent->child; prev->sibling != p;
+			prev = prev->sibling) {}
+	}
+
+	/* Caller wants to traverse through siblings only */
+	if (sibling_only)
+		return prev;
+
+	for (;prev->child;) {
+		prev = prev->child;
+
+		while (prev->sibling)
+			prev = prev->sibling;
+	}
+	return prev;
+}
+
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
@@ -401,6 +433,47 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 	return 0;
 }
 
+/*
+ * Finds the highest iomem resource existing within [res->start.res->end).
+ * The caller must specify res->start, res->end, res->flags, and optionally
+ * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
+ * This function walks the whole tree and not just first level children until
+ * and unless first_level_children_only is true.
+ */
+static int find_prev_iomem_res(struct resource *res, unsigned long desc,
+			       bool first_level_children_only)
+{
+	struct resource *p;
+
+	BUG_ON(!res);
+	BUG_ON(res->start >= res->end);
+
+	read_lock(&resource_lock);
+
+	for (p = prev_resource(NULL, first_level_children_only); p;
+		p = prev_resource(p, first_level_children_only)) {
+		if ((p->flags & res->flags) != res->flags)
+			continue;
+		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
+			continue;
+		if (p->end < res->start || p->child == iomem_resource.child) {
+			p = NULL;
+			break;
+		}
+		if ((p->end >= res->start) && (p->start < res->end))
+			break;
+	}
+
+	read_unlock(&resource_lock);
+	if (!p)
+		return -1;
+	/* copy data */
+	resource_clip(res, p->start, p->end);
+	res->flags = p->flags;
+	res->desc = p->desc;
+	return 0;
+}
+
 static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 				 bool first_level_children_only,
 				 void *arg,
@@ -422,6 +495,27 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 	return ret;
 }
 
+static int __walk_iomem_res_rev_desc(struct resource *res, unsigned long desc,
+				 bool first_level_children_only,
+				 void *arg,
+				 int (*func)(struct resource *, void *))
+{
+	u64 orig_start = res->start;
+	int ret = -1;
+
+	while ((res->start < res->end) &&
+	       !find_prev_iomem_res(res, desc, first_level_children_only)) {
+		ret = (*func)(res, arg);
+		if (ret)
+			break;
+
+		res->end = res->start?(res->start - 1):0;
+		res->start = orig_start;
+	}
+
+	return ret;
+}
+
 /*
  * Walks through iomem resources and calls func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
@@ -468,6 +562,25 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     arg, func);
 }
 
+/*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	struct resource res;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return __walk_iomem_res_rev_desc(&res, IORES_DESC_NONE, true,
+				     arg, func);
+}
+
 /*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
-- 
2.15.1


-- 
Wei Yang
Help you, Help me
