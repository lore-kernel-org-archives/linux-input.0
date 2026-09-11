Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5635B634;
	Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138352; cv=none; b=RjRQbjNSkf6QNyJn0+EF1rrVgBs73uq1kjayAqmrN3yAgM539K71+58kgJYgboCA4YwH/XIcFedoLL47jG+M0rK7UgeqUQge7LlFO7FhwucIz7dueRobRQaApS3gQ850eR+itnBhBuvw6XA6URK6ZrgnKCnsGTTbrL4c5G0HZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138352; c=relaxed/simple;
	bh=ripYcv+UMEL/q5S5kw1q+5ak/g3j+MV6b4LubcEYeII=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WfQQlQG141OvpC+ZUosVwWp6mFND/Q9wdbF5z+hDTjoqfgxnlH9rAkjaz7ftqvHxyEwUSRMBDbl+Jh1NpYmJ0X0gkKE/YZYNSfkqC5YvhpUgxoZOPNkY7uEg3DuaXAGNndoxJ0VG9KsoRawX8YEdlApHl7YedAwAcGHMi/skCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+72yLii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+72yLii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF91F00893;
	Fri, 11 Sep 2026 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138351;
	bh=R3qt+0B/1mnQ36SX7AQjSDbiXzKhmW8PzxAyTaaPd2I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=R+72yLiiP8z7QHBgify47f/1MiS8D6dCFbr7QcC3oBSf8TiefmhygyDxstH0SgKrk
	 2plQOI39+gOYzjF+cBQLEPGfU6eRX8fTDWvSh7bb19kjhFvYZqhm3yGpeuKyitgyja
	 /kA8LRZ9pvl/PV5m5RcVJSjOQRIB6zfjgOPRNr0bwfCnMzqEezuMv+XPdHXK2h2T3O
	 AWT1WO5clwmiqXPkDVCzjkOWaxJiKfbRGMGSEbRA5H7jqSUYK35sfVkYkjtxC7lT46
	 OZT3nk6UnBzy2uTegXnEYsrHS35zIrWQP5OIB9ytwLIwOoCJBv3o6tlqmSfdng8oWR
	 fIV+Al1WL54iQ==
Date: Fri, 11 Sep 2026 16:52:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
cc: Ricardo Ribalda <ribalda@chromium.org>, dmitry.torokhov@gmail.com, 
    bentiss@kernel.org, cocci@inria.fr, corbet@lwn.net, hadess@hadess.net, 
    lains@riseup.net, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
    skhan@linuxfoundation.org
Subject: Re: [PATCH] HID: fix semantic patch and improve its performance
In-Reply-To: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
Message-ID: <nn19nq4n-50q0-q920-94p1-qo101s85849s@xreary.bet>
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, Julia Lawall wrote:

> Replace "expression" with "identifier" in the declaration of hdev.
> This is necessary because hdev is used as the name of a function
> parameter.
> 
> Move the two uses of @p2 to the relevant function names.
> 
> Convert <... ...>, meaning that the contained pattern is optional,
> to use ..., when any, and exists.  This requires that the function
> contain calls to hid_hw_start, etc, which reduces the set of files
> that are considered for matching against this pattern.
> 
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

