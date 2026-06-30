Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B0330B11;
	Tue, 30 Jun 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839334; cv=none; b=kDlNsl5wHFvf7wZ/8JsInE9eYdSzGPkCormVzq/7KryTNUxdFLnQaQuq5qUG1SQ1BnVaHrYOl8/olEcnZNX2kTWi5vtmXUu1dAQw5Xb/EJG3M3+q1BPT0YJAcQqBjIj3sMq4Lq9Y5RZcLMxx5+tMSuRQPOPj2TRnWAecIYZWQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839334; c=relaxed/simple;
	bh=fIMm8C/TgI5nAa47LMm9rPL7P0R3u5OOub/jUFPcc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDvcYMcNuX1uDS8EsGemxwN9YiBAAtyz6IRmYB9M3ZmWuUHgqcD2xGvJKcA80icSHss19+7R9ucpgPyjoVQT8mDcK4u4uRbynfwAjS62+QopmV6g3TN4Qm2J5QV2vi86eJUz4zl28KoVXYi0XYilQmiSOKdzmzUMd25zqan8o/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElepC66P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElepC66P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B01F000E9;
	Tue, 30 Jun 2026 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839333;
	bh=vjXeeeCYeiUa7yMAifq5hXz1HtFrjFiorCgExnyzF2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ElepC66Pcuk267CvYmyn28I9bk3zHpHX2THxl8aq57IkCJXnUQBuLeA6ND3uVCtTf
	 UlsYWTk73uWhMnNjlC3jg7P7lrIeReoQ2Tkh/ciYapoig73EeiF8QJBmoO7qrOOLS3
	 NKLlS35VZ6hjxu9MmJNkIekPkp1KqgYq//PM5WhXMYWKriEt/31sSkCCmD40/pAOlS
	 05zkuCb6z+w5gIIVSvIxQpXSk0BXKpIC3Mta5W+PTFsDc39nkgqsqy74x5osEmFFHO
	 zubBFB+x5qzDhL5Hq2AETvLb/xv8yiWruG5/H0jWez/ZtOhekY1W/5OOmtBTziILS2
	 C4Pl3MgFtpIbg==
Date: Tue, 30 Jun 2026 18:08:47 +0100
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
Subject: Re: [PATCH 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Message-ID: <20260630-halves-magnesium-856f9c7d60b2@spud>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IFgQppRoGRqlg1/V"
Content-Disposition: inline
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com>

--IFgQppRoGRqlg1/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 10:54:32PM +1000, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>=20
> Apple internal keyboards and trackpads behind MTP are exposed through a
> DockChannel HID transport.
>=20
> Add the client binding tying together the RTKit ASC mailbox,
> DockChannel mailbox, and MTP DART. The keyboard child can provide the
> HID country code used by hid-apple to distinguish layout variants.
>=20
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../bindings/input/apple,dockchannel-hid.yaml      | 91 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 92 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/apple,dockchannel-hi=
d.yaml b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yaml
> new file mode 100644
> index 000000000000..dbba4fc38971
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yaml

Same thing here about the filename. Looks good otherwise, so please
change that.
pw-bot: changes-requested
=02
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--IFgQppRoGRqlg1/V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP4HwAKCRB4tDGHoIJi
0rC1AP9CivYKeIXifyJKmjFVsB20Z3JWxax7appciOgjNqympgEAs/E2+BjCEf/S
gRxK6PCZN+rd05T+GWJvwgvz+22GFQg=
=VmHn
-----END PGP SIGNATURE-----

--IFgQppRoGRqlg1/V--
