Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127A424D46
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576197; cv=none; b=b6pPiH1x8ntNcRBF9dwWvMadCoYzqUuILMCxJsdVk7XmW5cDXRWui8pnTPrueRhu49dugM4xGvTHN0onNTBHskW7B20aam2AnAtvVud5Qu8xOEU750moQ5TSYPuKCx+kuECBR6ZsA9i0yOkhjJwVZc3lFHp7dt+YTYoqzYYmQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576197; c=relaxed/simple;
	bh=b2+tEnS6Is5tFDYWU2E8JVCbBEdDNXKQkC1xbjM0ato=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PaiSdingoS27C6VzJmEpZ/hrpmjKeH9BZV7nLbbIotuz/wwPrVq+zVNf/fTIQ8UIRQZ8CIZbAIUjK6DoS4T5dXts7iQwTpxdYFSRrOnY/efQfsRUrNsp6HoHkjcOo1VoO7MXyDsvNW+x+kwBFEIekXrK2y0llaeOajr3vp9X33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTMOtpeN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTMOtpeN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so2330185e9.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576194; x=1792180994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6zmy1rcMM7No0NS8WH+IZGD4QJSIgLlc9r4zWyICc98=;
        b=FTMOtpeNnb6JKR8Af9cMtS+gl1pZR03pdZdJno12Dl2IV7OxmyLa7T0VPH7OXg6YQH
         RQst995d75WCWqvfPUn4DL5XXYfEwJg+9asPOFeKOIyinFXIwYmaIH9B52XdKQkWP0UH
         fVp4v0waw2WyxXEfZfmJU7nnICcsy87BTDm1caGrjev+xeEdKPp1HK8RUfGq0ROclIvH
         j9TqXM3Wt/9B/152tgjpq755MJ798iXhRU3Gm42TsNtH6ddUC8+aqF+knur38deeGXW7
         U5KUC42E9j9YCPY8Ftag6/kae8AE3dEUPStDLlM6QsV0rZ5atpSbImCLwpPIblcqvLOQ
         cQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576194; x=1792180994;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zmy1rcMM7No0NS8WH+IZGD4QJSIgLlc9r4zWyICc98=;
        b=O56eBoWX8rWMjEH9wWgT8L5okOTGn7MOdU0I5/3+vLWsGaKPrQqjjYkbpg3q+nabhb
         ULf55pWE1HmLO8kZNHguEj7F/k7eeb7XyNsfmbg5AmYOnvBS3XBKmfm0OtxgyUnGR45G
         wu9TMNnUzh9KoOAOG0yFwz/U242RJhDPLIjVIrlb48JON3L5shu0yTqNntWFpyF/AywP
         jkPIfQzHCVB31zQasdVJvGAUeyOF5uwOnYqT7Ipf/PH7Picc2X/PGVFJ33DwPHLiCJW2
         VZNSSlXa8i5bkTYFTbUWGSKws2p5cgonU4/wJSM7ZcxlrqFc22Fq/l7lPvqmDJS4oNZO
         6Zng==
X-Forwarded-Encrypted: i=1; AKwUvByBjVx4sapAyD21yBdfUfiWqjThxWgIBLYeQydA1fDxYz3xIxt4wWa7mfVtN0FMPJEOIdDkX04MtXtExA==@vger.kernel.org
X-Gm-Message-State: AFuF++mleTNugvKBBBKFbXX1ZQcrkmOharjnUFFW8CF0ZKMDEW8c7z4Y
	ejI22yPUYDfJh2tOTWaaKpWYOb5ehm8qkc3nwOy1QVXkRS0xkn27kQ5r
X-Gm-Gg: AYBFou3DNazeqBzEnRMMtFrfcHgmh2tyS3vZSFVm3CUnasPTEXJmcGraKpK2KWlWqSR
	rsYtV4DkSHMpQEO4eCgEgF3rNLf6RiR60geLrOKKqVtxBrMyrkgeMPKvswqfeQiO+CaSqjj91DD
	exqPCx9rwUcm4AFSfQSGqKtniY2IZ7YJoKiyUOl7L2TCU0d4XC9Cwsvwj3/vYqzB4fpPJc4uA97
	FYNsQH29VyP5fFie0tFgkdfZcnI4pSXsvikmvjuoA2docQ+r/zRNeOfhQ+bstgDHO1PWP7sR+a9
	Y7gvGOlN4PVJ6uHGcUA799lAoJj4rt1fFrQWPwom2b2dYF8UXyQwtj5GRzGUlhOmF6h+vhIaB7U
	w98ja2Ybdcs7DtWyG1C6DIV0MxiLZ6lqQmTM2xOEpKUt+Xsd772mitDyF4WdCMIDJcTcWolTeo1
	lQc5dLsB1lV21OKejEo4rYRIZh3N0GinUWx0bFAT60DgBp1C5O+fU7LK55DdT+qmjOyxrs8ap1P
	n1SheDAoTzAS2DUwc9cNwRCfHgqv7EudGEqr5hOdvwpA5qz4w==
X-Received: by 2002:a05:600c:46cf:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a18e47ad5fmr61536425e9.10.1791576193931;
        Fri, 09 Oct 2026 13:03:13 -0700 (PDT)
Received: from ?IPV6:2001:9e8:89a7:e5d5:36a1:7337:a199:6e96? ([2001:9e8:89a7:e5d5:36a1:7337:a199:6e96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190c49d5csm73570965e9.3.2026.10.09.13.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 13:03:13 -0700 (PDT)
Message-ID: <19c6120c-8eec-4ddb-9d41-d19162e92638@gmail.com>
Date: Fri, 9 Oct 2026 22:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: lendev4@proton.me
Cc: basavaraj.natikar@amd.com, linux-input@vger.kernel.org
From: =?UTF-8?B?UmVnw7Zsw7YgTWFhc3M=?= <regoeloemaass@gmail.com>
Subject: Re: [BUG] amd_sfh: ~10-second resume delay from accelerometer
 response timeout
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm seeing the same bug on a different machine (Asus Vivobook S 16 Flip, 
Ryzen 5 7530U) and reported it here: 
https://lore.kernel.org/linux-input/6ad35436-63ac-4bc0-8d38-90ffe03b6db9@gmail.com/.

I can confirm that on the latest kernel version the problem still persists.

Happy to help with further questions if needed.


Thanks.

