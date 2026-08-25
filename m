Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB13F9F56
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654713; cv=none; b=CY3GJlFtU5wW7cZzFSAnzeJuc9756yMOJjpbaMBB4ZoOk1BJ+3qDDzeji9QBLdFt4W7dtYURj4KyfdQORMA/armL0f8zikD3ol2Sd+gVyDqyH2R1SFOh04M4S6uDIo0HK0/mBJpWU2S53Kp7ORbg9UwHiYrm3vxcItVjpA/9BjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654713; c=relaxed/simple;
	bh=wP/xCBMlXVwQ7PnjqISGsrzWUMCCtMCeM/AhYnOK2B0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z40810RlkIOD+jd+8anWqA5wXPc2WpF8uWqUyaKneDCVYwyrgmSCjIkfNmV4Ip2jXXHwA4q3GVeu13jU7fRPYL7gekGB6UcbH8rwJjMN3HI9aP+EDBKKOtrYylWCc75Iiojt/BybU3GGQyfF+uyl/ydCuqk+Ts5puOb+4HhP3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjL8KC6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjL8KC6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A7D1F00A3D;
	Tue, 25 Aug 2026 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654711;
	bh=gZ1nfjRVE0wp2VQzL4KHYB4S8S2LpL04bEc9nVHNYL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjL8KC6g1Izxevb0scQ+yb/jnzSHTAqFmjG0qwdC60TDoqniBrQ3wc4MJleHSF8Cp
	 oGQlsXAS8eIrx4JKDPZZ0ovOq6+3GLeq2grgDQxyoY6euqryVT8JUV7YnCN0AGxx5Q
	 XciUNW3OFX4MICUuhj1QrMoE19m/NCYbRekFssMRx1DfHWhCYB1PNakLTrGNYC+50L
	 Ds6952OZOKIwTBBRsogra6iWl9sD1VlanVlZ3JYiywLkiWIIh3VB5kwHFIIuZRMs+3
	 sA0KnkPaXpojEQyrmpRrxrPXoZk3Mw+ksivvi3MARVHPMCrd0JCQGknlpo7zs1FltA
	 gsqqFgKlPMkPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: synaptics-rmi4 - remove the F34 sysfs group
 when probe fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825103134.12278-1-98lawweijie@gmail.com>
References: <20260825103134.12278-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:45:11 +0000
Message-Id: <20260825104511.B9A7D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The irq_domain allocated via irq_domain_create_linear() in rmi_pro=
be_interrupts() is never freed on the error paths of rmi_driver_probe(), le=
ading to a memory leak and a dangling pointer (Use-After-Free).
--

--- Patch [1]: [PATCH v2] Input: synaptics-rmi4 - remove the F34 sysfs grou=
p when probe fails ---
commit cb8b140f174750e7270da9a3b63cf033d6bd04f6
Author: Wei Jie Law <98lawweijie@gmail.com>

    Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails

This commit addresses a NULL pointer dereference in the sysfs show handlers
by ensuring the F34 firmware attribute group is removed if rmi_driver_probe=
()
fails. It adds an err_remove_sysfs label to route failures correctly and
repairs a secondary leak of function devices.

Link: https://lore.kernel.org/linux-input/20260824122751.76415-1-98lawweiji=
e@gmail.com/

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..144b203e636a0 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c

[ ... ]

> @@ -1284,6 +1284,8 @@ static int rmi_driver_probe(struct device *dev)
> =20
>  err_disable_irq:
>  	rmi_disable_irq(rmi_dev, false);
> +err_remove_sysfs:
> +	rmi_f34_remove_sysfs(rmi_dev);
>  err_destroy_functions:
>  	rmi_free_function_list(rmi_dev);
>  err:

[Severity: High]
This is a pre-existing issue, but does this error path also need to clean up
the irq domain?

Earlier in rmi_driver_probe(), rmi_probe_interrupts() allocates the domain:

    data->irqdomain =3D irq_domain_create_linear(fwnode, irq_count,
                                               &irq_domain_simple_ops,
                                               data);

This adds the newly allocated irq domain to the global irq_domain_list. If
rmi_driver_probe() fails after this point, the error paths (including those
now routed to err_remove_sysfs) return without calling irq_domain_remove().

Because the data pointer used as host_data is devm-managed, it will be freed
automatically on probe failure. Would this leave a dangling pointer in the
global domain list, potentially leading to a use-after-free if that list is
traversed later?

Since unprivileged users can intentionally trigger probe failures via
/dev/uhid (as noted in the commit message), could this leak be repeatedly
triggered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103134.1227=
8-1-98lawweijie@gmail.com?part=3D1
