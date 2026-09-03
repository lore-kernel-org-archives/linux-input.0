Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AD4AA006;
	Thu,  3 Sep 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450616; cv=none; b=hWeo+z+MifugTVtuS1R6hQ1dTES6x3S5Js1h0K97TJ9KOXDKNvEGvZf6q4F86XsozyeJNb6TQZbSl9h9+TPOViUG3ZCCyBzw7qj9uYIaNPuS+Qdf5I7b9vj6eCs6mOOWRinCfIGsdnp2pVVwc2QguVA7K6LqbDw5ODExHO73DFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450616; c=relaxed/simple;
	bh=buyWxt0I1SrEkXs2Ifwprv+7bPz9xmj8G04s9XU86sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNgufGH9JofHFCf3SHijq+AuibfLBjw+hxO0QqWysS6aXNpywVw7e0JAf5HDCzHonD/MlMl+uacKfvfm065Tt/UMq8fPLBblPgl8ybsp6nnj0DhNXW/VgMjrx7iO0LcrH9j5X8I8GPXSk2gB7C8Nt0wIr3UKjD5mY0AqohC7xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyoLOKJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyoLOKJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8AB1F00A3D;
	Thu,  3 Sep 2026 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450614;
	bh=xpQ+G6UtTo2w3vyGJPJeznHQWpBOtRAhjixM5nGiCoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HyoLOKJlU9flwF2tT95Ezp08U5AhXSIDW6og1SM/XSDUw+ZQVccfNY8oQaha0E0Kv
	 /rU0Pr4QbVxBgR8Xy+3VEwTVZhF36XqveFhT3x79iLceMUMQg1hb2ZY4ZyMYy/qz03
	 62r8CxxYR9CU1ryqkbjIG4TFhmGcFIWz5fcP/Nhd7i2GGIVre1vHE4RFycDA3QxQwG
	 kvywX37z7XHhtxCdfK6XJD7DslU/in2CwWvyvs5Mxmq9EjR79fNlCfHnEfTAhPXd3K
	 9Ntn063U9QxDcrODPy77wGWla25VW1v9uZsR2acs2+VMWoO5qb7GoGxjhFFzouPdn4
	 E1HS8YABSiUXA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 18:49:59 +0300
Subject: [PATCH 2/5] mm/execmem: handle potential allocation errors in the
 maple tree
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-rox-cache-pmd-v1-v1-2-11beb2a3d249@kernel.org>
References: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
In-Reply-To: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.17-dev

execmem_cache_clean() and execmem_cache_alloc_locked() ignore potential
allocation failures in mas_store_gfp().

While in practice they are unlikely to happen, it's better to handle
those errors and ensure the integrity of the ROX cache.

Preallocate the maple tree nodes for the stores that must not fail and
order the maple tree updates so that there won't be any failures once a
tree has been modified.

Assisted-by: copilot:claude-opus-5
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index ba277790e3132..00dd6324cae01 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -149,7 +149,15 @@ static void execmem_cache_clean(struct work_struct *work)
 		if (vm && get_vm_area_size(vm) == size &&
 		    IS_ALIGNED(size, PMD_SIZE) &&
 		    IS_ALIGNED(mas.index, PMD_SIZE)) {
-			mas_store_gfp(&mas, NULL, GFP_KERNEL);
+			/*
+			 * Preallocate to ensure mas_store does not fail
+			 * If there is no memory for the tree update, bail out,
+			 * next execmem_free() might be more lucky
+			 */
+			if (mas_preallocate(&mas, NULL, GFP_KERNEL))
+				break;
+
+			mas_store_prealloc(&mas, NULL);
 			vfree(area);
 		}
 	}
@@ -219,30 +227,34 @@ static void *execmem_cache_alloc_locked(struct execmem_range *range, size_t size
 	addr = mas_free.index;
 	last = mas_free.last;
 
+	mas_set_range(&mas_free, addr, addr + size - 1);
+	if (mas_preallocate(&mas_free, NULL, GFP_KERNEL))
+		return NULL;
+
 	/* insert allocated size to busy_areas at range [addr, addr + size) */
 	mas_set_range(&mas_busy, addr, addr + size - 1);
 	err = mas_store_gfp(&mas_busy, (void *)addr, GFP_KERNEL);
 	if (err)
-		return NULL;
+		goto err_destroy_mas_free;
 
-	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);
+	mas_store_prealloc(&mas_free, NULL);
 	if (area_size > size) {
-		void *ptr = (void *)(addr + size);
-
 		/*
 		 * re-insert remaining free size to free_areas at range
 		 * [addr + size, last]
+		 * the range matches an existing entry, so this cannot allocate
 		 */
+		ptr = (void *)(addr + size);
 		mas_set_range(&mas_free, addr + size, last);
-		err = mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
-		if (err) {
-			mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
-			return NULL;
-		}
+		mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
 	}
 	ptr = (void *)addr;
 
 	return ptr;
+
+err_destroy_mas_free:
+	mas_destroy(&mas_free);
+	return NULL;
 }
 
 static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)

-- 
2.53.0

