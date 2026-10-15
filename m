Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC443F0ABB;
	Thu, 15 Oct 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082594; cv=none; b=VVr3pTZDdToJvBz3vg4KbiworLJwZJ5lzzBygLiQr470XxL8dCw+2ONoWvgDgefKx1ruXuDkgkTdNtJTg8Uaf2GSfXgtXmUQ8YKytrvVYS8XY2EGgXjsm4LXuz5NJXd0kXtMjd4ZXfzMywyoMh2J/OEQPNibnnVxK6vRjYGJetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082594; c=relaxed/simple;
	bh=l2cEuXfTnxiaYfKDp+XfAtH6jcbuRZPOg3/Mf7aPf4w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mn12zZtMA/iP0j12r0/Md4P1NQwZ6ULvLDzJxasztHaa/IDbw2rCmODRBvpqzTKpWZkCr0H/8CrMGn3vzKbULdhznBsdPM9BO7YiKAi9b2zvni5Ps7AAYuP/hzoRQ1gd1d2SC/Wo+efLpQA6fbNlDTC7FSFhgqs9rZ8tZ2uTJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsCTN//2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsCTN//2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5261F000C5;
	Thu, 15 Oct 2026 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082582;
	bh=FH6YELDD9h+XB9cyCtzw+r3OU1m5mpCtFQVkOzHFGqw=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=gsCTN//2g2Szy0B2i4URahDiGC7Gr56IEL5SnWJeIdo4KE4vzK/vPr3N/w4Juvb7Y
	 Qojflu+OQ6P5uQ6aPYBsGeBKQoalhxK908rocvIDPlAkPZR/DQyfxzNkUkgoZDpW2T
	 jBfsMJSvmVXILYPwpLiZYDzXk2Hlh4TNpRs/nwsIPrL/I/poskbYQp4SpqEpNDfrSb
	 2MM/BVsYNbJ3j6X/n3BLiCPYdb4oP9s9dZjKrAS9RXNXXtXNmH8zYmsgsCX5rjFsuc
	 TwfYGBylpnC50wn/KBLOpeD0/Qaa6cQ119LODezMB9IEzd0TjWIelHneVX0zjbjajc
	 YhDdYtFFyejvg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Stefan Achatz <erazor_de@users.sourceforge.net>, 
 Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jiale Yao <yaojiale02@163.com>
In-Reply-To: <20260924142918.1177952-1-yaojiale02@163.com>
References: <20260924142918.1177952-1-yaojiale02@163.com>
Subject: Re: [PATCH 0/7] HID: roccat: validate raw report lengths
Message-Id: <179208258109.807325.9060103782657872973.b4-ty@b4>
Date: Thu, 15 Oct 2026 18:43:01 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 24 Sep 2026 22:29:10 +0800, Jiale Yao wrote:
> Roccat raw event callbacks receive the report before HID core validates
> and pads its length.  Seven callbacks inspect fixed-format reports without
> first ensuring that the complete report was received.
> 
> Add per-driver length checks before parsing or forwarding these reports.
> The first five patches protect helpers which read fixed fields, while the
> konepure and ryos patches additionally prevent a fixed-size copy of a
> truncated report into the Roccat character-device event stream.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/roccat), thanks!

[1/7] HID: roccat: isku: reject short button reports
      https://git.kernel.org/hid/hid/c/93e5f7f6189a
[2/7] HID: roccat: koneplus: reject short button reports
      https://git.kernel.org/hid/hid/c/d879e17a8b4c
[3/7] HID: roccat: konepure: reject short button reports
      https://git.kernel.org/hid/hid/c/1590b7c9bea0
[4/7] HID: roccat: kovaplus: reject short button reports
      https://git.kernel.org/hid/hid/c/e95917a606f4
[5/7] HID: roccat: pyra: reject short button reports
      https://git.kernel.org/hid/hid/c/493268f459bb
[6/7] HID: roccat: ryos: reject short special reports
      https://git.kernel.org/hid/hid/c/02f3607d0beb
[7/7] HID: roccat: savu: reject short special reports
      https://git.kernel.org/hid/hid/c/76c51fdc825a

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

