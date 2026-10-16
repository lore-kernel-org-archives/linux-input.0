Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B2421A07;
	Fri, 16 Oct 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144131; cv=none; b=ct9QIeGu6VKmg83B0fWVZfSq9uVAfYSge0aIK9eAd4oI9MPRU0ByaB/o07M6vlIHLNi0WZafy9CpgcIfaAnc9JC8BnF7DCeOI8ezf9pnh57odnmvCCAP5z6BmEh7PuAk8/Pss66yDBbxGbQKMN8aaQKFKFukAhoPyLkpgptEnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144131; c=relaxed/simple;
	bh=O6VBKn1Ukisi6i6i6LXTAktK5vPjt+n421kwMEHNSA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fk61UVS8VrK3CL+OZUpCX/imcPbPs96pR5LneeY9eoXrqngEvHuO0jrO3yt7cFILrM9Ib2igyzY4ezcz1F1kmmrOBX9b6noB+E1kVsocvBzv1KjjlGNXhvczZtCot8iqUkidCpMBGxPLmHzgRxj3uuZT6d7C+aUFwts0KvvxkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbd752tm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbd752tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7346A1F000C4;
	Fri, 16 Oct 2026 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144129;
	bh=fyAheN/s9yhP4UGaZ4YpXYbtwvZ/gPCC27PGnOeDaH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Xbd752tmyj9rHyh5X6WZzr8Y0gPHVQ9MdBbznjVxnv7mXlwkeinkH4/bJHYbTUERf
	 fHuiLHyzZSRZR+nlIziAWNwEqaPD4gTW9sJ9q7Oc8ENs3C1zc4TBXCDtoSMm+Oy8fK
	 P3seopuh3kqLZnDZejo4SSa1s4kT9q1wYXC646TX+XZay1Lb8fs03FFDctnVbo+buX
	 EcIYz74DOeVXB7Kb4scKpyGHuOCO8hOdOW8++QFkuuJTewLAPKAqG20GMjNo5oFw7G
	 VGnlF7qtP5tKM8sTyVVhHQSVTbcVJWU+tONPSOLXp2rXuzvw6LHF0yhLU2YNuO3yoL
	 DPCioFc47AqIw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, 
 USB mailing list <linux-usb@vger.kernel.org>, 
 syzbot <syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com>, 
 syzkaller-bugs@googlegroups.com
In-Reply-To: <dfa0aa1c-e55e-4316-8307-f72a07383634@rowland.harvard.edu>
References: <dfa0aa1c-e55e-4316-8307-f72a07383634@rowland.harvard.edu>
Subject: Re: [PATCH] HID: core: Fix out-of-bounds left shift by 32 in
 s32ton()
Message-Id: <179214411701.1109876.8709320205191149759.b4-ty@b4>
Date: Fri, 16 Oct 2026 11:48:37 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144128; l=391;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=O6VBKn1Ukisi6i6i6LXTAktK5vPjt+n421kwMEHNSA0=;
 b=OJNwJb2KuNI0kudhOGdLbxiS6hkHaXhDaneIxgs7/0hc7VzC3d5U68HRE0C6I9kuRbLnMOI6d
 8lSD0D7jhHhAPZKmNgFktJiexYBP2MkWfkYSaUg7RBH2PzoTo30yTTU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

On Sat, 10 Oct 2026 13:44:15 -0400, Alan Stern wrote:
> HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/core), thanks!

[1/1] HID: core: Fix out-of-bounds left shift by 32 in s32ton()
      https://git.kernel.org/hid/hid/c/5fe63b415c63

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

