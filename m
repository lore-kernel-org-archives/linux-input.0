Received: from sonic.asd.mail.yahoo.com (sonic-usea4-0032.asd.mail.yahoo.com [34.2.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E453168EB
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.68.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001452; cv=none; b=ndTYI6BcvCcPMtWSL0yTgvcp3LfhsC8lBxW+pKAyqtJ18Z3R/tFonharNu4K5f7oDW5MEGtnnUlAdOnjCJmZ9yxgXiWu3ssVPYJVWyaqJvWdvVquJ2dRM/3eioAKtNkjylRbb5WcPIKw3AruU4fQ88wVPe6wwZ4/+8RCmmEJg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001452; c=relaxed/simple;
	bh=Iqbkn+W4HxecBLJ/vWovecV9UCvG8fogFD6eVDLp4BA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JqvxQEA1WDmiRb1gwzyPas2trOXquPdAPb3eKIY1G5Mpu3Yb0CL3zXsPd8xKNyicVaDhJmWZ0IfJdoThJydp1RSoCvJFO+SW1PhX98g3ZLWmN2Erln3uxcWPDgVNF3UzGoylwwRI2QHGH5YL1ms8qAXeakZvBPGMj1b/kkfAaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Y/41aGce; arc=none smtp.client-ip=34.2.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y/41aGce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789001448; bh=y6focDPHJMDa8YDAonRSLBAyPNKkbdwfY6RbpsVJVbc=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Y/41aGce4JgcV2tCaJnP2vqvKmXyfh8HdEc6jdezyndQtJvi01QmgxHZQrlzJ2I+Hn6zV8Y4p12Unv5/mnNlKB8MYM94MWzCvBaEI751xBxk0IQPze9qoYzbRjAtVT937xawgsqQc0TBQaYusq7Gp2h4DhB40KpqNgLdK6zrD8W9dcSLFAJ/eynlot7h4MUjvU5wHQS8uyY5APvD4LXvDkKLc1UmaseoQLDC9qyq3C456qkC+ZDvsMXGerW+pzzlFfznufxTMPHEHO52H55DMISurlWhBtzXsxiGGaZpV1aIumRLGCqR2tcyUUb9zKLpsrVfj/Q4Z4jDaX/ymUbozQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789001448; bh=YyJSTaZcmopysaJnF0ClUFttEetYpFrVYSEvntNiGIs=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=aN1R8k3D7fNyljVy2R8X0eEgn5xCwV2mUqe9K/O6FS4Z7PGAHDiBDHlrrYWPqRPYgtNViBBlVoFD+5rbNmX4beP0fIbm/lCR6h9FRrGLnOClKs1vj4xBI4MA1QhpiImjV97yZmDOrXICnc+5ZC/yeQEPc8S3GwaF/uj+1xq4ew5ChITyaConE2+iOGyKXUDGkaEsqIdWKevUPVwJ13cBovp5vC0LJ4c522NYkBOSbU8nZISetVGmZSmGDza1wTVb5KvXKGXGwtMu7PUz6N+WVUd1oSElRsHEj/7qn12j+zy2xldSjNvE//ebt4GD0IwNiY0ZQaYtWsJad+9k6PfEkQ==
X-YMail-OSG: VSD6vY0VM1kINEiY1x5kAGHWN_mcA4xVSFLtgCwvTB7.q_QT2WF.hQH9.x3iPtD
 XEVJmpagMzQ7fhVGe5GjJKn2PXVGCs7pFu8Gh_cO06XuevjTfq4ZQomgnfahzMMibOLhftq8i4ut
 tRxNuI1ubQwsdmTYNMuSVCoeaoU.g2QgQF1EjaSuw6Z0zM1iDZtjVj_LK5P5pI24RZ1KSHMp3_X4
 JXLUnuhUxatmNihGVQaK9MH8oXMfluUPu68SK7Xe.6TLQzZBS2pcbnq7a.vmGSVvCOgOfnu1R20S
 x20eUKC6VUDjj6YySy0nCmNdb8VgRZwdzrI.LVDuI8.w.iwmjSIU1vIxJHG7B5Vfp_HQufXiV3E.
 LjyCpB5OTwD.MrydDqB7hoWocEFnQCr1xUDHwbtvCLlOSpJe_YcHYpMeBYPbaqg7A2oTgOymMlyb
 jeWAIqdrzsetOccqOi3ciXZsUYzqj47b9rti22LXs4JaZ0W5lIEibZF.RMkYM6Sqr3eC8hGLi7u6
 BNRpqIcnG2LmPgBV.0h4V35q.mXhuKHi3ZjnysTVKGXfkByV55yj5OU2aj7OoFp5uRPTGTyq_gfQ
 6ZfYj13HjlcD9rMocGbI_4yggHrngDyxUCRtt1.8hUe58qSIX3.thNp2ZscGBvSRd6t7kNWywG0R
 qU3yJfVON2EY1t_h3Wvu37Kp1TCfM6T55nX3eHrG3r9sq7hFxfNgB60NkWLtgpYfPkhfllcINfF2
 SeI9KBbrVnxpejOs8ksJEUArfVAY1WLydgz1xCC9Mda4R1H5uWmM8xqvxgM3ho.VY8TgSPhKvb8g
 wZHJxLSksXVZhFN5blowvrAQll3yuq91M1xUgyeT0ksTfacQ4bQxnSmzcgDAo7L1jSZrPnnOPyJN
 24NLcFQ.stcdonUWcDn0Xerc0.tAc5RRVR7iUMDTUt0m6jTpDR6e5aMcQNBHZn_WbdtE3.bMVnLM
 QZUUxHTa64F8Fd97.Dcp5C9FL0sMfhL2MjYFQu5teUGK1.MnXvLhIYYaY7.w_JKT4K8Tr3vLmCvf
 79cK4mmHNz.MxHXyO91FHax8W89SYGUNmZWrC9_g52mpYlprAE4PJRJw_Uxyu6XZg_B7Rg07Ymsz
 B3Gx9KdiSpOaVDtrujo1_5Hf3Z8U0GrgWcBLO3aJCNA2fKD.dAAM_Qcmd9QM_Pk.kPOtnhBR66iW
 dTHK2FqD3kH4dBF64P1bm1jkXAllCOHlAMy74P7W4pZfkb73fJvn.ABClK2kOEgfahIqB2h5XJSn
 nUp2yP2lbxf2xbfoRbRjQq8GPvTNvYtdbva9tvwhiTnHdVVx_PvZ86wR.YWDrpdAgpOcTLrXqPTd
 XD9ofzNypffiJqfQXVdPs0ubBtIppfRf9hCw81j9MpHeOAFPUY4V6PI1rBIKCHqiY2ZoXIeUGTgf
 PIkJq9HMr.gN38DsYcggnDpP3La4CPZzWXcfUwk0xxGYqKzHrIAGr6k4OJX6cE4KpvAPzJWTpx._
 x3yx2LZaJ5JOSHWRRazItS8HQ_gE_TDEMBAolmQcUPrwo6q92bVa82KUHvcwbo9Ywd8DJ0rOtlvN
 WUbMdAnvXiX..vhciApYpkrkx1zDXyyCCTBgOy6mLPjOD0Rhjw84etLQL4RZ9goXNfuzFR7IIMbY
 55nPL8GZ6sOhNKge2axFBgLo9t_Ik5wkGpU_QcAEQEp2VqBQXBQ8fLA1JoDMEqKSnfl5qjKW6vRl
 wEI9tPU_r8V.a.5TAHK38UchHfHZjHNkDSW5sKWX6TNqLcNyw9PMIPDDaDkUNP2.C6WALQZGA55K
 d5raJShrq7f44J1F7CMcScCHr2_PzpP84Ewkl84wYRf3mcY5dsEA4m0vYSGXIcoFqRBOma1.OI0d
 tg3VdO7vxXTNUzklRQG.vRmp553JUMqMROqjg2IuMMysCAS8_A9iwJqR3kjFPhP6jbw6NfF4.fpm
 awGub9gx7bXcinT.07iioW_WZhFlbdJHTb_0e1ThMG8OK6d2.21L3A.RAeRtPSJO2PbQFygBauvg
 NXtylPaCXUd55OBwyu7nYqiqU8w4uExGyB545smu1nJopibyn7dcQy3BQ3V12ZxYeYNHwaxG47kq
 JSQmPsn3E2oAP2C8XWWy6gRIJOKNiFjCj_Yzs.iCSgTCvbjYlt4s6w0DPNNtWqOlg8rYTN4OLCAT
 165eO.33insJ1nzNP3xx.9Y.7dwS7S0hwcGy3z4nZBPN2Q6k-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 2d55c225-e714-4319-ae0c-cf72f0bcc512
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea4-prod-sonicconsumer-svc-101 with HTTP; Thu, 10 Sep 2026 00:50:48 +0000
Date: Thu, 10 Sep 2026 00:50:13 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Message-ID: <1293811398.222172.1789001413808@mail.yahoo.com>
In-Reply-To: <20260427-paj7620-v5-v5-0-6f9bbe7b4ce3@yahoo.com>
References: <20260427-paj7620-v5-v5-0-6f9bbe7b4ce3@yahoo.com>
Subject: Re: [PATCH v5 0/2] input: misc: Add PixArt PAJ7620 gesture sensor
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26460 YMailCLDNovation



Hi Dmitry,

Just following up on this patch since it has been a few months. Please let me know if you have any feedback or if I should rebase and resend.

Thanks




On Monday, 27 April 2026 at 12:47:05 am GMT-4, Harpreet Saini via B4 Relay <devnull+sainiharpreet29.yahoo.com@kernel.org> wrote: 





Add support for PixArt PAJ7620 gesture sensor

This series adds support for the PixArt PAJ7620 hand gesture sensor.
The sensor is connected via I2C and supports 9 different gestures. 
The first patch adds the DT bindings, and the second patch adds the 
driver itself.

Changes in v5:
- Added this missing cover letter.
- Included Reviewed-by tag for the bindings patch.
- Linked to previous v4 discussion.
- No functional changes since v4.

Changes in v4:
- In pixart,paj7620.yaml dt-binding file added allOf: with $ref and 
unevaluatedProperties
- No changes in other files
- Link to v4: https://lore.kernel.org/all/20260421041505.4548-2-sainiharpreet29@yahoo.com

Changes in v3:
- Moved sensor power-up and paj7620_init() to input open/close callbacks
- Implemented dynamic keymap support via 'linux,keycodes' DT property
and enabled userspace adjustment via EVIOCSKEYCODE.
- Updated YAML bindings to include mandatory vdd, vbus, and vled
supplies.
- Added gpio-controller properties to YAML for hardware completeness.
- Link to v3: https://lore.kernel.org/all/20260418062241.104697-1-sainiharpreet29@yahoo.com

Changes in v2:
- Moved driver from drivers/iio/light to drivers/input/misc
- Updated DT bindings to include mandatory vdd, vbus, and vled supplies
- Added Runtime PM support with autosuspend logic
- Combined bindings and driver into a single series
- Link to v2: https://lore.kernel.org/all/20260417052527.62535-1-sainiharpreet29@yahoo.com

Changes in v1:
- Initial patch for dt-binding and driver was added to iio/light
subsystem.
- Link to v1: https://lore.kernel.org/all/20260413000308.7618-1-sainiharpreet29@yahoo.com 

Testing:
- Hardware: Raspberry Pi 3
- Method: Verified all hand gestures using 'evtest' to confirm correct
input event reporting.

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>

---
Harpreet Saini (2):
dt-bindings: input: Add PixArt PAJ7620 gesture sensor
input: misc: Add PixArt PAJ7620 gesture sensor driver

.../devicetree/bindings/input/pixart,paj7620.yaml | 84 +++++
.../devicetree/bindings/vendor-prefixes.yaml | 2 +
drivers/input/misc/Kconfig | 12 +
drivers/input/misc/Makefile | 1 +
drivers/input/misc/paj7620.c | 338 +++++++++++++++++++++
5 files changed, 437 insertions(+)
---
base-commit: bf9c95f3eeefb7fc4b4a6380cc23f1dca744e379
change-id: 20260426-paj7620-v5-79ab28a3b2e4

Best regards,
-- 
Harpreet Saini <sainiharpreet29@yahoo.com>


