Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6812931F0
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767974; cv=none; b=tsFwOJEEzN2E3wIr+pXmrV7zG5/RmO6xirOLgitA+erojMI4KAFzUF/k4+G9XVCfmnO8oJYMld8fHnViITWHeQmTb8JYtRJ480m6iWhxjYvOpJN24Wd0Of/H82OlbtV9LBFZjcdzPWEpKTQQtgiRB5CNZSbeABskn4jyQZZxgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767974; c=relaxed/simple;
	bh=bDDVpICMqlkNzNjqrPx5yTXY+l0/mG71ZKn5CbNtRlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyaaK9QSeJYAxIgQGwJza2q1Cni2R53PZMhWQ9oQTkGQRDvDd8HuY3eEEeOxrIWj22YYFZ7s4nk/mTz+Zmi6Csz9nnEchM8Hnjsr/5hpt8/3F0m3LrMt2n8llQlORtA+mOgLmsQ4D+XGMwoQRSebz/h1bhEZxM3KeGl4kh5jIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wuYE3UV0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wuYE3UV0"
Message-ID: <51467e81-3919-4192-9a3f-d2bce744f12a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784767970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnyAA6FllzAzAKXvhBp6nEofnu4s0MdDRKBx0a5heF0=;
	b=wuYE3UV0QrB5USHchVWfSpocKiNsbIUtzpPN/tWNhvVf9T01OLzUyNerkQVtw0kLT2xhff
	xg+ZasyXNlnUpGgOHkhx0jnwod6sj3OSRuzhr9U8ocW28VEgubKRbGtHfqqxdnXGDCkWHL
	J0W74+iwNt/wZUN9N9aI1vi71CDjIIw=
Date: Wed, 22 Jul 2026 17:52:46 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags match
 the struct_ops set
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-7-ihor.solodrai@linux.dev>
 <20260722234938.DF9D41F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260722234938.DF9D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/26 4:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] TOCTOU NULL pointer dereference in `dispatch_hid_bpf_device_event` during dynamic HID-BPF attachment.
> --
> 
> --- Patch [6]: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags match the struct_ops set ---
> Note: The format of this review is altered to provide a free-form summary
> due to text recitation restrictions. No direct patch diff quoting is used.
> 
> commit 460380780bad5817b193c7927dc05e04ce9f5480
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> Subject: HID: bpf: Make syscall kfunc flags match the struct_ops set
> 
> This commit updates the kfunc flags for hid_bpf_syscall_kfunc_ids to match
> the hid_bpf_kfunc_ids set by adding the KF_SLEEPABLE flag. This ensures
> per-kfunc flag consistency across BTF ID sets at build time.
> 
> [Severity: High]
> This isn't a regression introduced by this patch, but while reviewing the

Not relevant to the change.

However HID maintainers may be interested, adding them to cc.


> HID-BPF event dispatching code, a potential time-of-check to time-of-use
> issue was noticed in drivers/hid/bpf/hid_bpf_dispatch.c.
> 
> Could this sequence lead to a null pointer dereference when a HID-BPF
> program is concurrently attached while a device is flooded with input
> reports?
> 
> In dispatch_hid_bpf_device_event(), the first lockless read of the device
> data happens during context initialization:
> 
>     .data = hdev->bpf.device_data,
> 
> Shortly after, a second lockless read is used as a guard:
> 
>     if (!hdev->bpf.device_data)
>         return data;
> 
> If __hid_bpf_allocate_data() is concurrently executed during a program
> attachment, it updates these pointers without memory barriers or taking the
> driver_input_lock:
> 
>     *data = alloc_data;
>     *size = alloc_size;
> 
> If the allocation completes exactly between the two reads in
> dispatch_hid_bpf_device_event(), the first read could evaluate to null
> while the second read sees the newly allocated pointer and evaluates to
> true. This would allow the code to bypass the guard and execute
> memset(ctx_kern.data, 0, hdev->bpf.allocated_data) with a null pointer.
> 
> Would it be beneficial to use READ_ONCE() or proper synchronization here to
> ensure consistent evaluation of the device data pointer?
> 

