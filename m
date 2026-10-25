Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792943849;
	b=wPjpYeV8+4WYw5ibFOagPxi36qHGTrAEQfemf+NCzvmSVVxGZlhxSo1yDAFSluqo8jlr
	 vyBGBwWbIUeYSmvX3o0xV+yiSI5nX0qgLafqMxxSGQlSkHzbpudHAexYPU2dT09KoSdlb
	 k7THjKEtXv4k4eOTmVbgLTPQehAmA6T6Jaf6Km9rTl2WV7nrB6SgdtXD/ZP1pMSKgp1vj
	 Vp1BYEuxepeFjzRowMhtTxk2J+LqRQLCqZnoWt31LkNlB1pLPCSGT/u5j51rUXdFgN+VQ
	 yDNia6dpxvQpHhoPq/8LnnD36aud+hPxA2TMk0DfGhCQjsAgnkdXzk1JL2qqS6bTNjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792943849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O/opl+GPjDHhszCz0WmA4K7jgVZvCdfLt03k33uUSq8=;
	b=xs3Ut8zAL36hAwJIq/Wy7pRHnhITdbOTVo5Hrhh2aer+kpqhlgM931cIfAPOa0woUZlr
	 zJjXyIWCxTa3gPKWJvVcayscEtnlC4Y0iHYa7pdyqijl5kp//YjSnW0BAUnEN4+HuHOoK
	 k59XiO41UjticXG15bgXtcHR7vg8g8dYjyTjgP713ZpaqURkENNJqrGMEsiEheg6yuIkR
	 /r8gpvZiUqZjNtGmi88CHfjChbf0t6mxEp8OVpNO2wVDJpCeZrogOq1Cs4JUCoFQZ92So
	 Mzd50Tdw0jXwepf35/PLIy8ToREbMihvA62ozCsjaMRBsJwXFUoCDqWArjiEsmsJ2EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUZ2CvS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECD606A31A
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUZ2CvS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC3D1F01825;
	Sun, 25 Oct 2026 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792943848;
	bh=O/opl+GPjDHhszCz0WmA4K7jgVZvCdfLt03k33uUSq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUZ2CvS4wJs0y591hHRiN2XukPqErz6BvZNNz5hUrb5YxBStGhYmTY4X84MDsHreS
	 gYbcThioR3Gwsw9zVWwd5SoWP3+2p24RpUzNCvpCXj+lB5RN8vDiNo3xCZiMtfFihm
	 7RUsnQyjs8odyIJgv6IvIABFcVU8fIQQVTYZaNp2q2ZGECkdot3Qg0B5YmyxWrX+xE
	 Sr5Zpj48KiJsW/GIWpJ+Ij3AV+wMsnYHXWp/uCQ4u6dPfyAriWnY3l7AXQPpXJeSbh
	 LV8WfKY2h1kxHgpFxbb/zCYrrVPxYoZzGCcgFBAXO3EDlVa4pk0zuu/fH1vzJo6oW5
	 l5CPB5EW49Xsg==
Message-ID: <sashiko-outbox-184268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: validate ACPI buffer length
 before memcpy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025154745.2734805-1-tristmd@gmail.com>
References: <20261025154745.2734805-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 15:57:27 +0000
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
- [Low] HID: intel-thc-hid: missing @buf_size kernel-doc in ACPI helpers
--

commit 43947a3c4aa80586265415752a6a772f3e74da02
Author: Tristan Madani <tristan@talencesecurity.com>

HID: intel-thc-hid: validate ACPI buffer length before memcpy

This commit adds a buf_size parameter to the QuickI2C and QuickSPI ACPI
helper functions to validate returned buffer lengths before copying them in=
to
destination structures. It also adds missing ACPI object type validation and
memory cleanup in quicki2c_acpi_get_dsd_property(), and zero-initializes the
caller stack structures.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 7a913f717efaa..dd21864d16b05 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -62,7 +62,8 @@ static const struct acpi_gpio_mapping quicki2c_gpios[] =
=3D {
>   * Return: 0 if success or ENODEV on failure.
>   */
>  static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, cons=
t guid_t *guid,
> -					  u64 rev, u64 func, acpi_object_type type, void *prop_buf)
> +					  u64 rev, u64 func, acpi_object_type type,
> +					  void *prop_buf, size_t buf_size)
>  {

[ ... ]

> @@ -97,7 +103,8 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_=
device *adev, const guid_t
>   * Return: 0 if success or ENODEV on failed.
>   */
>  static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi=
_string dsd_method_name,
> -					  acpi_object_type type, void *prop_buf)
> +					  acpi_object_type type, void *prop_buf,
> +					  size_t buf_size)
>  {

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 53023e30cf8d4..e4331ba4e503d 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -81,7 +81,8 @@ static const struct acpi_gpio_mapping quickspi_gpios[] =
=3D {
>   * Return: 0 if successful or ENODEV on failed.
>   */
>  static int thc_acpi_get_property(struct acpi_device *adev, const guid_t =
*guid,
> -				 u64 rev, u64 func, acpi_object_type type, void *prop_buf)
> +				 u64 rev, u64 func, acpi_object_type type,
> +				 void *prop_buf, size_t buf_size)
>  {

[Severity: Low]
Should the kernel-doc comments above quicki2c_acpi_get_dsm_property() and
quicki2c_acpi_get_dsd_property() in
drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c, as well as
thc_acpi_get_property() in
drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c, be updated to
describe the new @buf_size parameter?

Without @buf_size in those kernel-doc blocks, building with W=3D1 or running
scripts/kernel-doc triggers warnings that the function parameter buf_size is
not described.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025154745.2734=
805-1-tristmd@gmail.com?part=3D1
