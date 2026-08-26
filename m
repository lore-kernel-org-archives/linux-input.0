Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C238DC56
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731688; cv=none; b=YE7diXi7TWJUvg8sgxfk+vSdzpci4D4Mp0UaYA6Upw5nDlfN6KtYqOP2KuJX+6M/68X/DOCPJY9QQgcxidimTctRiRJIvtAJ1RKiAqEJvmK2hia/BfyKbotv1G7oc5p36ZVZw6Mrd9cCi3exq8I7A8CBSLAHYZr7AJpI+5kc3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731688; c=relaxed/simple;
	bh=5YKLy5VFW/DKXPSFtXZN++p46bWj2RpX8FsCYIndZQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lSgvUZ4J22LoQQhGFJqaxTD3jcsuoEvMJvkGZKCFV8TpsutIlPD9Jj4sTEH5Yfp1MxKC4QSR/8sQ3UeXKyAXOgXhTh7wIVTfhv7L4H5Gqvg8RcH3sAZyjtWhNX85ranwyeFw4tTr4cN0PebWFf4tdYUXKhX5w9PaH0rCMObaHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0KMculD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0KMculD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CFB1F00A3A;
	Wed, 26 Aug 2026 08:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731687;
	bh=wpYlYyT5KZ1ACSoinXQKk2snMaZ682Ss+mP1V2iUGl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0KMculDTvzlZBP0nARLE38BmO4/XfayCPnu984axS6oCvxVxV/8hDMGbGbIjVJ/E
	 tPjZqFxhz2cXEhQaCYLcA3HKYm2IXx2saOvlwNRjCSTE6z+rvX1rIhg5KAdgCdnw+S
	 RYMexwXuFz1tWf3dckcXAA961ffJrHkH92KCjOWUF3wAqjrhDwbpKVAZ754qqdM1+/
	 n1RJYf+ouE7w0qg+HXbJ24HvlpybW4CmL0ZoKuEijTckuXW57VnLugA3JnytXfmxYv
	 pdzghox0ANEQzNxyguVv6X3Xkxlb501PlenN5LnE2g2UXQaQccffD5f5k9OZRjLI+x
	 V0UotavJ910eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Reply-To: sashiko-reviews@lists.linux.dev
To: DevExalt <exalt.dev.team@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260826075758.47287-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
 <20260826075758.47287-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 08:08:06 +0000
Message-Id: <20260826080806.E2CFB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `reset_hi_res_work` in the `hidpp_probe` e=
rror path, leading to a potential Use-After-Free.
--

commit 452cf6e851cc2adb7ff83d84efb83964e63b45a1
Author: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>

HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)

This commit adds support for the HID++ Multi-Platform feature, introducing a
per-device sysfs attribute to allow selecting the target platform. It detec=
ts
the feature, validates requests, and alters device behavior accordingly.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777f..1cb78096f31c5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -4557,6 +5154,7 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  hid_hw_open_fail:
>  	hid_hw_stop(hdev);
>  hid_hw_start_fail:
> +	hidpp_multiplatform_cleanup(hidpp);
>  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>  	cancel_work_sync(&hidpp->work);
>  	mutex_destroy(&hidpp->send_mutex);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
vulnerability in this error path.

Could this leave a pending work item running on freed memory if a device
sends a raw hardware event during the probe sequence?

The reset_hi_res_work is initialized earlier in hidpp_probe() and
could be scheduled immediately after hid_device_io_start() is called.
If a subsequent initialization step like hid_connect() fails, we end up
in this error path which cancels hidpp->work, but skips canceling
hidpp->reset_hi_res_work.

The core devres mechanism will then free the hidpp structure, potentially
allowing the pending work to execute on freed memory.

Should cancel_work_sync(&hidpp->reset_hi_res_work); be added to this
cleanup path, similarly to how it is correctly handled in hidpp_remove()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826075758.4728=
7-1-exalt.dev.team@gmail.com?part=3D1
