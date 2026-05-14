Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59C1E32CF
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721742; cv=none; b=C87BGr6ROba4hvp+yLLBvsa0nwuQCeuZfJjlOQZOr24yzJ6SpDMVdAkEwiF9svIc3+DslHyMSthuFZ6nwG1IxL16bnh6fU4ENuMw61t/6YG2KrLmUB57NIjZcxHC1mgqFXdWUjnhH4onAG2NbAstmMOC4fB2HW9EO0nU1VuvOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721742; c=relaxed/simple;
	bh=0cUdKIFWlOwo3V2iOW5FnDuFjx0YXYUKmN/7/aU+WZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHaNZB6OtCpYYjY9LAk2pYtMvnagiDnUAOnEq9fqcar9px9SaDPoBQ+i1eqaSOY2c+WWMcFvx5ppPASGF978Uawd8CNIJe9/mrj0IgkXCD9BvSr/zEBFsYSc6o0blZzUcWOL5jfsSJqq+OIuNSYjpW6H2/EYwd8j1NNBU8MsSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSGCyLj1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSGCyLj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48887C19425;
	Thu, 14 May 2026 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721742;
	bh=0cUdKIFWlOwo3V2iOW5FnDuFjx0YXYUKmN/7/aU+WZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CSGCyLj17oGqqjc2jkWP2YgPMhZepM9CKw2RFPPK4AR1IEB+QYXyxZ0m0Ps00ke30
	 S7UcoFwINkhN6qD/Qmk/0gxWQ/yPl059EdS13HaLSdlgk6aWq2evMQ0tZxuBYjU75+
	 fXkQxOut/mZWDbYUNRHfKfJyABsWIwIeXVTpAYUO8LQU8/eBHo3nbEjqaKyhH4SnBV
	 RfgAKbi9pTMNMPuK070GmF17/e4/f6OHCudgDt7lVcaWTfSQ20fLBo+5YAn9JHoCdC
	 N1I6yqyPDA6ja/8tbqwE/YKEib0K7lq4b3rnH46ZzPz5QJ1ToW8NoLcN5+y/6exmrW
	 78yC5u49iuNeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - add LEN2058 to SMBus passlist for
 ThinkPad E490
Reply-To: sashiko-reviews@lists.linux.dev
To: contacto@bazaes.cl
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513045749.185969-1-contacto@bazaes.cl>
References: <20260513045749.185969-1-contacto@bazaes.cl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:22:21 +0000
Message-Id: <20260514012222.48887C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly states that without the passlist =
entry, psmouse ignores the `synaptics_intertouch` parameter and falls back =
to PS/2 mode even when explicitly requested.
--

commit 18925dd22ddb975fc9e545765ec54eb77a26f6f6
Author: Nicol=C3=A1s Bazaes <contacto@bazaes.cl>

Input: synaptics - add LEN2058 to SMBus passlist for ThinkPad E490

The Lenovo ThinkPad E490 has a Synaptics TM3471-020 touchpad that supports
SMBus/RMI4 mode but is not listed in smbus_pnp_ids[]. Adding LEN2058 to
the passlist enables RMI4 over SMBus, which provides better multitouch
support and matches the behavior of similar ThinkPad models.

> Without this entry, psmouse ignores the
> synaptics_intertouch parameter and falls back to PS/2 mode even when
> explicitly requested.

This isn't a bug, but is this description accurate?

Looking at synaptics_setup_intertouch(), the passlist is only checked if
synaptics_intertouch =3D=3D SYNAPTICS_INTERTOUCH_NOT_SET:

drivers/input/mouse/synaptics.c:synaptics_setup_intertouch() {
    ...
	if (synaptics_intertouch =3D=3D SYNAPTICS_INTERTOUCH_NOT_SET) {
		if (!psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids)) {
    ...
}

If a user explicitly requests SMBus mode by passing
psmouse.synaptics_intertouch=3D1, the condition is false, bypassing the
passlist check entirely and honoring the user's request.

Could the commit message be updated to clarify that the parameter is not
ignored when explicitly requested?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513045749.1859=
69-1-contacto@bazaes.cl?part=3D1
