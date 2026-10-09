Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD3175A74
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513301; cv=none; b=AioWauFzLluDYDyjwO20/niz3LCWMO3kvTVO69EAF1V+UEGuQs4+KJSFITc/sWnKRXY5zGoQD7XQ3yar5ipBn4wdFDuAE7GiAcHvEapNIJFOLPCKLpFqV9L3Mhj/y8OQOF71W0PtxU52P/d+CpfbS8Wo3oF90Ie6Ejkl+FnIeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513301; c=relaxed/simple;
	bh=WREXE+nC2vo8qpqDBsF/IhOMXR30v1bZpQEYcy5zNns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvYs3/dMDqHxo7NfH57IOjDOBbqLP+Rb1+qUiCT6PQ0wuV4eD0fArJXzOnyN2KwwWv7vdjnoRcffmu2hH6BOFyc23T2NKh0cv0/s4y0UhzVWBMvBKCdRJXfshaQh6L3W3Pe4z7d3K3WBtx551oUZSw70OEbAsZ9rYm3l2L3dQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=I0L7jE2Z; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=EFd9nYKO; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="I0L7jE2Z";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="EFd9nYKO"
DKIM-Signature: a=rsa-sha256; b=I0L7jE2ZZgKpeB7ApzOYtPkTK4e3jtzw0nt+PHw/CJw8yEkn11QscTVoVVwY3jvvztJr6E2SbjT24C0Mm73B3tLwh+hkyi735sgcs1YbewGxK01izr/ksLYY2Dri1HxsOgyMlS7MmmMqrKQyU3zGa9tWpJJ14Q+2aSeGLAguYW1zxi06Pb89iORNtbvh4Ac6CM/rPgkQMWWRfk804i1j08iBbP40f2mfG+WOG6XH6yOHUeyuTpL2j0oGAt3uJBWtb4LY9AMrxdjOAZIRMt+9zL9GzQ7EXlaf5vvUmtqFwcyYeqzybPukN3pkaqG1k8oaG7UlYnuxt9cbpOTD83iA8g==; s=purelymail2; d=rcpassos.me; v=1; bh=WREXE+nC2vo8qpqDBsF/IhOMXR30v1bZpQEYcy5zNns=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=EFd9nYKO4UPFcq3MLVNF+SqOSoKlmzeoQe0SbqfVu7JsIwUAwhj9hhP9/yAc85uE2QLeWbWXoLOvTRmmWrBB11uqOJaX296a43XCS9cjYGssqkJ29dz2Ib74rTClXhW3xgio5r/sUv2WTK/cjxm7+b2rj0GGqZeRqqNYBRIzCxdPbF5b15/lRZJQUdUox+rrm5PCKZxtS7BkjYo1pEjJX9tXGr7Obn1koVlViO5QFja47xRJb3/lZGOJrBggJhcs6e6viWmwL+jL/aZRVGu+nX9rHT1OJTb+aldvcpt/oxT0prI3a9cA5HwkYcIX63c1S9cbFDRnm0LDeK22pFuVUQ==; s=purelymail2; d=purelymail.com; v=1; bh=WREXE+nC2vo8qpqDBsF/IhOMXR30v1bZpQEYcy5zNns=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 703998172;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 09 Oct 2026 02:34:47 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v5 3/3] HID: wiimote: led_probe with scoped cleanup
Date: Thu,  8 Oct 2026 23:28:01 -0300
Message-ID: <20261009022844.2790778-4-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009022844.2790778-1-rafael@rcpassos.me>
References: <20261009022844.2790778-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Cleanup code in led probe function, using the modern scoped cleanup.
This prevents mistakes in future changes to this function.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
Reviewed-by: David Rheinsberg <david@readahead.eu>
---
 drivers/hid/hid-wiimote-modules.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index fa8c63eb6097d..199589cbf2b85 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -339,9 +339,9 @@ static void wiimod_led_set(struct led_classdev *led_dev=
,
 static int wiimod_led_probe(const struct wiimod_ops *ops,
 =09=09=09    struct wiimote_data *wdata)
 {
+=09struct led_classdev *led __free(kfree) =3D NULL;
 =09struct device *dev =3D &wdata->hdev->dev;
 =09size_t namesz =3D strlen(dev_name(dev)) + 9;
-=09struct led_classdev *led;
 =09char *name;
 =09int ret;
=20
@@ -359,15 +359,14 @@ static int wiimod_led_probe(const struct wiimod_ops *=
ops,
=20
 =09wdata->leds[ops->arg] =3D led;
 =09ret =3D led_classdev_register(dev, led);
-=09if (ret)
-=09=09goto err_free;
+=09if (ret) {
+=09=09wdata->leds[ops->arg] =3D NULL;
+=09=09return ret;
+=09}
+
+=09retain_and_null_ptr(led);
=20
 =09return 0;
-
-err_free:
-=09wdata->leds[ops->arg] =3D NULL;
-=09kfree(led);
-=09return ret;
 }
=20
 static void wiimod_led_remove(const struct wiimod_ops *ops,
--=20
2.55.0

