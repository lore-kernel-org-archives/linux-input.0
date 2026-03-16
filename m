Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B3284880;
	Mon, 16 Mar 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674977; cv=none; b=MgBBJFkU1c8p6mrSnPQo3uURjiqSiKm+h+pyaLUAZxxJdUJ4yqXMWuS5Rom6nvjw70T457tQI/A3krS8H5rw8klVtjawA3YEZdWZBaTZsoPJi/6zZoWdFz8DFDehHAL0IArf3Juwtv1dVfm/9a+cTCjkAHTmWcpbEYqYkjWjkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674977; c=relaxed/simple;
	bh=+5Iuzca1NbhkkCmvRMEBRwe1mGTo4lva1NtNxeuwZgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSVhK/MTXBbSw1Giz+90urtOL3d38N2htevcLq56tRfVQuKcv7WdEfLEbaFXRHyj4N//xQmGM8zR0AU7m4q1yNI3pLAdbur++J5jnAR+6G4IrtB8EOYWWuw/d8vHIb0QD/wmJXfWmxF0xJB+IxMWkKM8v4nS3qRfu6M2pmouvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHyaH8js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHyaH8js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D81C2BCF4;
	Mon, 16 Mar 2026 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674976;
	bh=+5Iuzca1NbhkkCmvRMEBRwe1mGTo4lva1NtNxeuwZgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHyaH8jsAy9RymDYxQ78XVGLuuQqAsDBEpOk2TZO4rW3/03AdMyEzoH+aQSKfYM0l
	 65+3XLumG491R8HcWfkCSeyA/CXdDK5G2bhcj6LxcBD+fJi/RQUK0QzMCD0OMLxm1E
	 D/i4/m6KDD/HmeERO+p510PL6GIBf3V+FLblXhu6+2zyIdRJrLm9q6CjBm0lbEJuRW
	 YK1V3ZM4tHsVjDrKZUPyg0n/4pKcuuRkLmTIYlLzB/ka1kjU40fJtvHp3YQynLEp7Z
	 yXQisAsHZmJRy2nu5ytN2D4JxNMOqTl7RuD9Hl6ZyjDKW9rOG9lTVUy/ZSpXKXJjGh
	 jS2PwHz3F3Ojw==
Date: Mon, 16 Mar 2026 16:28:50 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 2/2] HID: core: Check to ensure report responses match
 the request
Message-ID: <abghH9Cf5FvUpfE0@beelink>
References: <20260309145942.1496072-1-lee@kernel.org>
 <20260309145942.1496072-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309145942.1496072-2-lee@kernel.org>

On Mar 09 2026, Lee Jones wrote:
> It is possible for a malicious (or clumsy) device to respond to a
> specific report's feature request using a completely different report
> ID.  This can cause confusion in the HID core resulting in nasty
> side-effects such as OOB writes.
> 
> Add a check to ensure that the report ID in the response, matches the
> one that was requested.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v2 -> v3: Cover more bases by moving the check up a layer from MT to HID Core
> 
> RFC query: Is this always okay?
>            Should the report number always match the request?
> 	   Are there legitimate times where the two would differ?

Technically, there is no reasons for a HID_SET_REPORT request to change
the incoming buffer. So that test might break it.

I prefered fixing the calling sites (hid-multitouch and others), because
here we are making decisions on the device behaviour which is not ours
to make. More specifically, such a test will prevent us to fix a bogus
device by plainly rejecting the call after the facts.

Cheers,
Benjamin

> 
>  drivers/hid/hid-core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index da9231ca42bc..da4078554331 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2490,8 +2490,17 @@ int __hid_hw_raw_request(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
>  
> -	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
> -					    rtype, reqtype);
> +	ret = hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
> +					   rtype, reqtype);
> +	if (ret)
> +		return ret;
> +
> +	if (reportnum != buf[0]) {
> +		hid_err(hdev, "Returned feature report did not match the request\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
> 
