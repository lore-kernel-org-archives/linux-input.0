Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE923A9DB2;
	Thu, 24 Sep 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250968; cv=none; b=NqvBlyW4xPGi9UXy+kliocjZv/MqqOM7XbaFL6MSy4OviTTfqjZLa2bPHzJ6LCkyhPEKlUkDdC/cjx87Pzf//TxZEZKXCFJBhK7aRAAvurk+hWLHR2i+UMrOEWduatOuBPFlDCCc6mTCrpS6yQ9DvAczpS/GYvoxxcvh3r5BrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250968; c=relaxed/simple;
	bh=kYeFIwrgMb+YJDX4SSk0nBhrpd8lYVsV6WdBSHa+kVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3CCFkxRxYzH77Lg1Z5cI3GxI8hfLNwOvPDsjOqZ0rZWqE4OPqP+7HAqt5hqo0wp84ovuBC0zOpTu5p3prVlLcHtYsnjjcL8XwKjxH0CVBSfw1pAQbMEnyBA67qAbBUorqO7V2/dZ8LSgGgv271WNAxtLB7K+0l65thqgoaTkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuNX04L/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuNX04L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EFD1F000FF;
	Thu, 24 Sep 2026 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250966;
	bh=Bk5DwM8PPL4Re8917OunGzw8BjTlRWhX8Jdc3Ar5N7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UuNX04L/3YWqt+g1NPUvDezj+lW9JUKPSbu3e5kM162ct/KZtC1NCHSYMrSdhHK5L
	 t2mRRR/jzGGKvdHVYcHPUScmBO8m2X6fW7U8t0xMmdOIn88ZGHpEiWTIQbZI5ck0XM
	 RM5a7dxrGTj0/46zj6nEj6ZC2DYWeSfwXiZ06z6C3a47nLHevm2j9NHTL+E32iZeam
	 YVR39cerODZ7Zo9asox+lgX2z5/F+dO+ZKEK5yIo7gwQVt/YzlJSmDzkSktYBV/Vw1
	 VfcjXkivqXfss+KX676a/vENKElu2CqrwlDkYlrl0RcQCjhsix8j5jjONV4ziHM559
	 ZmRsM47cQDH0g==
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260721095654.429346-2-clamor95@gmail.com>
References: <20260721095654.429346-2-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert
 to DT schema
Message-Id: <179025096434.466500.400174146164651131.b4-ty@b4>
Date: Thu, 24 Sep 2026 12:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 21 Jul 2026 12:56:48 +0300, Svyatoslav Ryhel wrote:
> Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.

Applied, thanks!

[1/6] dt-bindings: leds: leds-cpcap: convert to DT schema
      commit: d4948551280b1d52c1896b7c80d5383b7d8ad7c5

--
Lee Jones [李琼斯]

