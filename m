Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE52E7BD6;
	Thu,  9 Apr 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750161; cv=none; b=oSxt3YqX4iVUr7LvbHPPqU4OpM1vLGdMqk/HZ8LxQndRZ97LyEcNtNt8peViRwQkb+dmveQZ/VZSRcv6ycEwbTzR1hWrEEtNJlH77BuL14UKkSVWRB88DoNnNyxBrH5foL3Iu/hW5HfYYYTyvSuOWpMor8GpII+3ENvR+fsteF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750161; c=relaxed/simple;
	bh=0IM9YTgC7ARbpVqNyobooZWNvJnuL1isl+d8tXcd/tE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fygfCSt2MLdd8Yj4FpmZjKjouJ8CuZ+FeeYY5b+2o4JdJq0INWhy9tXCOxVzJzJlHZzNRaJM71sbj0ARECPWIxvGpuIGxAL75Sj/q2aahWZvQlRYOAW1R336GZZxp1HoCHoSErYtZzkjJ2BrTBsBWEd156Q6Q+bRGUA/hOuvVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFjBgUL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFjBgUL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BBAC116C6;
	Thu,  9 Apr 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750161;
	bh=0IM9YTgC7ARbpVqNyobooZWNvJnuL1isl+d8tXcd/tE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JFjBgUL6V/5oNU9eK0ESeBycj4BUTPxbJM1DKQwFVI9e0D6sZwoRXDzUCkYTuG4zA
	 rcHZ17PfBTj6z9CC9dhpADnfvuzo+kfT9vL6b4h03wLfNo9lDCbz+Zot3HQOTkF6kh
	 AzZ7dSPMHWA1E5mXmlq211ASV8qBOoJvQ9jiwX29MW/YsPscqU6+PoHPld5PRiOE0R
	 W3Kgx0r6vrQVsKlP8oi8hgO7ELGwzdWESZqWs5JOgM71QuMRFliVNL1pvc+GMDT9Sc
	 cbnNqYV67JNe2YaIYxji69Q/Jftgxkf40gLeVL9w4Ao+c1Fcz+6OuFjj4aiL1DBXtg
	 0mqhWbxzTu7Eg==
Date: Thu, 9 Apr 2026 17:55:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: FirstName LastName <bsevens@google.com>
cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: validate num_touch_reports in DualShock
 4 reports
In-Reply-To: <20260323124737.3223129-1-bsevens@google.com>
Message-ID: <pp804rrn-3n16-39rs-70o5-10790591004p@xreary.bet>
References: <20260323124737.3223129-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Dear FirstName LastName,

there seems to be a way to fix in your mail setup configuration :)

On Mon, 23 Mar 2026, FirstName LastName wrote:

> From: Beno=C3=AEt Sevens <bsevens@google.com>
> 
> The DualShock 4 HID driver fails to validate the num_touch_reports field
> received from the device in both USB and Bluetooth input reports.
> A malicious device could set this field to a value larger than the
> allocated size of the touch_reports array (3 for USB, 4 for Bluetooth),
> leading to an out-of-bounds read in dualshock4_parse_report().
> 
> This can result in kernel memory disclosure when processing malicious
> HID reports.
> 
> Validate num_touch_reports against the array size for the respective
> connection types before processing the touch data.
> 
> Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>

Applied now to hid.git#for-7.0/upstream-fixes, thanks!

-- 
Jiri Kosina
SUSE Labs

