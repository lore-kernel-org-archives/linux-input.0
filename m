Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA80407CF7
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549527; cv=none; b=XUTvfLVikdqD24PdlTLOC8s7nOekpZ2cNfTvJ7Z1J/bC5w7bJMmvDmX6uErzLEzxax0MO4a0H4Qxi9XGvuCR5LjlpRDwvYR/Ncda1aUbeIBNGDAHqqJ0soLt7tRl742umUvokAD+75eEZRX/Wf6Cae2rlElJowvNPoQIWbMmKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549527; c=relaxed/simple;
	bh=GyGiFVfZBlfFopyD8Q2zv341fr6VUUMw2fpjVVTLYLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5nuSoK40mgjXu5gdVy+Foi0ht7MRXLCZafA9X/dJBgdi2E6WiPitc9kxfou36OKte5NxfRnKdSG3ZrER/UnL8x9DE7B7OhEIIZTs4K6geq629z4FwD+UaIE8IIYOd7H6gZyA0ZD/iJ/fJfFNtBvNMsQGyfgeEzsxztVLhByY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg6a4aBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg6a4aBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DEF1F000E9;
	Mon, 20 Jul 2026 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549526;
	bh=0H4UAwsi6TKz046fqwOLJ9H8Jbna4tYo39Sm8byMdjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xg6a4aBE4TYZySAXiWUhUGj+a70qQgvrw9SIKcNTdU72Ei9a1zRavbOekf1CeAaVW
	 nrwl8Lh886YyIJw8UkJeYjH5fMjCkmgU0okyI6kxCnC78FIJiWKasEuICGmG0wEEXy
	 acf2Y9+tBW5Cf+B5gxWjRDH/nhvT6SZwywyctRP0GEX9tZrecOzm0n+LSI5f6FqFG5
	 acNl3LnjG1RDMAa2RBmS3UDDMuBKqsSikFmWVnMpTAl0G40nW7XOvzti1um8U/hVGw
	 bbot2IAV6i7iVaC0AhCv6emNcSDRgIGN+yByS9ods04cb5vXLX+EbYJH1O3MTUKAP2
	 bwrmoq1ZNqDVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: iforce - validate input packet lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720115018.75045-1-pengpeng@iscas.ac.cn>
References: <20260720115018.75045-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:12:06 +0000
Message-Id: <20260720121206.52DEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on core_effect->flags due to non-atomic __test_and_set_b=
it.
- [Medium] Missing input_sync() after reporting force-feedback status (EV_F=
F_STATUS) events.
--

--- Patch [1]: [PATCH v2] Input: iforce - validate input packet lengths ---
commit 32891702a73654a7ce9748db1e4baa8f0cbb9362
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: iforce - validate input packet lengths

iforce_process_packet() reads fixed fields from joystick, wheel and status
packets without first checking their lengths. In particular, the shared
hats-and-buttons helper unconditionally reads data[6]. The status tail is
a sequence of 16-bit effect addresses, but an incomplete final address is
also consumed. A successful zero-length USB URB additionally reads the
packet ID before the common parser is called.

Reject the zero-length USB transfer, require the seven-byte joystick and
wheel prefixes and the two-byte status prefix, and consume only complete
status-tail addresses.

> diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/inp=
ut/joystick/iforce/iforce-packets.c
> index effa76bfd8f9a..e8a34d68a51f2 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
[ ... ]
> @@ -200,7 +209,7 @@ void iforce_process_packet(struct iforce *iforce,
>  			}
>  		}

[Severity: Medium]
This is a pre-existing issue, but is there a missing input_sync() after the
input_report_ff_status() calls just above this code?

The input subsystem guidelines require that every logical group of events m=
ust
be followed by input_sync(), or the events stay in the buffer. While there =
is
an input_sync() earlier for BTN_DEAD, the EV_FF_STATUS events emitted here
might remain buffered and not reach userspace until a subsequent event
triggers another sync.

> -		for (j =3D 3; j < len; j +=3D 2)
> +		for (j =3D 3; j + sizeof(u16) <=3D len; j +=3D 2)
>  			mark_core_as_ready(iforce, get_unaligned_le16(data + j));

[Severity: High]
This isn't a bug introduced by this patch, but does the call to
mark_core_as_ready() here expose a data race with iforce_upload_effect()?

The interrupt completion handler calls mark_core_as_ready(), which uses ato=
mic
bit operations on core_effects[i].flags:

drivers/input/joystick/iforce/iforce-packets.c:mark_core_as_ready() {
    ...
    clear_bit(FF_CORE_UPDATE, iforce->core_effects[i].flags);
    ...
}

However, iforce_upload_effect() in iforce-main.c executes in process context
with ff->mutex held (which does not disable interrupts) and uses a non-atom=
ic
read-modify-write:

drivers/input/joystick/iforce/iforce-main.c:iforce_upload_effect() {
    ...
    if (__test_and_set_bit(FF_CORE_IS_USED, core_effect->flags)) {
    ...
}

If the interrupt executes between the read and write phases of
__test_and_set_bit(), the interrupt's modification could be overwritten.
Could this potentially leave FF_CORE_UPDATE stuck at 1 and render the effect
impossible to update again?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720115018.7504=
5-1-pengpeng@iscas.ac.cn?part=3D1
