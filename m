Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAE36C588
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776691; cv=pass; b=dZSHWY344vo+QyCZKegYqbsDd511IuUVOpk5sYKvtH3avGvUPtIc7S/jAfKLJuXrBEIVBM2ij9zk9bhkhsRhimNgvveC+eH9dTkRr+lK44wKTjY283eguIPi7p0EKkPD/bx5BMPtDE01VBWlqyHwnCutYAbNM+xnVrEkYCorLHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776691; c=relaxed/simple;
	bh=yaRchCT4lL36YqyiyFmzkap4LUIzavYu8Sb1W3l3aq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg+eY56o1Nt4akKbd9Elv2LD+MyB1KfwhJgX48LPZaYYIXPr4HW5EBaOdb0nKDFJTOaw4P8sDlIybsgv2pkdo3xeXJ2p1D5EufRFW9pH315t/tLaxec6f42yfKLvxFgfDzS286sS2u0bZ47tl9ct5c2+MgpXOlABVQQ8+QyQuZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js5NGkoF; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js5NGkoF"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5069df1dea8so71088461cf.1
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 21:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776690; cv=none;
        d=google.com; s=arc-20240605;
        b=LIW92cl1a3IwWcnyBCplDS/IphHLZ1ij6Xyv+HrCDN6GYrKUHmsb3+b87nq2NYnTY0
         cGuiUQ4orLRhyOkItcU6PZhfYjdS9CjSbYcRWV/8txdc5+M4ZTWI8h7N+AlGAPaXrDpR
         1pAIorJqaRVIQZIqFY+oPc2HVAIiXAmI9gAJvkh0Tq8QrMPDWF6dBZKtKeYCFSs/h+TS
         tPys6+iuKAFfpjDbz4IF8F6lmpG3iHU4eDCVDExQEHwVjWRkMv9KO4D4TroKG9THNakd
         OXQnFTnfudtQtigpTwzoVpNTglKxekz72Cs7skoMstv61BZAKXj3uLjUYlFgfwed+f68
         8ACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfrVeqa/RN26FcUcewU6REsrHn75vAdV+88ugPVAqFE=;
        fh=pnUAYRg1rS9sBpSOgcxw/0xggQYW8JMoYmvOOJRxIMU=;
        b=M3dChF3/K4Niap8EcMpG/eFv4RPSNMmt4mdv8d1Xi9vPuHm8Yg3YURh1o48hMVYxf1
         omi1T4JXW7vtl8DcXOSi7yxg4LluOJFVVgOPJLrkRVQQFYRcRksMNUYu4+RHYJLHMBwo
         tnx6t9ihJhX2qgbqlyDbr9U48XnJ9TEANBXauBw1NvrjaZ8f6cCWRMExqQHZ/LM78T/z
         oxyBukxZwOxqNnayIFzmEc0x4SiJp6/mz8akaygBBVSkixn5TOYJzw3FNkjzR4lgsefd
         7Wxeg7aQYbxcZpFMGsMSLmC2p4kXeQXOC4HwZw3MCNFzNTy93Cymd2JE1zEkyEZ58IMG
         RFMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776690; x=1773381490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfrVeqa/RN26FcUcewU6REsrHn75vAdV+88ugPVAqFE=;
        b=js5NGkoFbHbVcT5tdXsRDNQkAV+Qgi3S0SzmMyQGs6LYYoTG3GcfWpUtV+/+4/YRr2
         y+QlRGUZ35+Mgd0yxEVBgZGSRMyCQd7qIKkHXEqRDVeqsMAJPXKrb556/Nn6wG2cEMhW
         0kr3P9NfyAKgz+uS1PIBKQ1DH0NIpT9xXd9OjNDjemsTx2eZ7JoCKX7BdPFlbl9st1lr
         fcYWFQ3UvNwCjxHFq1GZ/2+7IQKQXMyfClNsuiABuSFp36H1jzvCor94lYetxoHHI/8s
         esBk9Oe8cLLfi4s59z31NCY0gPSRC0zP3/TUaWt7yEDszTcP8qATIfqgea0O9S1XXkfk
         eqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776690; x=1773381490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfrVeqa/RN26FcUcewU6REsrHn75vAdV+88ugPVAqFE=;
        b=OhdmpJikc6IKe8XEQ9o7Zy0YpguM2/K80FdaueOguzaxP0a/ay45wq9MjV+zyj8Ctq
         5e2J4tgqmIOdy2FAa5c0kPV8NltmjlocTOFMQq6CM3ePiQg4Ty7wG8kaKVCwRcS+HiP6
         iyKov1HHp+Xd9eVeYRK3q0IspViiYj7ntUJY+4ue3+movgkqLVIAcwRtm2pjoUr801dP
         sJoDBlCoX9dBGxE0IBYAXsSEOrDquqIL7AxCM5IKkZEVLs9OfWY+871gMJogVXV6VRHg
         3je9lvFeIPVH62NO9dJ6v4fqt1qRGlsS7jiZ2BwQso4ZujDjDAHt44kqXju8GgnUuv8l
         firw==
X-Forwarded-Encrypted: i=1; AJvYcCXz3QCbY4xCOr2I7ynj7DEPjjunkvKTKA+QDyhVGoSxIw7NMHPGoMHvyah2+eFmUCv+WHvoITLWQdu9xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwMWe8nyyvvGyRpxYchXMyquAl7WrHSCIhLUJmYE+2RkaSdm6
	oONK5ESL3Mdpc7aCed/t/DvXhlywq8pwR25IJW2sXZSZ+cz6vxuMe8C970isAtrcmpp9NA1NRiH
	DiI1Y4hmn3qeVvnbOuIii/AmZEmgIiWY=
X-Gm-Gg: ATEYQzzxWENM145lA7cdwMboyMxxmQg0Y2GUxzMzf7dpF8SoFyZoRFxUidg6b5Ggwfa
	S5KCkpTbR9uNtoVWp+Rwv6QmC4qenTy2eNYgOUnO+c0yPYuvpvwxhpUnQcuPWwMTC3vn4DKEsgv
	ggATWSoIizdoVMhKXUwxQGGx/HSBp8ZvOJukAX4ECs4Q2CF8Afm2QSdVxqTs8mJxOk98SNdhtHJ
	+6FZj2S3BD1SIo5F1WK9mwoWcx6b7fQo9pQ20GlRVYmFfa9fsp39ZUP2MDHiHlM5BvPAfC+sOTP
	39D/tHZsD2aPZtpYuA==
X-Received: by 2002:a05:622a:4ce:b0:4ee:146f:2502 with SMTP id
 d75a77b69052e-508f46f9264mr14540751cf.25.1772776689742; Thu, 05 Mar 2026
 21:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227205444.1083103-1-ethantidmore06@gmail.com> <20260227205444.1083103-4-ethantidmore06@gmail.com>
In-Reply-To: <20260227205444.1083103-4-ethantidmore06@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:57:55 -0800
X-Gm-Features: AaiRm53EZlakvrAdlHSkNqRJ2oF3Wp7bKOVlHqwDitBDs-8YkuOgTNW7OCcwAQk
Message-ID: <CAFqHKTn0yu7h7hCy_LjR0_kX_7Gn8kGGoZCOga3o1-ERdPGkYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: hid-lenovo-go-s: Fix positive promotion bug
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:55=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmai=
l.com> wrote:
>
> The function mcu_property_out() returns type int and returns negative
> error codes. The variable count is assigned from it and checked with
> (count < 0) but this check would always be false because count can
> never be less than zero as it is size_t.
>
> Change count to ssize_t.
>
> Detected by Smatch:
> drivers/hid/hid-lenovo-go-s.c:583 gamepad_property_show() warn:
> unsigned 'count' is never less than zero.
>
> drivers/hid/hid-lenovo-go-s.c:583 gamepad_property_show() warn:
> error code type promoted to positive: 'count'
>
> Fixes: 14651777fd675 ("HID: hid-lenovo-go-s: Add Feature Status Attribute=
s")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.=
c
> index a24737170f83..4596c18037a9 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -573,7 +573,7 @@ static ssize_t gamepad_property_show(struct device *d=
ev,
>                                      struct device_attribute *attr, char =
*buf,
>                                      enum feature_status_index index)
>  {
> -       size_t count =3D 0;
> +       ssize_t count =3D 0;
>         u8 i;
>
>         count =3D mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, =
0, 0);
> --
> 2.53.0
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
