Received: from outbound.st.icloud.com (st-2005a-snip4-11.eps.apple.com [57.103.79.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084C392C21
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611675; cv=none; b=piY89wy2KbygOTMiAsnhXsT1QxOhHmLeLBnYyHw6A0IC5ifQAhVGSLk0HoxSMgdp5asNHCxl39ZE7+WRcgEBA8D4u/dTNYOQndIUwzrdRfw9AJrXhlzwuT4B3zK+ooGJAJ6/XYJrHaGOME9MBBpuk6l48r/jPAEFexPNbD6aB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611675; c=relaxed/simple;
	bh=Omjv0jpOghTrrJBT0v3YTt0fhftJKIaYYeDaAzosvkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OER5UrwLnJO5Kx4YGDM6Lxsdf/uEODz+pAWnL0sSIvcyjq55obAfjrHJmyhCkYuJL1hQ1bq4bgUVJLaORh93J8bOkhwN4yfeBzcnThg5ifVIhvknGX9Q2/tIabwe9g9GTYmdv2tpyY9X0Em170FjwupKdwXTGTqz5Eurl+F+96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=Kd90JjZd; arc=none smtp.client-ip=57.103.79.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="Kd90JjZd"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id 1D002180054F;
	Mon, 24 Aug 2026 22:47:52 +0000 (UTC)
X-ICL-RepId: 01a035f5-6e11-7bbe-9334-676786189d3d
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxCCE0dXgdLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwRPEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXgxDAlMDFxVWTVoCVk0FSgNfAVsKQg1KAVkAXwVeAE8CVA9GA11RHV8BWCtfEU0RUh4ZBldOGQxKHVJWUQVKDFwAaA9dHVgRXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1787611673; x=1790203673; bh=a25Ir+rmVbBttW2H7mi/I3R5kWzfr+fuX8cCxTOlKgM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Kd90JjZdpGPisGrkliBdqy3aPEEIUjrz5dnRM+ANcpLzAIZm2vsYLndK027bYa1QUiP1bzrlSzs9DaXazt5r+7aiyzVz37FvJnoi/qKy2TZ0WXsLFXGxRb610v/uTqu4XdXuCV4QWNwSJnwnpmscvpR/EYhdicrZe3K9pkXvgFx0WdIuFWAiSM2fmIsqTO8KSgXfpVKTcJRKb1Ic3yB5KKfKa3uJP9QfyvCQ1cDUC/5/V5Zigls2PwTk+2xeJS5VO4w/XjH6H+PemAjZlhBA2cMSBOgHB30SbBiZ2cWQwD3aLDO5o9bpts0zppE6HiPFmBDjr/7vwWY9U/sIBMGrpw==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id 6B79218002F4;
	Mon, 24 Aug 2026 22:47:50 +0000 (UTC)
From: =?UTF-8?q?Mati=CC=81as=20Marti=CC=81nez?= <hello@matias.me>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Mon, 24 Aug 2026 18:47:47 -0400
Message-ID: <20260824224747.97198-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824220125.297EE1F000E9@smtp.kernel.org>
References: <20260824220125.297EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE5MyBTYWx0ZWRfX2VSUKrI0BCQw
 pmL/U5z+o2EzTETLPp/FOLL9UpB/8oy6Ixo1cuLyyi+pd0DwCtuLlwbcOzSk2Sxg9/OPvql8RAS
 Yxc08ZXJNgq1VxcIA9QNfEJUm+HmfkIks+aJpCqdyNqqKVSzGiroTwUA4ZfJKTchrNGDFl2lLSC
 FC6LA8xZevkiOJyrw5kmEG7HK9VdHJYMyKWAYtjHInoV8MQ5i+iLHS4iSgQDgHHDBvxI8fwnQE2
 Y7yWaqHGdc3fcYc2RT50aN13njM89Fz8iF52dR92GMArUBD5a7rxzEFaC8/D7gr2dc06886SXhQ
 BwvY5y4UFHFRtoEtkL7gaCn9NDelB9z91YBIhoyXT/8ztyFpksY+KZuQ0JjaZo=
X-Proofpoint-GUID: HKgmBi0Cu_Y91eDhAL3Gt2S1nTvlTb86
X-Authority-Info-Out: v=2.4 cv=WN1yn3sR c=1 sm=1 tr=0 ts=6a8cca18
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=F5biEvtkEkjsOq9xf6oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HKgmBi0Cu_Y91eDhAL3Gt2S1nTvlTb86
X-JNJ: AAAAAAAB1gZCxT4pnBwNd4m8WEe5PHfGbk3qM7ryv9/x+3ROWStxSLvaqgdyWHAoMvoFdLP96Lpi0VEGcC5kY2t2VmcbVkfwFFEDvUlQgdKeHaBNNCPREg+G+VvakLw6uOTJGkCKLT4BFMp8vQFsrdnIaPGqdZHyjJOsRMq3UDPY/q6MyFLJMLm+caHbXfnB+/LyKnDu7MMEIDis3b4gnl7KRGMztiLtL2PDSytmTMDq+33MP8/35ah3WMv0gOqc+yQ1hqrV4clvh5eJI0uDMbxyVnt+TT9+5nZ4W3FOTSeQcdQFQxlK2P2p1d6bpaRe7bNkBUpYGxbG7vsb9wvamC3FIwamQuAanIwASfpYssTJw+bsshudoTiaYlT28jU2+W1meCx1Kk1kMfZtUtSptCmd6s+dRoaYR6JS4rG5kEAZZGvFvX2KMBfNORl/nr66W5j1hTofFcMKD+sRiYmZK4UpVt+4ryG/bQ3l6ATW7YbzV0+kSdnXdOnqaT5W4lyRvS+KDn7LK6Fn117N9BI6SHsn0U9rhGw1dxAtwZ3qcXk2jMjIAhjOhcfGb7EbOnKqbjl/1kz/eE1vUaJL3TYQbbKZYPmOfx+0g3FS+DllLJoxgMaa5k5HiBJWsPvpYyx/szBqeiZDny0GUgzaGimtsiHjRAtKeLgiNdbAJx9uoYNtoFwKb5WRwo65ki5MY5eLLtUHMguNnnVeppRlbQz6TjACygDhHAlhnZliL0x8y3jHsTKi3AzXF/Y9J5p65B6TN3/lvcIvznZ7DEC0oAoMuWb5hiGHq4F41Dn8tXUF466IlEN6RHKNMIbbqbe2zQ7UyN699abApKbNaamoG5mUHva2cXhPTLnNrIA/NCIUnFSiDcC/tYKBmw2VM45b+70LplBTeWyhjPMUglUXbGIDOcxRRrMij/DcPkLbjydY/K2jdo1uhfmKJJ3HJCaRnCvcEyeKjRZssdAcBtntkdT7N5VO0paECLp
 jSwOSbelTj7lmjn+vSTQxnqBLf8e/daFElX1DLyFiHOcgqWgykusncmuR6Pk5kbk6WDHUhiIICL4Mn8wUknB5WUg36khHFG7cKNDpHOe3zNXcxepwOm+sLFN38jzx884VKF9en/nXbBI5FE5HQx3lC+yURXyPHs/MbUMkaDtLlcynll0cdtlJ1qeMHrXm6GQ39qgyAJUODU1hkEuQOCK51NkgJPSIaueyvNXLIAmnnDkX9laoAJ7OsRvB2fq5ZQBDlAroEdtbEeBXE+5XgUWD0PlNPFkUNSzj300BUmxKkO5+TQy+b1xdSojuqYr2NTeIIvyEIMg0hvuakqWPMI39HYeWsg==

Addressing the four findings for the humans on the thread — the bot
went two for four:

- The devres ordering issue is real, and understated: any brightness
  write racing a driver unbind could queue LED work that runs after
  hid_hw_stop() and after devres frees the driver data. I reproduced
  memory corruption by unbinding under a brightness-write loop, and
  the window is reachable in normal use (the controller power-cycles
  on resume and on module eject while userspace may be writing the
  LED). v2 registers the LED without devm, unregisters it first in
  remove, and flushes set_brightness_work again once the sysfs node
  is provably gone — a store can requeue it between the flush inside
  led_classdev_unregister() and the device_unregister() that follows.

- The eject-loop stall on unplug is real too. v2 aborts on fatal
  transport errors and only keeps polling on timeouts.

- The maxcollection finding is not a crash: hid_open_report()
  zero-allocates the collection array, so a descriptor with no
  collections reads usage 0 and probe returns -ENODEV. v2 adds an
  explicit maxcollection check anyway, as it states the intent
  better.

- The stale-reply race cannot cross commands: replies are matched on
  the echoed subcommand byte, so a late reply can only complete a
  retry of the same command, and those are interchangeable snapshots
  milliseconds apart. v2 documents this in aya3_raw_event().

All of the above is in v2, along with Antheas's review items.

Matías
