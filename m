Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370690;
	b=gBOiw1asWkq0BF4Bu2LjpVc1DUOvkqSxVrun1rzaf2pIhbYT0v6RExnNAHdrAvbc8VBK
	 ixcbgv6Dxxdq7QNjDE3XgrsttcU2xmFtHwU0bYvljQQ7mu/gibbP30ugNT1LcJftwtB/U
	 YoIMuRcwqhD5fbh2LBZJjXdYX21fFuGMHnKXRS64Ox2pnWF8KvSEFt95SJn7MgTeGLlkd
	 FZJQxpoB824xWa2R2gi8R6bs8M37kpPk1BfSgQCt6Cegfe283e3nPeArp75M0wXY13FLY
	 mgsTMC1TnOU76dXTiPF4UqQStRcUYkGRDBPDTYwh/XrTpWb6nujavyNjk7GHONoX/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
	b=EsV5lKFE8y9HaZuxtW2XF01hvPtaK5+B+2AOgAlPVJtFzPbtsZlKtf9oU2bjepIT3JQM
	 obO1mcuUCduco0iztIPDpDr0olHKVtJWzOo/72KsAAGOXtB2kmo8t+gC6EzZFsChwcgmc
	 wx9dQH7v5qTgVFEEnH+88672YepYMGV9HAwp9Jsi518bf53obEIdIKYsll7gKDP1N40c7
	 XyHu0Hd7nUbkgCcNW+anJ01mY5tTgWrc/93QxZVd/RQcELImYwB2dByckIkQYhldv0kym
	 EiCheaAPkCynOcbyuflKSAF75mWCXA5OxC+SSAtNOoEYnHj0By0BopXnCqAqA57thEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PReePLVE;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1F606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E1F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PReePLVE
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b88b74e54eso2960107a12.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370688; x=1795975488; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
        b=PReePLVEWnbnWB7EZiZahXGuNykDQMdLn5f5Ged97JYaFamdmkM9/73LSql4BJtXWU
         vUHgFkzdX9cavArolTyvMOxU7wbnh3HpcDEVG43mewnGjl0zUJrj70TT47+SVhiw8+mr
         h4o7hKTXsmR0PmUBDOOvu/O/nh3LmAt6/x8w8C+1mz5/Z32t6I90u771AZOPCY59HW4x
         4vZThqAwyfs/lnd06ePKqQ55rVkKkk91+lfubE2hihyDHy3VC70LgiPgZxqnvVpS/QsI
         vsPimUHfhqhc2Re5Wnr0DE1FdaC8cBaIO23DozTuBxNL8lnhUGCuTkyL/poRfangXI3/
         nvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370688; x=1795975488;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
        b=yOVN/j5KWz5F/OQIbqX/R5pI2dkUjJuFVaBvZHP9YmJVmUHLbFi/sgbWoc6lxIqCuU
         tX6RnKiiEjWJGuBJfYLNy8v3yQ3tIldz6/kd7sMnWUd1pouCL0ZSIXC0dbeJde5ecTrT
         kj2OaSikl87qdKr1s+zzRLDkrve5p0btYATDKUSMwiHSrQQKzCWoO6WtT2qSQWllCgJo
         KpjSH2K6U6GlFmo3uMmlMUV+ikC0mc7pPwKcSXPqwVz2NeDi8os9RCQVDjEJRzo8f4Kl
         Mvonhr1kQkAtB7bHGAWst8vNc2Fnx9/wz6NQ9UNfvMOEuywFxI7znWvH00Mjw1NWH2+5
         tHpQ==
X-Gm-Message-State: APuU4Z9bMfEths1DycwGpFWXjj8go4S3t+AF9QY00TqDmHc94dzG3vYc
	WLI55xElB+7hfB9RwSkYePrhLDG7qeOlPN2amivP61KK64LdvBZGCequ
X-Gm-Gg: AZFdTZfeg9snT5ab+/ptrc0SvXfi9XSti74DBwDxBwMIxBtoVpJ5J2QcSjAzk/uTwwS
	/PG3LAEbeTdSSsdx93LWjYg0o5h5jkaG2F5lwnlsimPapeWKpS0na5lcUWV8bsLHRjYh/LInwoY
	xNQeMA7j6yNnJyXo8dBW23Jc5G0YXLccqW+GTIA4NwZndw87B6fl6z16ew6/Irnmv9NYU2Uzk5+
	XrxDsUDNrKO4af/SNMevOeBLZUpQyEQFKK+AglB7rTqrhpVtbq7bg3BFHrewAHflmHn5KxXmUy9
	4DwwdqF+YufFad6TAWMIgRkH9n9XcFF2fmwd7N2hM4+YO8fxjZpKuZFolVP6lGjH8E004BfW9XM
	OiHrMspD4QirmxEwFisdleGYVf6kC2rgkzXj6qXm0tcrzleW1zracOyjxHsJsDYoH1QSTVWa8ZN
	dxAFD4YtzcFhNJY1Ps4ez1c61+xUpUXljn01+GiK/dViwAH4OXJj9HWncMIEC8hlAQohkBx5IDM
	8rEvmkIaq6u2cKyQPVWQgU5slBvE16H3GSW5V1pSuI3OO/hGEb8dsfkZrzB0iq7dOn9oCTO9D9f
	Qv31Np/mLmU9hRfHzmmjwQBC1e8F
X-Received: by 2002:a05:6402:350f:b0:6b7:e608:d26e with SMTP id 4fb4d7f45d1cf-6ba37ac7f23mr6591721a12.0.1795370688303;
        Sun, 22 Nov 2026 10:04:48 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cc257sm4046910a12.13.2026.11.22.10.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:04:47 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 19:04:45 +0100
Message-Id: <DN1XSIP8JQKI.3RAMYIOW5EB6F@gmail.com>
Cc: <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: input: touchscreen: hynitron,cst816x:
 Add supply
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Gerard Marull-Paretas" <gerard@teslabs.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.17.0
References: <20261122093405.70406-1-gerard@teslabs.com>
 <20261122093405.70406-3-gerard@teslabs.com>
In-Reply-To: <20261122093405.70406-3-gerard@teslabs.com>

Thank you!

Acked-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
