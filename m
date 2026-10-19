Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437107;
	b=kI2lrKJJOSqzm3dogtlPf9FKB5GakLBSsjLJ8ixBi7pp/ZImiG0pIVhg9wAF0pqwx3g6
	 DOXWJdg0ZIo+BREvv18IIhgE0n8s6E6ORPaTPEkEtD6MTziQMm6qiSWcScqEFyi48RKbF
	 mzqXP/1clbvb6EbwgH1rntXnUsG84Y2GYOTVMHDFGj7i5+r9Qna4bED+XPsQ4equXXGe3
	 jJWVFfusY3sJcdeqa6Lr1ENwoN+7M7rA0P08V25OOfZLBY7pR8H/+oP7wM/vTSxbqz88X
	 XiXASTU+GI1okBxwNaJUFlPHjUiYC+Uu/16K3khHSPZBu48E3klZEqrvLRYGMT88ILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RhTmWr+XXWZguh709xU8O4FXAyfq8Va3O1ZbeWOrgrc=;
	b=JmEsZUK0FsMLKU6a0qUUU/w0xiDQRql2qb0RBNSGMB30N5S5xz7MpSzzP6Iv1TpDxn6d
	 G10TtDOdw0nE10kKRhZuKldfUCWNxsTcJhzQG8udNNgOCTxaJVScOLNEZquikhWGQzKij
	 vkt72wI/tLvkLitq/8VFVJ+S54yjKifE44csnN+7HWckgqsS6vSGzcwM9WudVcGc6sBkC
	 hc6URe6NaVBe2ruSYFMjA1nQF7g027HzXG8rpnSn/kLojHrdobxzn1HVibO49LHu6duMd
	 D4BpT9wVXu7rfOP8GAijJxgvm8YKHN0A7xFHoCMeFINGo5ykUWO+LRSeaEtu1eSOEDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3H981Yh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9922606A32F;
	Mon, 19 Oct 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3H981Yh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1620B1F000C4;
	Mon, 19 Oct 2026 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437106;
	bh=RhTmWr+XXWZguh709xU8O4FXAyfq8Va3O1ZbeWOrgrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3H981YhCO5AbrpJtvC6R+k0LTpQrpsW/2KkU0zKPHz0v3d7Jjjp+j6I8K7RtG2+P
	 iA0hESBOEuX2L2urq0uKmENNWsQOmeTnTdY3unCuDQBHnMr/7NLF/wc0EdKrwSC1/k
	 J6hIu472K1tU78qy+/bsxgOuYt83BtQsLHDPzV0HYYi7vg0LYBjkdMHvcdwHp7y/vT
	 LxFk1DtzpFFi++AFXq5MHciBqX7pgf8QreMaOrYdFmLTCaBCc7j68nqVN3Sqr+81NG
	 7CuI4elnn+2L1yaBt2mbnOifSF/405VN8o2sAUjrMwyFs/oOPBjQoNV0FgUDrezY3g
	 y08xsozmDVL/A==
Message-ID: <sashiko-outbox-178136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/11] HID: spi-hid: add transport driver skeleton
 for HID over SPI bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019-send-upstream-v6-3-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-3-cb9ba4b3d6fa@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 19:11:45 +0000
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
- [Low] HID: spi-hid: multi-value sysfs attributes and missing ABI document=
ation
--

commit 4c66f3d16c395b79d0997b29357fb80b5a6f2708
Author: Angela Czubak <acz@semihalf.com>

HID: spi-hid: add transport driver skeleton for HID over SPI bus

This commit creates the spi-hid directory with its Kconfig and Makefile, and
adds the initial core driver skeleton including basic device structures,
sysfs attributes, and probe/remove functions.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> new file mode 100644
> index 0000000000000..02a7608c4b882
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
> @@ -0,0 +1,213 @@

[ ... ]

> +static ssize_t bus_error_count_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u (%d)\n",
> +			  shid->bus_error_count, shid->bus_last_error);
> +}
> +static DEVICE_ATTR_RO(bus_error_count);
> +
> +static ssize_t regulator_error_count_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u (%d)\n",
> +			  shid->regulator_error_count,
> +			  shid->regulator_last_error);
> +}
> +static DEVICE_ATTR_RO(regulator_error_count);
> +
> +static ssize_t device_initiated_reset_count_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", shid->dir_count);
> +}
> +static DEVICE_ATTR_RO(device_initiated_reset_count);
> +
> +static struct attribute *spi_hid_attrs[] =3D {
> +	&dev_attr_bus_error_count.attr,
> +	&dev_attr_regulator_error_count.attr,
> +	&dev_attr_device_initiated_reset_count.attr,
> +	NULL	/* Terminator */
> +};
> +
> +static const struct attribute_group spi_hid_group =3D {
> +	.attrs =3D spi_hid_attrs,
> +};
> +
> +const struct attribute_group *spi_hid_groups[] =3D {
> +	&spi_hid_group,
> +	NULL
> +};
> +EXPORT_SYMBOL_GPL(spi_hid_groups);

[Severity: Low]
In drivers/hid/spi-hid/spi-hid-core.c, bus_error_count_show() and
regulator_error_count_show() format both an unsigned error count and a sign=
ed
last error code in parentheses ("%u (%d)\n") into a single sysfs file when
userspace reads bus_error_count or regulator_error_count via spi_hid_groups
(which is attached to .dev_groups in the later ACPI and Device Tree support
commits in this series).

Per Documentation/filesystems/sysfs.rst, sysfs attributes should export one
value per file without custom formatting or mixing types, and new sysfs
attributes should be documented in Documentation/ABI/.

Should bus_last_error and regulator_last_error be split into separate sysfs
attributes (or moved to debugfs), and should Documentation/ABI/ entries be
added for the attributes in spi_hid_attrs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-upstr=
eam-v6-0-cb9ba4b3d6fa@chromium.org?part=3D3
