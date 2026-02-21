Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D40194C98;
	Sat, 21 Feb 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667664; cv=none; b=O+aZpJTxKOZBj8m2dZbnLdBMipiJW7of89pEAaaAWq66K3Ga0aFFpPgE+jB/vOIdrtfh0m5yRXJJ3z/jrjEHS85LyoWIt/oT01Jd1hCRrUOp4aTh98UcL9mdZgw0SrdojXobcZuub+412iULbDQXGsDIxa7qISTFZ/JzLjNiptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667664; c=relaxed/simple;
	bh=p1Yff1SSucxGC2JKcCgs/0UIwXlAUrbdKlZ4wuyd6I8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VFniKkvel57+qLQxpcgwAIE4NGpB22rT4LFEH+DDlx3Gli9adExNNiGQj9rcmsYZsLw2yHIGK3w7MKResFUe94Sep4pbT9VHXM1hp3zoPuegxhELY7vTYHlQHOHhrCrnvoVV1NMi2J7gzv7kd/TFlwyF5GtQb/pT8YMZv60izVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPCJS07Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPCJS07Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DB2C4CEF7;
	Sat, 21 Feb 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667663;
	bh=p1Yff1SSucxGC2JKcCgs/0UIwXlAUrbdKlZ4wuyd6I8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CPCJS07QRc5KkmQADQRKod5aKWoev9Rx8MOOnXn/RvhNUHEHHOGo30Nvb3DlAH6BG
	 VZaVkf3RMmS3qnkzpre92QvMDSDSuL7ehcu/ELlvVbM5Vvv89+DmhdhD7Vdx36I6XS
	 e385V/BhyqS0oo0T+c+vQS/stLhmGWJhtDE+nz2GA1vxICYtnqR0TFguqM9ql4hLPY
	 anOggnVytpLK5pwBfd6OuYfcsGcb082VP0ODmRPE+1nKSACDFxUVuaLzXtFqkbSviV
	 FRBP6gT+rDj9KIfgAO648p70PTe2B1t/7W4VlDeA/DbrD890SQeC3AexA+dEHe7FXJ
	 9vNabT3GnaH7Q==
Date: Sat, 21 Feb 2026 10:54:20 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sebastian.reichel@collabora.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: new class MT_CLS_EGALAX_P80H84
In-Reply-To: <20260217115152.35910-1-ian.ray@gehealthcare.com>
Message-ID: <3spo7082-sn3p-prno-8618-33spqpp44900@xreary.bet>
References: <20260217115152.35910-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Feb 2026, Ian Ray wrote:

> Add class MT_CLS_EGALAX_P80H84 to describe eGalaxy P80H84 touchscreen.
> 
> The eGalaxy P80H84 touchscreen reports 'HID_GROUP_MULTITOUCH_WIN_8' and
> this caused the generic 'MT_CLS_WIN_8' class to be detected.
> 
> The new class does _not_ export all inputs, since doing so results in a
> visible mouse cursor when only the touchscreen is connected.
> 
> The visible mouse cursor was exposed by c23e2043d5f7 ("HID: multitouch:
> do not filter mice nodes").

Applied to hid.git#for-7.0/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

