Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCD47126E
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114738; cv=none; b=NZ9WQ73cdbjZv/nQ3ZmNC53Oi2HFZHHb57olotuZqs7OMeK1zk2jmWEExeGPjcjUdbjQCKcvZepCquGPJOij33JSUEAbxBbv1L4BNPSMuJIdNFy3vbyq+2NbFa+MhvBe+kzekJ1rnI9+O/gC7o/MkWVr3/IFhS1N0svkQtsHPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114738; c=relaxed/simple;
	bh=K4OFgOpY4oDuZeU8ceWg9DF6IIHMC11+4+llbnoJDQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIriCzTksEnt2GDorljyxVz5LUbpnfCVNjs/rCGpN/I9T773kid2X8LgBZUKbIzu004S96pr9C6iP/Z3/ylAIzDMOnFsAbavbaQLS80d0RzrUWZnlttMr6Dl6wWNp86Lsfuqff8jJMDl8FXeatK1lCd+n6MRbRH5xv7oTpzOuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9dRXXRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9dRXXRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6C91F00A3D;
	Fri,  7 Aug 2026 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114737;
	bh=PDESC5GB5WxwkIpQkmSp1R6hLh1HmR5h8786GBU70T8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9dRXXRdvN6tQVMaYonZQNT3u06O0/ORgJVTcJLz+Lpsi3plfldusNA9YupLDolJD
	 9lorExPqjKqQFnxmZrfMmJkN+/h8gCDxAqn+0eyVOrtPCu6ZRqXGU2XFA4vBzhoXkh
	 08cjvmWGh0aUolRvk3YEi7XuNDsfd0UFcNOIcKHq+w4OSevGSj5z/MS77xvTpvi6VO
	 oD/BEi1D/aaD6meUMeqOyrJZ8qC9nciuvdtZwiNzpzxc7gvYTbs0LcXyMDNFJW9wA1
	 TaQUEAYH+xO4gLZy7qvHe+lCDWK6Dx4CsMNNhr05NROE8nVQYi5LKP/xCXQW5I1kHv
	 cxP4MarugUjew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: xpad - fix button mapping on Razer Atrox Xbox
 One
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vernon Di Carlo" <vernondicarlo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807144153.8430-1-vernondicarlo@gmail.com>
References: <20260807141419.7930-1-vernondicarlo@gmail.com>
 <20260807144153.8430-1-vernondicarlo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:58:56 +0000
Message-Id: <20260807145856.CF6C91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Handling GIP_CMD_ANNOUNCE in the URB completion handler calls xpad=
_start_input(), which sleeps and double-submits the URB.
--

--- Patch [1]: [PATCH v2] Input: xpad - fix button mapping on Razer Atrox X=
box One ---
commit f5450a413687f18b1cfa1f3ba3fe1938a5e5c72f
Author: Vernon Di Carlo <vernondicarlo@gmail.com>

Input: xpad - fix button mapping on Razer Atrox Xbox One

This patch adds an Atrox-specific mapping quirk to swap LB/RB and report
LT/RT from their actual locations for the Razer Atrox Arcade Stick for Xbox
One. It also rejects short Atrox input packets.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..00de9145e0916 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -1079,6 +1081,9 @@ static void xpadone_process_packet(struct usb_xpad =
*xpad, u16 cmd, unsigned char
>  					 error);
>  		}

[Severity: High]
This is a pre-existing issue, but while looking at this context, I noticed
that handling GIP_CMD_ANNOUNCE here calls xpad_start_input(), which appears
to sleep in atomic context and double-submit the URB.

Since xpadone_process_packet() is called from the URB completion handler
xpad_irq_in() (atomic context), does calling xpad_start_input() trigger a
sleeping in atomic context bug?

Looking at xpad_start_input(), it makes a GFP_KERNEL allocation and submits
the URB:

    if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
        return -EIO;

Then when it returns, xpad_irq_in() subsequently attempts to submit the same
URB a second time:

    retval =3D usb_submit_urb(urb, GFP_ATOMIC);

Could this lead to deadlocks or panics, and potentially corrupt the USB
core state due to the double submission?

>  	} else if (data[0] =3D=3D GIP_CMD_INPUT) { /* The main valid packet typ=
e for inputs */
> +		if ((xpad->mapping & MAP_ATROX) && len <=3D 22)
> +			return;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807144153.8430=
-1-vernondicarlo@gmail.com?part=3D1
