Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD093624DE;
	Thu,  9 Apr 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750316; cv=none; b=ikHEY9Ur+D7oUG1OTHQTijEONs9XDwWl4sfZ5xZhfM7q1Rco3SfxW5eajhJngj3DN6E5tXbUFnMFpLTFTL70m30oV4MJFxd2PCsSu66XSeHY5S+Z5oH+uGCBXmvPQ6G0pyb68lCwoEK4tl58ZsCnllR5x37LajtYENIuZmt/9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750316; c=relaxed/simple;
	bh=jQj/r7Jxg9dGziOOR621+A4MxvmiTARyzSLpXkG90lE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jEM6Bcg8wrjQYo67SZkRYV8/diXrJCHZsLjnofbT4XMw69Z9vxuIo95xbWfuSh+5lRNndqTTHkqGDsmynF2l0JbUOYxi5CFqTRlWefaVMp/lLMLH5Bp1k+q7Z/SljGa9mZQjIGcMlVTM/S1hCvT0QB9u4+awqGirYge3jGcAPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWxXiIgl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWxXiIgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A6C4CEF7;
	Thu,  9 Apr 2026 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750316;
	bh=jQj/r7Jxg9dGziOOR621+A4MxvmiTARyzSLpXkG90lE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qWxXiIglznV3vgH6ptP3vR7rCZOZKS2L5rQadTw4/R/iwTCNaXuA5qGbL/LkBCwpS
	 EsjL5azIx6M+QL6tbs+LEEVNlxqmCuwrhF/0p+EtKyEtlG15jWwNRnq9UGJ9PPfK1M
	 oyO3mhJ5VnBXwjqxudsIhtErcPfEXuI1aW49KJTbqFpLPXwyQhz3yJcPqCJWXzr+k/
	 XsQP6u/7ZU3P/V1ck38VwnglHvjgniglWUyesfAhI//U2hEszyjH5wIZZk4WpaVuEK
	 7fdc0JYaiwoAHVgKaVhDxtW4H6XsBc/Wtb+LN/Kci3ywASQdaunaQyPDlbx+E41TZh
	 qLnK0YFuAzwyw==
Date: Thu, 9 Apr 2026 17:58:33 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Johan Hovold <johan@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: refactor endpoint lookup
In-Reply-To: <20260330095034.1662231-1-johan@kernel.org>
Message-ID: <487p6rr1-r913-8s90-n6nr-rp4n464q7sqr@xreary.bet>
References: <20260330095034.1662231-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 30 Mar 2026, Johan Hovold wrote:

> Use the common USB helper for looking up interrupt-in endpoints instead
> of open coding.

Good catch, thanks Johan. Now applied to hid.git#for-7.1/core-v2.

-- 
Jiri Kosina
SUSE Labs

