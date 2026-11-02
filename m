Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655151;
	b=yJVUZ5jK8DhgH8VqASSvRzNb4+UZz5pLaGAF0lKc6lSNRuaFjf+DJHpBthVPb6hM2nI+
	 a3AtXHp9rOKOrD4Gt2n0O3ZCzEhqLe71oYT+sQHciPXl7mOGsM63nfFaDPN9/cznuPlEL
	 gLogO3fVrZRrxUXevHM3L3C5yk9zLm8EfdSU4fjtMrtdumPM58uqSlksmhqNoj3Xv9C5L
	 y/fYwSEKWAvbs2bY0CX/BbXo7k4zeFTqsVThNdpze17GOPcB/ap5nsCO1joOCiQRhMqEs
	 NBVar8ShsN806QOhToegzCzYM1RbD6+hjGSW+pYnrUtnyFaGsGRU+DbdQ+n83sPkw3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
	b=qp+SAY4BZNbwJ6vyXGd+k0SjByj5MfQcu1oOAipS61wDWkJhOLmvvttwfweSjEKsVU95
	 nFwynuKMppBFOmysbEQxfBpRzsCs4I2JJ9t9YX92LAUwZZMJZSsgCGksx7+rYuxXqZstD
	 OvNdZQB4wNg+0DE9IYcRPC4v+WaG8A8J6cqUSKsu4WAe14Ap4+WqcyBpDvc8+IXCGOxDW
	 NHr/zTBFFlgddKOg+2+3vbK0oeDVi//sOeJTleuKLa7PInBwFlD3QJEJb5Hy7V4M0g6CF
	 bO7ySO2GUta42vXhXPENwRkJGQBtpV4zp8lyoOej4bWgvhb04EZTOEHY7Hjp1cafQlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJBl9LUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC0606A329
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 21:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6FC0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJBl9LUk
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91befbcad6dso61939866d6.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 13:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793655149; cv=none;
        d=google.com; s=arc-20260327;
        b=Fg/+UAhAmnHsDziPB1itl6XWxinAbChIh2nwBz8ju6eGvRnFjCwIf2lQ/tjodWIxdz
         o82XXEG20HfB4MqBNINnGVsnw0uzGz/Mmwy+MpfULE/a1yaY5y9FcjYoPoBghA10FdZu
         u8bhKBT5lHUWnKwNTeqLwcNeXjHT+I3HEuQczr7EfHS4mRlVyIF7WvyKd46iy6LEwl5O
         vsx6u2mXa5ZL8ZOk07UZ0gii2QGdkAifRlngkBDf3dZo9zHyLT8M/hS4hiyBEfPn8kR3
         cZ9woy5c08EN9Y9P0tvSkU3FTXemvoRxplGDufcqKw9i4GIvlQGvq95D4b3TtddhSefR
         2imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        fh=SRmO4pO8VF+uL8FvoYqQiO4TG92QyOdmQmzeKm+zFfU=;
        b=qgYCGWSYPKXW0voMOWzrPzqVbUf+zQ2HuFkRzF5cKp4Vam5e+0uUQ4ICcha9mladvK
         6hTuEK5okcNbnHdg67SFkmFrvg9A4KcSO7KqFP0hk9BFiFkiACgL7eWP94SBCnG/XRL4
         RrxOWKNRoXdal9lXdQM7D0b7BgWJ276OZt8viRJ/KwOV6BLdDIkA+97gr4ZD/+9FkiDc
         6JRjvssox3xcHD3hbIBp4U20Ga8OnM2mpKm/ODPcOZv8kDnO93QqNTtpa5v3QMzXyU2J
         00AtujJTKtsH+jIP0KBjIsDUYuEiC5B5WOEBqlo9jxZzh610dW9jB1LaRans5+CKS9Y7
         U/Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793655149; x=1794259949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        b=OJBl9LUki163v7WEot8KNBkz+ZyHxB3U3PZWOzUQnqU1C9gwNWqMqo4ep2zJTiF76E
         H27U0U2Y2xU1edkWPvCXKNlTdh7FHNvP6iPCbdbi4N485mFhvwTigF1MWvhKjB3dtraS
         rVPVpUnl8PFkyNlD5j8BF8pdDkAdWyttJ0cI7ax1saMKaIKfFduWLBkxscuo7Xjswgmk
         KWgTFFt3DNYb1YENzHWh81+7DLhh4cD15nS0R0RZswSSg1fEUniAiObyXCdPXUw4E70b
         LdyxMtqanpWwzAvoE/TOYetmETdsu/uLnQujF+lPJWE/HBU7sdTJaZxo3v+UlCUj6GfD
         Y9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655149; x=1794259949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dy/3+y6cTy46fWlcbVMD558vn7aro/Q74xHtkgWN7Dg=;
        b=wky3dl4crKDAyD6wJa5exKkYVjpPfjiPWO1Pr4VWXyPHfzZUxhhDYTFpgE7Ds0FYp6
         wfZbhf23IOO4JBl9Lk7uiwtFObmDUBSKV0eVHLKZHgIK374BmCPNW9kRCEAAwcH0DhTU
         NYiYv0MjGy5sOJ/rZKiZylTBHCMB6drux/Q80IgG5zivHSxCCor0+VrKnlyRUKsajuTV
         5fL3IMz0/ConspH5VkYwKR9LeGfWMdjeCeS0+3riHpYCKwT1KihNSIpdF3qMcIhw7+j/
         zgmzt7e8d6XEibuX0pfJUQMIa+nn5c3KEE46ktJWhPGDZ6ZTcdQJ+dJlTaBsmbosGnMs
         fFFg==
X-Forwarded-Encrypted: i=1; AKwUvBwXXiL3hEZ9af7wUjXhDp9udXaVOwBJxR7UMR4FLPwFBz7KwUUwc3Jwdna23Fq+BNuf+GwTffwTCUWMGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3L+2I+0vOWmtT7yaXhSj+ZVH8fix1SNARKoED6ioQFW02qdaY
	n58d7lGvF3UpoRBjj0wIhOJePOXQp0rNodgNHIjIHzkcmdIHMB13hyNPy0rpKgn6rDnGHxSTUUs
	VsADpjhF0r2sv4GZ+SgvTdh8qD2uDG4Y=
X-Gm-Gg: AYBFou0iuiqtIbKufJv1DV0uSNsFiAjFt1oJLfff2l5uffgvghSekhMckfi049uHkFH
	ALAgyq+tIfbLoGDPLT5rNsKfUmictkooBwOF1hl4mMOfRbscYYXmSIsLz4tOviGOlwrB4xLoV0R
	lbB/Ia8kLf9EfcdTvyHKb6W7k6FxxlAhNB7sPcCpszoIjeg7K48dZ7Ui9rw0/e6nNNxYIHVp3+y
	3un4+t06Gjqmi71aZjosENucmWe7WtjtgMLgZuhjkblXiRhGb/TV/ynE5y9y1LqGT4Qt5ZfhwXh
	DInLQABGGMh+FJT9XwanF+vhdYZFu5uEcKM5EIOlwKDS0A4h46JsYSmkhGII06hisUAX1Ylf1cL
	zYrDdouzXPxPpZYGs5LMmDsohC6gP3T36PrzquWi0wwOjvZ72xK+uGShluQ==
X-Received: by 2002:a05:6214:2403:b0:91c:a2b0:dd0d with SMTP id
 6a1803df08f44-91ca4ae1111mr177407566d6.17.1793655149330; Mon, 02 Nov 2026
 13:32:29 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20261024033040.316652-1-jinmo44.yang@gmail.com>
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Mon, 2 Nov 2026 13:32:17 -0800
X-Gm-Features: AclHuK_Ep6UP7A60iM8FcMVyZcPHYDAlQGKDcoV_PVYPLMetFNaYY3L4D27BGc0
Message-ID: <CANRwn3TaYNa-i-c-1AOdPb4HVS8otBhFUkFbMFPnwzeKKwHcBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on
 successful probe
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:31=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> the corresponding input pointer is set to NULL but probe still succeeds.
> Subsequent irq handlers dereference those pointers unconditionally,
> causing NULL-pointer dereferences reachable from a spoofed HID device.
>
> This series adds per-function NULL guards across all affected handlers.
>
> Changes in v4:
>   - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
>     NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
>     suppressing the spurious input_sync() the old "return 1" would
>     trigger (Jason).
>   - Added pen_input NULL guard at the top of wacom_intuos_irq() to
>     protect its helpers wacom_intuos_inout() and
>     wacom_intuos_general() (Jason).
>   - Added pen_input NULL guard to wacom_bpt_pen() (Jason).
>
> Changes in v3:
>   - Fixed wacom_dtus_irq(): DTUSX is pen-only, so do not require
>     pad_input for it (sashiko-bot).
>   - Added patch 6: touch_input guards for wacom_intuos_pro2_bt_touch(),
>     wacom_24hdt_irq(), and wacom_bamboo_pad_touch_event().
>
> Changes in v2:
>   - Restructured per Jason's review: per-function checks for dtus_irq,
>     graphire_irq, and the Bamboo handlers.
>   - wacom_intuos_pad() returns non-zero when pad_input is NULL so the
>     report does not fall through to wacom_intuos_inout() (sashiko-bot).
>   - wacom_intuos_bt_irq() guards both pen_input and pad_input (Jason).
>   - Added dev_warn_once at every guard (Jason).
>   - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).
>
> Jinmo Yang (6):
>   HID: wacom: check the input device in the shared report helpers
>   HID: wacom: check the input devices in the legacy irq handlers
>   HID: wacom: add NULL input guards to wacom_intuos_irq() and its
>     helpers
>   HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
>   HID: wacom: add NULL input guards to Bamboo handlers
>   HID: wacom: add NULL touch_input guards to remaining touch handlers
>
>  drivers/hid/wacom_wac.c | 127 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 122 insertions(+), 5 deletions(-)
>
> --
> 2.53.0
>
>

Apologies for the delay in reviewing and responding. I'm happy with
the series in its current state.

For the set:
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
