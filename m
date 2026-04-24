Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F093B95E7
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038834; cv=none; b=P+LqjzRI7nGmdgFabEjy3HxavVpBPYuB1XSbh0Md4Xgli5n0c4Q3QaTKOTYFiQi4hRgQySUpVB8bTWeNrOKkr+wDBa8O586O/0M05dUfx8qYccs7e3CM4exvUkhSbIUxDZxMEGIa9GMUivD+buNtHoJCjTMOvRj/uimlBCFAPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038834; c=relaxed/simple;
	bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s9L+KE1FqfEw0yUeGY/TLCmuIOA2mqjt7bUg6dw1aifauYpCNoQaoFKra8lhuN4iXmaujgLZ8FwJM87+Vj6+Aznog7jGr2j/LBr+5QlpDsu6eqBEfxWZLZiK/mmz6uKHNJ6NUWeVN0R9zAiao2pYV/YB0B661U19Hf4KCkqIEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2TNQviB; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2TNQviB"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de5badb627so344357a34.0
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038832; x=1777643632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
        b=R2TNQviBbswq0JsnMfvHeKrUZOwgQqQiqY9HEaqjZolINYMRL3hKH4xukFQgIBgR1W
         vGU+pggx6TAUiccKFAJjxn68gZUeN+sff5oFrbJWlIPBNlgxANHbelPEIpKRgUgk6cwx
         W/LWFae6Na1T697G33USXa7NLUSyIvUaViMIxgErY/xUBzJz5nTEjKr4+xnFrt6QSu+r
         DhYvvASeLtqiHiXFgS72c90LqWpQ5GB7ikqL5T2SemUfSGikrhLRULgPYfNpEhOLgp09
         LK8KAeAqtfPLMVjTw8Sk6BCEqte8i+R9bf7A9kkJhn1Yk44KAhnNe3WYkvVeKJd415Cq
         0gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038832; x=1777643632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
        b=iErN38+KmGFY6BamsGg+R2b6sDqPvY5xddhKIBtb2tjIEoicQKyeVyF2utmxohMHpj
         sUqr/aSCz+JnzfAjoOFrVaImOoy5/DnfAtj1yIruf7KRIxbCwjXp7wXP0anAhxx1HEXH
         Ch1Pjiq/9wOJMQbBivd+lSbazuRz+9oeSwQQU7FJAWMQyCf6E+uU3dnRJ8ROvfkDd/b8
         K1s5JfDZ0kZwk+2rBXmCjW/C0m0H3EekSd05icNB/3bCJ3fWiA76M4z1XEJcGHzRR/u5
         3iXfeI3Ly76rZp0qgLZ9+cNre1Y2raqOcjNhI+QUaY82Hqj7uo4bKmHZky9F5UvHMOsW
         y6gA==
X-Gm-Message-State: AOJu0YxRHo7OPcBAqDu0VTgFXitCBtIAhlZgU0BrNG68guSpOuWXd35q
	b3fXrmrdwkFg9hJCW2wSp6FRKdvQeoeUhak+NfNt7bCj0+ZD995NnwKz
X-Gm-Gg: AeBDieu/KUNr9yQCGx3RVrdPFTlbJSuI6nPjUH0RhLdDVJz2SO6pTFi7gN7Hc5Mduea
	NI5DOCfebvD4V/2auIQrsGfzGCG8bXF1hT/kEYLICP0ETzF7pjiFRLrvf0Tt54Y5+qsXz0d/7Iy
	lo2GaSI+pN5awr6BTQAjLcqKDBvR6pq0MsPTzoM1nthBx94at3CT37LvXsIMvM79NFq9qCKDhYe
	daLkfkpGGI98oRSukKyPgbApCbIXNop9xr26779b1UuugtSqHd3vh6fOmAdphdtV1/9PmVHI/FP
	t48PbDxe2zfMHi+G9KhNvF2+XjYnx5hBEPP+j2jdM5ZOY7ezDFz1NsbLP8M3H9V7iUc81n2pgB1
	pCvQYC2YuWgaF1JnTlYnsejPddRr+an6zv7YXdXUIHHBpU0iUd84RLbW/nAN7nH2dehZ/MxMCe6
	8BkrepVRNxLZqOy6gabOl8YSPfQXkGtO+NFkPKeilyVdzHiFXYBm7kMkJrhVOIy7LM1pPS/N42F
	hDqHJbtYGn4+yPncseeg8ydLKhm
X-Received: by 2002:a05:6830:3508:b0:7d7:ef35:2c4e with SMTP id 46e09a7af769-7dc951a7664mr18794418a34.15.1777038832230;
        Fri, 24 Apr 2026 06:53:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm19196626a34.19.2026.04.24.06.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:53:50 -0700
Message-Id: <DI1FOWOLC37Y.3DK99VJZDMWKI@gmail.com>
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Zhao Mengmeng" <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH] HID: bpf: Sync KF_SLEEPABLE flags in
 hid_bpf_syscall_kfuncs set
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhao Mengmeng" <zhaomzhao@126.com>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
X-Mailer: aerc
References: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
In-Reply-To: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>

On Fri Apr 24, 2026 at 3:22 AM PDT, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> Pahole intersects flags across BTF_ID_FLAGS() occurrences, so omitting
> KF_SLEEPABLE may drops the flags globally. sync this flags in
> hid_bpf_syscall_kfuncs set to enforce consistency and safety.

Makes no sense.
These kfuncs are not sleepable.

pw-bot: cr

