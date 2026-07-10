Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1A43079B
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697760; cv=none; b=bwzfXo1+1+TB1TF6pgX1uu+OKqJJOxkRJ7GPP38+G0rCxImgzI5ZSbOEA999qo5MGvxpQDiMG+Ysbox8h75hwSo+lIUvj68aqG1bwoN9DHm6adXvdN0msrHM0AvVxqKa4d9ULjIeg/Ody/whrPp62VmnbLrjqmu7N+ED6+OmTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697760; c=relaxed/simple;
	bh=+pm/JGSiIHBnFzCzg5ySacPKGL7dhKuPbKl2NKB5PMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzYAh9hProOAnnz3UjM8Gezxrgt12mryjyVlbrEy0+GkA9Nkz3rpBQLxU4kre6gBSuyX5/tmsH6T5XtCPwLlsMeqKNrJd76ER2E8CExmpWkXKNsu2SujLClR2gcyO8HPLX9hWT+QU8ovu5xeA9RAbCGEgF24id0ArheQyqvgKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=TXDy2sMA; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cq4VlX1t; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="TXDy2sMA";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cq4VlX1t"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=TXDy2sMAwq4lt+ylXcJQrDd8q6UzMrnzTo1tJN3BhJ05SCz8hBY3bMdDK4HDiV5V1Zuk/K/trmKdESt1JnPmRB/W7PAdWRT6XuwBazFwroHL1o9i8PLwVuoClTkHbqcn85Dn8dBpUyhijUD95uTEXswJjQtqe9xOAo477kTR9sbhYl7xBnM115Q1wHfZeS1eWEi2Q3SAJ4I3e2PEqOhM6idltAyq9pEgwQOgE2QzJJwLSNScbnLjQVKKf9d7PlkgMBiTzttMBNMQVstqBIk7vTKLRsThvKQVwXIW2QDxMLUFhoXqWGXakrkUIlKc2ICtuLbxhxYxJ98kiSaMS+lcdw==; s=purelymail1; d=rcpassos.me; v=1; bh=+pm/JGSiIHBnFzCzg5ySacPKGL7dhKuPbKl2NKB5PMo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=cq4VlX1tnaB13okis3QQr84bTO1oIdJAGf+5U0ezX3yK/M9X4zTuAKj9dSzgFcWpQmS64Qiuwl3NqX6SeMMuRNJ+ewe/0MDUOgbygtK0mYudkHYP9Ac7kGjCJ0uzFRHkh+t05xnzgosoHCI+1tfKahZXCouNgIJa3OTV6C0ZnvXkZQ3Yi+7sZZPhjZuunrAJM/mSeWjP9dX0BVu8wb29C+ECD7xBy8A7XWzvqrFivEYVjz+RilX6yPwAQ42EMhkH8OTYCmB1nbFvXiieqedHO4woTzTOHsTcLdC3tEU+lIBv6qoYe4a72c4yDItfkLGcuScmVyBSjA0LsLE0eDG44A==; s=purelymail1; d=purelymail.com; v=1; bh=+pm/JGSiIHBnFzCzg5ySacPKGL7dhKuPbKl2NKB5PMo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 445827024;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 10 Jul 2026 15:35:43 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH 3/3] HID: wiimote: use scoped cleanup in led creation
Date: Fri, 10 Jul 2026 12:32:11 -0300
Message-ID: <20260710153456.2093889-4-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710153456.2093889-1-rafael@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Cleanup code in led probe function, using the modern scoped cleanup.
This prevents mistakes in future changes to this function.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-modules.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index f42f9aa7b2d4..7c305099c82d 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -340,11 +340,11 @@ static int wiimod_led_probe(const struct wiimod_ops *=
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
@@ -358,8 +358,13 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
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
+=09/* Ownership transferred to wdata =E2=80=93 prevent cleanup from freein=
g */
+=09led =3D NULL;
=20
 =09/* enable LED1 to stop initial LED-blinking */
 =09if (ops->arg =3D=3D 0) {
@@ -368,11 +373,6 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
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
2.53.0

