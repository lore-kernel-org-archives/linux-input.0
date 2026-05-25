Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D727B35F
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678573; cv=none; b=HIk9TMI52wA2/LGY6FNpRDt3WHmwVOjCiyfdev+mPupf68cM4xT/ZIkAF46vQstMI26olS3lqooznLvesreDh0kn4CoJVYzFBYZ8q8iAu/NQPwDp2DFhJD83n8RmRGZg/929mchn0Wb/OG4AwW9o2xZquVij2DvJsGsSuvIhreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678573; c=relaxed/simple;
	bh=dQfr9pwwBn5FMBoNb8GLR971OCe3Jgm8s5KCc7dtd+Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RivOzfbWuQTmU0BKlVT9VE9miCerV4WTSm+sfseOo1ge68XLKWj4CEE596U1GiWmJ+ZDvwoug24u4stXjykuNKNUzNXZVr7dlvawTuXj/ps9FRJ1aNouuIhNclKLhl28khZsvcOAuzhQgyCVSe3FA275l5T6DFUye6ItecLfs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXi64DCU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXi64DCU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91080895355so1061258485a.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779678571; x=1780283371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luq4KZSKcs5iWJVfoXYbkvu99g96tIhuQEM5ma4wHUk=;
        b=gXi64DCUrZfTo4CewvAAZlufqVZ6GVoEaq88iSmfdrpVeFTKCgU/u1mH0tqz7zTk80
         DYEh90zSKyPgcKPG4wskSZsg3ms0zcVMSDd/+RBrEN0ltiN5diLbBT2QnUmTGduPeIFD
         pU6muvtIDtuY9KBDSh10nfy4UaQwkAgur6dN9AKbLnc0sx655Q6MJOrPq1c23UfO0AeA
         orJsflyMa7t/sYIxewiMV88y1itOWTiPg11dMjIIaZRMBlRniG2oGCD1zjKwOkBbIzNl
         RRvt7yGR38Za8sjxDx71s0w5D83USPca7xID2e9WmWmMrRNOLugMX0htaYAqN5OygKOu
         /riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779678571; x=1780283371;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luq4KZSKcs5iWJVfoXYbkvu99g96tIhuQEM5ma4wHUk=;
        b=ixooYDyXwZ4cp7x8EjV9RWu2Dx9aCvJZjT2u1bJ67OQ1UM/n3R2N/ykrFkMS0KqyQh
         Rs+uOdBJ9h/uaGb1yHHvT3ckPNoA59QbCFDIi2MdgPqsf5pgelTHDn/rAaNrBZVQxBLV
         X1yrwReIpez3EF10sLQoZYVy6c3LCKyZ+wYovkXM6X/UAGf47ohPIp3CqOEbULtyo3lv
         4NBnRhA+gH76w/MlQNmP8ScQ5op9cACFEbvQ67T0hrr+c6BKk/o2Fw2nrXH9g9O3GEm0
         n75jzovP4u4JdhsiSndyWHLUVFt19sTUeiswkckfElFDJR9ZXd3KwilNSlUTpktTeNSg
         cEBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/T6ujSkggsYPvPYZUiMN4yuPu04b1Sv6K3FrnzCRRQyzviPLb/TRyrvA/vVH/DnPBFkB555pmDQv2tPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnikZ3a3SbzobdPaczsZOvqaJFq9ktFts7jCAZuo8g4lz+Nic
	750MLhqMgOsoOw/7Ez18zDdkpHh2PBQszQ+eHX6gdfSGilUOoxZP+khQ4JN+eYZH
X-Gm-Gg: Acq92OFCrwQyU/tKXYaCh4x5zjDP2dhecncZ8HGrYkIs+xKNXVsiA3tlG2XfYdPc+qT
	PRoYEJLluuO3UdfrIlPisNwYfz7e5VsL8nuJXOluLO78dhWwVHnmCXrk3TTxYHGLa+ulD6iIuqL
	nfaEn6uxwn3Du82csl7pkX3pIlYHmoehq9bKt2RaMuGX1xH2blaikrdcOcTT0RW+hjo3f0vh4xQ
	+cRS/OPw81WU0/Hachzx6fCrweNO1hWGfiRGUwQ6Aa9kw6oKDMiMhqSSF+S6OjeFUodm0oHwH0P
	AOtXf/8diaZLQeEc4W/ZP8YkIEZYeqP3hKBHRm1gp8UCjW7oyDGTs3cppclC7T/OaRl0cGbTNA1
	uM8UhrBM1xJDt8NiD5kbULrMi3FJa9t+wJqRVPAtVpk5XMKB8TSbIpVKn/3pJH2y7IFY/LAmBMi
	jU1p3on2VxVU30AUwF1Nu8nujNdiZinfcGXoF3RpX6fX2mc2XMivzfyiEk28kFFwOJa1i608i+m
	oHh
X-Received: by 2002:a05:620a:3705:b0:8ef:3de6:c5a9 with SMTP id af79cd13be357-914b49de45bmr1924638585a.47.1779678571003;
        Sun, 24 May 2026 20:09:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([172.59.187.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c7b22sm956906385a.8.2026.05.24.20.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 20:09:30 -0700 (PDT)
Date: Mon, 25 May 2026 12:09:29 +0900
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Manish Khadka <maskmemanish@gmail.com>, linux-input@vger.kernel.org
CC: Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_HID=3A_hid-lenovo-go=3A_cancel?=
 =?US-ASCII?Q?_cfg=5Fsetup_work_in_hid=5Fgo=5Fcfg=5Fremove=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260515153607.76175-1-maskmemanish@gmail.com>
References: <20260515153607.76175-1-maskmemanish@gmail.com>
Message-ID: <2334E850-97B6-40A6-B87A-8427E06AD0DF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 15, 2026 8:36:07 AM PDT, Manish Khadka <maskmemanish@gmail=2Ecom> wr=
ote:
>hid_go_cfg_probe() initialises drvdata=2Ego_cfg_setup and schedules it
>to run 2 ms later:
>
>    INIT_DELAYED_WORK(&drvdata=2Ego_cfg_setup, &cfg_setup);
>    schedule_delayed_work(&drvdata=2Ego_cfg_setup, msecs_to_jiffies(2));
>
>cfg_setup() dereferences drvdata=2Ehdev to issue MCU command requests=2E
>hid_go_cfg_remove() tears down sysfs and stops the HID device, ending
>with hid_set_drvdata(hdev, NULL), but never drains the delayed work=2E
>If the device is unbound within the 2 ms scheduling delay (a probe
>failure rolling back via remove, or a fast rmmod after probe), the
>work fires after hid_set_drvdata(NULL) has cleared the back pointer,
>leaving cfg_setup() with a NULL or stale drvdata=2Ehdev=2E
>
>Mirror the sibling driver hid-lenovo-go-s=2Ec, whose hid_gos_cfg_remove()
>already calls cancel_delayed_work_sync() on its analogous work, and
>drain go_cfg_setup at the top of hid_go_cfg_remove()=2E  The cancel
>must come before guard(mutex)(&drvdata=2Ecfg_mutex) because cfg_setup()
>acquires that mutex; reversing the order would deadlock=2E
>
>Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID=
 Driver")
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Manish Khadka <maskmemanish@gmail=2Ecom>
>---
> drivers/hid/hid-lenovo-go=2Ec | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/hid/hid-lenovo-go=2Ec b/drivers/hid/hid-lenovo-go=2E=
c
>index d4d26c783356=2E=2Eef69869f0a00 100644
>--- a/drivers/hid/hid-lenovo-go=2Ec
>+++ b/drivers/hid/hid-lenovo-go=2Ec
>@@ -2408,6 +2408,13 @@ static int hid_go_cfg_probe(struct hid_device *hde=
v,
>=20
> static void hid_go_cfg_remove(struct hid_device *hdev)
> {
>+	/*
>+	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay;
>+	 * drain it here before tearing down so the workqueue cannot run
>+	 * after hid_set_drvdata(NULL) and dereference a stale drvdata=2Ehdev=
=2E
>+	 */
>+	cancel_delayed_work_sync(&drvdata=2Ego_cfg_setup);
>+
> 	guard(mutex)(&drvdata=2Ecfg_mutex);
> 	sysfs_remove_groups(&hdev->dev=2Ekobj, top_level_attr_groups);
> 	hid_hw_close(hdev);


Looks good=2E=20

Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
