Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7D368946;
	Thu,  9 Apr 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748989; cv=none; b=AGKagKiGsr8CHfZFelO3zjpFMvvSPK/vU+0PnYYAhJm9TDR/3BKa5h5H5hJiDRsthBh1ayLhLQ8tK4Ey+QacS++py3ten7v7v/oR0A6+YNB3LKNLQI6MRds69r8o/saXEH/62DfT/4BsdAbjt4SWmDPEBGXoh6DDFapQR808Y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748989; c=relaxed/simple;
	bh=l2HDiYAuPv41xjTQMJo4TXbDoENUOQjegtG57Dv4K0k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F2/RMtPAQzXgRRVLeoH7Vnow6xS1g5rLwT61wp+LOxJa6uaHIh1I+JXz3L5FRe5kbj6NJuQZb4HZVr43rxmmh49zu35dWDf89os2uqo2r+DhFItzIRXsibG2xCIu8lkR5q6kuAxIH6qGB7CZIAtQjUTjUNqLvoFnQRCPnBXKO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFyfFNw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFyfFNw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248DDC4CEF7;
	Thu,  9 Apr 2026 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748989;
	bh=l2HDiYAuPv41xjTQMJo4TXbDoENUOQjegtG57Dv4K0k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BFyfFNw32v7cikwgp7WIOzyxFf2FfbLZuUspupyacD3IZX/g/WKZbFtz5Y9u+8RV9
	 /Ehkd8BfbCNTHg4Sqr3Q2CiG1YZx9AvckFdF+zhr27xq5wbj5pqC/fUsNKQPjCvxkY
	 G6ZqdpeD3p1lsitJljyCrLbBBeNViqoEcgzDUXuGgBKEZopavuhS5lTOehQChz44BN
	 zqC7URqvjMK2f0+leJV9+jdRtcVK4k5QL7tIGmoOXsqX3eaWQTvBYBz5Q81mlvZ70z
	 lg0qn+gerEyOG371iPqJ3zTNnFxyh/DaOUCJiiFXJ2yfCXed5XILkYCoI6VFrhubeW
	 tDoLCiNwNR67Q==
Date: Thu, 9 Apr 2026 17:36:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: logitech-dj: Standardise hid_report_enum
 variable nomenclature
In-Reply-To: <20260407135955.GQ3795166@google.com>
Message-ID: <6ro65p70-nqoq-7s19-or58-sn31ns1r4438@xreary.bet>
References: <20260324143651.342273-1-lee@kernel.org> <20260407135955.GQ3795166@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Apr 2026, Lee Jones wrote:

> > Since we will need to differentiate between the two report_enum types
> > soon, let's unify the naming conventions now to save confusion and/or
> > unnecessary/unrelated changes in upcoming commits.
> > 
> > {input,output}_report_enum is used in other places to let's conform.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > v1 => v2: New patch
> > 
> >  drivers/hid/hid-logitech-dj.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> During a previous submission you indicated that you preferred pings over
> [RESEND]s - so this is it.
> 
> This submission was posted 2 weeks ago.  Could someone take a look please?

Sorry for the delay. Now applied. Thanks!

-- 
Jiri Kosina
SUSE Labs

