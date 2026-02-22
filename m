Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACB214204;
	Sun, 22 Feb 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757193; cv=none; b=JTy9mVjfslqkKgU9a8g4uKAMfATjpjV4//s9cT9ihSdljYZGWXtfty2g22rvhd6gUr2pOAOi+TCUL+nQ598foSgaV7Iu6e16FnUdpoa+V/WbiILZDoo+y4tv17ReZHo3vto0yfGXr+3zcmt0x6W7ymZJDKSNXCkE0VZ3NFXDXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757193; c=relaxed/simple;
	bh=L0RYLimzP620+MWJzmTFq7NM2YBfwFSVKrGZdMmJ95I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APH53/PJuhnqiB1FjABDFMhTdThGcS38k5MWS6jL/2Cv7QMEmyMowgxLICwLLpP/FgealRiW6n3YpJ1mhLIKdP18z31jfyEQ2ozzfZn7bc/V4jOxib/YNaeM72mlyy+lf8W8VExSPW4OhVc7CWI8A3KCWimMY/KQgoLVkeZzLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJoTq13m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJoTq13m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F0AC116D0;
	Sun, 22 Feb 2026 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757193;
	bh=L0RYLimzP620+MWJzmTFq7NM2YBfwFSVKrGZdMmJ95I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJoTq13mmJUPCe3CSHlad+zbmce/MPRQIVDyD1W08JpS8bISlvJhUjuEgdhTMXlT9
	 WWPD0LydNLeCpItOOpMfNUuef/YFz71YpqZ4QFMsBjas17IQsqLLzYmUXuG5IRph1O
	 Av6ZCv6Q6/1vUYgTqJbDj6mmKkaWc+zU78bQ5IQiwDkN3xRK6LyHlnmiz+2ZGGay1O
	 j5/uHLpFK9fSv0pWSlUoYOa7n/a3nIyY7h5DvhFa9a9q8OtuGJbHha8slcQtwbjWTA
	 LRojGl3jSioaB/eZ48RTJQ+cIELicWp9f+ODTkCs/TIU7rUVn4SohJ0r4EUnG/gCZJ
	 OR4rrHPbX1xpA==
Date: Sun, 22 Feb 2026 18:46:29 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Input: export input_default_setkeycode
Message-ID: <aZrehVVBxlUC9dX4@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-1-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:09PM -0800, Dmitry Torokhov wrote:
> From: Fabio Baltieri <fabiobaltieri@chromium.org>
> 
> Export input_default_setkeycode so that a driver can set a custom
> setkeycode handler to take some driver specific action but still call
> the default handler at some point.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> Link: https://patch.msgid.link/20260211173421.1206478-2-fabiobaltieri@chromium.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
