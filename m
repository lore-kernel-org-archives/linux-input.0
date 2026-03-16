Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED03C345E;
	Mon, 16 Mar 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676837; cv=none; b=jXNG0VXzKLkNp2eIDgrZJ+1znfOFifa8rwKV6JY2uzVcGu8iT4grmkL4tk4bBNSfcgAl533fmZtmjvmJCUn3x+Ya56tghdWJJZqPXFYCa5cTLD57y5+Q6G06teKSXds9TlDmz0fjccngsgUvdglioiFkc3swAF706mEEnbk0UCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676837; c=relaxed/simple;
	bh=IU1MBjH4PTTzqtvtGeMpj6CeXYmu0DgE4Gk5/C2LnrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pl2yh8eJUqeg9TJ+lmSW9iafKyI5MCW23MTjAzFe1DPDV0zMG6/AlPhGosBTxu3vjXgGAfofoecJCpRAtZ6u+mr9UVOZ2J2syzlqmfWWxTyUnyAVu02Yb6LcT4R5Iyftr9CpNbIHdCVMghdmU+Sm+jaD8l0+8SUs65mrIEPzzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxsGrlMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxsGrlMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD40DC2BC9E;
	Mon, 16 Mar 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676837;
	bh=IU1MBjH4PTTzqtvtGeMpj6CeXYmu0DgE4Gk5/C2LnrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oxsGrlMJtN06NL/590oUIrmHsEwpKypVpff6KjlCw3J4DQWeo+1dd03po3gq6BUh1
	 VcixEXexRLtT7h1RUCGdQ0t14/EqhNN+LEQN9a8blph3PJwVWYbFzjhbS8qLUdfs2F
	 ARvESo5mWtdc6JOnWBWtk/Yw6KZ+KcklyE944aXl8Bgr2udbGPC4mLulK1e3/+w0lh
	 E79MutXCh4wvJGal8Bfvq7H2GeC6srpgC3m5+EKyoKR1AULExhH0F1KiL6E1Zm++3U
	 boX+xK9zN5pxUrzuCP2SwECxxq53c8z9+QKV0lBc6FXPCOC2ChJlGuxXkGhsixovKP
	 JnBrFDkYUI6zw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
Subject: Re: (subset) [PATCH 0/4] HID: bpf fixes for 7.0/7.1
Message-Id: <177367679366.2580085.7917002120079974985.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 16:59:53 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 13 Mar 2026 08:40:23 +0100, Benjamin Tissoires wrote:
> This is a series that targets a few HID-BPF issues I discovered or I've
> been reported:
> - first 2 patches should go to for-7.0/upstream-fixes:
>   - 1/4 fixes a compilation issue when HID is not enabled
>   - 2/4 is a nasty bug which allows a HID-BPF to crash the running
>     kernel, so not critical (you need special permissions to load the
>     HID-BPF program), but not great as you don't expect tinkering with
>     HID-BPF would crash
> - last 2 patches are more 7.1 material: basically the LEDs on the
>   keyboards are bypassing HID-BPF, and then that made me realize that
>   the fallback calls in case of an unnumbered report is not correct (and
>   likely unnoticed because I don't think I've seen unnumbered reports on
>   anything else than USB devices)
> 
> [...]

Applied, thanks!

[1/4] selftests/hid: fix compilation when bpf_wq and hid_device are not exported
      commit: 5d4c6c132ea9a967d48890dd03e6a786c060e968
[2/4] HID: bpf: prevent buffer overflow in hid_hw_request
      commit: 2b658c1c442ec1cd9eec5ead98d68662c40fe645

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

