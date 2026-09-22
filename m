Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760713EC6B2;
	Tue, 22 Sep 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103284; cv=none; b=EQMuESHN2PG8E/1qJx3HEY3lGBSzJYaCI7DJsJkKtPrQYpuqB/TBFAnjZOIkj4RQpnZ+6b417lj8SJfpOfmNzrie3P9fH95EYS6GZ0JIyLNaxFlA0APq2/Q8lIK//7hQm4gA2SJG8TO21NAQZeE8mhs180/O8B6HswLIYVysGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103284; c=relaxed/simple;
	bh=7GMuPDjmU0VOvXrQEGvNdAAstFZiO4Q3BeVLjuaZbHE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RGKSZjtmZGlDLReVXKHfohpnE1VR/EIYllDT5yjkwv4xr0dk4ywAqj4/IeLeznrkMqGiL4MZs7hDQfseibFOV1bqG6H9eoplF6xhDx2LUoFi/gGNWWa0RqUYmD88icv9LJ4pEivJyLlD+6ie8Tdl3VZ0YhWzTocBfa3OkQEguhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvV/BnzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvV/BnzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C66E1F000FF;
	Tue, 22 Sep 2026 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103279;
	bh=thuhAKia8WEjS16Dv0nCKqg8mAtgTs2pGHhvnrTWZSY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QvV/BnzA48cYWrm6KtIt3W/45P5v28VujMDWp1ClR/EqpKzHjwy+lvNl4dLbJn51K
	 Gs6hNRJrD89nzzWfh12NcadL+HR3j7Yuh/Pzspqtz+6yGvmvkHkRPMihgN3I6BI0xC
	 d4UiDejb0JxOAaxGWce80K6LLLgb6G8JyEAIAR9/VhSiuQ78fPbAYawtqE9jVAU8Xl
	 2GjdJIzcj6aUGrquTmKEnIakoCaqQGl7YDqBtiiB0+mK6uP3J+8J/i/aiZhnjYZ5mB
	 ZDA9N/l+HQ4QCJYt/+FXM8Ll03xd6IFK7rxARihqcyUrzLxR/4bTSRfotmhrhuW/xg
	 JsjdQOVFJwsBg==
Date: Tue, 22 Sep 2026 20:54:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Dash <mradityadash@gmail.com>
cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure
 status
In-Reply-To: <20260905061054.50663-1-mradityadash@gmail.com>
Message-ID: <p1o757n0-2rro-rnqp-56qo-56q08q5p29pp@xreary.bet>
References: <205C547F-BF6B-43D3-A8F0-829B657167EC@gmail.com> <20260905061054.50663-1-mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 5 Sep 2026, Aditya Dash wrote:

> Hi Derek,
> 
> The Stop reply changes based on calibration state. Its status appears to be
> the current failure_mask + 1. However, this mask does not always match the
> failure mask returned when calibration times out.
> 
> Here are some requests and responses from the experiments done:

[ ... snip ... ]

Derek,

do you have any final followup / verdict on this series, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

