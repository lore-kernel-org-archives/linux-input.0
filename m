Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7873C4B6A;
	Tue,  2 Jun 2026 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389040; cv=none; b=kyvJAmIO0RAKTmqGrCsx2oalV8MH6z7cQvOP6bZXK7RkwkNm9Z+R4CT8U9P3cpAnNFcBiihzMk4BB10M87gzgWz/DW4M6mf+EKWGZsfmqSylTMg3y4pdgybDd412s1b/Qrxp/JQqvijsra4fDfTipU77PjHwDfjuaTdLdOt+a+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389040; c=relaxed/simple;
	bh=EC64ryToB337IY+0ZnCeDvhs//BuPLW0iPRkRWqFLvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mnee1xzVMXUUN+T0DU4qPqI7gp1H1ZctnPnV4w90BAlfyTyFGu7OADvB+a9FRtq7M/uysU8GZkbItNUD0+QIEb2iLDsW8eOpNipLVTPM3w1TXX+3hCHXS3LpwQLdVJjE/9uPbPWjmisi7rX94ZAnHvSnu9o7BMQirYrB/D1JtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJjcyLzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJjcyLzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C271F00893;
	Tue,  2 Jun 2026 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780389038;
	bh=R+JPgZ7eONhErJLONihPezt9A8LRLxiGSW7MeIW7czY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eJjcyLzdeW5gyCJ06B+co/Mf5+221nbLn9C08St+hTH6Lpqen3Mw9V92oIncl6wR1
	 4/plsXD60aPoCj/FyeKla8l6XEdG+I2Wv2k8krt6lMqsB6HUESKE4n9VHJMq+TW4fZ
	 fbEKCQH+mlK8n2bZgG/S2GRn27wplHF2wtseUYtMdo7i+onAC4GNppaZS+ywK/c9SS
	 3aRuYYHUg1Qzsncg5BIbE4Zj9fDP1zRilC9cponRn6MPpWK5YtBy/zO/SUaiTzJsRO
	 xltqgWy8egp0G85GO4d+oitCAXKcKYKve07/+g5hZ0cJizxwCserjhWLwTajvFINxY
	 7dYCC9odlVViA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, lcasmz54@gmail.com, 
 Rafael Passos <rafael@rcpassos.me>
Cc: hadess@hadess.net, jikos@kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, sre@kernel.org, kernel@lists.ime.usp.br
In-Reply-To: <20260602030519.3097058-1-rafael@rcpassos.me>
References: <20260602030519.3097058-1-rafael@rcpassos.me>
Subject: Re: [PATCH v2] HID: Input: Add battery list cleanup with devm
 action
Message-Id: <178038903698.111986.5368522981222078729.b4-ty@b4>
Date: Tue, 02 Jun 2026 10:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 00:05:19 -0300, Rafael Passos wrote:
> The batteries list (hdev->batteries) is not cleaned up during
> hidinput_disconnect(), but struct hid_battery entries are allocated
> with devm_kzalloc.
> When a driver is unbound (e.g. during devicereprobe), devm frees those
> entries while their list_head nodesremain dangling in hdev->batteries,
> which persists across rebinds.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: Input: Add battery list cleanup with devm action
      https://git.kernel.org/hid/hid/c/426e5846eba7

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

