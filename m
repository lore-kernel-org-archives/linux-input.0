Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E953D7D7B
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296551; cv=none; b=EbFapAdWkyqrrSdQRDIssWN6HH730S+rwEAfauM/H9K3mMJmREp3F0m99CYeFceYgkky3quUlZz0BDYFkwUk85P2DEumgPZazDeJrMl4r6L3mMQAPcCMOLQEXKMvmPkmnvQMk7NOwLOtnNwjBIY1qpOtmzNBl49LU9mJrrlOtT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296551; c=relaxed/simple;
	bh=0gcEwcN8ex6JAThDnE/2c4Sb4M/0YQ9ne1aROdgdxXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aXaLS4cNTr/pR2Hi8/WiIjz/yBb3QZSPaWXdcwD2SvJyGP3Gg11xanQQjcbT5Lb9PrqVjMRDcmBhlrEzKtlUskqgFo+2x+UAPPWgxiS7+dttiS5zCus6K8BoOmkuEAonu984ye/gi3SvX6ZD9+jGEdrwXPcjeyu/z88aWk19Iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oERDlHV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oERDlHV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA31F000E9;
	Wed, 20 May 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296550;
	bh=N5icSH5U8yvD2aKe8six4aux0yaQwf+Ff/9bZgxYslg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oERDlHV21KVGITeadV7rcRzLhGUKz08uYEiWjKivCJS/eSU5efPoY0dCpeHkw9A33
	 Hd7cfXyhkg5T/eyjXRDy4Dyw+IcPckd3KxyKXL/ALepckW7SbWXwPXecU1Iom4JG/F
	 ED5WpU2iNSTFzBcWfJLxzHx/ppq6KU4EEoYBExOfp6ybdmWvNiKC5NTIafTFAEGwaP
	 2XnXbJmlxfdY1gNeZK4VHhFJY8SG8VrE+rk/G1twqw5ihc1JxPh40cMavQwY1upoZ3
	 ukL3dya0QmCC5/qNtirZBNYJdHdeyCKmpPFbhCp52ehdxSex+1/+Wwg+znwJSkR8ha
	 JofhZPUDgYx8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Kaehn" <danny.kaehn@plexus.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
References: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 17:02:29 +0000
Message-Id: <20260520170229.CEFA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature release of firmware node references results in use-after=
-free vulnerabilities when assigning the I2C adapter and GPIO chip firmware=
 nodes.
--

commit 3dfaf368e855835bf23009205c4b93a2a070aae1
Author: Danny Kaehn <danny.kaehn@plexus.com>

HID: cp2112: Add fwnode support

This commit adds firmware node support to describe the CP2112's I2C and
GPIO interfaces. It differentiates between ACPI and DeviceTree bindings,
mapping the child nodes to the respective adapter and gpio_chip devices.

> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 803b883ae8750..e960fc988058f 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
[ ... ]
> @@ -1226,6 +1241,28 @@ static int cp2112_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  		return ret;
>  	}
> =20
> +	cp2112_fwnode =3D dev_fwnode(&hdev->dev);
> +	if (is_acpi_device_node(cp2112_fwnode)) {
> +		fwnode_for_each_child_node(cp2112_fwnode, child) {
> +			ret =3D acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> +			if (ret)
> +				continue;
> +
> +			switch (addr) {
> +			case CP2112_I2C_ADR:
> +				device_set_node(&dev->adap.dev, child);
> +				break;
> +			case CP2112_GPIO_ADR:
> +				dev->gc.fwnode =3D child;
> +				break;
> +			}

[Severity: High]
Does this code leave dangling pointers in the device structures?

The fwnode_for_each_child_node() macro automatically drops the reference to
the child node when advancing to the next node or exiting the loop.

Because device_set_node() and direct pointer assignments do not increment
the reference count, the nodes assigned here could be prematurely freed
resulting in a use-after-free.

> +		}
> +	} else if (is_of_node(cp2112_fwnode)) {
> +		child =3D fwnode_get_named_child_node(cp2112_fwnode, "i2c");
> +		device_set_node(&dev->adap.dev, child);
> +		fwnode_handle_put(child);

[Severity: High]
Are we releasing the firmware node prematurely here?

fwnode_get_named_child_node() returns a node with an incremented reference
count. However, since device_set_node() does not take its own reference on
the child node, dropping the reference immediately after could leave
dev->adap.dev with a dangling pointer if the node is later removed.

> +	}
> +
>  	ret =3D hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "parse failed\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-cp2112-dt-=
v14-0-b1b4b6734b6f@plexus.com?part=3D1
