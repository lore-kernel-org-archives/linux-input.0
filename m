Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495945;
	b=PMI0f0QLEwrdkfCrY87hTrmvqqijc9Jj16kGDjKzCfCDx3C3tUm1WRNHu3SMnUpB9kl8
	 LSvMRVu6zOYu4dnXtCsV+lL8SLavTKbRw/qSW3UME/PpT8W4NVQe22xwa3EBnjkirI+JH
	 kfL0pP6m8JjEy1oD52yqYEa+eNzccn7JQe3BMxQgKHwEQ1ERCOzMcXO/+golJvwWAEoIr
	 bp1UYdORDXRSSSckNQYcGxG7tL55WAlVUe7efPqG7HHPfoN5B08RjAFsyxCLRHxDuA96l
	 z1pCYOHlDfyZmRT1Iai8+J2HjSmuDWVK87AQ+DFuoR+VLj3axwC7RlXUN9vgA2+wC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d0bVohK3ArTstpILC0i3sU76Zp+ms5BmbzrxgVgd06w=;
	b=myN16bWYW/ZDeqy1peOR7PcZ1eYu7O7q0O8DkfV8RZBPFs3bPw5+fWhlt2cPDUXMxLAx
	 N/tZHxESXT6ZdfFsVMvgWTBsQ1gco/DoWRRkoj5MmhiEiAkOiDgcXeADfAAHg4O2m6w0Y
	 8z4pbCT0CdyfZUdKV6AYREsVbcfaNEk4havDclTLbNg1U/K9lx9ok2MPA/Teb6vik4K2c
	 xhSTTtCrXVLNLSWWCd619DEJ7ZP6U9xcaolXNg8kFnOuR02fOXGCRLBo1GYiQv63/W3pk
	 Xuqa36nx4U/4oIR3im+vAWtWLM/VlbXzV2yHlDZyjRax3vCURS9vQBmDJ09NA//EfEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2FQTpvj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8E606A31A
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2FQTpvj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D11F000C1;
	Sun,  1 Nov 2026 01:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793495945;
	bh=d0bVohK3ArTstpILC0i3sU76Zp+ms5BmbzrxgVgd06w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2FQTpvjlwoHnlakcb367j/vl/1aMXiklI00Y9JsxnCvHrkCR2O9+4i14bRuS2ZlG
	 EswUVyvEpudJDrm2+FezAvwgH8k76OZG4B0b6RvbXeL79+nZCFcO4AheeDsXH3k/lC
	 nxDNAlwqp0Sht6zqG36Y7ykc3ZKPmmQeQ40HbTFYaT8cwLF5XbNv0dYPo48z615mEE
	 opeHuDaX+/YkiA5YSspdJXs7rNVx1fN5ZaIp8D8Bu3dhBJ2gctqV2uIzlGJ6KnBqxI
	 nYVQhnnyzncEoCaTWH4yOKtYWrJIeLkMc9aQOivV7u6BB3D+Y09vMfhvGfJGrPYwXm
	 pC+h9T7ifggvg==
Message-ID: <sashiko-outbox-192233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: replace sprintf calls with sysfs_emit calls
 in wacom_sys.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nehuen Lian Bova" <nehuenlian.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
References: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 01:19:04 +0000
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
- [High] HID: wacom: invalid sysfs_emit() call in __wacom_initialize_batter=
y()
--

commit 4c50e84abd55ee59728372c4dfa52c46c6e8c7c7
Author: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>

HID: wacom: replace sprintf calls with sysfs_emit calls in wacom_sys.c

This commit replaces sprintf() calls with sysfs_emit() in drivers/hid/wacom=
_sys.c
and includes <linux/sysfs.h>.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a2..bb51ea4b34f89 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -1838,7 +1839,7 @@ static int __wacom_initialize_battery(struct wacom =
*wacom,
>  	bat_desc->properties =3D wacom_battery_props;
>  	bat_desc->num_properties =3D ARRAY_SIZE(wacom_battery_props);
>  	bat_desc->get_property =3D wacom_battery_get_property;
> -	sprintf(battery->bat_name, "wacom_battery_%ld", n);
> +	sysfs_emit(battery->bat_name, "wacom_battery_%ld", n);
>  	bat_desc->name =3D battery->bat_name;

[Severity: High]
Does using sysfs_emit() here break battery registration?

sysfs_emit() is meant for sysfs show callbacks and requires a page-aligned
buffer:

fs/sysfs/file.c:sysfs_emit() {
	if (WARN(!buf || offset_in_page(buf),
		 "invalid sysfs_emit: buf:%p\n", buf))
		return 0;
}

However, battery->bat_name is a 64-byte array embedded inside struct
wacom_battery:

drivers/hid/wacom.h:
struct wacom_battery {
	struct wacom *wacom;
	struct power_supply_desc bat_desc;
	struct power_supply *battery;
	char bat_name[WACOM_NAME_MAX];
	...
};

When __wacom_initialize_battery() runs during device probe or hotplug,
offset_in_page(battery->bat_name) will be non-zero, causing sysfs_emit() to
trigger a WARN() and return 0 without writing the name, leaving
bat_desc->name empty for devm_power_supply_register(). Furthermore, if it
ever were page-aligned, sysfs_emit() assumes a PAGE_SIZE buffer rather than
sizeof(battery->bat_name).

Should this use snprintf(battery->bat_name, sizeof(battery->bat_name), ...)
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101011439.2618=
12-1-nehuenlian.kernel@gmail.com?part=3D1
