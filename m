Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869293;
	b=D0Dki2nwqxx2ir1I82zRhU3ZyrhU4bD65yzlAhSTJi2ppLS8VSOa+8aVeJX+Ka/+IVuU
	 wWIa+ce+wumW6fZp9dkEVSK7fpLQuVnfTj2Gq/MFeGQ/8KyvlLijIfEID74scjyRpt+BH
	 6sXCKASpiPxokwK1c0ZtF1RrMRS7J1R9NbxfBSL9ROhFYXZ/LFfwpNZ3m2B7eQ61kk7FA
	 j43fNXSTYUW9/PVPTSXAQRyiRuh78hn41g0IReOGD+2ll1B8HhPQ9HFmclEys3YTH69cN
	 ErC7LVcIX8LQTq05QGPxgZheZkFrxo8LJwZaXE9HMc+pVOSP9xUHnF6x79dI8bRoX6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869293;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7hLKL0jW9VnknpicZ4GU5PzaIM4jESCiNAB2XEKPe0U=;
	b=zy0Yqh38VebwrAEoNUtTDfIXV9mDw11EDmZnA5Mb00R6RmBvnrhA0+vcW+AJxEGrcKIF
	 Tk6Y5FjwPyOcTRl7q0NMOXTeKVopMaN7j7Ptatd4QgpscjM/PMk8uYGDx6CcCfFYojz49
	 jX+Y6R9KG+RIvUAv9Z5K80vA3pe65fTosWGqu7o0gG7gW1d4k/MZRZfsMTjzc2AbiOGbd
	 ptGwEUGLC/xh6CUf9q69mHTGJ/ybdOsWswMpIat6UpWSLMtc5T1af9we0NWAORjdR1T1T
	 cdix1gLbS79Keipa3kHGkC6owG8k7QpUGUvrKKz9GAhlTjykgcDIcz87pGzFj8WgfhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+axH5p6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BB0F4606A331;
	Thu,  5 Nov 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+axH5p6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 781D71F00A15;
	Thu,  5 Nov 2026 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793869292;
	bh=7hLKL0jW9VnknpicZ4GU5PzaIM4jESCiNAB2XEKPe0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A+axH5p6lyAp5u0NrfWmtfP8lQNzzuUfYqlTWMtvqmz+Cy+Nfz4N7/sGgkRA8I3jk
	 ++QOvs0Ced2TSRJXtZy3BiRaw4L27vobffHTIA3mEvXxtbWk1eusCHhq0hPJ1htMy0
	 +jmoqjVeZ4uppi6SkCmcueplP/m0WIYR77JaH6vb6861/vCFxMJqahyOXqMjssenkk
	 tGWH0AjjsB3QLt92b7clvuX5QlMT/7iQSnsWE/bJm3cmQwAXJY8GyiUJRy7GGU/6+w
	 Om89A9zLHG8Xb9GJonaKdrG2AaSB5LogjkRCvmh2bUiDdXcnZD3SnjlOJo2iqwxkK/
	 Vt7aX+QtxPV8A==
Date: Thu, 5 Nov 2026 10:01:28 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ethan Twardy <ethan.twardy@plexus.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>, 
	Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>, 
	Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v14 0/2] Firmware Support for USB-HID Devices and CP2112
Message-ID: <n2v4cyl2mdmtxml6qqrtz6jqhv6pxpqqkqhwzc7gd22t3dxobo@s3dgflqe3llq>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>

On Wed, May 20, 2026 at 11:13:05AM -0500, Danny Kaehn wrote:
> This patchset allows USB-HID devices to have Firmware bindings through sharing
> the USB fwnode with the HID driver, and adds such a binding and driver
> implementation for the CP2112 USB to SMBus Bridge (which necessitated the
> USB-HID change). This change allows a CP2112 permanently attached in hardware to
> be described in DT and ACPI and interoperate with other drivers.
> 
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
