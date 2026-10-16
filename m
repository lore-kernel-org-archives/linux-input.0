Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D53CFF65
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144314; cv=none; b=ihh4BWX4QaU+QZyWgq6BlCW1pFdypDJuTEfyRkZMIeyC3NJghH4mzBLn9we6iZsGUipKJTmHPRPx7boPGyRqJ7BWbe4Z3ys3Pd3iYmpGFfFzuBTmmhmbTaATuQzKczT/FVZuMufPhsp4BFabbv9qyxogA1TPp8bVkfM+zm6f3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144314; c=relaxed/simple;
	bh=VxFgrQP3b7muq+IcSuPZMX7PMZwR1Beg9P4vK8oRENE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZCbsGaJ9nN9m4Pd3Qtpwq+QNTK6WjCjwQxzD9o9J+mUYNrvtuzU4/ubiYCnF7g3I7e5ooGXZp6QTPUPAuwxJakK6PrqQFnO4LpwpMrUwbDDodAH3QfuJZM/1PGpXYzVRm4b5bFNVSo9wRKVG0zC1F+k9ocMR0FN9xLkhIN3JmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gdluaWv6; arc=none smtp.client-ip=95.215.58.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gdluaWv6"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VxFgrQP3b7muq+IcSuPZMX7PMZwR1Beg9P4vK8oRENE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144311; v=1; x=1792749111;
 b=gdluaWv6H5G88yq8Vvw5By3ZABP6GLLFfEcBGvZCKuj4Nw2dji5FCwU9BmRSk33n8ReP48LV
 T0dAWCgUWMiinR1uGed7WjsA20dHhqzXUKNtdHHE73z3pv1wClvykNMHg5KyMZmRWUFdZg4X7GG
 BUYb/41RIrFM6azPcEtC+92k=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26f2fc036871b972;
	Fri, 16 Oct 2026 09:51:51 +0000
X-Mizu-Trace-ID: 26f2fc036871b972
X-Migadu-Flow: FLOW_OUT
Date: Fri, 16 Oct 2026 12:51:48 +0300
From: Denis Benato <denis.benato@linux.dev>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>
Message-ID: <91f1f9e4-3ded-43bf-86f4-85d4abb9c282@linux.dev>
In-Reply-To: <82q38prr-84os-0n4p-4337-683o299512qs@xreary.bet>
References: <20261009122820.7603-1-denis.benato@linux.dev> <82q38prr-84os-0n4p-4337-683o299512qs@xreary.bet>
Subject: Re: [PATCH v9 00/12] HID: asus: add support for ROG Ally handhelds
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <91f1f9e4-3ded-43bf-86f4-85d4abb9c282@linux.dev>

16 ott 2026 12:42:46 Jiri Kosina <jikos@kernel.org>:

> Denis,
>
> this unfortunately doesn't apply on top of hid.git#for-7.4/asus and there
> are more conflicts than I am comfortable doing without actually being able
> to test.
>
> Could you please respin this and resubmit?
>

Hi Jiri,

Yes I'll do probably tomorrow after returning from Larnaca (I'm on vacation now).

There is one (or two) patch that is shared with the rog xg mobile but other than that should be relatively easy so I should be able to make a quick work of this, thank you!

Best regards,
Denis Benato


> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

