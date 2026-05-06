Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BB48096F
	for <linux-input@vger.kernel.org>; Wed,  6 May 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078472; cv=pass; b=iN1vDct1iN7W19w6XJXlzjx7sOb3/kalvn3B2MSTLmfqvmXPPpH7rhBNNb9yO3CUYpr2htMZxfBm8SJI0ZiFfxKNcN0l5tdstC6OII6ZIv6KIRaoBZSJsJc4LQyibYNHYxsMxmjUW7NwU5yyP6e09o7vE+BMlT/UytPUi8hrAeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078472; c=relaxed/simple;
	bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAcVV4SGs20aU28EQNrv/+dhNABfxp0MnQK8RV6DFz9luFsklJq7mysd+XawhV4hLF9oCoyD4bcIh+AtZSLQkfaX0LHKCM7Aifpz3wodxHmsklb+uZa6FW0Kr6wogm6MwsAtK8mqZLcHH3B6BdrlDmDq00ogLRoKgf/flgAr2nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4RzOK1j; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4RzOK1j"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b821f39a12so29731296d6.2
        for <linux-input@vger.kernel.org>; Wed, 06 May 2026 07:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778078464; cv=none;
        d=google.com; s=arc-20240605;
        b=MmjOrKe0CU2TPHOHLi+VJlNS3FQOv8WhCU9XTZ8TZQlsrf8LqTYMJmtHwFRRGh4UXP
         pWWQLbK63o79dLQ0XMMkH85HedBjfduSkNGtckY1t5XfTmqTG4vI/4FwMTPqJyTZzAEb
         cu3234A43Tz701L0jewCf8FksDfachaZJeRg+z54ss7zMGd20ACYLK4bzuuIoZ9Y+Kd1
         27YGu5iOioo0OZNfnhOi3rQC0XqNsUsmc/E6aMRlqz6S3yNsvHLffR6hx1xtzCBDYTEN
         Q+T9yfZjdkL4R5E5YQNPM3WtGvfoxZF0lmIL5fK6keazpqJCXTsF9QWuDGjHdeha2ekm
         1CDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        fh=ZEXZGH7iSmELqjZbnbyUse4PnSHF7CrDGSS9V2zQpaY=;
        b=EOoZJxsb+eVquwpJKaYwGqrKVHC++pRxouSHtL+PvGEp+dENC5p0sE8G/9NbHL4QX0
         rbtonctp71MZfPBnfkeFy+ck1nFDJiiWvIm3uzQkRf308tC5sC4AGeE+amFHRDWFflWo
         xiLHxCsTS9gBvXmhtBJ1VtYmq1OfEmalgrXM2P0IdgF3Z61lF7KPu6g7v5jrRgSB6cA1
         ju5ZpJuagK4AeuhFKCBufA8VhQWx1WStMzFZQxWmH6fgGinSaLm7D4/TUR6u0f0ZySFH
         U9g9ZlFwBaYMg7lTjpsSxyY55l3C3Or/GtNYpXDkeuWoXBjfuHyn5bUUtPlbxLgU3ynQ
         y/xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778078464; x=1778683264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        b=G4RzOK1jPvFj16I4JBAoLV7wEu8ZC5fzzMQHl/bCkqLBnOAzzuGNSmeJf8nSC+1TpM
         gmt0jlDriRemYfWrW2vsqk9e3x69kmh/W9HuH/HlbHAMYvV7ArKU8ov3A4cdt62+XWjm
         Iss/Em+w7Fi+CEVEUBR30xyDvrDVvIMOJixAIPaAqsYOvzUHQc3b+t6lvD4MqAG1LYZD
         7JxOoF3KkVxB66VXZOP2bgV2p6LMWTCbZJe/Zc2qIL3g4eGHUmizWFCbZIdDcQxWlVs4
         pIiTF88IhOcH+3NCSJcjyMbOXi9UFqFlv/wlxPp6jMWjASbtQKu+Wqhu8ljF2KioRmyG
         jWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078464; x=1778683264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuK1QnuCV7KWvUKnbJetsZrammaRRqdMrHwOLDsjneM=;
        b=VDYkn36U4BUNsWETN7X8geKaXT4RU3TQ81KW5UD3xsXJwBbDKMHIeTuOzHGd1Suqab
         JErLrpsTs3XKmDHvxwnyb7FtG42i/YrJ6ntGLXWQvu2Us909OdCl9syvAKuzyjyhujnn
         8DF4AbZv8MOcg4ZAgPddD8D/ie1gjElwAs57k2ZOA/FGOddWkbU5jgAV2kVALTN9mXdF
         T1Mp5BFIIXXqBthhBYMdj61tB3yGSXbJ6BlKUhXAptdtpv+lYZBLY8f3ibSwkshx5N5P
         1CjP5pzetfpn466LvQd/bBJo4PTBAdrtJoqKZv6FpnWrQiQ76fbEuVdYtWQB+vIsJZZT
         Rm2g==
X-Forwarded-Encrypted: i=1; AFNElJ9u1k3vtRGPc0acg2p+xt+XyOnrPDd6UFxxjLu6W02x1siXmKFbMxQD7ftr3b0xnfc6itaCpihrs4DsjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrE6WNf7Ly9aLbcExfkb2lN2+ZGLOfF7VF/fsQU9m1YYEQcE2
	BIiwRT+Ajno/c7VYScARwF2rJ9BczDJ9xAp71/w+sCZpSI+I1jgqmjh7CBbul6j5mZQvCcDESKP
	z3fcdolmvZn8PXJ8EHZjNZNzbqCR2L+7jcN9p5YyJ
X-Gm-Gg: AeBDieu26YxyepHYxnsUauccTsCzrPVymAOhQVXpWIOrHyi8uDL/GrAp2iCUtgRz5cG
	NbDCi3mvJqA2SiVUoBKgh2/qH0OI3z66zl3x3lo37A8X9lDImmOL/xrn0VNebmttTCJDn934+Lk
	QbOSOKqVZTkHpg2GFt0KEVXbCFP1PtvxV4F+R8yYPjGLhe9xAdYw15xfLKdfdeRTuw+r7dupO4b
	TeKHd/oxexLZyVPoXtoCj8lGA6J/Fk0+R9NCNsVYmdCxH7hjsNNuR9t8PLY3iTmwG3PnmJ2I8od
	LxmxmjqkJ73VY3J2IZJp3eHXC0jYQhovirbuGGjpsRZYlERtwpShcVNyRojiDQ==
X-Received: by 2002:ad4:5d4a:0:b0:8ba:7e7f:956 with SMTP id
 6a1803df08f44-8bc43df4e67mr53101336d6.26.1778078463580; Wed, 06 May 2026
 07:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415114752.1181079-1-bsevens@google.com>
In-Reply-To: <20260415114752.1181079-1-bsevens@google.com>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Wed, 6 May 2026 16:40:52 +0200
X-Gm-Features: AVHnY4Jo39U_2RZihXMgVdQ4rhs9ShEG8ptg7JggISStymij-sTqDRWTDgcuu_A
Message-ID: <CAGCho0VO4kcYRkHhTH9qV6c_8xsKXX=t9YK_oLcUtUpDNDTPtA@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: Fix heap buffer overflow in mcp2221_raw_event()
To: Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just checking in to see if anyone had a chance to look at this patch,
or if there is any feedback I can address.

Thanks!
