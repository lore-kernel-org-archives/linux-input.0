Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1572C0F75
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678672; cv=none; b=tQeBOYZvYq9ucvHpUOlUrcTV0b4gabUE3BJMCDgeVM3usMG1eN1limDIT4JMIwnfVJkWqqDPRvcZ+7F7304tTa1pUbK/FNRzS7sR/qKxGfbHxHN+uyQI7rmzCmrQI1RY2MY4TeAyt+x6eBjonbD2x6w51Ci3uhE0G8y1QM2Lpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678672; c=relaxed/simple;
	bh=S7TAaCBfyT6PJkGCZ2CQT3rHLdQWi+Op3g84ncear9M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=swCp5KzsFSHsvQyfPuQMwcTfnfcgNSG1Nc0B8WM1XpIw/T5oWmjd3zitnjGdOCOu772AwDCNZRkomlWhtDm4D9XC2Th89YXH5hQa4ogCGh+rpixcEJQrcBWfxT5Eb+NXrNd6l8akdYAv+mEOnC6GFP1XiKabFdfOthfUoT7JzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/rU6FJv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/rU6FJv"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914c12b9458so104397385a.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779678670; x=1780283470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L1ewu1BojhJLfgZiR0UNvxEti+UmNvL3WdI7IiOYK30=;
        b=T/rU6FJvJbAacTT/F2q77VxUnsYAbTrJzvSVPZ//6cBy4xT6W7eW80RmrcCUGOBSDa
         uCt4Pxkck5QgYy/g+AT3B5CK0mK4j0wvvc1TMTd/OKiwZ2XV/X6KLJ1xMxvdvrtuEWjN
         tuHzj+DGBgUg4xTMXKQc339lANjP3DgFoKhAyfolNIi3Wd/O2kYBoeFAI8CEuGRVGo7J
         sEa5oQGnEpEEa5sttvHwRL4dCGf5Bv2GOs1/vVaBPh6mBb766RzNBuf6EQZ5C5D1500d
         PMD1jxnc+jxIsSnkw+V5rCqtSoiYGMU0zbZnwx6Nj+kBegJma9hgF8Rev1YM1LS47Dgi
         YXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779678670; x=1780283470;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1ewu1BojhJLfgZiR0UNvxEti+UmNvL3WdI7IiOYK30=;
        b=bAJfi42espACS8Wyk4t7IKr5TD55C333Eq7rqi8H/B6Gq98afPX9S5zl2YGaKlBQ3a
         LxNPeh+z6B1FbvJ8bgnXecnJbyyiNPTIV1Mll1GwY7GpN6U+bpksBO1UAsUaxQgtRB2g
         03GjJ3Mqpazhu+YXfagjXbF3wGdhXuuub3sXNrIA1PiKGRaaTIWPmbxV3CPqXQiUQo9L
         xKcM1cmLCclvQFok0LhiU7qn86Xb2vgqADLoNusj9UavlP0jEf4j6jUYSzTX3J2LGhVf
         ywE15xFL6TWm64BQNOFDTdCNQavfohs6eXWDviN7anRCh+UtQE13UJOMO82Gn+I8TIkb
         n7HA==
X-Forwarded-Encrypted: i=1; AFNElJ94z/+8JqpcNVYWv7ofKt4J2aAVyLvBZ9PcxJkIbySlnfT0l9iy+KETQTaBfwHtU6cBTnaMDazMJUIt+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3+blsBg5VrXdcTqIkYpZbFAo4+U+qHhxJMgSEu7pXGmASdWe
	Hoiq0UaFFBEi2Lx72wRIZ7lFXIxITYBQXF43dkwQLTbdnpgAvJHZV1cGsLLiH+1Y
X-Gm-Gg: Acq92OFTs/3Zpnmonhvs3Emq9Rj44hBB5svKPvOU3jOc5GHJ8vDfV3sYIsIT+smDl7n
	rSFF1JHajW0JLLhE4bAaWzloaRP/dmMzVB0Zmb/4zZTr4WZS7gghExZURsNVy1gZKhH0HyUx4bG
	bHEiDVZLIj0WoSGWIoXbycy3pbgGWFcSdJt47Gkq+bqfqTCLv6QMiu/Bh74t4T4U20a4mid4q72
	cReRiKc81WuXfeFHMLF9MfZPauWmbCv6OW6ylWyheZcuncF4HXM7pqAo1LSAoadO39pBrxjc7f8
	PGOjkxl9VqEBaDgtqLArg7P/LwT1gCouLvN7+yLSKnwVyY4B0mKIRJRZvdrnE6FliBr2/AoYP26
	kDG/Eln8Y8PJ2U7GHoby5/+vMFm418K+DET684R43rEQ6YNGIxELZEsJhn8knh777ponRILSDHo
	2B0OZ7szOWvYWSjC0FpWDBOHYLwYXYauXRujKx5Gxpf5ScvEhO9JuP2v3VYl7FFAh0jQOftLoKK
	gIqw+Cn0a3iCdvF3vx4EQ==
X-Received: by 2002:a05:620a:31a6:b0:914:e3dd:17fd with SMTP id af79cd13be357-914e3dd293dmr218181585a.6.1779678670493;
        Sun, 24 May 2026 20:11:10 -0700 (PDT)
Received: from ehlo.thunderbird.net ([172.59.187.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914c217cf69sm786921985a.24.2026.05.24.20.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 20:11:10 -0700 (PDT)
Date: Mon, 25 May 2026 12:11:08 +0900
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bentiss@kernel.org,
 jikos@kernel.org
Subject: Re: [PATCH v9 1/4] HID: hid-msi: Add MSI Claw configuration driver
User-Agent: Thunderbird for Android
In-Reply-To: <20260525023712.E1C131F000E9@smtp.kernel.org>
References: <20260525020543.519082-2-derekjohn.clark@gmail.com> <20260525023712.E1C131F000E9@smtp.kernel.org>
Message-ID: <96119A63-AD73-44F3-9E24-904093EFB8AF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 25, 2026 11:37:12 AM GMT+09:00, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>- [Medium] Mixing goto-based error handling with scope-based cleanups (__=
free, guard) in claw_hw_output_report=2E
>--
>
>commit 279964e3a8cf0a3835903d6bad7357f0ca42f523
>Author: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>
>HID: hid-msi: Add MSI Claw configuration driver
>
>This commit adds a configuration HID driver for the MSI Claw series of
>handheld PCs=2E It introduces the initial driver outline and attributes f=
or
>changing gamepad mode, M-key behavior, and resetting the device=2E It als=
o
>adds a completion bypass when the timeout is 0 to handle USB disconnects
>gracefully=2E
>
>> diff --git a/drivers/hid/hid-msi=2Ec b/drivers/hid/hid-msi=2Ec
>> new file mode 100644
>> index 0000000000000=2E=2E3a176f44f2c43
>> --- /dev/null
>> +++ b/drivers/hid/hid-msi=2Ec
>
>[ =2E=2E=2E ]
>
>> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8=
 *data,
>> +				 size_t len, unsigned int timeout)
>> +{
>> +	unsigned char *dmabuf __free(kfree) =3D NULL;
>
>[ =2E=2E=2E ]
>
>> +	guard(mutex)(&drvdata->cfg_mutex);
>
>[ =2E=2E=2E ]
>
>> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
>> +	if (ret < 0)
>> +		goto err_clear_state;
>
>[Severity: Medium]
Hi robot,

Interesting that this same issue was Severity: Low in v8=2E=2E=2E

>Is it intended to mix scope-based cleanups with goto statements in this
>function? The subsystem guidelines recommend either converting all resour=
ces
>that need a goto cleanup to scope-based cleanups, or converting none of t=
hem=2E
>Mixing __free() and guard() declarations with goto-based error handling i=
n the
>same function can create confusing ownership semantics=2E
>

The goto's don't return early or break in/out of guarded sections=2E It si=
mply skips waiting for the completion if there was an error sending the pay=
load=2E Using this goto removes the need for 8 lines of duplicated code and=
 the use of cmd_lock in 2 additional places=2E Unless Jiri or Benjamin spec=
ifically ask for it I don't intend to change this=2E

- Derek

>> +
>> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
>> +	if (ret)
>> +		goto err_clear_state;
>> +
>> +	if (timeout) {
>> +		ret =3D wait_for_completion_interruptible_timeout(&drvdata->send_cmd=
_complete,
>> +								msecs_to_jiffies(timeout));
>> +
>> +		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
>> +		ret =3D ret > 0 ? drvdata->cmd_status : ret ?: -EBUSY;
>> +	}
>> +
>> +err_clear_state:
>> +	if (timeout) {
>> +		guard(spinlock_irqsave)(&drvdata->cmd_lock);
>> +		drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
>> +		drvdata->waiting_for_ack =3D false;
>> +	}
>> +
>> +	return ret;
>> +}
>

