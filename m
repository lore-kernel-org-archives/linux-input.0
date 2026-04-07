Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FB3A381A;
	Tue,  7 Apr 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548779; cv=none; b=Ozox7WiTiBUTG7XW4xDty6dvE3OPZRyVoTbSBf3QMLAfTBkNHNolHHNFDaq88Qr7PQUeya4u/g1xDqu5DoCaBrL0+Jb0iBYPN62MoNqAuSbxmNH4/PKj3o0VjZQlHzX49eAPBOLY9M9p81BeYRLU6B4l05SUF0lbqag3s/0jajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548779; c=relaxed/simple;
	bh=zhhTeBpFoUG8VaBKsvUgNyjLqgc044+xIspskNWKVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtQyT8Rxk88FTsbtH/MLrWXH4CxZyigQyHUvEYo1G4ucxerKtliiWjZS0xmsYsU9PpOHxNOMDjc9es71KEo16UFdxeX5RaXQWxrsiZPK9C5zeZ6Vy+R1Rm2fLKoJTyyxx9FMwu62hCHBmdXVLWlVmamZPLU9gzjM/fCm9QzhmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egtwvSYg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egtwvSYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD93C116C6;
	Tue,  7 Apr 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775548778;
	bh=zhhTeBpFoUG8VaBKsvUgNyjLqgc044+xIspskNWKVP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egtwvSYgyOmREZVPD7UcnwT4S1by9tY5VEXmmqWHqCg5VRgU9mWN+YY+PpQ3w//vF
	 WgwTbsJuiGlNbI+5YN16kZJFLaZssm48pORAB5I0xS3g91B5AO/OncXA9jKReFBQvv
	 1R/JiD2ZjRcP4TSsUiqWgVTPmLv0EyIpxdmG29Jg+htqwWvFk/s4go/tTwrwdeYitW
	 l+2S1uFE70M2ui61W/+i0nUnnG4IakgeG6LX2hvyyJgNFGcTx1K5zg8D7SIZUkO3zg
	 DF7uekyvD9Qfd8rT9gWoQSP68j+rm7K8W4fwEhrfM0M0bUiHU6lQ6mJIVzInOfQcWo
	 jecqK7LORQBow==
Date: Tue, 7 Apr 2026 09:59:34 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Zubeyr Almaho <zybo1000@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH v2 1/1] HID: add malicious HID device detection driver
Message-ID: <adSxXidgeWF0-Ewn@beelink>
References: <20260404133746.80914-1-zybo1000@gmail.com>
 <20260404133746.80914-2-zybo1000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404133746.80914-2-zybo1000@gmail.com>

Hi,

On Apr 04 2026, Zubeyr Almaho wrote:
> Add a passive HID driver that computes a suspicion score for keyboard-like
> USB devices based on:
> 
> - low keystroke timing entropy,
> - immediate post-enumeration typing,
> - known suspicious VID/PID and descriptor anomalies.
> 
> If the score exceeds a tunable threshold, the driver emits a warning and
> suggests userspace blocking (e.g. usbguard). The module never blocks or
> modifies HID events.
> 
> Signed-off-by: Zubeyr Almaho <zybo1000@gmail.com>

As Greg said, a HID-BPF program would be far better in terms of scope
because there are numerous pitfal in your implementation.

The question will be how to notify userspace of the suspicious HID
device in HID-BPF, but here, you are also just emitting a dmesg warning,
so it's not doing much either.

Anyway, comments inline, but please reach out to the end where I explain
why the implementation can't work in it's current state.

> ---
>  drivers/hid/hid-omg-detect.c | 435 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)
>  create mode 100644 drivers/hid/hid-omg-detect.c
> 
> diff --git a/drivers/hid/hid-omg-detect.c b/drivers/hid/hid-omg-detect.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-omg-detect.c
> @@ -0,0 +1,435 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * hid-omg-detect.c - Malicious HID Device Detection Kernel Module
> + *
> + * Detects O.MG Cable and similar BadUSB devices by combining:
> + *   1. Keystroke timing entropy analysis (human vs machine rhythm)
> + *   2. Plug-and-type detection (typing immediately after connect)
> + *   3. USB descriptor fingerprinting (known bad VID/PIDs + anomalies)
> + *
> + * When suspicion score >= threshold, logs a kernel warning and suggests
> + * blocking the device with usbguard.
> + *
> + * The driver is purely passive — it does not drop, modify, or delay any
> + * HID events.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hid.h>
> +#include <linux/usb.h>
> +#include <linux/ktime.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/math64.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zübeyr Almaho <zybo1000@gmail.com>");
> +MODULE_DESCRIPTION("O.MG Cable / Malicious HID Device Detector");
> +
> +/* ============================================================
> + * Tuneable parameters (pass as insmod args)
> + * ============================================================ */

I'm pretty sure checkpatch.pl would complain about those multiline
comments.

> +static int score_threshold = 70;
> +module_param(score_threshold, int, 0644);
> +MODULE_PARM_DESC(score_threshold,
> +	"Suspicion score (0-100) to trigger alert (default: 70)");
> +
> +static int plug_type_ms = 500;
> +module_param(plug_type_ms, int, 0644);
> +MODULE_PARM_DESC(plug_type_ms,
> +	"Max ms after connect before first key = plug-and-type (default: 500)");
> +
> +static int entropy_variance_low = 500;
> +module_param(entropy_variance_low, int, 0644);
> +MODULE_PARM_DESC(entropy_variance_low,
> +	"Variance (us^2) below which typing is machine-like (default: 500)");
> +
> +/* ============================================================
> + * Constants
> + * ============================================================ */
> +#define DRIVER_NAME		"hid_omg_detect"
> +#define MAX_TIMING_SAMPLES	64
> +#define MIN_SAMPLES		10
> +
> +/* ============================================================
> + * Known suspicious VID/PID pairs (O.MG Cable, Rubber Ducky, etc.)
> + * ============================================================ */
> +static const struct {
> +	u16 vid;
> +	u16 pid;
> +	const char *name;
> +} suspicious_ids[] = {
> +	{ 0x16c0, 0x27db, "O.MG Cable (classic)" },
> +	{ 0x1209, 0xa000, "O.MG Cable (Elite)" },
> +	{ 0x16c0, 0x27dc, "USB Rubber Ducky" },
> +	{ 0x1b4f, 0x9208, "LilyPad Arduino BadUSB" },
> +};
> +
> +/* ============================================================
> + * Per-device state (allocated on probe, freed on remove)
> + * ============================================================ */
> +struct omg_device_state {
> +	struct hid_device  *hdev;
> +
> +	/* --- connection timing --- */
> +	ktime_t		connect_time;
> +	ktime_t		first_key_time;
> +	bool		first_key_seen;
> +
> +	/* --- keystroke interval circular buffer --- */
> +	ktime_t		last_key_time;
> +	s64		intervals_us[MAX_TIMING_SAMPLES];
> +	unsigned int	sample_count;
> +	unsigned int	sample_head;
> +
> +	/* --- USB info (immutable after probe) --- */
> +	u16		vid;
> +	u16		pid;
> +	const char	*vid_pid_match_name;	/* non-NULL if VID/PID matched */
> +	bool		descriptor_anomaly;
> +
> +	/* --- verdict --- */
> +	int		score;
> +	bool		alerted;
> +
> +	spinlock_t	lock;
> +};
> +
> +/* ============================================================
> + * Math helpers
> + * ============================================================ */
> +static void timing_stats(struct omg_device_state *s, s64 *mean, s64 *variance)
> +{
> +	unsigned int i, n;
> +	s64 sum = 0, sq = 0, m;
> +
> +	n = min(s->sample_count, (unsigned int)MAX_TIMING_SAMPLES);
> +
> +	if (n < 2) {
> +		*mean = 0;
> +		*variance = 0;
> +		return;
> +	}
> +
> +	for (i = 0; i < n; i++)
> +		sum += s->intervals_us[i];
> +	m = div_s64(sum, n);
> +
> +	for (i = 0; i < n; i++) {
> +		s64 d = s->intervals_us[i] - m;
> +
> +		sq += d * d;
> +	}
> +
> +	*mean     = m;
> +	*variance = div_s64(sq, n);
> +}
> +
> +/* ============================================================
> + * Signal 1: Timing entropy
> + *
> + * Humans: high variance (pauses, rhythm changes)
> + * Machines: low variance (constant clock)
> + *
> + * Also penalises extremely fast consistent typing (mean < 15 ms).
> + * ============================================================ */
> +static int score_entropy(struct omg_device_state *s)
> +{
> +	s64 mean, var;
> +	int pts = 0;
> +
> +	if (s->sample_count < MIN_SAMPLES)
> +		return 0;
> +
> +	timing_stats(s, &mean, &var);
> +
> +	if (var < (s64)entropy_variance_low)
> +		pts += 35;
> +	else if (var < (s64)entropy_variance_low * 10)
> +		pts += 20;
> +	else if (var < (s64)entropy_variance_low * 40)
> +		pts += 8;
> +
> +	if (mean > 0 && mean < 5000)
> +		pts += 25;
> +	else if (mean > 0 && mean < 15000)
> +		pts += 10;
> +
> +	return min(pts, 60);
> +}
> +
> +/* ============================================================
> + * Signal 2: Plug-and-type
> + *
> + * A legitimate keyboard sits idle for a while after connect.
> + * A script device starts injecting within milliseconds.
> + * ============================================================ */
> +static int score_plug_type(struct omg_device_state *s)
> +{
> +	s64 delta_ms;
> +
> +	if (!s->first_key_seen)
> +		return 0;
> +
> +	delta_ms = ktime_to_ms(ktime_sub(s->first_key_time, s->connect_time));
> +
> +	if (delta_ms < 100)
> +		return 30;
> +	if (delta_ms < (s64)plug_type_ms)
> +		return 15;
> +	if (delta_ms < 2000)
> +		return 5;
> +
> +	return 0;
> +}
> +
> +/* ============================================================
> + * Signal 3: USB descriptor fingerprint
> + * ============================================================ */
> +static int score_descriptor(struct omg_device_state *s)
> +{
> +	int pts = 0;
> +
> +	if (s->vid_pid_match_name)
> +		pts += 50;
> +
> +	if (s->descriptor_anomaly)
> +		pts += 20;
> +
> +	return min(pts, 50);
> +}
> +
> +/* ============================================================
> + * Combine all signals and return per-signal breakdown.
> + * Caller is responsible for alerting outside any lock.
> + * ============================================================ */
> +struct omg_score_result {
> +	int entropy;
> +	int plug_type;
> +	int descriptor;
> +	int total;
> +	bool newly_alerted;
> +};
> +
> +static void compute_score(struct omg_device_state *s,
> +			   struct omg_score_result *res)
> +{
> +	res->entropy   = score_entropy(s);
> +	res->plug_type = score_plug_type(s);
> +	res->descriptor = score_descriptor(s);
> +	res->total     = min(res->entropy + res->plug_type + res->descriptor,
> +			     100);
> +
> +	s->score = res->total;
> +	res->newly_alerted = false;
> +
> +	if (res->total >= score_threshold && !s->alerted) {
> +		s->alerted = true;
> +		res->newly_alerted = true;
> +	}
> +}
> +
> +/* Emit alert outside of spinlock */
> +static void emit_alert(struct hid_device *hdev,
> +		       struct omg_device_state *s,
> +		       const struct omg_score_result *res)
> +{
> +	hid_warn(hdev, "=============================================\n");
> +	hid_warn(hdev, "!! SUSPICIOUS HID DEVICE DETECTED !!\n");
> +	hid_warn(hdev, "Device : %s\n", hdev->name);
> +	hid_warn(hdev, "VID/PID: %04x:%04x\n", s->vid, s->pid);
> +	if (s->vid_pid_match_name)
> +		hid_warn(hdev, "Match  : %s\n", s->vid_pid_match_name);
> +	hid_warn(hdev, "Score  : %d/100  (threshold=%d)\n",
> +		 res->total, score_threshold);
> +	hid_warn(hdev, "  Entropy      : %d pts\n", res->entropy);
> +	hid_warn(hdev, "  Plug-and-type: %d pts\n", res->plug_type);
> +	hid_warn(hdev, "  Descriptor   : %d pts\n", res->descriptor);
> +	hid_warn(hdev, "Action : sudo usbguard block-device <id>\n");
> +	hid_warn(hdev, "=============================================\n");
> +}
> +
> +/* ============================================================
> + * HID raw_event hook — called for every incoming HID report
> + *
> + * This runs in softirq/BH context — no sleeping locks allowed.
> + * ============================================================ */
> +static int omg_raw_event(struct hid_device *hdev,
> +			 struct hid_report *report,
> +			 u8 *data, int size)
> +{
> +	struct omg_device_state *s = hid_get_drvdata(hdev);
> +	struct omg_score_result res;
> +	ktime_t now;
> +	unsigned long flags;
> +	bool keystroke = false;
> +	int i;
> +
> +	if (!s)
> +		return 0;
> +
> +	if (report->type != HID_INPUT_REPORT)
> +		return 0;
> +
> +	/* Byte 0 = modifier, byte 1 = reserved, bytes 2-7 = keycodes */

That's a strong assumption. This actually depend on the report
descriptor of the device and what you said is generally true for USB
keyboards, but not all of HID devices behave like that:
- bluetooth keyboards usually have a report ID in byte 0
- some devices are reporting gyro data, so they are sending a stream of
	events which would likely be tagged as "suspicious"
- some devices are reporting touch information, and as such they are
	also reporting a constant stream of events as long as at least one
	finger is touching the sensor
- yubikeys, other security keys and gaming devices are devices
	specifically tailored to send a stream of events, being a keyboard
	macro, or a one time password, or a stored passwored in the key
- not all devices are keyboards :)

> +	for (i = 2; i < size && i < 8; i++) {
> +		if (data[i] != 0) {
> +			keystroke = true;
> +			break;
> +		}
> +	}
> +	if (size > 0 && data[0] != 0)
> +		keystroke = true;
> +
> +	if (!keystroke)
> +		return 0;
> +
> +	now = ktime_get();
> +
> +	spin_lock_irqsave(&s->lock, flags);

Why spin_locking?

> +
> +	if (!s->first_key_seen) {
> +		s->first_key_seen = true;
> +		s->first_key_time = now;
> +		s->last_key_time  = now;
> +	} else {
> +		s64 interval = ktime_to_us(ktime_sub(now, s->last_key_time));
> +
> +		/* ignore idle gaps > 10 s */
> +		if (interval < 10000000LL) {
> +			s->intervals_us[s->sample_head] = interval;
> +			s->sample_head =
> +				(s->sample_head + 1) % MAX_TIMING_SAMPLES;
> +			if (s->sample_count < MAX_TIMING_SAMPLES)
> +				s->sample_count++;
> +		}
> +		s->last_key_time = now;
> +	}
> +
> +	compute_score(s, &res);
> +
> +	spin_unlock_irqrestore(&s->lock, flags);
> +
> +	/* Alert outside the spinlock — hid_warn may sleep */
> +	if (res.newly_alerted)
> +		emit_alert(hdev, s, &res);
> +
> +	return 0;
> +}
> +
> +/* ============================================================
> + * HID probe — device connected
> + * ============================================================ */
> +static int omg_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	struct omg_device_state *s;
> +	struct usb_interface *intf;
> +	struct usb_device *udev;
> +	struct omg_score_result res;
> +	int ret, i;
> +
> +	if (hdev->bus != BUS_USB)
> +		return -ENODEV;

Why restricting to BUS_USB only? Bluetooth could be a strong acttack
vector as well.

> +
> +	s = kzalloc(sizeof(*s), GFP_KERNEL);

devm_kzalloc?

> +	if (!s)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&s->lock);
> +	s->hdev         = hdev;
> +	s->connect_time = ktime_get();
> +
> +	/* Extract USB descriptor info */
> +	intf = to_usb_interface(hdev->dev.parent);

You can't call that function unless you are sure that you are talking to
ta USB device. If the user is using a uhid device (because they are
replaying another), the transport driver is not usbhid, and you'll end
up with a lot of issues.

There is a function for checking if the transport is usb: hid_is_usb()

> +	udev = interface_to_usbdev(intf);
> +	s->vid = le16_to_cpu(udev->descriptor.idVendor);
> +	s->pid = le16_to_cpu(udev->descriptor.idProduct);
> +
> +	/* Check known bad VID/PID table (once, at probe time) */
> +	for (i = 0; i < ARRAY_SIZE(suspicious_ids); i++) {
> +		if (s->vid == suspicious_ids[i].vid &&
> +		    s->pid == suspicious_ids[i].pid) {
> +			s->vid_pid_match_name = suspicious_ids[i].name;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Anomaly: legitimate HID keyboards use bDeviceClass = 0x00
> +	 * (class defined at interface level).  Any other value here
> +	 * for a device presenting as a keyboard is suspicious.
> +	 */
> +	s->descriptor_anomaly =
> +		(udev->descriptor.bDeviceClass != 0x00 &&
> +		 udev->descriptor.bDeviceClass != 0x03);
> +
> +	hid_set_drvdata(hdev, s);
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid_parse failed: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "hid_hw_start failed: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	hid_info(hdev, "Monitoring %s (VID=%04x PID=%04x%s%s)\n",
> +		 hdev->name, s->vid, s->pid,
> +		 s->vid_pid_match_name ? " KNOWN-BAD:" : "",
> +		 s->vid_pid_match_name ? s->vid_pid_match_name : "");
> +
> +	if (s->descriptor_anomaly)
> +		hid_warn(hdev, "Descriptor anomaly: bDeviceClass=0x%02x\n",
> +			 udev->descriptor.bDeviceClass);
> +
> +	/* Run initial descriptor-only score */
> +	compute_score(s, &res);
> +	if (res.newly_alerted)
> +		emit_alert(hdev, s, &res);
> +
> +	return 0;
> +
> +err_free:
> +	hid_set_drvdata(hdev, NULL);
> +	kfree(s);

no need to free when using devm_kzalloc.

> +	return ret;
> +}
> +
> +/* ============================================================
> + * HID remove — device disconnected
> + * ============================================================ */
> +static void omg_remove(struct hid_device *hdev)
> +{
> +	struct omg_device_state *s = hid_get_drvdata(hdev);
> +
> +	hid_hw_stop(hdev);
> +
> +	if (s) {
> +		hid_info(hdev, "Removed %s (final score: %d/100)\n",
> +			 hdev->name, s->score);
> +		hid_set_drvdata(hdev, NULL);
> +		kfree(s);
> +	}
> +}

this omg_remove() function can be removed entirely when using
devm_kzalloc.

> +
> +/* Match all USB HID devices — we inspect and score them all */
> +static const struct hid_device_id omg_table[] = {
> +	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },

ouch. Very much ouch:
You are binding to any USB device, but you don't have implemented a
.match callback, meaning that you are racing with any other driver to
take the ownership of a USB device.

This is where your plan falls completely. There can only be one HID
driver attached to a specific HID device. And we have multiple HID
drivers in the subsystem. So either they get their fixes (the original
HID driver), either they'll get the new security driver but they can not
have both. And even worse, there is no guarantee one driver will be
loaded before the other.

hid-generic is a special case as this is a fallback driver. So
hid-generic is capable of unbinding itself to let device specific
drivers to take over the device. But here, that driver just takes
ownership and can't release it (otherwise it's pointless).

So definitively, addressing that problem at the driver level is the
wrong place:
- either make it a HID core feature, but it'll be harder to sell IMO
- either make it a separate module that HID core calls in: slightly
	easier to sell, but still hard
- either work at the HID-BPF level: much better because you'll need some
	userspace eventually and this way you control from userpsace both the
	HID-BPF program and your userspace part

I've recently added the parsed report descriptor injection during probe
in the HID-BPF program (assuming you use udev-hid-bpf to load HID-BPF).
So in theory, you can create a HID-BPF which would matches on keyboards,
chose which bytes are interesting to look at and then bind on those *in
addition* to any kernel driver. It happens before any kernel processing
so you've got the raw event stream and can decide to block or not the
stream.

Anyway, even with the various issues I mentioned in the code, this
present version can't be merged, as long as you are using a HID driver.

Cheers,
Benjamin

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, omg_table);
> +
> +static struct hid_driver omg_driver = {
> +	.name      = DRIVER_NAME,
> +	.id_table  = omg_table,
> +	.probe     = omg_probe,
> +	.remove    = omg_remove,
> +	.raw_event = omg_raw_event,
> +};
> +
> +module_hid_driver(omg_driver);
> 
