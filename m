Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62343DCDAC
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140753; cv=none; b=jtYEc3ujD0xhZfMarIxiZpQ9MFozm05kB9Dho/Dcgd6FbxVOr7nGE++95eCTcbKuZDV7QdOHmtdvZ/+oH6gLqJYlBJ9BHjxz8bNLQj/5shigsoJXecKS7SBHWSOh/ij/rf84v1089RJTGOrutfu5eqV6gcYKAdgt29E9oSyXSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140753; c=relaxed/simple;
	bh=vKc85Eoo05QXTvu0HlkuzhWzqlqxTVybr4Kxq/CGxwk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M4yv21kffH1Dc4Xs/b+PxT1lsaNDgW7ZkVwAzHDaOMvf85TPc0cpVfDp2vjSPuEg89RbvbCIoi5Sv+8Y/d3fdjZUrk8zoq2kH+vunoAuNmKhSfX3aV9TMSLdQgYt1tjGUnNjx6HSLIVrksdOswshTCBUYQj9UGGZAvTX5uSkT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSbfFLsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSbfFLsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82EC1F00893;
	Fri, 11 Sep 2026 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140752;
	bh=GoidXx6qGeWCjUKqD59ZzX4g9tFi4O54N/Kedsvz4rg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NSbfFLslU6rtxmomsYi4bHO3l+ECHhb+YpLmHMweTnIbidLzSBRHv+xOsgHnTBFhd
	 0XteYzVVAZ/qlKs+5EgD5TrKls3cSJacu4Ixw4A62LpSNPHfjbsb1Ui5n5PvAYjwBT
	 MXtbtV9KX/OTqKiz7AC9X0uMU/S+AZm9KluKSWbUFzozmVds8uTQGBETvJEpW4mWrS
	 inHqatKoYwnY413AS6U/neQW+wR+qCrTSSEVdvZTpCgYBDbV7BgQ33aAimQ2icUZLp
	 YWB1VjuBXS/cYFREoAX1FuecReABxD8kCanh3st6YBAUHeCwOKG008SbcfhKXyKD/Y
	 Om4gNjGQLtkpA==
Date: Fri, 11 Sep 2026 17:32:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] HID: roccat: fix locking in roccat_connect() and
 roccat_disconnect()
In-Reply-To: <20260902094551.200587-1-dmantipov@yandex.ru>
Message-ID: <8r21q95r-p6os-5479-648n-9348n1s0r359@xreary.bet>
References: <20260902094551.200587-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Sep 2026, Dmitry Antipov wrote:

> Extend critical section in roccat_connect() to ensure that partially
> initialized 'struct roccat_device' is never exposed in 'devices' list,
> and do the same in roccat_disconnect() to avoid racy 'devices' access
> against roccat_release().
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I have applied this one.

I believe the issues that Sashiko pointed out with 2/2 are real, so please 
fix them and resubmit separately.

Thanks,

-- 
Jiri Kosina
SUSE Labs

