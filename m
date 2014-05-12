From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 00/24] input: Introduce ff-memless-next as an improved
 replacement for ff-memless
Date: Mon, 12 May 2014 11:14:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405121112520.5813@pobox.suse.cz>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52478 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaELJOo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 05:14:44 -0400
In-Reply-To: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

On Sat, 26 Apr 2014, Michal Mal=FD wrote:

> ff-memless-next (MLNX) is a largely improved version of the current f=
f-memless
> (FFML) driver. MLNX supports all force feedback effects currently ava=
ilable in
> the Linux force feedback userspace API. All effects are handled in ac=
cordance
> with Microsoft's DirectInput/XInput. Most notable changes include sup=
port for
> conditional effects, proper handling of all periodic waveforms and im=
proved
> emulation of rumble effects through periodic effects. MLNX also uses =
its own
> kernel API to pass processed effects to hardware-specific drivers ins=
tead of
> abusing "ff_effect" struct. The API is documented in the respective h=
eader
> file.
>=20
> MLNX has been expanded to be a direct replacement for FFML.
>=20
> Support for FF_PERIODIC and FF_RAMP has been added to all devices tha=
t
> support FF_CONSTANT as a part of the port to the new API.
>=20
> This patch series:
> 1) Adds "ff-memless-next" module [1]
> 2) Ports all hardware-specific drivers to MLNX's API [2-23]
> 3) Removes FFML and replaces it with MLNX [24]

Dmitry,

what are your plans with this, please?

I personally don't really completely like having two implementations of=
 FF=20
in the kernel; can't it be really done as an extension to ff-memless?

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
