Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E919CD1D
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429948; cv=none; b=mUlE1XP1we92y6AKqVQv0DX6hWk1YN7ruU5mtBjuxfEkm08Z5MXIfYElo8h4nTHM3dbjryOaPucd/ecah4Ge56di9lmZ8XFTGwohaBs2Q4p9sSD5vUgQpP21Z10VrT/YDCt/6iFTaa9lAYjUllMOgaR/S90RzN3bzOzHhqytBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429948; c=relaxed/simple;
	bh=cRyG9Zxw1NZdmbAOuS5tq+RuSL8IY89cTuNFT8dRnM8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EMhGV1e++cZvrMHSwWLh0/UlFfMcWjuKrjHd2/QZIdgXyRhsBdy1kzTXS3rjCIV+rf41OweKpluT3DnHDbWNeB2i0xgwNTeDlLJ2a7LUMaHpT/JpFhD0e9ObfNrdJ8wbqcdt0rhUeeA4YOwHpNW0+cxKFSTxmH3KYR8i8GRAfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLElu7rS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLElu7rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5321F000E9;
	Fri, 22 May 2026 06:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779429947;
	bh=L7YpIChUbt3brq1rMQ/13nEIax8zfNrMhc1QMVSUfcQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SLElu7rSbORcPGxKUHhJXu1D80KByETZI39dv5dAG2eaqgChF9XnqPhJGcvS9F9JF
	 Sb3Ttv7K5xN7LfBdN7TW/ESWvq8LPAlDwRo6h3beNp0usYwZQ3XNWKUHDF5of2PpWu
	 9JVo/bP9sxf5dPeUcBkju9qDeClw3COzhQISkLQ48Lr/zwwJIYga7Sj+inn/oLZ0Iu
	 wR3T7fOjJvqXbeekUcbKN+KRW55UFT/ymM7A0WP+gyPuu2n71o/bdOxd6KMaO+Bwss
	 PSBP6bdRiShVo7WWMktAnm06HeFtIevXnat7MJnF/oGs+akUYfzKg5h68bsV4sgMGa
	 8bXxYvnB/Ovwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: lenovo: Use KEY_PERFORMANCE capability for
 ThinkPad X12 Tab Gen 2
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260522050632.8079-2-vishnuocv@gmail.com>
References: <20260522050632.8079-2-vishnuocv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 06:05:46 +0000
Message-Id: <20260522060546.DC5321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch unconditionally adds the KEY_PERFORMANCE capability to al=
l input nodes exposed by the device, causing capability pollution on unrela=
ted interfaces.

Pre-existing issues:
- [High] The raw event handler emits keys like KEY_RFKILL, KEY_BOOKMARKS, a=
nd KEY_KBDILLUMTOGGLE, but their capabilities are never declared, causing t=
he input subsystem to silently drop these events.
- [High] The raw event handler contains a loop that unconditionally fires k=
ey events on the first input node it encounters, ignoring capability routin=
g and causing events to be dropped.
--

commit 1b40b44e417a26a21650fec78e6a2ea55f535004
Author: Vishnu Sankar <vishnuocv@gmail.com>

HID: lenovo: Use KEY_PERFORMANCE capability for ThinkPad X12 Tab Gen 2

This commit adds the KEY_PERFORMANCE capability for the ThinkPad X12 Tab Ge=
n 2
and X13 Tab devices during input configuration. This allows userspace tools=
 to
discover the key emitted via the raw event handler.

> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 35b00619f0456..3492ba8d0fb02 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -1525,6 +1525,7 @@ static int lenovo_input_configured(struct hid_devic=
e *hdev,
>  						hi->input->propbit);
>  			}
>  			break;
> +		case USB_DEVICE_ID_LENOVO_X12_TAB2:
>  		case USB_DEVICE_ID_LENOVO_X13_TAB:
>  			input_set_capability(hi->input, EV_KEY, KEY_PERFORMANCE);

[Severity: Low]
Does this unconditionally add the KEY_PERFORMANCE capability to all input
nodes exposed by the device?

Since lenovo_input_configured() is invoked for every hid_input interface,
this regression might advertise the capability on unrelated interfaces.

Could we filter this by checking the application usage or verifying it is
the primary keyboard node?

[Severity: High]
This isn't a bug introduced by this patch, but I noticed the raw event
handler also emits keys like KEY_RFKILL, KEY_PICKUP_PHONE, KEY_BOOKMARKS,
and KEY_KBDILLUMTOGGLE.

Should we also declare the capabilities for these keys here?

Since they are generated from raw reports rather than standard HID
descriptors, they appear to be missing from the capability bits, which would
cause the input subsystem to silently drop these events.

[Severity: High]
This is a pre-existing issue, but looking at how the raw events are handled
in lenovo_raw_event_TP_X12_tab(), is it possible the events are firing on
the wrong input node?

The handler loops over hdev->inputs but returns immediately after reporting
the key event on the first node it encounters. If the first device lacks the
specific key capabilities, the input core might discard the event.

Should the loop instead locate the specific input node that possesses the
corresponding key capability before dispatching?

>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522050632.8079=
-1-vishnuocv@gmail.com?part=3D2
