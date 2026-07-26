Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202883AC00
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042422; cv=none; b=LOA8c6OdlQyr8XpwN/6vWRrlMxCYXx5htFiLeK8JC5BOv66PCHd5kHAcRzijTty6tuSuVRWdWw4aocRxOqyRF5paY8KQsGy/2cOA569FysB1/TFrvFxhL8senSm0nBeE0rGqrLNbNLyyg1IWseyQN20z6zDzdseG/ydjXyS/0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042422; c=relaxed/simple;
	bh=uw9oU+BMIOTIPQ6LEzfIcLSmcYncyXDeFihd1ceio4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=os87hL23lNJvZ/4S+bxZGARh59TI1IXzrJC0c6733tJ6c8EluHQ3FGXs6NqGaVNgX6RO75G0v9aPNFkphtySHcM1vvUfSww54hp2GcVeD1p/KCkS4EGdq3uRSemNMbmqxSzAk08vhcC4N5Yr2aRjwTh/5OCUOQGEgWt6gWCYO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWptKswk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWptKswk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864711F000E9;
	Sun, 26 Jul 2026 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785042420;
	bh=ssaQLtlpN92AbFova2W7wQ7s5X3SNQo7M9+OIvDAw6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWptKswk2vfMSH6ukxCzOF6Gr9BnV9wYt1AN5pBNtU2B9j15vJvFe64fCjR7wXAm3
	 sJPxxMTR609uwlI6Oz1A/rF2+oGIiBsyWjvVFxg1vor0tSeCRI+gvqICXNZzkm/gvJ
	 ETotACw/sN1xFeoDpzhNhy3RkkCVcpIlWdvp22qO+MFJ8/vfXXASW8EZWhXrkm3pCT
	 S01/9CJtSQLE+bxNx+O+EWFU4cPdY/zNIspwxRwSTmR2ULB4xm5BcoAY6rkeywvIRs
	 5M0g6WhuNi6wRHN7Ce8opvPJ5HsK74cQ3McqNnN2bQLPKpq+bXOVXs1tX8dmVVseJi
	 8ujMnUysKC9jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] reboot: use
 devm_blocking_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726045706.8169-13-farbere@amazon.com>
References: <20260726045706.8169-1-farbere@amazon.com>
 <20260726045706.8169-13-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 05:07:00 +0000
Message-Id: <20260726050700.864711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly claims to replace the `blocking_n=
otifier_chain_register() + devm_add_action_or_reset()` pattern, which was n=
ot used in the original code.
--

--- Patch [12]: [PATCH v2 12/12] reboot: use devm_blocking_notifier_chain_r=
egister() ---
commit 8cd90dfccbe30e1a7f1ea6421b385708237370fb
Author: Eliav Farber <farbere@amazon.com>

reboot: use devm_blocking_notifier_chain_register()

This commit replaces the manual devres allocation and registration pattern
in devm_register_reboot_notifier() with a direct call to
devm_blocking_notifier_chain_register(). It also drops the now unused
devm_unregister_reboot_notifier() callback.

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> devm_unregister_reboot_notifier() callback.

[Severity: Medium]
This isn't a bug, but does the commit message accurately describe the old
code?=20

Looking at the original implementation of devm_register_reboot_notifier()
in kernel/reboot.c, it didn't use devm_add_action_or_reset(), but rather
manually allocated the devres struct:

    rcnb =3D devres_alloc(devm_unregister_reboot_notifier,
                        sizeof(*rcnb), GFP_KERNEL);
    if (!rcnb)
        return -ENOMEM;

    ret =3D register_reboot_notifier(nb);

Could the commit message be updated to accurately reflect the pattern that
was actually removed from the code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726045706.8169=
-1-farbere@amazon.com?part=3D12
