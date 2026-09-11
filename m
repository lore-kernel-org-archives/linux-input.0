Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816936A37E;
	Fri, 11 Sep 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140204; cv=none; b=WHKrbvqN+L9o+TkTlNMAzFbLUOAHq81nobhDijd5lTp+GO3qEEfffHPk6LVPbnnpTD7JsrGO1EaTUo2FUuMNankqfKLNCnIPTnYtk4jmi6G+JBWuiKJu9AhDBKb5DFS7KucT480Gf+9MlM+KP53bkSXRhPP6u/RLuGMyGR4rB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140204; c=relaxed/simple;
	bh=qIkeg8Gxgi/6Qs05Gd20gfbmqaxz+SlET+amQ8F9tqE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JPR1J2IFruobERGdRFOPsExIDVve9Kx+NxQvTdC2VReMA9rJ7SqpTSsnLDhD5/RZyWDfqSY3opXCkeXt8I3VUFNzS+3w2PkPC8pn5ZenN4GzJVb6W+nVNxS1HhdDhZoT1K25VScuG8q5tJK2qPdZ0DXDprBV23yA3lLG6TtzoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRu2nTOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRu2nTOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE8E1F000FF;
	Fri, 11 Sep 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140203;
	bh=U8X/37gfWpd0zAzbC2GGaZRncPuNs8MdaEXBGaqSDJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dRu2nTOvwg7qr4kOaBLmc7csBVv0addavxamho2IA91VzzAIze7ESV4L41D9mhD2m
	 3bXgn/iQxrzs/AbE0jvth+ufE4/7epIbTF1FmNR3+mvTCZVb33J/saa4rLrynAAJho
	 tWZNIYmbOIF0k6HUY9T9c7Voi2oX2QVKod9dx2BNW7tKjbOakPAjTNuourTBU1rRVY
	 KlUjJcNCHn2om0oojd4Rvf4qhu6jBL/MfaXvBVe8Yez3T6iuCV7KsDr3cwHFvDqKbL
	 dblA/JAWGHbidrJ0A8VbPjQtRJax+pS+HpRlWlhQpkljgw30/Rr7GJ8mx9mplHE6Yv
	 ukoDTZHYwevRw==
Date: Fri, 11 Sep 2026 17:23:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Erik_H=E5kansson?= <erikhakan@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 7 (2018)
In-Reply-To: <20260901203044.459972-1-erikhakan@gmail.com>
Message-ID: <o0673p17-q8on-5pn6-446r-9237q0n5r6s6@xreary.bet>
References: <20260901203044.459972-1-erikhakan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2026, Erik H=C3=A5kansson wrote:

> The headset reports connection and battery status on HID interface
> 5. When the device is disconnected, ignore incoming battery
> reports as they will incorrectly report battery level 0.
>=20
> Clamp overreported battery values to 100% and add USB ID 1038:12ad
> to the driver's device tables.
>=20
> Signed-off-by: Erik H=C3=A5kansson <erikhakan@gmail.com>
> ---
> Information available online suggests that at least two other Arctis 7
> revisions (2017 and 2019) exist, with different device IDs.  Without
> access to those devices, their protocol compatibility cannot be
> verified, so this patch only adds support for the 2018 model.

Thanks, applied.

--=20
Jiri Kosina
SUSE Labs

