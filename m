Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8132571F
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538353; cv=pass; b=nEmT5A7K1rEiYr1fh3zjKj5Ox2O8YTGDacK3xINM7n+YQ81miSNxNff93UuCSuynf+60GKYeTlCL6hgVPWEMJVtEz43yp7lc+HgVt1BoYjNAC1MV4w+91ak1Augzk8CDxv/gIulkTz3bEm4TEtPmBn+0db3n8KVTc4OGEvSkBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538353; c=relaxed/simple;
	bh=m1bBFpsk1Ivv7Iit+aMZCilsYFGqwDPBLdRzLFCx98c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXPO8IjgMZNwGZaXcMA13b4erBtWLq4z67oi/+1ZI2Taan4fIRbb+ZanZMB+WRdTwigR2V1W1t/rWQ95GkPsX50wuzw79IEjoh9HeY7MbXlKHH1FM2JTKVdg0Ca7RFdUPXHqNX++7bHHMSLtJH92u4pUuOBFngvicexVA0vfKoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1M0R6Wl; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1M0R6Wl"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a1b4dd40so324229c88.0
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 10:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769538352; cv=none;
        d=google.com; s=arc-20240605;
        b=TxGfzotOcf9WkVXsk3U1ssY7RKQ8U6jS6qoHN21nO3KqQGnOUH583H4ECp2EqWqHd9
         GbPPQYtG52SyM8U/EF7Pg4KLhbSUNrE7tDK+FLxRkOHONJq/UFA6T52AJXz/hV4n0UQL
         zV594qMQQ/asUEexIrfn5ZgIGaifSRLrfmeGCXtFPJbk9rseBC1od+l0NH0eeK1ddnVB
         3QQrYYFyh1HDzh7D2TgDQoJl5hjpOXBhRPTRC+nxbWnIMbYahLH1xRonQlywNFpXUjF7
         pTObpaB5HvYt55/kx7phd2918xE2B694XtG4pdAM8GwBk8yIpF8U1Z0Cz+gJMb3x73Tm
         Bx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m1bBFpsk1Ivv7Iit+aMZCilsYFGqwDPBLdRzLFCx98c=;
        fh=vVW2P9XsfiWlFiQEGLwd4hPrdV02c0CItMrwkzmAqGo=;
        b=OvzfJGthoVk8vhq1YX0AmC+gSMcg28SGjuscAvpJGXhitk6/ghjWKBbqQwS7lys5mS
         relRd7xl+BX/gVV1MlopL/XUwqrIlNvkPvm/QKNb3Pbd086m2jZDEBhOOd5j28FhxdgB
         OE0a/tVLN+diFaRG9VgL0GvhUsnFSGxSQPfUMQ60Rszlgj0PtVqs6J1prbh7r30DePne
         sOc1y/M1GvxrcZahAAMtiDtDPu5TrOiKmutnObzadYrcSMf2/+22yG9ylsjtungzGYBW
         VkUny/z5UatC0D2X+CIzNwGY/UcpxsN/9lcng43L1h+B6RY6gj0lm/WX7KoHSj1cP/q7
         nszw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769538352; x=1770143152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m1bBFpsk1Ivv7Iit+aMZCilsYFGqwDPBLdRzLFCx98c=;
        b=H1M0R6Wlng2P8jFXTxXt+80YsqAOejSsESpsCVc3XRzPnKp2Qab/ULk6iziXxRWmmZ
         kZLJmaxoVfkccM6aAtzQ40mF7GVB8ZG90+jTAPnebyq1tDkZyVSVKUng7NqiZzSxgRTM
         mb8q9CG8jZ4GNITSiXDL5wW7sDOuZAtJbKzK4KxOoZGIN+gmB64xyWV5UD+RpqQ9ykjp
         Lk1f/ONP2RV7IM48CHAr1uNzaRjAYjEoDzclQYF91PrMHnWpabFV/tZW20uDG8NdHySW
         xsMQDvTtlTpKU91ckarJlmwESSlRcL+5Gn86uGSaB9dgUdKxtjMmnOG9GRzI0de6CN7y
         Negg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769538352; x=1770143152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1bBFpsk1Ivv7Iit+aMZCilsYFGqwDPBLdRzLFCx98c=;
        b=OxvQIqCuCU2J25nuJT9CY37dOaxVEon7OhTsGMubRd5X2x2Zd8cj/e45hutr1wyrH6
         rvg9W4szLY4myDj+xklcYk7rb0YMEEk4huQ0dTmT1i/RLmFkXct7g8Tx439bvOSxqqhZ
         mJDXNnrVoykj+ldJypIFZiEiRw7wghOVJwZucmG2Eab8/nuUHTVLvw7syL8RMPS03Agl
         v1IC8hciZJvCl9hQQondij4HisDnHmyXRjZUq/7r0e/HEZpUn2cp/ijaYM+B1LVR2rgM
         XJflgxdpQVZRW0eVS83hK3kbCgzeLHBJZRk+wMZ+CutU4tAl3mLaomJzs1zzW5iTPX8F
         OEyg==
X-Gm-Message-State: AOJu0Yy1yMVU/bm8lBhAToRLt31lQob+YQez2Qb/Q+PNuMEynRH9P+Cv
	zl/q2wNJOVLSj0d/+28GJCTjOIXoq6JtWA5RAoc0Stsnhc8kpsnhrMkhCTKfAu8djk00J5J+4hv
	06/FIPQNdYNBf3IfUmcSp4Ls6NODWnbuR1Rv6
X-Gm-Gg: AZuq6aIkdkt5X2B0Z60Z+H3uX24nTJB3nkPN3vz/SmSaI+dVAlQHChgqPAT37llPZvB
	RiDucbBr0d1SkodIvnfR0h1oq9uiHHWhnbNH4idwfLsiUPzXUAr9jeTyMZp6/i2WYDIiiucy/XR
	MF85drbuQsXJEVFyeKH0NpkwRIW+Jn8gmkxhGZocU58XvRuuTOlck2x9yrTyFE0ZxWDSwiv57Su
	FA9Iz8vRhXexcD66iceTrbxAjzAaQVgF5dUzB+oHNmaoC/ZM9WfwT2wYsHE8fc0hEZm0BZFNBLw
	snO1TGljQ+YXfGAQEDcveUqNpAsG
X-Received: by 2002:a05:7022:425:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-124a00c52aamr1402319c88.40.1769538351541; Tue, 27 Jan 2026
 10:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com>
 <38ea07c1-50ce-4342-aba9-fe2f4bc6c503@bitmath.se> <CAOQ1CL6G6eDcX+Qth3D531h72wW3RmvecCWjr5nAT-UdDWg40w@mail.gmail.com>
 <6880b5ba-ee76-4a9e-a116-16843a737b34@bitmath.se> <CAOQ1CL74A+WLY_f+QJHQqV=Wvq8yzJktLZ2ByZ4vjfUSsra9EQ@mail.gmail.com>
 <c2f1a90e-d6cb-480e-8f11-240b231adc84@bitmath.se> <CAOQ1CL7royHBeeY-Qr-xBhvXkWy1cJZ-tcT1kS1Dfu_z3emN6g@mail.gmail.com>
 <d1a09240-9a0f-486a-872e-8b528ff7e272@bitmath.se>
In-Reply-To: <d1a09240-9a0f-486a-872e-8b528ff7e272@bitmath.se>
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Tue, 27 Jan 2026 19:25:40 +0100
X-Gm-Features: AZwV_QgvDGdQVzgWYtdeuuKheVCRpVkr40fiXppAiu-ZC0ITVSr2ucNFLDRHkTo
Message-ID: <CAOQ1CL44D=9QZ7Jd5FrWQLpPoBPb12kKBRsn5Khu4145nrO6sg@mail.gmail.com>
Subject: Re: bcm5974 trackpad broken after USB reset
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Jan 2026 at 23:20, Henrik Rydberg <rydberg@bitmath.se> wrote:
> Looks like you made real progress here, great stuff! With this
> information, we should be able to provide a proper fix, agreed.

Thanks!

> > I think a more permanent fix could be to set mode on receiving that
> > first packet (control response) and/or on receiving default 8 byte
> > packets.
>
> I like that, expecially if 0x08 never needs to be set, as touching that
> bit would require some sort of rougher handling. It was a bit uncelar if
> your experiment with the 0x00 mode went between 0x08/0x00 or 0x00/0x01.

My previous experiment was between 0x08/0x00. I just tested switching
between 0x00/0x01 and don't see any immediate difference on switching,
just the mentioned difference after sleep/resume.

Regarding never setting 0x08, I see the commit message that introduced
this mentions dropping/repeating keys if 0x08 is not set before
closing (cd72ad3). I couldn't find any traces of this issue or
discussion online. Is it likely to still be an issue?

Liam
