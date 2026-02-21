Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB2194C98;
	Sat, 21 Feb 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667263; cv=none; b=RIyjwG3eGcObU0ltCE7jjitWg6srPI6G8Gu5Lu/o5f7u7CnO6GAkCvCaNugYNV5pjPLtlH3kZdME+CqTizrjKOcHPKwLQ1tKkoV9Tz5FGShH7V2Tjhkv2w0Y1Uk/wTata1svpcAa7uBC+kNLIqLO/iUWbfmTjqELMZ5VDlEee2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667263; c=relaxed/simple;
	bh=3hsMxra5nZolxOP0C/T82rughyHQAwrToSBFKFqoMF8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=frXw1tYzBr4dl352JZdZug5m6TwTJLpd6yvT93HIXuzbWA/bbSXhWEAWSz+zaK0gw6IOG3KnOaxtaB0inuZTM9/xbsqf+sMeO7uUmXa6ta3eULNxpLbWlCJgZwcCyWgLe221NqT57oYuPIsnHaeBTfLpvikQh2ghV5OOmQtDybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgyZKrSW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgyZKrSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25392C4CEF7;
	Sat, 21 Feb 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667262;
	bh=3hsMxra5nZolxOP0C/T82rughyHQAwrToSBFKFqoMF8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RgyZKrSWMNrNeuoefg1d39IRFDRXkoa9upS8eMOyPI13whZS947WmrqK/BnP0KJfu
	 iS8kF6ZINq1Ax/OkOjEXvmUVtCQ5cVYeHVLKEOvH3KpC7JwS+M8tMoxRBx42z92aqd
	 DkHd5ev+5h+BOd//JkeDgdI8buDFjoLvJKkmnPfAA9Fo99Q9lISI1akzIBmKoP5DnH
	 ZjxQS2fIHlLVF9GAp3e+QSe/joJo8dir8DEKr7iX6DfVSXfiwuHfiY2eJzSagINFRs
	 5qskbE9f+3myJIbJ39XksWUcOZ407B4hzGkZ3PJk3PfA7inQuKV7QGW7lNgFxdncpV
	 HPAmmvtYOll0A==
Date: Sat, 21 Feb 2026 10:47:39 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>
cc: bentiss@kernel.org, oleg@makarenk.ooo, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: pidff: Fix condition effect bit clearing
In-Reply-To: <20260204214455.68629-1-tomasz.pakula.oficjalny@gmail.com>
Message-ID: <n339r708-n13n-6rrq-s6os-98sp87qps96n@xreary.bet>
References: <20260204214455.68629-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Feb 2026, Tomasz Paku=B3a wrote:

> As reported by MPDarkGuy on discord, NULL pointer dereferences were
> happening because not all the conditional effects bits were cleared.
>=20
> Properly clear all conditional effect bits from ffbit
>=20
> Fixes: 7f3d7bc0df4b ("HID: pidff: Better quirk assigment when searching f=
or fields")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Tomasz Paku=B3a <tomasz.pakula.oficjalny@gmail.com>

Applied to hid.git#for-7.0/upstream-fixes, sorry for the delay.

Thanks,

--=20
Jiri Kosina
SUSE Labs

