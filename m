Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE141FC0;
	Wed, 23 Sep 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151014; cv=none; b=b6ccGVZA11Ga5Lu5eYJ7Hg+lhaecWXVmYxX009Klzopuzsr1yu7HIiu2xOM4XDIAG+rcniaRHd7RACF4xCP9nk1Kx7RTmBgZYTpynm/5Sl9VFbdZJluWNizx0LkuCex3cKCzEpYBw4p6SBIgh85zZApAGkiJGkJszmeva444flA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151014; c=relaxed/simple;
	bh=8DJs7Le9Gqlq7NjGc11VnwKk4ER//sx6M71RI6H9FV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bbIVig/1NYWL7Ri1Z4Hh4dANQvsPWnSli2RTsjvoDayebfhsuHuYZkuV9jsvUMQtERNX0IkOLd+uMsY66R45qHgld8l4dNAIANwaLRJmfS1UEyNKRI5pz78k5AM4PLSKoI4SzndNBTy+ZAGCB+alW1uJ9/NSRXPpgs68//bgxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3CtpED6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3CtpED6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC16E1F000FF;
	Wed, 23 Sep 2026 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790151013;
	bh=bF5EuWptzVSTQfet611C4PFTltOQ6Ec0LJhPTHDaTpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f3CtpED6aHAyLsdhnqOt5xu2P9oYQ4pgcdy5/Q0I10bt4XWZBDgkAQx4OBYUH3chs
	 cu9xpMsWd/O4xYU4Gy7wCZ6lgld3p0T2EyvSGt45VlDIuFB3ot7G0ywkQzNDuPdEll
	 bBlWduFDyHTRCCH/EBoI2eRRofV51kEoF8NvPxfj3Ux4Z4+x7La/EcJegG76pvOm62
	 jP3GqTXvkWk3mi8FVcTVtjmCuhByB8ruuDDiQif/VA1U0/eCakZM43/eSKmetCWpfX
	 oi3yE2kvvw8dnsAWfCefCPbv0cCB0sd2EtDkkgTp/TvPzkcEyZgxcHorxvj+wjtxn3
	 gZ59OUkiaoRQg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923-revert-bolt-v1-1-52c2ef6f614d@kernel.org>
References: <20260923-revert-bolt-v1-1-52c2ef6f614d@kernel.org>
Subject: Re: [PATCH] Revert "HID: logitech: add Bolt receiver support for
 Logitech HID++ devices"
Message-Id: <179015101056.20800.11230803034120852820.b4-ty@b4>
Date: Wed, 23 Sep 2026 10:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 23 Sep 2026 10:06:58 +0200, Benjamin Tissoires wrote:
> This reverts commit 022eb347ff3a48281e7e69c3addcb11bf24afa53.
> 
> Introducing Bolt as a DJ receiver created a lot of troubles for users
> with their scroll wheel going crazy.
> 
> This is because we have 2 issues:
> - Bolt doesn't say which device sends which event, so having 2 mice
>   connected on the same receiver means one will be normal and the other
>   deadly slow or deadly fast
> - userspace also tinker with those settings, meaning that users are not
>   happy with the new default settings.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] Revert "HID: logitech: add Bolt receiver support for Logitech HID++ devices"
      https://git.kernel.org/hid/hid/c/3fabd8ec206b

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

