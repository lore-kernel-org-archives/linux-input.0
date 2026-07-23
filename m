Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF13446DE
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786087; cv=none; b=TAX/1TY21GInLwfhS2o4ILmGF+ZwTwsqU8wQeJpbCFVyKbS8ixJfNiTWCI/Kuk9XkjLVl28kScD95tK2jiDfDulWPmw9Kuc61Ot+c+7wZCEZrYQBW15vsqhgrCIVwnH03oiNx9mn4AfEKmmez+0zQZd4K1w+kDuuFBvbzrBvwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786087; c=relaxed/simple;
	bh=bP3fGW/gE+XehXF+JveIeQKcg8Agv4A8eZ7Go+TrIXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj4zQ4mt51XIi2rdJYApn7Os6e3jJw4TfBDteZf6ctYPb5/wDWl6MMRWst7kE3bUX9x+cY0eoz5sMCLIHfmXkGRRY2BAYDUonbsK5iL7OEB1RpxBhsGkWUHA60Jvrf4HKJhB2OjyRfUdUV7q6FqBXNMtRFUzpMuYTVTzJI1ly10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=LsQ4jdwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iISX0FEB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="LsQ4jdwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iISX0FEB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1338714000ED;
	Thu, 23 Jul 2026 01:54:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 01:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784786084; x=1784872484; bh=Il2l40WQLF
	o70PoX3qN3we4tK1muw8hSLhA2a5a1uPg=; b=LsQ4jdwcafk/q50XBj9M+nX0SP
	8sIo+urStZsnJZi4E50Tu1kOKika5Mgu8JIkn9sZrmAUjKu59jLDXklP/8rxY/a8
	o2fxZlxaXCt5/dF196bGve7YFHqx20TzbAKxmzxH9j6+KmyFOv6NwMWZEVtdm0zG
	75j4JmTeJEz8VW/iP09cHA7+ZHxoIKxT3RMYWzpYZF6fBO/Th3KQ3hg+mDcwd3kZ
	T1FpfzhKsDlOu1n6uY+zwadppnLI+m26R6TQfmR+DVBYNebK7zzolBdzGMXLcYQS
	EuxyVumXGvjkH/6UswJT/atFWysLI0Kwk+I+0j+4/cP5S3UOErOAXXmlmglA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784786084; x=1784872484; bh=Il2l40WQLFo70PoX3qN3we4tK1muw8hSLhA
	2a5a1uPg=; b=iISX0FEBwiFe36lP9cGry1ZLJVYt55OctClH+HRyV7uabotOTcW
	UaC2BrWTKxCQqAi62v24SDIq7WlzDla0kI1rPbBnR2fRGRIpZkEQNQ/+fSlZO3a3
	5o7cYLfawqJvsO8dl8nFpZShdcK+KjnwlbDeJvwIOYrGGPJemeuP90vmfiUiWOYu
	hb8yddN2oriBC0QvBsWszqImaO+ecpWyZoUFLybV8bjWxXOPAhgwcuRaXKRRTLSw
	91eJ8OzkqXxprP/ps3orsisKFrePU1z2mt+uZLKUk4TAbEK0Hy8GQUtouyUtsJwR
	5hu4r80EjpplusdlwbuaJYgCl1t2aGRQlsw==
X-ME-Sender: <xms:o6xhasl_LuRF0yJ5yM4FuubLfPpH4ZCGF5_eJJ_nqYH3dsYhS8hOAQ>
    <xme:o6xhavEGZT65QGFvQBMn9EdhMvGWQw2H_XjCm2qgNFtsU-pZc_wkzJ-fTLEWpV3gd
    ON0FWplDhNrss2yfIiJ-RPAtQVXm5WIbBCs5FKBfSsPP8930wM5RbU>
X-ME-Received: <xmr:o6xhakH-NqJDWQ8-1SSvckeSbrV4rOj_MI4586d65r8XOK9JjFjbN7mAUsZLI-zPlwnCujmOwHDL-oPJQ_kzJOCwUMThV_F9TQ>
X-ME-Proxy-Cause: dmFkZTFejO4UMzr+yZ5FLw7bzZkyDDcVKJcUPzoNbV9wSJDjCCHNY5mQyeVpMe4BqaSMc+
    aQ48lorOAUBD1OlkN3TxyjytaMCj7r+NWpbBjfhv7Jojo5ze8OpCIbwj1ZyEYsmq/09f5Q
    GllN6pCrUqjttlqzACVTZ7Ly3lq1b8za1tunWrJfqorAIuBD1lMfFwkPM8tLrCYvdSCjZ0
    +081OXiA+EmAJCNc/MxyKxopM31oJmeDDchX65UavoSMlrTcpYX5TQ1pdgknW2r1jByrCo
    bbq4hF7aw2MU9BsSIm5EzT7AGPrb7HrbDeRAIkFFlQH/qTntxFzrE26g7XJ1Xlh1YsaaYo
    /Ile8MpiMEMOn5jdm1Q1Ivd37HTH2rFG5ECISb0CVuoWhRAAovli9ouwBA4eTPLbUP8tSI
    WnljcURFPVT+l1l2NW/c8rbiAaYGq/AvR2/WTbNSQjcYpoFkgVaQrn0l0HlT55hZ981akf
    Bbb3PCLfo0iVUVyImuPjoRXiRVVrDa4wc7L5R107oTZbHzPAWxFzU+PgAvBl+Ib4rzX0Er
    TumbeaEkCM9VBN3aXatPMvq/hvdLomqv3c1T+MnxjMkrw0csLkm97uBq7bOOIlQ5cEEJsj
    LNalvT87Jz+QumJl/K/7hdrpanoNKNVnuo0sDJ2PrraRBQb6JQKitHU16cBg
X-ME-Proxy: <xmx:o6xhakMjJqbBK3cnAIN5X0BEH7PH3AMA7uS7VLyNBHtStEI29YWs0g>
    <xmx:o6xharG2QKhLLRx0QqOS610Xj8fm1Z9IbcQHkWbLFGu4_MGctTD61Q>
    <xmx:o6xhajPZrx6adpbzKgD8TTHSi01S2wKlwEMDMHb-6QnJEb_X6UMN-A>
    <xmx:o6xhak8NNuZvyk-V24TNLsaYOSFoQA8QYti_WRjB62hkDiSKbN4jZQ>
    <xmx:pKxhaqzx0UUxWpMG8vBFWuaRuP2ViSrFy2d95ZgUmUtaAnyZtZaAcI29>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 01:54:42 -0400 (EDT)
Date: Thu, 23 Jul 2026 15:54:37 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
Message-ID: <amGrm7qnjHvXPYeX@quokka>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
 <20260717050748.5DC071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717050748.5DC071F000E9@smtp.kernel.org>

On Fri, Jul 17, 2026 at 05:07:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch provides an incomplete mitigation for CVE-2026-50292. It sanitizes the `phys` property to prevent udev property injection via control characters (newlines), but completely fails to sanitize the `name` and `uniq` properties, which are also exported to uevents and controlled by userspace.
> --
> 
> --- Patch [1]: [PATCH] Input: uinput/uhid - disallow control characters in phys paths ---
> commit 1a76e90e7acc09a84a52efddc46e598419020a19
> Author: Peter Hutterer <peter.hutterer@who-t.net>
> 
> Input: uinput/uhid - disallow control characters in phys paths
> 
> This commit sanitizes the phys property in uinput and uhid devices to replace
> control characters with '?'. This prevents userspace from injecting malicious
> udev properties via newlines, which previously triggered CVE-2026-50292.
> 
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 37b60c3aaf66a..baf1fe8290f75 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -518,6 +518,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
> >  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> >  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
> >  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> > +	input_sanitize_phys(hid->phys);
> >  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
> >  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while this successfully mitigates
> CVE-2026-50292 for the phys property, does it still leave the name and uniq
> properties vulnerable?
> 
> In uhid_dev_create2(), the user-controlled ev->u.create2.name and
> ev->u.create2.uniq strings are copied directly without passing through a
> similar sanitization function.
> 
> Additionally, in drivers/input/misc/uinput.c:uinput_dev_setup(), the name
> property is also set without sanitization:
> 
>     dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
> 
> If a user with write access to /dev/uinput or /dev/uhid sets the name or uniq
> properties to strings containing newlines, wouldn't this still allow the
> injection of arbitrary udev environment variables when INPUT_ADD_HOTPLUG_VAR
> formats them for uevents?

name and uniq are controlled by the firmware and thus by the vendor and
control characters (or at least non-ascii) may be legitimately present.
There is no such thing as a sanitized name.

Cheers,
  Peter


