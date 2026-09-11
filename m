Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B24A3D51;
	Fri, 11 Sep 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145722; cv=none; b=osD2H1cGyQZOPWm70R8lvQPGQxt937qdy8HrFMwC93rQP1HgcdeSLLBcM8LQ/ix0k1f62EYEbjgeVN8xhP30QJtG7YUtlXDXYY3x73SzteUlQ5lnAcKrTM6vs5SBpEvsMwEMoKM04V1e6jQSX1xssxrZn6Bolokhuy0WyY6DKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145722; c=relaxed/simple;
	bh=Bj+ZBln4X6/lQrr3PxnaA7pwSPk/3s3Lbhd4ASnvNOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W5BFKF7kg6lz1LJ7B7VH6zTWQkDiPdmaxnzy3sj5y+7zduh7ias+tsZzu3srF6GqNjKHFTJLqn5PW8vFVokPsasq8IMONYfC4gjqvE+QxnGbb/dk31RN3cp6YIvsF7Mt66+n7sE7tajqPsZXH8TGv5qtFQcbuHaI7Xzd1/UsIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwpFNWpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwpFNWpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080241F000FF;
	Fri, 11 Sep 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145720;
	bh=Ii95VsHGbdkDUgT7rvrbhpDgj+WFRfbscTczmv97jqQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EwpFNWpnRsosaLLQ7IwCwZCO4UREUGj2ev5Ibw4TNXE/UiGP/SEFx6WQo+5Bmi4aH
	 fs+wVNt/uqISVRRQodRN+2VWAgk3UZn3sHXHlCJrq3hW9Ym7Q6k6XglanS2U6o8gSC
	 cLx4Ko+H9/AREiTsxPL2tiuxEkLFvXRldvWDT1jZ2C7j57HjOzJMg3jODUph+z9tkX
	 5AOupgQg8RJ32mYT3RZdT+JF18dJaOGhc9kLJIgW/+ZxFAt0eytZTKClhxf3jR34pv
	 XXj1sKoCkET97Eag+mj2v03o/6+EVHiLjCyW9qzZQWRrGCWiyctaJrbUG6eozvpg85
	 4GhLN+NnaAbRQ==
Date: Fri, 11 Sep 2026 18:55:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Oscar Priego Verdugo <oscar.priegov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    YOSHIOKA Takuma <lo48576@hard-wi.red>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elecom: fix bus type for M-XGL20DLBK
In-Reply-To: <20260817120546.273232-1-oscar.priegov@gmail.com>
Message-ID: <q6463540-p92n-6617-378n-05n74r7os9r0@xreary.bet>
References: <20260817120546.273232-1-oscar.priegov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Aug 2026, Oscar Priego Verdugo wrote:

> The M-XGL20DLBK is matched as a USB device by hid-elecom, but
> its entry in hid_have_special_driver[] uses HID_BLUETOOTH_DEVICE.
> 
> This prevents the special-driver quirk entry from matching the USB
> device handled by hid-elecom. Use HID_USB_DEVICE there as well.
> 
> Fixes: 55633e681afb ("HID: elecom: add support for EX-G M-XGL20DLBK wireless mouse")
> Signed-off-by: Oscar Priego Verdugo <oscar.priegov@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

