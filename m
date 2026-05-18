Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D5283FD4
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122101; cv=none; b=B3DGUxZAf3YONnq0E+r/KlcmZaJJY5RBjDifzj3PXWrRWYU8ROSrRf1r3LXD/kFLnSU5VbzW3Dl3H2wVKyAlC44bI3YPRmEmOLFnzgU1d3a6Mf6pFEAi7+NqbycCnAeNtLbwob8eSPkFu+nbn3c+S/1Lq+/vVUWo1pnFGoM49t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122101; c=relaxed/simple;
	bh=Mdx/i6iyvqPakB/ZxP1CMoiMH7tIxPqs8CQ3jGL8484=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMfAdPiqlndJ0k4rz75FHAIs/K82QJRruyC700RO/cx1vXHMx5D9/+9kZCIgZe8g8d7ohDFCKiXE2i1NoHNUyYKYUmVvpe8kZjeqm0NhWS5O34tA1brnAuh/N4gBGt3ZL6IsqvMCA/w/lt4JrsR45Da991+wj/BQqBMOYrI+I9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzI1Mqmw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzI1Mqmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6795C2BCB7;
	Mon, 18 May 2026 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779122100;
	bh=Mdx/i6iyvqPakB/ZxP1CMoiMH7tIxPqs8CQ3jGL8484=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=EzI1MqmwgvllNr/z3OTXmoVEOS7lV5k9B9MN47ra5b0VgGxU/ynLGn8je57Kv/TBF
	 +NzVmFKUP2rO9DuQWy2UWMFWE5iHmSP40cUQVy3ERkazJrE5MSvFrafvazLxEgn7xN
	 q9Xt+I0FgcouMYhPzC6o55PZewSElAxxXxs+1h/XCq6xeV9/Kd7S9IdD50vEs3aUdQ
	 WWIYPSaw6KsJ1bCIb6PgqNsd804JLoFJV69S3gqWZDStK87kf747k9kjsSnDLl4bXY
	 uB5IQ3+Gi1OOZREqFeaZpHN5Btjqhv2HKUOPoncyvKmh9hEv9yY67tsp2Rd26F7fAJ
	 FxhrG1lSAHhJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] HID: mod_devicetable:
 'hid_device_id::driver_data' add union
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-9-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-9-a08e3989c283@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:35:00 +0000
Message-Id: <20260518163500.C6795C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Adding a pointer variant to `hid_device_id` union encourages a dan=
gerous architectural anti-pattern involving `driver_data`.
- [Low] The commit message inaccurately claims that `struct hid_device_id` =
is part of the userspace ABI.
--

commit c7768796e9018aff03a8509ee8a35c62af4417cf
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: mod_devicetable: 'hid_device_id::driver_data' add union

This commit adds a union to the driver_data field in struct hid_device_id
to provide a direct pointer representation.

> The change doesn't affect the size and layout of struct hid_device_id
> which is part of the userspace ABI.

Is this description accurate regarding the userspace ABI?

The structure struct hid_device_id is defined in
include/linux/mod_devicetable.h, which is an internal kernel header and is
not exported to include/uapi/.

While modpost uses the binary layout during the kernel build to generate
the text-based modules.alias file, userspace tools interact with the
generated text interface rather than the binary structure itself.

Could the commit message be updated to clarify that this layout is an
internal build ABI rather than a userspace ABI?

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 23ff24080dfd9..90b2dae75109c 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -175,7 +175,10 @@ struct hid_device_id {
>  	__u16 group;
>  	__u32 vendor;
>  	__u32 product;
> -	kernel_ulong_t driver_data;
> +	union {
> +		kernel_ulong_t driver_data;
> +		const void *driver_data_ptr;
> +	};
>  };

Does this code introduce a regression by encouraging an architectural
pattern where drivers assume they can dereference driver_data as a pointer?

The HID core supports dynamic device ID injection via the sysfs new_id
interface. In drivers/hid/hid-core.c, new_id_store() parses user input as
an unsigned long and assigns it to driver_data.

By adding driver_data_ptr, it explicitly blesses treating this field as a
kernel pointer at the core API level.

If a driver dereferences this user-provided value as a pointer during
probe, could it lead to arbitrary memory dereferences or lockdown bypasses?

Does it make more sense to keep driver_data restricted to an index or enum
to avoid exposing an API that facilitates this pattern?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-mod-device=
table-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk?part=3D9
