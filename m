Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C02C21E8
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284796; cv=none; b=B+LLtXGfeBn7GDakHxV3XyQs0xJqvG6CXbcKPnQrwBxsr3ZWi3O3PzHOEUJ1kWw+TzXTqF8nmWm06pWm02htfxiDOrxhjU0opYJnd9/H+OSLHr6yHGtO+hNMRyJpIo3O/CZbNdlC2JoUen5BqiVXpLuPE1rFc4vDRoJjkMO27Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284796; c=relaxed/simple;
	bh=SKPQwCuIXeQDVbooPWqvrjF0kAbsPDZsi0ZG7fXOySw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B7LNfYjWUAA6LcsX0LyiXqfuHGkKHWq7Usu2tTEhhds80ydUhjZMhendvU3CF1u9lVHxXmeDzDEkAQXrx3v9tD6Hc/ek/RTTrl0CCHx9xWm0EezuAkM0ddyUhbvcMRMMMUIjE5nZNpyx5wsYDQ7Oeh3qhHOS79sYi/UeuMQaN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsrYcwUa; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsrYcwUa"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2779320eec.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775284795; x=1775889595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iI+TxGQdSms39C3dG7V+X9y3rhqq0vqJZ7JLvdhsih4=;
        b=XsrYcwUawZ7qBhax+SMlSWMMRhmMOBJ8kPJggCNuhoD0OvCxLSvghnqwMJ4TI6iRET
         xSHrwpBD0u2UfDeRqnXK8G9Wl0XiNgY44fyvZrA33PKAxQkW7ti9zmE21VCNNfstIwa3
         DfufQoYlsSTJAvGYgt3pCCkX9+BS46CbLV2XcSvK7IhhVL3sX9VwjbFrah1+s/N6Au8r
         U/UxbEP/1vs6BrBquNQ8Fdm+ZVZImoJ9wr7abNNxvzjur0xLkq5VvovuzHk1b+xjhEV/
         AUOxG69hdGnoau7KP+WYfpRvieX2foXX/0T8MFFsm2dKkbslCw0NlVN3NeTm5oEQYlVL
         Aueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775284795; x=1775889595;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI+TxGQdSms39C3dG7V+X9y3rhqq0vqJZ7JLvdhsih4=;
        b=tHyLJF22BlErV2+hmUhedvVn13YKP1pYa3Krpu/Ue706Eas0Wv6/cmJHQ/xZ/rWCtb
         lQ2duc+vbXqHx+keqgeJPARt9gS+ZCBmTOkJcin3F52f65DqYgYg5250Umlsyh0xirmH
         eGUf4cFwFGs9PKO4delMlhEHVvJCDE+BEaW/cc7VRF80X01KdFL4PqMbNulhHucJ+xO5
         EzaIB50DxuTUdVTgy7tjNnCN7vvhCj2qv78gzd2ZOsVpt402zF5a2hyXYXczRxcLh7I1
         0RwMUpYV4A1+8t6R3lx+iyvoplfHSXNetqp0rOspTKvET5imb2LBFbBO7h2YCjEywAGz
         4C6w==
X-Forwarded-Encrypted: i=1; AJvYcCURrXj1tJLW0QSCyq1iuzIbnJu9NvP6UoHZUHPSoX/MX9bO7zz2sfYOSO+sM3mHkwEBM3N/Nngvmir8eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7kRgDaZHwgUhdG9GO1hJJ7k8ucrZQ6KaRaygH9LxmedPzpah
	J5xY9X42j2DGtN3zmIx0Y6Mf9bmeXGNezXQVnF4n+UFBCqsTwb4TNH38
X-Gm-Gg: AeBDievKkEs3/xwBr/nXjzf9qmNtkAw7I4RWOaGYcX7e2NvuyXZ1zGRCSJQalBfo+Os
	2dyJloyoi6fmu25wvodOlrCmMa+DvOMV3nrJ2qbYTSNMKkz9O1jcXC0PpYr2ZG3bstPGDsDgtpQ
	mK/0FkDzP7MHu2WlzGdaRE38va/lt8CvfjWsqT+4TfpKqJIPQ8gUWOW1E619p/2T/2YR1Py76YB
	JA50TRTmbi+YuZ1A2omT26gBTGUId/AUByk07Rprypx2FhE2RsDnxYY2HJ7SxGm1kI0YOhhu+jB
	PfOd4ZOUPPs66RAvshTpRTNjgfKqFKPuBbuzgIt5e5/bouiL1AyDcgLjvB2iHju11WAawl6OmfA
	H2J0Mxr/aKyyQH0QDrbaTROYIiTOA6H5uiZBO0k3/Xin8t+R21YHYVPCyAqtu2sIO0xNQlZg8kX
	vxC7lXl/+mVy0CvGfNOp55cudmLQ0aiJT1hikbEdackQ==
X-Received: by 2002:a05:7300:fd05:b0:2c8:717:7ec7 with SMTP id 5a478bee46e88-2cbfb4a5aa8mr3097372eec.20.1775284794730;
        Fri, 03 Apr 2026 23:39:54 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2601:647:5e00:4acd:15d:de11:9b85:6c63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm7239641eec.12.2026.04.03.23.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 23:39:54 -0700 (PDT)
Date: Fri, 03 Apr 2026 23:39:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
CC: Vicki Pfau <vi@endrift.com>, Nilton Perim Neto <niltonperimneto@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: Overhaul device data for wireless devices
User-Agent: K-9 Mail for Android
In-Reply-To: <CALQgdA1soGo6U2_pKS0RZ6smOSS9Zd-g+eMD7KjwUwz-_pAK_w@mail.gmail.com>
References: <20260314075034.1488655-2-sanjay.govind9@gmail.com> <adCc8OuHm7wwkysq@google.com> <CALQgdA1soGo6U2_pKS0RZ6smOSS9Zd-g+eMD7KjwUwz-_pAK_w@mail.gmail.com>
Message-ID: <4436A4BC-2AD6-4B51-B671-E6D9FB6C3395@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 3, 2026 11:35:35 PM PDT, Sanjay Govind <sanjay=2Egovind9@gmail=2Ec=
om> wrote:
>> However you should not change product and version once input device is
>> registered=2E So you should delay not until after link packet is receiv=
ed,
>> but until after the capabilities packet=2E
>Yeah i wanted to do that originally, but the main issue with that is
>some gamepads don't actually send the capabilities data at all=2E An
>Easy solution I could think of is to just start a timer and continue
>the init if it expires and we haven't gotten the capabilities data=2E

That sounds sensible=2E=20

>
>> Another option is to use version field=2E=2E=2E
>Yeah that is reasonable, I had just gone with putting it in the
>product id like that as it made things easier for SDL, and microsoft
>had done that for the wheel subtype already, so some apps already have
>the 0x02a2 pid=2E
>Happy to change that though if you'd prefer i use the version field=2E

No, this is fine too=2E

>
>> Maybe have an array of
>>
>>   [type] =3D "Name"
>>
>> instead of this switch?
>The main problem is there's a lot of gaps in the list of subtypes, and
>this also isn't an exhaustive list, there are a few other subtypes out
>there that were used for some bespoke controllers, and so using switch
>at least means they can keep a generic name if they are used=2E

OK, then let's keep it as switch=2E=20

Thanks=2E=20

--=20
Dmitry
