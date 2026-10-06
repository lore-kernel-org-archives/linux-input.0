Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CC2857EA
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247160; cv=none; b=se6MDwX/06lZQNaJfSc2/ObaNMxl86rM5Qggs/lb7ZzQxSGQ9/jVSOwW3AIBTcvi5eWEf8HpVCU3Ou32VySPt6OS9DqBsL0cJ/xcJRxpofrq4WwWgc+DpqVIDzMVKWvCiQii4i8sQ9+5qev/S+AeRh3NnQ1/1EhROiMjEluRTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247160; c=relaxed/simple;
	bh=WEDtKlOnNBa5EiqX7zeJadNMrqXvGqjnajPXo1AZTXY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPOCnGTAz5TeWzxBks49dOPtA5tTNYBYFvioY/wsxZTD/rt441jDTVym48bDEGRwKf63BWCyQ7aDhC+YSoYu1h15lgU+vaHGr0Lg1RI8673r6QzHCwcexIhnbbXDbicHMfW45rU9MvPyvjv7xoCuw3eZABqfKuWyAC8KrNoJrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=m8SK+n96; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="m8SK+n96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=j4kbytbcajfenpwk5ezlimtrkq.protonmail2; t=1791247152;
	x=1791506352; bh=DKyc+PsM81uZUwTY/Zzz/kpS8Y+ASO006jmCy6FVAsU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m8SK+n96mj5tNtIKjtHWNgBOs8Lk0KC9EFSV3zGbnakrtoxhTo/im/EHfRa9iR/vI
	 VlE9gBfqObXsq3YhkFJgVaR48ioFVONYPJippSDhts/94UhB7Wv00ZKbnBRJJe/BAA
	 SYahELBTfhsOXJoKbmkZ22BVe4GODAe07Hg7OhYQEzdJwQ5i6DEvWVfCS678+/2jer
	 WOGwx5PIrZrC1TqHslq7FV/KwCD2S2I5Y0+j/kJoohlxluGDbEIIVA+/21618KIvam
	 +HNsUJgK0jk5UBdImAZlCDLWQCXuwTtECm4X5do80eSWjyt64A3LS8iuywuFIdh7rB
	 hJdDMg7dpCr7Q==
Date: Tue, 06 Oct 2026 00:39:07 +0000
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
From: Bartosz Barc <bpbarc@proton.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?Q?Bartosz_Pawe=C5=82_Barc?= <bpbarc@proton.me>
Subject: [PATCH 2/2] HID: uclogic: Report stylus invert state for UGEE v2 devices
Message-ID: <20261006003844.10839-3-bpbarc@proton.me>
In-Reply-To: <20261006003844.10839-1-bpbarc@proton.me>
References: <20261006003844.10839-1-bpbarc@proton.me>
Feedback-ID: 109962581:user:proton
X-Pm-Message-ID: ba6ac088ff46d4fea8f836d0ef2781beee18a19e
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>

Captured raw reports from the XP-Pen Artist 12 (2nd Gen) show that the
first of the two bits immediately after Tip Switch, Barrel Switch,
Tablet Pick (one that is currently declared as padding) is set whenever
the stylus is flipped to the eraser end, and otherwise is set to zero:

hovering, nib:    1010 0000
pressing, nib:    1010 0001
hovering, eraser: 1010 1000
pressing, eraser: 1010 1001

Declare that bit as Usage (Invert) from the Digitizer page, which already
gets mapped to BTN_TOOL_RUBBER.

This field is part of the shared uclogic_rdesc_ugee_v2_pen_template_arr
template used by multiple devices. As this change only reclaims a
padding bit, it should not affect devices that do not support this
feature, assuming their hardware leaves that bit as a zero. I have only
tested this with the XP-Pen Artist 12 (2nd Gen), so further testing with
other UGEE v2 devices would be appreciated.

Signed-off-by: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>
---
 drivers/hid/hid-uclogic-rdesc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdes=
c.c
index a1b31511b625..186beca6a26a 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -878,13 +878,14 @@ const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[] =
=3D {
 =090x09, 0x42,         /*          Usage (Tip Switch),             */
 =090x09, 0x44,         /*          Usage (Barrel Switch),          */
 =090x09, 0x46,         /*          Usage (Tablet Pick),            */
+=090x09, 0x3c,         /*          Usage (Invert),                 */
 =090x75, 0x01,         /*          Report Size (1),                */
-=090x95, 0x03,         /*          Report Count (3),               */
+=090x95, 0x04,         /*          Report Count (4),               */
 =090x14,               /*          Logical Minimum (0),            */
 =090x25, 0x01,         /*          Logical Maximum (1),            */
 =090x81, 0x02,         /*          Input (Variable),               */
-=090x95, 0x02,         /*          Report Count (2),               */
-=090x81, 0x03,         /*          Input (Constant, Variable),     */
+=090x95, 0x01,         /*          Report Count (1),               */
+=090x81, 0x03,         /*          Input (Constant),               */
 =090x09, 0x32,         /*          Usage (In Range),               */
 =090x95, 0x01,         /*          Report Count (1),               */
 =090x81, 0x02,         /*          Input (Variable),               */
--=20
2.56.0


