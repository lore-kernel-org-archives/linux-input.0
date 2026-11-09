Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210866;
	b=t/3TBaQecSjqkANgeyR5xA8g739j484Cd9jUW6za+yjGrD5rPD8M+CHKhXGmd0uned3Q
	 YBFTXJ3hKdhpb6gNvxexBjOgzlH16fbPCy5BI0icqUfF8jOibKjER1B8eERA0Ld9ybagB
	 D1JJ0eBTqRabCp6LWnweCTHaF938/9/MF6ygMu8t58qxWjYzwfEGgY5MAU9NNN2BgN9rb
	 jSuGxYUAhWmJRfwLI2kxZ4nUwYjOYApI18VSa5UmGF8r8l0WOcXtblZOnOdt4Y02SCa0j
	 Tyxce/p2GheqzmjYxZaFiS7MxNrSE3bGo5jN2aPAs0IUcsck5zBQwSIrmPsKpVoeevw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210866;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=ZWl9jingBRzJ5jAonR3zuO+3KdpoVL68SjqrmB0AJc4=;
	b=s4Is1TM3BqsqOTNQiVjgkqozAY0/XPSJoYhd8YBWWIBU1icMvUW6bq9rzobkro+2RMem
	 iliu9bQO69AzxLqCMrDd1/dpQGhtJkUDpbaqz82pCN6GHQhj45LDZH7YJsnPDCrkrCIxD
	 fBhe760H2LgCZgmi3NGIpLzW25t+New7ni1jy8rtxAk+Apvm+6ixwPSx++jcNKF95qvMM
	 mtJprSJs7CfB9cmelaHkywaU3VdqTR5OwfVjPZ8ju8bw63f43LjtZEtogOIC5YVXOAuFC
	 OiXgh+oF2/qSEdFq3cTljUZEaSGYYlPHILGYREzvx10qBejBHsJ5bTfHOrKulHxC6Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="JG/VO2lC";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPtbq+8D;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AF606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JG/VO2lC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPtbq+8D
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4BFD77A0116
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 02:54:25 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 09 Nov 2026 02:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794210861;
	 x=1794297261; bh=ZWl9jingBRzJ5jAonR3zuO+3KdpoVL68SjqrmB0AJc4=; b=
	JG/VO2lCNqs07FngyJ7sAGpb5yy4Lvl4D5i6PBSlZehYdyaXJdONub8jYg5cFb4p
	D5waHZjLmZ/gym7e3LJLg3CEWIB7JfUkdWO50roZS16Rp1ql3ZY7a8ngrNBP6cqo
	rYop5t6tqTSEA0QnHsD/FGnvwQmw3JceqUhRC5vOopoHDw7mhELkrFXD5uCFXeHt
	sLGDANpG5PzQDVsX5Clq4qdNifqyZjtOyUWHmqlCbObIoNN+6C3i5zZr12PoBCUj
	9Q9xjj8LRUtINNmlFgP63h58s3aJkXbeTc9F5uqyqE4Gh2wqrVnc+wfVHlxAGMHR
	UohNUkLaAdOzJlRBswjwMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794210861; x=
	1794297261; bh=ZWl9jingBRzJ5jAonR3zuO+3KdpoVL68SjqrmB0AJc4=; b=r
	Ptbq+8D099xl3neJOYJETm/+DDpoVWpMJBJsspnIy4MNnjMUe89LSpmH2b9PmmXn
	8lHVL4rADE/bWp2PRXabFPrhQg7ItFkhdPEcrz6KDxNvsBvpTOTU/tYeJQcB0N9b
	vNtG5biqc3kjdNiFK2t3LNRDVHFlKm45bOCUCgYa9Lu2qyo26u6MVBtSo2DhhbZ5
	tsgtaSZTXidlLxxy3ZwIqxcAPKAMiz7hQBWBzH4PJnJC3oAHfvYEZPWW/Dvuk+O7
	OH8A9NzJPn4jaR8lm4Avm9K7F63d9V6ZsPugyubBD4EVoaX4CJyNO1ZCm1KC7Sko
	BTVYhIqDF7EoJA91SurnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794210861; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:MCWBac7qVmLyZEdeYU67ZdgkQ3qy1uRjTXPj6WSCz4S1l1p
	Gf9Oh/IzUmQH2mljz6srG4QvyJ/HLtuL6X8aCuV5PD3Bzgs2QkgOCOPdjyqbc3qK
	vQWAalpeASVE/Ub/5AB1GnfdzrkChQKYteb4EVT30JUQK7doo4paMoppnQkmjbJx
	XbCwYvrwa65iQQianoBLRqaeFmJdYUDRHhYdqPZoDldTh3mxf9DsEx3nKQgutU/j
	5Stvd46tui71VgSRjMGwVJ/YoXNAdW98vsEEnYQYMerAYroy4Z/sOcXGFHciDiQd
	wnY0sX9UaoS0BwCY2p0Zol+9t8rFIMRoaTRGhVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:br0h45qtPgSMInCnHStrufGtjfx3n0i1XgMdXhJuoi0=:9EZ78bDb/IFFrfazya5uDh2QzfACEXi+vbNDDTBiANM=;
X-ME-Sender: <xms:KnzxajJPabEKH3Cme6Du29CyTpdTgfW8Kdp9LDgB7u6HhkIBgwtOxw>
    <xme:Knzxah94pGAakNpgsvSHwVMZEAVQxmiUbfEAin0pf3zRcMOIV3q_GvAk62d-qkdR-
    1_wsxEBh7-I3DtnPZ_woewRVdf2pq1zilKkgt20FVMM6Xr3l3pat9wT>
X-ME-Proxy-Cause: dmFkZTFLBPZbwZtPJBZ6eGa1A0tuL5I23qQHDe5h6M5107y16xhJ43qHckrVl7wSASxvMB
    uQIspcTnvmRRYpTIHvglYFVFyN9RBDpkWrf3cQKOM4H/8WFSFE8aRcd+CG+mIoWA4WVWop
    3svGV8oEXlP1fhZTwSGOPH9EDNmoaR9XsEAG2VSSARJlWgaTYxsxQ/q5wmTrVHwWEpyR9f
    fzJXT2XkxEDmtfrXAdXDgUHYyF9JxZtmnZWWWK8du3uMwTFaSeF9Rosw3loPwrWS5oDmF2
    ZJIfJ33U1+iO26YFIB2wDU0QKtC08h0Prnw3PzsIJwF1S7VPSj42dPVMh/Gj3vkLoWdoHM
    RGYzKUPIVLP4Pd3XVu9Kv70ufqpLFDGmjMU1d1XhhNF9uHDIaK4xgYxJrp04KGBfcrqftZ
    CUQxuKryCVcwPXGR2lsIm4QM7Mffe4BTk/J+kz0OeT5hHOTMY19JoaW9JVRV21EH25Gw/l
    hf7exVwNf6PDxg3hnd6RwhMVZC/iTIKhyyRWrXnc0g6vxB//wPlSVrOS5COwDXbbSlB2jy
    vhwgDRb0X6v4odMT8QNd7Umwfg1/hOt0ngYGmLHssaVrO93231lVN8nq0RM4M2a4ykRgRY
    pSOg0pnQjWHv8fBuDTHLbK/c8k7sCWSJ+Tx4PNQ6JABoNVPggIe4Sv3skgvw
X-ME-Proxy: <xmx:K3zxagwDC6I1YEnhi5Ef1X-kKsGkVFwmoJLNIJRwXEhesMSIdAvVwg>
    <xmx:LHzxauVzymye-IrMhAg1UfIdf5bOp7KyVDn1ppvc5wYZEL4916oWuQ>
    <xmx:LHzxaiNySRdQi0g7UcAYaxQySSYRAqHle1ZHcJ1ZMu6I9VF87I2sqg>
    <xmx:LHzxagAGfgfPzCu-KfvAY0ZHPoygMCz48TdXN2LTvDUXzmmuaX4Esg>
    <xmx:LXzxak7Ybh3qiuUxpqoFCHXSg7PAR9SaazcAOhG8_4AIk5XQnf1b0INu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DAF7032A0097; Mon,  9 Nov 2026 02:54:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A33Xb_92NdCN
Date: Mon, 09 Nov 2026 08:53:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Wolfram Sang" <wsa@kernel.org>
Cc: "Felipe Balbi" <balbi@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Hyunjung Ko" <hj351016@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <def3815d-d3f6-4032-b7f3-d2b5e48c770f@app.fastmail.com>
In-Reply-To: <20261109072950.3474308-2-dmitry.torokhov@gmail.com>
References: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
 <20261109072950.3474308-2-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: lm8323 - remove driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 9, 2026, at 08:29, Dmitry Torokhov wrote:
> The LM8323 keypad driver relies exclusively on legacy platform data,
> has no Device Tree or generic device property support, and has no users
> in mainline (including the Nokia N810 DTS, which never added support
> for it). Its PWM/LED handling and unbind lifetime are broken, and after
> hardware-tested IRQ fixes in 2011 the driver has for over a decade only
> received mechanical API conversions and static-analysis cleanups
> without hardware testing.
>
> An inquiry on the mailing list asking whether anyone still uses or
> wishes to keep the driver received no objections. Remove the driver
> and its platform data header.
>
> Link: https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I made an identical patch (for both drivers combined) based on the
same conclusion, but you beat me to posting it.

I have additional Input driver patches in the same series at

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=board-remove-7.4

It's a mix of three types of changes:

- drivers that have been unused for years
- drivers that become unused after I remove the board files
- drivers that support both DT and platform_data, and I remove the latter

My plan was to post these after my board removal series is merged,
and this got delayed until 7.5 now after some back and forth because
I wanted to make sure they remain in the LTS kernel.

If you like, I can send more of these earlier.

      Arnd

2fc6e4e7ae89 Input: serio: remove RiscPC keyboard driver
 drivers/input/serio/Kconfig  |  11 ----
 drivers/input/serio/Makefile |   1 -
 drivers/input/serio/rpckbd.c | 152 -------------------------------------------
 3 files changed, 164 deletions(-)
48553e29487a Input: mouse: remove RiscPC mouse driver
 drivers/input/mouse/Kconfig    |  10 ----
 drivers/input/mouse/Makefile   |   1 -
 drivers/input/mouse/rpcmouse.c | 113 -----------------------------------------
 3 files changed, 124 deletions(-)
cc705b30670f Input: touchscreen: remove unused iPaq micro driver
 drivers/input/touchscreen/Kconfig         |  12 ---
 drivers/input/touchscreen/Makefile        |   1 -
 drivers/input/touchscreen/ipaq-micro-ts.c | 156 ------------------------------
 3 files changed, 169 deletions(-)
e0fa7869cf39 Input: touchscreen: remove HP jornada720 support
 drivers/input/touchscreen/Kconfig         |  10 --
 drivers/input/touchscreen/Makefile        |   1 -
 drivers/input/touchscreen/jornada720_ts.c | 156 ------------------------------
 3 files changed, 167 deletions(-)
0e7bc6741e99 Input: touchscreen: remove unused mc13783 driver
 drivers/input/touchscreen/Kconfig      |  12 --
 drivers/input/touchscreen/Makefile     |   1 -
 drivers/input/touchscreen/mc13783_ts.c | 245 ---------------------------------
 3 files changed, 258 deletions(-)
b106094d20b6 Input: touchscreen: remove unused ad7877 driver
 drivers/input/touchscreen/Kconfig  |  13 -
 drivers/input/touchscreen/Makefile |   1 -
 drivers/input/touchscreen/ad7877.c | 813 -------------------------------------
 3 files changed, 827 deletions(-)
618f5f964ae6 Input: touchscreen: remove unused tps6507x driver
 drivers/input/touchscreen/Kconfig       |  12 --
 drivers/input/touchscreen/Makefile      |   1 -
 drivers/input/touchscreen/tps6507x-ts.c | 291 --------------------------------
 3 files changed, 304 deletions(-)
f19aee30274b Input: serio: remove sa1111 ps/2 driver
 drivers/input/serio/Kconfig     |   4 -
 drivers/input/serio/Makefile    |   1 -
 drivers/input/serio/sa1111ps2.c | 384 ----------------------------------------
 3 files changed, 389 deletions(-)
f89e36a6d981 Input: keyboard: remove unused ipaq-micro driver
 drivers/input/keyboard/Kconfig           |  10 --
 drivers/input/keyboard/Makefile          |   1 -
 drivers/input/keyboard/ipaq-micro-keys.c | 165 -------------------------------
 3 files changed, 176 deletions(-)
f47f4668b39e Input: keyboard: remove unused locomo driver
 drivers/input/keyboard/Kconfig     |   8 -
 drivers/input/keyboard/Makefile    |   1 -
 drivers/input/keyboard/locomokbd.c | 340 -------------------------------------
 3 files changed, 349 deletions(-)
94397d400e71 Input: keyboard: remove unused jornada720_kbd driver
 drivers/input/keyboard/Kconfig          |  10 ---
 drivers/input/keyboard/Makefile         |   1 -
 drivers/input/keyboard/jornada720_kbd.c | 142 --------------------------------
 3 files changed, 153 deletions(-)
45a0b5d9aec8 Input: keyboard: remove lm8323 and lm8333 drivers
 drivers/input/keyboard/Kconfig  |  22 --
 drivers/input/keyboard/Makefile |   2 -
 drivers/input/keyboard/lm8323.c | 813 ----------------------------------------
 drivers/input/keyboard/lm8333.c | 213 -----------
 4 files changed, 1050 deletions(-)
7b34e2e324ff Input: joystick: remove as5011 joystick driver
 drivers/input/joystick/Kconfig  |  10 --
 drivers/input/joystick/Makefile |   1 -
 drivers/input/joystick/as5011.c | 354 ----------------------------------------
 3 files changed, 365 deletions(-)
62cfa3e37cba Input: misc: remove unused mc13783-pwrbutton driver
 drivers/input/misc/Kconfig             |  10 --
 drivers/input/misc/Makefile            |   1 -
 drivers/input/misc/mc13783-pwrbutton.c | 266 ---------------------------------
 3 files changed, 277 deletions(-)
e907244315b7 Input: misc: remove unused cma3000 accelerometer driver
 drivers/input/misc/Kconfig           |  24 ---
 drivers/input/misc/Makefile          |   2 -
 drivers/input/misc/cma3000_d0x.c     | 379 -----------------------------------
 drivers/input/misc/cma3000_d0x.h     |  31 ---
 drivers/input/misc/cma3000_d0x_i2c.c | 113 -----------
 5 files changed, 549 deletions(-)
9dcaab7ec67a Input: misc: remove unused kxtj9 driver
 drivers/input/misc/Kconfig  |  10 -
 drivers/input/misc/Makefile |   1 -
 drivers/input/misc/kxtj9.c  | 548 --------------------------------------------
 3 files changed, 559 deletions(-)
82f1f73d7331 Input: misc: remove unused max8997_haptic driver
 drivers/input/misc/Kconfig          |  12 -
 drivers/input/misc/Makefile         |   1 -
 drivers/input/misc/max8997_haptic.c | 434 ------------------------------------
 3 files changed, 447 deletions(-)
8a21394cb9e7 Input: misc: remove unused bma150 driver
 drivers/input/misc/Kconfig  |  10 -
 drivers/input/misc/Makefile |   1 -
 drivers/input/misc/bma150.c | 575 --------------------------------------------
 3 files changed, 586 deletions(-)
a25190646153 Input: misc: bma150: remove platform data based probing
 drivers/input/misc/bma150.c | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)
3ee02d394861 Input: misc: remove unused adxl34x driver
 drivers/input/misc/Kconfig       |  37 --
 drivers/input/misc/Makefile      |   3 -
 drivers/input/misc/adxl34x-i2c.c | 137 ------
 drivers/input/misc/adxl34x-spi.c | 103 -----
 drivers/input/misc/adxl34x.c     | 872 ---------------------------------------
 drivers/input/misc/adxl34x.h     |  30 --
 6 files changed, 1182 deletions(-)
7303850802da Input: misc: remove unused ad714x driver
 drivers/input/misc/Kconfig      |   30 -
 drivers/input/misc/Makefile     |    3 -
 drivers/input/misc/ad714x-i2c.c |   97 ----
 drivers/input/misc/ad714x-spi.c |  103 ----
 drivers/input/misc/ad714x.c     | 1200 ---------------------------------------
 drivers/input/misc/ad714x.h     |   53 --
 6 files changed, 1486 deletions(-)
067581d4518d mfd: remove unused da903x driver
 drivers/input/touchscreen/Kconfig     |  13 --
 drivers/input/touchscreen/Makefile    |   1 -
 drivers/input/touchscreen/da9034-ts.c | 364 ----------------------------------
 3 files changed, 378 deletions(-)
0403fd11877e mfd: remove unused adp5520 driver
 drivers/input/keyboard/Kconfig        |  10 --
 drivers/input/keyboard/Makefile       |   1 -
 drivers/input/keyboard/adp5520-keys.c | 190 ----------------------------------
 3 files changed, 201 deletions(-)
d26d231fe10b mfd: remove unused 88pm80x driver
 drivers/input/misc/88pm80x_onkey.c | 152 -------------------------------------
 drivers/input/misc/Kconfig         |  10 ---
 drivers/input/misc/Makefile        |   1 -
 3 files changed, 163 deletions(-)

