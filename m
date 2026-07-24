Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF60439F72
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901674; cv=none; b=Gn3jAc1/nNs4/Rhrfbf5u9ernTI8EbSfCRiUxq0PXFjXQG6I9JQ5LO5KwJeHaly94gvtjoXL7J+errvFl8UjcDprRHV7TaMTr3Oz/IiJWDdH3mILvof7xDTvkXsg4S2Y+THufUscmzHPhHD7Ge5ZsmC861Z6O9HJX02Na47X2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901674; c=relaxed/simple;
	bh=QT3tAa/P6QEJ9ci7bUOYo7dAyYOWVnNnoFhpCz5Wcas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qfPBxOP20a8B89ETEt33mjxCcqAYqbfN4e/Z0KTBOf9V44UkSxQiwczfL5ZTKX1JfbNEzngdIvI7skhy6kvZbWmdWgORCx/el7ijJT2NyGn8kc5ymE8dw0YW0aJXCWZZ275ETxO96nAxY88UnScA7Wax1L2ELFMBDMeKCdElB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvZW4qf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvZW4qf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCC11F00A3A;
	Fri, 24 Jul 2026 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901669;
	bh=dAPLW8CRo1M3UEkQupfSY3oKsX+GjbqYJji0umN7DTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvZW4qf3r/Fi8QcZ8YwDw/WaCxJSaZT/CPBu2bmoIiuLkRVLihi7hDtvbnVEX/MeJ
	 n8aMfaDJeTkUocu5SHofeUGyzOGeDEgTaqW4yVf9/vMLYhBLUF9ML/4KO5xLiCJOZq
	 fLTd/AY03RTVhdlFuVc7UoJ4AhvTCuMCiYW2HjWjknPtS6HaRbMcXwqof3yEvZq7W/
	 4Ul93VTVOVdzMYlzPvWLBpotynGMCn2zgeddqF6te0mzUkLhabCD7aOMhrKtdlv5e3
	 2nRa5FNrl1zROsvsepiVourCgukdMqiiB4HYygH6OWLhNBIVHDxpE9u0RLZweDk2KN
	 bQ8BhWC7Gym8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at
 driver unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260724134236.34304-1-doruk@0sec.ai>
References: <20260724134236.34304-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:01:08 +0000
Message-Id: <20260724140109.2DCC11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch fa=
ils to correctly fix the use-after-free race condition because it uses `usb=
_kill_urb()` instead of `usb_poison_urb()` or a reversed teardown sequence.=
 `usb_kill_urb()` does not permanently prevent URB submissions; it allows t=
he pending timer to submit the URB immediately after it returns.
--

--- Patch [1]: [PATCH] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at dr=
iver unbind ---
commit 922f81b4c171a572e240262070ec65197e21cd83
Author: Doruk Tan Ozturk <doruk@0sec.ai>

HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind

This commit changes the driver teardown sequence for Guitar Hero Live
dongles to fix a use-after-free during driver unbind. It attempts to kill
the in-flight URB before shutting down the timer to prevent the URB
completion from re-arming the timer on freed memory.

Fixes: cc894ac55360 ("HID: sony: support for ghlive ps3/wii u dongles")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index e75246d29e16d..b7b9b705b9e1c 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2424,7 +2424,19 @@ static void sony_remove(struct hid_device *hdev)
>  	struct sony_sc *sc =3D hid_get_drvdata(hdev);
> =20
>  	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
> -		timer_delete_sync(&sc->ghl_poke_timer);
> +		/*
> +		 * ghl_magic_poke() resubmits sc->ghl_urb from the poke timer
> +		 * and its completion ghl_magic_poke_cb() re-arms the timer, so
> +		 * an in-flight URB can re-arm the timer after a plain
> +		 * timer_delete_sync() (a no-op while the URB is in flight and
> +		 * the timer is not pending).  sc is devm-allocated and freed
> +		 * once sony_remove() returns, so the re-armed timer would fire
> +		 * on freed memory.  Kill the URB first so no completion can
> +		 * re-arm the timer, then timer_shutdown_sync() to drain it and
> +		 * permanently block further re-arming.
> +		 */
> +		usb_kill_urb(sc->ghl_urb);
> +		timer_shutdown_sync(&sc->ghl_poke_timer);
> +		usb_free_urb(sc->ghl_urb);

[Severity: Critical]
This is a pre-existing issue, but does this teardown order still allow a
use-after-free race condition?

Because usb_kill_urb() does not permanently prevent URB submissions, it all=
ows
the pending timer to submit the URB immediately after it returns.

Could this sequence occur if a user unbinds the driver while the URB is not
in flight and the ghl_poke_timer is pending:

1. usb_kill_urb() executes and returns immediately, decrementing urb->reject
   back to 0.

2. Before timer_shutdown_sync() executes, the timer expires and its callback
   ghl_magic_poke() successfully submits the URB.

3. timer_shutdown_sync() then waits for the timer callback to finish and ma=
rks
   the timer as shutdown, but the URB is now in flight.

4. The driver teardown finishes and frees sc.

5. Later, the URB completes and triggers the use-after-free by accessing the
   freed sc.

Would it be safer to use usb_poison_urb() instead to permanently block
submissions?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724134236.3430=
4-1-doruk@0sec.ai?part=3D1
