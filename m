Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5B309EFA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768602; cv=none; b=Bd7StVYj+Ri2CjOdUI+Qt/HgPWPBTO55BVvE7//DEF5UiOVsvYG7zmiOCniff0iJRFaDZqFyoZAO9sIcDyOfLMOijIyr/cKrFna82dGVOjoATzfbDPHw0QSwL2ubNdv6qjYlopLwgRxSudQNSwyInO8jMXv2SqDNzfmoz97pFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768602; c=relaxed/simple;
	bh=EiFintgcr42au6B1FGImFMrbhzyzuzIesynF6bSBtrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOoeW7HcBMfWLrXiNoxgbLvYQmORVeMc0qpfuKy7IoN0Hr+swMKsyU2N0+xHQCAVO84bPAZvnI36tkBU4YebQlmzIhqmSfArtj8ZObZpuRmaTviLzEH04P16AtTGI+buQjDy1znAu2ULjhj65hiIhXxQke0oj9uGTn6iZB06ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ZoPYgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ZoPYgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44E91F000E9;
	Mon,  3 Aug 2026 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768601;
	bh=WWsg9AX6APPpYDDJWpy+Qlc7Ik4AfVfSyMrg5Tvpnj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4ZoPYgCQd6pmSwgW1Y0rc1iamWSiyZYoYbb+4gOF5HdDMcAxUz0oDJ2Ojv0cjRa3
	 OBKuvIeYj/RzsIoPJj9vOeE9y1A7iIze4e8dzcWffyuWeGKoFdk4JZ6Lp2IjMnCK/k
	 TvcznP3meAx3vbcYDfK4WpUE1tRDSojcSnuuhXHGKQ0GIMPl1X5ORhpXIoYR92FGhe
	 EzCjxtr9EWQps/QTqjqQdY5uBbC7HNaQxH0lDsmsb8G1q/ZTyls7qoGRz7IgztVKV6
	 735Y/EEi77iDsPe7qeGw1sTp0sioXsZ+c5tXM4iSrwuv1WjcU5ImxoWe7KBzkG1spF
	 DBk6o5q+hxSRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: bpf: serialize device reference release in
 struct_ops destroy path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
References: <tencent_6C4272FCE4F12C891C300445A9D8E6C68C0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:49:58 +0000
Message-Id: <20260803145000.E44E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race leading to a Use-After-=
Free of `hdev` during lock acquisition.
- [High] Early return bypasses `list_del_rcu()` and `synchronize_srcu()`, l=
eaving a freed BPF ops object in the device's active program list.
--

--- Patch [1]: [PATCH] HID: bpf: serialize device reference release in stru=
ct_ops destroy path ---
commit cfdd4ce27d8a975674b1f3418e6b5078b5d94946
Author: Shen Yongchao <grayhat@foxmail.com>
Subject: HID: bpf: serialize device reference release in struct_ops destroy=
 path

This patch aims to fix a double-put race condition in the HID BPF struct_ops
destroy and unreg paths. It serializes the remove/NULL decision under
hdev->bpf.prog_list_lock to ensure exactly one path releases the device
reference.

> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index 702c22fae136a..049df06477610 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -250,6 +250,11 @@ static void hid_bpf_unreg(void *kdata, struct bpf_li=
nk *link)
> =20
>  	mutex_lock(&hdev->bpf.prog_list_lock);

[Severity: High]
This is a pre-existing issue, but is it possible for hdev to be completely
freed between being read from ops->hdev and used here in mutex_lock()?

If hid_bpf_unreg() reads hdev =3D ops->hdev and is then preempted, could
__hid_bpf_ops_destroy_device() execute concurrently, clear ops->hdev, and
drop the registration's device reference via hid_put_device(hdev)?

If that was the final reference, the device could be freed, leading to a
use-after-free when the unreg thread resumes and attempts to lock
&hdev->bpf.prog_list_lock.

> +	if (!ops->hdev) {
> +		mutex_unlock(&hdev->bpf.prog_list_lock);
> +		return;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this early return safely handle list
cleanup?

In __hid_bpf_ops_destroy_device(), e->hdev =3D NULL is set, but the node is
intentionally left linked in hdev->bpf.prog_list.

If hid_bpf_unreg() runs, sees !ops->hdev under the lock, and returns early
here, it entirely bypasses list_del_rcu(&ops->list) and
synchronize_srcu(&hdev->bpf.srcu).

Since the BPF framework will subsequently free the ops map memory, wouldn't
this leave a freed object in hdev->bpf.prog_list?

If a driver .remove callback then triggers hid_bpf_hw_request() (for exampl=
e,
to turn off LEDs), it would traverse the list under SRCU and access the fre=
ed
ops object.

>  	list_del_rcu(&ops->list);

[ ... ]

> @@ -310,13 +315,17 @@ static struct bpf_struct_ops bpf_hid_bpf_ops =3D {
>  void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
>  {
>  	struct hid_bpf_ops *e;
> +	int count =3D 0;
> =20
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> -		hid_put_device(hdev);
> +	mutex_lock(&hdev->bpf.prog_list_lock);
> +	list_for_each_entry(e, &hdev->bpf.prog_list, list) {
>  		e->hdev =3D NULL;
> +		count++;
>  	}
> -	rcu_read_unlock();
> +	mutex_unlock(&hdev->bpf.prog_list_lock);
> +
> +	while (count--)
> +		hid_put_device(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_6C4272FCE4F=
12C891C300445A9D8E6C68C0A@qq.com?part=3D1
