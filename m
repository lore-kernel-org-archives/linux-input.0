Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F16490BE6
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352834; cv=none; b=DopPrTyo7ez8wyLZSBFQkoW/K+K2MRAStCEUaFY2oEkfqaPVB0aLg7sk9/cb+xF0IgpkwAhe7xK2ua1oyOopTfuIj+scG0LvptFtjQaW/4I/cCWBV5vXwk9V3Q6J14PEozXpRA/9WSITKy6rTxkiA9eYzWLoNq0wXHC5mFhma8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352834; c=relaxed/simple;
	bh=/0FlnvMgf8ucFbML07sLt62uDSw38M/o6+5iK1tany0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YOAUT7bIhQYT8iqwlzAX8sGkzg4ZAKnRrZBeNH2UuGF7fPhv94mDcvcG031lkHHaCuX9895/yu3czOGr86BvcH5iC/NVAM8obvWNYj4z/PQbPJuJfQkfjtn7zBzcgjDM36UaIcDTRFyovFZsYHVmk0W7haADgc6tNNG8Zxt+Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8tcQlrv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8tcQlrv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso986650a12.0
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352832; x=1788957632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pN9+CUjHm3nUnn6kbT0jqG6pViZcVeuyzSfqXWpIynU=;
        b=X8tcQlrvM9VYKg+8vg1Pd3+KTZAlBBJliu/95LwtfaAWuURqy8ZDzYr3ZyOuqcjLNB
         w6KqEEAkkg6RSaMN14rtt5ceWFTKLOsFjgmySje7tkLlcNfP+pU4RB/YxkAznf4t3qjA
         Pg6xUkgqN3RKVVrGE5PrBaJP/dCOcicoEc5nVycDJxvSd+G0kbW6huRpT1taiEgBadEQ
         GvVfciEp/yOhLAliZno7kQJ26Apa69fGl8AfwyefFe4xrZ2gvzoK3U3F8Zbgg9w8kEp4
         1C2fAgY3VeeNcJuKv6NmpmnvefgrKFSOTJqxmv38q+367zBfQvs/VbrvmZBcCsYOjeGg
         6jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352832; x=1788957632;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pN9+CUjHm3nUnn6kbT0jqG6pViZcVeuyzSfqXWpIynU=;
        b=iuoqpWG55iAzh73FEGiEtgboUxi0NWwbeElGImdox+HU7dWmH70+UA+A0Kbm+ahvE/
         GUti44+doq12cTcU/8mC83Z4/A95NiOH9lrnOAoQd6auZomzeNDZHhPOFCzuoGKa0iRE
         4l+PI+H3iKCbpIinOm+kfLlm1owyE3kgHBtP26jiVwAOYkifFLIX7MURrbetqVZxf+r7
         bcyXgtFwmnDG3bfvCnMIso67PXb24Genhq0F3CWXQN+oC8FQOk8fkNvTpflwJOjLsxJv
         choPXDIwHcEZXEjRtARtKP0AHGCjuhytEKX0oPm3q3JGcA2E1Fkya3APE1SO0FiGazrG
         105w==
X-Forwarded-Encrypted: i=1; AKwUvBzR9Ovgm1eDpGiFnnwfEaXjGndPp6eNuke231frrjDw+rxayhdG1/dS7Cwcp7qksoXRN8QZNpHqDomwhg==@vger.kernel.org
X-Gm-Message-State: AFuF++mZ8htM+Coa95Wg9b7PJLFhH+Eu0aEIRyBdhJNR9pGZAFiNMXW1
	22PKuJPe+c2ekUR4JLAHzRjK2VP4NLkYislvFfdEf8eaa7o8DB6GX+Ta
X-Gm-Gg: AYBFou2u7B4P8hsUQDWgMCmJDVv3QveeXCH8UjHVZsUmYU01Xkw0Q/XKhVJ/vxhFmd/
	pogEGm5yJmm0Xb6TOglMlrA4rrooH/spYljz5iwZCmLfUt0/6iijk04eVsVpQDBWCrYPWszJog0
	gXQMdrhjqR+JeMSOEvljwdVNWNLIpLO6fOVMG81GTM8AUIrzeuF67iGApM8sCGJPeDessHd1hTx
	0lNwsYsiUDbP+lSHReeUD1/21RUqsSxQXkiqYiR16lM7v2ewDGCrPZDTJIbJ/CdKz2VYhVXEBJ5
	XkoKhBYqEAom84XwoH9tquv8mv8u5xcKBPJWe3qhmADWdB5QguMV5Var3AIPBQvB1q18Cftb0In
	rfx2XtQHEtNX9D2GVJdrqTPDub76dL1leGO1S+M2EukLfWe8mu3XdhRCRfpbB2uT23cLnNK7AmH
	s8NKvXHK3Csjudgy6NWiNWDCH0aOH9BHrPDx+G4rfl0bqhT90i8NA4mAyfTkREPEryR3X7GbeB2
	vB+ACAyFthEphtz3FNiBtrVGth4ZwE/STS9w5uj6LfMNohWebaqyVKBGrfvsgEqfNtL/h8=
X-Received: by 2002:a17:90b:3d84:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39aedf7cc2cmr7542665a91.2.1788352832210;
        Wed, 02 Sep 2026 05:40:32 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430eb4854csm6767338c88.15.2026.09.02.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:40:29 -0700 (PDT)
Date: Wed, 02 Sep 2026 05:40:25 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Aditya <mradityadash@gmail.com>
CC: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_5/7=5D_HID=3A_hid-lenovo-go?=
 =?US-ASCII?Q?=3A_normalize_calibration_failure_status?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAH7J6R-Vh7uEtG=+Shj0CVgxm1RNpuxjuEmNfLJevhTmCz_3Cg@mail.gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com> <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com> <CAFqHKT=7xMJAvTt3__6CtBiS2duGu6eoHq4FWiGONMvjFE2CtA@mail.gmail.com> <CAH7J6R-Vh7uEtG=+Shj0CVgxm1RNpuxjuEmNfLJevhTmCz_3Cg@mail.gmail.com>
Message-ID: <205C547F-BF6B-43D3-A8F0-829B657167EC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 1, 2026 10:06:18 AM PDT, Aditya <mradityadash@gmail=2Ecom> wro=
te:
>Hi Derek,
>
>Just to clarify, this behaviour was seen when sending a left
>calibration joystick stop command when no calibration was
>being performed=2E
>
>Sending a respective start command returns after 10 seconds
>with the error codes you have provided=2E
>
>Here are the exact requests and responses=2E Consider ellipsis
>to mean that the rest of it is zeros:
>
>Left joystick calibration start:
>Request:
>    05 00 0c 04 03 01 =2E=2E=2E
>Response (after 10s, no movement):
>    04 00 a0 02 03 02 02 07 =2E=2E=2E
This makes it look like the reason code is a bitmask rather than a specifi=
c value=2E Probably more difficult to present in sysfs than the value it pr=
ovides=2E=20

> Left joystick calibration stop (when no calibration is running):
>Request:
>    05 00 0c 04 03 02 =2E=2E=2E
>Response (this is near immediate):
>    04 00 a0 02 03 02 08 00 =2E=2E=2E

Interesting=2E This wouldn't be the first time documentation was incomplet=
e or inaccurate from Lenovo so I'm not super surprised=2E We can then consi=
der a 0x08 response on the status byte as stopped with no call running, vic=
e failed, if you think that information is relevant to the end user=2E I th=
ink it might be=2E If you stop it with a cal running is there a meaningful =
difference in the response?=20

Thanks,=20
Derek

>Thanks,
>Aditya

