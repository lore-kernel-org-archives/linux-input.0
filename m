Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC238CFE1
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119435; cv=none; b=G7Maxvl8ZC0qDryocr1IYsq8+UlPLpBlL4OBIPYQTpFxyXZ9HSpvPCOftypvgTu50m6GzyQn0RjEhVEGYCRgVN9ndvXpvJ6iKFXFlFeyVjcXmHTvk9I/EScpBHMnm07VANYKo7yNuG2Lb3DDLdacD9ZmYVA2OueOKL0a3NO9UlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119435; c=relaxed/simple;
	bh=mNerJKLU1TtlcXUHuzVOr3Iyj8YFfzSmvnqSbG9hVO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpraaayyNooW5cWtAfSOezUY2Ftq+2UJB/YbxX6N26Yrl9LRYYwONniZfwuVMXooTbW3b2EMXDZ7vhNjlqfoynQtapbsLlqTmKMXwXbh8F5vJtIaRrcgU33F5bhSah0RqROBPeHjx3TQW9bgdoLi1IVxxo/W7xEBoH1NkpGq7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD0I014C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD0I014C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43F61F000FF;
	Fri, 11 Sep 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119434;
	bh=UxBSf5AAHcHaoyW7hnkHdlkyi9YAW4p1f0PgF50Pdxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jD0I014Cb89f12qDjap3I5lv6G8vp1cATPqFx8MFEaOFg+dK8UBfN2dYck6KIkitH
	 RygDvLOGPWyquISqtpg+NmqD+gqH8KAFtZPnQvQyyrCd3E7YIPR7CrCzKQ6iJnRlPh
	 GlxvxEbh2IwLtNNV1eKuhy85tF8m5FDH9gIe9AXt1/sYzezyp3iRj7/0gZ3wCvNsw+
	 KhDssxpW0lo9to0wWkhQypac3rlZbl1YPahEg1Ek8e4EXwMmTYsJti1jK437oIQ5aa
	 7goxFmMEDCrV6KyV3nBFpjkzXO4EI4kirPv6N0QpK3a7dgICuz7sloPabSqkKgLdFL
	 33cW6qGSgxclw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] HID: sensor-hub: Fail unfinished multi-value reads
 on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Tan" <lhfff@tju.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260911092039.234253-1-lhfff@tju.edu.cn>
References: <20260911092039.234253-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:37:13 +0000
Message-Id: <20260911093713.E43F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unsynchronized cancellation of pending requests leads to stack=
 corruption or memory leaks when wait_for_completion_interruptible_timeout(=
) exits early.
- [Critical] Missing validation of `field->maxusage` in `sensor_hub_raw_eve=
nt()` allows an Out-Of-Bounds read on maliciously crafted HID descriptors.
- [Critical] Unconditional 16-byte read from HID report payload regardless =
of field size causes an Out-Of-Bounds read in dev_rot_capture_sample().
- [High] Overwriting hsdev->pending.raw_data without freeing previous alloc=
ations causes a memory leak when a report contains duplicate usages.
--

commit df43a8787a3e2f8bf5173b9ad940b826c008809a
Author: Yibo Tan <lhfff@tju.edu.cn>
Subject: HID: sensor-hub: Fail unfinished multi-value reads on removal

sensor_hub_remove() completes pending reads after stopping the HID device,
but does not record why they completed. A successful completion wait
therefore returns zero even if no complete input report was received.
Multi-value IIO callers then format their untouched automatic buffer as a
successful result.

Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tre=
e/main/cases/hid-sensor-quaternion-root-b-kaslr

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc5..687f8defa2f0d 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sens=
or_hub_device *hsdev,
>  			ret =3D -ETIMEDOUT;
>  		else if (cycles < 0)
>  			ret =3D cycles;
> +		else if (hsdev->pending.raw_size < 0)
> +			ret =3D hsdev->pending.raw_size;
> =20
>  		hsdev->pending.status =3D false;
>  	}

[Severity: Critical]
This is a pre-existing issue, but can clearing hsdev->pending.status lockle=
ssly
here and in sensor_hub_input_attr_get_raw_value() race with hardware event
processing?

If wait_for_completion_interruptible_timeout() returns early (due to a sign=
al
or timeout), the waiter thread cleans up locklessly and returns, popping the
stack frame if the buffer was stack-allocated.

Concurrently, an incoming HID report could trigger sensor_hub_raw_event() w=
hich
reads status locklessly or races before it is cleared. The interrupt handler
then writes to the now-popped stack frame using memcpy(), causing stack
corruption, or allocates new memory using kmemdup() that will never be freed
after the waiter thread calls kfree().

[ ... ]

Also looking at sensor_hub_raw_event() in drivers/hid/hid-sensor-hub.c:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
	...
	for (i =3D 0; i < report->maxfield; ++i) {
		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
				i, report->field[i]->usage->collection_index,
				report->field[i]->usage->hid,

[Severity: Critical]
This is a pre-existing issue, but is it safe to dereference usage[0] here
without verifying that the array contains any elements (i.e. maxusage > 0)?

If a maliciously crafted HID device descriptor specifies an input field wit=
h 0
usages, the HID core allocates exactly sizeof(struct hid_field) without any
trailing usages array, but field->usage is set to point directly after the
struct. Accessing report->field[i]->usage->collection_index (which is
usage[0].collection_index) would read out of bounds of the allocated slab
object.


				(report->field[i]->report_size *
					report->field[i]->report_count)/8);
		...
		if (hsdev->pending.status && ...) {
			...
			} else {
				hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);

[Severity: High]
This is a pre-existing issue, but could overwriting hsdev->pending.raw_data
without freeing previous allocations cause a memory leak if a report contai=
ns
duplicate usages?

If a single report is received containing multiple fields sharing the same =
usage
ID, sensor_hub_raw_event() iterates over all of them. For each match, if
max_raw_size is 0, it executes kmemdup() and assigns the pointer to
hsdev->pending.raw_data without calling kfree() on the previous pointer.

Since the entire loop executes synchronously under a spinlock, the waiter t=
hread
cannot free the intermediate allocations, leading to permanent leakage of a=
ll
but the last allocation.


				if (hsdev->pending.raw_data)
					hsdev->pending.raw_size =3D sz;
				else
					hsdev->pending.raw_size =3D 0;
				complete(&hsdev->pending.ready);
			}
		}
	}
}

Also looking at dev_rot_capture_sample() in drivers/iio/orientation/hid-sen=
sor-rotation.c:

drivers/iio/orientation/hid-sensor-rotation.c:dev_rot_capture_sample() {
	...
	if (usage_id =3D=3D HID_USAGE_SENSOR_ORIENT_QUATERNION) {
		if (raw_len / 4 =3D=3D sizeof(s16)) {
			...
		} else {
			memcpy(&rot_state->scan.sampled_vals, raw_data,
			       sizeof(rot_state->scan.sampled_vals));

[Severity: Critical]
This is a pre-existing issue, but are we performing an unconditional 16-byte
read here without validating that the incoming raw_data buffer is at least =
16
bytes?

If a maliciously crafted HID device descriptor specifies a quaternion field=
 with
a small size (e.g. 4 bytes total), the HID core allocates a small report bu=
ffer.
When a report is received, sensor_hub_raw_event() passes this small buffer =
to
the capture_sample callback, passing raw_len =3D 4.

Because raw_len / 4 !=3D sizeof(s16) (1 !=3D 2), the callback takes the els=
e branch
and calls memcpy(&rot_state->scan.sampled_vals, raw_data, 16), reading 12 b=
ytes
past the end of the small HID report buffer. This can leak kernel heap cont=
ents
to the userspace IIO buffer.


		}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911092039.2342=
53-1-lhfff@tju.edu.cn?part=3D1
