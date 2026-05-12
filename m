Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33A19CD03
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556195; cv=pass; b=f5IEw+jML6OZP34FyPAE8m086PYTBh3TuDoci1lVaazDixFLimKuPjI+IOBj/WV9P7ibBKzrwTbUwLXaC98T0f0aUul+g9+ND6NQbw6B2eblAuNZS8S3QqpB07dKV2XdBokojGvktcnT7CUJ5PF9BQwtInfaLV5bqel6kMYRyRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556195; c=relaxed/simple;
	bh=E7iq/aL/xgpSFvAV8M6VI0zRLxJN22qDfKQRNMALdHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suwV2VFe80Acn/2Dy/zAuSk1yr+BLBK+D9IEAY7KO7RsrDAXtYIBnJCjvRqQwxd7JoK5iENzG1gp4CWZeckIdorE3VuHWaiBhPYu4DG1IoVNfa9V0Tg8CW96fRR8DzzRDBB2OvSRqKTheqUC+L0pGlm0Xp7Ym1N7Z4obgIetvq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut9LKsgO; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut9LKsgO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-452169ae568so3742297f8f.3
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778556193; cv=none;
        d=google.com; s=arc-20240605;
        b=lP73WYEZ6+LzCRmVW1AHOH8Mw5ahHRr2zkRxuijY0IAq6jxT4EOkJZ3+2QJvqPUABo
         OKqj3LRXo+noBESc7kH39Nzlz+bwp3XyuqVP1WPEhEcHbwGU4O0G1gOVxA05Uk6o8uGG
         TSg3mFpWOok/TdIrdpz8kkPCUUgqcDgsQQ4qY7S9VVWnXT8QwEd5GebICNNzQYNzgewN
         SUvn269+kxQcs57f7xRETmdmtnXGeOuHFmydqPYtxWTFMVvaV/XgJwufcGLPmiU6SOcJ
         xyJ+rulSbxhyr1uDhFcfv2ugrgpRsbs6x0Fb0xCpZedVB6Ffbwl9OAKDBMKSY6ID5G9n
         oXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7iq/aL/xgpSFvAV8M6VI0zRLxJN22qDfKQRNMALdHc=;
        fh=uMg/krFhgBJOkuZC2XLMtWBqebliJQJqp2DWI9MmUSA=;
        b=fsjctrKaMQOudJxDPBS4Z2nDLuGWrQ30pn58jLaWlzCnvW9+twYhvaw8RerM+BIi9a
         7SIktjG82QEZ5E9FB/nyW7fRC0pEZMd7clIhjHTtMqO+jxUnDBJ9yLHImgTYcbTxTM5C
         3RdwcMct1knolYjr0eSjKHrrbSu/ubrf0VuOKdlqtXMz48uBqMrL+960r750MJKt1pgy
         ZU9sncc6RnmZRPf8Q63fpdoq1oy/2idI5raPnzqp5h7nTRnvGf9qeY5EI32ESWnqUGeX
         Mgk4f+Gqtv0A47fGed5USexV0VSOPod94tKODnyjsVfWY2Jh/GyMBYH8CwzvVANEL4L/
         2j9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778556193; x=1779160993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7iq/aL/xgpSFvAV8M6VI0zRLxJN22qDfKQRNMALdHc=;
        b=Ut9LKsgORuc0Ty4zdiCxgpfLFfkMr+H7KJ+bp6QoKC1HI7RwZZNQgmrTWk2bEheTtv
         H3nIQXJDuK54DbQGESPybRE54J9EX9HLrK2mbHIrr7WC4L+WS3pxBWrxCF5aTfv+ir4e
         VjOev9yduEkzsdpbH7kH9L0g4xXww7Mr2DZKKo75VTqerllxbujqhYpPyt2Y/jr1VGjf
         rtgLFvYSl613kgi/kFmfgiM71hsxFL3FieIAw4791kMLWXSqxaWpZj7xxfhA9GHAZadI
         +EZsAI4/qUAwW865rmwU6CxUU1/3Xg8xyv6gRo/RUz5HfvgOXGo1ePVWzT9EE+mpqq5S
         X+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778556193; x=1779160993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7iq/aL/xgpSFvAV8M6VI0zRLxJN22qDfKQRNMALdHc=;
        b=JLtFV1BGi2CZxYBfBZxhFYEKAAVMa1VUMXdEegc/eOhy7VkbVc7P2dMP7rrYcHJgRK
         orAY7EFizRKVxmkyxDH3sVyhUknL7w5LEdQk/+ufzYs4CbbI/54KHaF/B+eX+6t3ruzx
         LpyHgKevDVx3Uh0K0kxK/Q1e689PNFyhKQDrnMPmbkHN4jdKBqWt0nrMZFyPGKR7D7n5
         wc2eK0HJuo9MO3SLTXMhFFPhFpBrc+xAlYKoFlxkH2Vx7UTSweghXR3GfeNpTSbk6uVV
         7XLLbdLoYVhJJWZCwReZj/kR9oTCupSg11NfLL8YE9fBx2V5J6LHFnpzwka8A6o+GyT7
         SdjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+1fxjquQZ9AEtO/MeWI+ETWCIMFhVe4BrGTeO5bTm68R8pCJi/ndOuFx9wqQ7CVKaXpZOXx91VrxNwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjK11PbBkkDF3FBoGeXRprK7iWV2QSykn+K/wssOU5jYq+gwUA
	HEkLMzRMijyL69nBb4o0VbeVVFvA3PU66RIMKKBMgBHQO6u/D4gj20+gVxFc5lfKeuQQ7vwoBIT
	buXlnkSW1DFAsAxJN+1XGGd67tacPfIs=
X-Gm-Gg: Acq92OHg0VcqArCnz1T0CBYqntIxsHCziGKBo1sDZPLFSNc7sx+W/ISBXF7aO+MMK1s
	suIveWiYkdUKjq9aqZhABhLMMO4ChDkJk+FNmLEg295oTtGrgRmrJDJSO1ukdd8l3IFZXtmwDrR
	H7LNFWJU3zK9NyBCBBc+F2ajbJfdSgbcvNjEgbbv14IT90SA/g8NYKCWGgYkbVDEKDahs9WPmbO
	K0rucxQX7qBCy5KKk84Rorbv2QRODdHvrdvfQy1lEArm1gQt7oLNa9mqfqwnW6C6wag8G8awozt
	r2TyvRc=
X-Received: by 2002:a05:6000:22c6:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-4515b056c9bmr41045834f8f.7.1778556192946; Mon, 11 May 2026
 20:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511054003.1205-1-horiiyuk@ishida.co.jp> <20260512000455.44AB2C2BCB0@smtp.kernel.org>
In-Reply-To: <20260512000455.44AB2C2BCB0@smtp.kernel.org>
From: =?UTF-8?B?5aCA5LqV6KOV5qi5?= <yuuki198708@gmail.com>
Date: Tue, 12 May 2026 12:23:01 +0900
X-Gm-Features: AVHnY4JXqiCbgcaO0dSCCIbA4hH7sZTeBdkheQnG2w7s9AJy_5G5rzjIoxrlA38
Message-ID: <CAMARicOm-QwVrBnR+giVjzqfJ4hZP5PwZO7+o9o_SkLhEtxUZw@mail.gmail.com>
Subject: Re: [PATCH] Input: tsc2007 - fix resistance calculation when A/D
 value is saturated
To: sashiko@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	andreas@kemnade.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for AI review

> Does this code read uninitialized stack memory? The IIO path initializes
> tc.x, tc.z1, and tc.z2, but it does not initialize tc.y before passing th=
e
> struct to tsc2007_calculate_resistance():

I knew this code existed, but I didn't realize it hadn't been initialized.
I'll fix it.

> Is it safe to return 0 to invalidate the sample?
>
> In tsc2007_soft_irq(), if there is no pendown GPIO, !rt evaluates to true
> and prematurely breaks the polling loop, causing an early pen-up event.

I'll fix it.
In the original code, I had set touch input to be disabled when the
value was 0, but after submitting the patch,
I realized that setting the resistance to infinity=E2=80=94rather than
disabling it at 0=E2=80=94would allow the interrupt handling to continue.
