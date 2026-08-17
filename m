Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA0235045
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002838; cv=none; b=sYl9gTS8KU29G0Oxn9pLlhw/xCKE6kEcO5ZmXoxqs7uWs/4+p8m/l9U1BGnqZWr2RxMYdToFr6gmULAAwvzlCItBsAQo1ti/76P7mwkMtcZ8Ge/PdRwQ4o8olV6DPtTXvD39S7RWy83xaXmUhWddAcGovJrudeTvj4xLwbujl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002838; c=relaxed/simple;
	bh=VmF9Jugx0vg6Ce/NL2QLC99iUELK5vxpJraRyjFJjz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXHzS1r53BjZg+xvazpS1QeD0IuutbQsP2n9zsXMAuJJxx07y2DTsowxnSn8yVcwp/4gr9v8BGUSU+PNm9mDVLV1Cj6bR6B5VkuP9yMKl/rr8GPCTXunbsbCM3kdCf9wdm/5NhIzWgd5Q8rwyZojvPjzDFRq9Rx4Bi68AFCSv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=Ox8b1wR4; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IkGhJsqQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="Ox8b1wR4";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="IkGhJsqQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Ox8b1wR4tdrYy8xkXP2dCI1ecUoieu2WLt8JOhPwEZCR0gpP+GZjbRtk9ycPBfDTZqapehnLobXxwG7X+l3NStskPek5DMzNl2qmuzIsBtEV+ipmisN1EuH1nzHiKffdzYHArLOPYOFv/fwnDV4AqDO6xyDpGaCSQp3jOI9TO3WpNSK1ODymnLp85cc4dnkVuFJYBCTbCn74yQ0iLR6SZMEUaoSLIU9WlNg8i8NrukSHvIY5HBC5iglzQ6/vwYL3LrERGdPJmoxgdg7gWxDLbTswt1lcRK3BjIChlmAJkIRg+lxTMUJ0V+y105NpTLs0afPeycFIogq2m/+CmDLRrg==; s=purelymail3; d=rcpassos.me; v=1; bh=VmF9Jugx0vg6Ce/NL2QLC99iUELK5vxpJraRyjFJjz4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=IkGhJsqQZGm7XLlMHz+EaLghPHUEsek6VUmk/ta25xqTrpamOOmdVNVB5hGpVfCVGYNWqLcy/ZmufrxiwySiG94X2exVFEK/473XvPy9/S6Ca7fGsLvjmk4tApKsTaqBAD0lOxM50gbiih0QBUYm5OhnJ1cpjjzmlyEHo8cBZdDPNybWd5gYp4Hyush5T7i6hF7rkBkXAzHPn/fEpVYxv0TkQkp96ukyBQV0XnTTip1HI2a+LFyo+i9it5iEIY9gpnTAanH58QwSJd+yI39wGZ8TLTdl4yZRVRvPwzphvYKAlgy384v2EIQ3kidn4Yi+d/ZXDgANaSHB0BY2ziAQzQ==; s=purelymail3; d=purelymail.com; v=1; bh=VmF9Jugx0vg6Ce/NL2QLC99iUELK5vxpJraRyjFJjz4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1866441726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 21:40:26 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 3/4] HID: wiimote: led_probe with scoped cleanup
Date: Mon, 17 Aug 2026 18:38:23 -0300
Message-ID: <20260817213840.1053216-4-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817213840.1053216-1-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
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
---
 drivers/hid/hid-wiimote-modules.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index 3cd614466740..47fa6a8ecdae 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -341,11 +341,11 @@ static int wiimod_led_probe(const struct wiimod_ops *=
ops,
 {
 =09struct device *dev =3D &wdata->hdev->dev;
 =09size_t namesz =3D strlen(dev_name(dev)) + 9;
-=09struct led_classdev *led;
 =09char *name;
 =09int ret;
=20
-=09led =3D kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
+=09struct led_classdev *led __free(kfree) =3D
+=09=09kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
 =09if (!led)
 =09=09return -ENOMEM;
=20
@@ -359,8 +359,12 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
ps,
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
 =09/* enable LED1 to stop initial LED-blinking */
 =09if (ops->arg =3D=3D 0) {
@@ -369,11 +373,6 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
ps,
 =09}
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

