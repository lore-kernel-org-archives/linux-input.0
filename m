Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F94C77A1
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858220; cv=none; b=C43gpUipEW5V+0vPvpkScIMlBM7CY09VEjzUC/QvBgcX/XtbYkfTNMZfCWnLUJ0UBxc9UmehnpuAIel1WN7H8YsBjrOaRQgBK8AJ6o+d2MGeby4HiuAm/GNzPkugMnqCh7fhNJo7jImJHSYvEz15EbRuqLSVlQT79LqlVvPLqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858220; c=relaxed/simple;
	bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwAG9tindStV3eIsz/hc+j52Bx+xrzaBDAaVR90NSKo5YgjEGkSRSvtGPy83uXrdPN/Ea/5c/CRJpq1Ao1JoY9ktz8EpayZAGtMXPTI012D1jJlWlgoGluwQcdFCDrYhtoKr+3A1wtQJItcXB5759WusuL+QBIkWauCW9jGnggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW8W0t6t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW8W0t6t"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f96c5b722so126723f8f.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787858214; x=1788463014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
        b=GW8W0t6twdwAwLTLmEFFYso9t53eB4DYNG5Jl6InpAiPhtoLrqulQ8Q7HYCexTRJnl
         qpq9hsFycSUNuqH3FuzZH9BJUbKOsoLuNsg3RrQENKG2zv4Gbzd7oaB7UM2TXRIEqkrG
         ABVoR8qctgtdkXDboWNhbuW0lKmnyLJHWWMVy2FZqbLoJoDnVTMvksZmXPSEhbv8Q7k6
         ljmEb9l5sJOrGtphawVzDsVaNBGCRtg056ovub4SBtU4JP/jmNh5OtWPCj3axfQVCQEj
         bG2YCQvk0ifJiH/PCn8hvTpe1Cqb9RX+wCaiHO7wEB43GnTzieKamLmA/jzbBtCaMMNZ
         zg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858214; x=1788463014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
        b=BOHfvfh3tmr2WoLo/j1PrnJuqOurX4VpMKEiCixr9evPb+crytIO4qtrMLoz3fafNj
         zZbe9FPNA9DWV8vW7zW/NK6n4MLcHhkHT2gyb4YVVxaJ+EYPrzhF/o8v2eoglIO/+Jt2
         ccKiPGkTWYwAn92XwXcimtZ4HPe1lz2V/LYfLnSmtZRcqGHUqE+vEtEnucWrODT1iAbM
         1EFhRguuaoJxjb+SgKxtISkbRWgmU+qV4p+q6yYJcskwMUPjtuaGw75gI8O6BBL5lLhA
         FJvt/E76wQMPOZIBwTMezsxVRKWBUorFd7vvHGgccp+j1OWnsvcSu4NqPzAfDKrylnhi
         dxkw==
X-Forwarded-Encrypted: i=1; AHgh+Rqt/2OwHCMLAOG/T6B8xwxouUoRQFEoo51ipW8jw2NvhU0wIeoubYEtoQKp5Jgwrk9eeHROmKZpWHM0MQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lbTOvwtZh/c2ywHJv1fbt9KvDhtiPg8Gr7oU5Ml27OcimxxMSo
	AAZIOt/Y6NlTrOFg1joTS9crhgbdvGR5myvGM3NcYfx1MJLUeM6uEwDh
X-Gm-Gg: AR+sD10VJL5orv6kmaasfW1LetIBZt4XVpD75sBZDKm9kibUZcW/sxhlUGHezSFGfWu
	CubFOwUrPPyXpBDlNjowOQzgO+DpBDVnYHI1cKnrm0tcR2dwzW8FRYWsj+AiD6UQ7GzHz6i24FL
	cDDVDLFm3sZPYS+xHLiYCI7jhIsm/E5Waw6PMW9czlXwF628mm+FNn3XHijrPg+MsZN5R0atG49
	GoCbaZ9veRyfkQ57noutfA55IVM1m3Fx6fQmXf8+Eb6PSulHIhUlSJLejfQ/VrJX13HjsJoOOnF
	vpswXrVJjnsL49m0OKo1Um7P6xuhBhWUsMi/I2qo1pTDSS7WRlK4G7Ul3muVZGKqzHjysDPqlYa
	b+qQ6oIKN9LFDFyWTvTT2fElDY4E4IBh2yyZBJ5q9OoPbr59jWtL4zFkDAUxjJefqz+p0m0u0LF
	+Tm/VCmA9qfz4QXtrbRDemcCMpS30Uftty8NI0aiRRIwfX0aE/a+rNxxNo0Fg=
X-Received: by 2002:a05:6000:2489:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-482f7992e40mr1312918f8f.7.1787858213511;
        Thu, 27 Aug 2026 12:16:53 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482e27aa050sm10505002f8f.12.2026.08.27.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:16:53 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
Cc: bentiss@kernel.org,
	brgl@kernel.org,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	daniel.beer@igorinstitute.com,
	germain.hebert@ca.abb.com,
	gregkh@linuxfoundation.org,
	jikos@kernel.org,
	jirislaby@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	michael.zaidman@gmail.com,
	rio@r26.me
Subject: Re: [PATCH 01/13] HID: ft260: add serial driver
Date: Thu, 27 Aug 2026 22:16:40 +0300
Message-ID: <20260827191640.11725-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
References: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 09:49 +0200, Linus Walleij wrote:
> What kind of "enum" is this that re-assigns 0x00, 0x01 etc to
> several enumerators?
>
> Either this is four different enums or you should just do a
> series of #defines instead if they are all really coming from
> the same place, because using an enum like this does not
> make sense: it's like numering pears, apples, oranges
> and peaches in the same enum or something.
>
> Also use the UART_ infix as mentioned in the GPIO patch
> so you don't need to immediately change it in the next
> patch.

Agreed. v2 will use #defines with the UART_ infix in this
patch so the GPIO patch does not rename them.

On Tue, 25 Aug 2026 at 10:12 +0200, Linus Walleij wrote:
> You need to CC the TTY maintainers and linux-serial on patches like this,
> just keep in mind when resending, thanks!

Will CC linux-serial and the TTY maintainers on v2.

Thanks,
Michael
