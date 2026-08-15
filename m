Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1532B13F
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807175; cv=none; b=KIxVvI1afdFJdeLkcglaGQpyjiOi96VhSnr099FnKL3I9Tu4DkwNgszGdx3YlLivSIB0VTL05bK4M3rrgdWI2rk3Sn5a5ed+LVYQzPHWFMLRXNt1ze5o1gvadQ8wS4IOlXLrsuNKZWPB8xOR2ms0ma+jMqaK3duKJT3aook6m9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807175; c=relaxed/simple;
	bh=ce3MoDInA8VGW6if8f8/Fl5DlRI7FiX8aH1MFUhEPQI=;
	h=Message-ID:From:To:Cc:Subject; b=QSPv1+OqP9/kh6TW1mmF+u/c22jLDIQZW+Jy8I639LsWAiIH6useI/UdCO1Ein1JKSxLPj45YW+ah9e+NvAz2l+qhiyTcMISMy8xvbWRo7vStnQRbGD0FbkiepPzS4Ae3VInP3Z3dFh+1euoJ8cFcfeuUye5qR86awPR0DqlCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lkq+gimi; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lkq+gimi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786807170; bh=dDsM7R9j//8/j7ajILCgF6dLfCHrpUPp1q13gAvUUFU=;
	h=From:To:Cc:Subject;
	b=lkq+gimitgKOKP25WKGRWDCoOD3RB3tzF+SuP41rvF9QZLPEkWR9R6lDXW3jgRgXh
	 TDW9GuNKXCwnLUu/7aio2wyE99BlwIJw0w+rESkNATpvDpnJTO+Mo6dMW2cx+03GJE
	 D6IhW/45s0myzXw2gqxOQWgDlklHU5chNjJPfNZg=
Received: from [127.0.0.1] ([120.204.213.10])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4DC2B2DF; Sat, 15 Aug 2026 23:19:28 +0800
X-QQ-mid: xmsmtpt1786807168t4bgcnygd
Message-ID: <tencent_DBBAC19E701BEFF670746186D3C6B4CA1D06@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06iLlIb9Y76qw5Ev8Y9rmFRYgqzTVJIsOQBD6Kf1+VuiNEOQJBW7b
	 h90JqKiGHAMEs6JgpJhGKx1YH/cFuVjKymEhAw0wL49NHPNQhJoi+MC//nk53dWcnuDhh77YaYsh
	 mT1evQazbhExOxeB2r4V0r3d9RtpNLNX7LXEK+4PwhIeP6VTtIHu7mbbenVzf/X6jhQfLqqx6DGE
	 H1mzmWtDWhCjt9ji1nsBxcO2m9QsEGoddaghwHkRzFRc1lYAsPBV4aTJMnV50Ghh5af8L8JczH/a
	 gNXN5IULaTFbpxbNZUyI9mOwtv0Vh89QwmGi97Lr5DHU7QUwjpiSr1kJMZF2NVCSV9IEXLWHA0Dx
	 7IeOF2fSoiQ6lBggEFXLNyBhbh6j/vnb7Bfc611vrQSTgtfmNKkLPoDiOe6gcbOVD/5ycLFnazNS
	 Jxt22oOGsvyhyhLWp1VHikjTG1uwT4M6qG84m92O6HyUa/KP0HrxRYJ2li/zUPwgCImp35BYxePT
	 me9+UP0IJ6qeeIM+clWUK3xOr5lFxt7H2A5PZC/vo4c7K0mn5357DO6kK1H2uA2yznWmgV1wvHDO
	 W9CICe/iUYLg9Bsb0n3ly6X5JaKCFWnCEVb/Amp0pN1Fxb+Va3orS6ER1oV0WNw/cQJS0QmHcqnn
	 aq1ORBxpopZWa9kSU38XohSEQvyk2Dvv4sDooKfg6foifVAHdVvOSc3JCO0+iym/XnSyjatkFVe5
	 fvcb64W0ykfehL3R6SYTrbSHr0PFECmYQKIDMYMVpFzwDLP096MSphZydOjeiwieEHdcrRQJYmN+
	 RejyngEODX7HRqUqj9fRCwZOvC61ggH7I8tA2dsMtQb5AjPkwfRx47dox4YY0aQsGrDQWIZ3xhlj
	 ss44PmWWp20F4C/vUi+J1kpL3AT6KmgMop1UAYrXFMowhysWO3u78yemplwsjm2WoORGeKZE/C26
	 gK53QHsPZghXzIctW4k4B6DKDmN7L/gp8sif8H8+4I0G3gSvPERbMMYFDclCEQFFdAdRgkjshRTk
	 vqarVBAaE3E1GH7e6v
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Qiao Ruihao <qiaoruihao20061203@qq.com>
To: linux-input@vger.kernel.org
Cc: even.xu@intel.com, xinpeng.sun@intel.com
Subject: [BUG] intel-quickspi: touchscreen DMA write timeout (Goodix 27C6:012D) on Lenovo YOGA Pro 16 IAH10
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Hello,

The touchscreen on my Lenovo YOGA Pro 16 IAH10 does not work under
Linux. The intel-quickspi driver detects the device, but the
feature-report fetch (GET_REPORT) fails with a TxDMA write timeout,
which makes hid-multitouch fail initialization and fall back to a
generic keyboard, so the screen does not respond to any touch input.

The touchscreen works correctly under Windows 11 on the same hardware.

## Hardware

  - Laptop: Lenovo YOGA Pro 16 IAH10 (MT 83L0)
  - CPU: Intel Arrow Lake-H
  - Touchscreen: Goodix 27C6:012D, connected via Intel THC QuickSPI
  - THC controller: 00:10.0 Digitizer Pen [8086:7749] (rev 03),
    subsystem Lenovo [17aa:3815]

## Software

  - Kernel: 7.0.14-070014-generic
    (also reproduced on 6.19.14-061914-generic)
  - Distro: Ubuntu 22.04.5 LTS

## Problem

At boot the device is detected (reset + device descriptor read
succeed), but then hid-multitouch fails to fetch its feature reports
because every GET_REPORT command sent over TxDMA times out.

## Relevant kernel log

  intel_quickspi 0000:00:10.0: Can't find wake GPIO resource
  ACPI: \_SB.PC00.THC0._RST: Excess arguments - Caller passed 1, ACPI requires 0
  input: quickspi-hid 27C6:012D Touchscreen as /devices/pci0000:00/0000:00:10.0/0001:27C6:012D.0002/input/input7
  intel_quickspi 0000:00:10.0: Wait Get Report Response timeout, ret:0
  hid-multitouch 0001:27C6:012D.0002: failed to fetch feature 2
  intel_quickspi 0000:00:10.0: timeout for waiting TxDMA completion
  intel_quickspi 0000:00:10.0: DMA write failed, ret = -110
  intel_quickspi 0000:00:10.0: Write GET_REPORT command failed, ret = -110
  hid-multitouch 0001:27C6:012D.0002: failed to fetch feature 3
  hid-multitouch 0001:27C6:012D.0002: input,hidraw1: <UNKNOWN> HID v8.65 Keyboard [quickspi-hid 27C6:012D]

## Analysis

The reset (acpi_tic_reset via _RST) and device-descriptor read
succeed, so the SPI link and interrupt path partially work. The
failure is specific to quickspi_get_report() ->
write_cmd_to_txdma() -> thc_dma_write(): the TxDMA transfer never
completes (write_done is never set, 1s timeout -> -ETIMEDOUT).

I would be happy to provide additional information (full dmesg, ACPI
tables, register dumps) or test patches.

Thanks,
Qiao Ruihao

