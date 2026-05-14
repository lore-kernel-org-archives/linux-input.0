Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E453F4127
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744956; cv=none; b=TSiuqUSOIxA0rJlf4JR83zvB3pvSOjqzLD6H7TwPA++XxV045eNYiQ0LRs5+GNd9hQ2rC6uHEbgljXotx7kcwSZcoQcUrMa11T71l3B0iJW4Xe44RCxntoMnz9qKMAKH0jqdOwG/DuHeTMaEc3x0SnWqO1iRBFfzNZv5NSyI5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744956; c=relaxed/simple;
	bh=+dJ0j4XCAL3WKYM5WptCyt6xsBO0uZIXD6hkD+dCkHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TJt2toN1iuNOgSySiCaYX2/ziwhd1xKm0YKSYLz43xsrF6BA18v+Og7M0hv5kJPRPZahFkkQcU8xQRDPAedhTsr4fh2DjlEIew2oZkPrV5RXLdhbqTjM8HsQHeP5Q5uTjwm0ZZnpJ8lRlht9MuaaIJ5+fdLsbLKpMHUbKrbXIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoTbtaej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoTbtaej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B955EC2BCB7;
	Thu, 14 May 2026 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744955;
	bh=+dJ0j4XCAL3WKYM5WptCyt6xsBO0uZIXD6hkD+dCkHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XoTbtaej9oBUj2A3u++AFwPfeeJt8AoDQYh8NeOR4kRzox2XNDcIA0tfPgbKdWazb
	 ZgShadQ76iVDdnCSR4mqXPC2BenIRSTKvw+jp1VzBbi0rQcgAefsUmE9yo2VQQzPLl
	 LQmlsv2WhwMcvQYy7DMeFAXD/gdP5cSwo0AhgEIPsZQM87Od0r7OjwuEG6Y3eQ7ITg
	 w4SoA5vwCe+fg1KHz6PLzE26n7Nkj2poP7t+YwaWzetmeABV5rFGEK1/i9XRotM3Ap
	 shr9iCNylB3IxH8fKPy6PsRJCFc0GoAiCgOF1XC6LcpfFQ/6SlrYABuLb7hZ1vP52Y
	 y7uy8OGx/Mv/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] hid-asus: Add missing Zenbook Duo hotkeys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513163248.16483-3-p.pisati@gmail.com>
References: <20260513163248.16483-3-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 07:49:15 +0000
Message-Id: <20260514074915.B955EC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'MyASUS' key (0x86) mapping is inconsistent with the existin=
g Asus WMI driver.
--

commit ee67c289461b2da1755d4534b96e25db841e41d8
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>

hid-asus: Add missing Zenbook Duo hotkeys

This commit adds input mappings for several missing Zenbook Duo hotkeys,
including the MyASUS key, screen swap, and ROG Ally buttons, handling
them through the hid-asus driver.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ce246efba74d3..cba638b19465f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1046,6 +1046,7 @@ static int asus_input_mapping(struct hid_device *hd=
ev,
>  		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
>  		case 0x7c: asus_map_key_clear(KEY_MICMUTE);		break;
>  		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
> +		case 0x86: asus_map_key_clear(KEY_CONTROLPANEL);	break; /* MyASUS */

Is it intentional to map the MyASUS key to KEY_CONTROLPANEL here?

The existing asus-nb-wmi driver maps the identical 0x86 hardware event
for the MyASUS key to KEY_PROG1.

Mapping this to KEY_CONTROLPANEL in the HID driver might introduce an
inconsistent contract for user-space, where the exact same physical
button on Asus devices yields different keycodes depending on whether the
event is routed through the HID or WMI subsystem.

Could this cause issues for desktop environments attempting to bind
device-specific hotkeys consistently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D2
