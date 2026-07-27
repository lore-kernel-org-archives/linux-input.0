Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77836345741;
	Mon, 27 Jul 2026 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117443; cv=none; b=jSe293xWDs8BGvvtWdt2Y2k+w5Kt0bR2OU0XPDYew5r6s5Gxd3CnOLc3UjotmmXYRNqs8xO5DWzXv2PFf348CXTB0HiHjeO0d8f9muINW50t3v0lA56evpXOrYBwBAjTGErnNLdcs6MsbAmidLss+qew4aMwcvWZqja6Yy4wkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117443; c=relaxed/simple;
	bh=HD2WJ/5x/o0muogGX9YyTPv9xoaHDf2TbDSE87sYIRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q38xsCs2rqX6bFBIzeahOr3CMcdvDzts+KRW/LpSallfLrDbz+Ai0vBRJahL/Shs9Qcd4JeWX8tmEuZnoS1C1ZRcz0Si/U1BgRC+sExQpwX02nVGjs7b+FXTnPRtN5kKJZsqRVFaaEhEsDRZd/BjitjQyeepYgRRmgmus+3ooSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DURqCo6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DURqCo6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E581F000E9;
	Mon, 27 Jul 2026 01:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785117442;
	bh=cFoTycp0hLavAZOQ0cVzd8gHYcpiPXTUug/Tnf0v72E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DURqCo6LkSY8u0QIgDnA4f5zQcGytdgKQY8TiMqJw1/XrjXZDeSZweJcivV3P/Ksz
	 alkJUFL7MFXOgGeZb0KpU6kdDnNi5rk1lF8/3DBGsHqPn71jU7Xbj1tsiY/Tl8rWRT
	 ySLBsgmdXeOfiPo6aHWkpiZ5X+DlVDLb+LKI5N+xnnMXyKYAgJS33d0eZAwDBEhtFG
	 C5q8VZ/KcnphEtXYbicgkLZhhhX/fwkYUvhcdPp18DGwE5OSLNPFOzN/BiehnuKXS+
	 rm0hAuoobjBTC2DzSq2JIpOl6iWOXcckVysAxZwLebK93PiLqtbK3cN8bEgkErAsob
	 vwcbcQLNVMb2Q==
Date: Mon, 27 Jul 2026 02:57:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
 <guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
 <lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>,
 <linusw@kernel.org>, <brgl@kernel.org>, <orsonzhai@gmail.com>,
 <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dmitry.torokhov@gmail.com>, <hansg@kernel.org>,
 <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>, <ukleinek@kernel.org>,
 <fabio.m.de.francesco@linux.intel.com>, <kaihengf@nvidia.com>,
 <ankita@nvidia.com>, <leitao@debian.org>, <pedro.pbg@usp.br>,
 <paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, shijujose2008@gmail.com
Subject: Re: [PATCH v4 08/13] ACPI: APEI: GHES: remove unused
 ghes_{,un}register_vendor_record_notifier()
Message-ID: <20260727025713.321f70e5@jic23-huawei>
In-Reply-To: <20260726101739.33170-9-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
	<20260726101739.33170-9-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Jul 2026 10:17:34 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Remove ghes_register_vendor_record_notifier() and
> ghes_unregister_vendor_record_notifier() along with their
> EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
> remaining in-tree callers =E2=80=94 all users go through
> devm_ghes_register_vendor_record_notifier() instead.
>=20
> Inline the register/unregister calls directly into
> devm_ghes_register_vendor_record_notifier() and its destroy callback.
>=20
> Signed-off-by: Eliav Farber <farbere@amazon.com>

+CC Shiju Jose who wrote this code in the first place.

Looks fine to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> Changes in v4:
> - Split from the devm conversion patch into its own commit
>   (Andy Shevchenko)
>=20
> Changes in v2:
> - New patch: remove unused ghes_register_vendor_record_notifier() and
>   ghes_unregister_vendor_record_notifier() along with their
>   EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
>   in-tree callers (Jonathan Cameron)
>=20
>  drivers/acpi/apei/ghes.c | 16 +++-------------
>  include/acpi/ghes.h      | 16 ----------------
>  2 files changed, 3 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..4e092f71ca84 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -677,29 +677,19 @@ static void ghes_handle_aer(struct acpi_hest_generi=
c_data *gdata)
> =20
>  static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
> =20
> -int ghes_register_vendor_record_notifier(struct notifier_block *nb)
> +static void ghes_vendor_record_notifier_destroy(void *data)
>  {
> -	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
> -}
> -EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
> +	struct notifier_block *nb =3D data;
> =20
> -void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
> -{
>  	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
>  }
> -EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
> -
> -static void ghes_vendor_record_notifier_destroy(void *nb)
> -{
> -	ghes_unregister_vendor_record_notifier(nb);
> -}
> =20
>  int devm_ghes_register_vendor_record_notifier(struct device *dev,
>  					      struct notifier_block *nb)
>  {
>  	int ret;
> =20
> -	ret =3D ghes_register_vendor_record_notifier(nb);
> +	ret =3D blocking_notifier_chain_register(&vendor_record_notify_list, nb=
);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 8d7e5caef3f1..3cd13171c14f 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -55,22 +55,6 @@ enum {
>  };
> =20
>  #ifdef CONFIG_ACPI_APEI_GHES
> -/**
> - * ghes_register_vendor_record_notifier - register a notifier for vendor
> - * records that the kernel would otherwise ignore.
> - * @nb: pointer to the notifier_block structure of the event handler.
> - *
> - * return 0 : SUCCESS, non-zero : FAIL
> - */
> -int ghes_register_vendor_record_notifier(struct notifier_block *nb);
> -
> -/**
> - * ghes_unregister_vendor_record_notifier - unregister the previously
> - * registered vendor record notifier.
> - * @nb: pointer to the notifier_block structure of the vendor record han=
dler.
> - */
> -void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
> -
>  /**
>   * devm_ghes_register_vendor_record_notifier - device-managed vendor
>   * record notifier registration.

