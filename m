Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDB29CE9
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073586; cv=none; b=XrEAK64rj01S2IKcPtpDXwgzaLe0Zm+h2V4Sd010/EKBTOOL3qD1j0B0eYa9w64LVLmwNDSngxW15j9l7qBJF9Xs2lLHRtR/GSZjbY8qGZHQ99/hWwapVbKU+hoWG8X5W5SHoVQFjufjXtqjjMWLf8yK1eKBwZ0cg0Pglra6hec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073586; c=relaxed/simple;
	bh=4myePDbGOuuvFHg/eT5rjXj67qALj6mkkV+jO0qZ1ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7LvWKMseDq3D0cuzeLrxbJSKsDQQsW8Gj/q+iev3Tfu09SHlVlARS5JlDVv9wFR2JpE6UHTQzcMXPo+t3rjr1HQhdQUYjnfwPAF9ica1FjRPBQf/B/792lXBEk3usxei4zc3vnvJOAwTjbXffoVuAgdcBLxK8T6N3+56k9RCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMDGbFsy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMDGbFsy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso2390605e9.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789073583; x=1789678383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BCq0kuHs1j0acWRuibtXq3pLZmgmsIKMo87HdJz9dU8=;
        b=VMDGbFsy6VMjqvGLqOaUxZGHQrYUg1H344c6DejVFMBJXEOFz/QKXHkB+dyqwTjZsN
         nbWBolb8oFeMoQDB6AahiL/6jjYzWYPKNDxP0XZpOVFNLZaFm+Ft3eCHUbZPbTL9DCSR
         fyQlqujw+CHCHtol2vCocfzGTbgFfiMSXaBMdCKI5p0f2XZrGR07GzqAb5eF495qpGcg
         TuofGOFe2NSrZKOOEnV7EE1dIEI9Sga6FEUKPuFiV1Ip6XDlcJ7jvNLpJsLFQxvcQNoP
         uhD7CqeUGXZNL/lNq8Dx2hYxnDdn93EAnRomu4pS+Q+eOzw4u1gfZUbJTykLWnn34NU9
         nEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073583; x=1789678383;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCq0kuHs1j0acWRuibtXq3pLZmgmsIKMo87HdJz9dU8=;
        b=sUCiNUXjQ6xh40+Io0OO0IgpnjH0h2RK7yVFoh3WjgGrfORRbQD0sQXzPOvsWLHAhO
         4EiN6/SB+Vu0dfL/Aq5n4ErjXUwi7svPfFRb/Jo6WV4O8hdyTRU8/wZWo7QISd6752dk
         6SVMzuGkvjhd8Hy6UWWkbDt3Y67DM9A57jCYZzHFTZ5L6YlFxu8Xg8bqaAWazKmp61+q
         NZU7kW9G+0bv3UoHcc3Pzp4sYb8iU5ftfCXL6P5m53eO5tYUSQcVhA8yUp4fOQe4gRTu
         PdzD8063UcVmLH/jrYRzaZr0Uuw/6hV3vcqEuI+wSkkw2CoL2Z7T4CRTchJIM4gKRU6S
         v6WQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+O8pDp67VAHspxhPi11IrkGYAXe+qhuaVPkfypil6SBrhYpJFBFJaITjX1ScBeLs+0TVefbMhigx97w==@vger.kernel.org
X-Gm-Message-State: AFuF++khndlp+imESq/Zxx0BdhQqpL/e/FrIGuAiATmFSNA0tq4WHO+L
	tMG+h/0xToFvHc8o90ntkp9L2MfhOtivm5nTtH8YofA36XO677On5pAB
X-Gm-Gg: AYBFou05PZONTYgznvf1pZym23PtzkAnG1JdWo75VRJsI/fa4/mJo+8j4TaDfBHvfY4
	DqeeWD7pt4IziLETW7ZvmcHxss7kD0gky2+W77Cy5Btt05H3agoAMNCdForAbmnoZAZECxSfm2X
	I7IClb0JUubXE/dTrc66RCHF/lVJ1/8sXH85FZroomkVK8E1l/pdlccUqaPsT+8w+qyy7W4enYM
	Us80EdneaKEilOdfczMDcDXRNNIJkqfXHyW/N28Hi/v/4yzJh8SPycjHrQ9PRP5wO8rjigBZt87
	BQ1pjHNmhU6d0QvcStlSuu+1F9rWMyWOqxWxgMJ93d+qcwb9PRDr7DeFCLLTXokCILfsWxCch90
	Cq3kUHsSp61o686+d91UXB08AdKl55s1beJS29QD1ocUVi5uiaB5rbTwpJFLT4dk3UdPja5lCPs
	ryxeG7s7x0DYqxcdEG3jUpA64uNZBGe2C5hcr3EnActLJHY3oiT493a1WC83IeSx7/OLXB2in/x
	HqaWzJb
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:a3d5 with SMTP id 5b1f17b1804b1-49e619bfebcmr7617295e9.20.1789073583150;
        Thu, 10 Sep 2026 13:53:03 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c38e3asm106663825e9.9.2026.09.10.13.53.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Sep 2026 13:53:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 22:52:59 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Curtis Vogt <curtis.vogt@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pierre-Loup Griffais
 <pgriffais@valvesoftware.com>, open list <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:USB
 SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <20260910225259.66b480c6.michal.pecio@gmail.com>
In-Reply-To: <55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
	<20260910170254.833871-3-mario.limonciello@amd.com>
	<20260910220421.40356e51.michal.pecio@gmail.com>
	<55918a70-72c9-4f55-934b-81a692d4619b@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 15:43:18 -0500, Mario Limonciello wrote:
> >> +/*
> >> + * The headset's EDID service is lost when the host disables the DisplayPort
> >> + * PHY during system suspend, so it needs the reboot on the way out of
> >> + * suspend.  Doing it on the way in does not work: the headset dropping off
> >> + * USB is a remote-wakeup event from its hub and aborts the suspend.
> >> + */  
> > 
> > The internal hub which will be quirked by the next patch, or its parent?  
> 
> It has to be the internal hub if quirking it works, no?

I believe there are two separate problems here:

1. resetting the device at suspend causes instant wakeup
2. a few seconds later the system wakes up anyway

1. is solved by resetting on resume rather than suspend
2. is solved by the quirk

Questions:

Any chance that 2 also solves 1?
Would resetting on suspend be preferable, as the comment suggests?
Maybe it would, if the reset can race with DP seeing empty EDID? 

Regards,
Michal
