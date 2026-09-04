Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC94F6460;
	Fri,  4 Sep 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535755; cv=none; b=pBI/Ciu89jvIuww9KzPPG3aZePO2mg1DEBX4tZ1reTJ9KeM625n6JfqP+Tn6l3zRdSQDt5HF+8JuPsz+uHCDAkawe5i/4jYLtFyObfbu6pg0pHvS6VzWCUdc3aPTXiYtoed0HcueURcv+2IC8p0C2Fbg2iil3xeJav887MsM3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535755; c=relaxed/simple;
	bh=1/aUR0AlkyO+cmhQYeGzQ4NzLfhpEKV4x355FNj8hYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EjVSM6H8EYaR166eOe+CndeZ4XNPc3vMl2JDa4lysZR1trPrUXi/UjxbVzJEUd6hMY6Jd9ZSmxQpVIzeNxT4bTH+ULkqhiVwlAJrJXdrtJoeLeM2DNgCQOoNhsMk3gIj81jZzZH1MPqf86XoDGl9far70mfidAudbholg197328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cibmYrhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cibmYrhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEAE1F00A3E;
	Fri,  4 Sep 2026 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535753;
	bh=KibasY7gpdgaN9Q7GqAgR1twuwFAQB+blBRQI0vIILY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cibmYrhymjL0SsnFwru3t1Uu+E6WKrpYbX54VbW02xonPBzi1I+DzvOLHHndbrUMV
	 ZdbQIev+plC7QfzXBn7Y2hKqc/jfvIjerDzbEVZFqPlLZwzZCqVKlhsMH2YZ/NJPCA
	 EwtarzwbR2ujUvkgKRQbtiMQqvFE+6J8jb3DR6QpiB6YsfYwz/GzcHv5P7xw8vjTqv
	 J44YzugBNAI4SMvuMSnzsOXVY7U2HeJFTuwV6cFoUX0+v55LQz9z3OXLPZj2M/KMXu
	 mcQNQGi53xVsexFRxVdbXpuqpH4iv54y2xT/HrCExWb5nZGJz2ZWjnmqKMzJJnsDXP
	 PnGRNSlnM/geA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
Subject: Re: (subset) [PATCH v3 00/10] Remove support for platform data
 from samsung keypad
Message-Id: <178853574810.59617.2944881892778371302.b4-ty@b4>
Date: Fri, 04 Sep 2026 17:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 11 Jul 2026 19:12:41 -0700, Dmitry Torokhov wrote:
> This series converts the Samsung keypad driver and the Cragganmore 6410
> board to generic device properties, allowing the removal of legacy platform
> data and GPIO lookup tables.
> 
> We rework the Samsung keypad driver to stop using platform data, utilizing
> a new compact matrix keypad binding. To support this on the Cragganmore
> board, we add infrastructure to associate software nodes with Samsung
> gpio_chips, and add software node propagation support to the wm831x MFD
> core to route DVS GPIO to the PMIC regulator.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: input: samsung,s3c6410-keypad: introduce compact binding
        https://git.kernel.org/krzk/linux/c/27d305325d2f3929e61105d465ef968ea39502ec
[02/10] Input: samsung-keypad - handle compact binding
        https://git.kernel.org/krzk/linux/c/e8812411863552ebb153d7c856e60ef6deecfba4
[03/10] ARM: s3c: register and attach software nodes for Samsung gpio_chips
        https://git.kernel.org/krzk/linux/c/a01394e260d51b0b028735a9d71476c5c74280df
[04/10] ARM: s3c: crag6410: switch keypad device to software properties
        https://git.kernel.org/krzk/linux/c/78b8efc99aa61c99c77ad1bf6129ba182a27b52a
[05/10] Input: samsung-keypad - remove support for platform data
        https://git.kernel.org/krzk/linux/c/235cb99d39db4c80e3120d59e4c572dbb408f524
[06/10] ARM: s3c: crag6410: use software nodes/properties to set up GPIO keys
        https://git.kernel.org/krzk/linux/c/c67c110d141b4347b864aa08ca86a1a492bff776

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

