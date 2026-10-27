Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089368;
	b=S0k/WDA9IQLWKOB/cv+wsWnvIefSF9tZr/RFGXibEUVzEWvkXiI74Gy1mhV3s/BRxV/d
	 KBeift740Q9nXjAZjGe000GBkVVHGDECWrxJ5fbJfOzFbCnD/rYD5GIobefEzQdS1gKbz
	 uZADiF7yFMbKycygdzr0fCb67n0yjcaz15ifBKU04dUXHIHrhpgSH52svpfV5ResGlSS2
	 8JDdEgYitsOMKU26V+L/JRq7yf8L559r1Ukc4EtOpKG05f1huKutoQAk6roQ1oZR/W+DR
	 7Owa0AOdzmgYBqSEPBdInQxlE7HLKdzr+lHQ6d80HskYNIz7yWQXIMYzf7/jXNY/sFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
	b=AA7cyqOVhEBcz7c4edcjnIJ7IGDVAYE1wFD8bUJDRK3lGOV2OPulXhHzV1e7HXfbJ93W
	 U/ulVC+Lusr0HKew1UKuFxOhCz3+LQSc0UMnHKnqvH2MnsWq3AIHFnCHBnH6nm46UqxHP
	 NjOrFnTgKCO9GtB3eJvlhfk0YPB5mAPQ0NVJP1gHzLqZttEoq2ItCsuCGgoJnKaYm0e8P
	 GuKNqblxycHpciLMESn9J47gQ0Oiu0iyVJ0tpx0yj1wLBaXUItPTlH9rGA9owyoy4hLuK
	 jfwG5WAjp4MREaOG44vtMbD7FdAgwqtEowZZHi+79Obcj2ctW9Ong+gjOIybi/01ytw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hayvxmzx;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B776606A31B
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 08:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B776606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hayvxmzx
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso921262a91.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089368; x=1793694168; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
        b=hayvxmzxWUNkxQZOcUXN0qwsRzCsTin/m622IWJBdtGoONQ4VRwrf3pi7aAL+T1CTG
         ulsqZAcddvKOYf2/ClMFuj+IlU7bKnnHMc161bYEfz39L6J+qM+J/chect4a4bTzHW/V
         HUXhN1koSC0WgHZ7jXAZCc1j75ygzTLQcU9Hx5XslNYpwIWNaGusoczP3SJGjTOBFncJ
         CY/wRMqZAkmBxqJP7YQqazM51ZlXEN66EiyheLaNRXYHJP+GPF2wvrpsBEHYfcKb/Mk3
         bu2PCc053cEFkIWrPYSX3/yV19Rutmpp47ownwFpzk+EQk0I6B5NDatVwF/S1+wTVU93
         kJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089368; x=1793694168;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxzp5fPcS3kqgnusg3EHz+ARzLMXQsnr8kyVgVxlMPI=;
        b=iiXoF5jeSoc4q/8SuqKGr0gzx4ujggF+KyoYv/JuwkslFW5MIHG7SJeelTJxKQ1dK/
         KNAmQ7a9+jkVt3jKNXWRYM/jFwOTVFwI4MZsoiz+MPIJlrfx6Z8+dSNv4g/yTpLb9vWl
         XnCfOqDl3a8fWWRqzbv/YGdSJ/iu1aVx5ojoKqvxb44pNsG9Zhuv/CrzNg3qoArWOAGp
         3JzE05YWit4b5CWoPRYOSY16zWJPCoSP+oeZNJmtd9Jq41qDa6ukGlQBX3YqWwBF2hYZ
         OOry0SXqiX4BVKwSXsTT/QVDQ+QQWh41sNuc41AqaFT6niSV6wvk5KPMlimbgN55Z8+D
         igkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdOInFuLwubdQ40srcHNqBTpvICb5vpr1F4m/E9gj/obXg/yM4+ewDRm/YYeiRVPeFlvHoSrvdnkpOyw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7vnIEcV+1/T172wRU8xzhbH05V2z1BNbWhVhj+oSQhrh6krGS
	4cCn8+y9SROAxCf5pSOyzhVjEpZxSrheM7S1VS0Vjx4NaqAdKKs9ascN+LjVUuXbSJh8eg==
X-Gm-Gg: AYBFou3bVuO4KfbcBQc37a26YYSgbW6p6h3/3Bn0Iglk61DIA/0UpW3kVL1xb9m7GP9
	eQmcxFaLbfKuVdJhvdhTBDyX4A/izq7UyjrQS0+RNhpfF5CPVun0xLYTBbWimmVJ47yfMKuj4Re
	lzNvRMQVr3DHcVj7ldaAmXcIJhJYRewfiH5huNX7uxzwDFLxA0zlQ2wlF1mPF3Q7/gOy6kBDjPE
	Av1mG9wNJtszXEuQ8KJzcJ017KsPnQwrUH5QyPQ0Fh26AHH0ZnaOlMEZNLFa2T4gE2bxW9Qtj29
	TCyHXOtum5QmAOjQLg5oUE9GFmUy0vj6TvJ0TnQH3tnUNqOLisNCZj9txBx+6E2rcuEDhwqVd0v
	vgGmHKdANciF5zQqwn4ZdCw7YZPNvV8oi7d1k1BS3GO9SRh4uOjTLXWO5t4+ANg0KEkdm7AexuN
	J0XnimHd5394Y2raekIVMy0nzY16FOBhF2bamihinBOZN77YeaRJVbeXpnej3zAbZsMMpgOJPEB
	T/RMiKDfYc+9Hk0qg3XSSf1Lote+tgk91kD19whStYTAwme4VplqTWjNEnpacsMjsNb38r/2QDu
	JE6pYHW1TGS0SALVY36UEnQiIuTz69CGItMjVUSA4jXdCL1eTc//w3InFIzr
X-Received: by 2002:a17:90b:314a:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3adead4f73bmr6882910a91.37.1793089367740;
        Tue, 27 Oct 2026 01:22:47 -0700 (PDT)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm8137375a91.1.2026.10.27.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:22:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:22:46 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
Message-ID: <179308935900.645289.17780178981863221787@gmail.com>
In-Reply-To: <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
References:
 <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
 <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
 <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Helge,

On Sun, 25 Oct 2026 09:20:36 +0100, Helge Deller wrote:
> For this patch:
> Acked-by: Helge Deller <deller@gmx.de> # fbdev

Thanks for the ack!

> I'm not sure about how to handle this patch series at all.
> There is still a review missing for patch #1.
> Shall I take this patch (#2 of 2) via fbdev git tree?

Since patch #2 depends on patch #1, I think it would make sense
to keep both patches together, perhaps through the HID tree.

Jiri, Benjamin, could you take a look at patch #1 and let us
know how you'd prefer to handle the series?

Thanks,
Aveline
