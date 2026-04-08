Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2094536CDF8;
	Wed,  8 Apr 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686800; cv=none; b=WbWk7AJwzvIRQdKBw+4zsuNWrRhGZFKw8Adovh0fXczyLbEK2OHoULWanR6nc1VToLjQsKQuAFB/+tl+OYR98muGN8W9jrfcCQpiRHfAkod7VyewmuhicPQWW5E6OHk35dviW7MbS8vU9qne2Y09w/xIFUzGSN3zy3CZ8uKUs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686800; c=relaxed/simple;
	bh=pDfc5qh29eGb4XdLO6xFraNPQ6Qug2f/jNfa5W4JIh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cyI6ep8vTpsoflJ6qffhD6HikyKf9cKD8pXwrfHEvNOPvSBsE6KlGbzEA9+lpwWZwQj69Lg2iUCBnG4bw3Ta+QaRMJ66bB2YLz5D307yyTuMzxyGjUFD2uKp2KG7snI19NVee4mjB61plg9LjcrCUVyqq5hzbag8XByHCT/Y2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewZwxZjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewZwxZjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62123C19421;
	Wed,  8 Apr 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686799;
	bh=pDfc5qh29eGb4XdLO6xFraNPQ6Qug2f/jNfa5W4JIh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ewZwxZjhZEaBq0NVI9NBgM/sf3ufH999kn7fjjxJzAH83osV9p95uqGsI2S66Tq79
	 jEXA5lbCdlIdsVd3lRQ22nnU+u5yebW762maCuArvQblmput1vDbzI134uYYm25wiB
	 eQntkzYk1qw+bnFoHKtQ9NAcb9j44qhK32O5oW9DYvSUZIdFWa6nCN1pMQ0/+IOSf3
	 0l37j44JSY2+wYg7FjxVQXNXqduOJtV9oNBJc1gkKmsvxxLsyXxH7dbEU3rQdIYQgJ
	 S6ApgtsbIVfjR4bVm6FY04R702MSWz4uOqaAAdV5eFdbZZxN7ObOPSityTkbcV0xt7
	 rLIhkEnJROKbg==
Date: Thu, 9 Apr 2026 00:19:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sanjay Govind <sanjay.govind9@gmail.com>, 
    Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: add support for more instruments
In-Reply-To: <cb0617fb-76b0-4241-8fba-982a5ffa4525@mailbox.org>
Message-ID: <r803963p-778n-84p8-3046-s7118rr376pp@xreary.bet>
References: <20260407194636.9671-2-rosalie@mailbox.org> <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet> <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org> <o488s484-r1os-6736-o800-7on55687757s@xreary.bet>
 <cb0617fb-76b0-4241-8fba-982a5ffa4525@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Apr 2026, Rosalie wrote:

> Yes I do apologize, and I'll be mindful of either doing a series, mark
> dependencies clearly or do a pull request.
> 
> I didn't expect to be sending this many patches at all in the first place, but
> one minor annoyance of the code bothers me one day and then another day
> someone else mentions that e.g a device name is incorrect, so that kinda led
> to this chaos.
> 
> Apologies and I'll try preventing it in the future, and thanks for the advice,

No worries. I've just update hid.git#for-7.1/sony and I believe it's now 
in proper state with all the patch dependencies correctly captured. If you 
see any issue there, please let me know.

Thanks,

-- 
Jiri Kosina
SUSE Labs

