Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A24ACC9A
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441788; cv=none; b=m6jRsPEwS+Twky7UniIcLkDur/ecwzvh/JX6Rc8tpbsrDSFO15B9vS9h5orZbG5Oh3uUc3wFd9tXsgAC0Dycv18vZ021knzagjSWQDkUce3mZTuxZvpRJYKcMVFj685ouU7QYDJomawChISVBwUarAtboTrmmdUq+uXHR9BZM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441788; c=relaxed/simple;
	bh=xlTsAxZXmPfvdwkijolNdlrkPZoO8P/maWgCFphjGhw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=isaw+DM4YeEs9zdSSxWGhuX3U2GycsrbaL63GTkX4qhbDPIfJXsdzc6xFqScHmtmnLmDnFMRELRvxsMvYB/J8spzp7U+AJfkCn+HyjGIqKhcBucbgcGgV/n8XqbGoJFlVlqUoOSmrdncHXjYQtigFDX+s7DLyel+AIWD/jfB6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=G5rHSkMi; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WAwBdsOz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="G5rHSkMi";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WAwBdsOz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=G5rHSkMiunsPFLJywNM/wGdUI8jx6fqHPB7ipruTMkCb1LASiXCkB9ihW+unjJo+bU8EO17hTBDuXPjg9d5eGfBfgwCJrDnPzYEZVrPiVQSmMxKJnvEdy0bX554HRIM4n9s7NiYfn38d+DP0+LB3lQ8VvpgLY1uCXGT2CbvMPC983OLCohqKs/gRT1ms+iParjj0w/N5qY3RcPBw5VJ563aozavgLY3CypED8DLVcuUnnURV4hGKPvjDdP0kjVwGTDind8Ahke07WOtvnlIbn0ftOluBgUUAAG31ITteWz7jgKYOiQ8aD80o5X2OJuQB/eamb0yac5abxbhA4RegvA==; s=purelymail3; d=rcpassos.me; v=1; bh=xlTsAxZXmPfvdwkijolNdlrkPZoO8P/maWgCFphjGhw=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=WAwBdsOzOqjoluXjKqAMenhihnygiOut56cq/jTkZUPIDUOGvlisTEWCMXgjInv7TWRPUy+oDobdauatPtlILTNp/7A7zTYxWpNlrHOA7KHx1U4csKp7Ad4yLW1tAIvSsu4qWFHHFhM89TvbAWz3drYIDABAihvxlBwbhqIeo+rMO8KbkD6h4THieUSbrx92p1EzpJs1EVT20mQWMdX7C4t3kCogNdPvQOwE2imLgpavWnON2labpsLtBIXwlvdtOhbR1M7yiO2Lgj97Snw4L34j8WR+aB06cHDx85ptS96p6dmDaIxLJeDwT3ZVTiyW/KHlxiMXw+AvgZnN51yzng==; s=purelymail3; d=purelymail.com; v=1; bh=xlTsAxZXmPfvdwkijolNdlrkPZoO8P/maWgCFphjGhw=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1652801101;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 03 Sep 2026 13:22:29 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 10:24:35 -0300
Message-Id: <DL5PQFFLYF7Z.127SLIUU7U11H@rcpassos.me>
Subject: Re: [PATCH v3 0/4] HID: wiimote: new LED behavior on connect,
 scoped guards, uaf
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rafael Passos" <rafael@rcpassos.me>, "David Rheinsberg"
 <david@readahead.eu>, <bentiss@kernel.org>, <jikos@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260729164928.1138468-1-rafael@rcpassos.me>
In-Reply-To: <20260729164928.1138468-1-rafael@rcpassos.me>

Hi!

I'm looking for feedback in this patchset.
I believe this is a good time,
since the merge window was just closed.
Maybe this could be ready for 7.4 ?

Thanks,
Rafael Passos
