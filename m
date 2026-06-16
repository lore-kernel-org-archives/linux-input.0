Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685782750ED
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643866; cv=none; b=sGolGo9ns+jrGLvAnqod6BfgtHuv4f80op2l836CZDMqHpfvv8hKJwUaUQukWkgNeBwwCoHKo+tF6qRS2acsNsERNbWw8j7IaG+uAObQyx5u2X9l6D0Ew5R8NaSxpDrwrNmFikEL69tt+DGVUgE0YG0T3yhwh+zMyW4CwdXosjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643866; c=relaxed/simple;
	bh=TjXqKlS7hpeJaUz6fRXeOCcm9FU+E4zTIUWwgAFFa8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQI2okATdrFaj70p6ZwLojWy8nwirZ0E7itFBxd5IE4+ypeFj2ZBokkavOb/eKD66OOuWdiqIgMsCZfy6QDQmInDJITHYvys5Mw7PPH4YkvB4G3KgT20xwU7ai9cVNWClRUT7+ZWMK4ysdEDyCxQOlY2CaQ2UPdt/yXvOZRiCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIjmPEF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIjmPEF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCC21F000E9;
	Tue, 16 Jun 2026 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781643865;
	bh=XlbvMmg5dmIeaif6ae0xRvLcR1lrJTravhGKUBogs5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIjmPEF2yvLFIE3tWuKjtVRpvxq3ARPyYQuPOyv3JqK/QXg4mWM7nbEiJ5FsVyFs8
	 Q4G+Pveaoq7MHaCGNd4OlpVKndvSGJpwlf7bDhGRs1Uns5THJFvPHfsw2qYvy9hLbM
	 SkmidAUedLpKHZ0RSVp7rZ35zBf3DPaDw4GlgO3MFvO3+p6BAtGYGHctm1Bea5TTQK
	 okcrdz01rIRSgkjpy+uU5/U370Tzywph0fcxlv15pge0c42f06+Ug48zYja7gtEgPv
	 Um6yAvuMVKgHoxwfgoH01skDMBm7k91obSHoLuWQ7yxwACpNPrb2ndFSMHjHYTmllW
	 V86tSfPduoL6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: sony: remove unneeded which argument from
 sony_schedule_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosalie Wanders" <rosalie@mailbox.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616205042.6671-5-rosalie@mailbox.org>
References: <20260616205042.6671-5-rosalie@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 21:04:24 +0000
Message-Id: <20260616210424.CCCC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced `hid_hw_close()` calls lead to `hdev->ll_open_count` un=
derflow.
--

commit 45be0bef88ed1ff7df93b4882f4865bcd24126c9
Author: Rosalie Wanders <rosalie@mailbox.org>

HID: sony: remove unneeded which argument from sony_schedule_work()

The sony_worker enum only had a single member, so removing it simplifies
sony_schedule_work().

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index aa5e65a13ecbc..9014c1db1ba5c 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
[ ... ]
> @@ -1859,7 +1849,7 @@ static int sony_play_effect(struct input_dev *dev, =
void *data,
>  	sc->left =3D effect->u.rumble.strong_magnitude / 256;
>  	sc->right =3D effect->u.rumble.weak_magnitude / 256;
> =20
> -	sony_schedule_work(sc, SONY_WORKER_STATE);
> +	sony_schedule_work(sc);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with
unbalanced hid_hw_close() calls leading to an underflow of the open count
in this driver.

In sony_input_configured(), hid_hw_open() is only called if the device
supports battery reporting. However, both the error path in
sony_input_configured() and sony_remove() unconditionally call
hid_hw_close():

drivers/hid/hid-sony.c:sony_input_configured() {
    ...
err_close:
	hid_hw_close(hdev);
    ...
}

drivers/hid/hid-sony.c:sony_remove() {
    ...
	hid_hw_close(hdev);
    ...
}

For devices without battery support (such as motion controllers or
buzz controllers), does this cause an unbalanced close that steals an active
userspace open reference or underflows the open count?

If the force feedback initialization fails for a motion controller over USB,
would the error path execute an unbalanced hid_hw_close() and corrupt the
lifecycle state of the HID device, breaking the low-level driver open and
close state machine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616205042.6671=
-2-rosalie@mailbox.org?part=3D3
