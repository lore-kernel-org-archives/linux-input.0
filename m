Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569B2C158D
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079896; cv=none; b=gf3sAWdVISqryBV+qCeVyyHOwBB49tKCr8+MubvwhfiZImK7PTTOms6gc0236+5z/CBjUE+n/O72ordTDjiGDiAyF4rXWpGVSChL0XnKgQFrYpSCK6XeIIhzaA3cyekkwcqy92ObPdww4lJuJJXzzzrnmKQiJzJyhFFsOAeMxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079896; c=relaxed/simple;
	bh=Qrin2FaaPd1rwkTqhOGm8c/YGbX8vcRH4wmUrX3MCYs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BzGby5+WCeltag/MGGWORt/ukYS7JpSyVrzMSosyycfRMfqjG6Qtmyk9Bws//PnvIxKDs44wkC87xoDPXYucxdzcRTtxGojX+fZ4oezoeOGBebAGHIxHWKtyuwddf2FI3pSmPjpNkr2urrkTJMPcAY7YF+zjXVnAn2a6KKzuI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnTZ8hZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnTZ8hZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D72C2BC87;
	Mon,  9 Mar 2026 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079895;
	bh=Qrin2FaaPd1rwkTqhOGm8c/YGbX8vcRH4wmUrX3MCYs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bnTZ8hZz2YgqV8urDCZa0GA4faP6QptdzmfwkQQZtLIH2i3sHwm9lHQqs2Bz8aT6A
	 rAsj1ajAJyQaspaC/+wm1y8DeynUyaU1xv5uRdPz6/dUe9YKD+5+mucWcMaSUuTi+h
	 zy9i9s7T7GS7Vu/JjRo280eZv59d7hDQHGofVxvpy74Z2VuQhoEJYo0HPzwnXcWqi/
	 9VAFbItGX4QeBIIFjUwbIJMqpOcPTSan9f2baxScgZMdLHHowLGBt3WJgUZ7e0LVzn
	 YffgYofjiCFa15rc1VIqu+iR7Qw4rJ1neMGeEi7WLJxP7yHv9GM8jtIXITxVJRCBOA
	 DITXcwaUXTD7w==
Date: Mon, 9 Mar 2026 19:11:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, ggrundik@gmail.com
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
In-Reply-To: <aaWvxHt5RPeSRGxJ@venus>
Message-ID: <nq916rn6-06p0-93n1-r12s-n270qn08o11q@xreary.bet>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com> <20260228145258.76937-2-johannes.goede@oss.qualcomm.com> <aaTZIcPuY3qz5MJm@google.com> <06d2504d-2b66-4ae7-94ec-8c062a8c15dc@oss.qualcomm.com> <aaWvxHt5RPeSRGxJ@venus>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Mar 2026, Sebastian Reichel wrote:

> The rationale and the patch LGTM.

Could I then please get your Acked-by: / Reviewed-by: recorded, so that it 
can be added when applying?

Thanks,

-- 
Jiri Kosina
SUSE Labs

