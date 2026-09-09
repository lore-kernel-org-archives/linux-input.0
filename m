Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A445DF47
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951067; cv=none; b=NMuYKWq47hwANkoPwKmq7i9GH0eKTFxszuqfFH9y76iA7P0hHije5NqMChW7JvkpDjyqc82TTNPSb6TYLtY5MBpqNIHneAkCo0bjwX8RhAGapAX25806kBw9CusLbc/vM3VQgbQZmqqIOhRBRRIw2OkJyshoLGulFEbhSqbU8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951067; c=relaxed/simple;
	bh=t/0KGcphiYLUBvUHyq5A/5cegZ+QMwpfYt79RuHvmAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kI3IrTqerUIXa/xFhnm0yyAfXOgJ2o8PdHDJorvUqqWQuYoeS35EbotTc3O9GKeKkYatGrDHxSb1pHVtfiWmzF0vdv/CWRT1i0eLeggWnh0VJ7YacwaxYDRBilhemw1BS9tCjVMjFZJikd0Vr1bzxy5LDAVLqCzncdwacQWfkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8kd94+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8kd94+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1551F00A3A;
	Wed,  9 Sep 2026 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951066;
	bh=cAX7xipKAcTWbff9Q4mRdRFMMfSAADmOfT+Tmj4UbNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8kd94+lPNIoEyeqHR73dnNrbAkvRspGZs2JvbfwUvMpmVvyOFd1BoS/7+ob9My0E
	 3qjt3Gyqy9x4xpYAaYkw2+tXMnO713NfipYExW8Sc6ZbkT4ZkMDAD0ROFLbD7y21B/
	 xUUojnTOIr/zJC/iMxSjeUjzdvq/PXvKp9wSV5zdcFJTHnnlcSube20+5w8vcvegnW
	 Q6DvfDcpmEzoLEp06NTtMziAb9anzzqPn72fBBs8pwpBe6kv2xF/Ic/Kcy8pm7xyth
	 ULCDX3PU/08AKKrtCkQSV19TKpsQKovo8v9It1V1Evq7SWnXaEJBSmAXdhiJcnssPi
	 hAuvRvuD3NGTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] Input: aiptek - validate raw macro indices
 before updating state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <CABKbRo+qUMG8=+-MnY34KkscgZdPASieN7CgWce9BTCggNSvcg@mail.gmail.com>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
 <2026090833-mutt-whiny-242e@gregkh>
 <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
 <CABKbRo+qUMG8=+-MnY34KkscgZdPASieN7CgWce9BTCggNSvcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:51:05 +0000
Message-Id: <20260909105106.0A1551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sysfs attribute handlers dereference NULL driver data during devic=
e probe.
--

commit 645c2a36ee70a10a323ece648cef25c5a29065c9
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: aiptek - validate raw macro indices before updating state

aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Validate the raw macro index once
before it enters that state machine, so lastMacro only ever stores an
in-range macro key. Keep direct bounds checks for report type 6, which reads
the macro number from the packet body and uses it immediately.

Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 2b3fbb0455d5c..9e78105bace77 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -658,6 +658,8 @@ static void aiptek_irq(struct urb *urb)
>  		pck =3D (data[1] & aiptek->curSetting.stylusButtonUpper) !=3D 0 ? 1 : =
0;
> =20
>  		macro =3D dv && p && tip && !(data[3] & 1) ? (data[3] >> 1) : -1;
> +		if (macro >=3D ARRAY_SIZE(macroKeyEvents))
> +			macro =3D -1;
>  		z =3D get_unaligned_le16(data + 4);

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but it is a pre-existing issue.
Can this cause a NULL pointer dereference during device probe?

In aiptek_probe(), there is a window where the driver core adds dev_groups
(making sysfs attributes visible to user-space) before usb_set_intfdata()
is called.

If a user-space process concurrently reads or writes the sysfs attributes
during this window, dev_get_drvdata() will return NULL.

This blindly dereferences the NULL aiptek pointer in show_tabletSize():

drivers/input/tablet/aiptek.c:show_tabletSize() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	return sysfs_emit(buf, "%dx%d\n",
			  input_abs_get_max(aiptek->inputdev, ABS_X) + 1,
			  input_abs_get_max(aiptek->inputdev, ABS_Y) + 1);
}

The same blind dereference occurs in the write path of store_tabletExecute(=
):

drivers/input/tablet/aiptek.c:store_tabletExecute() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	/* We do not care what you write to this file. Merely the action
	 * of writing to this file triggers a tablet reprogramming.
	 */
	memcpy(&aiptek->curSetting, &aiptek->newSetting,
	       sizeof(struct aiptek_settings));
    ...
}

And also when reading the firmware code in show_firmwareCode():

drivers/input/tablet/aiptek.c:show_firmwareCode() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	return sysfs_emit(buf, "%04x\n", aiptek->features.firmwareCode);
}

Since these sysfs files are created with S_IRUGO (0444), any unprivileged
local user could trigger this panic by repeatedly reading the files during
device plug.

Could the sysfs group creation be deferred until after usb_set_intfdata()
has completed its initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CABKbRo+qUMG8=3D+-M=
nY34KkscgZdPASieN7CgWce9BTCggNSvcg@mail.gmail.com?part=3D1
