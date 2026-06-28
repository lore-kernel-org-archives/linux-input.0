Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54D28C86C
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665943; cv=none; b=I1TUpBb65F2049ehy82jbv1JL3oxoKndlkd38HIIbMXpx/+0/EunZX64IN3/OLQDUDQZ3J/nkAZWKVPAZYSrNsvlE5IUjubfpmrLuB/9XOEbZWeXKNVmfwOYtr3p5ZRPFMIg/7uUEDQ4IB7A+r2Ojl8ma7tRcp+ykfzErnz6ijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665943; c=relaxed/simple;
	bh=Cao3htUNyj5w81OMDgLnifn9e0G+HOlpLw6iQp4e4tQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J02Zt4pXrNrZqafGCTHre6R1zihAuvRIPA0VCXwZmCIxw5n4Tcv03+nVDV7SmJvV2agEENftOoAjdNe839twIGraUK9PUYbHWFQ03Od5S28vp4exc3dJealTonSApfIbkQTtEBmvj5Yl45dW/OiLpj5sXwF98e09K69ySarYsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcNk/XSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcNk/XSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B151F000E9;
	Sun, 28 Jun 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665942;
	bh=Kp0jl/deoR2TgngvdBvIeibDBKKWS8Hu+WIY9BjzNYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcNk/XSyB+b1wXrIyIuJUrv/S92dF+XhCsmk8QcZytWPFOqvk1wy8qManMsb8J1q6
	 C/lEdl1bdIe5ZLc/pGanIabLb/C7sbLC4zV0P7O9T+IIGgdL/mXINHyGLCpCdzGvlr
	 ATHuhNpbWwoqgnfriI9z5/DaQzmJOeKEjTEcVuANFcykPAbC2m1a6o7OEWvOdxYDCj
	 WzY0TQmGEuQX/xXObUdLfwxMjw9Bwoz7IIaKDDyk+Z+edyEd3kcGjr1vkEmC+De27B
	 XWsJHSlT9fsQ5CDUuc0lrGMLWjhh43kEgi6ERydaJqC8QGHh/aeF/zqrdcv49jQWTS
	 V5c5iEa7MCBHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] HID: roccat-konepure: reject short button reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628164611.17467-5-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
 <20260628164611.17467-5-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:59:00 +0000
Message-Id: <20260628165901.D0B151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch series fixes out-of-bounds reads in several Roccat drive=
rs by adding report size validation, but misses identical vulnerabilities i=
n `hid-roccat-savu.c`.
- [High] The `roccat_report_event()` function illegally acquires sleeping m=
utex locks while executing in atomic/softirq context, leading to scheduling=
-while-atomic bugs.
- [High] Leaking `struct roccat_device` and `struct roccat_reader` in `rocc=
at_release()` after device disconnect.
- [High] Leaking dynamically allocated report buffers in the ring buffer wh=
en destroying `roccat_device`.
- [High] Missing size checks in `corsair_void_raw_event()` allow out-of-bou=
nds memory reads.
--

commit ed9829ff5a1328c7edd5ce7aa1cab27bdb994e83
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-konepure: reject short button reports
   =20
konepure_raw_event() forwards button reports directly to
roccat_report_event(), which copies the fixed eight-byte report size
registered by this driver. A malformed USB device can send a shorter
report and make that copy read beyond the input buffer.

> diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-k=
onepure.c
> index 7f753dfc2a108..d17dee18ac2b0 100644
> --- a/drivers/hid/hid-roccat-konepure.c
> +++ b/drivers/hid/hid-roccat-konepure.c
> @@ -181,7 +181,8 @@ static int konepure_raw_event(struct hid_device *hdev,
>  			!=3D USB_INTERFACE_PROTOCOL_MOUSE)
>  		return 0;
> =20
> -	if (data[0] !=3D KONEPURE_MOUSE_REPORT_NUMBER_BUTTON)
> +	if (data[0] !=3D KONEPURE_MOUSE_REPORT_NUMBER_BUTTON ||
> +	    size < sizeof(struct konepure_mouse_report_button))
>  		return 0;
> =20
>  	if (konepure !=3D NULL && konepure->roccat_claimed)
>  		roccat_report_event(konepure->chrdev_minor, data);

[Severity: High]
This is a pre-existing issue, but does calling roccat_report_event() here
lead to scheduling while atomic?

The raw_event handler runs in softirq context when the URB completion
handler calls hid_input_report(). However, roccat_report_event() acquires
sleeping locks:

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}

Will this cause lockdep warnings or panics when those mutexes sleep?

[Severity: High]
This isn't a bug introduced by this patch, but while adding report size
validation for konepure, did we miss identical vulnerabilities in
hid-roccat-savu.c?

Looking at savu_raw_event(), it lacks report size validation before
processing the raw event buffer:

drivers/hid/hid-roccat-savu.c:savu_raw_event() {
    static int savu_raw_event(struct hid_device *hdev,
                              struct hid_report *report, u8 *data, int size)
    ...
}

Which then performs out-of-bounds struct field accesses on short reports:

drivers/hid/hid-roccat-savu.c:savu_report_to_chrdev() {
    ...
    special_report =3D (struct savu_mouse_report_special const *)data;

    roccat_report.type =3D special_report->type;
    roccat_report.data[0] =3D special_report->data[0];
    roccat_report.data[1] =3D special_report->data[1];
    ...
}

Could this lead to an out-of-bounds read if a malformed device sends a
shorter report, potentially leaking kernel memory to userspace?

[Severity: High]
This is a pre-existing issue, but is there a memory leak in roccat_release()
when bailing out early?

If a Roccat USB device is unplugged while a process has the character
device open, roccat_disconnect() sets devices[minor] =3D NULL but defers
freeing the device. Later, when the user closes it:

drivers/hid/hid-roccat.c:roccat_release() {
    ...
    device =3D devices[minor];
    if (!device) {
        mutex_unlock(&devices_lock);
        pr_emerg("roccat device with minor %d doesn't exist\n", minor);
        return -ENODEV;
    }
    ...
}

Does this early return skip freeing the reader struct and fail to decrement
device->open, permanently leaking both structures?

[Severity: High]
This is a pre-existing issue, but does destroying roccat_device leak
dynamically allocated report buffers?

When the device is finally destroyed, we free the device structure:

drivers/hid/hid-roccat.c:roccat_disconnect() {
    ...
    } else {
        kfree(device);
    }
    ...
}

And similarly in roccat_release():

drivers/hid/hid-roccat.c:roccat_release() {
    ...
    } else {
        kfree(device);
    }
    ...
}

Since roccat_report_event() allocates report data via kmemdup() into the
cbuf ring buffer, does calling kfree(device) without iterating over cbuf
leave those populated cbuf[i].value pointers leaked?

[Severity: High]
This isn't a bug introduced by this patch, but does a similar missing
size check exist in the Corsair VOID driver?

Looking at corsair_void_raw_event(), it processes status and firmware
reports by directly reading offsets up to data[4]:

drivers/hid/hid-corsair-void.c:corsair_void_raw_event() {
    ...
    if (hid_report->id =3D=3D CORSAIR_VOID_STATUS_REPORT_ID) {
        drvdata->mic_up =3D FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
        drvdata->connected =3D (data[3] =3D=3D CORSAIR_VOID_WIRELESS_CONNEC=
TED) ||
                             drvdata->is_wired;
    ...
}

Without verifying that size is large enough, could a short report cause
an out-of-bounds memory read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D5
