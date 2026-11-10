Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794336614;
	b=brzsaqLGaCGU8J3YvTJAZm1HUEZOgUCUT43LF9eUsLvqc1YRHmdg7xOfHxyoLXG1whEy
	 mhF792he5148CMQFIge+XyI//2KSCtv0mUKvHOIl6TCSGXXN3mvFDFmRqFM0xfkWyflV0
	 zEHSRE3sNSv8OTrFjyGMUAAoftpGEmfCQNdJruXszXolgLhZ1zYaRIZN7qg6stwhD+zPI
	 KxrJSFa9BUHRzmSGJH/8mmSqwwPCwgJcY6utvVUuJVY8vXcczK+yFKYBVAmk98K53mWL/
	 mdL1hqgXEifeDMtslUmGGczHJ/CT0ecjWP05mR+YLl6tpVxJ0JFLo5ZtBvvyH1iJA9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336614;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=p2IbextAHNaW3yc1BxVBn2/aGRXQasAMIeuG3rdCjBk=;
	b=5km2jG0imW0Q4vjlaScHit/frfhgXNlu6PmxCEZvJsmLDrmpqwNnZ2TA+B0MlAW8YWuM
	 TrCOHQ3zmeI4eNjUvsATjC6Fxv5L/hSOrEdI8BW96Sq/3xfhe7MWerNyz6Q+pLDPGyjH6
	 Imd7mFl8ylz55n18Yb3iWJ8ZhrQH+QhweUK49TXpn553W31/aB7Wf8XXkJcoYZgd7KDAl
	 u8tAeF2GhbpT18v2X5on5reFZU1QvDVitjD5Zz/L/R7OOsSKI8AUPojwiIuQ8uYV1AeJg
	 7QqNSlLRUREWQcbMoAGd1+VXkXoX7/HDOrKeD+b5ECSvW6l/oEmKbP6X+qv7YWBMivQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=a1KoB3Dw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBA606A326;
	Tue, 10 Nov 2026 18:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FBA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=a1KoB3Dw
ARC-Seal: i=1; a=rsa-sha256; t=1794336601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=grDPv7SKgQrSFE9gJixDo7BJDMd+dbW4ThlRpU+fB1bESKAja6qLRVdJ9bn0J7hbxJgcjHAWAthHyjjwFOKQF621UX8qRkUwo6U6QNpf0h9YyyNgsvZZ1lNp39OAGKRjV11hwQKTaOdrMmAtgCCUEQW4df9iteJcEL2Dv0emwIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794336601; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p2IbextAHNaW3yc1BxVBn2/aGRXQasAMIeuG3rdCjBk=; 
	b=C2LfQDYpC2Dcm32kzPNBz+sVr43JZN8VYpopXy/y/OfDktTLANEc/8ORuEmE5Bafvk/MjSSg4G7cCu9dIqP0fVORos7VZB/6/UeOVy0qvUvtPARCnTjKsLDt0LazHPU2CEYPv9vf+oAvipFEviLh/dRiAOIwMQ+UMu4DLehIHEU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=a1KoB3DwCGJyzDX5CqezHEy2zXPS02WcBI4SE2OmYdMAnlDH1gwcBNgZ0es5Uj80j5SzvvuMgrCwybXxAaErw/U/mMhnUV0WIursHzH0DUFZ96JEkOltmcFN44R5OHjOW4MGXcOIUSf/S7NDBKZfk3Pw3gxOts44J57wX3Goyzhs8ahuwMCI6XwY+qT6Gb38rTEzvh8HUPfPcR0uFQr90XEebzfwr5XxdVmX1+SN2YFSc/5ZjtLhfXsV+CsvJcWej9D4ZNHUofUDcGQX45AlECBz9N4DsCIqt9/OuH+UMNp2O+mMO3oDUvrsR5exc8g1yQ91x15UUxh7jjKnE7mbTA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=p2IbextAHNaW3yc1BxVBn2/aGRXQasAMIeuG3rdCjBk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794336598712503.7128319877977;
	Tue, 10 Nov 2026 10:49:58 -0800 (PST)
Message-ID: <4d0153a209a7c54ff513eabd3fd87445269279f0.camel@rong.moe>
Subject: Re: [PATCH RFC 1/2] platform/x86: ideapad-laptop: Ignore keyboard
 backlight hotkeys
From: Rong Zhang <i@rong.moe>
To: ciro.pedrini@gmail.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt
	 <aer@tuxedocomputers.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261109-legion-lighting-rfc-v1-1-a87e1db8c5e3@gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
	 <20261109-legion-lighting-rfc-v1-1-a87e1db8c5e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:44:53 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

On Mon, 2026-11-09 at 22:50 +0000, Ciro Pedrini via B4 Relay wrote:
> From: Ciro Pedrini <ciro.pedrini@gmail.com>
>=20
> On the Legion Pro 7 16IAX10H, Fn+Space (backlight effect), Fn+Up and
> Fn+Down (backlight brightness) emit WMI fn-key events 0x21, 0x1a and
> 0x19, which the keymap does not cover, so they reach userspace as
> KEY_UNKNOWN. The keyboard's USB controller handles these keys itself: it
> switches the effect or changes the brightness, and reports the new level
> on its own HID interface. Ignore the three events, as is already done for
> FnLock and Esc, rather than mapping them to KEY_KBDILLUM*, which would
> make userspace change the brightness a second time.
>=20
> Tested on the 16IAX10H with 7.2: with the change, evtest shows no events
> for the three keys, and the keyboard still switches the effect and the
> brightness.
>=20
> The change and this changelog were prepared with Claude Code (Claude
> Opus 5.5), from measurements on the laptop (evtest on the "Ideapad
> extra buttons" device); I reviewed and tested them.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>

Acked-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platf=
orm/x86/lenovo/ideapad-laptop.c
> index 91a8d11c79c5..8b6c08b21c8d 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -1336,6 +1336,10 @@ static const struct key_entry ideapad_keymap[] =3D=
 {
>  =09{ KE_IGNORE,=090x02 | IDEAPAD_WMI_KEY },
>  =09/* Esc (handled by the firmware) */
>  =09{ KE_IGNORE,=090x03 | IDEAPAD_WMI_KEY },
> +=09/* Keyboard backlight down, up and effect (handled by the keyboard) *=
/
> +=09{ KE_IGNORE,=090x19 | IDEAPAD_WMI_KEY },
> +=09{ KE_IGNORE,=090x1a | IDEAPAD_WMI_KEY },
> +=09{ KE_IGNORE,=090x21 | IDEAPAD_WMI_KEY },
>  =09/* Customizable Lenovo Hotkey ("star" with 'S' inside) */
>  =09{ KE_KEY,=090x01 | IDEAPAD_WMI_KEY, { KEY_FAVORITES } },
>  =09{ KE_KEY,=090x04 | IDEAPAD_WMI_KEY, { KEY_SELECTIVE_SCREENSHOT } },
