Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792851240;
	b=g5Ody2xaqwD56m5bLkf+XdirbTYbTE2UI121EgIaT58sXPBOiJ1AEdYMT5IwJnC7dRnq
	 wo8Rbo9yHmlXsd/6izNJGkztU8jXqg+A/s8FcWXM34lhL41tI8yWRvQZ6SUP2XZzUdtQk
	 88juEPtaG/fKQZdxJrin9ztM2wO1+ucmGrhnRsnFZu1xSfeHdjnSbutOqAhtcBj+zRxfz
	 P9XACvGsyR6VDDFHcQu+oV4jzwPl4osXS8Q5J/25dBdS3sWynNt+5LbKPRvSB6QSOsie7
	 YADhmIbeABo+gszVodVx9RlW07K6pmQhT4LSQMEsiekSzXRV2bx0rT2hcslGgOL5oRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
	b=miDAgdJLB3/+rrro4MOzwauWsOdt8H+GsusFXb2L7JiI9HkJEsZyUkNrWj0zajCOnt24
	 UNe81vxyXylFCYrg32RDbuxySX0GtHVzCsSynE9nY56SQTNbnoLvijvRhm2Z+WLJlGYKY
	 rbpvXXiqguKKwfFMLGulj4MpASlhmfEGW8i66lgyVqGd+MqXt4EMgBPqKXzJPV10+gyaO
	 DYhIDcHTdcTUaZSWV+PDHEOW0F/3ASgm6VkacqJ65pZtyGRjduGdjFQv8faCg9IbwvdNh
	 TsGMHrHrhdXeEqzVzOFFEqqY+vqNozCpNAI+JJ9MHzhu4I67jKbEfFuO+xxZF9jbttw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943B606A31F
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 14:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3943B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1366617e87.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792851238; cv=none;
        d=google.com; s=arc-20260327;
        b=q+ONBSNd9WwHgfu8IcivxxgOcRUgi1MN0Fub1bJtnXZYtQjmczDabJBcdOsfTth/Bl
         3iD/uaT7P/mgI4N4ksT1J5w9BxsjKNc5O2FynUVXXnAG5XdKSkSW5XfzzsnKe+daqkT7
         5MOsTrllJ599uZWzBGNtzL55l/gUKphHqmSxiYS87KrEVfyB/LQP3cx1n96yy7Kre8//
         HvR39gwzlm55RrJ0WYG+SVw8PE/MhFqnV9Vxt8NS8wOPnbVq+y3bYpgC9oAErsxOcpk3
         Y62UQ/tvBOE2/ZjJiEJocfhTRlCZ4TnD22qRjH/K96AdVLcvF/RlHojBrlOwhAVTnLim
         TwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        fh=hN+O1604ulQpEmiZLWZ6GnmfBIrdQzxYVvtoSS/bbe0=;
        b=ckVPf2Kp1JDPI7m6FS7WNhbh78tPxuIT+WmdyrTlbV1qlIvaXTeeL4aQMCvDndhqkJ
         r/5lZDiz2KYX08ilsFZUQAen/sWp9xTHglznkJdKHEKBAL4ubK+csGMfYdsi7jyE5Iq+
         5j69E3+MVM6Ee9qxZvZvB2ZoeQ4/X+8hj4bESsr4zNMXnVYcxiRuf1wlnugkNixN36ow
         Oiq3mLDmjq4q5Z5/9XViw9TGLkXBC/cMdnbLL1oeKLMvkUv2xvND9qJbEQuuyAHEuUYc
         f/FwsR7Ee3DbMhSCrkNgC17uywqMMGT82ONr7Odr9h503GO9VFlXH4BRBMlEiuP43F2K
         IVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851238; x=1793456038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=Ezdj4S4xEB8h7gxc03c2uOcj/ii601I7+Cd4LQAP+csNZtwqaMJrX7yHnV/QRvc3eh
         cy5B9dqUS+Oz/fwYJJhrVqldoR3wqQnjxlmUmztY2taoA9FuiP+qznCrX4ahYkiZVZJu
         +CK4AGKWWOPfbp1ZMEtLRjpXJCu/Oz2kFxxBB2dsvUX6X0yHqRvjodQCXe61EgiHfvYY
         hMbpHMr9o/zG1nWClTKTYPQD2wyuXpHLbF10wB2AhOCIIO7GJyBE+Z/eYGPJ7wju5eYo
         fMZQIwZIRn2RVGmTi2WIrciOEUSxYeriB/lDGzOvior6snXECURFiS0d8YdclVa7uPK8
         4vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851238; x=1793456038;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=ECzQ017d+YW8qB2/hcZqYQdJ2ezm2xuz7HA3kRAXVn17wUwswJGsXJxi5X8AuekmuI
         TlAn/CpJroaQFGe5DBJ37JH0mBLKjp513LR85b8fEUIJhPU68zh11qP/55Y9tBTBfXd6
         wmhlfukzbf8bj/7qDCOy1Tg3dtim3w7GMeL9tCYjICmUcUMv50cqqbhHED2TrTsmBxkc
         yxbEckix9jjJ2Oc02nfpbhCNaiFx8CpA/eheDruIzD/StTpN5bWrjlKnXE5rqC2xBIh9
         rS2LvA5tJbqcmWRFz1a7CWHFAdjjyXiw9yo3W5KJ/Q5x30iLI1ol6z6Gg9GKHSV4B9p7
         rc6Q==
X-Gm-Message-State: AFq9FYJsLrYLCS7HhxV6HMdDRx9Ljj567R3PC13KDTuQHluLrGpicM1p
	dC4bALReB4xdJT9+XLBAaakAH4DTcpg/SNGeekP1Hb5hMkWXuD58eAhsxjPkmXj7QTObqLROGl2
	NNpMV6gZeONERtTfboz+wX8zlRsbJDqDMt7pVl/qM5A==
X-Gm-Gg: AYBFou15vhHIfqn0Mw8aT20SRJDZBr9NLzLyuc6kNmL6RB1TaBCOwFtjsSPTZglJiZl
	PB/e3uOOXTXEy6QvWECy5AxNR/1FWxb4zNzSdy0QJRj96t49P+/hagZFeCQiteAdLEhVwxfo4Zf
	+ZF7JK0qFZKuhIUuWWOvu3dMQa2mTV5f+2jzty2whYGh+lUSZ3uxHvGTXJHYV8eo7xl0NJy8dEn
	r3gCMr/EzvtqidyzURsqSXqYw8o0LCZTck6Bq7K2MXn007jr9WHf17ThRCYn99qxw9XKx/ImviI
	tbfOEzJfRX+gwG/dR/68EwzQYBvoAAGPbXixbqBcoIK0T0ZPb7pjAEPUwXahWD/iYUK676WprGW
	NXMjHVtvifzjGmWVg2ZlM9mnMoj59HsbV7wle9w==
X-Received: by 2002:a05:6512:a83:b0:5bf:ae8e:ef5f with SMTP id
 2adb3069b0e04-5bfb7170240mr682770e87.5.1792851238053; Sat, 24 Oct 2026
 07:13:58 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andrea Santin <asantin36@gmail.com>
Date: Sat, 24 Oct 2026 16:13:46 +0200
X-Gm-Features: AclHuK8rSSexd6wbySxEH-6RWmgS6VGKifIVY5kw2Vlwh1mO1AHs7PtfFqEvVSg
Message-ID: <CAG3xgg_10jdDiT3iSSQmm+hHDWmgdaSe8=DW=ddC6cE7rE_MNw@mail.gmail.com>
Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from s2idle via
 GPIO 12 (WACF2200)
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from
s2idle via GPIO 12 (WACF2200)

Hello,

I would like to report an unexpected wakeup from suspend-to-idle on a
Lenovo Yoga 7 2-in-1 14AHP9 (machine type 83DK).

Hardware:
- Model: LENOVO 83DK / LNVNB161216
- CPU: AMD Ryzen 5 8640HS
- BIOS: Lenovo P9CN33WW, version 1.33, dated 2026-03-27
- Distribution: Arch Linux
- Kernel: 7.2.11-arch1-1
- Suspend mode: s2idle

Problem:
When closing the lid, the system enters s2idle but wakes up almost
immediately. This causes the lid-close suspend behavior to fail
intermittently.

With the default wakeup configuration, the kernel log contains:
- "PM: suspend entry (s2idle)"
- "Setting wake for GPIO 12 to enable"
- "PM: Triggering wakeup from IRQ 7"
- "ACPI: PM: Wakeup unrelated to ACPI SCI"
- Repeated "GPIO 12 is active" messages

IRQ 7 is handled by pinctrl_amd.

ACPI investigation:
The DSDT declares the device \\_SB.I2CC.TPNL with HID "WACF2200".
Linux binds it to the i2c_hid_acpi driver. Its ACPI _CRS declares a
GPIO interrupt on pin 0x000C (GPIO 12), Level, ActiveLow,
SharedAndWake. The device power/wakeup attribute is enabled by
default.

Workaround and test results:
Disabling wakeup for this device with:

  echo disabled | sudo tee /sys/bus/i2c/devices/i2c-WACF2200:00/power/wakeup

prevents the immediate wakeup in my tests, while the touchscreen
continues to work during normal operation. With this setting, the
laptop remains suspended until I reopen the lid. In the captured log,
timekeeping remained suspended for 43.838 seconds; the subsequent
wakeup was associated with IRQ 9, an ACPI EC GPE, and a notification
for LID0.

I repeated the test several times with the same result. I also created
a udev rule to apply the workaround at boot.

Could you advise whether this should be addressed with a
model-specific wakeup quirk for the Lenovo 83DK, or whether the
ACPI/GPIO wakeup handling should be fixed more generally? I have not
established the precise underlying cause, so I would appreciate
guidance on the appropriate subsystem and possible fix.

I can provide the relevant kernel logs and ACPI table excerpts if needed.

To solve the problem, I used AI during the troubleshooting phase,
since I don't have the necessary skills to do it myself.

Best regards,
Andrea
