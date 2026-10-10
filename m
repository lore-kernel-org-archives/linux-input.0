Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115230CD95;
	Sat, 10 Oct 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791654591; cv=none; b=umVj7ohvumuXeYaRfe1zJ/jkS2AogGAQdMaon7ON8qfFrITgnEpzabyIerz8A0R/P2sWIynbg8p4me/jeFZFNjwQOv7xv5jGXHOiqf378iZAc3ANE5pYycHq/p5GRGG2Ne07qriweolvkp1oHEssRiXTSgleBkmMXd2QhtZxLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791654591; c=relaxed/simple;
	bh=IHH+op/r5engKa06OPkZW/eHYnRciF/v8FwzBsORMJo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VOWaZwqZUTVzvu3GfHqyHqsEyYaZtLBGwbNDmkcAMaTkz+3gdV1cDqOkLXUjpR4UHNwwfjAJ4ttuo+uAuKwT3ylahpXNz6Pn3ZEUTYH5FwdtTzqPvTAc6oE3trxunt4YY4va5kqcOVotB1RZX0IBbS8u4lTUI/H4WGf5ZCs9feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWk0F+RG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWk0F+RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B681F000FF;
	Sat, 10 Oct 2026 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791654589;
	bh=hLJtOAWU3pszol7luRMmRK6aXAxfQxlcZEGoWm7ISGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWk0F+RGdHYRMwOTG+Wcop//6ro7jfaT0vhLRveUcVvI0I0erMbA9x1vTxNs/P4pL
	 ELPYH190ATW4MplpcFET9HXYYdEsRUKbJQR4+EIO+uc2b55F80spFblKYpc3ZZJ/5/
	 KFZI2YxZT+lvph4ryyT3IHRx5xMGF4Iz7tzeUCj8MikJrNzrT7JLN8rxzLQSpJFcP6
	 A1tuTpcxP0hDHYDN6o0idBoX950q+lhjqY5ix3ETY3XbC4yNqszH8QO+DUeAyRYOT+
	 P4SBxKpiHxJmV9faRvrStIWE8keX1IZZx8G1OLEzp+5fhUoXNsNx5s4k5AKSplY8x1
	 ObXj3ZgjRYzcA==
Message-ID: <sashiko-outbox-166784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: core: Fix out-of-bounds left shift by 32 in
 s32ton()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: dmitry.torokhov@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <dfa0aa1c-e55e-4316-8307-f72a07383634@rowland.harvard.edu>
References: <dfa0aa1c-e55e-4316-8307-f72a07383634@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:49:48 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Syzbot reported an out-of-bounds shift (32-bit integer shifted left by
> 32) in the s32ton() routine in the HID core.  This routine converts a
> signed 32-bit integer to a signed n-bit integer, and it caps the value
> of n at 32.  But when n =3D=3D 32 there's no need to do anything; it can
> simply return the input value.  This will avoid calculating (1 << n)
> when n is 32, which was the cause of the invalid shift.
>=20
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/dfa0aa1c-e55e-4316-=
8307-f72a07383634@rowland.harvard.edu?part=3D1

