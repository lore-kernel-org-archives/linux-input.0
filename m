Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752F38E8A2
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236216; cv=none; b=tB4hczJ/am8pK90gO8oK9gXuJqpWrA1pC8tS2UGLE0sZ48/loa6Yc5KPoBmt2d1jLY4B5Ew+dNecya/bTvfOwVVO8VMI2O2m+ja6UyuE3YboDIJ3SlOXyAN+gF/xHcOh7X7kqpZ0Z7coXhMoIERFho0+5BjNhXREZ0llspxtwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236216; c=relaxed/simple;
	bh=auS2+NN7GFCGqmZLNhDh1h+BOzw3Z1GMNuT9UdGiCE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1/ravbE4BQVaTCRyFaWSGQxE8zeypSjvidTncEMOmi8BuOhyZ8B2ZTDVcgOU6wW9EVvkAZRRSryuhLC3tKoJf4ZenpcRZXsELAXqHVJLJ87RngUHWbSxoyahvyiavs7HrG/NNOjOf7w1zBXPOsK1CIoc+eVajN9E6tm5I8oqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onho1EHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onho1EHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57111F000E9;
	Tue, 23 Jun 2026 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236214;
	bh=VUoFXnAxvV3ou+TxHTTqj/K/DR8a4Y5SPvwV5d2uqxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Onho1EHhD1P+QN1doC6F7Heme94l86AApYXhQyb4DkB5LvyIEKo2+W2gLF1nh8kyX
	 FTAC5AwmiRw4/v21HGsU2RSwzuZiVODTbWZdW4DqI6BbGgVVVAGWdK9BlIRg7ACzaN
	 FBjCfU3KSw9RWGtYKw4JdYXFclCJgbO2+ek3RFSlOM7Zp7AeWxJPoSeX7Uvxz6R6nx
	 cxlwlbIoD3yVIxbYEjzSmhYSHG6L34rUXdlIhPTD0kHX8LadBlFIAhaIuXI1uiVNJW
	 OlhQFLsNuPw4laJXHEEL/VzAdNd7lEzxGWJnleXfwLlrIk3OxGueU0qck+j4Y9wEhh
	 kV6QfpyT2641g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] HID: steelseries: Manage battery lifetime with
 refcounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260623172310.272708-9-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
 <20260623172310.272708-9-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:36:53 +0000
Message-Id: <20260623173653.E57111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dangling pointer left in device driver data on probe error path le=
ads to Use-After-Free.
- [High] Race condition in sibling interface lookup during probe leading to=
 Use-After-Free of `hid_device`.
--

commit 5a206f2162dc642386285174c7af698f767dad15
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Manage battery lifetime with refcounting

The next change shares one steelseries_device between two HID interfaces,
so the state can outlive either interface. Stop using devm for it. Reference
count the struct with a kref and free it from steelseries_device_release().

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index 1f0e9cb5138f6..734cf1eb87894 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -361,12 +373,15 @@ static int steelseries_arctis_probe(struct hid_devi=
ce *hdev,
> =20
>  err_stop:
>  	hid_hw_stop(hdev);
> +err_put:
> +	kref_put(&sd->refcnt, steelseries_device_release);

[Severity: High]
Does this error path leave a dangling pointer in the device's driver data?

If hid_hw_start() or hid_hw_open() fails during the sync interface probe,
the driver explicitly frees the sd struct via kref_put(). However, it leaves
a dangling pointer because hid_set_drvdata(hdev, sd) was already called
earlier and is not reverted here.

If the async interface is probed concurrently (e.g., via sysfs bind),
it calls steelseries_get_sibling_hdev() to find the sync interface's HID
device and reads its driver data. It might receive this dangling pointer
and call kref_get() on freed memory, resulting in a use-after-free.

>  	return ret;
>  }

[Severity: High]
Is there a race condition when looking up the sibling interface during probe
that could lead to a use-after-free of the hid_device?

When probing the async interface, steelseries_get_sibling_hdev() retrieves
the sibling interface's hid_device pointer locklessly:

drivers/hid/hid-steelseries-arctis.c:steelseries_get_sibling_hdev() {
    ...
    sibling_hdev =3D usb_get_intfdata(sibling_intf);
    return sibling_hdev;
}

Then in steelseries_arctis_probe():

    master_hdev =3D steelseries_get_sibling_hdev(hdev, info->sync_interface=
);
    if (!master_hdev || !hid_get_drvdata(master_hdev))
        return -EPROBE_DEFER;

If the sync interface is unbound concurrently (e.g., via sysfs unbind),
hid_destroy_device() can free the hid_device. If the async probe reads
the intfdata pointer just before it is cleared and dereferences it via
hid_get_drvdata(master_hdev), it accesses freed memory. The HID device
probe path does not seem to hold the parent USB device lock to prevent
this concurrent execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623172310.2727=
08-1-srimanachanta@gmail.com?part=3D8
