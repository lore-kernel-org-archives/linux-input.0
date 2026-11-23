Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450117;
	b=edjrN/p96izCHMtb1VVbcVohfYFrvdfWr76I1G9OYXEzYkI4dbp+7Zzgg94uT7OCjNOQ
	 LZZQuYzXf3wR3G12S3zmFOzZj8c7umOujkLYvOLco2sP3QfF98b0NI6ZsqNzeoCTZVt7x
	 sX9JNn64aWoJ1ZVsMP54vRTRuCYIFzJV88K+H/KG8ZQQK1vhrXsqO5DGxsTrhKYU5Xmx+
	 ehYavFWywfkwthPZVvWej6VeKL6/lmpXw91q9LP3DjhT6txUeX16HE6oNkVQb8D6leEQa
	 ezznN0DxiZmnYiluqF4PTpwn2/Dp2sfX5NRetEDa0JIio7HFXDL+6MfTfwttjhxHk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t9jOk3je7+24C/kM2nXtwpWWGqJWoEHgyDXlLUT3QjU=;
	b=QYmYKx3it0SvLR1CJiqkFQ7PpbIXkDQt9kUBX+zrWSxtRhJ8cjX2jFVrqLueOPes9ryE
	 bgx3lC3re6oVTnZyda22btb63DEvxYNzomF24yLAN2TAQIjfqW5et1hBSHwDCs0UL8Kyr
	 EI1FP62GgoxP8PWG5PMY/BmDmL+0bufFwpMFZn59UH61yUqTXPan5tShOD8PNAGtzq9/f
	 GuY4JFwKY+PNqeHg45/T/m3crHafIvWypF1dFVJNjdteupF6TnO4T7NUZSr61ZtjT4nPE
	 boaXymiqXCpJBFPRaRTwH1WvRbHj/noJRfc5xw+HKOkm1+SqClqoRy/fxk+CvMMN0BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQmVJ0T6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B78606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQmVJ0T6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAE11F000C0;
	Mon, 23 Nov 2026 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795450116;
	bh=t9jOk3je7+24C/kM2nXtwpWWGqJWoEHgyDXlLUT3QjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQmVJ0T6eWHIoyCSnMWdlPNGsZL228NkzWkiLQWWtUtziM/flu7jdFDmujVdqKPwN
	 oNNXOEdoSEF+vIIhOQdaIXDc8rlPmbYqgP5vEzbp/FJak6ql3K7t1oXZq++h02/x9Y
	 kdqr9GnNq34oxBjACov4Y5nYherWCp+SwaXYRUr0Bm6IBLKpzA40OaYJwhAOLFNYle
	 C07nEMctLCJVcbX2dkUIQ6cWuJWZnfQjJa9qXwTdaTo96rB2pjr/xXm26cNxZ/1nGO
	 hjyxhn9qf4Bm6a3ylWvkEyG3XVzjrkGPRQfM4vE3vy8hiTBjrv0cmLz9uFKHQFRWqM
	 1Wj0f0gxwgcjw==
Message-ID: <sashiko-outbox-229644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] HID: wacom: Stop HID hardware before releasing
 resources on mode change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123155138.2907049-9-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
 <20261123155138.2907049-9-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:08:35 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] HID: wacom: resources released before hid_hw_stop() in
  wacom_wireless_work() [1]
--

commit 32ce19fdb19359280af8da0840cd4996821af3f2
Author: Lee Jones <lee@kernel.org>

HID: wacom: Stop HID hardware before releasing resources on mode change

This commit stops the pen and touch HID interfaces before calling
wacom_release_resources() in wacom_mode_change_work() to prevent a
concurrent wacom_raw_event() from accessing freed resources.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2d2a4d56a8da7..121bead90147c 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2887,16 +2887,16 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
> =20
>  	if (pen) {
>  		wacom1 =3D hid_get_drvdata(pen);
> -		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
> +		wacom_release_resources(wacom1);
>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}
> =20
>  	if (touch) {
>  		wacom2 =3D hid_get_drvdata(touch);
> -		wacom_release_resources(wacom2);
>  		hid_hw_stop(wacom2->hdev);
> +		wacom_release_resources(wacom2);
>  		wacom2->wacom_wac.has_mode_change =3D true;
>  		wacom2->wacom_wac.is_direct_mode =3D is_direct;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but does wacom_wireless_work()
have the same issue [1] where wacom_release_resources() is called on
wacom1 and wacom2 while their HID interfaces remain started?

drivers/hid/wacom_sys.c:wacom_wireless_work() {
    ...
	/* Stylus interface */
	hdev1 =3D usb_get_intfdata(usbdev->config->interface[1]);
	wacom1 =3D hid_get_drvdata(hdev1);
	wacom_wac1 =3D &(wacom1->wacom_wac);
	wacom_release_resources(wacom1);

	/* Touch interface */
	hdev2 =3D usb_get_intfdata(usbdev->config->interface[2]);
	wacom2 =3D hid_get_drvdata(hdev2);
	wacom_wac2 =3D &(wacom2->wacom_wac);
	wacom_release_resources(wacom2);
    ...
}

When a wireless tablet connects or disconnects, wacom_release_resources()
releases the devres group for both interfaces before hid_hw_stop() is called
(and hid_hw_stop() is never called on disconnect, on an unknown PID, on
hdev2 for pen-only tablets, or on the fail path after hdev1 has restarted).
Because wacom_wac->features remains populated while the HID hardware is
active, an incoming report in wacom_raw_event() can dereference the cleared
shared or input pointers or access the freed pen_fifo and input devices,
causing a NULL pointer dereference or use-after-free.

[1] https://sashiko.dev/#/bug/linux-0154f73a-a980-4d2c-8f09-407e588762d9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123155138.2907=
049-1-lee@kernel.org?part=3D8
