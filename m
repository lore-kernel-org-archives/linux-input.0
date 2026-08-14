Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE646C4B7;
	Fri, 14 Aug 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712968; cv=none; b=XnmTog/ls6wqbZp0M2+pC1qdY8Qow0jXcWuZwmclcF/BrGrjXHx6dZQB6fgn2k0drLq5dTN9BI5Vug9maR7s3K9gVaTk5HLEueXB66ezo7MhcI/9dYQZtNzkmUs0jlIOEX6+8Ma+3xk3EQEQQyCnyoaWdXA3fp6PbbpHMcbUr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712968; c=relaxed/simple;
	bh=U7hYHJsfp60K/758XLHWd+RwkR0Z/5k1LSmuVfu9b6E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KHP7x9I2hqWp0pJj6h6SsUnhPagjnPVqs7Acyibv+luYWlxORE30EnUobL5uWKI9lUb2XCB8df047r0+GoiqfnMKtG3fuM0j6BBqPzgSQDPUk6YdtVGRar6hWsGGqKLiz7KxW7UxtPcsuHx7ngFakr0UQnYCmjEbzdGRd9/QlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek6T8Imm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek6T8Imm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7D61F000E9;
	Fri, 14 Aug 2026 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712959;
	bh=smBZiWEsfoNxn6lIrGD6U5+0i5KjTfd0hMr2J5pAqo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Ek6T8Immmmm4xZZ840erDv3xmibiUHI+dGsZRWrmyzMVoPHQM7L8ZgCFM7X3uY10n
	 y35zsBpVi5FcqBWk/CKDaFONW7cd1ZWuy998NuhjC3J866R1eCWb+cvQajfVsOheJt
	 66TtUdbkx94/Bb4ngiXAKvPA8BbBMQU5/Mb/tpE0/OzWEhPjKlOMU4baH/F+jlGHvT
	 T7P9Ffxo28xRioyLusDBGW5akqxF+5Rm5+X9l6jTiGWCkIdX62t/WFSouSx7qnqefL
	 8TGz0lqHTtePFBlXg0OJPNntIhXood2kjJS57uk3Y6QdFtKKLcgCjUgfn+HBz5Tnqs
	 6LWoZkTQ6q40w==
Date: Fri, 14 Aug 2026 15:09:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Erik_H=E5kansson?= <erikhakan@gmail.com>
cc: bentiss@kernel.org, lains@riseup.net, hadess@hadess.net, k8ie@mcld.eu, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
In-Reply-To: <20260810205634.209099-1-erikhakan@gmail.com>
Message-ID: <9n1sr367-980n-310o-7108-2s9p5o165s2s@xreary.bet>
References: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com> <20260810205634.209099-1-erikhakan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Aug 2026, Erik H=C3=A5kansson wrote:

> This patch adds Logitech Bolt receiver support for Logitech HID++
> devices so Bolt-connected HID++ peripherals can expose battery
> information through the kernel power_supply path with the correct device
> model.
>=20
> Changes in v2:
> - Handle only the Bolt receiver/control interface in hid-logitech-dj and
>   leave the other Bolt receiver interfaces to generic HID handling.
> - Handle Bolt HID++ unpair notifications so child HID devices are removed
>   after unpairing.
>=20
> These fixes were based on issues reported by Kate=C5=99ina Medv=C4=9Bdov=
=C3=A1.
> Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a=
52a8d@mcld.eu/
>=20
> Changes in v3:
> - Handle HIDPP_ERROR_CONNECT_FAIL like other disconnected-device errors
>   when retrieving the protocol version to avoid protocol error messages
>   when a Bolt device powers off.
>=20
> Thanks to Kate=C5=99ina Medv=C4=9Bdov=C3=A1 for testing v1 on additional =
Bolt hardware
> and identifying that Bolt interfaces 0 and 1 must remain handled by the
> generic HID path, and that Bolt unpair notifications need explicit
> handling.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

