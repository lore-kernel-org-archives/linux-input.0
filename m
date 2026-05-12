Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89D3CAA53;
	Tue, 12 May 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602509; cv=none; b=f62ONPifb9hbzrrjoQozYMLPGQgwDoxCoUHNW37wSl1SwGuXpGBKdrxP8JEafhTbaGztCl4TP+BKZ8lACKls6Ji4D55ckgeMGX1qyBIme1u77sfCzED9lVoIGdxZazc99B9tETiLUrC3AiVOd2ruC9uhkH1d10OjN6zqBHMhBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602509; c=relaxed/simple;
	bh=UEpCfX4rpLXSTVqAYLO3NySJmE/JWHyb8pZuXuwJ15w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WrIvaguqPlypjlpJwLCNMTEjov3GrFroCDHVaDOUjQlrZD4cNdPK6qdiyanWRzY9shqppEQpr1BHD39rWtOYdGTcDLHWz97QcHhwGI1leojQHUCIxSqrEt7EO8E7yUdf7JCG6AGuif2QMBafu+uJg1Ms/CsVAfsn2cBx1OqaR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbR/2ho3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbR/2ho3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCEC2BCB0;
	Tue, 12 May 2026 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602508;
	bh=UEpCfX4rpLXSTVqAYLO3NySJmE/JWHyb8pZuXuwJ15w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nbR/2ho3TZfZ6pGA/Kkk0g16goaKuK6v+Zu/lAkc8CskaNbhkd/sRbhY3L+cZFj6K
	 7wjNnDbDZ7XDN69ZGQyqqAe7i1ggzbI1r+B7A/dAC4nKPjEObrjcvfCm7QLfti2oBt
	 7mwv/fIj3vrgajQbDjOE8wQK4/vdgS3vunp94dc5a6UDEaHOii7OujlfM3aiX3tKfl
	 mQAM08HEG06GrGX0hG7O4PnsboSMvfEVy9vsVrW58fvTiAJry5h2skBSq83bjCK75G
	 qUVP6To8w3DVe8ZfMFmW402x/BT4i+ggKwkStqreZwDKuYwUZqIPF8umGFntTVoZ5+
	 HaRls5yEGrbJg==
Date: Tue, 12 May 2026 18:15:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
cc: linux-arm-msm@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] hid: Pen battery quirk for Surface Pro 12in
In-Reply-To: <2702fbde567457ea0835ba12cc29421590e688aa.1778498477.git.harrison.vanderbyl@gmail.com>
Message-ID: <nr7o1824-1s35-8n35-qo65-16n2r168oqqq@xreary.bet>
References: <cover.1778498477.git.harrison.vanderbyl@gmail.com> <2702fbde567457ea0835ba12cc29421590e688aa.1778498477.git.harrison.vanderbyl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 May 2026, Harrison Vanderbyl wrote:

> The pen setup for this device uses bluetooth for
> communicating battery levels and status instead of
> reporting it over i2c.
> 
> Without this quirk, the device either reports an
> extra, broken phantom battery, or hangs.
> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

As this is apparently part of some bigger series, I am not sure who is 
expected to merge this.
FWIW

	Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

