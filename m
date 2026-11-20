Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208837;
	b=BZgfoH6OglPKbWBPubSfbxzPbP5WaxUWRCc8wE78eBlg4uvsZ4nrtT4/G6o9mW6H0OU2
	 lDBdo8srZ/m23WUm75gzDQy4mGUji32LVY2EB4+KTrmfgDqdGCnqUN0VlV6B0xSaLM1kn
	 FAZEYIrNZx5socaJrG4PJuNT30PnznSa5nlHUdMGq3St8GXkmNFlgRmGni5xwEhEa0BYG
	 dB8an+wBpmucNVyK0IwaE3/S4X4zueRYvkvbQl9dPnvUMHJn51t8+7+OH/mtpJYvef6cQ
	 ZweZLeeyCWCOFRzbR+yLoDIJtc2+s37pBcmBvCKAdoj+kaBODGXO2EHgYFTYpKQgUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
	b=4osLPddx67SJrbdWIm3Wr7yY/2ZoPvTBi4ySWM2YppjqVQFvmMlCkZcSTzmDRkb12plb
	 nkT238WwymAJ2/jq9jiYEznHNeCdAT4nbuOvAPbaihK5V37UH/qp8PV5fXD2pVtIZM2RC
	 WyETyF8RAO8ZH5GH4cmJcPvqRBsa9zPQ/jUAlBnpIBvUT7CIfDR6KKWtRAUBkvvWEUZIV
	 ykhRuAbXWpXcCX+W7u/8nv0wVDWHPvbuliYS9egUJ2bhJN9CRQK3wP9iarlv1BHHeo8TQ
	 r6NYgZasT+CkIYf9Q2DgM+jws6A81uSZqlfDR93ZmOXYHpAvXZqAFKWd0ni+SeW49dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwVF4Jn9;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C4606A6B8
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 21:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875C4606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwVF4Jn9
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3869b68caecso46295eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208835; x=1795813635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
        b=GwVF4Jn9eZO2wRAEn0rlpvXXCjH4SynS6Rs4Y1execPCOih144WClMxXEP51uMNjQD
         ZIJfSuOKfpql7V91LVjEVljkGN1+Xavx1ldMekNwrLuykliRCACF6NHgFUQsI5MThz+U
         Wq3KQQA26RNCl0362YFySpWZk9oPtqH1lHgW3iNYTbaf+geMqyrTxuwFFliQvhl7YQ1O
         DLPS0il4qQPwVgTPgO/5TV1Q0aqCrsDtN+57aJZEL9dmU/vM9hsDQEGfhiMwV173oBkx
         YawPjrGxY5zV0n7NKVtjS8vw7b9DK3oWwHGmQlWX0YUpBcYBd1mQVKJL13snXPDx3erY
         8XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208835; x=1795813635;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
        b=HlucCgRdKsdUqVcacQrV9pFPxW/mSTsxPi0JzssHlqwGIZlvAytSOW3qDkwI20PIn5
         mW0hLMnH+HNY5Cya6x3iWdnMVzTXldB3FLX8Fbo1FitNBDfqPE0jMXY4YhEqmBsvIkpJ
         v7678WOI3Qv+BIYnqP2xvTq42/KuS8AACXoZzTnR9gYvBQNLGWR6cDILhnDCi15uTGbK
         69h5zFDp0XP0+gYOvbQOYD4YDSCCOp3LBSpte5HUyktFv/cjIMhlloYnj8rspqglNjnp
         oXS5Kjjpi+Yn3rlxrklExhY7gyjvGa2kziUajDJxcQWc6gxGx7/ENbs33YY6+kERA2+i
         kwrg==
X-Forwarded-Encrypted: i=1; AL+hErEyiPNSQNWASWREPsO91seUMzuO1jp0U0UAdTKHEKpf/Zp0VvxX0q0L7RUr36pnzodbIROPmeEtAjtdDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9VcEf53eb4gMAMd4ZF0QFgwZAmxOXqht++M739cfgqOqVGVwdv
	TIu3DzU6SGeN0MGIqlTvGuLuoupjkEtjpb9kAIxzX73MJ5Qk7g+lE0aq
X-Gm-Gg: AYBFou1JillEPaofqQkuOs4yX1WW2aEtd23nR4gRFa8N3uVcj+VItQqEnYXmSCeB5Zl
	XOwOCT9dv2WI5KlqopsmY6+UA9R4lZZ7p/z4QwkO0VF7SKLUIcrp0a2yR+2khsSLjWyx4PVNK7p
	t/qYoLt5kMQTCGoP7XfaY6/q/BVg+nxzRebX2Vf+AGc6emtsLMHrQNMTHJDPLbMAYgklYfG0nBD
	t5WuzSDAyuYd+BPa2p4jBJNk9Y523CkrZpPcE4d7WZv9A3XnpJ0alk3JEIoGbDCmm+o77aBwlTH
	nY61QiCUcHLYBXYgc5EUqhM4m0MQh60UEAz8Dnc1jwMZOA3Rt9KwflEgD1RddHrOQoZ6Evr0iz1
	RCx/zZgxrTgXx5/8rVlvrKk0elZ6t1E02fIOOFOO4FwJIkI+ueLm83n70FoSqHlwQloafbdcQE9
	bO2OLC4/5uLVnmyuyrWXJEjWfmcdWpe9v+qosGAEAotJ2R7Pj6/crqgoSQuxbS7+oOjaE9WYaEQ
	HGTU+1tBaPHnFbj6dh3QQBZh0onqm0nAyzzTDK6FGatN16JCq4fWfhThXLzqE+P+hGZxTBURfTU
	e/+ZwRWJ6iqgkvf1qmHKfaIGIPl6Skexys1zNORyqcuwsnSrA7AwZrSSwAy7sBn9F7Bh8eOBjiw
	9wKV+KjsZKc9CbJZb5L6YTfCI
X-Received: by 2002:a05:701b:2083:10b0:164:4e36:f956 with SMTP id a92af1059eb24-1b5568b47a4mr4157620c88.16.1795208834608;
        Fri, 20 Nov 2026 13:07:14 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:79e1:2e00:6c01:7cf7:3a98:7b9f:8575])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm8822424c88.10.2026.11.20.13.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:07:13 -0800 (PST)
Date: Fri, 20 Nov 2026 13:07:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <bentiss@kernel.org>,
 Gideon Heinz <gideonheinz02@gmail.com>,
 =?ISO-8859-1?Q?Filipe_La=EDns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>,
 Edwin Velds <e.velds@gmail.com>,
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_04/14=5D_HID=3A_logitech-hidpp?=
 =?US-ASCII?Q?=3A_disable_works_before_stopping_transport?=
User-Agent: K-9 Mail for Android
In-Reply-To: <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com> <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com> <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet> <awCMOvYf64DZfuWF@google.com> <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
Message-ID: <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 20, 2026 10:12:23 AM PST, Jiri Kosina <jikos@kernel=2Eorg> wrot=
e:
>On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
>
>> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
>> just applied=2E
>
>Hmm, but that cleanup is sitting in hid=2Egit#for-7=2E5/hidraw, while thi=
s=20
>build breakage occured in for-7=2E4/upstream-fixes, which is based on Lin=
us'=20
>tree and doesn't include that hidraw cleanup =2E=2E=2E

Doesn't next mix it all together?=20

>
>> Hoisted by my own petard ;)
>
>:))
>
>Thanks,
>


--=20
Dmitry
