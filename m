Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E383126B1;
	Wed,  3 Jun 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494250; cv=none; b=oijOJ50ceyvgM0UZBrsj6aD65h7IR/6UKsZ75+tpjGT18zI2D2JtCbJxADqmqY+CM9LqH4oOL8aCgCZCF03s3s20n153S1/op3jjMiRyHqn4hRD1ur42wseX1/XFx/i8lQwcUOgp09oGtwBvYh4ncyLCsycrP8HMUrWVNELuECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494250; c=relaxed/simple;
	bh=aHPUicEFVoNnCYVo8z4foWIsWF5I4tV2kxHMObwAv8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9+qWmMInKuQiNkKMQ0AxUbq1ZRVyZu+EAqom+z0AmV4/G6jRhBJtQxzVYeg9pXch1Wj8LcH8mdeNR6uB4nZ53FG7KNDg7tIWCG8/48/n9tbMO27zMKXm7Yu3xGeJ1j+Gk11t6hvrD0V2y+7DztynFroLwU/9dO66w/R+Xd6UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0Yjn0OL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0Yjn0OL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D06C1F00893;
	Wed,  3 Jun 2026 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494248;
	bh=D6uRSx4az7UQcm+muhppGaS4LcOWWUQe2WwZeCIuoyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0Yjn0OLz27IJHUVTQkU0URr5A6czcYGxYduGVg046Fn0N4jurREew1lnIN+uRBPK
	 JBxe7TroB235v6dUohRcrGuNOpymVZDZ3s8W5lZXZyfxJx/AfOuFJ/gmal+erhzquG
	 9F0xKy8rc+yd+PE7hbeAPyEGDj9jsbTwOVdEypMwwgUiMfWxtGQjS82jvaiy3a5D8O
	 NjbCPTyJNWSJLYPc2L0okOJe58O9i29k0ArhAPPY+4PyPV19o5YOF0OgRLJlXUY8EA
	 R0/lnEdo9VmviqgVo7krmPSAKARiw8ittJGjIHVdz2kVtkm73ux9edy5NfhCaPU3vC
	 t5+ry6rt+WPIA==
From: sashiko-bot@kernel.org
Subject: Re: [linux-6.6.y 2/3] HID: pass the buffer size to
 hid_report_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org
In-Reply-To: <20260603133140.3069226-2-lee@kernel.org>
References: <20260603133140.3069226-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 13:44:08 +0000
Message-Id: <20260603134408.8D06C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch fails to resolve the short report regression because `hi=
d_input_report()` incorrectly defaults `bufsize` to the received payload `s=
ize`.
- [High] `wacom_wac_queue_flush()` incorrectly passes `size` instead of `si=
zeof(buf)` as the `bufsize` parameter.
- [Low] Incorrect format specifiers in `hid_warn_ratelimited` cause compile=
r warnings on 32-bit platforms.

Pre-existing issues:
- [Critical] Unbounded `memcpy` in `dispatch_hid_bpf_device_event` leads to=
 a heap buffer overflow.
--

commit e280aff3473f90b2372da480e1f061c96bb64fd0
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: pass the buffer size to hid_report_raw_event

This patch adds a buffer size parameter to hid_report_raw_event() to better
differentiate between the allocated buffer capacity and the actual payload
size. This aims to reject buffer overflow attempts while safely zero-padding
valid short reports. The changes propagate the new parameter through various
HID transport drivers.

[ Upstream commit 2c85c61d1332e1e16f020d76951baf167dcb6f7a ]

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 7903c8638e817..e0c03942ff7c4 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -47,7 +47,7 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf=
_ctx *ctx)
> =20
>  u8 *
>  dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_t=
ype type, u8 *data,
> -			      u32 *size, int interrupt)
> +			      size_t *buf_size, u32 *size, int interrupt)
>  {

[Severity: Critical]
This isn't a bug introduced by this patch, but can the memcpy inside this
function cause a heap buffer overflow?

When dispatch_hid_bpf_device_event() handles incoming events, it executes:

    memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
    memcpy(ctx_kern.data, data, *size);

If a malicious device or a compromised userspace process using /dev/uhid
injects a report with a payload up to 4096 bytes (UHID_DATA_MAX), and this
exceeds hdev->bpf.allocated_data, doesn't this unbounded memcpy overwrite
the heap?

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e3d728d67b538..c6d98634b97e6 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
[ ... ]
> @@ -1986,24 +1986,32 @@ int __hid_request(struct hid_device *hid, struct =
hid_report *report,
>  }
>  EXPORT_SYMBOL_GPL(__hid_request);
> =20
> -int hid_report_raw_event(struct hid_device *hid, enum hid_report_type ty=
pe, u8 *data, u32 size,
> -			 int interrupt)
> +int hid_report_raw_event(struct hid_device *hid, enum hid_report_type ty=
pe, u8 *data,
> +			 size_t bufsize, u32 size, int interrupt)
>  {
>  	struct hid_report_enum *report_enum =3D hid->report_enum + type;
>  	struct hid_report *report;
>  	struct hid_driver *hdrv;
>  	int max_buffer_size =3D HID_MAX_BUFFER_SIZE;
>  	u32 rsize, csize =3D size;
> +	size_t bsize =3D bufsize;
>  	u8 *cdata =3D data;
>  	int ret =3D 0;
> =20
>  	report =3D hid_get_report(report_enum, data);
>  	if (!report)
> -		goto out;
> +		return 0;
> +
> +	if (unlikely(bsize < csize)) {
> +		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d v=
s %ld)\n",
> +				     report->id, csize, bsize);

[Severity: Low]
Does using %ld for size_t cause compiler warnings on 32-bit platforms?

Since size_t is an unsigned int on 32-bit architectures, shouldn't we use
%zu for bsize, and %u instead of %d for csize?

> +		return -EINVAL;
> +	}
> =20
[ ... ]
> @@ -2055,12 +2069,13 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
>   *
>   * This is data entry for lower layers.
>   */
> -int hid_input_report(struct hid_device *hid, enum hid_report_type type, =
u8 *data, u32 size,
> -		     int interrupt)
> +int hid_input_report(struct hid_device *hid, enum hid_report_type type, =
u8 *data,
> +		     u32 size, int interrupt)
>  {
>  	struct hid_report_enum *report_enum;
>  	struct hid_driver *hdrv;
>  	struct hid_report *report;
> +	size_t bufsize =3D size;

[Severity: High]
Does setting bufsize to size defeat the purpose of the new bounds checks?

By initializing bufsize to the received payload size instead of the
actual buffer capacity, the new checks in hid_report_raw_event():

    if (bsize < rsize) {
        hid_warn_ratelimited(...);
        return -EINVAL;
    }

will always evaluate to true for short reports, as bsize will equal the sho=
rt
payload size (csize). Will this unconditionally reject short reports and
leave the original regression unfixed for standard HID devices?

>  	int ret =3D 0;
> =20
[ ... ]
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 52011503ff3ba..52b7f474d8669 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hd=
ev,
>  		int err;
> =20
>  		size =3D kfifo_out(fifo, buf, sizeof(buf));
> -		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
> +		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, =
false);

[Severity: High]
Should this pass sizeof(buf) as the buffer size instead of size?

Because buf is allocated as u8 buf[WACOM_PKGLEN_MAX] in this function,
passing size (the number of bytes read) as both bufsize and size means
the buffer size limit equals the payload size.

If this is a valid short report, won't it be incorrectly rejected by the
new size checks in hid_report_raw_event()?

>  		if (err) {
>  			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
>  				 __func__, err);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603133140.3069=
226-2-lee@kernel.org?part=3D1
