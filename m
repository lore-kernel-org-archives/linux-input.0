Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1530E0EC
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776142; cv=none; b=BsloWG9nUpYEpaS923EjBvRfkMcNwWFNedGn3tgZsMxQNxzOa4yw16R4DDz8uayq/oKvoXmhJ//sO+rgcDKVOcmx2cFrD8cD6DIYDEQkVDQD+DgWYOjVV8VFcIK1XwXvNTnh9jirSC+0HbjSDB4m0f0w4E11RdN8/B4ShIQmHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776142; c=relaxed/simple;
	bh=PKTj3EscXktJ9RYstJZ1Pu86+taZx579JZMcT+Fhjds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l/P49gcjJn3YTfsiyojP+mIXpiusbf/K9pLft0hcnQ2lt+w/1KEtd94S5SHmqd2iz+vG0TeT3ku/6GqiEFUxMgYm80YMHhcJ2lCUePIleG5xyabBpIRxXZmvpPLW+e6jXIEdoxvzgCZbIz2DqOkwvih3OLR9xJT/z+b2e2iaZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSq2JU0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSq2JU0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB8AC2BCB3;
	Thu, 14 May 2026 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776141;
	bh=PKTj3EscXktJ9RYstJZ1Pu86+taZx579JZMcT+Fhjds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NSq2JU0hOmxDC68ZXay+OGU3fJVHGv85I1ezlzuklUpQEoiayXJoZ1lfyxQA1m5Xf
	 hRTh0nCgfc30YqEsqRtL+Or65V2KcA0cn/PNo3Hg2RDlMY8EYVa3/2Yx0WZqSkpoNC
	 hKJj/r2o3V+cbb0iabYGwGouomeoE1mbeMUYomsR8kUeL7kf46K/gIu3aWmdAdzgiv
	 7XjagdBdLDis7fWrhJx5XBj+ddFO+TyfjSvVqeIDh8dlRoeVOmiEVZaQVTTUaiPCPW
	 ydiZKN51p6xfHXloNCKUGoqdX3KxYpj+rFaCxEGwuOXl1LqcGn+KTYxl3BAiYn7KD1
	 SOORv1q9kMbFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513231445.3213501-5-derekjohn.clark@gmail.com>
References: <20260513231445.3213501-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 16:29:00 +0000
Message-Id: <20260514162901.8EB8AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent sysfs read and write operations interleave commands and=
 corrupt hardware state due to a block-scoped guard() bug on cfg_mutex.
- [High] State machine corruption due to failure to defensively clear profi=
le_pending on unexpected generic ACKs.
--

commit f1baff465a5e284998680961eb3326992b856326
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds intensity adjustment for the left and right rumble motors.
The code was co-developed with AI assistance for data gathering and initial
framing of the sysfs show and store functions.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index a628b77bfb7b5..cffd6ed253ec9 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -815,6 +831,126 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);
> =20
> +static ssize_t rumble_intensity_left_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{

[ ... ]

> +	guard(mutex)(&drvdata->rom_mutex);
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DAT=
A,
> +				    data, ARRAY_SIZE(data), 8);

[ ... ]

> +static ssize_t rumble_intensity_left_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{

[ ... ]

> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D CLAW_RUMBLE_LEFT_PENDING;
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a,
> +				    ARRAY_SIZE(data), 8);
> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);
> +}

Since rumble_intensity_left_store uses rom_mutex and
rumble_intensity_left_show uses profile_mutex, these functions can be
called concurrently.

Does claw_hw_output_report serialize these hardware requests?

Looking at claw_hw_output_report, it attempts to protect the transaction
with a block-scoped guard:

static int claw_hw_output_report(...)
{
        ...
        if (timeout) {
                guard(mutex)(&drvdata->cfg_mutex);
                reinit_completion(&drvdata->send_cmd_complete);
        }
       =20
        // drvdata->cfg_mutex is released here
       =20
        ...
        ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
        ...
        if (timeout) {
                ret =3D wait_for_completion_interruptible_timeout(
                                        &drvdata->send_cmd_complete, ...);
        ...
}

Because the guard is scoped only to the if statement, the lock is released
before the USB transmission and wait occur.

Will concurrent sysfs operations issue uncoordinated USB commands and wait
on the exact same send_cmd_complete object, resulting in desynchronized
responses?

If a concurrent store operation triggers a generic ACK that satisfies the
wait in the show thread, ret will be 0, but claw_profile_event will not
have executed.

In this success path, does drvdata->profile_pending remain stuck at
CLAW_RUMBLE_LEFT_PENDING instead of being defensively cleared?

If an unrelated READ_PROFILE_ACK arrives later, could claw_profile_event
incorrectly demultiplex it based on the stuck state, copying arbitrary
payload bytes into drvdata->rumble_intensity_left?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.3213=
501-1-derekjohn.clark@gmail.com?part=3D4
