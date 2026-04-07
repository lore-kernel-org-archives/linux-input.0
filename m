Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB21FF1B4
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538743; cv=none; b=SBoiZN7ZA7YlYtaeUeqgi2IMDjdFXECHHzGWMVHsYzlLlTfT785+fTejAjJCNC/zlwX1rlHpiRgi2ZHOZ6OUFEW5O0zbZYD2BUAf8dGOGpCAz4HWrAr7xhldeS2M+DcMYUKEyKz1Rc7PF5rHeeVYGWhZDii07GLqt1NJwn2HLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538743; c=relaxed/simple;
	bh=NvIgwFBoRmnGdZdeZvaypcoTTtxYs4s8WUzw1wl4B+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq4SVQf4z46t/Gf3THdmHkxsvputsvUs05ZzFJ33scg8NcgjF8tuTGaTenYIUrWVo9klBOKAmeoYsZtv+EnJ/FZVzPSahKbRlIzAGDHiZc60IFlYVVnoYYGDbWbqLexHXtYiYYNWmlq6Pjuz3qmuGVnBzLw9xrxcARFvSJhjx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJcLPyZx; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJcLPyZx"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5755650eec.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 22:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775538741; x=1776143541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fryNqpmXT/hLyfHB5KpmBEVnPCa51Kg7pCyMCICY3II=;
        b=fJcLPyZxlwAX4b7y52oYK/ITLe26bOjEb7s1g1VKE0+2F0sbuHN7IWxlpuDWOqDGmx
         pGnULHQRZ2MuCc17NzBTXxUE5gBYT3EWet7jgdCcVILYNZyHHRGMoXuyDaoTPVdUfv6Z
         O5zfK6q7yXy8L+/baB14DMxvk0Csfc1AFQtyH5yowuBjDlvyXvXYK/N+Pg1hbCahuLrq
         qGGyN3bSn2HY4sfikfIuJhYQbWZhy3qYeterzuA+SahAiOxONY6bqrGHGNla4guNKzn8
         kNp2wSu++OMcmuWmkUmZgidq5axBKf+BbzSpSWnXdAs20BFOVrHmnBqd7zKGh1JyjxiJ
         DuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775538741; x=1776143541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fryNqpmXT/hLyfHB5KpmBEVnPCa51Kg7pCyMCICY3II=;
        b=JxBVF5vFmUYTpMUk4sO6a3NmvgIl8TZhYEFhciXSWSyr5xXjwF4kZCjOzbWkX5gZs2
         gMFX1mSodoelJD4MDzY0Lebx+MW4CLVDkMlcdp4PJtWmAf/rG/4nbmYiNwCMYm1AyrwA
         IAhqogZBNFU9TTIH4gj127wdbxIKtjPnNfzpM4hrr8hgKvfhfzy4on8Zp0k8WmeliA8u
         hfRPZ8oaTLaKz5HCQtdwsDL+b9tib9xkvSAhWYiZv4OCI97chhr6Hf0y3IyvjidUgSUn
         72D93T8VW0h5/hPs/y8SYSP1OjOKlXMwRjKhVAHJ+XUKQtcl1rCcj35AhP4NrQEu4N3P
         6eSw==
X-Gm-Message-State: AOJu0YzoRzpbZ6rG1xMy3/zbgpgsuox5rxwH6v2LWn0MWzW8f2ZtLP8/
	/V7uw5/xb2eUC+PRlFLUuNyOK6fZ5YiTy1Fxobow+ctxe9luxtAMI+kN
X-Gm-Gg: AeBDieu90Y5m+cZEiH0rUZU2XtARcqnWlPw2II/d2m3UchfDngHjkJoIa8zKRiQ/Ms9
	wgxjM3l/pRgq8PTaR7F3GBsESYFlo4zrUWRlYhGt5F/ykm4qvky09aVC4zJpdGmE5XJkpa9APi9
	zwNI6Z5VUai0OU9ALY3V0RyoNoISPldAIP7UJX4hH4NFbU+JeovG9BRuRzoq2p2ComdM2vJG4vU
	YNJpdVq6TuQJEtCS0VSbB0n/mncqIzqZO5EUXBJzXhbdXetvtcO4fcLZB9yhWoqthVTNzm9WkCe
	0A5Cbye4pIIrStqbu9SK9AwmRJ/s+M9N4i/Kyv9lyULj2lCxZIyh6/b0JEyp4VJYdjHu1AHkMp8
	mhaZYRTgaz8Llg56cQDmB5J6FKBfwn47UUDFtBxneSqfl3fusO0PGcrNG9ZCxHvFoRHqdsJdGMa
	akFieF24zcRURP95zT0UsjOjfRjJ+tk5H9OVFAJhPyxlc0366deMSpNkNX5+O4poCXI8wbi+xBE
	5Y=
X-Received: by 2002:a05:7300:571e:b0:2c3:9406:d574 with SMTP id 5a478bee46e88-2cbf99ef349mr7235195eec.4.1775538740798;
        Mon, 06 Apr 2026 22:12:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm15834673eec.19.2026.04.06.22.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:12:20 -0700 (PDT)
Date: Mon, 6 Apr 2026 22:12:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org
Subject: Re: [PATCH v2] Input: gf2k: skip invalid hat lookup values
Message-ID: <adSSLtg5CeugykNO@google.com>
References: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
 <20260407120001.1-gf2k-v2-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407120001.1-gf2k-v2-pengpeng@iscas.ac.cn>

On Tue, Apr 07, 2026 at 09:56:52AM +0800, Pengpeng Hou wrote:
> gf2k_read() decodes the hat position from a 4-bit field and uses it
> directly to index gf2k_hat_to_axis[]. The lookup table only has nine
> entries, so malformed packets can read past the end of the fixed table.
> 
> Skip hat reporting when the decoded value falls outside the lookup
> table instead of forcing it to the neutral position. This keeps the
> fix local and avoids reporting a made-up axis state for malformed
> packets.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
