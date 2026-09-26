Received: from mail-vs2-f17.google.com (mail-vs2-f17.google.com [74.125.227.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130D1BC08F
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790464801; cv=none; b=Dpjf0KPnKwZmIssqaFFiMsanKLku+MqRPI/d0a4TW/sY092nPBzXRZ4XMJjjXZjDc77abuXJztSG95TwXrD7bNlv+atjwCKmzLUIgMM1LQ9Ahid92jGEo1g+GAWmkX4IuZxXyWjj3AeYwHt+cmcBRDkJWCPGXRPHs4D1gchiSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790464801; c=relaxed/simple;
	bh=x+lyFU8fw2NYtSeu1jk9/sJSW85cbGjiEFqzRVsY3s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2MV0TYy/alKxRfuQHfxS3I4H7hNwrKTTrjPNNKk2p7lhsfubfbL/wX7Ek4q88JRG31LRgBIodZD7XAsPKTiWGWZajZJTHY4pBWapRUKu5oWY96nUb7h4FmakEMgJJ0TiGOVx2wISKo1Fxy3795sJFKlW0oZ5dR4hcd7Pur6FZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc/soLaO; arc=none smtp.client-ip=74.125.227.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc/soLaO"
Received: by mail-vs2-f17.google.com with SMTP id 71dfb90a1353d-5cd13e9ec34so613932e0c.3
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790464799; x=1791069599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8rVZ31dhnVvTYNLVTgnVU1B4iKZs/qhV9xXBXWsikI=;
        b=cc/soLaOVGUcwvQmtn0chfwZ6XHQ+lBjMv/BXQMqEPXAV2qwsZgJw1vC4vbzLlqPWW
         G/zXXglqZKjKvH5v1SquxssGsq3E7JZpYU2R9ArxaGv9KDTpZY96SCX3rUyddnmHgnIK
         bhZR++2Do6DIDpRYe3yg1ggG1/9CdtcHDdnhKnRibpydOVdl1xrHeq1vLX8Y8/H4VbeR
         tde1RNt++3eo+C9Bf6sW5LDLS9PFb7XgCvKM/+lgpcsgQQ9W6hjcIGrhlhgMbrxedKHg
         YbJ3g+fyY+ncbTtc2m3ym53K0C6la+BHUfZkciBSLL9ogydjeXwKBN2FntLL+R5iOe1O
         x6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790464799; x=1791069599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8rVZ31dhnVvTYNLVTgnVU1B4iKZs/qhV9xXBXWsikI=;
        b=kYjfCYlozhVcwjsTSRJJV3OXCpXRKOvSRcOkQF744WjnFzO2nrQjHSs1DrbtBmZc+y
         qfC559fZVuj90opNq4tWAFW+MyPri1/2yO1eJw+5l1SXre5WxewI5CzJPWgMuR8eSPa4
         uUFvBjxQfWkw4IsJuEmxKKwoCRsFnFUQbGWvOYjAev3r5+fej0FLy8j+eHwJ0Jh5MhqJ
         WcZY2v7gdlZPtn5zcvsTmPSdKK00v4KWOuSOcsee1DNqJFqHJcGXkC3Ih9zeUnfj/0Ot
         sjJ/mYsRYsVIodtKeVpqEXg9Sq1Bntit5JiXfy4KfVm2vasnHqT02c5I1PQlSNqYHNos
         O9yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAre5ySZvwwi3hbwCBIHftOmN5slhAG9uGHaatTzatCPrvgZ6BOLflniprR7NFp5TIDm9gYYnfq+BqnA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+jnfwD2gFUr/YprOkK/X10hs8onsmXYPajof6zmo2G+QjZ4hV
	kakkdUpM+WVPSWCD73qPVwf5AvxwE5iTPnpfnCBLG25eUQJmluwR63yv
X-Gm-Gg: AYBFou1T2UlrD5C/lC1tr1aYvhKQqMIBJQtUe1l1WvhGU/NRNdU0SiUkOZHxhj/pDwT
	qZKma+tr25Obpe7CsSa+BwecbD8u+F7jWw1QZ7dkE8/HH5M/TRluBooNjIxlp0C+lYw6Oi4J7KW
	Lu8JL9OtQM65dL3ju/tux8Vs5cN6zKgBWqaAp2JtLVHh0cwgyrPfvjIQm3LNzXHku01UF9WLwtN
	3AsCdX/U7KJe9WMZQ31lspqxj+5z802GmRj/mRxFabH3eIznSK9/dbp0W1BENWoBh5kEstQxHdQ
	EkeLN12iu/WoN33uxstdUNOytGxOnz3Hwy6OFFDePdqh1bjiBX8P66t9UnYmVzRDljpTj32DgyG
	soQAMZ/imxvVFWAkgjNF3o6IHNcD6c9jlWmGzd/B/em8bMdn9M6eaZTZVOJLxMwUfTL0IQHFtgE
	RqvheSOrTCOVk13KkiNn80I1XJ5qJshH1kZOKMx8CAcCfHDwO/HCBi5UoBGzM9ch+uNBI5F44lp
	BAogGCLWzANPg0JeQhPaCMnjrrJMgtCroGAov+H6gNeGw==
X-Received: by 2002:a05:6122:1c0d:b0:5c9:c60e:3a42 with SMTP id 71dfb90a1353d-5cb0bf4f842mr3983859e0c.20.1790464799140;
        Sat, 26 Sep 2026 16:19:59 -0700 (PDT)
Received: from [192.168.1.2] (host179.190-30-68.telecom.net.ar. [190.30.68.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde5a70282sm3358365e0c.10.2026.09.26.16.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 16:19:58 -0700 (PDT)
Message-ID: <5ed0ee13-9502-42f1-94b7-a99607ca2bea@gmail.com>
Date: Sat, 26 Sep 2026 20:19:55 -0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 303/398] Input: synaptics - disable InterTouch on
 ThinkPad T440p (board id 2722)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, =?UTF-8?Q?Rapha=C3=ABl_Larocque?=
 <rlarocque@disroot.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org
References: <20260923140643.441954610@linuxfoundation.org>
 <20260923140651.274430576@linuxfoundation.org>
Content-Language: en-US
From: Daniel Salmun <salmundani@gmail.com>
In-Reply-To: <20260923140651.274430576@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/26 11:06, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let
> me know.
> 
> ------------------
> 
> From: Raphaël Larocque <rlarocque@disroot.org>
> 
> commit 26eb3d92c7a4d7adb1ae1740ca6e8e100b11d1ec upstream.
> 
> The Lenovo ThinkPad T440p (PNP ID LEN0036, board id 2722) has a
> Synaptics touchpad whose SMBus companion is not ready at boot and
> takes roughly 200 seconds to appear.
[...]
> Disable SMBus InterTouch for board id 2722 so the touchpad and
> TrackPoint work immediately via PS/2 from boot.

I have a concern about this one. Board id 2722 isn't specific to the
T440p. My ThinkPad L440 has the same Synaptics board id, and this patch
would move it from SMBus/RMI4 to PS/2. I have never hit the issue this
commit fixes, and I haven't seen it reported on other potentially
affected models either.

I sent a patch [1] that limits the quirk to the T440p. Previous
attempts to move these touchpads to PS/2 were rejected [2], as
explained in that patch's commit message.

Could this be dropped from the stable queue until it's sorted out
upstream?

[1] https://lore.kernel.org/all/20260925230039.236786-1-
salmundani@gmail.com/
[2] https://lore.kernel.org/linux-
input/65C23A49-5A55-4CF4-9AFD-2DA504DAABF5@duggan.us/
