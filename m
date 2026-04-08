Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE43537DE;
	Wed,  8 Apr 2026 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688253; cv=none; b=CKZyv7CyNkkY2SFOMfAyn8Csy2SMBRynU0CZdozFL0ISMyLqcLwM4k/eQ2y5+vRdSjzAdNWpDNmdJD3s1E/fKDw/ooEY8G2VEOapB86Wfp2p4LtmgUzMQCM8NG86oo5xwNdG2DD929utID7YINcJQwNAEzhKj6K1C5/4P1XTo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688253; c=relaxed/simple;
	bh=J0r1jzzYEIrYEMhMdIzB6i2rUsovCvaoU/VYfi0FAeQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fLT0FXAjxNqIen2GwsLtsMIiqNZy06oBkQkzvVnbBt3d+huUBn0kxsl2flthc8af+mHH2gTDy7XkUbXvIirqzT9fiMULDeKxkFjlgvKWdaI/WqsbAk2UE3sg3N3wVj0Td1Hpw2FVm/v9hWd6QqNjux0D5RbWAGZ368pRNbP5vNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfHsl26b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfHsl26b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA4C19421;
	Wed,  8 Apr 2026 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775688253;
	bh=J0r1jzzYEIrYEMhMdIzB6i2rUsovCvaoU/VYfi0FAeQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BfHsl26b9jRMC//X4ncsw1B2+zfkdHnQaG9oaUNsgQ6t0L6Rzi804WCrpoDaCe+RI
	 4DB65nP6Ei/Ix0KHMsPA4QLVIjzhlpU2T0kL7iGUCjPp69agkgtv3NmBO4iSQ6Cmic
	 wV+d3y6ABwmLcswnXcGbhpyEzRZx/p3dlBH+cnzqqgcitutW7AYtmQagNF4XL8Tfl1
	 atJOnQ+LVPCzA+I2Jgh0QzvcJTH2t18cFdFjYKpdqBTHnMA1wXjLyIbchnkzvZb3HC
	 nE0lEnnwS4gvFBz3wHu83QllP1T7qjx96ikqGjWDb9iKeSCdk7wNHDDwv/5lG47j2O
	 IjpbVhVjzT2sg==
Date: Thu, 9 Apr 2026 00:44:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sanjay Govind <sanjay.govind9@gmail.com>, 
    Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: add support for more instruments
In-Reply-To: <21996a49-6408-4fbc-b11f-0d9cc503ad10@mailbox.org>
Message-ID: <7287np32-o208-61n5-677q-3437r81r9oq2@xreary.bet>
References: <20260407194636.9671-2-rosalie@mailbox.org> <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet> <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org> <o488s484-r1os-6736-o800-7on55687757s@xreary.bet> <cb0617fb-76b0-4241-8fba-982a5ffa4525@mailbox.org>
 <r803963p-778n-84p8-3046-s7118rr376pp@xreary.bet> <21996a49-6408-4fbc-b11f-0d9cc503ad10@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Apr 2026, Rosalie wrote:

> It looks fine to me code wise, and it compiles! but you forgot to apply a
> patch you applied earlier to the for-7.1/sony branch, namely 'HID: sony:
> update module description'

Thanks for checking.

Yes, I am aware of that one missing for now, it's in the queue for next 
time.

> Other than that, it's fine, and again I apologize for the chaos,

Np. Thanks,

-- 
Jiri Kosina
SUSE Labs

