Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB73F39C1
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194363; cv=none; b=Z3mrlzRYF2ZClyejN8cXROQuu8EABu2yUEZ+q6SFKbnmT49/zMtYzzRgxSNdYotmxCmM7KlDiCA4nBV4U2BYc3vcYhAa3kATvJK5wqoKvuOV13BqW7iUMpclY5NRjclceEnRTdnrj751orP0yF/y5Ty+t+mFaxDbru3mxinPAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194363; c=relaxed/simple;
	bh=cPmpmx+T5sAWycdpqF364kuymZ/P1B9n9CUUBg6crMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9UYWuQpwlnWhVmWfjfdf6mUI4DL5w+AEg3DGp/awH8x4zQJXZQ6xfO4qlBWqBpANz3wNzE6A3+FrN+lwgXm19BIgb9H8lIoyVT6bHqUjm+tHs5WJaCUv53cyLbG93lqY+o45HwtG8SpnZ7/TtglTRCX/lcaOp7WcHrfldg9n7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/y3csxw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/y3csxw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so34715815e9.0
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784194359; x=1784799159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMCp06Fn7LM1KbKjNDRyvgq+gIPkw0ShH7Q56EFQy0E=;
        b=K/y3csxwNu4Fd3RqfPYeUBRGDZFXvvuEx2hKSB8qibeBokcxFISgRcIb5LB075dCW6
         YIwSBVFxgLRokj4VbeS1y6s08JefvE2btKkwvT2dlWtdOqi4wwruVFd6GsTbVHZWrw6c
         d7VR0cnHBejI2XuPiDBvWM3qr8z3AEEmj0lxNviGaMj9/BSy6eOGhSf7VPbQFaBvX9Yi
         9UHEp8CtF+/a2cfectVTJ8qVZ9OjGB9HbtjNNoJRIPJJmAASPPmQNy6GcQPQdClAnSjj
         +jBNL7eTSAQaOMCdozRdaYwssyXZs00a7yAZQ7TJ2HyRRrjQjwU05z39HRQlrWblFv3q
         dr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194359; x=1784799159;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMCp06Fn7LM1KbKjNDRyvgq+gIPkw0ShH7Q56EFQy0E=;
        b=FAd+QTjvr1YqpEblNWfL6tbimY1iLhBSZYfCzHnUmQZy/dGpXcLAUUPdp5otQe3KrF
         5e1PiRV/mzGNH7rtTFK81AgQ9GQ4JcU+dvGQr5yqtGJAedvmFIjUdvR9W0GcedI/fyLt
         HtMhf80TJwsPIKWm8GEZu/EdNzu19w/DnNtVD2EibS4hnNxj30p8QzQxdqWh0WM91J7b
         JdWYZdJZ7MPYvQ45aLKTBcbxrWaRArftE95e8zSEIgJDdKYYg0Xb7Hwe3Dm8HCRYMtFx
         fqAk2RsCc8ngc/p9A0J9qEN4E6V4hiJzv0HYl0wbpLz3GkY5KXJ/abeyJV+T6oKeURoA
         bP/g==
X-Forwarded-Encrypted: i=1; AHgh+RqE9Y6byWc5RI3CUWQZ5ORIEsQazki4N17SrzlSqFeH4MxptyMvZMwjahp+FfnPR2NWZ96W3ZJ4IKGCCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjOPqhKiOw11EZe0xp/bZuQHrQPIXGUtkESar9xRX3ZA1yS+2
	DFdM5T0EkVQ3HnunFL7/046zY051NM1GpbU+dECpGR/2VLwpE6U00wEW
X-Gm-Gg: AfdE7cniPzuUp0o8f8nJjew/R+O0EqgpCgj3JhKTjrhWnW/7aXTYPrmrjgd0xDLXpmO
	eyb1Zb6guZzQu6DhU7QbeFJpSbYl2cASxARZR0sSdfc7Cn+Hc6tJ6fMzYGXVmFam9gWVxeRHhii
	ZRImLrXcYWLB2+xwLZ1icXT/ErTc+YFXAW/T39aKMLeRxhFh+seFUSFmAYbDF9YNV6mSPhfIM8p
	VrBIgG0fFuBIpkQbX2Wiub+1Dfm7uHK+qHg5B4J+Czx8OzLTUQikNBN2bc5jM26czloUXUna4Rj
	7gOVSZiiHI1IOxGAhmIf8G78sX+pYKrBZYO1QLk0oyUri3vrFYyR1UnNYn8GsC61WxCseRX/oct
	oUE7vob0EBmXQlf6WcT7qB+CavCWecuDdLeIr+4Dt4lqDpRmryV1E7o3GwCo0ddua9RFlVIfDGz
	ZLRhD8GaR+iC7MBezL8Z+ggLvq/OT6pLPlYIS9KI51kexMX3iMpQ==
X-Received: by 2002:a05:600c:1e0f:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-4953c280b8amr61833475e9.19.1784194358954;
        Thu, 16 Jul 2026 02:32:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm40799655e9.6.2026.07.16.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:32:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:32:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscpy()
 helper
Message-ID: <20260716103236.28c1b5bb@pumpkin>
In-Reply-To: <albg4Rv7QxvLJD05@dev>
References: <albg4Rv7QxvLJD05@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:22:41 -0500
Ian Bridges <icb@fastmail.org> wrote:

> In preparation for removing the strlcat() API[1], replace its five
> uses with a small append helper built on strnlen() and strscpy().
> 
> The five calls append device name fragments to a basename buffer
> that grows in place across the setup functions. The helper takes
> the same arguments as strlcat() and writes the same bytes, including
> when a fragment is truncated.

You can do much better than that...

Change w8001_setup_touch/pen() to return the 'const char *' name,
then put everything together in the final snprintf().

	David

