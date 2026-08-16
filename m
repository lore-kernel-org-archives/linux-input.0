Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3982190462;
	Sun, 16 Aug 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871450; cv=none; b=VFmuRANwa9E/wmCGlIKjNDzMIbyeoF1C+vrZy/g6y4rWIlNq0XuGjyTl7CpZR/qTkgMTuhHgq6wOs4wutEXkn18uGrYEZ0PwHGFyxhKy15krVIV1CRzD3tjIc+JPBnm/YIBVsnR83qDKFl6P25DmGt5+l/jwskLX3ni0BGvQQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871450; c=relaxed/simple;
	bh=bKD+LczPWMRKymiZvTeFZW2DqdqWMIcrJVjqiY27Rz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GDX7cA0mFPlm0i0nWOY7bxUMkcFiFnIQa3LIoyvc0JaQSHYl+ifaNcFkpXZcSKbnVq9ExtR/Ho/r0zvpjioefezOVpL1mrtKGsQJQez18XNwooKI1vdg2fyCflVzFdYEtj4gIboafmOG5kydBoSRRrJ68/kGGKG4RgpbYNVp16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Q6ah64J7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Q6ah64J7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NrEUYrjZTvcDUiMxShUMOXghU9BWfoLn2LjuFoPa9Wo=; b=Q6ah64J7wzwRG+icu5fU91Nxv3
	t8YreFN4d/y+PzuslvmNvdf4kFs30I7L3l76VZZqNfvTHcJ3wsgtuYOsDMbb71ADoqNovqZYDnPsn
	rfhkZE6wSHeZvzEUNRwM/CFMqAmMK4opeuul1qKSc0FMMFoWqXLC8lmXClfA0PCPTF3X+ZQqWIzfB
	WwdaEDYX9orAhHexdosrHXBjQ4bxk6EaWCH6q02zFEnZ4unjxgVJrTPFQOGQ6ffJU6RuRJZSGfsla
	3TCIUW03S4yBBtwwkgOZQPn1mvfwU97Q/ySTNu+LK+DhGa5hk8cvNd/BNTOx0kbGZKkZWZtEytSk+
	+KwxbpWg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wvWt9-007LRH-0s;
	Sun, 16 Aug 2026 09:10:43 +0000
Date: Sun, 16 Aug 2026 11:10:40 +0200
From: Ben Hutchings <benh@debian.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>, 1141407@bugs.debian.org
Subject: [PATCH] HID: core: demote warning to debug level
Message-ID: <aoF-jIn9gk9kJ7Pz@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EgAQaCZm1TB6wdfL"
Content-Disposition: inline
X-Debian-User: benh

--EgAQaCZm1TB6wdfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matteo Croce <teknoraver@meta.com>

The log level for short  messages was changed from debug to warning,
flooding syslog on systems with devices that regularly send
short reports, in my case an UPS:

    $ dmesg |grep -c 'Event data for report .* was too short'
    35

Demote it back to debug level.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus m=
emset()")
Signed-off-by: Matteo Croce <teknoraver@meta.com>
[bwh: Re-sending this fix which was applied and then lost in a mis-
 merge.  Add a second Fixes trailer so this should reach all stable
 branches that have the warning.]
Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <benh@debian.org>
---
This was originally posted at
<https://lore.kernel.org/linux-input/20260523105545.68079-1-technoboy85@gma=
il.com/>
and applied to the hid tree as commit d0ff08d946c8, but then it was
lost in merge commit aa776949fb77 "Merge branch 'for-7.2/wiimote' into
for-linus".

Ben.

 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af..605530ec2e9c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2079,8 +2079,8 @@ int hid_report_raw_event(struct hid_device *hid, enum=
 hid_report_type type, u8 *
 		rsize =3D max_buffer_size;
=20
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs=
 %zu)\n",
-				     report->id, rsize, bsize);
+		hid_dbg_ratelimited(hid, "Event data for report %d was too short (%d vs =
%zu)\n",
+				    report->id, rsize, bsize);
 		return -EINVAL;
 	}
=20

--EgAQaCZm1TB6wdfL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmqBfowACgkQ57/I7JWG
EQm/bA/+NYBTqjjxmY8NP259zAuvFQJoR61XfIcj2NImqh/lotA/uAqeS1g6q46u
GgHlbfOhwjEwoMYQDLeChmaFSxZZCbYhd4ZQMruFodRd2NDwlMlQi6Jq8Umu3NJq
kQvVCHX0JEaOcoTKnhxEqJ7ssfrZwBUDixupDvlvu3kcBEsA7lp7MR7G5hkwrKVd
015y70C20LkQIif+e4D7FMqZI8Fq6yxga8qq/j50Kqo8vpygkMW8RwSwS9XHP8go
N7+YYidSoVfHoATNIWMU8iMxNaf+lnD3lYz7hxJkoTK2+A3c46YY+8rs27LOEHc6
qN0DQxJrx9LKzeMp3YPCtG4nbOCa7kPx98dWy5s9u5wrVAXjgMQ/Hztwr0qHpEHi
6VyREG+DqzFu2EEIlpFga4L1uxmkKgKIZ6gUrRdoHt933ag5LqrCInVQZVM3jhwY
mqWkk0dAXpBortytqEItyhVBmFN9WIb71IFBcDUoj3K3pUZszefchO29gvpJJUYr
DgPetpQxXYbA8/NR9jzznuDzIMOsN44tgqSg4wWHsMNc7KFQgcTrmfG4zU8+rhAM
Hqqdp8vWPf9ZH1GfjvvjSyA2oyRyRp/KceqwHGlU67VAlfiZdW0HD3W6K39CQCiJ
GS9igvKA+tyZZwnMpfGx4VD24PkswFU+scAJa7KfwNbOBeR478M=
=R7bY
-----END PGP SIGNATURE-----

--EgAQaCZm1TB6wdfL--
