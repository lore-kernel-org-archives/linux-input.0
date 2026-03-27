Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0033E5587;
	Fri, 27 Mar 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609768; cv=none; b=dYkg50B/9dxUCgXVxx/7QP2RGwdpH+bwDBapfdwi2sDqMAnVlwmV6sX703NeSVYcWVm9OWWmhNOwtOSsfD94Bqm8v8ImzddPH8ypY6ivEklLt9qbQlnmpi0FCiDXjZdFc1u/bNq7+UjI8oAasxVg+DwyrkeBD+ekjKGrVyAm82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609768; c=relaxed/simple;
	bh=l/qlTWcyguqnaMbJAEv+ys430YD5VoSlszNs6P5g5K0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xxp9AEXLpr9+cSD2BooOIuXN6KGl5PMpyOaT1OPdGIwSwYb6+otHVamdLiAwQ6raQAMmrHhmknEQilLMLYudOhws9nFA0clGcHDHmK3XecNg3N/MpqDVUQzx2dHYljjEKeTh3giFV4r/EDiFzTfZHc2Si7VwlHUPyzo3wHnaRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHwo7ryL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHwo7ryL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D2C19423;
	Fri, 27 Mar 2026 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774609767;
	bh=l/qlTWcyguqnaMbJAEv+ys430YD5VoSlszNs6P5g5K0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kHwo7ryL6AVv5ezpL8zW0BYQvHWP6njq98059jPwYw7uPW+D7KvM6Pq1MgGcrnEac
	 bRJ37jtUIaQB1X1+iX5gElQGB1ZUF8ju96NnIq6CBvv2TqIwnlMY5/IyKaypJm9O1u
	 j653iZj9kYK1JcBCXUCzvTZ1B6eZQ+dubH3r/e1hevX+S1iv32KTZedv2G9Awt87YF
	 ZLyXxwlmcpfRMPpQHXZjzqX85wEssXuotQ/0TrCYkD5k0GNxlFECk8e+sM5mP599Cf
	 EdU6zsjRfvJV98goWPGRDXEgKcLddLYhAYqHbfbSGKok9cinmoXDnXQKzMpud97u8O
	 YIeQ489tQCNvg==
Date: Fri, 27 Mar 2026 12:09:25 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: factor out hid_parse_collections()
In-Reply-To: <20260326062539.750272-1-dmitry.torokhov@gmail.com>
Message-ID: <39p94pnp-q077-5r5r-o81r-ro878n2q4qr6@xreary.bet>
References: <20260326062539.750272-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Mar 2026, Dmitry Torokhov wrote:

> In preparation to making use of __free(...) cleanup facilities to
> clean up temporary buffers, factor out code parsing collections into
> a separate function to make the code simpler.

Both applied to hid.git#for-7.1/core-v2, thanks Dmitry!

-- 
Jiri Kosina
SUSE Labs

