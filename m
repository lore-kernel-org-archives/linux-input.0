Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18E3C1973;
	Tue, 30 Jun 2026 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839227; cv=none; b=GCP6OvOcq1u6CVIBI+MKc6959ZlQHtQ+7jN/haylxebTVV3IWcoXxyS4T0SzF+58lr2XOP5hAP7sn6/kdLQF+k9j3udXtR+CmFc1SJscKrDQukCqzYY6Mq0kta1YSFJ+QsS+bixlQsIzcZFbRp5M+B67+EKoF+9vJkah4gbr30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839227; c=relaxed/simple;
	bh=uiv/MQy+bsUwjaZfvhdwuG1YReHC8DRhAmOkht8FjnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkKl+JoOoh1WKgoyR7CsRo30TMMJLqNh2A2yAfK/h589ClVXSW+GIeXFrK6YZ4smYzbx6qJC3TWD3//A/0teiSYqd3RkZo/cCgcuZbmcACbdnPbEflr3MSslw//HjcDh2onm8JyukxOA3HMUkRoZWh6R+3OLQFgaeBK483EZ/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SubIErM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SubIErM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9621F000E9;
	Tue, 30 Jun 2026 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839226;
	bh=KUt9xvrobGC1g8ep6yGQsb6675NZBAP2ejFkWc8jgUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SubIErM6OY/nb2I7a7mQa5SIcfQTpE4YTLOyvIpyeIB6PeUG3Lv4jF54i2MGGmdCh
	 wgl9ejCIKKFHKzm3brvHXwKMxMAyx+Hm+ohaq8CLBP4BuBp7+RssCBNkLGNDNFrh1s
	 Xp8obx4mdhNWPOSpPO+e6vcGDC2FHX0eqoolO6JD+NQ29QBbmU+8EfMqs0B/awPTZi
	 zgHwv9uiKZRWH2/c+3GCb7oAdOiyS2TAJC2XRKQ4QXErxmmREKGcUsADIZTUzmc5+Y
	 EnJGY7PSkzy/M2X09lRHaWizlACWC0UghIHGpS1r1UkHFCGslJibnLf1bkH6RcLjZz
	 fzNjBevOQDa6w==
Date: Tue, 30 Jun 2026 18:07:00 +0100
From: Conor Dooley <conor@kernel.org>
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: mailbox: apple: Add DockChannel
 mailbox
Message-ID: <20260630-tattling-pacify-3b990261b8b5@spud>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-2-506d936a1707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0g22oMjV9TukVVJO"
Content-Disposition: inline
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-2-506d936a1707@gmail.com>

--0g22oMjV9TukVVJO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 10:54:30PM +1000, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>=20
> DockChannel is a FIFO and interrupt block used by Apple coprocessors
> to exchange byte-stream traffic with the AP.
>=20
> Describe it as a mailbox provider so HID and future serial clients can
> use the common mailbox API.
>=20
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../bindings/mailbox/apple,dockchannel.yaml        | 75 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 76 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/apple,dockchannel.=
yaml b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
> new file mode 100644
> index 000000000000..4f326d8f3d5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml

Please name this file matching the t8112 compatible (since that's your
fallback).
Otherwise, this looks good.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: changes-requested

--0g22oMjV9TukVVJO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP3tAAKCRB4tDGHoIJi
0tpsAP9yh09xpXCe3hdbIXOFLGIAYGngvFJx/GaejeLl6sq6dwEAl0uB3079qxBT
RmiRaPZl5o6Er07zy4XhqIYj9j9MBQE=
=XGKy
-----END PGP SIGNATURE-----

--0g22oMjV9TukVVJO--
