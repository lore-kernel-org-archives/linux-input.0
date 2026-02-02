Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577E369964;
	Mon,  2 Feb 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039609; cv=none; b=sVIifQJWifSDx5LQAbfZV3hVG4800DN7MLxaIoFK1sRvO5tUfo/4vXz/82t5xajalk6gtXfkucJVlBmOVxrqkZ8BcqcoJBcJXw0J32AoZXj+6bj1ttApyNJjEYkpe3/oz6aPUYG0KM4mr9Q7LwsPHVBxlDdqN5q3TFE8fa0vqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039609; c=relaxed/simple;
	bh=+84NQ75F23f0cNk1I0gXeXXlilJEvU5Rlr31L/EMT/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZRcsfGzVdtgV0V6oE4W5azzMlCg3ZQbsr6fOn/JVhgAZd6OcXfFwcyiCdf54637Y9VUK+o612u3Xx4pxPCRynNsz6tc0Pilxp3ICPjutliBJACeIneZgOsb107hkLjfKAmVkKTrZDhJ7/OgXnk1VarRLZG73vM6gLLx7d7j5gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3akWNyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3akWNyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECBCC116C6;
	Mon,  2 Feb 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770039608;
	bh=+84NQ75F23f0cNk1I0gXeXXlilJEvU5Rlr31L/EMT/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=a3akWNybcPEuOEuJK3AHKg/hOXj1uSxkk7fV1ckmOuGCFB1G951rfO81kltik/OCB
	 51OKALtfjydjQAoCqZkT7wUA1LWh+LkX5Ssfily9CFC+/cr5ST4hKfOjjSRkUFvJ0C
	 fZlIZROAm+y2njtgwayzhbVN3yOUi07yJMzmvT4dwXQ37YSa8Mdh+mgojzMA/qSV+s
	 cxzUEc4H/5PZVJywTvuEOVTCDXhe2CkV1UkJtn1EuOShB1UebtXSAZvZ8tpIod5XYr
	 l3maxf8cxPPrT8wdqfRYColDgNr555WdYPRciQcmJdkZOTWBZ16hskmvW272SKFpmr
	 bSHf/F3xHLyZg==
Date: Mon, 2 Feb 2026 14:40:06 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Rui Zhang <rui1.zhang@intel.com>
Subject: Re: [PATCH] HID: Intel-thc-hid: Intel-thc: Fix wrong register fields
 updating
In-Reply-To: <20260202030144.967964-1-even.xu@intel.com>
Message-ID: <2rs0n4rs-8821-69qo-7485-50nr37on2ns4@xreary.bet>
References: <20260202030144.967964-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Feb 2026, Even Xu wrote:

> Clear the target bit fields in register before setting new values. This
> ensures proper field updates by removing any existing bits that might
> interfere with the new configuration.
> 
> Fixes: 22da60f0304b ("HID: Intel-thc-hid: Intel-thc: Introduce interrupt delay control")
> Fixes: 45e92a093099 ("HID: Intel-thc-hid: Intel-thc: Introduce max input size control")
> Signed-off-by: Even Xu <even.xu@intel.com>
> Tested-by: Rui Zhang <rui1.zhang@intel.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

