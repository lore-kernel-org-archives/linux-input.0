Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F603E7621
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082595; cv=none; b=FrHyILgP+epU+pXrq3q6zN956WWrK8UKyeKn0rk0nEheQous56bfmRmrfyVcSp1nHTNaf5U2ZJJi+cjiminvkXg12obVnPf4IYg6kcuyTrNFt/H1YG9B/NklviNRkrgLp6QNBhVweXOfaulx4WxDO9UaosiOcKzIxGvIUmHpJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082595; c=relaxed/simple;
	bh=gnZst7c728VTDqXJpJjDnfFOgpQczHFjat/u0g26YYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=owU08HEEw2EQ41yoTc3YQtj6xqMapFqkxdpftjNQJFDsFDE++4qKX1mojTG1YOIC5rBdbv2VgOB5ZFXHGNno7ISRO8bg+QLm0rJPMU6VN28e6Lg/wV2EjGlInL7TYFiee3ozYDVo38AorlM3NTWFELq1RMsULI2H5eZ0bWdmFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPvqhGuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPvqhGuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB61F000C6;
	Thu, 15 Oct 2026 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082583;
	bh=CU4l9TmH4mNUxNxeZGZJOzHZvu7RlbNHNPTcffNaKbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QPvqhGuLEGLQOazPWp+qjh4g+ei9/+0hBT2ue00B5GtSL/F4OxDFdDqp7+zaQxq8H
	 tPV8dbKeQKVOnVCVAonVu5LJrUp4lmIshMahkqSwc9yfTyDrichEh36SaUzXx78OsZ
	 RvgmbDvsJWJg0Qan2c8IZ6zSj13kNsHxyS0KvlLJAS9SNo7ra9VvHmTVGJkTJD6Vnv
	 7/uzTyP1/hBZokFR0MmU1ffSACPzt4IM50gOxN0Bb1Czrk/nFXhiJLsNtTSjOZpwcL
	 CioftSZ61/bWeXYftMwhm3+/vYNygIYC9FrSUZG7LFqiTX5b3Znws8Ggy4PCjejhvk
	 EHMYezdlCgqNg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20260929065743.134635-1-dmantipov@yandex.ru>
References: <20260929065743.134635-1-dmantipov@yandex.ru>
Subject: Re: (subset) [PATCH v5 0/3] Latest Roccat HID fixes
Message-Id: <179208258260.807325.12608115657184821547.b4-ty@b4>
Date: Thu, 15 Oct 2026 18:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Tue, 29 Sep 2026 09:57:40 +0300, Dmitry Antipov wrote:
> Now d76994443eed ("HID: roccat: fix locking in roccat_connect() and
> roccat_disconnect()") is landed, and these ones are expected to fix
> https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e and
> https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f.
> 
> Dmitry Antipov (3):
>   HID: roccat: use device_is_registered() to check whether device is available
>   HID: roccat: fix device access in roccat_release()
>   HID: roccat: use kref to manage device instances
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/roccat), thanks!

[2/3] HID: roccat: fix device access in roccat_release()
      https://git.kernel.org/hid/hid/c/b0a42af46363

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

