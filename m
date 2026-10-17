Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFE1DA57
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195551; cv=pass; b=LYEek74+ShKd/YWRiDgGbLCDIqjZeYTLdtp18V6wOGwC1aKHI4MhGmVY4FkPzLRg1sqUFQffpjZwdf/mAkLDU0WNHOLEYNdqeSWfCp0WyIHUDiRS862H4xwDpcgtzdOLuqyXqLINT+q4D9CjEG9a8rsYIKqeDVUun+BxoiGLJyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195551; c=relaxed/simple;
	bh=7sGdRH+GOCeIbPggafCtteXnjrkYq313LLWRk0dNvSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WytKvnth8fCmqCFHAiBX9bKF1InH3E52E+wnshC9uRXnLtJ7gfQLYPYeEUiA3vBCz7UFw9fV0zdzD2yPV51sFIb3biRPRRtzk6KUPY7Yv1ZDPKresNvYqfN3b7sGw6kcuOD1aymcp5kI9++ocyettN1+3ggDu/SgPPv3LySkpOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g94BXGzc; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g94BXGzc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917b78dfe30so6713736d6.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195549; cv=none;
        d=google.com; s=arc-20260327;
        b=F6pMMVrr+kIITaHiDXrE6IJouApwr1waY7JsjaGgnZEIjFFE/NcFt0MobGi2gFcf99
         yhGOF43deR5dNvFZlHjcpM0mi2+FGdeP56f3hIo43juRd+wwdQWT79VR+r7wL5sdqquD
         qi+sHRCUWvcwvXF5Sdv0qcJc9YvOVCsyZ8Ew7pQwjyOnkdo0kvamCp+oPJ3LnpWuYHm/
         MIt4yeM+rnExofKZhbDG43v8sx//BEC+6jFxT6WgjIGU2LFOGgmSiTGl8ZJiEUNuESBL
         xOCfHkp1Yz4/bKwSDfVThow0AKtatA3EGlZe5giXfVoT9tQwIRitiCRTKcSsv+C/HhP8
         K3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSA7UZw2c3bTiGnVzwM29+KWNJ0lb+yekyy+zeNvwcQ=;
        fh=BKUemsgkYMFoxpqFMjWEO+/oKCB7CCuZ3EBYedcDbWA=;
        b=cMMAJJt6lZ4FTw+/uFXxGr20oSDpQned/HO4DY8eeyqvJHf6zMv3It9nsvtjCxy5SQ
         lXLhrU6KYoZxp7tzfwzCd2DgZlzCASDV+th4pdi/GKspR9ixf7++lNzHBcyECc504Or/
         P803D5K4IKIPuPDik7y3e9I1FinuBp/s8IvPp6fTFIEiJLk68IUdIr6P32NjBvGuNAQt
         k1aoDEIMqzSl0yb/CypAZgZzErOHHLp4Gbbovs2mkKqlaIoSW0l3T24CNz2EUDbu3iBT
         Gc4ngZ7+3D4oJ425ge18cK3oJJ34tS4xvg05CSbBzP3+JCMsBvO9CMqlCkR0h5NSjptM
         7AiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195549; x=1792800349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cSA7UZw2c3bTiGnVzwM29+KWNJ0lb+yekyy+zeNvwcQ=;
        b=g94BXGzcUfM5/h0F5vseQpt2i9AG2qoz3PGxqBRBXzYVaNnvbThmks0kglshNXu0iC
         qFBIrP47o0JcQv2WBGCxyhsgIVMKETdpA9435HpOr9H0bLvQSslijfOaSLnSNk3AZduL
         K5z3UEXoztI8TJ8Db72ydvIjep1do7WrSC24e19pnPlSYoAVFjbY7ZxLLW0+KGIAZJ+H
         r2YM5TrLbAXa5tce7qyhdpnwWao0Kybsy/fOn/9GAWgaePO3zcpFf2BLwCr/vk/L9cg5
         aNuyG/uqEdEuUCz9fEJ2P705DXOilz3JAtfNgHhA3zEy/H78xSsULVhnFLhNy1GjekEQ
         72wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195549; x=1792800349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSA7UZw2c3bTiGnVzwM29+KWNJ0lb+yekyy+zeNvwcQ=;
        b=QDy3bV+yGCfpqABkdDXkW82cf8eKF83RE2CMxUgph3Y6J6V6vHQaU94m7zBV5uQP6X
         cz4fBpGa0WpwNdBmEZpy585x2Q5m9/2xpkXIDfzBN3V/ksDctDRd0ubeeiQ7z8Y341Zn
         biy+keJGNGy39nb0AV0KUowh8RTfHvjdROa/s1YExW4llJItA2ksminZkrqDcKmfR7ES
         BsHWXXDlQe72EXHrNiKaZoK0/J+5l2Inh/RDpQA2mgFo5f16sYawrTku3ZuIoHM5Z4fn
         uo2HnusiOOG3+xNA3Bc5xB7f3BD19ef8Hc0tBT+zeSBBA1tHzVtMoSkEHRJvWEGf0t7Z
         AdQA==
X-Forwarded-Encrypted: i=1; AKwUvByRle0qYlUOjM5fOu0Go184QIOTLWQcVAMGt0WHjazo1RSITZr17g8qXWjLcLfo51UAg4CZYquALGq1xA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKW/0UKlbCmUY92p6pMtbQGvVjgHrdDYnGXDImlIWJZlcf2UsVg
	p4dPnV5abNtnLCLxdviVeco9ysLRZPR3q2qC58t5yt1Zr+d+vbyBabCQR3LPe4Ya7Q6iMz7js3m
	Wh+8gaa/c9aX278Q32wTmXIiDiMJkM3M=
X-Gm-Gg: AYBFou3NkcZkBqO2/UjucFzKp9Ixvq84VRhQ9neudCz8SHQN4UlqG2wi42Z5i6oGBoD
	dWfCRC3jQgAnXVs5Zr2t+DEWkUC9eUngWX1HfPWCUSC8M2yznxfZQwgjqujV2NnVaUumbqtgle5
	QFrFJl/6U1du1/G/r0ujto+j2Y7MLaHyFUiZY/S5OEEHLm9TcI+f9mmTw9Y5I7/R90LjAzBnuto
	V/p+V/LBVT4W6Y6hgeICt/9ZLejLEAJOJzcYmjBB1IAZBPmasJuDDjwM67drt7dKw4ISjZB5SRR
	GBmPsBZ7kmSM318a8hmPAejQQUIyS292kCOmIQhuDczBFd9UWK1oeAo=
X-Received: by 2002:a05:6214:509d:b0:917:9915:1f76 with SMTP id
 6a1803df08f44-91bdf0a8018mr27071886d6.30.1792195549268; Fri, 16 Oct 2026
 17:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-2-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-2-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:36 -0700
X-Gm-Features: AclHuK95QwdgfqCpzXo3U6esCMQ8q2bJI473RTvTkZWxw9RndnhzLiH1N68nFXk
Message-ID: <CANRwn3TMAhhsL8J43ROhNbFzp-wdin84L_+J42AD8Qrz6wKLHw@mail.gmail.com>
Subject: Re: [PATCH 1/5] HID: wacom: check the input device in the shared
 report helpers
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
> reached from several report handlers and use the input device they are
> given without checking it.
>
> Both can see a NULL input device on a fully successful probe. The report
> handler is selected by features.type from the id table, while the three
> input devices are allocated from what the report descriptor declares.
> When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> wacom_setup_inputs() frees that input device, sets the pointer to NULL
> and still returns 0 - the "no pen in use on this interface" case.
> wacom_wac_irq() then still routes reports to a handler that passes the
> NULL pointer down.
>
> Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
> device plus a single UHID_INPUT2 write:
>
>   BUG: KASAN: null-ptr-deref in range [0x290-0x297]
>   RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
>    wacom_intuos_irq+0x29e/0x3300
>    wacom_wac_irq+0x1b59/0xb3f0
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> Check the pointer in both helpers, following the convention the driver
> already uses in wacom_tpc_irq() and wacom_wac_pad_event().
>
> Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/=
Cintiq")
> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index c4cd87b781c4..177a1e09fd05 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1263,6 +1263,9 @@ static int wacom_wac_finger_count_touches(struct wa=
com_wac *wacom)
>         int count =3D 0;
>         int i;
>
> +       if (!input)
> +               return 0;
> +

Checks like this are for an unusual error condition so a dev_warn_once
or hid_warn_once before returning is suggested. I could even see an
argument for removing the device if these conditions are encountered,
but that's probably too extreme. In general, each of the places that
you perform this check should be updated with such a warning (in this
and other patches).

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>         if (!touch_max)
>                 return 0;
>
> @@ -4226,9 +4229,14 @@ static void wacom_update_led(struct wacom *wacom, =
int button_count, int mask,
>  static void wacom_report_numbered_buttons(struct input_dev *input_dev,
>                                 int button_count, int mask)
>  {
> -       struct wacom *wacom =3D input_get_drvdata(input_dev);
> +       struct wacom *wacom;
>         int i;
>
> +       if (!input_dev)
> +               return;
> +
> +       wacom =3D input_get_drvdata(input_dev);
> +
>         for (i =3D 0; i < wacom->led.count; i++)
>                 wacom_update_led(wacom,  button_count, mask, i);
>
> --
> 2.53.0
>
>
