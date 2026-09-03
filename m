Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4515111BA
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470289; cv=none; b=k1WD98nCD64hE8acF6Fvkjg89BiKazIqstGT2VHh5PSkmqxONNSme1jK+uWGrgwI+dE96uNJ6IM1azFje0ju9QGadyoHIbVBhM5niVFFwSh31R0Fr/usteIv1n5GmthiJPh6qtiQgOtTHAyRy1wGrX9ThPPr6vmQoaAl/KyXr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470289; c=relaxed/simple;
	bh=C5Yjlm9kRd/DAjBbMK2CN9s2ywZFtR6r84b66gFaYJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ms0CDXkQOXdHt+Jfngbe/kjhWvQeMgHjENFeYrFMtk5xnp3jroCwBJdSOruPFsYwfGTxIF33SlfUnwAMbVZMcX9Pi+/6BV5u51wmuzBU2QlEawLRicRka7WPotBD8u9Ywk4kG8c8kc3yiqb9NIfB03sQXlyIrtR652QZp1Zk4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVK1FFoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVK1FFoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF61F000E9;
	Thu,  3 Sep 2026 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470284;
	bh=4Dyy3tgC+Zk/yh5t1yK8NJj58M/NyPnFu3q+eBFZ3Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVK1FFojyFPBf9XpDIihlSoWr+Mq159JMwg+08diBXXWtXIo7bUBjeEaW8poOGub3
	 CqlfjOv/Hv67Vf48THLvpuQmiMDqIbx8GzG1Pa6TR4RMy8za12WSwWwBbVkywa2tOu
	 0hzScJQ7mTAqv0tMiGZijWSlSblw5acTSbI/wB+CLK1Hq5maOIlkQnzom9kQfmhYKU
	 FzDveqaq9cj7ROgmESOWjgN+ckOe7dYgLqqhHIZ9U+mEjwtcJHh3GSLAw1EtTJJ+OU
	 SwA6EKbLO9tCl2XrvKM+wRL7l9Uo8/0zMUpF7hDa3ZxCB1Si/DUb+85f6wqs2DHYNs
	 PJ6wABBWt++uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: tca8418_keypad -  Add devm cleanup to disable
 interrupts on unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260903210639.22472-1-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
 <20260903210639.22472-1-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:18:03 +0000
Message-Id: <20260903211804.05BF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on hardware-provided scan code leads to an ou=
t-of-bounds read on the keymap array.
--

commit a7ecc5efa5741df5c7a115258a1df26344bc93c3
Author: Zhian Liang <liangzhan5dev@gmail.com>

Input: tca8418_keypad - Add devm cleanup to disable interrupts on unload

This patch adds a devm action during probe to clear the CFG register and
interrupt status when the device is released. This ensures interrupts are
properly disabled on probe failure and driver unbind.

> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyb=
oard/tca8418_keypad.c
> index 4616afa0286c3..a7c7e23f16617 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c

[ ... ]

While reviewing this patch, I noticed a pre-existing issue in the event
handling path:

drivers/input/keyboard/tca8418_keypad.c:tca8418_read_keypad() {
    ...
		code =3D MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
		input_event(input, EV_MSC, MSC_SCAN, code);
		input_report_key(input, keymap[code], state);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but pre-existed in the codebase.

Does this code lack a bounds check on the hardware-provided scan code?

If a malfunctioning or maliciously crafted I2C device returns a large row
or column value, it appears the computed code index could exceed the
allocated keymap size. Using this index directly in input_report_key()
might lead to an out-of-bounds read on the dynamically allocated keymap
array, potentially causing a kernel panic or leaking adjacent kernel memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903210639.2247=
2-1-liangzhan5dev@gmail.com?part=3D1
