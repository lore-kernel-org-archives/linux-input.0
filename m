Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC74C8FF1;
	Wed,  8 Jul 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536101; cv=none; b=oTta4yHy+TW9eG7LX7nimSeSQtAFWVkSJGxr8gREpmxA9NB+SXreNp08qNAx9hhDVr6o7cWW4Kf30aXQFMq7bglMBDIBST9cEUn/xGXYx2NV2BEBCTiHkvw5Fg6xaSIRx2eltZN2S3z4dHQGuw+zUoGVd6k5/QV6qbNrSoN3sqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536101; c=relaxed/simple;
	bh=61RkIUJ2qP/RvE+g33eXArqV9Fd6aoZ5yFwYE8GjoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3bXtsmtSm4rttQ+NBm2WaNmlkWg+yA6f7O3KPQo7IwZl3i4SW3mrpXorABb9Jranso1GFWHdBU+dObip5lLm4O/8oNagJH00Sr4RzzvSXnrfmJtOuBIRAipDIIHGh4posHEaeeB1bSGJfO4TL3bjKGERvEv0pWzZ3lslSCCV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO3ZA6i8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO3ZA6i8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8388F1F000E9;
	Wed,  8 Jul 2026 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536100;
	bh=alNkV8EDv6zlCowp+A6tvJeoXW4l2xPTBqoPd3Djy+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YO3ZA6i8xKEpaPk9gLqq3MGsMNakj089LtcJbGe7ZuuPZrs45MxOER/1Jav7L5L3H
	 GGG9d9TEh69TVNEHxmrfmhhHSUjg8XetInDOMthdgxjTI33Ek1odqYLmrnIoBtEZF+
	 6eHoklPtGjlAewNLKd15vFg3uw8XGdHmSG7GPefjwxlIZpnlliathExvM+AVtt3Gf9
	 vFa4CI9YMyQfjH3r71QPpYXGXmPaWGGfXpdYQXoBpMRkbVjBdmGmbfbMb1trsJzOof
	 rMrJD6TVS7jVXCC7IyNhfaJCQnElOTrP8jVViAkM1EF+I8bO0PwIqsTQAvBMww9pLB
	 ny485hqR5NRgw==
Date: Wed, 8 Jul 2026 19:41:36 +0100
From: Lee Jones <lee@kernel.org>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Message-ID: <20260708184136.GK2108533@google.com>
References: <20260616092658.1714548-1-lee@kernel.org>
 <CANRwn3SCQ58hLg00NU844nNxR2B5+f6UvuOYRgXR3x6q96FSgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRwn3SCQ58hLg00NU844nNxR2B5+f6UvuOYRgXR3x6q96FSgw@mail.gmail.com>

On Tue, 30 Jun 2026, Jason Gerecke wrote:

> I'm still working on testing and reviewing this set as a whole, but I
> can provide some immediate feedback on this first patch at least:

v5 posted.  I look forward to your review.

-- 
Lee Jones
