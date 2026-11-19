Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.46.229.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076102;
	b=HSqON8+hSeFIUzpHek4PmZXhfOwoQT4LA3NLmdlF5pYO1qT4wxhY3CuCx7fn7U/rCD/d
	 8KMBV/uKEo0kCPucU3HCxYv4bRH2+tbAw9P904p3eo7bkt3EiF0YDPMwwgMsjbmrb+e5p
	 buxFwVSgOfiWUM65O/X279ExJWD360kZIBoeHW4b9NRjrJOc6fNMQQInjOx2xH5LJuTGZ
	 WVNGHjxOKTqoEntF8Uq4Ddd6X3BgGuhy2fr7SCg4K80PiPqLQKxSPRyzfjS6DxuYiqCXK
	 iS43JNmLtfuDsLEaLKh3htyAtcnJTqQLb9g69UtLU5K4hGRyknZdc6yKMLH9GvDbThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076102;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KQjFXmZ+pAWZ6X30x7o23/sjlS9JkbSCf4z7NXCe5P8=;
	b=JpQJjmx9rcveHBOZ4M8OHqNE3y9Hgk2e42vBAQB5n7EXfCohJxRC6CNaGgr+JxG0jiwl
	 nc2CGQjsmrVU/h3yC5DHAfY6wKQwlkpq8Qn6WFIgc45JTrpqvnesNGdH6dUSh2cqk9hWr
	 3cOsJTL8aeWFhUIRL31wQ4WSDUzFSrbE64RXx//QwbOpa63z3SEyST7IdijT/KTgknIsO
	 IQvBLk0nXlceEpOhzv501s0+wXqeaoflXl51zOMDyEolH4mdYtiCAj26D6Oz58XgtK+8J
	 A/kr22p9QNmo5tZFrxiYt2g9K7iGg6BtbhdEeo1ep/4Ztmg6OgPPB19Y9MVtacRKENA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.zgclab.edu.cn;
	spf=pass smtp.mailfrom=mail.zgclab.edu.cn;
	dkim=pass header.d=mail.zgclab.edu.cn header.i=@mail.zgclab.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ddMIIq4A;
	arc=none smtp.remote-ip=207.46.229.174
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56466606A320;
	Thu, 19 Nov 2026 08:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56466606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.zgclab.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.zgclab.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.zgclab.edu.cn header.i=@mail.zgclab.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ddMIIq4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.zgclab.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KQjFXmZ+pAWZ6X30x7o23/sjlS9JkbSCf4z7NXCe5P8=; b=ddMIIq4A5x2cF
	uyO8nQT62JPcvm8eBl8R6LQ9kbgrbk17+9tp3EVgiWl5XeK+dqInV6PbL+8mS7jd
	g7B+fbwr0Qk8TjZWTI9T90XizybeDr7MZHEuLGUOZizc4scLJEbPOfVWL8ypcpOm
	ydG2sI7k3qJFOxfQemNXJkBqX+Tm8w=
Received: from 04.eml (unknown [58.206.202.11])
	by web4 (Coremail) with SMTP id ywQGZQCXVgT9r_5qpbwhAg--.21704S2;
	Thu, 19 Nov 2026 16:14:53 +0800 (CST)
From: Wang Haoran <wanghr2026@mail.zgclab.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, wanghr2026@mail.zgclab.edu.cn
Subject: [PATCH] input: hideep: Roll back regulators on power on failure
Date: Thu, 19 Nov 2026 16:14:54 +0800
Message-ID: <1795076094831-4-142a2b55@mail.zgclab.edu.cn>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQCXVgT9r_5qpbwhAg--.21704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3KF1DCFy7tr1ruFWrAFb_yoW5tFyrpr
	s5W392krs7XFySya1DXryIv3W5Kr1DJr95Ar1kG3yrX3Z8Z3ZxJrs2yrWY9F1Fqr1kGw15
	KrWkZr40yF12vrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAaw2AFwI0_Jrv_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx
	0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I2
	1c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUjw0ePUUUUU==
X-CM-SenderInfo: pzdqwxbusqjlo62juzldeovvfxof0/1tbiAgIQD2r+rloDXwAAsj

hideep_power_on() enables the vdd and vid regulators but does not roll
them back when a later step fails. When the reset command write fails, the
probe returns before the devm action is registered, so both rails stay
enabled; a subsequent probe retry then enables them again, and the leaked
enables make _regulator_put() warn. The enable failures themselves are also
only logged and neither propagated nor rolled back.

Disable the already enabled rail(s) on failure, return the enable errors
right away, and disable both rails when the reset write fails.

Signed-off-by: Wang Haoran <wanghr2026@mail.zgclab.edu.cn>
Fixes: 842ff286166e ("Input: add support for HiDeep touchscreen")
---

diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index 9384657ece7e..ecd730763821 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -661,17 +661,22 @@ static int hideep_power_on(struct hideep_ts *ts)
 	int error = 0;
 
 	error = regulator_enable(ts->vcc_vdd);
-	if (error)
+	if (error) {
 		dev_err(&ts->client->dev,
 			"failed to enable 'vdd' regulator: %d", error);
+		return error;
+	}
 
 	usleep_range(999, 1000);
 
 	error = regulator_enable(ts->vcc_vid);
-	if (error)
+	if (error) {
 		dev_err(&ts->client->dev,
 			"failed to enable 'vcc_vid' regulator: %d",
 			error);
+		regulator_disable(ts->vcc_vdd);
+		return error;
+	}
 
 	msleep(30);
 
@@ -679,9 +684,12 @@ static int hideep_power_on(struct hideep_ts *ts)
 		gpiod_set_value_cansleep(ts->reset_gpio, 0);
 	} else {
 		error = regmap_write(ts->reg, HIDEEP_RESET_CMD, 0x01);
-		if (error)
+		if (error) {
 			dev_err(&ts->client->dev,
 				"failed to send 'reset' command: %d\n", error);
+			regulator_disable(ts->vcc_vid);
+			regulator_disable(ts->vcc_vdd);
+		}
 	}
 
 	msleep(50);

---

PoC reproduction (7.4.0-rc2, arm64 QEMU virt, unmodified kernel):

Device tree injection, spliced into the QEMU virt machine DT:

    reg_vdd: regulator-0 { compatible = "regulator-fixed";
        regulator-name = "hideep-vdd"; regulator-min-microvolt = <3300000>;
        regulator-max-microvolt = <3300000>; };

    reg_vid: regulator-1 { compatible = "regulator-fixed";
        regulator-name = "hideep-vid"; regulator-min-microvolt = <3300000>;
        regulator-max-microvolt = <3300000>; };

    i2c@0 { compatible = "i2c-gpio";
        sda-gpios = <&gpio0 0 0>; scl-gpios = <&gpio0 1 0>;
        i2c-gpio,delay-us = <2>; #address-cells = <1>; #size-cells = <0>;
        hideep@41 { compatible = "hideep,hideep-ts"; reg = <0x41>;
            interrupt-parent = <&gpio0>; interrupts = <2 8>;
            vdd-supply = <&reg_vdd>; vid-supply = <&reg_vid>; }; };

The device has no reset gpio, so the reset command write fails on the
unanswered bus after both rails have been enabled.

Trigger:

    modprobe i2c-gpio
    modprobe hideep

Result:

    hideep_ts 0-0041: failed to send 'reset' command: -6
    hideep_ts 0-0041: power on failed: -6
    WARNING: drivers/regulator/core.c:2678 at _regulator_put
    WARNING: drivers/regulator/core.c:2678 at _regulator_put

Two warnings, one per leaked rail, and the regulator use counts go from
1 to 2 after the failed probe.

Note: the PoC was generated with AI assistance and the vulnerability was
found by static analysis. The device tree is trusted input (a bad DT
requires root or physical access), so this is not a security fix, but it
prevents a potential resource leak or system failure on a failed probe or
an old or malformed DT.

