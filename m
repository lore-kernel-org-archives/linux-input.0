From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Date: Wed,  4 Jul 2018 12:10:35 +0800
Message-ID: <20180704041038.8190-2-bhe@redhat.com>
References: <20180704041038.8190-1-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180704041038.8190-1-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: brijesh.singh-5C7GfCeVMHo@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, baiyaowei-0p4V/sDNsUmm0O/7XYngnFaTQe2KTcn/@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem@davem
List-Id: linux-input@vger.kernel.org

reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
so that it's shared.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/microblaze/pci/pci-common.c | 37 -------------------------------------
 arch/powerpc/kernel/pci-common.c | 35 -----------------------------------
 include/linux/ioport.h           |  1 +
 kernel/resource.c                | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 72 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index f34346d56095..7899bafab064 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -619,43 +619,6 @@ int pcibios_add_device(struct pci_dev *dev)
 EXPORT_SYMBOL(pcibios_add_device);
 
 /*
- * Reparent resource children of pr that conflict with res
- * under res, and make res replace those children.
- */
-static int __init reparent_resources(struct resource *parent,
-				     struct resource *res)
-{
-	struct resource *p, **pp;
-	struct resource **firstpp = NULL;
-
-	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
-		if (p->end < res->start)
-			continue;
-		if (res->end < p->start)
-			break;
-		if (p->start < res->start || p->end > res->end)
-			return -1;	/* not completely contained */
-		if (firstpp == NULL)
-			firstpp = pp;
-	}
-	if (firstpp == NULL)
-		return -1;	/* didn't find any conflicting entries? */
-	res->parent = parent;
-	res->child = *firstpp;
-	res->sibling = *pp;
-	*firstpp = res;
-	*pp = NULL;
-	for (p = res->child; p != NULL; p = p->sibling) {
-		p->parent = res;
-		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
-			 p->name,
-			 (unsigned long long)p->start,
-			 (unsigned long long)p->end, res->name);
-	}
-	return 0;
-}
-
-/*
  *  Handle resources of PCI devices.  If the world were perfect, we could
  *  just allocate all the resource regions and do nothing more.  It isn't.
  *  On the other hand, we cannot just re-allocate all devices, as it would
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe9733ffffaa..926035bb378d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1088,41 +1088,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 EXPORT_SYMBOL(pcibios_align_resource);
 
 /*
- * Reparent resource children of pr that conflict with res
- * under res, and make res replace those children.
- */
-static int reparent_resources(struct resource *parent,
-				     struct resource *res)
-{
-	struct resource *p, **pp;
-	struct resource **firstpp = NULL;
-
-	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
-		if (p->end < res->start)
-			continue;
-		if (res->end < p->start)
-			break;
-		if (p->start < res->start || p->end > res->end)
-			return -1;	/* not completely contained */
-		if (firstpp == NULL)
-			firstpp = pp;
-	}
-	if (firstpp == NULL)
-		return -1;	/* didn't find any conflicting entries? */
-	res->parent = parent;
-	res->child = *firstpp;
-	res->sibling = *pp;
-	*firstpp = res;
-	*pp = NULL;
-	for (p = res->child; p != NULL; p = p->sibling) {
-		p->parent = res;
-		pr_debug("PCI: Reparented %s %pR under %s\n",
-			 p->name, p, res->name);
-	}
-	return 0;
-}
-
-/*
  *  Handle resources of PCI devices.  If the world were perfect, we could
  *  just allocate all the resource regions and do nothing more.  It isn't.
  *  On the other hand, we cannot just re-allocate all devices, as it would
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..dfdcd0bfe54e 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -192,6 +192,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
+int reparent_resources(struct resource *parent, struct resource *res);
 resource_size_t resource_alignment(struct resource *res);
 static inline resource_size_t resource_size(const struct resource *res)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..d1cbf4b50e17 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -983,6 +983,45 @@ int adjust_resource(struct resource *res, resource_size_t start,
 }
 EXPORT_SYMBOL(adjust_resource);
 
+/*
+ * reparent_resources - reparent resource children of parent that res covers
+ * @parent: parent resource descriptor
+ * @res: resource descriptor desired by caller
+ *
+ * Reparent resource children of 'parent' that conflict with 'res'
+ * under 'res', and make 'res' replace those children.
+ */
+int reparent_resources(struct resource *parent, struct resource *res)
+{
+	struct resource *p, **pp;
+	struct resource **firstpp = NULL;
+
+	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
+		if (p->end < res->start)
+			continue;
+		if (res->end < p->start)
+			break;
+		if (p->start < res->start || p->end > res->end)
+			return -ENOTSUPP;	/* not completely contained */
+		if (firstpp == NULL)
+			firstpp = pp;
+	}
+	if (firstpp == NULL)
+		return -ECANCELED; /* didn't find any conflicting entries? */
+	res->parent = parent;
+	res->child = *firstpp;
+	res->sibling = *pp;
+	*firstpp = res;
+	*pp = NULL;
+	for (p = res->child; p != NULL; p = p->sibling) {
+		p->parent = res;
+		pr_debug("PCI: Reparented %s %pR under %s\n",
+			 p->name, p, res->name);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(reparent_resources);
+
 static void __init __reserve_region_with_split(struct resource *root,
 		resource_size_t start, resource_size_t end,
 		const char *name)
-- 
2.13.6
