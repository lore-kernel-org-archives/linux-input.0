Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C34A3874;
	Fri, 11 Sep 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144267; cv=none; b=TB8nqn4uVe947V79CXP9xbVdm/lx0Bd06MI96PhEh8RTxkcab8OKJGBcCvQ45lDVv7/vVDhvmOJIChFoZXrEzHQVIjZ3OqJdlOqr/e7g+aWz35TFyusxobMLN+ZIMJ2P6h4WqgX42XLvF5pkWCn1+nXEzpFjsXHBYrmIkNSZ/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144267; c=relaxed/simple;
	bh=BlQC9Qcsp3rZ9TzotUw73e4ZVErNEZzbQUuvQP0WSPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I/6WipiGVPZ5+WOx2jOzJz4IwQIx+5PalUZX5qORddpMvBr8gxXK8wUlDCce48Oh6bl4yj+TGV+yKE4oBe/BL/Xg1P5dLy8oQq1mX69FbcNo1b8tpDd2XkamJTjRCgNDjZ5bYEj0wX6AtTkiQuEi7kQZkgb2u6ubzvPb0GZpWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESBG+YNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESBG+YNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9551F000FF;
	Fri, 11 Sep 2026 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144266;
	bh=TXHjAPO4ki49xaGycG4mlYKTXaKXIGZou8mNbZ9rst0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ESBG+YNwvBfO6E/s3ggm+M1pmr9KZoiA7kMHNcAbDYVJXQhgHVdGVWJo95oroHAOu
	 z+z7nfs0Svs0S7L0Nk8sGay4PdnN91SfnadfwXIxN2dI6bd0rjZPBqE3/wlx84cY2R
	 kVrDZIQ1MK2SSOd1TsX0XKFZLUEvdNf6QlBMPpswOBhxI72yefGIBZ/etsZI7cVcxa
	 8aYllxfirt99K8VBE/3DhwvqKpaFNSNH5FWIwrNc/4L+ZSPGLN6/a5e8iFhfAnUE8Q
	 5qJhIRmQjNKrOQdUJfwgLzbrPyrf+AajR4BNPnR9Bqa4/8woTWTFJNED2yqHuD2OaJ
	 l79M81BrQf/jw==
Date: Fri, 11 Sep 2026 18:31:03 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Berke Durak <berke.durak@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elecom: Add support for ELECOM M-XT4DRBK (018E)
In-Reply-To: <20260907184719.25042-1-berke.durak@gmail.com>
Message-ID: <1p66q195-4nr8-606n-221o-20p88psrs1sn@xreary.bet>
References: <20260907184719.25042-1-berke.durak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 7 Sep 2026, Berke Durak wrote:

> The 2025 revision of the left-handed EX-G wireless trackball
> (M-XT4DRBK-G) reports USB ID 056e:018e instead of 056e:00fd. Its report
> descriptor declares an 8-bit button field (Report Count 8) but only five
> usages (Usage Maximum 5), so the sixth (Fn) button ends up as a
> duplicate of button 5 and is unusable.
> 
> The report descriptor has the same layout as the M-XT3DRBK 018C
> (button usage maximum at offset 16, button report count at 22, button
> report size at 24, padding report size at 30), so reuse that fixup.
> 
> Rename the existing M_XT4DRBK define to M_XT4DRBK_00FD to match the
> convention used for the other EX-G revisions.
> 
> Tested on a Raspberry Pi 5 with the same fixup in an         
> out-of-tree module on 6.12 (6.12.96+rpt-rpi-2712);
> all six buttons are reported after the fix, and they
> work (tested with xev as well).
> 
> Report descriptor as sent by the device, pre-fix (056e:018e,
> 215 bytes):
> 
>  05 01 09 02 A1 01 09 01 A1 00 85 01 05 09 19 01
>  29 05 15 00 25 01 95 08 75 01 81 02 95 01 75 00
>  81 01 05 01 09 30 09 31 16 00 80 26 FF 7F 75 10
>  95 02 81 06 C0 A1 00 05 01 09 38 15 81 25 7F 75
>  08 95 01 81 06 C0 A1 00 05 0C 0A 38 02 95 01 75
>  08 15 81 25 7F 81 06 C0 C0 06 01 FF 09 00 A1 01
>  85 02 09 00 15 00 26 FF 00 75 08 95 07 81 02 C0
>  05 0C 09 01 A1 01 85 05 15 00 26 3C 02 19 00 2A
>  3C 02 75 10 95 01 81 00 C0 05 01 09 80 A1 01 85
>  03 19 81 29 83 15 00 25 01 95 03 75 01 81 02 95
>  01 75 05 81 01 C0 06 BC FF 09 88 A1 01 85 04 95
>  01 75 08 15 00 26 FF 00 19 00 2A FF 00 81 00 C0
>  06 02 FF 09 02 A1 01 85 06 09 02 15 00 26 FF 00
>  75 08 95 07 B1 02 C0
> 
> Assisted-by: LLM
> Signed-off-by: Berke Durak <berke.durak@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

