Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E836403B;
	Tue, 17 Mar 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788479; cv=none; b=Agmc+Ps1nCXkG+SHG5JwtsT4odNMhHGG3zaom6LH4s75fnsw59msUcXkqN6/TSApNelviCFr5u7tZazDsqIOCdMRWZ81YLx7XU9+LY6ZzIV+CRtknBFcDjJ/3VzneVavvI0N1wZUjARApmLYQi4UYp/SjMmyeCaZwYPRFjM5A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788479; c=relaxed/simple;
	bh=+n73CfIPb0rVz3cC5+0UQunQY4UMPi8qXLIl8UIG9tg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l3sddGHpVBkIkr/JKFgPvG4ZUZy05DKYs4v5QWEgO/nDm5XXuL6Mj11sByPPyZPm3ujPcGz1LRuSO6Cnw+0zP2Wfrna2tCajbBTpsGJ8cKVszc0l6P5x9NtgsNopYIoMrpvf/1dvmIlo7EPVtXY1ID/WZc/qtxi7SC8FIzPI6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8tAY2ti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8tAY2ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF1BC4CEF7;
	Tue, 17 Mar 2026 23:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773788479;
	bh=+n73CfIPb0rVz3cC5+0UQunQY4UMPi8qXLIl8UIG9tg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=B8tAY2ti1uv/SjaTZsE65fqR/MUGL2N2act/v7mp74nrvTU/KjLnj4l2+w8BdeoDm
	 KLRQ3UeRqJrG5iNy3FjfLatB7f2QxOGyTUSGenAMk+A7ORb3VW3iI54HoWfTEKH321
	 QQS3Y9BXpxGETYimdw6K8YHiah4qMZsqyvS8knlpiRbOc0Ea0Gj4LRlJqzl0fFdgun
	 /jQiNH3sMMQvRiVXRpjNNya5v3Dp/FLMAq6swmm/dPh2Mt9JuCKJ+Szs6vzI+kZEnt
	 dufx4diw8vccSw9mZG9B+eKOYIOvz5xxrXnxCUZpbEF0/tGLAl5S1abKue3VzGW0bP
	 HvnuOc9Y49QAA==
Date: Wed, 18 Mar 2026 00:01:16 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add THC Nova Lake device IDs
In-Reply-To: <20260317055629.3877299-1-even.xu@intel.com>
Message-ID: <q73969s9-n2r4-10rp-1459-3nnp0322ro9p@xreary.bet>
References: <20260317055629.3877299-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Mar 2026, Even Xu wrote:

> Add THC Device IDs for Nova Lake platform.
> 
> Even Xu (2):
>   Hid: Intel-thc-hid: Intel-quicki2c: Add NVL Device IDs
>   Hid: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs

Thanks for the patches, applied to hid.git#for-7.0/upstream-fixes.

(for your next submissions, please follow the subsystem standard 
convention and use prefix 'HID:' for the shortlog, thanks!)

-- 
Jiri Kosina
SUSE Labs

