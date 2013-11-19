From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Tue, 19 Nov 2013 11:44:50 +0100
Message-ID: <2173005.BXvqYgK6po@bentobox>
References: <1384682880-5960-1-git-send-email-sven@narfation.org> <2436222.LsGn6ZW5hr@bentobox> <alpine.LNX.2.00.1311191133550.6657@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3447302.O0GPXUZm0B"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42216 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3KSKo5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 05:44:57 -0500
In-Reply-To: <alpine.LNX.2.00.1311191133550.6657@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, simon@mungewell.org


--nextPart3447302.O0GPXUZm0B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 November 2013 11:35:27 Jiri Kosina wrote:
> > Now I have to resubmit the LED patchset to include the function/variable
> > rename. I will do this tonight or tomorrow.
> 
> That'd be nice, thanks. Also I think really only the first patch (atomic
> context fix) is really applicable for this (3.13) merge window.

Yes, only the first one was the fix and only the rest is for later because it 
is a feature.

Kind regards,
	Sven
--nextPart3447302.O0GPXUZm0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSi0EjAAoJEF2HCgfBJntGXKQP/RpT7Ed73uZketoiAY27p3CW
9vK3L+Gci5b/qmrpfuyTiI/sIaJPv/MeiDciBdF4pK8xbez14RzCjrDRd5sQdz2x
u4YGjS8zcmyjmDKJYKOe56ZUAccQktgmMHbXz0/X5mWg8g/ynN+oS4Kb8svZqhxp
d+hE1nUSMHoIy4jmRO2o3hBAKg+nz0Vj789I/mt8cVvqyXbUGBLUSkDO8zcgXZU3
YuwCdMNwYq4HzhdpF3rlTPhLgNcK50u6KD1WtdfRIoNwaf0OwmmjTv2cGONqx0Gc
VlWEVkV+xVlVq0UvgE/SLASzEV/VY5vXNwauIEGhr98ubJgFzCHsqTwaYSHyjpbw
OZKEgNYb2wC0Pcj+4kVPSwf5087UizZm1Totsxm8CmsOlhYt5LQqPpUK5fQI6sOy
4vqeye52dSfxWpU8LqT9EEQJtJSliUWIw7ar+Nc8sJ6JcfHfopjW9e6bmLyTFzlx
8ZC9O7ZDU454ibOBLJSeu7NN5ApLbvpYL94+qQq5g1PO2Pjl0wWYNrIK6M/FCLQf
EAW1Zs8cAhIe+DlOEEtQlCqYnu7kQmp0bCdOvEYegUvHDuLtpSsNfSgIJvPXTobr
TEBis67J9cZjojLGd/izPy7Q6PDoeYqG+nC/e+2P8MlWVZNiTzU/sYm+y63h5Enk
BiB3pbQAISMoyOuJ0w2j
=aedP
-----END PGP SIGNATURE-----

--nextPart3447302.O0GPXUZm0B--

