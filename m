Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC5214204;
	Sun, 22 Feb 2026 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757285; cv=none; b=uKlXGjz1Lbj6AOx4Vr+vNSiklPHbzq+SooWMDr3ohVzHSDU+hWi125/LtiLEhLbdUvqlodz+ztsVgXARlsgHB3dcn92NSIqrt2ucp/+3Zd7S7tQwNjRVw/1X0cHSS1ADfLRXe9JhEFlZ0c9zAariDl26WfZd5/AXpkukTvYIs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757285; c=relaxed/simple;
	bh=8Tr8/t2vyOfJZDOx/VQiqugcG/nmYtR3QeGVhq4tJKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFrJj2wOhXv7d1tJ5GZZIAgeXixSWuMgjc5W4xqB/mPx0KbEG6aF4iVwv/JiBR5jZ4r/VAyK3tqg3bWpKu2Ek5CSUqocqAkHn3g+tmwTqC5d7ZJSWhwsBgGuWh3qmuKOVaNENfnGB/fvTfo0+Rf9l1LmeYkTllGk30gg87eN+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2zM9FVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2zM9FVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB40C116D0;
	Sun, 22 Feb 2026 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757285;
	bh=8Tr8/t2vyOfJZDOx/VQiqugcG/nmYtR3QeGVhq4tJKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2zM9FVH2XBFTdJoOWBUhS+/Z7yZQnq6cWUe6B97yxm7CTpG3d3KyfHhmgk7Ekvyc
	 N8cic4/DH04JfSakH30Mmqc+BRa+6U6jhHS++rZRUb87kYfQYDb49IA4C6hvrT8EJY
	 kxSiETfmdNXIiKAesbISLMkzjRHW7k6i/Vr18ei1xh8rb6SXIaN1AQcjORxV7ldpIq
	 RTQ4dpYG/xj45tOXpaOmIuWvbfhE+XA6hcY17xCUL6ExMYgKEhKwBZcqnjktgL3aXk
	 IvKSizEg4DNsKuhXWCJFEo8f2yfpZF5xxkNf+82DNRxslAOWGdFjKbSrWho+w33jNb
	 mIW27btjXgAcQ==
Date: Sun, 22 Feb 2026 18:48:01 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: cros_ec_keyb - do not allocate keyboard state
 separately
Message-ID: <aZre4dkIYkVUJAFb@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-6-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-6-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:14PM -0800, Dmitry Torokhov wrote:
> Now that we know the upper bound for the number of columnts, and know
> that it is pretty small, there is no point in allocating it separately.
> We are wasting more memory tracking the allocations.
> 
> Embed valid_keys and old_kb_state directly into cros_ec_keyb structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
