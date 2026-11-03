Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674835;
	b=qvCVGqSSs/jTrsQcczUrn5u9dlfXQ2ftZ42xZu1O37Vl2f420IiyR+IszC9wFBXuBjDp
	 k6EFd1SBCFTFbeyqNohLuXecIExYven7jKcdabGlZXP2yYfmHA8Xhe7c9bp9inCJ5h9L0
	 h8E4JclcWw19DEmAZ5NiATjnvTJa49eCi2DbpU6BBxIG5HIpcecbkYW9b3unYX6xnew2H
	 Lk95BLp0qIeIdre+lVhfDJ4WEKE6TlFPV+3/kZnSkz7uz4fe5Eg47kURdZXsz7PEMI6eN
	 grQw7001TxRsoA06Ey0T5HA7T6FMQ7i79z+VK0WrPefBSLbR4sMLKrfTvP9sdiuAFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L/ha//ZrXLsBdkvFyJ+OTDpmXygYtESff7tpSNBQWjc=;
	b=w3rLvH7HE5jcEjaaOBFM4xQ6LqyZKfrDmYWEBT6Bj4uSUA/d9fIDgEwElY9lPNuMQR4s
	 hWKNOxbPDEMDZA/UhV3p52guMaZZgO7DFImZOIAGE5OQjrYpU+koi11vyqXp+qp6xKSW7
	 TFD7IYXy6H2CjEvssOhah+AVrQw1B1a5RGsvAutu3X0CNFIdhozZczjQlKk0+SGainTcj
	 1h7eklvSN6VBcryilkxBNWa0AUrmfxVFttO4uSlPIlNLxUxXJwIyrIrzIzRuF3qfeKKhk
	 D1VWg41Xhj09NSsxUIfvuJhwFiPA3Ydm5prtHCmQd7SDtTiXMK2UO44v9Z9BJjAdpbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6MK6DTU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F6606A324;
	Tue,  3 Nov 2026 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6MK6DTU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247691F000C1;
	Tue,  3 Nov 2026 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674834;
	bh=L/ha//ZrXLsBdkvFyJ+OTDpmXygYtESff7tpSNBQWjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6MK6DTUs0ZAuPg2FjmPTw9VywzJUpp3TLovJCBs3j0Q2qhFizRh5l2fr61pUuVxd
	 yTRbrW3+vENAUbhYrF7YWSrMd7v1aGpqeC2jHl2loId5RvFQOmdemLnNXEiznhYKyj
	 WlPIe4ticrpFs9BlmnydH/c4d5HdsMjJJwreCMWwK2eH0u9Mbh6QMjw6JCa5oERl9d
	 pHBl8Nk9tPLU/HaCKhFKpKg9ydLGy7FdA1niJgeTQP7nFpdqPTqlYx3orIsF0lAt+G
	 G6x38OwKbJunnYJFnaE6DrDOgC0aHZL8zOaE8klPHzkNflVP6+eIR2lavhz8TB+5W/
	 /vvDt5cT5qMjQ==
Message-ID: <sashiko-outbox-194481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: bpf: reject struct_ops registration during
 device destruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-input@vger.kernel.org
Cc: bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <179367391951.8187.16512492575149308999@stu.pku.edu.cn>
References: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
 <179367391951.8187.16512492575149308999@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:00:33 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] HID: bpf: premature ops->hdev assignment before lock in hid_bp=
f_reg()
--

commit 652bc4fabe060de525612119c444207ef100747a
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

HID: bpf: reject struct_ops registration during device destruction

This commit checks hdev->bpf.destroyed while holding prog_list_lock in
hid_bpf_reg() to avoid registering a struct_ops program and calling
synchronize_srcu() after HID-BPF device destruction has cleaned up the
device's SRCU state. It also clears ops->hdev under prog_list_lock on
registration failure before dropping the device reference.

> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index c90b68956cb3b..31e2cb146b92c 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -201,6 +201,11 @@ static int hid_bpf_reg(void *kdata, struct bpf_link =
*link)
> =20
>  	mutex_lock(&hdev->bpf.prog_list_lock);
> =20
> +	if (READ_ONCE(hdev->bpf.destroyed)) {
> +		err =3D -ENODEV;
> +		goto out_unlock;
> +	}
> +
>  	count =3D list_count_nodes(&hdev->bpf.prog_list);
>  	if (count >=3D HID_BPF_MAX_PROGS_PER_DEV) {
>  		err =3D -E2BIG;
> @@ -229,11 +234,14 @@ static int hid_bpf_reg(void *kdata, struct bpf_link=
 *link)
>  	synchronize_srcu(&hdev->bpf.srcu);
> =20
>  out_unlock:
> -	mutex_unlock(&hdev->bpf.prog_list_lock);
> -
>  	if (err) {
>  		if (hdev->bpf.rdesc_ops =3D=3D ops)
>  			hdev->bpf.rdesc_ops =3D NULL;
> +		ops->hdev =3D NULL;
> +	}
> +	mutex_unlock(&hdev->bpf.prog_list_lock);
> +
> +	if (err) {
>  		hid_put_device(hdev);

[Severity: Critical]
In drivers/hid/bpf/hid_bpf_struct_ops.c, hid_bpf_reg() still assigns
ops->hdev =3D hdev before acquiring hdev->bpf.prog_list_lock:

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_reg() {
	...
	hdev =3D hid_get_device(ops->hid_id);
	if (IS_ERR(hdev))
		return PTR_ERR(hdev);

	ops->hdev =3D hdev;

	mutex_lock(&hdev->bpf.prog_list_lock);
}

When a HID device with an attached struct_ops link is destroyed in
hid_destroy_device() -> hid_bpf_destroy_device(),
__hid_bpf_ops_destroy_device() clears ops->hdev =3D NULL under prog_list_lo=
ck
and drops the link's device reference while leaving the existing bpf_link
alive, and hid_bpf_destroy_device() then calls
cleanup_srcu_struct(&hdev->bpf.srcu). Because hid_remove_device() has not
called device_del(&hdev->dev) yet, hid_get_device() can still find hdev on
hid_bus_type.

If a concurrent bpf_struct_ops_link_create() on the same struct_ops map cal=
ls
hid_bpf_reg(), it sees ops->hdev =3D=3D NULL and writes ops->hdev =3D hdev =
before
taking prog_list_lock. If the original struct_ops link is closed at the same
time, bpf_struct_ops_map_link_dealloc() -> hid_bpf_unreg() runs without
holding the map's update_mutex:

drivers/hid/bpf/hid_bpf_struct_ops.c:hid_bpf_unreg() {
	...
	hdev =3D ops->hdev;

	/* check if __hid_bpf_ops_destroy_device() has been called */
	if (!hdev)
		return;

	mutex_lock(&hdev->bpf.prog_list_lock);

	if (!ops->hdev) {
		mutex_unlock(&hdev->bpf.prog_list_lock);
		return;
	}

	list_del_rcu(&ops->list);
	synchronize_srcu(&hdev->bpf.srcu);
	ops->hdev =3D NULL;
	...
	hid_put_device(hdev);
}

Can hid_bpf_unreg() observe the newly written ops->hdev, acquire
prog_list_lock before hid_bpf_reg(), bypass the !ops->hdev check, and call
synchronize_srcu(&hdev->bpf.srcu) on the cleaned-up srcu_struct followed by=
 a
duplicate hid_put_device(hdev) when hid_bpf_reg() also drops its reference =
in
the error path?

Should ops->hdev only be checked and assigned after acquiring
hdev->bpf.prog_list_lock and verifying that hdev->bpf.destroyed is false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179367391951.8187.1=
4164894863012056170@stu.pku.edu.cn?part=3D2
