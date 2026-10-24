Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877720;
	b=uZSuGLzoc8Xj3qveagIPLLd1Iv3uQ7caQSxKB6AX9pOSc+npgPehane7Gzf8Ds1sKGNt
	 WGLDUlqkzHMvq4WPLweVjD+RWjfYv1VAuyQq+b8ArnCrApzOMugV0UdEY+k/A+1qLNvnb
	 rw1y1HVuBexkAzGO8mx+iGXPccLXCVKS5Y/CUed9MfZSMI/xFDb0w1T1ZUwBczJcAXmF6
	 ZbGdhC8H0U5Rjzgh6OiAkAzhC79fnmJidc4dFGeO3BeauHjp2dvdkhUfj0QE4F2bsib0m
	 a5bUkeGmlbgPIcEAHeUw7NcX5Kym/rbYPRAfzhOuYY/tBL1ysSxWyWHiE9tWeXNiOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FD8UgFMgXelwApcPCVI6iYUFOE5dpGoetp8Mz//NtN8=;
	b=0rATq83Ovth+LgqlsBiiKre5+BxL/DvFm4inwKZgiGSxUYj7YpTSo0AN9guSR/2QqJPP
	 nJlcTjFXmk6KWMwvkSw7Vt97HlWKTnfbqIMT+pjkT2A3w76HTwrQ1vZEabuxf0HZXKmw6
	 Z4epzF4gK1Y6JE6qCo1QUa2ijk9tx0QKVOdUpE5YXZWk8ZDCUfCPOAjlJuSjSl3nS+EaS
	 g2ZGitq8ZpxDUeY/l/rYyv/Sohr9omWLmsXB1jPg0Ua8x0Rsp1ysgnynwZEcuRlFH6EvE
	 HSZjLo0dENBx30PbDCThmLvUXTY0MvOxDDHOGxfLpBn9fqWAXgknb0q+VZpAjYlfHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGOdwBzq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2F606A31A
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGOdwBzq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7061F01825;
	Sat, 24 Oct 2026 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792877719;
	bh=FD8UgFMgXelwApcPCVI6iYUFOE5dpGoetp8Mz//NtN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGOdwBzq55ZtHyvpDmxiJHXQr0iCVkYGtCeFRQQHTg+ltXN9yJ5C5ZxmAaUo7aFdI
	 8mdOZkt/FjbQ9zjyxl8mJZ3w2oHcNcHIDn+N37Fkd5Ni27gPMxI1xk+mR3t3qqsIME
	 0EBNnlgC0usy73uieaLo6ZNmkZJtlDbIgkhkPMG1Do4f/EbUI4RuoJOliiCK+Qi2+0
	 dXWtGm8qzQImFFwhkL5kojm6Uvtpkt+jX+BCmZW+heF0LsL9dSAPW8EubE3PgcnHNt
	 PcskxCDOl7RpRnP1rbg8zFuNeO4cCPMJx2WeWI1n9Jp7O/SY7RaFG88V4uqab61T/f
	 6KZabfhSO8ICg==
Message-ID: <sashiko-outbox-183886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: validate ACPI buffer length before
 use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261024205850.4051206-1-tristmd@gmail.com>
References: <20261024205850.4051206-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:35:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] HID: intel-thc-hid: ISUB size check in quicki2c_acpi_get_dsd_prope=
rty() fails
- [High] HID: intel-thc-hid: opcode size check in thc_acpi_get_property() f=
ails probe
--

commit 7818ecd95e7c011bb989cd8c07a2ef782c095de2
Author: Tristan Madani <tristan@talencesecurity.com>

HID: intel-thc-hid: validate ACPI buffer length before use

This commit adds a buf_size parameter to the QuickI2C and QuickSPI ACPI
property helpers to enforce exact buffer length matching for buffer propert=
ies
and adds object type validation to the QuickI2C DSD helper.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 7a913f717efaa..6f70b64f20105 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c

[ ... ]

> @@ -97,7 +105,8 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_=
device *adev, const guid_t
>   * Return: 0 if success or ENODEV on failed.
>   */
>  static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi=
_string dsd_method_name,
> -					  acpi_object_type type, void *prop_buf)
> +					  acpi_object_type type, void *prop_buf,
> +					  size_t buf_size)
>  {
>  	acpi_handle handle =3D acpi_device_handle(adev);
>  	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -113,7 +122,18 @@ static int quicki2c_acpi_get_dsd_property(struct acp=
i_device *adev, acpi_string
> =20
>  	ret_obj =3D buffer.pointer;
> =20
> +	if (ret_obj->type !=3D type) {
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}
> +	if (buf_size > 0 && ret_obj->buffer.length !=3D buf_size) {
> +		int err =3D ret_obj->buffer.length > buf_size ? -ENOSPC : -EINVAL;
> +
> +		kfree(buffer.pointer);
> +		return err;
> +	}
>  	memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
> +	kfree(buffer.pointer);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -180,7 +201,8 @@ static int quicki2c_get_acpi_resources(struct quicki2=
c_device *qcdev)
>  	qcdev->i2c_config.target_addr =3D i2c_param.device_address;
> =20
>  	ret =3D quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_=
ISUB,
> -					     ACPI_TYPE_BUFFER, &i2c_config);
> +					     ACPI_TYPE_BUFFER, &i2c_config,
> +					     sizeof(i2c_config));
>  	if (ret)
>  		return ret;

[Severity: High]
Will requiring ret_obj->buffer.length to equal sizeof(i2c_config) in
quicki2c_get_acpi_resources() -> quicki2c_acpi_get_dsd_property() cause
QuickI2C probing to fail with -EINVAL?

In drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h,
struct quicki2c_subip_acpi_config is defined without __packed:

struct quicki2c_subip_acpi_config {
	u64 SMHX;
	...
	u64 FSEN;
	u64 FSVL;
	u64 INDE;
	u64 INDV;
	u8 reserved;
};

With 22 u64 fields (176 bytes) followed by u8 reserved (1 byte), the compil=
er
adds 7 bytes of tail alignment padding on 64-bit architectures, making
sizeof(i2c_config) equal to 184 bytes.

Firmware ACPI buffers returned by the ISUB method do not include compiler t=
ail
padding. Tables with the 4 advanced-feature u64 fields (FSEN, FSVL, INDE,
INDV, added in commit 0b1fca9dce44 ("HID: intel-thc-hid: intel-quicki2c:
Change ISUB table length")) are at most 177 bytes (0xB1), while Lunar Lake =
and
older BIOSes (as noted in commit 1db9df89a213 ("HID: intel-thc-hid:
intel-quicki2c: Update ACPI ISUB method support")) return 145 bytes (0x91).

Because ret_obj->buffer.length !=3D buf_size rejects anything other than 184
bytes, won't every valid ISUB table be rejected? Also, if shorter 145-byte
ISUB buffers are accepted when qcdev->ddata is non-NULL, should i2c_config =
be
zero-initialized in quicki2c_get_acpi_resources() so that FSEN, FSVL, INDE,
and INDV are not read uninitialized from the stack?

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 53023e30cf8d4..29689f41f6bf0 100644
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
>  	acpi_handle handle =3D acpi_device_handle(adev);
>  	union acpi_object *obj;
> @@ -94,10 +95,20 @@ static int thc_acpi_get_property(struct acpi_device *=
adev, const guid_t *guid,
>  		return -ENODEV;
>  	}
> =20
> -	if (type =3D=3D ACPI_TYPE_INTEGER)
> +	if (type =3D=3D ACPI_TYPE_INTEGER) {
>  		*(u32 *)prop_buf =3D (u32)obj->integer.value;
> -	else if (type =3D=3D ACPI_TYPE_BUFFER)
> +	} else if (type =3D=3D ACPI_TYPE_BUFFER) {
> +		if (buf_size > 0 && obj->buffer.length !=3D buf_size) {
> +			int err =3D obj->buffer.length > buf_size ? -ENOSPC : -EINVAL;
> +
> +			acpi_handle_err(handle,
> +					"_DSM buffer size mismatch: %llu vs %zu\n",
> +					(unsigned long long)obj->buffer.length, buf_size);
> +			ACPI_FREE(obj);
> +			return err;
> +		}
>  		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
> +	}
> =20
>  	ACPI_FREE(obj);
> =20
> @@ -153,7 +164,8 @@ static int quickspi_get_acpi_resources(struct quicksp=
i_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>  				    ACPI_QUICKSPI_FUNC_NUM_READ_OPCODE,
>  				    ACPI_TYPE_BUFFER,
> -				    &qsdev->spi_read_opcode);
> +				    &qsdev->spi_read_opcode,
> +				    sizeof(qsdev->spi_read_opcode));
>  	if (ret)
>  		return ret;
> =20
> @@ -161,7 +173,8 @@ static int quickspi_get_acpi_resources(struct quicksp=
i_device *qsdev)
>  				    ACPI_QUICKSPI_REVISION_NUM,
>  				    ACPI_QUICKSPI_FUNC_NUM_WRITE_OPCODE,
>  				    ACPI_TYPE_BUFFER,
> -				    &qsdev->spi_write_opcode);
> +				    &qsdev->spi_write_opcode,
> +				    sizeof(qsdev->spi_write_opcode));
>  	if (ret)
>  		return ret;

[Severity: High]
Could passing sizeof(qsdev->spi_read_opcode) and
sizeof(qsdev->spi_write_opcode) to thc_acpi_get_property() break probing wh=
en
firmware returns 1-byte SPI opcode buffers?

In drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h, spi_read_opcode
and spi_write_opcode in struct quickspi_device are u32 (4 bytes):

	u32 spi_read_opcode;
	u32 spi_write_opcode;

However, per the HIDSPI _DSM specification (functions 4 and 5) and the
register configuration in drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev=
.c
in thc_spi_read_config() and thc_spi_write_config():

	if (io_mode =3D=3D THC_QUAD_IO)
		opcode =3D FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_SPI_QIO, opcode);
	else if (io_mode =3D=3D THC_DUAL_IO)
		opcode =3D FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_SPI_DIO, opcode);
	else
		opcode =3D FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_SPI_SIO, opcode);

each SPI opcode is a single byte returned as a 1-byte ACPI buffer
(obj->buffer.length =3D=3D 1) that was previously copied into the low byte =
of the
zero-allocated u32 field. With obj->buffer.length !=3D buf_size checking ag=
ainst
4, won't thc_acpi_get_property() reject 1-byte opcode buffers with -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024205850.4051=
206-1-tristmd@gmail.com?part=3D1
