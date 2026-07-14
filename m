Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD62931DA
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056724; cv=none; b=Ol7/EaQ0IVrACxVLGH9uvnWYdLq2xOgxxKuPGXh3IvEov8hF65LWKwz5mgsCgrWPmx9vsDhAeyCM710VipwtKLA0NRLkyc+sP5yrFTB30oCkLaxBtZ5Q7Kw+wqlcqIhgMRgJ9A8Nq9M5w/+1UqKj+uLEbRyj+eaIbxBeiQXoy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056724; c=relaxed/simple;
	bh=vAC7NmEz6Ix+jgxJFCvTOMUwPM2VSrZKgMwj7oKvoUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RifBckb6gnMruFV8BHmbf4go7VCPH6NCZMCujzaoEopmol/PWGldzMWUqrqTnOyZruPhOyv91LGKXrwrcSPlTWVMRwPSfYZL62kp/AJta55lfG2Qn8D/MqAX34igzMB9OumsEVCJApJQsJqGLYO9tDbWfgiL5VJwXwcZWDsSowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbqsSmw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbqsSmw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870431F000E9;
	Tue, 14 Jul 2026 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056722;
	bh=9f96M8yADrnTLnDjIts4wrWtfhCgaRcS9hrlfQCTm/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbqsSmw0BWKOno80X787EkTZMBwMVGTXumIpUtHInkzs3lfLeipzfz3ge/M8wyLZM
	 ovdAirBovjIXLT3a0/nJhuHlb115y0hU3Z7HC57rfUZ5+dF/tnJN5V1YNdqj2dFxc9
	 oT8cUZ/hLKj+8CPVA+ptgy6T7ohRlkLIv0sTKqapUuo9OJg7Tn/TOnultpfnp7W0E6
	 SQKfocbU5W97FzRO9fX/DE1nWuR7gASe81IaSLtzrXkzPcJ0EjmUSEX4quWBJzOtES
	 OVedhOc2LBN8U0bYiSfCXQd3u0DguQrajDcGn6PmcAdjG749Mrk63iS/R57wPx4JZO
	 W+0YGn9Vm1tbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: playstation: Support DualSense player LED
 brightness control
Reply-To: sashiko-reviews@lists.linux.dev
To: k8ie <k8ie@mcld.eu>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714184225.84646-1-k8ie@mcld.eu>
References: <20260714180424.70662-1-k8ie@mcld.eu>
 <20260714184225.84646-1-k8ie@mcld.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:18:42 +0000
Message-Id: <20260714191842.870431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cancel_work_sync() in the probe error paths of dualsen=
se_create() and dualshock4_create() causes a use-after-free vulnerability.
--

--- Patch [1]: [PATCH v2] HID: playstation: Support DualSense player LED br=
ightness control ---
commit c4af8f1ee7d50867512c691be4fbde7636ea1510
Author: Kate=C5=99ina Medv=C4=9Bdov=C3=A1 <k8ie@mcld.eu>

HID: playstation: Support DualSense player LED brightness control

This patch wires up the controls for the brightness byte on the DualSense
player indicator LEDs. It increases the max_brightness of each player's LED
classdev from 1 to 3, and updates the brightness values before sending
the output reports.

> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index f9dc9378cf777..58786117ec016 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
[ ... ]
> @@ -1742,15 +1776,15 @@ static struct ps_device *dualsense_create(struct =
hid_device *hdev)
>  	int i, ret;
> =20
>  	static const struct ps_led_info player_leds_info[] =3D {
> -		{ LED_FUNCTION_PLAYER1, "white", 1, dualsense_player_led_get_brightnes=
s,
> +		{ LED_FUNCTION_PLAYER1, "white", 3, dualsense_player_led_get_brightnes=
s,
>  				dualsense_player_led_set_brightness },
> -		{ LED_FUNCTION_PLAYER2, "white", 1, dualsense_player_led_get_brightnes=
s,
> +		{ LED_FUNCTION_PLAYER2, "white", 3, dualsense_player_led_get_brightnes=
s,
>  				dualsense_player_led_set_brightness },

[Severity: Critical]
This is a pre-existing issue, but the error paths for dualsense_create() and
dualshock4_create() appear to be missing a cancel_work_sync() call.

If initialization fails after the work is scheduled (for example, if
ps_led_register() fails in dualsense_create()), the code jumps to the err
path:

drivers/hid/hid-playstation.c:dualsense_create() {
    ...
err:
	ps_devices_list_remove(ps_dev);
	return ERR_PTR(ret);
}

Since ds->output_worker is not canceled before the devm routines free the
ds/ds4 structure, could this result in a use-after-free when the global
workqueue eventually executes the worker function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714184225.8464=
6-1-k8ie@mcld.eu?part=3D1
