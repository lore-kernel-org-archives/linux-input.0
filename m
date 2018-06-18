From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/11] Split i2c_lock_adapter into i2c_lock_root and
 i2c_lock_segment
Date: Mon, 18 Jun 2018 20:06:11 +0900
Message-ID: <20180618110610.cwvkke6klc46kzvz@ninjato>
References: <20180615101506.8012-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m2cccclcdv7g6rv4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-input@vger.kernel.org


--m2cccclcdv7g6rv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I suggest that Wolfram takes this series through the I2C tree
> and creates an immutable branch for the other subsystems. The

I'd prefer this, too. Are the other subsystem maintainers fine with
that?

I am very positive on the series. I just have one comment which I just
posted. It looks good in general.


--m2cccclcdv7g6rv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsnkiEACgkQFA3kzBSg
KbaHRg/+LIDv2KYrGb+WRGPsvVW8pckrYy46rfvncOf6y84rD6/fOb6yBmh8d/X9
knn6/6n6qCSkRIsEGt2qiGN0/wi+SscJ1sSYb8nFwe2vaYFkwpGLAutys9o6Y7nZ
rmqnfcnEVIyY6w5eN2ZEZymToscwjRHmf8s4LOe8QvPTf9FSP22ZxAg0LdwRZCAZ
588k6cUKFmd0XpCrW/1EvbMPxAz58T0gZDAJ6M1MLJiZZvK8PKAwl21kXeFW9/PY
rkpjcpz6MsBik3OGw83YW3ZzrQ48XqrnknkNFt7/CP+TcCUI7wRuCAjuNPW0Nstr
HzUKry57BfEA2G//GZxKmjSzy8ZGuLu6UBgl81cJsjnw93FAsbNlsJBRxWT5PRZS
2ZELyjwtDoQOchXnwFz6JdssbjYp6KvbAEL7osl9lAiMf+DpNmkbwATkMWwAlHVp
bPtuKxueH0ABWwuUVu6Xzxh4hVVQxBE2MvlVzVmNLv5gTx7XMISJM+8GZ5pjR5iv
f2Jh7pRuzPfyk8GD7GMbIn4b0MOlX3xR2nBVT9jS5t0rtQAUouSJ0BhPIZO6HH/s
J62e1enNni++DfR6pLZKaLT5xILgLCoZv9CRw1saX+86RvsX8vFrNt9B3RCTeUJu
/c4IVYf52xA+CxviyqcZqYDjYrrirHMP2LjRclvMyPBzsE/wy/E=
=HnqL
-----END PGP SIGNATURE-----

--m2cccclcdv7g6rv4--
