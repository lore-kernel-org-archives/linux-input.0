Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E5225413
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321706; cv=none; b=dCszfpE8hUQgHMagDDdGwPpsLJXrvXS17qH+zKmwF8iPJKpn/gZ2zLq/ouRUiACUbidzR5IzvuBQ0Eezq3PDl5sAa/6L8I10RFvvL5DRbPgSOihLi/cqI2wBqAgoPdo2fV9hdr9LSPlwuPJobbXzFsuR8BhAYAMW6d4EtXa565g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321706; c=relaxed/simple;
	bh=R/d+5abW1Anntjl8w6nu5DCHxaWIiup4Plkw/hnrK0U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HXH6qmxVnmSOi8y8t5QpAYuEqUxS4HEdvDkzQiCQdKGj7fDf+UwgAnQRxS74i/qfvUFfP6Tj5zG06CRaII8U7jv8IyK8KX1lYnDV3XIS+Ltdw3vuU/2zJOB6w1bMdCk1kyo9fvNYLBlEMQOaHjSddc1MUJeHv68lcMXaqk++L+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9xEmipp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9xEmipp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3B5C4CEF7;
	Thu, 12 Mar 2026 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773321705;
	bh=R/d+5abW1Anntjl8w6nu5DCHxaWIiup4Plkw/hnrK0U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=E9xEmippGdCD9le1ALZd8cy7iaeh3fTW3fu1r6bgYLGMXrWRjcDpiVAnbiEkbouXf
	 wQHeiW736kHCl2VyQWUjkXyyVF/QjjLYkb1SwJd4LadvfCgiP5UY1xa/6hkqamEqjC
	 xpXuxkf/IyF1n8CkczHkOqyN5Avo1KNkkoMX5+U52y0USYpN2Cj1MG/BuW78JjPJyf
	 ESt7bJO8vfNKdWseTwHKtb/8v1ILaNyzPHZDLGgky/jCGmkJr+zJHk2TW1ncdZezSJ
	 BXEWUhZaoea4Ik3M1BCA/K7ZDr243Qp8MLHax99xLlqwK7wY7zj/uvjz7T9Mp8EFx3
	 nrfGhBkcl7Ikg==
Date: Thu, 12 Mar 2026 14:21:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCHv2] hid: hid-pl: eliminate private debug macro
In-Reply-To: <20260303084359.1206434-1-oneukum@suse.com>
Message-ID: <78nn1909-3sn2-p994-op2q-370n83rr8r73@xreary.bet>
References: <20260303084359.1206434-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, Oliver Neukum wrote:

> Use proper dynamic debugging.
> 
> V2: use hid_dbg() instead of dev_dbg()

Please always put the 'vn -> vn+1' changelog below the '--- ' line so that 
they don't end up in the final commit.

Now in hid.git#for-7.1/pl, thanks.

-- 
Jiri Kosina
SUSE Labs

