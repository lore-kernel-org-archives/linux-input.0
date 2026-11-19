Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086449;
	b=K0dIEnQHFTBdQPiQ1wXStApMarRqOVzOQ2Awph86/+iKWYphkcVFN4XlGod71COLgG6w
	 q+8zbknc/dDG1IRzh6n7wu5oWe11fa3UR/3/AWyoHSaceCwfKJWPzUoAmsriBtv6qiZAk
	 ZnaYqO/XbMjS6Z0SwoBnpEgDSszzYd78mkIlUQJmywd2q7hI7l4kX7BLxgfwf2vRrryX7
	 7htl1i1P0hEwvW3H8FIAwhe/wckxP2AKE8udL6EPV4up3JrODRnBhBAMQvoVCki+CIQvJ
	 tZzjyLELjh4La6rfRPVLhyV+xZVUYE6DrEv0Yz9eYU5D+IJUIsSrwlfE629dQ5oJ0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bF4w0zkbeD5tHT4LAmxpVkfpXwiAwG3nGo+CC6+Ut+U=;
	b=D/BS3wJHwZ3PRuJAplsctzkjHyF2Cv1u2tKQdA07n+BYvzQA//ir5UTb4sjikWgf2kAY
	 Y44IWEh4xDDZfFXjtQ0SbMzAW+o9wd7iMX+6Cey8geuiU2wotM2ay+lE4X191qtHyPoi9
	 wWt74iCaQMqfr3MKVa5YY1HZ7UGxaYGVnmnGFBh1wW6l7nanMhQ1S3oVG+R/HrA8iMeT4
	 86tL0FACaedsYyrBKX2ewWXtwaK+LErUUJw896cbwgx45+EvfcOTo7ghH16KMe24k8+eP
	 VQlPuYQSiRklhks0+/4LRfsj/clxBFrTpZAK7k3rmpOlvHbH3AzNDsmhAaVAlRkyN6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BdCA/CYC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCD606A324
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdCA/CYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541DC1F000C4;
	Thu, 19 Nov 2026 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086448;
	bh=bF4w0zkbeD5tHT4LAmxpVkfpXwiAwG3nGo+CC6+Ut+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BdCA/CYCFNG0gk2k+hnhJ2sFk/RcD/1v4maISEg1mgK5DjqboQF7or84kbOvZttoU
	 dp+nY603iyTQIJ2RHFSEfYxS5ZXgMnKwFWUIvVY+OmlQRKBLxsem7h/PXN8INi+/UH
	 D54OhItJyct4WBI8H7aKXp2uhafLJYx1Yc5ZVI+CFpkcjxfIe/PQxrtRWX0WHZYgnP
	 4lDTu5qtov64WGxYfm1b7i7M3WAuLwQ2fvM6Jg8rWNxrxcJJLrKv/qaSlDGIjk83xE
	 JT/pbaBC8Clskh5YvOJWJhLZ07WNa4bKLahyGsGfqa252yoynMSSGaKf6G9fJdSeDs
	 Byb+8jYMdmKSg==
Message-ID: <sashiko-outbox-223007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: usbhid: free unsent raw output reports in
 usbhid_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119105551.488524-2-dmantipov@yandex.ru>
References: <20261119105551.488524-1-dmantipov@yandex.ru>
 <20261119105551.488524-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 11:07:27 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: usbhid: Fixes trailer cites c500c9714011 instead of
  f129ea6d1efe
--

commit 589b15fa1479bdb0a0e176cff9a3a3493562ddb5
Author: Dmitry Antipov <dmantipov@yandex.ru>

> HID: usbhid: free unsent raw output reports in usbhid_stop()
>=20
> When HID device is stalled or disconnected, there might be an
> unsent (i.e. never passed via hid_submit_out()) output reports.
> So free their raw buffers in usbhid_stop() to avoid memory leaks.
> Adjust hid_irq_out() to prevent hid_submit_out() from using an
> uninitialized output pipe slot as well.
>=20
> This is a companion of commit f7744fa16b96 ("HID: usbhid: free
> raw_report buffers in usbhid_stop") and inspired by that one.
>=20
> Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De2c057ea576d2644e2be
> Fixes: c500c9714011 ("HID: hid, make parsing event driven")
> Assisted-by: Sashiko-0.2.5:gemini-3.1-pro-preview
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

[Severity: Low]
At c500c9714011 ("HID: hid, make parsing event driven"), struct
usbhid_device stored struct hid_report pointers in out[] rather than
dynamically allocated raw_report buffers.  The per-entry raw_report
allocation in usbhid->out[] was introduced by f129ea6d1efe ("HID: fix a
lockup regression when using force feedback on a PID device"), so should
the Fixes tag be:

  Fixes: f129ea6d1efe ("HID: fix a lockup regression when using force feedb=
ack on a PID device")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119105551.4885=
24-1-dmantipov@yandex.ru?part=3D2
