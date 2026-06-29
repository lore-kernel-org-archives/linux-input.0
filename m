Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976A3F823B;
	Mon, 29 Jun 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723951; cv=none; b=Dls1yakYEJ+xtORMoLfwamzv2GU29BUKBVD+tnmPvU7g3KNv44VyFBRff0o+rTeV6LuBkEAJht0DJohRi6FpSh7M9ZYyLd4Ja2hdWOTlSjiVRvyubCGoInJ9XZZP/gPfgX+tb0XUeFgyGTapk7NjROuqJozZp6NhfIP6XDYY5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723951; c=relaxed/simple;
	bh=s/i6TsF9qToW/mfG5AsW0rgP7bAbZZG0sIQ6fd5yBXM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hMVBFLOs8g4Vyq1IM78RD5HJW73Ogx35KR4NGQwG5yTxpkjekYiW6m0abT4gGkUBX6w5a1qYYQw46GIked9c9hBglQQY27tWV7N8AcEAimH1F7myelS9zodaXcRT88wLV7YeLzuX0c7AeMn1k1WPbh6yULTuy5RhXaI7ufaWTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfZrD6cH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfZrD6cH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31191F000E9;
	Mon, 29 Jun 2026 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723950;
	bh=kxFZ92lRTjxq1TsejX5VZPB6lVdxPmrX5KJHwzwtypY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=KfZrD6cHVic7jRMvvVY7Wk0qJoiAUYNTnMipmpJ8+9xu7QBq5HMP0SysSJoqwWkde
	 tc6YCGparLihdgJbcdjKS1maDDPMoV3c2zY/DmLs+gpumD2tfvtnl712TV1OnHkW4H
	 EBnrKnC6NYw6t0XuMcPH1oUEA1YBfq7nx24Bvl52dpU1V6Ri35dgwb8ld6RaVhkN7e
	 DbsK7rUx380eZWF5IdxiuSKfVl2OBuOYTtyp3vemMPpsUgn6G7/wMvlvEdkn1ikHTb
	 axipo4kKIwDYwTYwMDcroFcDRFZr/8xE6riPbsP2NnTzQa7m6xaAWkqu+9TMY4H8o+
	 dL/G0tUX7zG8A==
Date: Mon, 29 Jun 2026 11:05:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Peter Hutterer <peter.hutterer@who-t.net>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
In-Reply-To: <20260616092658.1714548-1-lee@kernel.org>
Message-ID: <r1p5r875-5831-r737-6npq-q38n09o63967@xreary.bet>
References: <20260616092658.1714548-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Lee,

thanks, it looks good to me now.

I'd still like to get an Ack from either Jason or Ping on this before 
applying, especially due to nature of patch #3.

Thanks,

-- 
Jiri Kosina
SUSE Labs

