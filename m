Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EB313531
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435599; cv=none; b=ej0z+I9vFaATwRN8yKhUBNyNETt4cdwl7h032GJoarWUsYAYShp29Xy5rIDLAvfAhYdtp3RE/9OrGd40vTiEFNEkTbkkerXZmG0W3MBIMhX92+BkERFpdI8UmQnQaUK58wpaDmsmslpjQu2Pqlq5NoBg33ScISakQ/lkxLlPuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435599; c=relaxed/simple;
	bh=Vj+5WHku7LYr6Iv9wMUcef/1WskNu4yeZcbYtJXDzmw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QyvYuawGIh8C0VvGul4+faEpQA1mLGJaSKk708rlVZGOg7WbL5Yhs1R1AD/jxpec5ZipVnherSuSoxtQEqH7ERFUBeCPj1qraK7GFgiJBs++7jkh4Yb1c0iYrWrH0t/fPmz47rvEOWK5NXj+CuedwCep6AAGBNco8IrhAMT1or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWvm3DWQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWvm3DWQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-480706554beso47291975e9.1
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 23:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772435596; x=1773040396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj+5WHku7LYr6Iv9wMUcef/1WskNu4yeZcbYtJXDzmw=;
        b=nWvm3DWQW/najdDpmWhP7Aoh3twqVg8SuVj+a9dD52s+5v1pn31xjyELUT5f/LgPJZ
         5e/U56ayaMOJa06yJKWVTQB9XXV7kvuygRM/8rbXWnubGr2F/daI7UDviQAfOa+KOqT2
         Lo0SwkOXdYKyd/RLWj2NaMEp23JdLedDMEC7+xZFGik+BXDanAfJyKjXCgVO9vxA6SRP
         b4sr/jKU7GU/qBe6uuxz7SDlzHsTaWrkJ5ltVkT8rloW2KSF+MByFuZQFRM1SBbeqJAl
         11ogbApa73L+jIwVrSK10eMdSTvee65T7d3bGIWe/hfFh5o/UvxNfRunctk+VdrVOk2E
         0N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772435596; x=1773040396;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vj+5WHku7LYr6Iv9wMUcef/1WskNu4yeZcbYtJXDzmw=;
        b=UXFlI9givNmhk1tp6rQyvQVse8d3NOetKWefbmgDfTOy3KLv0OT7PM4cGsYBh2W0rw
         PrTrPMaoQGZwBiS2bGxS4e/oHImBvz59VC8TXrHlyoByVgTb5rIGG1Gtd5Hfi39BZkNC
         h5Es889Q8doeamZMsOJO6/pS76FOqyUOqOXcKLmlfl+X90mkgjM3nyaGz0JIHbaPF0Nt
         TAqLnZznHKZB3aG6RqtLrqFM7trIt9VYbgKZPdab5iK238lb+POMj6jhXqCm5BACw64y
         Wlz8ptJjs7MlzdYBwR/a6U2qTXsmEIcGsfFjf9ZxH469AjoZ5NLAEuiTlIOL+jB7oKSS
         uyPQ==
X-Gm-Message-State: AOJu0Yw0xjPwqp+mEL9KMs4ITT/wQTIiMUr1kahL+YC2pmYpLrw7z/m9
	E8ZDoUTNuIqQAvOCYBrGcwyA880RqmZrcjqUNwPo0Xko8kvA26qPJdslfa2tSELI2z0=
X-Gm-Gg: ATEYQzw8c+1nKLh1SmB5DPJHutbK5Z9Gt7Os+IRfeScj39LqHA+FKf510tp3LcfC+Dm
	W4ww6tvs3rRox0NnMi4mU8+j+MfZZ8uz1NX6Dz51FmIBMsKQR7D1US/OwBgDjf7LEV80LSTqntN
	g3mnwogzzDd+NS8ZsjuMK5dNKHwLy4aBNR5idB1w3h+oY+7eR1DTJpmKb65eiquWvjyxSNplUD9
	X6DwHy3v3LsKOL+jamzbgq/TDoGpmkwBYg/iW7HWLf5f9ZPxmE222vW2X2P8ZA5zEjRJJ7bj+AQ
	KJQXkIQ24CjZtVhn14aciQOeDuOG2Xz93BWclyYzpQfLEG1gnoP7rz9BpzgE9rpZbjc34RQG1kp
	Ms2RDxRLKICIjbZYotlepFQl1758mZx25ixIvi7noc+XLEk9QAK5VgzuISVpFH30pwPUfdsTuml
	ks8KhgcZQJ2sNp/FP6+1beZZtF3zI=
X-Received: by 2002:a05:600c:1909:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-483c9b545e0mr213405235e9.0.1772435596159;
        Sun, 01 Mar 2026 23:13:16 -0800 (PST)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84023sm266616995e9.12.2026.03.01.23.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 23:13:15 -0800 (PST)
Date: Mon, 2 Mar 2026 07:13:15 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Message-ID: <6d62bdf4-192a-4de9-beac-71f9a865d233@gmail.com>
In-Reply-To: <aaTYvqdymKquoVWJ@google.com>
References: <20260228195258.2468296-1-objecting@objecting.org> <aaTYvqdymKquoVWJ@google.com>
Subject: Re: [PATCH v2 1/4] Input: elo - fix style issues
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <6d62bdf4-192a-4de9-beac-71f9a865d233@gmail.com>

2 Mar 2026 00:25:16 Dmitry Torokhov <dmitry.torokhov@gmail.com>:

> Hi Josh,
>
> On Sat, Feb 28, 2026 at 07:52:58PM +0000, Josh Law wrote:
>> Fix array constness and spacing issues reported by checkpatch.
>>
>> Signed-off-by: Josh Law <objecting@objecting.org>
>
> Why the difference between From: and Signed-off-by?
>
>> ---
>> drivers/input/touchscreen/elo.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen=
/elo.c
>> index 434b9b47e964..40ae132cde21 100644
>> --- a/drivers/input/touchscreen/elo.c
>> +++ b/drivers/input/touchscreen/elo.c
>> @@ -257,7 +257,7 @@ static int elo_command_10(struct elo *elo, unsigned =
char *packet)
>>
>> static int elo_setup_10(struct elo *elo)
>> {
>> -=C2=A0=C2=A0 static const char *elo_types[] =3D { "Accu", "Dura", "Inte=
lli", "Carroll" };
>> +=C2=A0=C2=A0 static const char * const elo_types[] =3D { "Accu", "Dura"=
, "Intelli", "Carroll" };
>> =C2=A0=C2=A0=C2=A0 struct input_dev *dev =3D elo->dev;
>> =C2=A0=C2=A0=C2=A0 unsigned char packet[ELO10_PACKET_LEN] =3D { ELO10_ID=
_CMD };
>>
>> @@ -273,7 +273,7 @@ static int elo_setup_10(struct elo *elo)
>>
>> =C2=A0=C2=A0=C2=A0 dev_info(&elo->serio->dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%sTouch touchscreen, f=
w: %02x.%02x, features: 0x%02x, controller: 0x%02x\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elo_types[(packet[1] -'0') &=
 0x03],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elo_types[(packet[1] - '0') =
& 0x03],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packet[5], packet[4], p=
acket[3], packet[7]);
>>
>> =C2=A0=C2=A0=C2=A0 return 0;
>
> Thanks.
>
> --
> Dmitry



Sorry, because my main email can't send emails and I prefer to use my objec=
ting.org email

V/R
