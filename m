Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A83DB302;
	Tue,  9 Jun 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000540; cv=none; b=cOC0vD0aXJt4oU81BYmp2eLRLWFyZnBDqnPV/yJ8CMdVzbj16A2pqwZdMBEpeUlqO5Epl3hHkirg9A9bLJ5dZmx1+wdI8L+sN82FN/NJZ+5iSR6zUlL+EpJNYrsO5mB88wQy6MSGTaZyL393GZ11ZlqOVddLtScFBTJegQ8Vmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000540; c=relaxed/simple;
	bh=2+h3yI9Biv+0jSS/uTHxJgYEDwZWmrmXTwx0J7E6AfQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3RTAV8w3yZxqM0XdXBvnLZT/edrX9ZRRVuht4H+mb6uR4bmdCbb1mXFJP6VEg7LsGQtOhWwZDehY0Y9Ew/9YGVpx9tWhLHkY9LBdyXk2YGyvHZhPnoxZEI/8VO7wQo2Pn9Ey4SWH5c4tqMoqPFMlfigIlLTWbKnmWcPRMunHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JnOEsVNY; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JnOEsVNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781000529; bh=2+h3yI9Biv+0jSS/uTHxJgYEDwZWmrmXTwx0J7E6AfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JnOEsVNY234wAae+sMDE683IBa+SH0JgpxwZZwRW68QKSS8QeOATe1dhkG/2AQnwG
	 go6GeuQruNwb1gIKBCri7NWTxiR6SJ/2oXwz3IunYbvxNT99k2Us4tD8W1YIS730Ab
	 J9rt0oT6C5UzJdC+DzMJxGl/zJlILsdZ78DHNRE8=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 56D3B69C; Tue, 09 Jun 2026 18:21:45 +0800
X-QQ-mid: xmsmtpt1781000505ths0p36j9
Message-ID: <tencent_45D6247F04CF37ED6A3F858178B4303D6808@qq.com>
X-QQ-XMAILINFO: NcEwhrcyhX+EC+tD34u+gzg70Pevo/BFXAxqx7N56t6xEaDqGb8Rj+fsQ7vRSY
	 P5iwwowccEHFGs4wsNmw2NeWu4T/dq658d4QsZRzDCiJhHI/QLnAE0YihxxPUb7Mz38xTIonYuSe
	 FNa68jwvOuFh53ZlZn1592W6UWmO40vK+Rv7LlNNd21qwhQIGh6Wh6XJBO/LC3Q1+aE9+1QcY5Lw
	 3YiPTBP4h9OICaxaONUYeEL9ptb+uHA9e/7dTGtQckvV7kryFTOtLm1laRKZUYevEHWedwm3bSA7
	 GwGI9n7M+Ln6+Z47eZETRYKCXmEOONqniVfnmDc7re6tLlj6L1IhW7B9zE1B+7327aEyO/NzIVHw
	 AH4VxjXjnl/0Gew9QBMp6RWNqsOXa55XpTn1VDfuNt8zBux/ma/An+FICveukITmljiyw3F8NWyx
	 L3caKTSoxmPGCy17+QDauyhnDdT0HyoFiX/soPIRZ5bprfztWuAhl6Zz62Ps6aW0ij49ycAesZZH
	 ckOLHMuFMw4UAnxaTuBve3BrWcxFUwenthq/D/x/UcsDGO5E3ReKDYK8slOvpDFXsk687Nf/DYjx
	 7E0l+K/X2SuMz2EhADO2Vmgup7SnVnzNIsVsdHuf2zX2Pb4wCO0SFYpvafsseBl0zP0b1yRd2vpP
	 HrVh/Dk+y9e2yKgTuDOzSMVQzUlg7eUcN1uA2aK3aN/4g4N/7VR2uXTyk/0BaY/UgqieZGHw/OJ8
	 00fx/tCIG1KnlqBpgD9M8DEqdQf8+xpFTulDxZnvNs/mPV3op05IRLJ4qFDVchtiAyaR7LQ/1CmZ
	 uyOHftxd8GdTLgZsPqZl1k5d0IfZ2QVnBh7Lub7ia3XVtrkqjTx6lA3VEu4Y39nDGngtISt+6OFr
	 xLe1nQL5klqItRilkYvG1LrbD7LE9wt4PWumyFVdkqGbGdnTYySLiYZW0ZIUiVasvRhI3aKSx3/7
	 dRlAgMpM17Cv2rzr12v2hwaQkooDGtBgas3PRpYfK9QCU+HuBcv16dvgAHxm36LSTjmRm+kqc9rW
	 0hHasAyorqBptfgYhXq4IHQG7t+TC9kOLZ9Q7zAq1Ze17KzjeKuHQ/wB2pQA6NyvnhMlcxTBMy+0
	 vGW2qrnTFNl8VoT2wGhf0SWmaafjJfl7ad0YPUh71VPApVcPU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org
Cc: Yeking@Red54.com,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org
Subject: Re: [PATCH v3] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Tue,  9 Jun 2026 10:21:38 +0000
X-OQ-MSGID: <20260609102141.106235-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_C2BEF7C0584BFE713DC7B41FFD7007B6D30A@qq.com>
References: <tencent_C2BEF7C0584BFE713DC7B41FFD7007B6D30A@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks for the review.

The current header-based approach lets i2c-hid-acpi-prp0001.c work
independently by just including a header for the _DSM helper. Switching
to EXPORT_SYMBOL_GPL would force prp0001 to depend on i2c-hid-acpi —
a Kconfig "depends on I2C_HID_ACPI", plus module-level dependency at
load time — all for sharing a single function. I find that hard to
accept.

I understand that adding a new header for one function is unusual,
though it contains only a single static inline and introduces no runtime
dependency between the two drivers.

Looking back at the full discussion: Benjamin made it clear from the
start that he doesn't want i2c-hid-of.c handling ACPI _DSM fallback.
His line is that ACPI devices and OF devices should each go through
their own drivers without cross-contamination. If you still prefer
exporting the function from i2c-hid-acpi.c, then prp0001 would have to
drag i2c-hid-acpi along with it — an independent leaf driver turned
into something that can't stand alone.

If you still prefer the export approach, then I'd rather take a simpler
approach: add an of_match directly to i2c-hid-acpi.c, and return
-ENODEV silently at the top of probe if hid-descr-addr is present. Same
logic as the prp0001 driver, but one fewer file, no module dependency,
no extra Kconfig entry, and no OF driver touching ACPI devices — which
should also satisfy Benjamin's concern.

[corrected: s/prototype/function/ — the header contains a definition,
not just a declaration]

Regards,
Zhibang

