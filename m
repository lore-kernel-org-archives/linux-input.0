Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DC2F8EB2
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844357; cv=none; b=DL7Z94mVqO4DtRsn634Eb5lFlqlDV8Ubqx3vAQXf9wd/QPzzmuwXiGMkOf0Ni403iRhaZC6Qi8K/7i4MKECdO5r4aZaE8PqyJJ0CEGGKuRNPYEDF6GkpqzHaQHV4XSEqCSmNOmgLszCmbml8TvenTJHNS3QNHKfkoZvVJJm737Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844357; c=relaxed/simple;
	bh=MTdKI+qSU2S1gzH85u4yMWn1TcEJ83oMMMI1SPSAYHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TAIoqMFM333+ESVXMxDlzyGzPZ9JikO3XMNuZquB7hS7+1wmvtAKZB21lzElRcv2qNPZcy3/TM7JdXlPUZS2bA+bU6UeAr/Z7AiLeEIsh0A+Dg4+GlCrpSdKozIk7MdY8S0zTc2IbHIc6dWWhy0IHkXG/0RZDNkiAtbFNPVUq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=NAofqzG7; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="NAofqzG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779844354;
 bh=FPt1eWkrMSBT/E1sSHPRGUWsgazpOHI7E7CXkjVEzVI=;
 b=NAofqzG7KIZkvlntcZdgk4/kLUBCH9QokInGLjEw26tH9t5g++X5UglIoB4Hc/GyimIqf+MGz
 Y4m0dakqpbaleq1cn/mxCKhS1cPHSOD7kCpYUMeRMtKosuHG02ItA9seKYulDG8apg9IxvryZlN
 YhCuuP5O/BPx/6XZVf3N3PaV+tqNaPr7ZxK72ZWcEnFtSCg7PZQULwJXKUouSW0peH5hPemjJLQ
 mZIytoaVRXA7Rwh55v/5GZq7bqTvYf9tx5xk6AQ54BrU5oK09na2O/wXf8wJZIvtq2vTIyUhjzB
 Jv0Z9Jmzixe6n92JIeidE2CE+3lFOYd9x5ayFxIEJNQA==
X-Forward-Email-ID: 6a1644ff71ef648d15813d17
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Tue, 26 May 2026 21:12:30 -0400
Message-Id: <DIT25YW25J0G.1SUDB22TA0IKS@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Hector Zelaya" <hector@hectorzelaya.dev>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Daniel J.
 Ogorchock" <djogorchock@gmail.com>
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: nintendo: add support for HORI Wireless Switch Pad
X-Mailer: aerc 0.21.0
References: <20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev>
In-Reply-To: <20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev>

On Tue May 26, 2026 at 1:08 PM EDT, Hector Zelaya wrote:
> Add support for the HORI Wireless Switch Pad (vendor 0x0f0d, product
> 0x00f6), a licensed third-party Nintendo Switch Pro Controller.
>
> The controller reports controller type 0x06 (vs 0x03 for first-party
> Pro Controllers) and has the following quirks:
>
>  - SPI flash calibration data is incompatible; use default stick
>    calibration values instead.
>  - X and Y button bits are swapped compared to first-party controllers;
>    add a dedicated button mapping table.
>  - Rumble and IMU enable may timeout (no vibration motor in hardware);
>    treat as non-fatal for licensed controllers.
>
> Tested over Bluetooth on NixOS with kernel 7.0.5 and 7.0.10:
>  - All 14 buttons map correctly
>  - Player LED sets on connect
>  - Sticks report correctly with default calibration
>  - IMU/gyro data streams at 60Hz
>  - D-pad reports on ABS_HAT0X/HAT0Y
>
> Device information:
>   Bluetooth name: Lic Pro Controller
>   Bluetooth HID:  0005:0F0D:00F6
>
> Assisted-by: Kiro:Auto [Amazon Kiro IDE]
> Signed-off-by: Hector Zelaya <hector@hectorzelaya.dev>
> ---

Looks fine.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
