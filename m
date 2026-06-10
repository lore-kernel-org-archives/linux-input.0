Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F232429831;
	Wed, 10 Jun 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106493; cv=none; b=bOYUiR6fpg2k3TyEHWW69U6xxV0K5PEfE03JyYx4h45WNxHiQXyU+YhRBnkatuL1hDO9FnN2YuLo5x/LXBFA6/ras5sCayJsa67e/5Y2500KtSLDeBuWnEnNTtyzqYes6iN4PdmORRDihlW+UeK1gFC/G/JUIaEfarOg4Z8k2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106493; c=relaxed/simple;
	bh=jKCKRwOhqRe97VcengYmkXq7V6H3ZKWueevdoipLlGE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WQNxPlDK8TJnoJcUYfQkzNXf8zx5E+2JR5idkyGnLsRM9dAYYsdtUIXbW1aMaXUxRfBGL8ZyU++TdS48OSveDIvlgN92utkER1Ex3ienDnWfygFQNnh3Enr1ArLXeWgYv/sFfqtkA+UcdLRwH79Y8sb7TZ8wY1wP7lvULbj/x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TscW3aMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TscW3aMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD741F00893;
	Wed, 10 Jun 2026 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106492;
	bh=l2g7PQQWA4frSavs5D+3E3Zap7b2DwMwRJRd0uta8j4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=TscW3aMgtcVuwRh3yMN1TcynUlqYwKrC86S3lllIANDEs1/UWcEXQxNs9FCpOppAk
	 4ii8hh8DY6T8f5vKf5sKa194gMPZYnmiosne7EI4bvgWVI44o7Lerhbs+FooJ2AXBi
	 UUM43/w+TIIm5jSedIggSh0dIsQQOXpHaKH1k8koqRsP8fJJjngW9v2HJRLDfmT/QC
	 Y8oSAD19zXP8bVysr399NyOlakSgSBcGIEiqH5L4CI9BTGnxEiywEKm0zlXiV9Ptrf
	 naiy08whq4sowtzLV5b/PoYkIGOJgpRRpTZEEaBM0900b++hTMO5mWFhPHxbIgEBPC
	 jv4AxTqIRFfjg==
Date: Wed, 10 Jun 2026 17:48:07 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Jinmo Yang <jinmo44.yang@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix NULL pointer dereference in
 wacom_intuos_pad()
In-Reply-To: <ahoH87pet5BUQwfD@google.com>
Message-ID: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
References: <20260523150101.611473-1-jinmo44.yang@gmail.com> <20260523150619.615565-1-jinmo44.yang@gmail.com> <ahoH87pet5BUQwfD@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 May 2026, Dmitry Torokhov wrote:

> I think there are many more places in the driver where it used 
> wacom->pad_input without verifying that it exists.

Absolutely correct observation, thanks :)

Jinmo, are you planning to submit extended version of the patch, please?

-- 
Jiri Kosina
SUSE Labs

