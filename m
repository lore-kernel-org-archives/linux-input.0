Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686230E82E
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257715; cv=none; b=pevrs62AJ2F4RV5AocIuatdDYwTGfCPkGnK0TKOZvYy8THPU4e0uW+ZqBhuamJptmWRTnzrvdgRaMDBX86R7QLwInFHpktB96ZcPWb0Bye0fMhup70sVjKmMqhmYd3bF4AfdRQhbVMzOXzwkmsK1GtW+Ncy0TyVEYVTVgkI+gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257715; c=relaxed/simple;
	bh=gSja6kpXXUojh09M/4kJXwE8p86uDkqtjI3BHopOTGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndxvrnd+08+cJI2EUsvGEths0MVNmuh2D63QauF2+x5NHogPHdr3c/kICVeQgCPOk5C8Q1JQtZ3cwJhRYbQpFlwlEaO8qwqfwYwQqtQuWmnj5vbZgKGLYj/nSMJHjXV9JamH7f5qLS3rJQJoT5IvvvwPFz+ufxKUqWLoEwGVjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpK6rC5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpK6rC5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079181F000FF;
	Thu, 24 Sep 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790257714;
	bh=KjnzZUZd3TZQLHyPIQHMu2uaRT1JlP5YvUqiQe5fdF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpK6rC5x7sEJ8QdcHD3hZ6vQlOa9GU2oPRQDlheKnE0uuA3ngvazta3A7FIDyc3NC
	 dnoc3P4UuvB0V6Qc68OIcTzEBu2VtcADcTN3UDYFsiMMWEm1gUYFKFfLd0Y2xFjkJQ
	 blgAkqh1Wo46VxubXYQ/ZAkWnJMkKCabONg45KQ2IQ5PwX7FjkSpLyZi51DEirMDLb
	 vSd4N/icPGjC1RDkHZpB8Ahw94P1MLCsi0aU5Y5FVbOBUpxe4z3WfQmCnjcc1p9BTk
	 HkY0uKpIaCBy3AcOnEuyUqL02V5ms0095I4moCp5VpxFYumFAIvPZ3ai0WMm5BNlR2
	 K8Q+57b4KDv3A==
Date: Thu, 24 Sep 2026 14:48:30 +0100
From: Lee Jones <lee@kernel.org>
To: "Cheng, Ping" <Ping.Cheng@wacom.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] Setup touch switch for different order of input
 registration
Message-ID: <20260924134830.GC453446@google.com>
References: <20260923214928.18760-1-ping.cheng@wacom.com>
 <20260924065137.GM3864833@google.com>
 <GV2PR07MB9153825A137B384ED830006F9B812@GV2PR07MB9153.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR07MB9153825A137B384ED830006F9B812@GV2PR07MB9153.eurprd07.prod.outlook.com>

On Thu, 24 Sep 2026, Cheng, Ping wrote:

> Hi Lee,
> 
> Sorry I picked the wrong patch to submit. I did update this patch as you suggested...
> 
> I am on vacation in the next 2 weeks (starting today). I'll submit the set again when I am back at work.
> 
> So, you would not give a reviewed-by for this patch, even if I update it according to your suggestion, right?

I'd be happy to provide a Reviewed-by tag for what it would be worth.

-- 
Lee Jones
