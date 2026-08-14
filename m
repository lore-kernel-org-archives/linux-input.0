Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2A45FFA6
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717720; cv=none; b=u9kHfg3UgIml8KuTTIfGEXv3YQS/3lAjCDsvOD2dpNM8PBKa8b1iJszmmecoMPCrAeG1Etf9EIjwOwc5sgs895IvqliD4syWqJa9hVwuRDlmlc1Z1gvcs3CFA4xXiUkwUfUhcHtM6hg7WujesuTiLwzMlOmGBDaxQEVhARZON58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717720; c=relaxed/simple;
	bh=sQX5SxBNvkoCI6Kgpkp97A3zMrin4gRQKJCHIw0aqSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C7/NYUTH04KdGAclda4bjfpSnb+S1+Gwg7Laki0AaTjasAAkHozNefpmtLAysBU6cojXy/j05EdnS4WRnp/EvwWjaCukbVDbqwt8c+CNn7twcOhSPVqFvTOJ9EfXYg4SKqCXB34Q02Yvz5mVZy6xmXd7FSmr+EOfP7lDrU2iai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib5NG22z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib5NG22z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E79F1F000E9;
	Fri, 14 Aug 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717711;
	bh=L1OlmczI1NgsKCC5LONVIW6GQxEPjAH48KoNh7Yn3kI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Ib5NG22z3uWTQ4poz30PDR0mH0kWEnlYymmMlCn7Vdu89fcxv15Vro0PX1ekAG4x1
	 MvRd3f68R3E4KWC1f1+frfDjhSHAgaWQGwNx5D8oIhzHC0wLoAYe9itHWJFLKHFDfy
	 1xHOJG6d+HLLSlPkrQxjC5OTaRILudwbJ60cEZANl07poviAR3DS9xMGEL/FUE4zC4
	 7KiKz4Vx4nyfroM2XOvB4yiD9RAr7Hqp0QToC217115WTJo+sEdXiVrVw+ypFVgynd
	 RptzETfB0dDTaB4yeuw203dCFWfOPDb1NqbqbE7Bn2WtW99g911sJ5WyI0ayWVECP5
	 chaTxQdmA4YRw==
Date: Fri, 14 Aug 2026 16:28:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Xianglin Lin <1021538027@qq.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: reclassify HTIX5288 to
 WIN_8_FORCE_MULTI_INPUT_NSMU
In-Reply-To: <tencent_AC29AFBFF3AF614C95F0E2E59A721D595C0A@qq.com>
Message-ID: <s92q111r-oq08-5osr-p59n-r3850r255767@xreary.bet>
References: <tencent_AC29AFBFF3AF614C95F0E2E59A721D595C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Jul 2026, Xianglin Lin wrote:

> Commit b5e65ae557da ("HID: multitouch: Add quirk for Hantick 5288
> touchpad") assigned MT_CLS_NSMU to the HTIX5288 (0911:5288).  This was
> necessary because the device sometimes fails to send touch release
> signals when transitioning from >=2 fingers to <2 fingers, and
> MT_QUIRK_NOT_SEEN_MEANS_UP fixes stuck touches by treating missing
> contacts as released.
> 
> However, MT_CLS_NSMU only carries MT_QUIRK_NOT_SEEN_MEANS_UP.  It
> lacks MT_QUIRK_CONTACT_CNT_ACCURATE and MT_QUIRK_IGNORE_DUPLICATES.
> As a result, after a two-finger scroll finger lift, the device still
> reports stale coordinates from the released contact in subsequent
> frames, and the driver overwrites the remaining active slot with
> those frozen coordinates.  The remaining finger appears stuck at the
> lift position until all fingers are lifted.
> 
> This was confirmed via evtest on Arch Linux 7.1.3: after
> TRACKING_ID=-1 for the released slot, every subsequent frame contained
> duplicate position pairs -- the real moving finger's coordinates
> followed by the lifted finger's frozen position, both attributed to
> the active slot.
> 
> Reclassify the device to MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU
> (0x0018), which preserves the original MT_QUIRK_NOT_SEEN_MEANS_UP
> fix while adding the necessary Win8 quirks (CONTACT_CNT_ACCURATE,
> IGNORE_DUPLICATES), preventing stale coordinate contamination.
> 
> The additional FORCE_MULTI_INPUT flag is harmless here: it separates
> the mouse and touchpad collections into distinct input devices,
> which is the standard behavior libinput already expects.
> 
> Fixes: b5e65ae557da ("HID: multitouch: Add quirk for Hantick 5288 touchpad")
> Signed-off-by: Xianglin Lin <1021538027@qq.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

