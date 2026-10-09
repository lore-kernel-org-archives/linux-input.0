Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30470421239;
	Fri,  9 Oct 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526213; cv=none; b=Hhbsk+vFv2c12wZNUlti0YEekUqV4EwfNOTDbf5gKVl145LUhZQbrgxu9ObApfnRxPI2/uZtCupv8Kuoiu8aORBvjiT1hhv7Zko81AxmuEHRheazHq4D3v+UFSpr7A2d/UB4KQXc9Vwk3VKQcpwYuXoEqJYFW28sZyVQjPhN3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526213; c=relaxed/simple;
	bh=qPZUI5AERDbsMwVw1xRusZQKPYUc/YAJLop+eInFbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8UAi1Ero4aF8e1e4Dsi1Q2Bisr55H++ZT9wG/mDEZPiM8rvCqTP+eqfqul3AovdG2XOuHM4PcoQ9pvx3WL9IbMlzcelrHolA6IxE0fd2W+RV4IWlcto+19d/OYFZDuL4AOLuK277oMVK10TDZvMGZefUfa//iTI5HKlySsO61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eisZVZI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eisZVZI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B991F000FF;
	Fri,  9 Oct 2026 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526211;
	bh=BC3rl7y513ctwp4yg4sDTNp9NBnOhsJNy1rfcB5SVoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eisZVZI7kFhRfMyPIll4w1FF+8Wd4ddNwiwigIb84oSBeNDerOiDFMkEnUjSOVN+e
	 UHJCU+ScV6Y4vMxAKsLOD+X9lU2KZs5615fHGaikAEuWDhWK/UVgafdcsucmYihf3H
	 wFU/LHKV3CrjOsnw8xzg25kBAroEBUvWlgYzYw6XNWOtZ8fbz+YK5zyv5ufs0J0G52
	 9OO+K6DEaIopXI4+CdLkFbCAclKRk4qXhGPsFmE3KkSwQzcmMPPhMRZlhoHFIfZqoM
	 R+JCjGHdzt+GtUd0vHBSjUFmDKIIIcysYr6dDAn5W3QDnW357jWT9He75BPAWd2yU6
	 /bEKuh7FRQZBA==
Date: Fri, 9 Oct 2026 08:10:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>
Subject: Re: [PATCH] Input: ati_remote2 - fix type confusion in device
 attribute handlers
Message-ID: <20261009-shapeless-silky-deer-acd3bc@quoll>
References: <20261009040302.3087205-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009040302.3087205-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 12:03:02 +0800, Haotian Zhang wrote:
> The channel_mask and mode_mask attributes are instantiated by the driver
> core through struct usb_driver::dev_groups, so they are attached to the
> usb_interface bound to the driver, not to the usb_device.  The four
> show/store handlers still call to_usb_device(dev), which applies the
> struct usb_device container_of() to a struct usb_interface::dev and thus
> produces a bogus usb_device pointer.  usb_ifnum_to_if() reads that
> pointer as udev->actconfig and dereferences it, and its result is passed
> to usb_get_intfdata() without any NULL check, so reading or writing the
> world-readable attributes can crash the kernel.
> 
> Use to_usb_interface(dev) so the handlers recover the interface that the
> attributes belong to, matching the other drivers converted to dev_groups.
> 
> Fixes: b20d6bf8014b ("Input: ati-remote2 - use driver core to instantiate device attributes")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/input/misc/ati_remote2.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




