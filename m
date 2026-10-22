Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685680;
	b=UPX6QitO70QBH+ouKrZk9Mhh4wo2bzPJkC5NwhAcHrQ/sjyqsmAvXgOrQycjtkJuLmvG
	 rh40FjLj6xQf8OvSXGL0Y9U7o7jpGyIwrK1Lkaapo3jiQkFBl75LbrSDdSBbOv6kl1KFI
	 QwOcGiwEyQLz/AAOcdjN7d+wzFmofJ9ti3EImOU830nKk5DhUpxyvTnpclkj07BUxb3Sr
	 EQ9wGs5V2zc58qLWLkAowM5xu8Vg3KWAXFecmRQ/I36/PNtRM9Snv6o6Z5U5XLei34M+6
	 AkqJWO7R4H/C3/4L1F0pERRAwk+0G+cZgI/Cu/aW+G/pz7mBo2iPl/mjg0QLjvKs5/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bNMW3PNHa9CwraPOyiE/RuoP1DKfaXX3qWqLQcS3sgI=;
	b=IQVid6nk0EgSkDcMBrI1deUOtn02Zr4BnDXvdGsC9bo9ZEv9pIV1VtRSPvVK17CbCKfV
	 1qyl2pYCT9rwL1pgNvxjeLIhT75D2t9dUhbzXWd96l3sA3s7y8NyaQ29LMR0ukj2MiN6f
	 9G7g7W5aRCfshucm5F7cWwL1MizRpW8kVKaGg+X9kncVkXw5uzI++1LhInH9XEn9C6kMe
	 5UFdxveyZ/tq5t2vrTRzQ0Vy9lmye+fJ4IEj95GqqSZJp85OjUtHVvHwVSJO4jzDd1smu
	 H5+byNHRtUIMbcJ5NcKSPhBiNQ73sGgWjLBPVFbaYEUpFsRaTyV7gbkMJuLODYLn59g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dMJWgAox;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3A606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F3A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dMJWgAox
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917c04630c2so461866d6.3
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685679; cv=none;
        d=google.com; s=arc-20260327;
        b=CJZMBff+Wfdl3nOCu6TvZQQXg/l43TZcHPqPdoyelTsVjip0UQB/iXjjvtgMSfTdVj
         kVoXpTXpVk64bqSl/rYkK++7USmNlrJKmTVBmaHlqMoGAevLKwurhxGUSc01q+fTm6+6
         SwwDlc233OYT54G5q4wGd/tgAPUM7zOkwpfsZo/qeDu214Xgd4F3QSwMxqCgBF6dKL8W
         l9nhQI8NlqXfs1mhnMmXleABIfFr6O2p/I9tewhmTFlKy+ch+4+aJc7dQSF9a3k6sOHi
         gpLAIbrnmzJBe3ZPSsl/53ShWyJdPU0ZtP5qY+Bu02tocdP74eeLEGFxrR78WRoE8vgd
         0RfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNMW3PNHa9CwraPOyiE/RuoP1DKfaXX3qWqLQcS3sgI=;
        fh=QiSPUgIEc2gMOvGSJROTXMetXFzoc4liGcZwAvBow50=;
        b=f6LGJzpUKX+e7DR5ZQuvrkYDpble0Y3o4yXsnrm17xK8d5VDqAOoX0ZLte2ij8+ZKv
         xdoH6gVGhLNbN/m6Y4DVVfvlMnsnYkPpZWEmnbpg5Q63WonnMaurAH59CT0dGwGjHCiJ
         MYm+S3Vjzc8328UlwFTyuf5aVTWadqSBKgkspEqKPgM2dBavHok78xpg+7V1ts60sTvE
         YsEBYrSHMmduEw6q18nDxMPbYPCsIQZLH1FZFlyKgcCOWnmIQgm+QuhXXnoEY2gXAvzs
         KvTjL9TS2DCxf5QapZnM8L9H2OkcqjUvftcXDUciQgPzTMQJjYzos4zNWu3+0dtHfUnk
         l/5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685679; x=1793290479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bNMW3PNHa9CwraPOyiE/RuoP1DKfaXX3qWqLQcS3sgI=;
        b=dMJWgAoxu0rDNa/c1QvDOh4AGNc9FFzDfH5qP3VMBsCuzWJmGhclaPg/jSq3ejePlt
         Q6FEsLtbFLlQGdVsWrSQHVcafw1I57mJZ+lhRJaM1x/mFPpL+4bnY3iah4b/LTWy76VB
         Mv6Ogh3C7w9cBoHqAg9ex2oaxtZnfBqV51vqp2Wg8TxFzZNE70Xo66rjB/CLiigWDMUy
         YBv7KjirVC13CWp88B31D6Ap+iXSWvcMWWP6yi6noFDtRHzfD3sp142rDAPnT8V8W//K
         PWRkUux1A4CKUYJqrjuVfO+ierHwW4/119qQraRcXVRg519rUjkmP0q6EgAYYSOHlF3A
         9VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685679; x=1793290479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bNMW3PNHa9CwraPOyiE/RuoP1DKfaXX3qWqLQcS3sgI=;
        b=HH/xCPf4KGtaGkhmNZ4X7Evd6itEpmB+2gpno2nExrB/r2929ZsDtWr2nlzLG+ovLY
         ABwM27B/WcmV3IIC8DlhBcuBYoG11n+zeKQpR+6iQZtnel1oHtF/kbtEtncQEzWvWyj5
         1eIrGEXPGxZwFfvhjKQ6EBoMr8tUbXmyEUctV83gNwg8rU+cA1XYPfzhNMODP7H1XyKF
         7NG2b9visdUlPyr9kavOZhKBzLatZW06J6yKXXyVX2S9jNxT+FG1TRV8eZZt0aXnmU/s
         8KFflNptdFPPk6veN2aN9s8i5n9R9WTiB3gEfrjsNjdQ2EullCC53TJQTwP6E+Dkts26
         G3zw==
X-Forwarded-Encrypted: i=1; AKwUvBwP/LaMJAGOgwDGNRTdhpk1d+vbfSPgWrrX253k1r2nBgQ4GGPEVG7G53agJH95IOaIErv6ldr/+iztlw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLHZPiBNDRimD+ZGjvomLhfCKxedSKgf0yrc2zWfwx7Ei/AyKzg
	WqLsZZSUpZ8/7LwXHv+pje26jq789+mfwN71sJYUjDYWuApl7faLPcXQy9KE2BHe95DYVgVPfWa
	76wMQPwe1YqNdw4Stn8b2aVL13WkFgQk=
X-Gm-Gg: AYBFou0MIrlWpZAS6CGyY5xOK7poh/ukyr2dcNCfIMehXNvzTvv5dfjR2puAKJ2PwTI
	Q0ZJfFu6vmCHSkEgbP/Z3IjjnieT5eeCU5+JOQEgg+U68U6IaIbdhG/qI1/0XXPwqwRDF0v51+v
	W1TV6yBuBmyHzw8wH7f2kaSMETyknE7CVMFu68E3HsP/S+pgE1ahSn7lyUekuWDPq6fyIn2xCZW
	bCGa/TvmkLFtsLvAOF1KFK0a8kuSDXfVXdlC6TGPf4s3SvUDQeyWukB9PR80pbNbXo7rJBYtDBq
	3uAnU179Q83yOUjvBc8egGhWwllr0VldjEwRLLknBO7TZWpzb7XZTcE+TpiAq5PbYA/Q0YXmv+V
	0YlhlwUPXQM1PHugkYCQ9XEAEaNbhAqDqOeCS
X-Received: by 2002:ad4:5de5:0:b0:91b:de10:e9bf with SMTP id
 6a1803df08f44-91c12f5e5a9mr96702306d6.50.1792685678470; Thu, 22 Oct 2026
 09:14:38 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017061920.3781644-1-yaojiale02@163.com> <400db63d.18c9.1a148cc2351.Coremail.19888972804@163.com>
In-Reply-To: <400db63d.18c9.1a148cc2351.Coremail.19888972804@163.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 22 Oct 2026 09:14:27 -0700
X-Gm-Features: AclHuK9yTpMipV2tQIARoLqeOFyl50wW-stz4jFoKTdjbJHatzhq9G183CNvSsQ
Message-ID: <CANRwn3SZqjHd9ezRw1_=DwLNdEdg5ysRHXPWHvLRzTUCBq7XtQ@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: reject short input reports
To: jiale yao <19888972804@163.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 12:38=E2=80=AFAM jiale yao <19888972804@163.com> wr=
ote:
>
> At 2026-10-17 14:19:19, "Jiale Yao" <yaojiale02@163.com> wrote:
> >wacom_raw_event() passes incoming reports to the pen serial extractor an=
d
> >the device-specific IRQ parsers before the HID core validates the declar=
ed
> >report length. A short report can therefore make either consumer read pa=
st
> >the valid input data.
> >
> >Require the complete report described by the HID report descriptor befor=
e
> >invoking either parser.
> >
>
> Fixes: 29b4739134c7 ("Input: wacom - switch from an USB driver to a HID d=
river")
> Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial d=
ata for later processing")
>
> >Signed-off-by: Jiale Yao <yaojiale02@163.com>
> >---
> > drivers/hid/wacom_sys.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> >index 40770affdbde..85e966e80012 100644
> >--- a/drivers/hid/wacom_sys.c
> >+++ b/drivers/hid/wacom_sys.c
> >@@ -175,6 +175,9 @@ static int wacom_raw_event(struct hid_device *hdev, =
struct hid_report *report,
> >       if (wacom->wacom_wac.features.type =3D=3D BOOTLOADER)
> >               return 0;
> >
> >+      if (size < hid_report_len(report))
> >+              return 0;
> >+

This seems reasonable enough. The hid-core.c:hid_report_raw_event
extends the short reports with zeroes and then processes the result,
but that's not safe to do here without making our own copy of raw_data
(because we don't know how large the underlying buffer actually is).
But copying seems like overkill since I doubt that our hardware
produces such short events (based on the lack of reported irq function
misbehaviors). Returning early seems like a perfectly reasonable
reaction if this ever occurs (e.g. by mocked-up uhid devices or usb
gadgets).

I'm slightly hesitant to give a full reviewed-by given that this is
just an assumption (and one that we can't reasonably test given how
many different kinds of devices might be impacted), but I'm happy to
ack the patch.

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> >       if (wacom_wac_pen_serial_enforce(hdev, report, raw_data, size))
> >               return -1;
> >
> >--
> >2.34.1
