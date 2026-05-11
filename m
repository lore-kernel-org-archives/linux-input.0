Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34F4DA55F
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536794; cv=none; b=rXLqfCyN3B0BR9MlOYcGp1xq+C6XkGNfAEG2sdae4hjd3tjURH4WCBFrqCKGRg1xe65t+Mh9FYcz7EpM/X2MthCRQlnfWrvKPSMRLJFnVreb6uFTMcXo2O8hI1VSHBwZjXKhlOChXUqiVFd/lMCjsAgONlxAv2Q0tPv4ji0KUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536794; c=relaxed/simple;
	bh=PaQlJJH+b7e+/sFYjOpkFY//rP69dq1K/SjdJHxvTMQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AICH74zhsrbOpws+WkLQVvWtldm/rE4OKwsXHNOkJRJIkCAgWB0mJs9EUC7iZfmrjD/LzBUNO30pbZNpb7Feu4cVHir83c9owbyFJGMPL1/Zt8A9Y7CK9gAbDNEfV2/HRncMFutPElyvAT6qucgw/mVPxWD1mP5dgBHtwUWLdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgxaXDsI; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgxaXDsI"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ff5472f263so739196eec.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778536792; x=1779141592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGG70aLyZXbkyXVoX5cx1ZHQlf1r1TQ7U3Duak5bUAQ=;
        b=FgxaXDsI/i/0ekIWpg/Vk42Etzl8WawW+xrFrCncL9u5bouCf15qd9O0L2to4t0uzu
         XJzss1wZ827LR70ci3KuNKNS8NOz9xsgaUavwuyYTsnxwzqRYVI434waCobWRXvQIRUh
         4JMphWOa5NVpJ9CeKWQ1St8nhQw3CCHg3+vLslz9xQyaWLnf9zqq7uHVSZXX92MxWmM0
         SAtENr+PXTS/7DGVLhEQgk2wBu7AuttPzSa7mcZWdkkAJ1UomqUvn3oC2DOW0r8nevR+
         1sDkNWlT5IFAs+j/UgCBPQawG9Mh/7iKu7+9bjwRletrc7bhP6cxoiBXlQfIJYW/+iSb
         dKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536792; x=1779141592;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGG70aLyZXbkyXVoX5cx1ZHQlf1r1TQ7U3Duak5bUAQ=;
        b=R1Z7ktD3bMuV4DoiAx9I0+HXRKQlRM4Vtc5gCQ/QVchAYOTOnTAsyYaSJ08eb+8usf
         rY2eMvsHNrNxeqTypyCcBwesTnT5vn+wjk9B4LnUdW78D/9E3anqzHpWSmn7YvbMkE/6
         2VcwTOyZy0Jyl8M8kx/y3pY+WXt47ZsjWeoo4+bZiro/R8+Jkef1SGWWSyJLzCTlnPaW
         Ui6lRPi4a46XBSL6hH79sN+ewvEznP5sNHpp5OqYucRAK39jJXOgxW7/N3uZV1U1nmqU
         WUgBNc8Ec4828w6MyECknAW6rFmbj9OpJahvOOa9SZtH5mEbMiM5LZX7rRqr6VFtpaxi
         kiIg==
X-Gm-Message-State: AOJu0Yxeevxkv+zCMy1FTxtFbtJccFZt+r0XEUXxkzmHuSV4aTpwkByh
	k19PVa12dqwv5ESDRA9IhprmPpH9qwopVq1C699pAkfFGVfD9X3dgPanOW1Ypg==
X-Gm-Gg: Acq92OE+GERTbJUNO2qm3qSTsFl1+ZFbq2YyZT/HQw+sHUotDcUinXnr6axvAWQ104q
	Z1CO+MR1vZGjLH5vS2HyiuNd+hwYcTEApJHhqCPTOHn7+kiVu0zNB0zY5IX3aBUiX6q3egJebiy
	svF0CRqrxXCqQrf7B2ff15FjJixxwDqdxAGEuElmzli4MJroSleE40hb4dMLPKc47BsEjOVHON2
	XzK6ryJ+b5bswvMMNAvIA8y0vLDULG+k05bw5wpgmZClrhNzL4XqVHDPx8LWbhtj2b6xwt7V1OH
	vzqrZvamdGwLMLwtNYLXQffzM7oMn/0ZYiucakx4w9nmc3W+64Y4ctMjcw7ItwDRnjLXbiUi9+j
	H8W40NpGqwNRlXdKTcIJHiz48l4SyhH/kke8csg/LPuQZy9CNrS/h2bsCRsyjePUcbUyrAceo6D
	tI8nXD7sZgRe4c6KW+r4rxH2FN2fVE92qCPX5X3qLs2XQnpfa/aRuu0AaahoeQcWt8NtfuzCzd/
	cEKrHZzk392D93kqmFH6A==
X-Received: by 2002:a05:7301:4b18:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-2ffd88bcd1amr222141eec.34.1778536791780;
        Mon, 11 May 2026 14:59:51 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafacsm15107022eec.1.2026.05.11.14.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:59:51 -0700 (PDT)
Date: Mon, 11 May 2026 14:59:52 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: sashiko@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/4] HID: hid-msi-claw: Add M-key mapping attributes
User-Agent: Thunderbird for Android
In-Reply-To: <20260511205107.C2030C2BCB0@smtp.kernel.org>
References: <20260510043510.442807-3-derekjohn.clark@gmail.com> <20260511205107.C2030C2BCB0@smtp.kernel.org>
Message-ID: <70F3879B-AEFF-4CFD-9CC3-2BA477D97D9F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 11, 2026 1:51:07 PM PDT, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>- [High] Data race on `drvdata->profile_pending` and lack of transaction =
atomicity during concurrent sysfs accesses=2E
>--
>
>commit b9bc6d29326e3dd3ed065aca7059668a1b674bc8
>Author: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>
>HID: hid-msi-claw: Add M-key mapping attributes
>
>Adds sysfs attributes to remap the M1 and M2 rear buttons to up to 5 even=
ts
>(gamepad, keyboard, or mouse) when in macro mode=2E
>
>> diff --git a/drivers/hid/hid-msi-claw=2Ec b/drivers/hid/hid-msi-claw=2E=
c
>> index 7a3cd940ec49e=2E=2E60694d075d56f 100644
>> --- a/drivers/hid/hid-msi-claw=2Ec
>> +++ b/drivers/hid/hid-msi-claw=2Ec
>[ =2E=2E=2E ]
>> +static int claw_buttons_store(struct device *dev, const char *buf, u8 =
mkey_idx)
>> +{
>[ =2E=2E=2E ]
>> +set_buttons:
>> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA, =
data, len, 8);
>> +	if (ret < 0)
>> +		goto err_free;
>> +
>> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0=
, 0);
>
>Is it possible for concurrent writers to interleave these commands?
>
>Looking at mcu_property_out(), it takes the cfg_mutex internally, but the=
re
>is no lock held across both calls here=2E If a second writer executes its
>WRITE_PROFILE_DATA before the first writer executes SYNC_TO_ROM, could th=
e MCU
>be left in an inconsistent state?
>

No, the sync to rom simply writes the state to permanent memory so it rema=
ins in the same configuration after a power cycle=2E The first call writes =
it to temporary storage=2E

>[ =2E=2E=2E ]
>> +static int claw_buttons_show(struct device *dev, char *buf, enum claw_=
key_index m_key)
>> +{
>[ =2E=2E=2E ]
>> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m=
2_codes;
>> +	drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PEN=
DING : CLAW_M2_PENDING;
>> +
>> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, =
len, 8);
>
>Can concurrent reads of button_m1 and button_m2 race and corrupt the
>profile_pending state?
>
>If Thread A and Thread B access the sysfs attributes simultaneously,
>profile_pending is updated locklessly here before mcu_property_out() take=
s
>the cfg_mutex=2E
>
>Could Thread B overwrite profile_pending to CLAW_M2_PENDING before Thread=
 A's
>command executes? If so, when the hardware replies to Thread A's M1 comma=
nd,
>claw_profile_event() might route Thread A's data into Thread B's m2_codes
>buffer and clear the state to CLAW_NO_PENDING=2E
>
>This would cause Thread B's subsequent reply to be dropped and trigger th=
e
>"Got profile event without changes pending" warning=2E
>
Possible=2E I'll look at improving this pattern by managing the pending fl=
ag with a mutex=2E
- Derek

