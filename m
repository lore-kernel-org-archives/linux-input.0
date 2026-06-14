Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3702D3727
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473850; cv=none; b=t7dvxr6TSHR6YAPCU6X+mpMeXVPsr8iw9O/Nk3K9a+r+qnyIJHiCaMgLtQUxhcrXt4RLH6hpbMTBH9rmAnVzxGzdiqgQ0vDKVxkUSIXczyvJFuMwZi0W0OIqZIae9MYvOVQYRZR/apYpOm5+H2yaTifpkgqJrLbHBKnCXnFx+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473850; c=relaxed/simple;
	bh=f9i5sDz6iwsnSbfBhCTnVa3QpYWUQP8/lYxUTCL3om0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YGSs7DQgpYXG2OTYOv6/HUtzpc+yCTPJDc/5TS098y328XKZxTYeHkBPLd4y3DQGwzgbiK3ZQtqAjPN/T7XRvB9Ctj9OXJ9UflzlkvEeAxIg+Y4+jsac6u+aLQrRAAagiu/B2EJ9usm8z8armrK3dt51cQISmI9R/c5ahntfMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK7p00SL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK7p00SL"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-915aa0a9293so363509185a.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781473847; x=1782078647; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjPvSV9SzvrrYwJN/4MKdeoaNz5ldXj7yHeVr3JEKZk=;
        b=lK7p00SLK54SGGh/iKmhGxfIPVvD1zUnBHOggU/zovMAJB1tF0VGzAg/dvpENRRBg2
         K9a1ZsDvt6VHF+zMoXqGXGh+fCjrMKgfsFJYI/N9wT7CP/SzeOzZdvWthSeTZviNBdud
         /2fwwvAHPshM+NCGnNpmB5uhhaps7bZKuPIAqOUFpkYnp0f19bWHSDWc/s4QO3KhcCUG
         DnFlnUuXbeKEoycOXqqc/iQ/3IYd/6Kx/JQTWUtzRREP06bQDq6b9ktJ9982nVGE4w8f
         b7jyab2fieZRfni536TAeBPkPZoyUYIkjaFcBivlorjW5Rec7rIimBs5rodXQx8eAE5a
         9Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781473847; x=1782078647;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjPvSV9SzvrrYwJN/4MKdeoaNz5ldXj7yHeVr3JEKZk=;
        b=Dq3n/yNIdPK7TQGakIhRidM3/pKG1OWDyvZM7fjdSCya0xb/8HUOjycLdFKKYzGSRj
         dhbJ3ej94Bv/vU4iQssf0BD6irGhZNSxrMjmGI3S7AnRM0TIFJVwf9Hv6cHOwKDo4q9M
         BqZP5/s1mxwvSuMbiak1IH33YnMMUBWl0Lp59l+7ZB4jv9kzqk9E2joUnaRMF0yPt5bg
         MJlFgDVoKY9APwNoz7R8nAW+9SOW6avaDD2xN2d4JxE1UN7ghSU01x9ogqhPr1a9DVFf
         CDtnjXlOqMWYyzvDk+SsgDe+/vvkimC7qSHt5ngGTO3HBWHmu8/WIKOcUd5rHve4Vg7K
         SpTQ==
X-Forwarded-Encrypted: i=1; AFNElJ99r3pm74LgqXv6XhwagYEVOYRpKoOPm6+plNJuAnThlO1I/x1Dw7U1BQFCdcSP7HaEH5I6lp+SlBiP5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGU0XRpX3W7pgZWgAuWWnDh3vGbZmC0ml2H+qU9WZOQuuSOG0L
	fxnglwdFmh4m17jnpD2AuUEknRmdmO2Z3vGz1YrZ9MZyCu8b+UYm3Jsz
X-Gm-Gg: Acq92OFZcf/8sRS1VRmwRNNFyRdE8LAWuXN/LBl7DEGZbt7O1aWm6bAnBSSQM8DdQ7H
	TfZ943c+GXLx+4zGrKTmLV/pCl/w4Qv9yXhUx6ze5H2Y/N/Pgad5f8avrkf0Hl2kW9sOGmxiN9v
	BFMm4gbZu3r1PIJS/X7S9YgOXn8boQOvAKbsWhy9FQxHJyKIm++DIEowvvDSkw5kJ4/2aSD+gp2
	13MgFJCWfLgRgy+3dPytas9eO6aJO2sd/npb1w9J1Wox45nAVL1TceDutuq+VR670Qjh9Tj51u6
	51bqiMt3/nZMMdOOdKSny6PAoRT0d515CiY4+8SOtco5ixSVZoyrK6QIb7k6f+IiUFSJXMvKnFB
	CmBon+hut608gma9h60cvapInDY9zDgfhFnPcb17RLmZt7VaqWw824NyyY9tbVH3y22G3K+VACg
	L+TxdrTxzCxlxl+e6uOkJuEAiB7NSn4XvvHkmYFQ6yRarpxxVGQOViJ5DXlGcnlfmCgMrp/uP8R
	ujj
X-Received: by 2002:a05:620a:2948:b0:90f:47f6:832f with SMTP id af79cd13be357-91619f395b3mr1565739485a.33.1781473847153;
        Sun, 14 Jun 2026 14:50:47 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb90:eae2:4af:c9a8:8473:8833:347f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006ef0sm850690785a.24.2026.06.14.14.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 14:50:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260614163518.2a265172@linuxescape>
Date: Sun, 14 Jun 2026 17:50:15 -0400
Cc: jikos@kernel.org,
 jic23@kernel.org,
 srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org,
 linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DEA24F7-A8E1-4879-8810-1F3400086A19@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
 <20260614160213.085e1efc@linuxescape>
 <C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
 <20260614163518.2a265172@linuxescape>
To: Maxwell Doose <m32285159@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jun 14, 2026, at 17:35, Maxwell Doose <m32285159@gmail.com> wrote:
>=20
> On Sun, 14 Jun 2026 17:24:12 -0400
> Shuangpeng <shuangpeng.kernel@gmail.com> wrote:
>=20
>>> On Jun 14, 2026, at 17:02, Maxwell Doose <m32285159@gmail.com> =
wrote:
>>>=20
>>> Hi Shuangpeng,
>>>=20
>>> On Sun, 14 Jun 2026 15:19:21 -0400
>>> Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:
>>>=20
>>>> I hit the following report while testing current upstream kernel:
>>>>=20
>>>> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
>>>> hid-sensor-custom
>>>>=20
>>>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>>>>=20
>>>=20
>>> Is this correct? It seems to point to changes in HPFS.
>>>=20
>>=20
>> That commit was the linux.git HEAD where I reproduced the crash. I =
did not mean=20
>> to imply that the HPFS merge introduced the issue.
>>=20
>=20
> If you have (a lot of) time, it may be worth trying git bisect to get
> the exact commit. No worries if you don't of course, but it would be
> incredibly helpful to the HID folks.
>=20

Thanks for the suggestion.

Unfortunately, I don=E2=80=99t have enough time to run a bisect right =
now,
but I=E2=80=99ll keep it in mind and will follow up if I get a chance to =
look
into it later.

Best,
Shuangpeng

> --=20
> best regards,
> max
>=20
>=20
>=20
>>>>=20
>>>> The reproducer and .config files are here.
>>>> =
https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
>>>>=20
>>>> I'm happy to test debug patches or provide additional information.
>>>>=20
>>>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>>>=20
>>>=20
>>> This bug report also seems to have nothing to do with IIO after
>>> investigating the call trace, seems more like for the HID/input =
folks
>>> than iio. HID folks, seems like it was caused here:
>>>=20
>>> [   73.163547][ T8356]  hid_sensor_custom_poll =
(include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
>>>=20
>>> before _raw_spin_lock_irqsave() gets called and KASAN triggers the =
slab-use-after-free.
>>>=20
>>=20
>> Thanks for checking.
>>=20
>> I agree that this does not look like an IIO-specific issue from the =
trace. The crash
>> is reported from hid_sensor_custom_poll() in =
drivers/hid/hid-sensor-custom.c.


