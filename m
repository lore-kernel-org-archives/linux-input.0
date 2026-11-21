Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271038;
	b=m9xgbGKLoNsRkqEJRpDwx5tPJ98FILaut/E92erMQ/4sbOwH/7GTm6flsgxjLORpyPKF
	 f/y6tIMZ2XQcGaU1N44HuVYnqrwp2RYE+a2oXBC3AJi4tGoP7TrHtzXis9RiKPfyGYC09
	 S/MGOM2MuRoOCU/yejul+ASGf2EWpW+mnF6WmzhDHIUROu6EXO0NUU/IKDJVhJ2WrrHpA
	 oxSMtR0L6SAkW2XiGmivRS6Je8VHZ6b8dalLsIYdoLjMJRBbcmL1AVE0oHGJIa+nNf0Pw
	 L/Dji4KEBBPcOwpqgNQYufNqdUtIrAup7wGs9HNmg5lOagHTQ7SXt7a9dUDfoY//ZpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271038;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:MIME-Version:Date:From:To:
	 Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding;
	bh=+sUAU5hrifF8o6xMh6x3c38w168vV46NtJO40QMcVDg=;
	b=O4HreujStox0jYXxMaEVxyZ74P/hs7zf7geHRUi8BdrnnCxCgIe3stYB2DDnbNmUP1zy
	 0pQHaNVrSoaYSOKNgjA61f+XMMfi/46dY2+TN0XfWd9KloGyeoGRVl+b4xSg12cjIY2/7
	 s9NZwKpcexg05uNB9CBbp1icn6TPLQ47gcZA2y8iYPkmgk9DQWh1WKAmYfSgGd1xKk4CJ
	 t1SZbI2+CgCIwb/+2yOgMqlsWxVcndRxmUl7SAMYJLnPEGb/lDd4dUd4X0hrVUp4ry/HC
	 GzSD3bXVAr9A3dmopPKTQOC7+qv/2uSygzpU+teZmZECcd8m3IZ8XNSsw0dRXfGuIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jrBdroR0;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=pQqrsBZN;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DD606A320;
	Sat, 21 Nov 2026 14:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684DD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jrBdroR0;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=pQqrsBZN
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1795271028; bh=+sUAU5hrifF8o6xMh6x3c38
	w168vV46NtJO40QMcVDg=; b=jrBdroR0cFd0g94YeYtz4C8VfhdpsLCAHdBb3Ixv5GlSlTMrTd
	bAyJYPvpOErEDT1UCZOnxulRbcAupwjTx8LSDlykKkwsl7BOQajjNbyNkdCDBOn0HokV0vnpwlF
	Axq1hbihVu6CYS2u5BHIgBO8uwOyyb9zmMrMnUAYFGaqygKWT8pPQOd/T9/+LLVYSX+IxUgraqj
	4SU9Gr1LCT1ihEs10ZZPHyxTscPT08M+IZQd9Q3wgIsSDzAsrPTcSs8kxxXwDmxMjUlkePuS7eJ
	1ddoSAKIGOninjIXJTRXgZ0/HdIxOoHaq+S8UyTUNQUq+MF65YeeO/cnrK4ClvxvFbg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1795271028; bh=+sUAU5hrifF8o6xMh6x3c38
	w168vV46NtJO40QMcVDg=; b=pQqrsBZNfzl2ERRlIL7LxRFCbq+9v5LN3bobxeWU2r1rBBKcxQ
	exX9Gh1Jhwhf6PyDy8zSKWcOE8EPWBtq12DQ==;
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 21 Nov 2026 15:23:48 +0100
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Input: add Synaptics TouchComm I2C touchscreen
 driver and bindings
In-Reply-To: <20260910091405.354058-1-sevanevorotov29@gmail.com>
References: <20260910091405.354058-1-sevanevorotov29@gmail.com>
Message-ID: <8dfccbeec4fe000a857b706bdcc895da@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-10 11:14, Vsevolod Nevorotov wrote:
> This series adds devicetree schema bindings and an input touchscreen
> driver for Synaptics TouchComm (TCM) generation-1 touchscreen 
> controllers
> connected over I2C, such as the Synaptics S3908 found in the OnePlus 
> 9RT.
> 
> The S3908 and compatible generation-1 controllers boot autonomously 
> into
> application mode directly out of their embedded flash memory. The 
> driver
> implements communication using the Synaptics TouchComm packet protocol,
> retrieving device identify information and handling reports through a
> threaded interrupt handler.
> 
> Features supported:
>  - Multi-touch reporting using the input_mt framework (Protocol B)
>  - Dynamic touch report layouts and coordinate/pressure decoding
>  - Standard touchscreen properties (axis swapping/inversion)
>  - Low-power wakeup gestures (double-tap to wake)
>  - System suspend / resume with deep sleep transition
>  - Regulator and reset GPIO lifecycle management
> 
> Changes in v2:
>  - Fixed continued-read chunking in syna_recv_message(): accurately 
> track
>    stream bytes including the trailing 0x5a padding byte, request full
>    64-byte I2C chunks (up to 62 stream bytes), and ensure trailing 
> padding
>    is consumed and verified even for 60-byte aligned payloads.
>  - Clamped active touch object count in syna_parse_touch_report() to
>    ts->max_objects and guarded offset calculations against integer 
> overflow
>    and OOB access in syna_get_bits().
>  - Made regulator power management idempotent with ts->powered flag to
>    prevent unbalanced regulator disable warnings during teardown if
>    hardware recovery fails; power down controller and propagate error 
> code
>    on recovery failure in syna_resume().
>  - Removed touchscreen-size-x / touchscreen-size-y overrides from 
> driver
>    and DT binding example, relying on native resolution reported by
>    controller firmware.
>  - Documented mutex locking contract on syna_exec_command().
>  - Added explanatory comments for ABS_MT_PRESSURE and TOUCH_MAJOR/MINOR
>    default limits.
>  - Sorted TOUCHSCREEN_SYNAPTICS_TCM_I2C alphabetically in Kconfig.
>  - Fixed commit title casing and checkpatch warnings.
> 
> Vsevolod Nevorotov (2):
>   dt-bindings: input: touchscreen: add Synaptics S3908 controller
>   Input: synaptics_tcm_i2c - add Synaptics TouchComm I2C touchscreen
>     driver
> 
>  .../input/touchscreen/syna,s3908.yaml         |   69 ++
>  MAINTAINERS                                   |    7 +
>  drivers/input/touchscreen/Kconfig             |   15 +
>  drivers/input/touchscreen/Makefile            |    1 +
>  drivers/input/touchscreen/synaptics_tcm_i2c.c | 1066 +++++++++++++++++
>  5 files changed, 1158 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
>  create mode 100644 drivers/input/touchscreen/synaptics_tcm_i2c.c
Hi,

I have tested your driver on Xiaomi Redmi Note 7 (lavender).
It is working fine, here is some proof from probing:

[   27.427839] synaptics-tcm-i2c 0-0020: supply avdd not found, using 
dummy regulator
[   28.570803] synaptics-tcm-i2c 0-0020: TouchComm v1, mode 0x01, part 
td4320-12.0.9
[   28.590773] synaptics-tcm-i2c 0-0020: 1080x2340, 10 touch objects

Two thing lavender is using same regulators like the panel and no avdd 
defined,
maybe the regulators should not be required in the bindings.
Is it possible to add more generic compatible since this driver working 
with
other TCM variants not just with s3908.

I can send a T-b for the next revision.

Br,
Barnabas
