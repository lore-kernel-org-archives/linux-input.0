Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B2261B9E
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447509; cv=none; b=gDGVJqvEK895AmSSD/5qwxIdudahie7o9NSu1osy/PHYFGayTWSHi1fEULEVnD+GJWVUkE+5MxJWtCw8wp8OF1wXOnd1CSLekwXutbrRjV8Du799LhCorM0wlOkwHi44GyII5sDSXVxVlTRr2I49YUOR30khqcp/PsRabHskSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447509; c=relaxed/simple;
	bh=ZTJPjPJxE0WNlUfHRSqhiAYlVk8gMUP4vwmB54Medcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVYpmqYM9NtMePL9Z4Kjr9MH7IWYacWd4EjBFcFVSFqvMS8n+2a8/HJAzPBf+0T6OCyOIDN9H4B8zuRENdfozG25hWs9+9evbrokgbgpA1rcHS0Ns7hlPuUdZuIl3sUPCKd1rJMVLCVIt297ifav+/FVvx3UfMgbGCOSvWLdc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM727M6b; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM727M6b"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48881a62e09so880230f8f.2
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447505; x=1791052305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTJPjPJxE0WNlUfHRSqhiAYlVk8gMUP4vwmB54Medcc=;
        b=PM727M6bvHo7LgABTeXzZQHagXOS00tJFIBldBtAB+kks9qKxu7mvzqzk4pXqFGcZs
         TqOhueVag5HuxXVZSxYY1mronhkUNpH+OOVxTfRb+HwAQmMiIrbwrA3lmt1j4nxMYX0u
         X1/PcNoQ+fzK6EWWwIEpox6lXzEj339SixBak/3xJZ0fGVIrXo1U5yluCo/NOgFcS73v
         2Wje4DvclSs/QIEhKT6y8wTSSz355LYFuR8i4+Vdt+Qbl0oUeNdRiEOJRkmDn79YVbnK
         JY9HalDRj+XsgTFJvT7L4KfQNGOoN/1S1JEipUu25BTYkZ93qGO65pAu1HnyNuqwJxd5
         Rj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447505; x=1791052305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZTJPjPJxE0WNlUfHRSqhiAYlVk8gMUP4vwmB54Medcc=;
        b=wRq9XNbLDzD3HB5LEc8rokUj+t3oOC1rx1yOqCWfnpOBLCB/tqpgLGHV8AiEf3vCS+
         b1PtkQe/Yshob/6HQ5RKGK/KO06lWxuah4nmnDeTZV4+KezDj/qMS92wXgklf5Lo+e/V
         3KI7EbW3EKqd2WA+TaQP1N07I4pmUmRhGUAZSoKnhtSH96UsckkvJXqWDLu91URODJkn
         NkPFE04Or5ljK7UV1WdHCcPt/I6CwIVshpuiroYAMQMLnDZ8UnOIlp1fRirBmebrDZtE
         skjWKDoFSEexuKLbsZOYpMGPuyHa/0FwMOZOX6IBDhZpK4pnEZlwbCPUwKEYT7i4PPxm
         /c6Q==
X-Forwarded-Encrypted: i=1; AKwUvBy5vOjAzGKfeHUBR/64R+nmbc/wefrn/v8smoLiZPQCMUFI8gN4AI8VPgq1k4ddu9X2uWfIk87yj2l5HQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLw7k/Mc0ifjbYFv5cqYk5RWzBpjGdmQLOh8x3nXe+UcIF4YKyY
	Xt8l2hSZ5riSzIPUJy7GSo60KSiYAE+palqOVnHHHgjiUWbFj8/mCS9dA0qFTOo6
X-Gm-Gg: AYBFou3s5YWpVqk8w33t6vnWC6ABi1ANMZ0gpXxaJ2xr7QeVibHaTcOU2vcLLzbxto8
	glUnoE2+UB8E2/25ArG3VmPtDAZJ9QUUqgvWtJ0nUWW/54gNCMjuy8vyF7DVz/kh7jBqSSTs5VP
	GtAnqdUtwJ5KS0VF6zXBPVPF5VsVNFYaQjZzzINp+h5ndYcAf/+oqGMJw/pRhV08QPB2oTLpwJK
	9ZJz1qGSpNS6b2oWlYKon6bzfr8Mmb9nCxfbSJtgd6iV9qQ+XIkkwP+UIpJWQyM/9moID7m5nuu
	/Jjwg5ynzUKlzU5F4hrEtymMaUiOllY7t6CyGQQ8DCZCswHZ8Y3Ygw/x+/M8b1F7F4HIXd013Ue
	4/emydO3kkKFRicRBx3QUNjS+JW4tzFS1qsSFj+12tPs5pMsQbem73UX5fbMcONQrZR3Nx+0t0h
	Vow0ZFRRSh9C+6wzaQ2OyZS8MmsslGKpAH9XBj39xXZDXt6noh6/FeLTgHJwbWLR/Ug82IZKykE
	MZx/qEb
X-Received: by 2002:a05:6000:468c:b0:488:79db:c73b with SMTP id ffacd0b85a97d-48879dbca28mr7473819f8f.24.1790447505235;
        Sat, 26 Sep 2026 11:31:45 -0700 (PDT)
Received: from m2.. ([37.142.154.181])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4887a34a4e9sm13167970f8f.11.2026.09.26.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:31:44 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: michael.zaidman@gmail.com,
	jikos@kernel.org,
	brgl@kernel.org,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Sat, 26 Sep 2026 21:31:34 +0300
Message-ID: <20260926183136.25146-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aqvHqSOgziyfhWgp@beelink>
References: <20260827205116.GJ2943942@google.com> <20260827222550.24634-1-michael.zaidman@gmail.com> <apaLLD4ZXhNV-Dph@beelink> <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com> <20260916125806.GR11487@google.com> <aqucXBi0Fmq-tCWr@beelink> <20260917100455.GG1605367@google.com> <aqvHqSOgziyfhWgp@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Benjamin, Lee, Linus,

On Thu, 17 Sep 2026 at 13:07 +0200, Benjamin Tissoires wrote:

> I think HID is just the transport layer (like USB, I2C, SPI, etc...) so
> it shouldn't count as one of the additional subsystems to MFD.

Agreed for the FT260. The HID reports are the transport. The functions
are UART, GPIO and I2C.

Jiri answered me off-list on 11 September, before the mails of 14 to
17 September. He has no strong preference, and he left the sequencing
to me.

I will land the current driver first, and do the MFD split as its own
series once this one is in the tree.

GPIO support has been in the out-of-tree driver since 20 November 2022
[1]. The serial driver was added there on 12 January 2024.
That is where its bugs were found and fixed. Folding an MFD conversion
into the same series would replace that structure while the UART and
GPIO support is still under review. Landing the tested layout first
keeps those two reviews apart.

I maintain this driver in my free time, and my bandwidth for the next
few months is limited. A split across drivers/mfd, drivers/tty,
drivers/gpio and drivers/i2c in this series would stall the UART and
GPIO support.

The parent device depends on the strap pins. One HID feature report,
0xA1 System Settings, carries chip mode, the clock, i2c_enable,
uart_mode, the UART frame and flow control, and the GPIO pin-function
selects. The I2C interface owns that report, and registers the
gpiochip, in I2C-only mode. The UART interface does both once UART is
strapped. Enabling I2C or changing the UART mode moves pins between the
I2C or UART function and GPIO. That parent is easier to define against
a driver that is already in the tree.

The MFD series will follow the constraints from this thread. Lee, the
code that calls the MFD API will live in drivers/mfd, and that file
will do the shared setup only. The UART, GPIO and I2C drivers will live
in their own subsystems. Benjamin, the child devices will keep fwnode
support, so an ACPI or DT child can attach the way your cp2112 CI does
today.

On Tue, 1 Sep 2026 at 16:02 +0200, Benjamin Tissoires wrote:

> It is maybe a lot to ask, but Michael, can you demo the MFD split on
> one/two functionality so we can check which approach is the best?
> Ideally 2 features that would be intricating well enough to demonstrate
> how hard/easy it would be.

The two features that interact here are GPIO and the I2C and UART
functions.
The split is one MFD parent for the two HID interfaces. A demo that
splits only the I2C part cannot show the gpiochip ownership above,
which moves between the I2C and the UART interface: with the I2C side
moved out, there is no configuration where that change can be tested.
The MFD series has to do the whole device at once, and it comes after
this one.

[1] https://github.com/MichaelZaidman/hid-ft260/commit/e40e56953e8c2b23c222d76e97b5f5e274b91603

Thanks,
Michael
