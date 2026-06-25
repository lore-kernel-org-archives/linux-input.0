Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99D364059;
	Thu, 25 Jun 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379359; cv=none; b=uvzjHm2LeKTyyopRZiITZSHisA1V7GT06S9k3IOJ56+/mUt+Cct80DdUrykrHyiLFiMWkvd9slvpGr32rM59wRMrssmO4fn5xG9GeZJwpISQY1wPhep9pdSzqVkECftta4Uh+sCLrLHDfPIyxt6VVkST3maRMEoJqOcXoiHs0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379359; c=relaxed/simple;
	bh=9LdH2GIAQsyr0i/xJyEGADqPeQRmhxkIfX7Ckp8CLX8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h+ezCai8YgXkN3XCbMcnGI9eTZ+OuRq6osLpOnntZjK1iIhRCOQE0lTEJvjU85FA+ASfgd5CNpMkv0gpj6ZrSBYdMyzGaJzFgTuJlHMwLV6dbahi6xYeN/OWPZZ+8rg4qW8YwTgkXWYSDxI80F2Sn3XVxeQXM6zD0jZjqtE90Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RdwGqzYu; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RdwGqzYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782379349; x=1782984149; i=markus.elfring@web.de;
	bh=rsFjYUcmSFIxtrEdSOUo7STbvEKgHvQmW+mn7rdDdqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RdwGqzYuDrmqi4Isd8iEp08GvBoRAWIz9NQZLZezqUEmxbjKXhP1waZNIUUB2yF6
	 z5DjBJotFKNblcsGCjwGEEiK0qtIK3/96NrOD8Z5CUyI/1nD5OqYkBxorlrcf7VMZ
	 2b3qcCzMJq+wyGiDyVGcVnQ1ndhA2IcMdxSAXERfqWQFAGMAS4Uk2M8fRO6QmF8Fz
	 lPimxJRIc/j5zQVq6ZDb6eDZu27kNZGfmg1DYmw9w4OX6BaGxeHzUWi+URjCQ1vP0
	 g70ttC+Eqn/MNioI1ERGeIdPhuTSJ7gvoYLKUmit5GqW1ZCozaBTyu4lEv/edUIpJ
	 wYHHVGtmEcSAxbGneA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1wkYVM211p-00IKNI; Thu, 25
 Jun 2026 11:22:29 +0200
Message-ID: <89e9c672-efee-4ed2-9ef5-637ec9707f0b@web.de>
Date: Thu, 25 Jun 2026 11:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] HID: usbhid: Use seq_buf_putc() in three functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gU1czW1YEld+gQqJ9h4EvSY30W/I0ERUDGdczah6ugkW22z9u+
 ctMWbo90ZEk6aI+BTjNrfuhwWE804PlaW9KPKvUrfqAFUrP0alaFiFrLvitqIDV3fK5LNNS
 IN5yYlfMlb2141WSnLtABbWevYIUqHJmaUC/zoiQXImMsFfrPNIdNkxIrovuw9Hs07cllLf
 egI6XIy+hkWfdx5P+bU/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wNaoYIh4FVg=;azKigFG8xPSN7opumNUFGO/Bsor
 y1zlpsTdtHlSXfhmOW64JMkWiFATu6t1BEXJdF1++B0wdUDy+0wOfXyhf1o6WjP1HGGuQ4Amx
 AoEhjXsOGk8yQZTytbou0qMymFG+JiiIeYqsmA2SX28q8wD6Rl7kyLRJbIU4n8ox0v0JkHZHK
 1jMVQXVzBUh2PaGxY7jEZUyUmht4G0UzYWrrcwVH1bBzOkfMxbFYt4yCaFPm/a9WjbFbHpfpl
 wiwXIfwl114aQhPGce7RJx4Y5GlupX38Unpk4bjtY6xb1DCIoJiJuMh8RUKrDZ/V2k9IUoSH8
 IB2yeZPptzz6m89X66ZfzIEoBHX/N1A6IdGQW8CSxIBmzW5rrlCjaCfRvrCGe3k7/wGmVam8G
 7qoxIGEQ6rdMP1jwTsXIQ3SPwHwBAp2cT6IXaZgKES6imrXlPK1xLRBc7hB7c7OI79DzngtKW
 6pY2NFdoysb39+qeDm5U/7WlTahx3uug1WDj054RWwV/QNXf2+KyswZSkuiQGIFaHQMIidwps
 ABHalEFBlCE5KbMLzxNx8/7wGyNG9X+ciK4CdGzRQkOi4/IJ03OemjCpm30xKkiN30gsBjCQH
 hegX9MKsnXC32AnM+y23IkrirUZEpPCNignsbeKBrnLnD5P5f1BuPEQGaCA4caDuglcOScaIz
 8aUpZmqqh1rhq1Ozs8nfsMsTdd4XUrZsi6l54SR3tottUboFpaQgLUIgQZ7lZNWABKKXP+ARK
 CAsCkgkynkhWCUYx522WmXnlHZixrR619lRvGiiWSD994Ul6T2PmZzF919xx96ViDtFo3pLbo
 5BhsIFgqVls0tVbdV/VUaaA/h2Zv2ePXkhqT5sMW8Tuj+I5y4rg9gdpdogcd3GV8JoAJd/4Ui
 yVpFD6bJwisCLPrtEi552xJ3HY45jFpdj3Ww9ZXR/cocWRhfFPvO+jSX+bhKWngaQc2c/XB0t
 O8LoCnbKFEpTAuBQpVwNqjtUKEiuOxLiYG4+LhndCxPvc1d/0dizIpqc4n+mPLfGMkzQg7LR4
 lDZdOIgpnreCzyaH4mdXKDVZNACVthQgkUnF6OlIKCpwJ6YmZc/LT2M/1S/7lFXMTdmnHj6l5
 BlGEpiKTd5kb57kzler/YwbBrWv7ulgkkY2IDo/V5ZiO/iZd66LMdX6FGMB0hzqLiOTS4g49d
 oBmJwNudmBSOAQn2F2bFePTeC9TqK9x18vGJWwP21PjddgFV+Z4ECx4T/COT7P+FTDmg9frKm
 UCi5Jqm0kQKGn/QAxONItAaBAyDgoV1OWKwto0N38eY1SY3TcEHevJOtcpJdZZmQ+DB3G9U6F
 cMhlt32VvytBnHoGMQMhpGI+ih7xOYVaPyOhZOgjJA0NFkc1Rt6jB/3CgiR9MdjvDQKTLSL3q
 54u84cre7pa1ctrOj52Fxepsu3dq/+J1wqcdmMlNYojlXXoc1tGT/CHvjhR+NnECkWqOdIkyM
 fityQGl5/zjhRxbYjn5Rjb5c2RSe1GiGbEcJvySuH3AhLRibwayK8o1hWF1vYKHJpaYydqR15
 Bo586N8pkgcV5qyhskESbATwq2Ga+N2j6B77LVnKg015BUWpPLDeWafKjf8vTS2aqkJ93CEKk
 sBSFIU1CevpPIrlWnNmWXoPX191orMTfEdyR/qoLi2vmsWYqdn4ebBegcipanKamlNUg7okLA
 Dh3F44gM4yD99yV6qSTsqBU3MdoPQh7i62v4UUe/amONtIHjvJtmxmBeKMFffnKaGd5dBWt7A
 B6foCsyRfnNjvPz/zvze1EG0g0r2L2UIl9iK1c/ie6THUM24ppzDdaimFn4b79OFMnw6Tn4Eb
 p1NPjn9pKSCMyftkYGe6JQtxrORWId1j6oFrp3TQQyZ2KuUHvUdmi1iqKVQZFzvUy6Db2Elz8
 u0RcdIhCUb4o1yG+E7Ysj7IjFTFYD7koSLA12rPXj77OYfIMsC10svniX89a0fQOeN63dRKmy
 oGvIRqV3fDtzLSnlSpcwcpI/85THpLiF0j4RKTuRAS/EI1ky/qwthi4PEassXgRuXp/SSsr46
 Gfw4IMRUegoZ4NdFhx5ByQ9eetafDGT1OekDacAD9skRza3+xvZZnOrxeBx+1+jbPUxZqI4gb
 TFnDoLHS+dHYQXZIKk3XAdagZuCJcDt46CGZGWYgiRBrR7ByuC4YiU0u9MzO1NlKRdJaxUZwE
 vYjbVOinofp279q0loI2DdY8n4LagQXpVPx2W10FyTPYhvMr10AdA1mZN8/yOZcvNRscFe5E7
 DDzrKaWu9f+veqcn9KdecWpGYLM/I2Aqi+JWWEQMPcayF9Q9p1cEUecJftW6HorBF0TJA4/Wb
 PfGGiYs1f/OXFFvUyhyd6Ful3raVrSFQactH6F+0p/OikRfFiuMtOnWP5T9TMvE1PAQrGtzfb
 CcUhJHsxZWpbRNAO2cSFAsV1ghNxNqyxjqM4lmuClAcGzhYy8Oz689HfeEkYtf6LQt+s/f2MN
 Ro886Eo0cbOtFTUtyTU6S8S0HzNRnt2kSvadmyr3Sgb+c7ZU6eyhdQXaX48Gdf5Q1HBWuGoGo
 5DBPUsBamfYuZ2p3mRKlC99G45r2n1ohgjQarIEHBc0uUkCz3DuRxT79RStU+SJWND9mW4dzS
 zUOWOTooopuVynRJFsBWYcIGki3sRpIlpTMDDqWiI/93QBG1w4bJI2VRpMgnlJBaPFdH5d4WK
 UdKiSM309wKGoSKEnZFfoc5bUnC03yLr5ysdkRIJ26ego10E0xP7T53gFIEUli6QxYp7izbSh
 R7NHSxHDviPnDPxhoQJdjjlBsqOV182qxGB+TSWgFiUwOOJVz6KvWMszbfDwvPm+U+mIbd4UK
 qyrLu8baYmcFviICDz9NXAys4PVipDmFwgDSdgOiFqIs1A0w847owwOE+4KNLenfabdgrq8Rr
 o2xxzQAl5/1FfBHHm5IxmKq3mqimDWU0yp5mlJdz6ov8Pobq8Bc5Q46TKM4FEKLbp/sCH1x0X
 bd9IAxdgJUIi3fBJ2aXRh0W2yoeFOlkSj/hdQzXj4EL0iPhnvCSwVscpsCdnlnLy2T7CcQL8K
 AvRifExxWHS9XochvOq7YuQxUAHStR+0opKumgNukK9siNDdSHGyhpZjAR4MWiiv3TE3/Qpo9
 JLMygfLLBvNPZHPvOEerPUPLVRECgx3KEawvSUwNUJtFxH3pPDu9puQCA6sXm8h8hgVmL3cMS
 NG9lG+Ujpst+0OcoJJmMOpI+DSlTFb/VUvk+rNo+9rdCT1KVFX8V196FZEl2QeIfB3AYR524m
 zcyKaaDQ4Jdutc7SOSYrYFZPUtRkIdlB2EcfEeLrHwvdddhDKDDf9w2JLYQKpK7gQ3mKrZ8R6
 bfb9VUgMQ8/0CUfrwPfReZ16uxdyhzHkceo9+24Z5ZXo3IbQhWqWH3NYavnP62SrlVwkUhGBo
 KeUKAN5qGZPnEFEy/xvsfzXRuTqEvNv3zOlzxnqJurnDBaBAfsxb8CAqyceqC58N+U38O4Jox
 UJHjUfCl2sALXMf++5wnJIUEtFiNuSMNP5vf/j75XPN8hvkXdX8JSdP5d3VJRH5pv8jDe3bU6
 27uuAR8H5EozKEJ8tg2JjmjUWMnOa8Q2821cJY8jrNsdRyR+KGeC5HMRHSfueCH37twDNXYQF
 eM4LOJDtZG9khG5+oFhmYFBglT9Kx6e6PIiKcIoVbT6GATbzT6CK0Hjo7Uo38VgaDbBXIFffp
 3OLOaPcuc8apdfCK2rd2v8xAfOqWW2ChH9vfdJM7z86ZyEymj1jHnjZUDIyJ3pYLzme5thNQB
 ZOv882shtuqIZV1lictrfQ3ZpqQHFUWpYvJ764PThReTz6h/g2mlHlgQCKA5/OHuMpzyNwylr
 o06BoMzlRe0/qR5I/apcJLwzJA8lW4G5lhbJ9XCUj01Sb6eZx+kA5a75k6cHcO4I2wmorqk1W
 P0Wd/Klzypz2IECI2d1IJ17wmPfj0E2OOJhZhbRUkHGaMJlvyqzP4QgiGIeCQS0sziK7OG9F2
 d3SoFJiNOxZtMLhvjNsO2CBQoBNjB2d4GNuE5xTNHtKFg30drzK6bgNXEDkcGnpwxif8QYYqG
 RjYdESJNbuj3AxjAVc9bwe+DIAAX4f2LjRLJt1bN6vD04yWf7lKmY4F2DDPVrMH5hDsNN7Pxp
 1lFST+Z+sC50jSz6vRP3GvQSAZMPsQdx3y5jYXP2ikB+PG0OV6QnC1upkmh6gEWzaZKfT8AB3
 /kE4vGsAxLMnhQuv7F8adaHu8VR3G+GkQvvz7qmiYu3eRX4GSeZ+zZkWH2GU0z6o7tlRE762u
 DB1Hv988SIWnW2rx/Buzi3YRV/Gucl6zy2soBTAMupHSVO9n649FIckxEomlam71cAoGrUlhm
 vFxGhxRcEMiPaanhpPd+49TWGiuwJ9bctYpEdKJztqVnwcUS82IJgcI8RpegEk3X9kgUZGLbC
 rt8aU5IpV1/rEkK27U9EUcUY3+Tw3A8uxEFdNSeRGpwIKg9UgRPB/q2kL0BveKhGv3QbH63Dm
 edjf3Dhl+P/c4X/QB9SYcfOnidMlDd0hnWClRui+CFNBl/pWfob/6aANbI6wzmxK7/Po5wTqY
 lebKuD/RZiMzvxJyylq8Guj3QqjIpWmj2/amczuGrvbYIDTKON9naEmJSaZHsDdBpIn/oORz/
 zOmHFci41J0gE5pmHm4JPvItru4NwwiL/eGyPGILzllOxMuV3D2orunOQVG+eSuNN8T9RtSe6
 FnTznfaJIgojbtMRWnrFKT0Jd6CnX5UGyriijXnJby0r/kYqgsFWx14vVdZks5uVnha4vgXRU
 SqcwgMpnPssjctzjkLXJIFiVM1xbJfPZDRCh57LFCNcr1tGUMeDQbGzZsaOP57tEU65sBQwlK
 So6dwrxG3qi3iRayw6wbkRmUDh6TlrEUzjdN0C7RI7CisQEVDRuHoKWXTgCIIKKYO56mcsh42
 Q9ehbcxkNivRMFRO+3HqtxLtWVx32PvfMZeAcunlE1G7XrpqQvXnoSJtFjT5oduxSQ68HhNQz
 KjGQVm8Za/YYhAUT+Jgdc6eAyusAfujQrH1471A9PeqU96LvSMnBv96iifZqeIBBKD5WIUd4R
 HFM8PPks3SmDR2sK+5hawAf27u3w3xzwG1zYdX+FZvJoULHb20vfcHqIYw9Y4vNVeHvbESzCC
 7f0EpROkw4LSqkwMWmcgPwpWTpM2RBYzxdvEFBqj/kcyanclRyZ7EalUfqkaFbsXcwx4OGu/O
 8hQLW41cIST+BkZw7SEQHPDrDKSaQR9/iL+/4blvzo+l4KOtIR/hMpN7y7OMHXOgrFAN1y7rY
 deq/wuRRtcF5A+9LT6CBPoiB1xGS4fEEjtJeaAMJEJBCOLpoQRQ5B/YeeQ2rIm20Og778KGzI
 ep6ynvoWrzSs5fodDdpSTEuyqgJbNtC4EdjXgdR4ndwCezWtcPDDUm2Z64tzZQOWgT7JiyDmo
 3rnhe9BiO4in2xv30Czx70IunwR4HsvEr+VyxVxUcWXYJyxX7nfqTMgIiND+jZqmU8jKva6SZ
 omBEj75k4yX783wRoN9k8wQmsrnP8lm/SUE/fObxmQwAr95h217SXLQ7ZxFSva5sSNTPAtFJU
 TJ+zxwCUSs+i7XAYC+LORXszPkmqWNHAsWv79sHMtywfc5FIudcRjRri5Nb8L4NInuuMIA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jun 2026 11:11:26 +0200

A single space character should occasionally be put into a sequence buffer=
.
Thus use the function =E2=80=9Cseq_buf_putc=E2=80=9D in these implementati=
ons.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hid/usbhid/hid-core.c | 2 +-
 drivers/hid/usbhid/usbkbd.c   | 2 +-
 drivers/hid/usbhid/usbmouse.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..a755102b8cfe 100644
=2D-- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1412,7 +1412,7 @@ static int usbhid_probe(struct usb_interface *intf, =
const struct usb_device_id *
=20
 	if (dev->product) {
 		if (dev->manufacturer)
-			seq_buf_puts(&hid_name, " ");
+			seq_buf_putc(&hid_name, ' ');
 		seq_buf_puts(&hid_name, dev->product);
 	}
=20
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 83d4df0d7a45..02abd54eca49 100644
=2D-- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -302,7 +302,7 @@ static int usb_kbd_probe(struct usb_interface *iface,
=20
 	if (dev->product) {
 		if (dev->manufacturer)
-			seq_buf_puts(&kbd_name, " ");
+			seq_buf_putc(&kbd_name, ' ');
 		seq_buf_puts(&kbd_name, dev->product);
 	}
=20
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index b3b2abeee614..9fce51d65cd6 100644
=2D-- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -150,7 +150,7 @@ static int usb_mouse_probe(struct usb_interface *intf,=
 const struct usb_device_i
=20
 	if (dev->product) {
 		if (dev->manufacturer)
-			seq_buf_puts(&mouse_name, " ");
+			seq_buf_putc(&mouse_name, ' ');
 		seq_buf_puts(&mouse_name, dev->product);
 	}
=20
=2D-=20
2.54.0

