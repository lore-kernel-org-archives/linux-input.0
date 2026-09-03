Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A854EBAC4;
	Thu,  3 Sep 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450623; cv=none; b=nmfPeaSukkvnGFVAcDdbKqr3k/3xLhxnNuqSbfMN4CZHM1F3i7WIoFGhjDn/C9wBhQn8EeTURG/k1cUNtsxA90hwGbaksSr2TOGDH3qHmjfXfnTroSKKDbiIOcqFUpvU8v3OsOq1opbsAAwgiYrsarMBkdmxibc1bZa11bAmIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450623; c=relaxed/simple;
	bh=FtoH+kwk2wKBBnqh3eHduPPmGppQi2AbEvfg6AlBsj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tj41QMwr52dxJwYuto7fKlsPMlSKgGm+WckfcgDy8Lf6E7GZEojCQW/nIwIT0PXsClzH4FL6UntdlDIxnHR5UYoVn4sjEBEEeiURysTdaPSsvmGO5wmb7uoC/BNA1Gk1d1JR1KgyjRfm+Qb8+PJH7QsVnyZKG7SfW63SH5L0Ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq53Txo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq53Txo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA251F000E9;
	Thu,  3 Sep 2026 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450622;
	bh=c57DBNEt0+woR56ZuvNbkfIrlDXYh8oKXIQm/KMduWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Rq53Txo23LaqkMe5fufGOjTXt1HCpC3UBmUOtCC7iNt9tPfm6kTXXnPSDCAk9nxFE
	 lwemGFrATyN+XAg13ALbLeKBqqCnEFjZCIw3m+OgJcoF6R2o55nl9zlR2nD0eTX5GV
	 5WP02yiztn4pzZBwyYJctDQamuvIJP/ix0ISO8UHAZl1Jm02IkgCxK2aY27CDvv6Hc
	 7QDyJftBmqBtwrh6mtysocnwg4FnJVx3Sfz+AXJds6nDGeBfsYx3+pfkjMCTK3jRpK
	 /JYp0S0gnBA1SSNnCmI0CtvQhXnnUR5Tw1Fd/hwLuWwcoJS3sNrNTSUndJiU/wpXbY
	 mJG5w/QHSQw6w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 18:50:02 +0300
Subject: [PATCH 5/5] mm/execmem: use cleanup infrastructure in ROX cache
 functions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-rox-cache-pmd-v1-v1-5-11beb2a3d249@kernel.org>
References: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
In-Reply-To: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.17-dev

After splitting out execmem_alloc_rox() from
execmem_cache_populate_alloc(), the error paths of both functions became
less complex and can be easily switched to use the cleanup infrastructure.

Use __free(vfree) to free allocated memory on the error paths and
guard(mutex) for synchronization in ROX cache functions.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 77653b7f163dc..349cadd874863 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -138,11 +138,10 @@ int execmem_restore_rox(void *ptr, size_t size)
 static void execmem_cache_clean(struct work_struct *work)
 {
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
-	struct mutex *mutex = &execmem_cache.mutex;
 	MA_STATE(mas, free_areas, 0, ULONG_MAX);
 	void *area;
 
-	mutex_lock(mutex);
+	guard(mutex)(&execmem_cache.mutex);
 	mas_for_each(&mas, area, ULONG_MAX) {
 		struct vm_struct *vm = find_vm_area(area);
 		size_t size = mas_range_len(&mas);
@@ -163,7 +162,6 @@ static void execmem_cache_clean(struct work_struct *work)
 			vfree(area);
 		}
 	}
-	mutex_unlock(mutex);
 }
 
 static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
@@ -269,7 +267,7 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 static void *execmem_vmalloc_rox(struct execmem_range *range, size_t size,
 				 unsigned long vm_flags)
 {
-	void *p = execmem_vmalloc(range, size, PAGE_KERNEL, vm_flags);
+	void *p __free(vfree) = execmem_vmalloc(range, size, PAGE_KERNEL, vm_flags);
 	int err;
 
 	if (!p)
@@ -280,22 +278,17 @@ static void *execmem_vmalloc_rox(struct execmem_range *range, size_t size,
 	set_vm_flush_reset_perms(p);
 	err = set_memory_rox((unsigned long)p, size >> PAGE_SHIFT);
 	if (err)
-		goto err_free_mem;
-
-	return p;
+		return NULL;
 
-err_free_mem:
-	vfree(p);
-	return NULL;
+	return no_free_ptr(p);
 }
 
 static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_REQUIRE_HUGE_VMAP;
 	size_t alloc_size = round_up(size, PMD_SIZE);
-	struct mutex *mutex = &execmem_cache.mutex;
+	void *p __free(vfree) = NULL;
 	int err;
-	void *p;
 
 	p = execmem_vmalloc_rox(range, alloc_size, vm_flags);
 	if (!p)
@@ -306,20 +299,15 @@ static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t si
 	 * as an atomic operation, otherwise they may be consumed
 	 * by a parallel call to the execmem_cache_alloc function.
 	 */
-	mutex_lock(mutex);
+	guard(mutex)(&execmem_cache.mutex);
 	err = execmem_cache_add_locked(p, alloc_size, GFP_KERNEL);
-	if (!err)
-		p = execmem_cache_alloc_locked(range, size);
-	mutex_unlock(mutex);
-
 	if (err)
-		goto err_free_mem;
+		return NULL;
 
-	return p;
+	/* the chunk belongs to the cache now */
+	retain_and_null_ptr(p);
 
-err_free_mem:
-	vfree(p);
-	return NULL;
+	return execmem_cache_alloc_locked(range, size);
 }
 
 static void *execmem_alloc_rox(struct execmem_range *range, size_t size)

-- 
2.53.0

