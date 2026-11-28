Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867584;
	b=I76Jp2hC5AOz3SGZA+qMyuXoIoM89ZmbVEtDPUD+XsbeD4LJ4gEVZ1BJTASlAHd9tuM8
	 48of9toj/qssUPUmFS68jo7hBtJi/YLgHWghXIx+iPWVW8Inb7zVD8znSpha5Vlm3Xbhk
	 yO1nMElg+aFqwVkE/WQ9oJsWpM33ZnE7Dp+TwSeci8SoSfHhlHGl51oF26npR7dtzeZJ/
	 yt1l5Cijk3PVfKVJYF1TgqduWDkdpVY6ZfVM0c6Kffpt0OeQ/ESJ2NI6DaZUzbjWedNB9
	 54tlljLlWUW3CcetOOwitMgJgH0ZPNHQ8bQ149k/IOeBJY/t3xycR8QFxZ4X2/6eYVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867584;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=/MIE4vq/FN1EOjs/5ETTx4Jr3QdxYFZf+qhT2RjGEv4=;
	b=hk8G6gVXmfK2LheNZEI9sNR7I20LP9sjAGaVPCJFKjd9rVfLNwMIYJHFM9C2Icmt6NBg
	 MNN8S9feG3klnMshsIVlAqDH0GOyD+UR5e9ZHUPeaai3uCbmxYhclGlRQjhN03d32G6xo
	 yUYXQLEMMFs27VP7si0l6W//5ePy7WHosWr5ZVEFZ0RQozJgxqPrP5hmQ6m5Sq0HPHMCu
	 hMvg0bDCbl7nAiJgQYTOLDQanWKamwyFNKn6xiI2Mogr91Ewpxzyd4jzl0EMAjgV4kdCh
	 i/uDtHCjU7lZDCRiLskj2XfRZTq1Lr8KBKG4kdCpRUFErjbw/7MmB7NvSZuplYNZbaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=hf8Gq6X1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7A606A321;
	Sat, 28 Nov 2026 12:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC7A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=hf8Gq6X1
ARC-Seal: i=1; a=rsa-sha256; t=1795867564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MwNWM+2UVaCbz9gvJaIC89VsbQgpnqYGbEX5qFkvIsSlGzu8Crrj5mVzRFbSt+aTI4pAq/t7g5cUVlmvB49iRzBSHWmwM9y9S8p+mG/0FdPKQdImcJNe0pD5vamCkDOhsDyFseP9Y/tg3OrToRV0QmbTCD5hr0+7IFiJiGUB32o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795867564; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/MIE4vq/FN1EOjs/5ETTx4Jr3QdxYFZf+qhT2RjGEv4=; 
	b=Ft1c4XM/GRuZDElYFSNZjzk16K366vc7fAWbRskLzQ4Ni57Ye+3ikI6k4ESxyqssxsOzMrwtO7s78NLvotDVUVtb1pLvPp23/KAb0kBZ6DXnNHvJRdeRD90JzBvk1BVP6NcxmQKnhQXwwNdk1fnjhaSV9gapOP7smwbW40D1f4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=hf8Gq6X1ggZzpDU6Y22aC5dYDdrFofngj0cMDAe6sHt6txl1jwwG2/0Bma0zCUZ23FLSHjHewn+lqF593EhxxemYQEq5NA93zowAkmFjI5BT1uaMgPSFrR8XUlhOFSU40sCRwjv48tKicyfTZOMUHlMOcweo8nHZgXEEbic1wMY2SO9IP8MXJw+cOGLpr3l/LWK8axZAU4FuYJ/DP5OZXBoBs9F731WEAt0tX201PM2oerh89Z2vIw7I3p+LtLs5FcwgaaYYC14Xx9hHZrSC9xTcioDVYQLLTqmXVtnx0cGIzDxJVKfrjSPpEP1c2S6Kv4bwFKvRNh/2l1PNxtc4Ow==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=/MIE4vq/FN1EOjs/5ETTx4Jr3QdxYFZf+qhT2RjGEv4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795867561898695.6030045258999;
	Sat, 28 Nov 2026 04:06:01 -0800 (PST)
Message-ID: <3468fb09e97e129fd11dfa334da1af289a96d31d.camel@rong.moe>
Subject: Re: [PATCH v3 0/2] Keyboard backlight for the Lenovo Legion Pro 7
 Gen 10
From: Rong Zhang <i@rong.moe>
To: ciro.pedrini@gmail.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: David Cemin <dcemin@nvidia.com>, Werner Sembach
 <wse@tuxedocomputers.com>,  Aaron Erhardt <aer@tuxedocomputers.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
In-Reply-To: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
References: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 20:00:53 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-4 
X-ZohoMailClient: External

Hi Ciro, David,

On Fri, 2026-11-27 at 01:11 +0000, Ciro Pedrini via B4 Relay wrote:
> Hi,
>=20
> This is v3 of the Legion keyboard backlight series. It has the changes
> Ilpo and Rong asked for on v2, and one fix I found while testing them.
>=20
> Short background: on my laptop the keyboard backlight never turned on
> under Linux. The keyboard controller (048d:c197) stores a brightness from
> 0 to 9 behind a vendor feature report (0x07), it was 0 from the factory,
> and nothing on Linux could change it. That brightness dims every LED of
> the machine. Fn+Up/Down/Space are handled by the firmware, which sends
> the new level on a vendor input report.
>=20
> Patch 1 stops ideapad-laptop from sending KEY_UNKNOWN for those three
> keys. Patch 2 is the driver: the brightness as a kbd_backlight LED, plus
> brightness_hw_changed for the hotkeys so the desktop OSD works.
>=20
> The fix: while testing v3 I found that the controller sends the same
> "brightness is now B" report after every brightness set, the host's
> own ones too, and also when the level doesn't change (Fn+Space sends
> it as well). v2 passed all of those to brightness_hw_changed, so the
> host's writes looked like hardware changes. v3 only reports a level
> that differs from the last one the driver knows.
>=20
> David: patch 1 adds three KE_IGNORE entries to the ideapad WMI keymap,
> which your "architecture independent home for the Lenovo WMI drivers"
> series moves to wmi-fn-keys.c. Whichever goes first, I'm happy to
> rebase mine on yours; it's the same three lines in the new file.

David, could you integrate PATCH 1 into your series when you resubmit it?
I.e., append a PATCH 4.

I believe this is the easiest way to solve the collision. The hid-lenovo-
legion driver (PATCH 2) does not depend on PATCH 1 per se, so they can be
applied in an arbitrary order.

Thanks,
Rong

>=20
> I tested it on my 16IAX10H (83F5, BIOS Q7CN77WW) with 7.3 as a module:
> brightness from sysfs and KDE, the hotkeys and the OSD, Fn+Space,
> suspend/resume, unbind and rebind, and the vendor report on the wire
> while doing that. It's based on pdx86 for-next and builds with W=3D1.
>=20
> About how this was made: I found the protocol with usbmon captures and
> by looking at Lenovo's Windows software. I wrote the code with help from
> Claude Code (Claude Opus 5.5). I went through all of it and tested it
> myself, and each patch has a short note about it below the ---.
>=20
> Thanks,
> Ciro
>=20
> ---
> Changes in v3:
> - Short reports: send only the request bytes and read only the answer
>   bytes, right after the request; no more 100 ms wait (Rong).
> - The buffer is allocated per exchange. Not on the stack as Rong
>   suggested: usbhid hands it to the USB core for DMA.
> - legion_raw_command() and legion_simple_command(), and the request
>   length checked against the 960-byte report with a static_assert
>   (Rong).
> - Out-of-range values and failed reads return errors instead of being
>   clamped or replaced; dbg messages, no hex dump (Ilpo, Rong).
> - devm for hid_hw_start()/hid_hw_open() and the LED; .remove stays,
>   empty, so hid-core doesn't stop the device twice (Ilpo, Rong).
> - Dropped the (int) casts and the "(2025)"; comments trimmed, the one
>   about HID_QUIRK_INPUT_PER_APP now says why; Kconfig help about what
>   the driver does (Ilpo, Rong).
> - New: only report a level change to brightness_hw_changed (see above).
> - Rebased on current pdx86 for-next; Rong's Acked-by on patch 1.
> - Link to v2: https://lore.kernel.org/r/20261110-legion-lighting-rfc-v2-0=
-845726afb71c@gmail.com
>=20
> Changes in v2:
> - Only the keyboard controller (c197) now, as Rong suggested. No
>   LampArray, no colours, no lighting_mode, just a kbd_backlight LED.
> - Ilpo's comments: struct with __le16 for the request, guard(),
>   devm_mutex_init(), no magic numbers, includes.
> - Removed the "ready" flag, its spinlock and the work item. raw_event
>   can't run during probe/remove, so it notifies the LED directly.
> - Keep led_cdev.brightness in sync with the hotkeys (from the Sashiko
>   review).
> - Moved the note about the AI tool out of the changelogs, below the ---.
> - Link to v1: https://lore.kernel.org/r/20261109-legion-lighting-rfc-v1-0=
-a87e1db8c5e3@gmail.com
>=20
> ---
> Ciro Pedrini (2):
>       platform/x86: ideapad-laptop: Ignore keyboard backlight hotkeys
>       HID: lenovo-legion: Add keyboard backlight driver for Legion Gen 10
>=20
>  MAINTAINERS                                  |   1 +
>  drivers/hid/Kconfig                          |  12 ++
>  drivers/hid/Makefile                         |   1 +
>  drivers/hid/hid-ids.h                        |   1 +
>  drivers/hid/hid-lenovo-legion.c              | 293 +++++++++++++++++++++=
++++++
>  drivers/platform/x86/lenovo/ideapad-laptop.c |   4 +
>  6 files changed, 312 insertions(+)
> ---
> base-commit: 61c0dac952b9308884936d05cce97565a5c89af4
> change-id: 20261109-legion-lighting-rfc-dc32165df52d
>=20
> Best regards,
