Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B839184B;
	Tue, 16 Jun 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643308; cv=none; b=OYBBq5zSEf9fZfKX0sPLMnXrNacL0IT57MdOi9I1IGY3+aYK++Qo/U149dmQ+5o51/1ah3vfaSnwHViuh8ohLOKsTnVyTyEf1DPeSBGRzA0k15jFZu1wn1bUhA14/f7+9DfVeefVyJ6ZZzhVw7Jy/nE8W/4OhoWGpIyyeizDFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643308; c=relaxed/simple;
	bh=JF7vQTseJyCClDlsTDewd9NpGzGEIswPYFeplvdK0JQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jFVIHsAnu0yMG1qyISsufLpjfanIlim4tIqQA3ArQ/Q6wvCcX8U1HtsR8NOaJVsGjWo3JB47ovh41g2vzBte8EtRrwZhypmTqaIKuaFLBT+FdPtWkpNnxGs0oYv300VRGETZl4KvW3sgxholW0XYgZTKIKJzYggdLqGDpPvkBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbbag6Bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbbag6Bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E781F000E9;
	Tue, 16 Jun 2026 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781643306;
	bh=FXpDFcs11P0h/PAVwMROS5HO0nv5/WlpvOGLnADPazs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Cbbag6BfD3ZhjhddGsaiR66xb6T9WzQ1bECvAQN6F2rcXLD7tiHirr6YUfAyIptGU
	 cOx6DUlYGpBQIZNWgT1Ah/wpIHRt0DAI+5KpWpUPWzlbAa/VEyWnQDDSi46szW/x75
	 WfNHlh77Mk0g0hpdw2T+oa+oxTNUYB1zZC0t+ykRwM+w7uF7L/2jYy1TAa9mVc3PzC
	 NUPC3qDFF/SgLyqrclbFqb6xvY+lYnoNPxffgfzVJoQhb98DXzwEA5usxq5eiEKm7K
	 iN1B21gaABZZXQYlSu+Xk/wgvvFHNXAPIPJ3WoZpnBYgZ/GksmX3j58kEkNh+++var
	 wAflsPF9wyfuQ==
Date: Tue, 16 Jun 2026 22:55:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] HID: sony: more cleanup
In-Reply-To: <20260616205042.6671-2-rosalie@mailbox.org>
Message-ID: <5o965110-3959-0061-1s41-q7224452q746@xreary.bet>
References: <20260616205042.6671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jun 2026, Rosalie Wanders wrote:

> This series cleans up hid-sony by utilizing modern helper functions.
> 
> v2: the dependent patches have been included in this series

Thanks a lot for this, Rosalie!

Your patches have always been a little bit confusing to me when it came to 
inter-dependencies ... now that this is sent as a series, I can easily 
apply it on top altogether when the merge window is over.

> 
> Rosalie Wanders (4):
>   HID: sony: use dedicated raw_event() handlers in sony_raw_event()
>   HID: sony: use guard() and scoped_guard()
>   HID: sony: remove unneeded which argument from sony_schedule_work()
>   HID: sony: use devm_kasprintf()

Thanks again,

-- 
Jiri Kosina
SUSE Labs

