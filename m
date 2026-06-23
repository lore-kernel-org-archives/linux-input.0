Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938F3FBA7
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182200; cv=none; b=l1OPBBjpe9vgsJc63FUe1TAPWmJd7SXtR3G5tP7o0XAgZpSzpdKB3kzsMojuUsUrfm/SSjFogb10B6Up6BIjOjdK3pBctkDyuUob09X96YQL6/ZrdrCWRE99en82bNiOl6gjxBpAB5hMSL6bUo4mtVK5hzxGkocZm0zqQ53gC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182200; c=relaxed/simple;
	bh=OlsBc+Sj+IORtSnWEstt9vRg+/M8/xWDTp9+LLJ0zEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMrJY09qa0RRlOcAdGL1U6iUGeZtvQk6+MXPkNDlihUJJHBk6rqAN4UNGGpU9vxPzeZPUAp8ytvtZCZEb5CoAL9KGBpMjCmPkt/F25YS58CsPEUTMiFFGeo7MiZu4loj+OAl/aAUq4lfs4KsAGrb1HJj4e0LhALvAZ3B9RQdd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLR3lkI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLR3lkI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9061F000E9;
	Tue, 23 Jun 2026 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782182199;
	bh=XfV3odLZvoTb3OgjZFTN6QTo1t9RnxUWBglQ5OywRFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLR3lkI5KWxAXESBiXcMd06tK5iz9ZSPV3KgfZUHHh5dBb0VEnCtRAipy6akLOU3X
	 oJ7n3dWKnSpD5wk7TKnNryFgnZV3w/IViCLxDwIkuxTpOGhdErXGwdTRw3VyD+XjLS
	 WVzhtDXp3ekja6XrMvpMtgoXb/hgh4ek15eggn8rrm5UGidNDtDpwobC2p8HB+oXKw
	 VkoqW0w3q0wE4QvmzqWl2ujn7bA/1mDW4X+oqLmd9sv7+N8tRqCRU0NEE/oNlfFIPv
	 F4SuKJxWTIFUN4Z4AYD3+LdHK01Oe2APIMX9oNWjMPs1NDQXkAgtlDzmAjtlrp+pbP
	 T4eTZ2nmMucKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: Fix sysfs group leak on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260623021950.1736413-1-haoxiang_li2024@163.com>
References: <20260623021950.1736413-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 02:36:38 +0000
Message-Id: <20260623023638.DD9061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Freeing `sensor_inst->fields` on `sysfs_create_group()` failure cr=
eates a Use-After-Free window because the `enable_sensor` sysfs attribute i=
s already active and its store method uses pointers into the `fields` array.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver teard=
own path frees `sensor_inst->fields` before removing the `enable_sensor` sy=
sfs attribute, allowing a concurrent Use-After-Free.
--

commit 0c3a9f337fe5155646ac08e2a7d6eae0a3e612f0
Author: Haoxiang Li <haoxiang_li2024@163.com>

HID: hid-sensor-custom: Fix sysfs group leak on failure

hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function currently breaks out of the
loop and returns the error directly.

Fix this by adding a local unwind path when sysfs_create_group() fails.
The unwind path removes all sysfs groups that were successfully created
before the failure and frees sensor_inst->fields.

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index afffea8940214..cd676516e6b04 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
[ ... ]
> @@ -621,6 +621,13 @@ static int hid_sensor_custom_add_attributes(struct h=
id_sensor_custom
>  	}
> =20
>  	return ret;
> +
> +err_remove_groups:
> +	while (--i >=3D 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				   &sensor_inst->fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);

[Severity: High]
Does freeing sensor_inst->fields here introduce a use-after-free window?

Because hid_sensor_custom_probe() registers the enable_sensor sysfs group
before this function is called, the sysfs file is accessible during this
failure unwind window.

If a concurrent write to enable_sensor triggers enable_sensor_store(), it
will dereference sensor_inst->power_state and sensor_inst->report_state in
set_power_report_state(). Since those pointers point into the freed
sensor_inst->fields array and are not cleared here, this might cause memory
corruption.

> +	return ret;
>  }
> =20
>  static void hid_sensor_custom_remove_attributes(struct hid_sensor_custom=
 *

[Severity: High]
This isn't a bug introduced by this patch, but the driver teardown path has=
 a
similar issue.

In hid_sensor_custom_remove(), the code calls
hid_sensor_custom_remove_attributes() which unconditionally frees
sensor_inst->fields. Only after this does it call sysfs_remove_group() to
remove the enable_sensor_attr_group.

Could a concurrent sysfs write during this window trigger
enable_sensor_store(), causing it to dereference the dangling
sensor_inst->power_state pointer in set_power_report_state()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623021950.1736=
413-1-haoxiang_li2024@163.com?part=3D1
