Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE254E80AD;
	Thu,  3 Sep 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450621; cv=none; b=pI6DuN1F0gUY7OflOKmuIUoYkYCm3saFR4uashUZ9lNjQMflF3eM4PUOhYDluNdQ8KjscXnncawvc/wKAWG3+HhGf27e4y4rcriSdob56mat1N3CMBzXw30MoObxom9/lLelfdfZE1EH7s5V/0//FODQFvRKWdkDQoOnIofQY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450621; c=relaxed/simple;
	bh=ZRM/vI4pMdCAo6YUtblt4PuGHpZv2gO8Gpotzfpm4o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYwPaEkYtyb2K8G5xOrsIV51KEansGH0lUkc6SFRShBoq6HVUYmyxeElDCqcly/nMBVk0c32YB0udhMvcXhk/lFpHD8M+JTqieDvSyyWejXJNG44q5YaI0YiF7/TEILDGMu8ttQ6uDpzC3zpnG8IrXG9uJPNGtYuOi15WEjVt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKSbt6d9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKSbt6d9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EBC1F00A3D;
	Thu,  3 Sep 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450619;
	bh=7gSlHxYgypuWgcZDQkom/SXcL5+3gzhc1fw1FAM1Py0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gKSbt6d9D0uAdEaOVghOguJ6c5AtIVGFZ05HuItgg8aSgDE7+88HwvowvZDc8M4u4
	 g5ZZqw3Lc7+MZm/ErnQ6lTH7QY1fKwso02uiRPA4Lqq2HQpjUBxVRHu9XcggliatYB
	 Ir8GpFHtraTriTsZPrQ7SPsYncQAtbqXCCnIz2jfVM5TtQHgUZLP18dr8d7VBx/0pv
	 SShtK+ubAdzhIquF0nf2gnu5G64PAJSJz9JbbW0oQBIxX2mhFJ6wgyRuuKgGI68uqF
	 qdRQd/XHSPvXQhsyPAEyo8sNgKYYrb9VcqX/Ub/P7IMdntF7IP5C2xnlesXk1istpT
	 LDFrk2HJ8zXHQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 18:50:01 +0300
Subject: [PATCH 4/5] mm/vmalloc: add DEFINE_FREE() for vfree()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-rox-cache-pmd-v1-v1-4-11beb2a3d249@kernel.org>
References: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
In-Reply-To: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.17-dev

... and use it in hid-core, the only place with a cleanup for a
vmalloc() allocation.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/hid/hid-core.c  | 4 ++--
 include/linux/vmalloc.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cdf..ec7c2860c93ef 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -944,7 +944,7 @@ static int hid_scan_report(struct hid_device *hid)
 		hid_parser_reserved
 	};
 
-	struct hid_parser *parser __free(kvfree) = vzalloc(sizeof(*parser));
+	struct hid_parser *parser __free(vfree) = vzalloc(sizeof(*parser));
 	if (!parser)
 		return -ENOMEM;
 
@@ -1265,7 +1265,7 @@ static int hid_parse_collections(struct hid_device *device)
 		hid_parser_reserved
 	};
 
-	struct hid_parser *parser __free(kvfree) = vzalloc(sizeof(*parser));
+	struct hid_parser *parser __free(vfree) = vzalloc(sizeof(*parser));
 	if (!parser)
 		return -ENOMEM;
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 6e555e31e6225..034a693777ca0 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -3,6 +3,7 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/alloc_tag.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
@@ -215,6 +216,8 @@ void *__must_check vrealloc_node_align_noprof(const void *p, size_t size,
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
+DEFINE_FREE(vfree, void *, if (!IS_ERR_OR_NULL(_T)) vfree(_T))
+
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);

-- 
2.53.0

