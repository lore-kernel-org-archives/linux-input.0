Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324436;
	b=yi9fjYiNvn5fNy/Hiv11XmtIflHDVGRn0B+MY/WspHCbOU0EETY8RkZOfHL9OnI1/Tqv
	 ooA4YiDF757j6C08XoCRJA5PYUw6YnQFDONLpYENtyQNcqlCsBhmkguwpPo63jxPJmnaS
	 oJ3GQui+J3krEnJ9F4AGsrpHkf8Mta632kLtpG031HhP4NQU+/PyGt7FlxzmcMmYvs0+0
	 UXwW4f9XafKbFaRHqj2N0juNRYXzRgF8ShC7ZijCmpZKEUntLGENbmku/DuZZo1LgKxKw
	 oeb2ecbtvlc2DuwXRhVtTu3cjrGSeHcxTUWUlBwf0vSAkYzkcab0TDJ3qYKsGzKjYew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324436;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/QrJTXR+9tGdWyJeoCL5ze/rHmBkcQAMi7mOI8oYCYI=;
	b=JRdqp0IkMTifhIH5l5UgvmqSOUYtLU/qq+4VAv8XJLbX3osQktIfvXEFvrwPIUfhnlwI
	 OvLBjkMmyXI4XC3lyUc2NccMqTh5GP02V9IPdjYrdlfRIkMzqIZt3FOtYrrRHawW5eROd
	 oY6QHz6e0IXYYHGHawSc7Z6/2NyxAQq3Y7uqg/o7Zm5u3X7LGSC0cS3MWc9PIqZ+AokJu
	 3ou42K5m2eC/cQ2PCinbVCrdpzq4qMFyS5nWwys26qZuaTUkylVB3YP4dnX5GJ8Fnr677
	 312R3Gqi6qrndV88H3BFYOQOJ3DjmkrdY23mdwDXltxoCJXdmz7E6SFtN+W+cTu9Wrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGAdWzJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23609606A682;
	Sun, 22 Nov 2026 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGAdWzJH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324436;
	b=jgW6V82QJKvVsEe+gecp+TfojTTgpg1CLRQSbQhqh3mfClhyY7cBpiapvlQmNLd6o2iE
	 Esxre8m1vdI0rksgwpYMj5TUXAByDmxoYH9T4FQRAX3EVNwtvcXZUFe9zdtDMa17g9hk+
	 exG0wevMUa9jkh2YoW+y7PeYeZ7E93jhZG+LKGtdPCvbk8fujZykd7AYPoyrsrcPqGMh/
	 Wnr+CSEsRZzvqa+whOZGWPoqs1YsZAvJ+DAlNXPCo/koy2bIFMjQ6Lh5zzL229x6DVtAC
	 SVEPiuQ/uV3BKYxnvF3SezHujhyjlZT7TbwKgddQZ3IMVW6Zm02k3gONbwKsLgDUing==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324436;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/QrJTXR+9tGdWyJeoCL5ze/rHmBkcQAMi7mOI8oYCYI=;
	b=BZWkpMeg4kdA/PDGJ9BFjxE2cgd/mqZGEL6Ln7K+SyfqvzUiDg610A9fW+oSe7GzOCWC
	 QTolTK9YgQk59Hz30hPPy2AHqI3zWxqf9TjuJ4/P88wtoonFAfu50JhhrgBCtdSHIovgS
	 IL+0GtiPePF4p/6LWJEnakgAVJlmAFoIk5DvfgKe6WY1XFIZMRStRE7uL7JN8dGg08kz0
	 WEVIlAq6zTL5rQjCNx2h99smRIhzg3zg48ZbDk6xEiRIxtZ7AZOzRTRefd+xwNK2zypVt
	 O8WOhly1tbMCVJQsRR3V5bdV2KHnCQcPhsdHojg0CvK4GKWQCqx+PVktSYMooHUI8bA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A0B301F000E0;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324436;
	bh=/QrJTXR+9tGdWyJeoCL5ze/rHmBkcQAMi7mOI8oYCYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RGAdWzJH7f7noEDdtliIQfd4XUVEFu+XjLnWRCGUp0Qx70MmBTgpAdKLU/e0Ez2JR
	 9DpOZnoT/iC244Aq+E+pMYBmoL5s5zG4GUmPleq6Lfl3BrQq5RQ9JBn756oUMmDvcN
	 iT+Rpabt9I0VHbDxYjcgzHKDW1eGUFEBp7Olkx8900De7XBLwJA2EjsKtVKv7ec62x
	 +hIKyCZqpV80OYxOcYnA1gcJbtIleKN1Ru+SJ6fNRWdGoCKiD8AeYr4AkwuJfA4c+o
	 hMZmZrCpMC4lghDGVVeweoM75h4sZS8ogIDjHgYe2FFPA0tKoWL0tIgShmX/LVCjgc
	 Tl7ueKnnOmCbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 319644BF5C;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:13:52 +0000
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-oneplus: Mark the touchscreen
 as a wakeup source
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-rmi4-wakeup-v1-3-1b662be4a9d6@enser.io>
References: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
In-Reply-To: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Abel Vesa <abelvesa@kernel.org>, Casey Connolly <casey.connolly@linaro.org>, 
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324430; l=1595;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=BkQi/aNaLB67MHOxqLW5Gip80XqiKJZrg366Q7Ri004=;
 b=J53g3RH6mgQUU1cTTdsIFH+7zNmEtVWORHfkzsm+AxjYIaboThSB1k48F2OE4wyxbZ24qVK+w
 f03KZuq8B+SBnLvJsXW19NtdD1zXyMLsXmg4sNMiuJF9abQalhPkjjS
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

Without "wakeup-source" the Synaptics touchscreen on the OnePlus 6 and 6T
has no power/wakeup attribute and its attention IRQ is not armed across
system suspend, so a touch (for example double-tap-to-wake) cannot wake
the SoC from s2idle.

Mark it as a wakeup source. The I2C core registers it as a wakeup-capable
device and arms its IRQ for wake.

This needs "Input: synaptics-rmi4 - keep an I2C device that may wake the
system powered". Without it rmi_i2c cuts the touchscreen supplies in
suspend, the attention line falls and every s2idle ends within seconds.

Tested on a OnePlus 6T on v7.4-rc3 with that change:
/sys/bus/i2c/devices/12-0020/power/wakeup reads "enabled". With nothing
touching the phone, "rtcwake -m freeze -s 30" slept the full 30 seconds,
and a double-tap woke it with a 60 second RTC fallback.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Signed-off-by: EMCP333 <emcp@enser.io>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 1df09da3c4..187bd6f45e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -533,6 +533,7 @@ synaptics-rmi4-i2c@20 {
 
 		syna,reset-delay-ms = <200>;
 		syna,startup-delay-ms = <200>;
+		wakeup-source;
 
 		rmi4-f01@1 {
 			reg = <0x01>;

-- 
2.47.3


