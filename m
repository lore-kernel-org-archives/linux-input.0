Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA9262A6;
	Sat, 21 Feb 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771678987; cv=none; b=C2T1MqOE5NDi2HXyWIdRRJJr9IwwZERHtJzY0LNBDLvbiNPyNnHzH1h1GOMRMxNfORlkQhRxVyS9mQzqTPdq7XPFcAsVMC7gBdUVm2qO++sLeKvf68/rybbhwwRqDTxXrxqC1oCFYJ814HPSMbJeqSU1P4IK2BTLgCBpze0VRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771678987; c=relaxed/simple;
	bh=CNBU/SRZmGYSGcBvezg1sTQ0bW92dxbzjGlwjt/xqgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6c435rNGA62BuHGqDG0cRWDSQMwLicamANLHcQBBjdlgzJijpfe/UplKJCxkbqYV0PwDTHhyLJ2BrV+deGCIHIf+i1Kauv84VCLMcOL565BcX9DBW/o4+uHw7N2bffjxes6uI4DAqT8tEGuc78IM7KhqyAI7+Lh8Vvr5zayGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXNXS+gj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXNXS+gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C740C4CEF7;
	Sat, 21 Feb 2026 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771678986;
	bh=CNBU/SRZmGYSGcBvezg1sTQ0bW92dxbzjGlwjt/xqgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXNXS+gjCzK4/KzAxXyCYUlI1zvIV6y6JaUKvF/yPkg+g936NGMY7IXCayAVgI/dW
	 i6N20LdIuqTXHemHNthQc+Yg0NftaL9kSDVvrpx0pMTAC9mNZii7OtnqgDmu+VnG5t
	 bg4jNoERAgQn4zrHFemHJtF2BEykt6SgLZCg7A3q4k6nnybxKIedChflbJCjkmq0PP
	 dOeACSzXud3ihr7mkchffwrHU8FzX00S1s25k4atEsaPcbFPCGAhkAhMa8bxhOAg6A
	 RcoPW4CY8O2A/0hN9MA6h7/JLWohUmzPFeKzrKWQ5yexboqJc7uoDD23jMO5sVoNfk
	 8NPD419pq6fUA==
Date: Sat, 21 Feb 2026 14:03:02 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <aZmsTQeeGf26FqvY@plouf>
References: <20260211164025.171242-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211164025.171242-1-lee@kernel.org>

On Feb 11 2026, Lee Jones wrote:
> Since the report ID is located within the data buffer, overwriting it
> would mean that any subsequent matching could cause a disparity in
> assumed allocated buffer size.  This in turn could trivially result in
> an out-of-bounds condition.  To mitigate this issue, let's refuse to
> overwrite a given report's data area if the ID in get_report_reply
> doesn't match.

That's a strong assumption and a breakage of the userspace FWIW. The CI
is now full of errors:
https://gitlab.freedesktop.org/bentiss/hid/-/commits/for-7.0/upstream-fixes

It is pretty common to allocate the buffer and not initialize it in
get_report operations.

It was a bad API choice to have rnum and data[0] for all HID requests
(internally, externally), but we should stick to it. The CI breakage in
itself is not a big issue TBH, but if it breaks here, it will probably
break existing users.

Cheers,
Benjamin

> 
> Cc: stable@vger.kernel.org
> Fixes: fcfcf0deb89ec ("HID: uhid: implement feature requests")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/uhid.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 21a70420151e..a0ee4e86656f 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -262,6 +262,10 @@ static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
>  	req = &uhid->report_buf.u.get_report_reply;
>  	if (req->err) {
>  		ret = -EIO;
> +	} else if (rnum != req->data[0]) {
> +		hid_err(hid, "Report ID mismatch - refusing to overwrite the data buffer\n");
> +		ret = -EINVAL;
> +		goto unlock;
>  	} else {
>  		ret = min3(count, (size_t)req->size, (size_t)UHID_DATA_MAX);
>  		memcpy(buf, req->data, ret);
> -- 
> 2.53.0.273.g2a3d683680-goog
> 
