Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D58544D73
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112313; cv=none; b=ET/govgG+x0ujRoxVu+JFVw0uorBX59IJYN7D9nE/lFAjBgPNSu6J74wlC6QhVcLI480gQH9I4fqc3L7UrQoFOmkMe8Va6XT3M/+DmtYC7UVZZKnsJzi+jCBKPQTSuTNZqlzvpUeBJeq5k2dDpFNtTO0OA4mkIyoxmVABb2SoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112313; c=relaxed/simple;
	bh=no/OHCTGZ4vWGPddZ9QLuhpUGxiTm8p9NsSWN+Ypb30=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZrMNwpj38xgV6r9z+g3WBuunN5S9vmmWR/wc/dLIYDafXrx7OYnlAram1+0Kx9weGAuBj8TPMQLo9JNRL/kFrE4puxSgY9tREZupwD0xSj+FrqLYm3NJvKCv2PHDc+QlCG7fwE10F4RFV889X561t2yBQrcFBXTXv5b/x0SwVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lItEh/Fx; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lItEh/Fx"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dbbe82e13so220171eec.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790112301; x=1790717101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=no/OHCTGZ4vWGPddZ9QLuhpUGxiTm8p9NsSWN+Ypb30=;
        b=lItEh/FxsD/j8z3dz9Al44YrTdL+1qVmEQifaa/ibIjrYozFB1gRRNZPdjNX/ZblWP
         LlTRTmrE1wgOJgKWWzi+9MKAVtGDYwTxj1CXS+g4C3tAQlNgyuF1j/p7BW+ZG+TtpdxN
         s8zPcK8Ae0AbyZ1WZkBy98+DmsVkeJ5yrxLj+eb3FhR3OPdzug2InQdsqBynZaVUMzw9
         DTAxgZ+9Iq5PC298ItQ0i8INoQNMPLKsan4oTLGF61AFSSlHRmrGbqvKveaw6PId8eN1
         jnKm4m4GZmhDynTAXiTajEsBQdeAJB5b/dGDFklBk99beYO5K8XwJtBkXbzvgxanzcWw
         o0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112301; x=1790717101;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=no/OHCTGZ4vWGPddZ9QLuhpUGxiTm8p9NsSWN+Ypb30=;
        b=1r0QxUPtTur2R9c5kgmfrQXPIp4PwTbwiFecv1E0T3PSR0PUBFYxFpw5n0ElWiM6q7
         InRWae9Agtl74D2wXG2XpgRNW1ftUx8GH/j03XSpJMl6A8NaDrNhBCh9qWqe7WbXf3kv
         XA8u13a/1jdCzNA+BH9oa/+BuJzzK+kPbwMIeqMNVk1tLZ3+4mmIF1voom11lvcrvsYT
         FoLs3ZXdDNf1JtsaWr4StrxzHeILyKmonqSMtFJMMRgSjrwr1k+uEwC/LRP7WbZ8drxT
         d9sBWNI3srx8AFp+6ott//8JHtkNXHsypQYvSmmF+Spm+GxEMvy1qKYDkt+6MYjsWdG9
         V47g==
X-Forwarded-Encrypted: i=1; AKwUvBwBqKIlTvVNkxSTg+I6MHPWH1YhxgTAtAOCzRbwUSJSnRugzJYGxr5wpVHzhVmbQByhWOSO1QtN7ia/4w==@vger.kernel.org
X-Gm-Message-State: AFuF++kO09HHb/fLmUYLqgvtAY18duObVFokPav0b6qEGwz56mojsQ5E
	IWg+TseUIttq5QQezp6gaAUHe6Y4RdCZrReQIs7Ty4h82ixliUTLxDy5
X-Gm-Gg: AYBFou3b1T9bpOnQtOd5TkOzfojzGkczUebs5IEl92a0cpBqyPqBCeqUDzBHP4pcuHN
	YlonuWfeSDpAyYFB8lt17vWsC/5cTMIYWxG1Ls/goowpbJfMUVjbeLx/29eYsWNwBVWkInJgOUk
	O/Wtj2aMOiyqQX9jOfTJwA4sKLQiX3QoFjCm+NVY/qHHcqw+fEtei1xs1XLqs493IeTgnPLeVCO
	j2HCJa8+O++t0ksDxPvy+nM4N57r8hKmgupROQ6aXcXrca4sGi8olWK7rFCScae1TZF8GDAUSxv
	k3Dg1tCwehuX8IERW2MM8rJ55BSBzWdc6N9VKARu8AulVhXx0AC8fq4JB3mIQ59PHFMvOC/n2DE
	ut7lNfornBBUX1iahbM/Ufg87ncOLpRKELCuvLwk4uAwtzA2iYSrBbJXO7uLxGnAVEkf+m6cjsz
	69FU3c+JcpmbpZL1tz3DaDLJrRWpzN2wE4U8+aatnCtVg/RfWlvSLnpHtOJYaiiUjkPe6+TyO6z
	GOC829TcPKlP05fYS6mxRiAKNoCtPiQWd3iKBFzUO/rn3UeEC3RqEZhcTz3tpu5c4oumpr/pRCX
	PB4=
X-Received: by 2002:a05:693c:41c1:10b0:339:7f8c:7f9d with SMTP id 5a478bee46e88-33e8d8d21d5mr615779eec.28.1790112301177;
        Tue, 22 Sep 2026 14:25:01 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm1014841eec.4.2026.09.22.14.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:25:00 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:25:00 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Aditya Dash <mradityadash@gmail.com>
CC: Benjamin Tissoires <bentiss@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_5/7=5D_HID=3A_hid-lenovo-go?=
 =?US-ASCII?Q?=3A_normalize_calibration_failure_status?=
User-Agent: Thunderbird for Android
In-Reply-To: <p1o757n0-2rro-rnqp-56qo-56q08q5p29pp@xreary.bet>
References: <205C547F-BF6B-43D3-A8F0-829B657167EC@gmail.com> <20260905061054.50663-1-mradityadash@gmail.com> <p1o757n0-2rro-rnqp-56qo-56q08q5p29pp@xreary.bet>
Message-ID: <836F1B09-60CA-4A82-8293-0F9CF506E593@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 22, 2026 11:54:36 AM PDT, Jiri Kosina <jikos@kernel=2Eorg> wro=
te:
>On Sat, 5 Sep 2026, Aditya Dash wrote:
>
>> Hi Derek,
>>=20
>> The Stop reply changes based on calibration state=2E Its status appears=
 to be
>> the current failure_mask + 1=2E However, this mask does not always matc=
h the
>> failure mask returned when calibration times out=2E
>>=20
>> Here are some requests and responses from the experiments done:
>
>[ =2E=2E=2E snip =2E=2E=2E ]
>
>Derek,
>
>do you have any final followup / verdict on this series, please?
>
>Thanks,
>
Hi Jiri,

Thanks for the ping=2E I missed the last response=2E

Aditya,

Seems pretty inconsistent and I can't really see a pattern emerging=2E I'l=
l look into this more later when I revisit the driver architecture with som=
e other much needed fixes=2E For now I think just reporting success/fail li=
ke we have been is fine, we just need to make sure we're reading from the c=
orrect byte=2E

Thanks,
Derek

