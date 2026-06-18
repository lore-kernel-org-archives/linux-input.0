Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34352280A56;
	Thu, 18 Jun 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799367; cv=none; b=bBi7nCEWKxkDYgJ9dtDOPBnbe6UilptLqVYEFNKvT8LHPZ8mVFWViK3ETW3fg8Wn5uZRqqOtMvdk+sf0I9Y60/WNW1zU9iS1x1EFz8d8TjWzddSTSjrYynmlTz/0C8wouv9preTs2h0S10OcY1hUVmLckidJz/DT1QkewZ1Bouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799367; c=relaxed/simple;
	bh=bh6yMG7Jjrcy+h2Lf4LEeP5p+/tFlElnTLLcqINYk4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WmY33R8bwzXkCerhtFRB/5tYSfw62WGWefNHDbfaqY+QPDjM/NZf2OquS2Hkj9Z5iHhALdRmGYvSBE6SQXVa5Auvs4qflcf0waEXnA4F7wDCfZmjwSgS53NhLYPvQwT4SYiZiy/yX7udmCz715T+s/q/G7xSsEv+eBQJtjIzg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB4/sYmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB4/sYmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EC31F000E9;
	Thu, 18 Jun 2026 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799365;
	bh=oyYL2Ifsh+0HG+Om4yOMBVAW+hFT0EaHlB18mBBOXOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CB4/sYmQEh9RFgFZHtqseuakDHAO34n5+z3duLrNy7xgyboGuU1oDAc/RKw/eFvz/
	 N02xJKEaJ3s+RuoSK8ldopxgSlFXDah5hZLd1yXNyDCmoHwXDt/67mN/W/plXMPWOW
	 isWgc0plYEvsZ04AOTpQTcdl+lJQ57VRP3QNSeWVOF9Wt6tDgyxyAhblx921b+S6+z
	 j+63U1SYyh5Iq5o5wSKhXF5Hm26mKQETO0YkE6P9hoIpJF2o0oaoEG8RqYlARUg5w0
	 B45fbqF+M/xGncv0TZMGp4CK0rgOQofBzTvMfhvt3E2uBThgMkVxp3nTQ4AvQ46tbP
	 JAYHDgS7tq4Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] module: add SCMI device table alias support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260618-scmi-modalias-v2-1-8c7547c1be21@oss.qualcomm.com>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <20260618-scmi-modalias-v2-1-8c7547c1be21@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 16:16:04 +0000
Message-Id: <20260618161605.12EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dropping `scmi_requested_devices_mtx` during list iteration in=
 `scmi_protocol_device_unrequest` leads to Use-After-Free and double-free.
- [Critical] `scmi_child_dev_find` returning an unreferenced pointer causes=
 a Use-After-Free if the device is concurrently unregistered.
- [High] If `device_register` fails in `__scmi_device_create` for the `SCMI=
_PROTOCOL_SYSTEM` protocol, the atomic flag `scmi_syspower_registered` is n=
ot reset, permanently preventing future registrations.
--

commit 90162c8443181b14c6b5151402b556abe1a600f4
Author: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

module: add SCMI device table alias support

SCMI client drivers already describe their bus match data with
MODULE_DEVICE_TABLE(scmi, ...), but modpost does not know how to consume
SCMI device tables. As a result, SCMI modules do not get generated module
aliases from their id tables.

> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/=
bus.c
> index 793be9eabaedd..70781146fa613 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
__scmi_device_create() leak the atomic state for scmi_syspower_registered?

When device_register() fails for the SCMI_PROTOCOL_SYSTEM protocol, the code
jumps to the put_dev error path:

put_dev:
	put_device(&scmi_dev->dev);
	ida_free(&scmi_bus_id, id);
	return NULL;

This path cleans up memory and the IDA, but it doesn't seem to reset the
global scmi_syspower_registered atomic flag back to 0. Does this permanently
block subsequent attempts to register the system power protocol until reboo=
t?

[ ... ]

> @@ -197,18 +199,18 @@ scmi_protocol_table_unregister(const struct scmi_de=
vice_id *id_table)
>  {
>  	const struct scmi_device_id *entry;
> =20
> -	for (entry =3D id_table; entry->name; entry++)
> +	for (entry =3D id_table; entry->name[0]; entry++)
>  		scmi_protocol_device_unrequest(entry);

[Severity: Critical]
This is a pre-existing issue, but can the lock dropping in
scmi_protocol_device_unrequest() lead to a use-after-free or double-free?

scmi_protocol_device_unrequest() drops the scmi_requested_devices_mtx lock
during list iteration:

	mutex_lock(&scmi_requested_devices_mtx);
	phead =3D idr_find(&scmi_requested_devices, id_table->protocol_id);
	if (phead) {
		...
			if (!strcmp(victim->id_table->name, id_table->name)) {
				list_del(&victim->node);
				mutex_unlock(&scmi_requested_devices_mtx);
				...
				kfree(victim);
				mutex_lock(&scmi_requested_devices_mtx);
				break;
			}
		}

		if (list_empty(phead)) {
			idr_remove(&scmi_requested_devices,
				   id_table->protocol_id);
			kfree(phead);
		}
	}

If another thread concurrently removes an entry from the same phead list,
sees the list is empty, and frees phead, wouldn't the original thread
evaluate if (list_empty(phead)) with a freed pointer when it reacquires the
lock and breaks the loop?

[ ... ]

> @@ -245,7 +247,7 @@ static struct scmi_device *scmi_child_dev_find(struct=
 device *parent,
>  	struct device *dev;
> =20
>  	id_table[0].protocol_id =3D prot_id;
> -	id_table[0].name =3D name;
> +	strscpy(id_table[0].name, name, sizeof(id_table[0].name));
> =20
>  	dev =3D device_find_child(parent, &id_table, scmi_match_by_id_table);

[Severity: Critical]
This is a pre-existing issue, but does returning an unreferenced pointer he=
re
cause a use-after-free if the device is concurrently unregistered?

Right after the device_find_child() call above, the reference is dropped:

	if (!dev)
		return NULL;

	/* Drop the refcnt bumped implicitly by device_find_child */
	put_device(dev);

	return to_scmi_dev(dev);

device_find_child() increments the reference count of the device, but
put_device() immediately drops it. The caller will receive a raw pointer
without holding any locks or active references. Could the memory be freed
out from under the caller before they use it?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-scmi-modal=
ias-v2-0-8c7547c1be21@oss.qualcomm.com?part=3D1
