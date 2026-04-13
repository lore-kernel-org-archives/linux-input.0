Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094963B892D
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094073; cv=pass; b=s/ynsaLL/rU8gKO7NtLXoSqdwuMbHInN12cjWmc59mPhWZ3zkCB2bUMbD71gCmOzMZd2TielRNv9g6/HH+ucFmOhP76cOzdThBYJOb+cIxYbCawpMGtE7w3a/fbGnvUbQthkTcBF5as0xZw9YJKcWvebd+jqpY+9wa89qpfGljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094073; c=relaxed/simple;
	bh=Lx7mSmWNuqhAb3JzYsS2ktkY930n5BfhAYA2eKqnt7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKZdogKNUpkMb3wjo6KdMV47MSB9c4TFDnSAvh3vzIzbIjy2unGqiZR9EpS6GXYaDp0nATVeWWVqWTj1DumfW82S0sRMtOAngCoAR5HSc7ZZCkqyX7ANw4uEH2DZkRgRK4Rm9ElmiHmJl703iN/3SDNQS1ehU/a2hOvTsXi55i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZtu+9Sh; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZtu+9Sh"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e0aa4221fso36428421fa.2
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 08:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776094070; cv=none;
        d=google.com; s=arc-20240605;
        b=UYPeizIlsuJD2LX0wiGKXMJYVpVjnDfH+Fu703SvVqt2cw8eXkvOrkW1WxQ1xAkb1D
         W78FrTpZMKs/EGm5W5n3g9eara9c+TkFkF9V9fSn5b5tk60y8l3clAUt1icJSBFI+fMV
         wDI6zU7Nn0iOm05f1Uh9oBJgB4IGDZ62P8O4CyTUmVGtBNbTi1DFImWBRGmRp5c/nQYO
         xZf4tY80vWW46qgSLXiznyWHXyrx0yaS5OHIX3iO8TxZPD8jAorz4RWwoWQEUnKSaRo1
         Sb1mFWB8O9DlFZxjcd2EpIbgmELFwQmGNzDvpuT50EWOGm1Yl/s+gUgckqrWi7m54ANd
         4pWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0pGsJDcYYPaoSb+N/DQe6j8/EpjcgYmn6nMpH7yvuQE=;
        fh=PwXiFISfaeotx0XACbyD/kJOCXsRxgBwh8Z0Ruti4Oc=;
        b=lnfO9j1xIXVKS5/ht9z6JzEEMd7JKZ264MjaBL2m7K1tVlUsZ0JzPKge7Wl/MXOuHp
         ZYRHTt5/nlQclMH3FoC8JBQdSmk3KvXf+lFSTFnHkLzZsybSKRwvNpz2HjfGV3oTRqQ5
         y6DXVT6CQLL8RmRlrtGBp9TZjGGwdXP4c+ThTvaNz7iObinPUoXphcEvnjmWiXkjOjyg
         hzP8zVcdZzW1q0sOnYZfzdnmV8glJgLvXzcO6K4SMXNXs8yLPBN7BFQUYF+L9BNYgioE
         KIBef+S8vHFtn5niUtJI8GNhT60Y00HNJVqUBROAM7HXRwT53dWIl4YoUBrT8xpgqDKQ
         3TrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776094070; x=1776698870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0pGsJDcYYPaoSb+N/DQe6j8/EpjcgYmn6nMpH7yvuQE=;
        b=FZtu+9ShYzCXgqgFD6oLzif1hk4TekYpPTsRUSjpgtbR42wTXft9v/msyUFukeK7QO
         HPl2ho3IiBCafk5r7T5mFKmGJ32kXzF1Uw52uPe30SJZc42PGONzAeXfmNWZbJ9tULX/
         XegPJD1Mhjky21aTdCZzWfIYkUKjuYEttvwPA8zdZ3FXLGMLZlcXK4rj3uUtTLaT6vum
         h7NQG4J8oUpbDg+n4RkwwiW3SPdfNEz6gvsMTpuXPvEv/AXMYcevNTK2wAhscBH5vJr6
         f0YhL4gm8nU8JsnnxpzJsao2pNlxqkZ3qVPqaekfkRV6V9G63c8PGNMEwcCJwcJr3ZaF
         mnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094070; x=1776698870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pGsJDcYYPaoSb+N/DQe6j8/EpjcgYmn6nMpH7yvuQE=;
        b=DDgtPg65QkRMbZRX0GStRqhelLp8F1LqtWB7qgZortqAQlTtuBkGArVBFCu9fuSjrW
         CsS2aad7WGugsCr2HvoJQP0wdhGDIvbzGPkzPxL1v98i49g3u8aSKMcd1rLrix9sGMJg
         XLfhjKwFeJ4bw1+PVXr2pMIKcGJe04Lli+3P9FIV0vexvnOgVUr0/qFPZs+e9s8iwiCA
         z8dqzgYO6BHYgm1+s2wDbtYZgtx/1BNWJHICysLNMhhz0yGjPVT6Yl9ZpI7iR0OF8tHd
         7FP1p3ADKt8ouqf/rpogGJNESbHUPCLe2jAxlR6kdRPjgjkTtnAJ5bQyzi7Atn+9YfNf
         Bytw==
X-Forwarded-Encrypted: i=1; AFNElJ/+bRwW22jqyJU3OvGXfeDTSw/whAhjv856TCkPyeEKLiy2pHpzL65VXFOxL8JARMBqmvr67MGc4PTvQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqf8CQe39Bim2wzEyO6+MqWjiEmBdsV4i4AUOnERoAADUBcbn
	vRJpHoSlXqUCSHYiT+7APmfYgY+qlzfhV0nUPoqRPw+DtQLCaQviCCIK7KIiaS1X09TuWAc2Doq
	HgGo2UNcq5lSCf3oNrYDJNX7pT6LcoWq6zpAFTqEEiwX6okQ=
X-Gm-Gg: AeBDietEUoFpIhtocFQMHlrsCSc5j3McdHVFD7hHHnd6Kg7cygDp2L8xfEBIfZnc4rg
	FIlTvajiUMUqBdr99MufSQvLfmX6kWT+0xBFspO0vukmdn73B+cmhRJb75visCURTZmyIFP2hXj
	Qk25kwQ5nHoyHpJTppVS4n68EKzZJrvojp2WHCVNMlAVmLvoZVBWnGDiwUkFO0aBwBVe9xtNLYb
	KnDxy72Ha6CmL1WSAlIzDqH7WoqtW+K7ZxM5qvLzZe9xKUpx8CaX+cfMLwbPDymUahLLfw3RykO
	vehzhWwK
X-Received: by 2002:a2e:b8d1:0:b0:38a:4dd3:6a48 with SMTP id
 38308e7fff4ca-38e4bf6873bmr45754281fa.26.1776094069756; Mon, 13 Apr 2026
 08:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403161806.31908-1-utzcoz@gmail.com> <0rqo1ors-45s9-n22r-6qss-2q3q96n5r6rr@xreary.bet>
In-Reply-To: <0rqo1ors-45s9-n22r-6qss-2q3q96n5r6rr@xreary.bet>
From: utzcoz <utzcoz@gmail.com>
Date: Mon, 13 Apr 2026 23:27:38 +0800
X-Gm-Features: AQROBzB3gR223WZke0FjrRvM5Z6H3kJbUzEdrbS0uvxOu947yN7OMRf_2rd7ydo
Message-ID: <CABu6A6Zc2dq3q6+De2m35mn_xRom65iJoQ3Mqo_gh1RKnhYfzg@mail.gmail.com>
Subject: Re: [PATCH] HID: apple: Add Niz keyboard dongle to non-apple
 keyboards list
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

Thanks for your review.

Sorry for sending this email again with plain text mode as the
previous one has the html content part.

> doesn't really sound too well established identity to me,

Yeah. It's my id for code contribution, not my real name, and you can
find me as a real person at https://github.com/utzcoz.

>  know that the kernel documentation is now a little bit more liberal  about not having to use real names

Sorry about it, and it's my contribution to Linux Kernel to resolve my
personal issue, and I didn't notice this rule.

> but "well established identities"  being fine

I also use this id to contribute code to many large open-source
projects like AOSP, Chromium(although small contributions),
Could you think of it as the "well established identities"?

Thanks for your reviewing and reminder again.
