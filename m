Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3031632DD
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666066; cv=none; b=g/TLzTcQi42iWSBrztB1bUUqMMiUto9+HvSOvZArzQ8wivOqrf6TYpG0JAWUnRSWpNS5rejC2t5Ftx0qsxzgpwqZr1dbMFsLJMtH4nY1veDW77shltBcoUMz4rT3v1sLfRLSSweNAZxkTLm/s3lD98eAxZtzGgtlGX691aZ2HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666066; c=relaxed/simple;
	bh=b3UZ8BiS/AdciwMmDGJXZDZQ9JuxWQH6pFA6lbv59pY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m1HYXnrWhn5mEGVp0kNgawkpGgmFW0yDxXKMlpiR0ZKgTGpm695/WwGFseEniP9nx0qRWdEgHDuj/CguhUfXGZzvYG7teHBhdW/kZuijR+GVnKF9uy3oOfWLotvG8JO3AcMVRaKx22Jlx7bO+wQc/0j4QqTVbp3/YfZ6STgBd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F80E1F000E9;
	Sun, 28 Jun 2026 17:01:04 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] HID: roccat-koneplus: reject short button reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:01:03 +0000
Message-Id: <20260628170104.6F80E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free during device teardown due to incorrect removal=
 ordering.
- [High] Incomplete Fix: Out-of-bounds read via short USB reports in the sa=
vu driver.
- [High] Memory leak of `struct roccat_reader` and `struct roccat_device` o=
n hot-unplug.
- [High] Sleeping in atomic context due to mutex_lock in the raw_event path.
- [High] Lockless Access and Data Race on the `devices` array causing NULL =
pointer dereference or UAF.
- [High] Kernel information leak via sysfs attributes due to uninitialized =
memory copying and ignored errors.
- [Low] Unsynchronized access to `actual_profile` between process and inter=
rupt context.
--

commit d5a3862120a746721ced4fff1b161538d9d1d57c
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-koneplus: reject short button reports

The Koneplus raw-event path casts button reports to an eight-byte
structure before updating profile state and forwarding an event. A
malformed USB device can identify a shorter report as a button report
and trigger out-of-bounds reads.

Require the complete button report before either consumer sees it.

Fixes: 47dbdbffe15b ("HID: roccat: Add support for Roccat Kone[+] v2")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-k=
oneplus.c
> index f80a60539a967..e0f35251e81a9 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -523,6 +523,10 @@ static int koneplus_raw_event(struct hid_device *hde=
v,
>  	if (koneplus =3D=3D NULL)
>  		return 0;
> =20
> +	if (data[0] =3D=3D KONEPLUS_MOUSE_REPORT_NUMBER_BUTTON &&
> +	    size < sizeof(struct koneplus_mouse_report_button))
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but does the savu driver also need a similar
check?

It looks like the savu driver lacks length validation. savu_raw_event()
forwards reports to savu_report_to_chrdev(), which casts the buffer:

drivers/hid/hid-roccat-savu.c:savu_report_to_chrdev() {
    ...
    roccat_report.type =3D special_report->type;
    roccat_report.data[0] =3D special_report->data[0];
    roccat_report.data[1] =3D special_report->data[1];
    ...
}

If a malicious USB device sends a 1-byte report to the savu driver, could
these accesses read out-of-bounds of the heap buffer and leak information
to userspace via the character device?

>  	koneplus_keep_values_up_to_date(koneplus, data);

[Severity: Low]
This isn't a bug introduced by this patch, but is it safe to update the
profile state here without synchronization?

koneplus->actual_profile is updated from sysfs in process context under
koneplus_lock, but it is also updated here in interrupt context via
koneplus_keep_values_up_to_date() without acquiring any locks:

drivers/hid/hid-roccat-koneplus.c:koneplus_keep_values_up_to_date() {
    ...
    koneplus_profile_activated(koneplus, button_report->data1 - 1);
    ...
}

Could this data race cause stale profile values to be read if sysfs
attributes are accessed concurrently with profile-changing USB events?

> =20
>  	if (koneplus->roccat_claimed)

[Severity: High]
This is a pre-existing issue, but can this path sleep in atomic context?

koneplus_raw_event() runs in atomic interrupt context from the USB URB
completion handler. If roccat_claimed is true, it calls
koneplus_report_to_chrdev(), which eventually calls roccat_report_event():

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}

Would acquiring these mutexes inside the raw_event path trigger a
scheduling-while-atomic bug upon receiving valid input events?

[Severity: High]
This is another pre-existing issue, but does roccat_report_event() have a
data race with device removal?

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    device =3D devices[minor];
   =20
    new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
    ...
}

If roccat_disconnect() runs concurrently, takes devices_lock, and sets
devices[minor] =3D NULL, could roccat_report_event() fetch a NULL or freed
device pointer locklessly, leading to a crash or use-after-free when
accessing device->report_size?

I also noticed a few other pre-existing issues in the ROCCAT subsystem
that might be worth addressing:

[Severity: Critical]
This is a pre-existing issue, but could there be a use-after-free during
device teardown?

In koneplus_remove(), the driver state is freed before the hardware is
stopped:

drivers/hid/hid-roccat-koneplus.c:koneplus_remove() {
    ...
    koneplus_remove_specials(hdev);
    hid_hw_stop(hdev);
    ...
}

If a USB event arrives exactly during this window before hid_hw_stop()
halts the in-flight USB URBs, koneplus_raw_event() will fetch the
freed driver data:

drivers/hid/hid-roccat-koneplus.c:koneplus_raw_event() {
    struct koneplus_device *koneplus =3D hid_get_drvdata(hdev);
    ...
    koneplus_keep_values_up_to_date(koneplus, data);
    ...
}

Would this dereference the freed koneplus pointer?

[Severity: High]
This is a pre-existing issue, but does hot-unplugging the device while it
is held open by userspace cause a memory leak?

When a ROCCAT device is unplugged, roccat_disconnect() clears the array slo=
t:

drivers/hid/hid-roccat.c:roccat_disconnect() {
    ...
    devices[minor] =3D NULL;
    ...
}

If a user-space process holds the char device open, the memory isn't freed
immediately. When the process later closes the file descriptor,
roccat_release() checks the array:

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

Since the device was set to NULL during disconnect, it returns early and
bypasses freeing the reader and device structures. Are these structures
leaked permanently?

[Severity: High]
This is a pre-existing issue, but can sysfs attributes leak uninitialized
heap memory to userspace?

In roccat_common2_receive(), a buffer is allocated via kmalloc() without
GFP_ZERO. If usb_control_msg() fails, it still executes memcpy():

drivers/hid/hid-roccat-common.c:roccat_common2_receive() {
    ...
    len =3D usb_control_msg(...);
   =20
    memcpy(data, buf, size);
    ...
}

Sysfs show handlers ignore the return value and emit the potentially
uninitialized data:

drivers/hid/hid-roccat-koneplus.c:koneplus_sysfs_show_firmware_version() {
    ...
    roccat_common2_receive(usb_dev, KONEPLUS_COMMAND_INFO,
                    &info, KONEPLUS_SIZE_INFO);
    ...
    return sysfs_emit(buf, "%d\n", info.firmware_version);
}

If the USB transfer fails, does this expose uninitialized memory to any
local user able to read the sysfs files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D1
