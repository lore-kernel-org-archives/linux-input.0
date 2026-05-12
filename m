Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AC3C2B81;
	Tue, 12 May 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600057; cv=none; b=F0O6y04iZ6DvhyWmz1VjJ5OA7MNfHEu0rq4YkLpE9AG3d/IUf/Pgs8YJ9luqkUVQYE36mnOIF0M3qVi4am9Cb8UWwhk9RZsJDBTDyD2duD64CCDmmYtOEYBDbRWPpndy6jcWThCASvFwJI3G7Ah6FW7El7WoNs6CqlegSg3iml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600057; c=relaxed/simple;
	bh=J/bZClvNlqivNSdihyJYgv4Opa7D02RTLV1NGuZUBJs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lXPZJvQ1M40m9Kc0Oyi481TO4YCJo8zDjEZus9s+0oVtoGB15P1ayabEUUtUe36zhIEe5NgXECgUmAAcy35n3EfiOTxjZ2Aq+rRHWqXXdM9Kw6tYkuGR2qfjAgQ5w0/nPcqnvQWBU4+5F/NhXkXsBzuwdtrRqIVPEveIg4L6xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFaLoR7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFaLoR7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA55C2BCF6;
	Tue, 12 May 2026 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600057;
	bh=J/bZClvNlqivNSdihyJYgv4Opa7D02RTLV1NGuZUBJs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NFaLoR7kX20/CD4tLW/CgtENgY7ybipS9AJ+fj/4k+nuTTgGp1UH+rRkCqenc1ai+
	 286CfCc/Ru2CAbdCEFLKN2Jg5+XcRVYm1+A6faHpIBvXzHeepSxtnteUOUTGd3eDnv
	 scctDNDQxwGwLpbBwUT1LEQ5SBzC4r3i86Z99OV4rO1isQlPKwp65NA/tsb+LGeYlT
	 QK3lb/QhYZJsAGkMFbuK+i9IgVQ4Gp31GLmQHmNV4keQB05lbnv7NAOIL4dr8ys30u
	 dBy6q7UiyGXllvFcjWXekPYfZtElT8Ptosc3LOhWk3WijVdur9gEMT9ODAXO7Skqq6
	 t343ZcalE1ORw==
Date: Tue, 12 May 2026 17:34:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: use input_dev from sc struct in
 sony_init_ff()
In-Reply-To: <20260411155347.101760-2-rosalie@mailbox.org>
Message-ID: <r42s4o62-n622-6579-n6oq-05q3r79rn705@xreary.bet>
References: <20260411155347.101760-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Apr 2026, Rosalie Wanders wrote:

> This commit makes sony_init_ff() use the input_dev from the sc struct,
> this simplifies the sony_init_ff() function.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

