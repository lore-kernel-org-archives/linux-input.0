Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F627E05E;
	Thu, 18 Jun 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799310; cv=none; b=kbY9XdhBKztTbKB+lViX4jNce6fxkp8HQ1xnk7aHmpZ4s8SvD37V25UfsaVruNr26E95zPxxH0m4ziQzRlLYn1XiO5pmMEjpltrUYHxFFQ9tJzLeB9K0d1diJMMBpTPTyiL1NwSNb9Afzzo0jfc8pkwsi1arm6xMZSXoDZ29lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799310; c=relaxed/simple;
	bh=XOh33/7J12phZEc0RyvDSay2BesLrR8PKaklP2UOpXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKWbXon/QQWvvtszUOVZXCDDapPUS6VpBtqJaFNGTFsY94cbeks0dXboGAB3CTpy5NPPHqIp16FB0w88hJa3NeZrkUQzw3sCe8B5NpQXsWCF7i1zUBDnq6QXvvkRNF7YRUa03kAJFV6Ugy/d6KAIqfa3wGLWzytv9ZoDszKz/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCM2LLF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCM2LLF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5221F000E9;
	Thu, 18 Jun 2026 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799308;
	bh=ELyHRkzlWkP1BPP9bDIBEArBzxK4qUIdeIluaMgdxsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCM2LLF4U63fGOvq5nvUKpaPpP/pqSvlxxHb7hG/AeJXsSURDS1LJBCf3nOQwXrmi
	 rsW/G0RH7Pw/xrgfchX0MOkAD6rDQugVNNDFNV0Pk0vtgYB6rvcSehafP/1r3Eo0xr
	 tk+1HF8+lGJfB/e9e2LGe46KxNmnGEwoB5g/PaRwE/a0mOddN+sjLDhxbt8f1cmkMk
	 pWoiodTN1NNJyxGSQOuan4k9AGnwWEDzLpm/wk3+Yv2IPaPQTsXS2uPWbrY9hTC1ii
	 9qR3Xirrp8w+VcfvChVP8O+mTqLnIO+Cd/S+9zfXMNY+JAf75ZUgrnXz/E04eZYfLB
	 nF7SoK19CIg1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: request modules for
 discovered protocols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>
Cc: linux-hwmon@vger.kernel.org, Frank.Li@kernel.org, linux-input@vger.kernel.org, imx@lists.linux.dev, dmitry.torokhov@gmail.com
In-Reply-To: <20260618-scmi-modalias-v2-2-8c7547c1be21@oss.qualcomm.com>
References: <20260618-scmi-modalias-v2-0-8c7547c1be21@oss.qualcomm.com>
 <20260618-scmi-modalias-v2-2-8c7547c1be21@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 16:15:07 +0000
Message-Id: <20260618161508.1C5221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in `scmi_protocol_device_unrequest` during concurre=
nt driver unregistration.
- [High] IDA and SystemPower protocol state leak when the SCMI platform dev=
ice is unbound.
--

commit 55b65f66dfc5c3002d324389dda6dc66790201cc
Author: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

firmware: arm_scmi: request modules for discovered protocols

This commit enables autoloading for scmi driver modules by emitting a
protocol-level alias for scmi device ID table entries. It requests the
alias when discovering implemented protocols so that driver modules can
be loaded before the concrete client name is available.

> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index 0fd6a947499e7..7d33fab94e281 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can concurrent driver unregistration
lead to a use-after-free in drivers/firmware/arm_scmi/bus.c?

Looking at scmi_protocol_device_unrequest(), it drops the
scmi_requested_devices_mtx lock to call blocking_notifier_call_chain().

If two threads execute concurrent module unloads for different scmi
drivers on the same protocol:

Thread 1 completes the notifier, re-acquires the lock, and frees phead:
    if (list_empty(phead)) {
        idr_remove(&scmi_requested_devices, id_table->protocol_id);
        kfree(phead);
    }

Would Thread 2 then evaluate list_empty(phead) using the just-freed
phead pointer when it finishes its own notifier and re-acquires the lock?


[Severity: High]
This isn't a bug introduced by this patch, but does the scmi platform
device unbinding leak the scmi_bus_id ida and system power protocol state?

When scmi_remove() calls scmi_destroy_protocol_devices() with a NULL
name, it eventually reaches scmi_child_dev_find() in
drivers/firmware/arm_scmi/bus.c:

    strscpy(id_table[0].name, name, sizeof(id_table[0].name));

Since strscpy() does not accept a NULL source pointer, doesn't this
trigger a warning and leave the target name empty?

If this empty name causes scmi_dev_match_by_id_table() to fail, the
device won't be found and the manual cleanup in __scmi_device_destroy()
is bypassed.

The device core will then automatically unregister the child devices
using:

    static void scmi_device_release(struct device *dev)
    {
        struct scmi_device *scmi_dev =3D to_scmi_dev(dev);

        kfree_const(scmi_dev->name);
        kfree(scmi_dev);
    }

Since this release callback skips explicit ida and state cleanup, does
this permanently prevent the system power protocol device from being
recreated if the driver is rebound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-scmi-modal=
ias-v2-0-8c7547c1be21@oss.qualcomm.com?part=3D2
