Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB3345CCD
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924665; cv=none; b=GFh6QG0FwNMl0zs+gK4h4bsFPpQ3eCAUcxmC5xrj+gxPv2eSqGYSoNP2aQHX3HaqFYHZ3kU9pnm3nO9L/OSHNCYmvbOowwR6rTYcoX0OWKoBL/CT3j/8h1uJrKj5kltxjot6DtA8ZTzdK4lH5eyWwYgjznJwyKhv5wGkCd6UykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924665; c=relaxed/simple;
	bh=xfVPT9OzxlqV3qbzcWrzmgUwngPIEKF0PvpfrMlNbAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMjc/+Y64X20U4P6UeCkEe4fIlfN4ifnUdZgfnXeCSGKgGxI89Gfe1qdj7CbmOJANdrOE//KySYRa/ZU6AvWHva70nZkl+u0uPO5VJ5y1MzikEc53eIxuZByjaLrTJ4QImfVtwr9xVDWW04binCnVAlA9+qut6u9jpEcwva4T0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z++7OPUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z++7OPUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA231F000E9;
	Wed,  5 Aug 2026 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924663;
	bh=KTMSpwb18eC4rhmrLMs9ravbsAe8/ZPlMqRTkfoezb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z++7OPUJoDa7ym0VchXuddFMsawKlQNCT/RihbSV+dAjaNWkYwRdB1ry0VJmu17qT
	 EuQXpMyVI2tyMMbY6KNFJUZlXOji4ida3vafh6QSqJnC6Iljh5RH8VIgAO3wkBLJdR
	 7ADLnx2iDl7UIijF2RbJm14oycw9jciJdX85+RKP7yMZ7ECi+WJxt0KDZPoLFa52BT
	 etMRTrck/BsiWDCPSJRESiawKf/rx7A1KefNcB+ksr72JwP9paBNGLssi7RS1TrO2A
	 uUsC14UJXCkD5MxG4gUHi8XwR6GI+sED/pHIxQ/Ne6wmxSl03Oz0OofKzKPXvpKJ9W
	 zVTJQx3zX228w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input: xpad - add packet length check for
 xpad_process_packet()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260805-xpadone_length_checks-v2-2-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
 <20260805-xpadone_length_checks-v2-2-f3e925e0280b@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 10:11:02 +0000
Message-Id: <20260805101103.6AA231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Using `min(len, XPAD_PKT_LEN)` causes a compiler warning due to mis=
matched types.

Pre-existing issues:
- [High] The patch adds a packet length check to `xpad_process_packet` to p=
revent OOB reads, but misses identical vulnerabilities in `xpad360_process_=
packet` and `xpad360w_process_packet`.
- [High] The `xpad->work` workqueue item can execute after `xpad` is freed =
in the `xpad_probe()` error path for wireless Xbox 360 controllers.
--

--- Patch [2]: [PATCH v2 2/3] Input: xpad - add packet length check for xpa=
d_process_packet() ---
commit 871137dca87547e72930981b59cce6b2b69f5992
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add packet length check for xpad_process_packet()

This patch adds a bounds check to xpad_process_packet() to ensure that the
processed packet is at least 20 bytes long. This prevents a potential
out-of-bounds read if a shorter packet is received.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 9ce792503b3a4..83bc361b15f76 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -1259,7 +1262,7 @@ static void xpad_irq_in(struct urb *urb)
>  		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);

[Severity: Low]
Does the min() check in xpadone_process_packet() cause a compiler warning?

Comparing a u32 (len) with a literal 64 (XPAD_PKT_LEN) using min() causes a
'comparison of distinct pointer types lacks a cast' warning due to strict
type checking. Would min_t(u32, len, XPAD_PKT_LEN) be more appropriate here
to avoid build failures when compiled with -Werror?

>  		break;
>  	default:
> -		xpad_process_packet(xpad, 0, xpad->idata);
> +		xpad_process_packet(xpad, 0, xpad->idata, urb->actual_length);

[Severity: High]
This isn't a bug introduced by this patch, but does this same vulnerability
exist for the Xbox 360 packet handlers?

In xpad_irq_in(), a malicious or malfunctioning USB device sending short
interrupt packets can cause xpad360_process_packet() or
xpad360w_process_packet() to be called without passing or verifying
urb->actual_length. This allows unconditional reads of up to 14 bytes
from the xpad->idata buffer, potentially reading stale data in the same
way this patch prevents for xpad_process_packet().

[Severity: High]
This isn't a bug introduced by this patch, but can the xpad->work workqueue
execute after xpad is freed in the xpad_probe() error path?

If an XTYPE_XBOX360W controller is detected during probe,
xpad360w_start_input() submits xpad->irq_in and then calls
xpad_inquiry_pad_presence(). If this fails, it kills the URB and returns
an error, causing xpad_probe() to free xpad via kfree().

However, if the USB device completes an interrupt transfer immediately
after irq_in is submitted, xpad_irq_in() will call
xpad360w_process_packet(), which schedules xpad->work:

drivers/input/joystick/xpad.c:xpad360w_process_packet() {
    ...
    if (xpad->pad_present !=3D present) {
        xpad->pad_present =3D present;
        schedule_work(&xpad->work);
    }
    ...
}

Since the error path doesn't call cancel_work_sync(&xpad->work), can this
result in a use-after-free when xpad_presence_work() dereferences the freed
xpad struct?

>  	}
> =20
>  exit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-xpadone_le=
ngth_checks-v2-0-f3e925e0280b@kroah.com?part=3D2
