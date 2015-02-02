From: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v3 00/20] power_supply: Allow safe usage of power supply
Date: Mon, 02 Feb 2015 09:58:57 +0100
Message-ID: <13686747.WJugMFr0nf@fb07-iapwap2>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11668177.gtCQM2pIVG"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422629278-12202-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Julian Andres Klode <jak-4HMq4SXA452hPH1hqNUYSQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, ac100-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>L
List-Id: linux-input@vger.kernel.org


--nextPart11668177.gtCQM2pIVG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Freitag, 30. Januar 2015, 15:47:38 schrieb Krzysztof Kozlowski:
> Hi,
> 
> The patchset changes power supply API and drivers implementing
> power supply class.
> 
> 
> TLDR for driver and subsystem maintainers
> =========================================
> Two patches of patchset change power_supply_register() function so in
> the same time they touch all drivers. I am kindly asking for acks,
> review and help in testing.
> 
> Please look at:
>  - patch 2: power_supply: Move run-time configuration to separate structure
>  - patch 11: power_supply: Change ownership from driver to core
> 
> These are huge.

Patches 2 and 11 are Reviewed-By: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org> # for the 
nvec part.

Thanks!

Marc

--nextPart11668177.gtCQM2pIVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJUzzxRAAoJEKyeR39HFBto2BUH/2Dr/MSrGuZhAUOk3vetM4Yu
2HFNcuXw9lsKK0djNbT7XGCi/18cSN/TckPAi1XEkXkTzVuM/OXSUxaHKgPs+HHy
ovE8bgKXc9c8SgIL309znX4RSSj5dJd9olhEw0+vuQvMNLbxYsbpvT7mz0wHE2Lh
oEI2MxM+1hjTZvpb2qnpzj2q4oaXnIj3CeS9KNYfkizj76XCL1Cq9vFI/4SpeW3b
IqEqaZcbMY2o6pNMWzyrKKwHLLpk/wKitqWapkYkiV9lT/ink75GrvlfPSvdWmFp
jIACNgW6MT6oCICVmH/OhHjjSatJdTXKaEvMmlZa79ZUSljKYsNlbHOl0x53cpw=
=eWOk
-----END PGP SIGNATURE-----

--nextPart11668177.gtCQM2pIVG--
