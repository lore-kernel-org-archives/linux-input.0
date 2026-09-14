Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB129350A18;
	Mon, 14 Sep 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402034; cv=none; b=aL9NIYOFI8UdwL/bUUMj0zdtsV1AGizXHho/aLnsScFcc/Zw5C25gIW1ZP5NZtyn+otCDEP4j/uvRL4DDDgJZk+QjUC8QiCBq+6Bms42OZXgUlg728ewqi0s6xsazifEjs+cd6dewItgIYPW5AtS50vuM/218nbwgZ2wPx9zFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402034; c=relaxed/simple;
	bh=vgKW9rgTL+9UMSdMBxxkc2hcCLyFiJB6jL5GNnLl0PU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lU4RbQ1OFDZqBaBUFALv85vJELUnacdAlTpuSnmMLZi4P0QD8IVhM8wLL+iwf+lu2972dcuV1IEO2+SIQn8iRjuGK6VPaaX/tJDxQdE9bE31ihSBkpOLdfDnVmlToh8uzL1OsjrydlGHKIdaSQ+8Mems66li4OTUIDg1rn8PCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjgIHEOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjgIHEOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D3F1F000FF;
	Mon, 14 Sep 2026 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789402032;
	bh=HYTCr1rH3dREyZMV0GLr2OtSHAaQdVWtBmgVmB/JcH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JjgIHEOELFA+cm1bNOl70cJfx/bGXlglLPUkC5ncewFqBqyQLWj4ZJ7yFEG6Ydp7K
	 oIck+WD5E2HStPHiii1fazmfmXrr8mIwX79x685fFgYhvEE58s44iJj3bzd5HXJeVd
	 Y0SXkrco9bdimraoNUzvRMU17PKleK+wrwaQdq2SWTzWBClPqyGZWutBPWRQfFqLT6
	 Izjd+qgt1HJIAVpbIg9gYp2d3PCBn76Y+ssaLhMQDVpcjtHwSjrSehPrRvGxdZGiGQ
	 +3ncm8xTJaOpF9/2B2nL2GVF9H4NCWp4IaSo5a0LfGfhqWQIeuYoJ6N8Q5jPSBvWKO
	 w4rLndXKwJXFg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
Subject: Re: [PATCH 0/3] HID: bpf: fix __hid_bpf_hw_check_params report
 length computation
Message-Id: <178940203087.404209.12218684192951986814.b4-ty@b4>
Date: Mon, 14 Sep 2026 18:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 04 Sep 2026 14:52:58 +0200, Benjamin Tissoires wrote:
> While playing with hid_bpf_hw_output_report() on a device without report
> IDs, I realized I wasn't able to send proper reports to the USB
> endpoint.
> 
> This is because the __hid_bpf_hw_check_params() check wasn't taking into
> account the report ID reserved space, and it was trimming down one
> element in the report.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/3] selftests/hid: add define for commonly used buf size
      https://git.kernel.org/hid/hid/c/9d1e523b92d8
[2/3] HID: bpf: fix __hid_bpf_hw_check_params report length
      https://git.kernel.org/hid/hid/c/c4afa4862b87
[3/3] selftests/hid: add unnumbered variant to the hid_bpf tests
      https://git.kernel.org/hid/hid/c/b6f69097c827

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

