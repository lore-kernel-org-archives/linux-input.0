Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76E323417
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855145; cv=none; b=b3Jsve5Nqr4kbUMdVBPGtVsl+PDIzq7bEPAUll83w93ojdFiocT2XFe1T28//ssV3vZ+565M4srBFxnBsGbteF3zC31IaFZNklh79LwWeL2RYb6+ZdHxum4GhjI0tsWYqAqXGiI2yCVRDBAcjXWlbI+jP8T7w116uVQZFP1+700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855145; c=relaxed/simple;
	bh=+eYRPxPyuSLQhgA5FluhSBH5DM1N8iqQ0pviBZhorUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LB+CLxqSvuhgzCvyk6/scxSm4h6q45XNJAUM5+ZNMFguYrDZlSLp/djKAfJXEfJUdd73XS/5pvpBZfS34+iIUK5y3ZbjsuZ4lt6JjFWUCeUI0wgZVxu6bZ5bPCv2R42qOCr4Gyht9PQOQ4BxSmafLq8LCx46Ql7tuNqTjrSQEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKDFg/rJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKDFg/rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281E81F00A3A;
	Fri, 19 Jun 2026 07:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781855143;
	bh=QgwwrZk/7D7TDY2vh6wEy1+Z6gnoJ12vjKJ+oa1LJE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKDFg/rJfutzOw/Z11o6OdwCIII6L7abHZOnHW79+/JHRIHd0m/9zS2J9GFM/8XdN
	 eZ1IVnWDOlGAhb0eqWGfyNuB39bCQb4GuOEtgRSYt8X+zJElmt7Vn6lNDk6Pim8czR
	 ASt5bggI4AzSoYN27cW8u9JmLi7vJ0lx//FWNWeIvbv3xPzrXWqCJI5ayDPO5BEEiv
	 KVLjk4llNsuXikqUbfLQT+5l+Hc+QHWIq6I7Qrb0TUGDsQsQ5PQr3+U2DXhy8bmeFi
	 apkddL39F7gShtWdVzVJFdvrEDgaYjQnUR56urAoDZH3j7zow0Y56Rzr+89oxI1IDb
	 XzVv+xy3kr02w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] HID: BPF: add keyboard behavioral anomaly detection
Reply-To: sashiko-reviews@lists.linux.dev
To: krishgulati7@gmail.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260619073607.393248-1-krishgulati7@gmail.com>
References: <adSxXidgeWF0-Ewn@beelink>
 <20260619073607.393248-1-krishgulati7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 07:45:42 +0000
Message-Id: <20260619074543.281E81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Evasion of detector via large HID descriptors with padded payl=
oads.
- [High] Missing Report ID validation causes false positives and state corr=
uption on composite devices.
- [High] Mismatched report size rounding causes silent event dropping and l=
ogical out-of-bounds reads.
- [High] LRU map eviction permanently disables detection for a device inste=
ad of resetting its state.
- [High] Uninitialized padding bytes in the stack-allocated `struct dev_inf=
o` will cause the BPF verifier to reject the program.
- [High] Keystroke heuristic fails to detect keys when no empty report is s=
ent between strokes (morphed keys).
- [Medium] Missing `bpf_spin_lock` protection allows data races between con=
current `kdb_hook` or `probe` invocations.
--

commit 103b2fc551543479bbac0ff3ea588c3508776a4c
Author: Krish Gulati <krishgulati7@gmail.com>
HID: BPF: add keyboard behavioral anomaly detection

This patch implements a HID-BPF struct_ops program that detects automated
HID injection attacks. It does this by measuring post-enumeration delay
and tracking inter-keystroke timing using Welford's online variance algorit=
hm.
State is stored in an LRU hash map keyed by the HID ID.

Link: https://lore.kernel.org/linux-input/adSxXidgeWF0-Ewn@beelink/

> diff --git a/src/bpf/testing/0010-Generic__keyboard.bpf.c b/src/bpf/testi=
ng/0010-Generic__keyboard.bpf.c
> index 0000000000000..91145870768f6
> --- /dev/null
> +++ b/src/bpf/testing/0010-Generic__keyboard.bpf.c

[ ... ]

> +static __always_inline void welford(struct dev_info *dev_state,
> +				    __u64 interval_ms)
> +{
> +	__s64 x =3D (__s64)interval_ms * HID_GUARD_WELFORD_SCALE;
> +	__s64 delta, delta2, delta_abs, signed_div_res;
> +	__u64 div_res;
> +
> +	dev_state->count++;

[Severity: Medium]
Will this lockless compound update be corrupted by concurrent executions?

The dev_details LRU hash map stores per-device state which kdb_hook() reads
and modifies directly via a map value pointer locklessly. Updating Welford
variance (count, mean, M2) is a compound operation.

If kdb_hook() executes concurrently for the same device, such as across
multiple endpoints on a composite device, or if the userspace probe()
program is executed simultaneously, torn reads and writes will occur.

Does this structure require a bpf_spin_lock to prevent data races?

> +	delta =3D x - dev_state->mean;

[ ... ]

> +SEC(HID_BPF_DEVICE_EVENT)
> +int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx)
> +{
> +	__u32 hid_id =3D hctx->hid->id;
> +
> +	struct dev_info *info;
> +
> +	info =3D bpf_map_lookup_elem(&dev_details, &hid_id);
> +
> +	if (!info)
> +		return 0;

[Severity: High]
Does an LRU map eviction permanently disable detection for a device instead
of resetting its state?

The dev_details map uses BPF_MAP_TYPE_LRU_HASH with 128 max entries.
When a device is evicted, bpf_map_lookup_elem() returns NULL, and
kdb_hook() immediately returns 0, completely ignoring the event.

Because elements are only inserted by the userspace probe() program, an
evicted device is never automatically re-inserted by the kernel hook.

Could an attacker deliberately present 128 dummy HID interfaces to flood
the map, permanently evict the payload device, and bypass the guard entirel=
y?

> +
> +	__u32 size =3D info->report_size;
> +	__u32 fetch_size;
> +	__u8 *data;
> +
> +	if (size <=3D 8)
> +		fetch_size =3D 8;
> +	else if (size <=3D 16)
> +		fetch_size =3D 16;
> +	else
> +		fetch_size =3D 32;

[Severity: Critical]
Does hardcapping the analysis size to 32 bytes allow attackers to evade
detection by padding their malicious HID descriptor?

An attacker could craft a custom USB HID descriptor that defines dummy
fields or padding for the first 32 bytes, placing the actual Keyboard Usage
page array at offset 32 or higher.

The loop will only iterate over the static padding and completely ignore
the keystrokes. Meanwhile, the Linux HID subsystem correctly parses the full
report and processes the hidden keycodes, allowing arbitrary keystroke
injection that bypasses this guard.

> +
> +	data =3D hid_bpf_get_data(hctx, 0, fetch_size);
> +
> +	if (!data)
> +		return 0;

[Severity: High]
Will this size rounding cause silent event dropping and logical out-of-boun=
ds
reads?

The BPF program rounds info->report_size up to a power-of-two fetch_size
(8, 16, or 32). If a keyboard has a 9-byte report, fetch_size becomes 16.

If the kernel's ctx->allocated_size for this device is exactly 9 bytes,
hid_bpf_get_data(hctx, 0, 16) will exceed the bounds and return NULL.
The program then returns 0, silently skipping analysis for the report
while the kernel continues processing the keystrokes.

If allocated_size is large enough, the loop uses fetch_size as the upper
bound, reading past valid report data into padding or uninitialized memory,
polluting the active key tracking.

> +	int now_active_ks =3D 0, was_active_ks =3D 0;
> +#pragma unroll
> +	for (int i =3D 0; i < 32; i++) {
> +		if (i >=3D fetch_size)
> +			break;
> +		now_active_ks +=3D ((__u8)data[i] + 255) >> 8;

[Severity: High]
Will this logic indiscriminately process all incoming raw reports, even
those not belonging to the keyboard?

Many HID keyboards are composite devices, such as wireless keyboard and
mouse receivers, that send multiple report types over the same interface.

Since the report ID is observed in probe() but not stored in dev_info,
this hook counts all non-zero bytes across all input reports as keystrokes.
Mouse movements, which send reports with changing non-zero bytes, will be
incorrectly interpreted as rapid keystrokes.

Will this corrupt the Welford variance tracking and cause false positive
anomaly detections?

> +		was_active_ks +=3D ((__u8)info->prev_report[i] + 255) >> 8;
> +
> +		info->prev_report[i] =3D data[i];
> +	}
> +
> +	__u64 current_ms =3D bpf_ktime_get_ns() / HID_GUARD_NSEC_PER_MSEC;
> +
> +	if (now_active_ks > was_active_ks) {

[Severity: High]
Does this heuristic fail to detect keys when no empty report is sent
between strokes?

The detection logic relies strictly on an increase in the total number of
non-zero bytes to identify a keypress.

Automated injection tools routinely optimize injections by morphing
keycodes directly without sending an intervening empty (all-zeros) report.
If an attacker's tool changes key 'A' to key 'B' in consecutive reports,
both reports have exactly one non-zero byte.

The condition 1 > 1 evaluates to false, causing the keystroke to be missed
and bypassing the variance check entirely.

[ ... ]

> +SEC("syscall")
> +int probe(struct hid_bpf_probe_args *ctx)
> +{
> +	struct hid_rdesc_report *input;
> +	struct hid_rdesc_field *field;
> +	struct hid_rdesc_collection *col;
> +
> +	hid_bpf_for_each_input_report(&HID_REPORT_DESCRIPTOR, input) {
> +		__u32 size_in_bytes =3D (input->size_in_bits + 7) / 8;
> +
> +		bpf_printk("Report size: %d\n", size_in_bytes);
> +		if (input->report_id !=3D 0)
> +			size_in_bytes +=3D 1;

[Severity: High]
Is the report ID needed here to validate incoming reports later?

The report ID is observed here but not stored in the map, making it
impossible for kdb_hook() to distinguish between keyboard reports and
other HID reports on a composite device.

> +
> +		bpf_printk("Report size after report_id: %d\n", size_in_bytes);
> +
> +		hid_bpf_for_each_field(input, field) {
> +			hid_bpf_for_each_collection(field, col) {
> +				if (col->usage_page =3D=3D
> +					    HidUsagePage_GenericDesktop &&
> +				    col->usage_id =3D=3D HidUsage_GD_Keyboard) {
> +					__u32 key =3D ctx->hid;
> +					struct dev_info info =3D {
> +						.connection_time =3D
> +							bpf_ktime_get_ns(),
> +						.count =3D 0,
> +						.report_size =3D size_in_bytes
> +					};

[Severity: High]
Will the uninitialized padding bytes in this struct cause the BPF verifier
to reject the program?

The dev_info object is initialized using a designated initializer list.
While this zero-initializes unspecified members, it does not guarantee that
the compiler will zero the 4 bytes of padding between report_size and
prev_report.

The BPF verifier strictly tracks initialization of stack memory at the byte
level. When bpf_map_update_elem() reads the struct from the stack, the
verifier will detect the uninitialized padding and reject the program with
an 'invalid indirect read from stack' error.

Should this structure be explicitly zeroed using __builtin_memset?

> +					bpf_map_update_elem(&dev_details, &key,
> +							    &info, BPF_ANY);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619073607.3932=
48-1-krishgulati7@gmail.com?part=3D1
