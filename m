Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8677431A5C;
	Tue,  1 Sep 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281864; cv=none; b=s2VLh+Mnvy3guE6SnJ2Z0y85y9zT561Xb6zQRa3gWBVYGMeDIgGw0TFIXEgi3GbqkytxLMv14nveE3QjR7assFuMNM3QPQlTtF+EQMza199/s45jj9CCe7eE6EXKkAc1TCJgTsq/tmyiNn+mbIBbvGkvPgwgG7xhCdrKMbTdEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281864; c=relaxed/simple;
	bh=8y/ZGX5qliXeV7zOiReFbIWuQE0twdWnLhic6h0ssQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHn+RqGk1T67xmk0qFxnZx+AlZU7XsTRbE2qO6fcxM7SGj7VOFkJxTnpNun26aFdm78YGQIaGSiyahU5TGYScv83Css/Ah9yblXbdP0HtGo9vwH81NQYgo6PL4f3vKtZiVcuLdVjfi80lpQp+dzZ1YwHmelkgTcQH8Me+jidZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtgwO02D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtgwO02D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B181F00A3A;
	Tue,  1 Sep 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281862;
	bh=OhvZtQ0eU3bcnUaAynNGwXmOtzlnlhGl4PsopzQ50LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtgwO02DSb8NjYFrfujZWaYC/msXiWExIkXQfzDGRj6dBF3MkBqK9cNBxD25xK5kl
	 v49yYSos4FTtRTE/Xo7YxmUevfEhhqyPKoeT1w3aWQFv0fLAKCmXVTJ8VhXcwgk/wh
	 EVoDUOQqGk05t74HEYGfDgxsj4hCpKkO0tHLfrZtN7uB1cJTELRNKI75dy3FomiJaV
	 g7nnmFmeqfDCho9One6Q5pZa1NrIaf6ZRP902fHkhhLg8zehBnwSDlRx7A54hXtk60
	 Eap/MBs8gpELCNf6qwKHt6YF1/mNjbOeOFffnRtstBOEZQ2rI7uoMVpzqWAqojX6c7
	 n6YCr1JTLx0gQ==
Date: Tue, 1 Sep 2026 18:57:38 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Shen Yongchao <grayhat@foxmail.com>, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: serialize device reference release in
 struct_ops destroy path
Message-ID: <apcDYuGfT6Q1B10p@beelink>
References: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
 <20260803145000.E44E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803145000.E44E91F000E9@smtp.kernel.org>

Just for the record, because this broke both our brains for long enough
(Jiri and I)

On Aug 03 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Time-of-check to time-of-use (TOCTOU) race leading to a Use-After-Free of `hdev` during lock acquisition.
> - [High] Early return bypasses `list_del_rcu()` and `synchronize_srcu()`, leaving a freed BPF ops object in the device's active program list.
> --
> 
> --- Patch [1]: [PATCH] HID: bpf: serialize device reference release in struct_ops destroy path ---
> commit cfdd4ce27d8a975674b1f3418e6b5078b5d94946
> Author: Shen Yongchao <grayhat@foxmail.com>
> Subject: HID: bpf: serialize device reference release in struct_ops destroy path
> 
> This patch aims to fix a double-put race condition in the HID BPF struct_ops
> destroy and unreg paths. It serializes the remove/NULL decision under
> hdev->bpf.prog_list_lock to ensure exactly one path releases the device
> reference.
> 
> > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > index 702c22fae136a..049df06477610 100644
> > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > @@ -250,6 +250,11 @@ static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
> >  
> >  	mutex_lock(&hdev->bpf.prog_list_lock);
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for hdev to be completely
> freed between being read from ops->hdev and used here in mutex_lock()?
> 
> If hid_bpf_unreg() reads hdev = ops->hdev and is then preempted, could
> __hid_bpf_ops_destroy_device() execute concurrently, clear ops->hdev, and
> drop the registration's device reference via hid_put_device(hdev)?
> 
> If that was the final reference, the device could be freed, leading to a
> use-after-free when the unreg thread resumes and attempts to lock
> &hdev->bpf.prog_list_lock.

This is actually tackled by the commit description.

> 
> > +	if (!ops->hdev) {
> > +		mutex_unlock(&hdev->bpf.prog_list_lock);
> > +		return;
> > +	}
> > +
> 
> [Severity: High]
> This is a pre-existing issue, but does this early return safely handle list
> cleanup?
> 
> In __hid_bpf_ops_destroy_device(), e->hdev = NULL is set, but the node is
> intentionally left linked in hdev->bpf.prog_list.
> 
> If hid_bpf_unreg() runs, sees !ops->hdev under the lock, and returns early
> here, it entirely bypasses list_del_rcu(&ops->list) and
> synchronize_srcu(&hdev->bpf.srcu).
> 
> Since the BPF framework will subsequently free the ops map memory, wouldn't
> this leave a freed object in hdev->bpf.prog_list?
> 
> If a driver .remove callback then triggers hid_bpf_hw_request() (for example,
> to turn off LEDs), it would traverse the list under SRCU and access the freed
> ops object.

Sashiko is wrong here: when we call hid_bpf_destroy(), there is a guard
that is set (.destroyed) which prevents further iterations over the RCU
lists. So the next .remove() call triggered from the device_del() will
not iterate over the freed data.

Cheers,
Benjamin

