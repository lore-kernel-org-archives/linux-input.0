Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122650;
	b=SJjaQO2dqD6w2JTsH9dLg1bkcHAcXNz/ScfvC9g32LV8iiLEchlbv3C62sN3Ko22r3vM
	 kOR5IBTVNSWX906pu75A+6jvRZboH0M44KvHMkscWrI4eMmfyfhMt86gT5we858m7+4sN
	 lK0P7HBIxv1HcAan1R+pI7aO/wcuGDMB+DPRjEXMZU174FZBgKKjvqTgT1oeAZQfoT5Mp
	 eAifyVvVQ97drAjppLKc1bpEChDC99+KFumGiPsa8eRuatKsxnbJeIb/nZLY2pE5HNvHp
	 aOSbKKUZKDqdZdFtdIgNCp0qXRet2fQe1wEmBr9qCpABHKVUx7D0Z/QHy9aW2EklVOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
	b=fyOAeLhMIuJHar4GDe9lTGQ+qQ6o270s/P3itFFKqZALJ4Il+NU06kAeSNILAL/AtCuh
	 HKKiUdQWywr14QOezNjyQThMw5y0lHgxBflHS9b1sm6b6tuP50v8q1sH0vHChXWTpRLGl
	 8s7XXX+w6DG+OsPdtTVqf2lUtTrNEfURH9GRN+IuazV2Nl31Rj/Ld4i7qx00kl4Xs5Ufh
	 kZTFcw68SX6RJC1HpkYRGDxAxCJ45DGz/pRTfoGBb3UBaxQ06ZwYvUPJF50vicmZ9xjau
	 SZyXUMEKhwkbCnJXH1NkhZjq95iK4LZpeEQc4BYcuT8rCIs1D6yIUfo9yEw6JETV6Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCP3kLMX;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B3606A326
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iCP3kLMX
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso238972c88.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122649; x=1795727449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
        b=iCP3kLMXRPed7S9bJiG09JN/i19X4EoKdfuX47yJoyHTjU2fP14WJ46M688r92Qp5q
         +huNC4FWM7X7qXkM5atVyXyOoxBHx0L7e84UdWP7l0GkReWXfnyI9t4tJxbquQoQsLhe
         1pe1DSTPLjKf+XC5qZQ5FGRSAFvEhvosPiuS/UfhKZzWwsWKs7BKZXQK0L3TFb2gsCpQ
         EfneK5gQPeWRs1j+tvebD0EgjIJldr4OasjqSLqWiRc8H/CX1ztng4w+nrqRD4ZX6tkY
         SBp/yjLUNhxsdMtp/92gznC4m3/M8+m5OlxJ1bCEbbCvKFkN/lCpi0suNNxTzyoKfC5A
         Gvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122649; x=1795727449;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5U6njWrD4PRYLymuIC+nuulMZWyQK1ghfLznW+6AEM=;
        b=gqKBEYo3VZgJft+115ZM4BY1dW34/hjRPn3DHRh9Dy5WWtGaIg1x6hf+AbKdtnLXbh
         M2ymkih+mYjH6bdxt31Q7a0HWPQVxWktJkAkNmF4QAPU+FfqCpnGkHY0Xj8hE/43GeTd
         Ru4NpibgJOsG8LXVTvUOxgtgrDkxoSJF+Y7ZmT1VzgH2Q4flbZ89XasDo48YB+BbYm+I
         T4O40vqB581YZaNWnKTJD8hkmJ92ZyCiAcPkYvITV6KUm6R3jV7nss7GqbmjIbijfNpm
         CkzsPZCMg69DUVAAL2/RlrX/ku1YzzehtGcpvuLQ+rcTjgQpNLrCMBAbnEEHzYKyBdNt
         DWlQ==
X-Forwarded-Encrypted: i=1; AL+hErHnRXTsOVmRjbaNPJF8fpluKQoJiOPXEyCZPQAgcn7dM0Au9Ww85lymECeDRQ4cC2B/rrylPLX9Q+tayg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+Y0JHp+hqqwruMgupnv1VqufdSj5QEtVYAOmznIuNE5FER/RB
	tISlRYjEnOLIs8HqO8tz6n+gAAGq9P/drISQZaTKLvcCI6+50bqUZXan
X-Gm-Gg: AYBFou3Y5uh05sRXZvppOTUGmPAzzTZH1MGy2jUY5On0TMms1l38fUNVixjfgSC1dDH
	oyIOjDS7wShTNBH+J1tJfrwkr4k0sYDGvQYiHVH4rluIucixdsZRTrB8OSWZ6QzxVXFHdijI1nP
	/SnrlkN4m/zWRncr+ofpYRQt3lkm2pIxqvIKDu3J86KAobxfXWdgW8SRA1NSKW6C8+TUD46ldWI
	TT00P6W5DI/fH1kPWp4Hgf2dxTpSyF2NkidpzwSVlehZ1Plzzk6akn4cFLYr+h7c25JNbTUmt+H
	zahDoXIl7vzOw0Tiob31NhWtt2e1rtrz6cCU9GSvec7YPMvLZzEo3JePQOqHA9A/FfOYnWBBOO9
	vnWTI83up9Tbb3nsv/IYRRr4492gNR2AHuppjJRSrgKliKFraU6ujhkytmUxvcnnavv3h/JbkC3
	IWMrNEbdgf7LYU0sxi1MNtorKPRJVFShImLFBT++hVujPTCx83jkZc0gzoASQkOZ7YyYz0d2Y8h
	gw/JJLRMZlrlXLHZPSn3F8tYjtTHAo7A78IA8VAkxDVwDqZO7dX7Oqbm05FRtCXMBYUMDNiEQ8i
	bd0wb1ZhWWRIlnDauDTt6x+RvQazbSiizaYQi7pJZ+UeOxWUivMMjr9HKau4fD9sylw7XLM=
X-Received: by 2002:a05:701b:2091:10b0:1b5:3616:59a1 with SMTP id a92af1059eb24-1b55687e5b9mr800510c88.8.1795122649174;
        Thu, 19 Nov 2026 13:10:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:861a:3517:4ba8:8641])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm1312003c88.0.2026.11.19.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:10:48 -0800 (PST)
Date: Thu, 19 Nov 2026 13:10:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
Message-ID: <av9lbJa8VlQTeatR@google.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
 <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
 <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>

On Thu, Nov 19, 2026 at 09:36:07PM +0100, Jiri Kosina wrote:
> On Thu, 19 Nov 2026, Jiri Kosina wrote:
> 
> > > Wow, what an endeavor. Thanks for looking into all this.
> > > 
> > > I've finally got to processing it. I've applied 1-14 to 
> > > for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.
> > 
> > Ok, now I see that you will be respinning. So I am dropping it for now and 
> > will wait for respin.
> 
> Are you planning the respin to contain differences only around the 22/23 
> patches?
> If so, I'd prefer to still take the first 14 through upstream-fixes, so 
> split the series.

I do not have any outstanding code changes for this series unless you
have some comments.

I think if you simply drop #22 and pick up Gideon's tested-by you will
be good. But let me know if you want me to apply the tags. 

Thanks.

-- 
Dmitry
