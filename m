Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC073D9DC9
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792321217; cv=none; b=Y/kFlLeY9gSQIp+KMIVAP5v2PxyMgjSQ7z62/XhQ8yVZ0W9e3Ejp3ha7mtw8iZaK4xBQo7tjdLVshgvVOiAr4aXt4SjhK6SBOyQuGAeYqXElEAedxOCnduCNGQJ0wpEyygaZhCcthedqOGbqs1sdcqZvvG4oPl5kls4oAZNEooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792321217; c=relaxed/simple;
	bh=SQ6p1ugCM61M8ROyFnw+Ku0ygww9ARBCj5CXi5PwDRQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rEDRn+8/C5ag7F+fj2vNAmnHeNqHVCO9kuwUTaVmXdnwFUJQDRw3zheV9k+hm7/SB3IhlSKx/Mg+7XEpU1EIP40IztrFjZXLJWabox+FyOoiavA+39/jmJUc8t7zoauVbjOCD7e/WnJJVGHI876lvJoao24plANNlyVJfFOECww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhlzCSfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhlzCSfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7431F000C4;
	Sun, 18 Oct 2026 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792321215;
	bh=xmW3Om+sSK3MdqqDG9w6a7NvqQ9+n2S/AA7Ac6+BeCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mhlzCSfBXQAw+8UdoDzuiT5K1SyyOUwU6Z35+NpBVyKQ8ANrnLuHQLCevp5Q0aytU
	 Hy3qpssQMsg9HlPRbo/ItBdjcAJftDd/ardmRxdT74ffwSGH3ycDQe5RLMe4SClXxz
	 5ZrAL1gp6eQrV4j3gfL01QArVZ63qjfvtnKQK77LPmySaO1p8RcrxpCs1Lbo4rF3K5
	 UFxaUd6/5uotY3+8lImb5/UZnF9gj7VEuNv+UX5848Tz7+zLYYmH6SL7f2jF0Oz6MP
	 PTbJUjcIgzYT2cAbDiXFJNGaQUhkPOnjSwqMG0P2YNXXSBEc8aadu7A60/sPQkAALr
	 BBY6Qsks/8cpQ==
Message-ID: <sashiko-outbox-176065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] HID: wacom: check the input device in the shared
 report helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018104617.743771-2-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-2-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 11:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: wacom: touch_input dereferenced before wacom_wac_finger_count=
_touches()
--

commit 44932063e701ad08bed9376ede6b9b3005174d4c
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: check the input device in the shared report helpers

This commit adds NULL checks for the input device in
wacom_wac_finger_count_touches() and wacom_report_numbered_buttons() to
avoid NULL pointer dereferences when a device interface has no allocated
touch or pad input device.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index c4cd87b781c45..567b01882eb1e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct w=
acom_wac *wacom)
>  	int count =3D 0;
>  	int i;
> =20
> +	if (!input) {
> +		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
> +			      "%s: touch_input is NULL\n", __func__);
> +		return 0;
> +	}
> +
>  	if (!touch_max)
>  		return 0;
> =20

[Severity: High]
Can this NULL check in wacom_wac_finger_count_touches() actually be
reached when wacom->touch_input is NULL?

Every caller of wacom_wac_finger_count_touches() in drivers/hid/wacom_wac.c
first passes wacom->touch_input to input_mt_sync_frame(), which
immediately dereferences dev->mt:

drivers/input/input-mt.c:input_mt_sync_frame() {
	struct input_mt *mt =3D dev->mt;
	bool use_count =3D false;

	if (!mt)
		return;
    ...
}

For example, while a later commit in this series ("HID: wacom: add NULL
input guards to Bamboo touch/button handlers") guards wacom_bpt_touch(),
wacom_24hdt_irq() remains unguarded when wacom->touch_input is NULL (such
as when a WACOM_24HDT or WACOM_27QHDT device probes with a report
descriptor that omits WACOM_FINGER_FIELD usages):

drivers/hid/wacom_wac.c:wacom_24hdt_irq() {
	struct input_dev *input =3D wacom->touch_input;
    ...
	for (i =3D 0; i < contacts_to_send; i++) {
		int offset =3D (byte_per_packet * i) + 1;
		bool touch =3D (data[offset] & 0x1) && report_touch_events(wacom);
		int slot =3D input_mt_get_slot_by_key(input, data[offset + 1]);
    ...
	}
	input_mt_sync_frame(input);

	wacom->num_contacts_left -=3D contacts_to_send;
	if (wacom->num_contacts_left <=3D 0) {
		wacom->num_contacts_left =3D 0;
		wacom->shared->touch_down =3D wacom_wac_finger_count_touches(wacom);
	}
	return 1;
}

Wouldn't wacom_24hdt_irq() dereference a NULL input pointer in
input_mt_get_slot_by_key() and input_mt_sync_frame() before ever reaching
wacom_wac_finger_count_touches()?

Also, when input is non-NULL and touch_max > 1, input_mt_get_slot_by_key(),
input_mt_report_slot_state(), and input_mt_sync_frame() all check for a
NULL dev->mt, whereas wacom_wac_finger_count_touches() dereferences
input->mt->num_slots directly:

drivers/hid/wacom_wac.c:wacom_wac_finger_count_touches() {
    ...
	for (i =3D 0; i < input->mt->num_slots; i++) {
		struct input_mt_slot *ps =3D &input->mt->slots[i];
    ...
}

Should wacom_24hdt_irq() check for a NULL input at entry, and should
wacom_wac_finger_count_touches() also guard against input->mt being NULL
(for instance if touch_max > 1 is set via HID_DG_CONTACTMAX without
input_mt_init_slots() having been called)?

[ ... ]

>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018104617.7437=
71-1-jinmo44.yang@gmail.com?part=3D1
