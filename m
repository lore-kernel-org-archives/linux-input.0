Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFC3D8131;
	Thu, 19 Mar 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932483; cv=none; b=dD3XdsOyuxDDY+2JAFz0yhL/PJOyB+MbUjYdhzQM+V1FeQqya8Dcq8covF1e09yDl+mLsyGI0znuSwoiFdCZK7MiAm3V+uKvaa0mEvJqkCzjEUKEaR+Preh7snKc4jpiHfyAPia14+miDhopjPlTvZIHlSwprNiHo1p/Eamh63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932483; c=relaxed/simple;
	bh=Jbl4h7EyS3qPXNKnUxxzVBqe4EY5cH12TK/UrsUq6O4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j7HoEMF7fdaMFCfpp5PZqUa1kATk3dWY+Z/NNp0X796aF7ZTUOcVfU9Qiagl3W0GYvZ/C5N78LKgzpEU6gaudbIS5NgKYFeM23jmen2A8CyAtIlexPEyQ6ZWdMr5Kez8Fha2B5efuMZ+JnMy1LweHQkurI75KBcp1aQz9s/SJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK71JIEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK71JIEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8123BC19424;
	Thu, 19 Mar 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932482;
	bh=Jbl4h7EyS3qPXNKnUxxzVBqe4EY5cH12TK/UrsUq6O4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jK71JIEXp2WMI3m8bAQq3u9SN/366CdtcK1n1IuptDT8k0X9c8BOvw7IBFZUV56Gl
	 ThjNgR6FdYw3ku5WL600D94vrQykjN/2jPqgo77kgjBaFciosxlgN/aXnCpBHLRjWq
	 kGFUGcWA1T2SB/VmFD13ldxIn4fajsrIE77i3aZc3idu96L0Gklc2mBFyxrEOWnCRX
	 SxvhaUVeBCcatwEgebfjWR2pPtJrZ3ITcb7rJ3jUaTm7PzYoGGnmQUT18lkzhKiAY8
	 Sz9bkUBQwdJ0riME1To9/YuJgNy66KbR89N43zU4zkIcQbB33N/WBKAJauabpNYltk
	 TzwVpW8GIzNgw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, Lucas Zampieri <lcasmz54@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 linux-pm@vger.kernel.org
In-Reply-To: <20260314010533.110278-1-lcasmz54@gmail.com>
References: <20260314010533.110278-1-lcasmz54@gmail.com>
Subject: Re: [PATCH v7 0/3] HID: Add support for multiple batteries per
 device
Message-Id: <177393246035.125995.2162038231287893815.b4-ty@kernel.org>
Date: Thu, 19 Mar 2026 16:01:00 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 14 Mar 2026 01:05:27 +0000, Lucas Zampieri wrote:
> This series adds support for HID devices with multiple batteries.
> 
> Currently, the HID battery reporting subsystem only supports one battery per
> device. There are several devices with multiple batteries that would benefit
> from this support:
> - Gaming headsets with batteries in both the headset and charging dock
> - Wireless earbuds with per-earbud batteries plus charging case
> - Split keyboards with per-side batteries
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/core-v2), thanks!

[1/3] HID: input: Convert battery code to devm_*
      https://git.kernel.org/hid/hid/c/5a9df498581a
[2/3] HID: input: Introduce struct hid_battery and refactor battery code
      https://git.kernel.org/hid/hid/c/7a3ac62473f2
[3/3] HID: input: Add support for multiple batteries per device
      https://git.kernel.org/hid/hid/c/4a58ae85c3f9

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

