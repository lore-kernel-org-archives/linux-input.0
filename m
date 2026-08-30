Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71C2690EC
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102594; cv=none; b=m41AyF173vu6dYOJOqpHadOIIc38nhj9GRhvf58aEkVPrdnA1kRLp0tagNm3a4CB9HeE8ocgCNjXUXQ8zwEsOF6E9W68vw/ByPtoa9Z94GZoT3gbD8hXIIxKD9Ha9MRuS30RRIitEO0QD5bNCjxK0lDaPSc+QZK0W2AaL0N4nFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102594; c=relaxed/simple;
	bh=9FCYv69xeuCYxhoEjgHB/ewu1MZTiKa9zt2dsFcJWjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GsLRnJoFb2qjIPqbnobCdL29NmgaRCn1aaOOOpfeBkF/PbFrIYj5ppSUiSLWoFJkgFPOw4xAboaANV7jLPMlKHYGJ0xa0EgsNgUkC4WZf21pYlEYNBxaioqKrS2GHTU3F5tb1tpg9aazhhL/FV8h3CQDWmnSh3oqQ4oZbpuwV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVFx30/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVFx30/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B431F000E9;
	Sun, 30 Aug 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102592;
	bh=igVtH58LpW64sTTCKmGk2zfrPqbEgErQ9sf5IUg3WXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FVFx30/fcC8bY6fGNPosZF4VFG4t537z/NgupI62essysWd7+O4aISeDJCugb1gcO
	 coCajFzOXHbExloEXhadjQ+IysQ5gLMCLeB9vGUgIzbmOwzNaRrgOnBb6B61lZj0dV
	 iI5927CHKc9z2ZAfc80cde/H6tF7EwX2e94grd8gKnZuR3WYS3e2s1gGMhsZvtUMOj
	 IyvEiFpsTW52vDVusp9ica9w2UbrPyWHdfJqovMp0paM2qb4D8r0nRMiG5SYm/QuTl
	 qcX7LyYTSpmqtRsxyvEH1f0AWAER2x3NR4bm9/IqVGmnW23O1a9QfOFVlQXIWYh07Y
	 +Th2htotTZZwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] HID: hid-lenovo-go: return configuration request
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <a18c5147dc7a0699523c62013d64cd1d8ec40690.1788096668.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <a18c5147dc7a0699523c62013d64cd1d8ec40690.1788096668.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:09:51 +0000
Message-Id: <20260830150952.05B431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The newly added spinlock and completion are accessed by the raw ev=
ent handler before they are initialized, causing a potential kernel crash.

Pre-existing issues:
- [High] Missing cleanup on probe failure leaves the hardware started, the =
device open, and sysfs groups leaked.
- [High] Missing hardware stop in remove for devices with no endpoints.
- [High] Global static `drvdata` structure causes state corruption and kern=
el panics when multiple devices are connected.
- [High] ABBA deadlock between device removal and sysfs attribute stores.
- [High] Possible out-of-bounds array access in get_endpoint_address if USB=
 interface has no endpoints.
--

commit 0d711ce676d4cb403114e39243d7e14be625eec6
Author: Aditya Dash <mradityadash@gmail.com>
Subject: HID: hid-lenovo-go: return configuration request errors

This commit adds a mechanism to track pending command state and correctly
match configuration replies by command ID, sub-command, and device. It
ensures that unrelated replies, errors, timeouts, or interrupted waits are
properly reported as errors to the caller rather than silently returning
success.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b937d11dd6f6a..dbfacbb70394b 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -31,13 +32,27 @@
>  #include "hid-ids.h"
> =20
>  #define GO_GP_INTF_IN		0x83
> +#define GO_INPUT_REPORT_ID	0x04
> +#define GO_OUTPUT_REPORT_ID	0x05
>  #define GO_GP_RESET_SUCCESS	0x01
>  #define GO_PACKET_SIZE		64
> +#define GO_COMMAND_TIMEOUT_MS	50
> +
> +/* Lenovo replies identify a command and a sub-command, but have no sequ=
ence. */
> +struct hid_go_cmd {
> +	struct completion done;
> +	spinlock_t lock; /* protects fields below */
> +	bool pending;
> +	u8 id;
> +	u8 command;
> +	u8 sub_command;
> +	u8 device;
> +	int result;
> +};
> =20
>  static struct hid_go_cfg {
>  	struct delayed_work go_cfg_setup;
> -	struct completion send_cmd_complete;
> +	struct hid_go_cmd cmd;
>  	struct led_classdev *led_cdev;
>  	struct hid_device *hdev;

[Severity: High]
This is a pre-existing issue, but the entire driver state is defined as a
single global variable instead of per-device driver data. Does this cause
state corruption or kernel panics when multiple supported devices are
connected simultaneously?

[ ... ]

> @@ -331,6 +346,62 @@ static const char *const os_mode_text[] =3D {
>  	[LINUX] =3D "linux",
>  };
> =20
> +static void hid_go_cmd_arm(u8 id, u8 command, u8 sub_command, u8 device)
> +{

[ ... ]

> +static void hid_go_cmd_consume(const struct command_report *cmd_rep, int=
 result)
> +{
> +	guard(spinlock_irqsave)(&drvdata.cmd.lock);
> +
> +	if (drvdata.cmd.pending && cmd_rep->id =3D=3D drvdata.cmd.id &&

[Severity: High]
Can hid_go_raw_event() be triggered by an early interrupt before
hid_go_cfg_probe() runs?

Since hid_hw_start() and hid_hw_open() are called during device probe,
the hardware can generate interrupts before hid_go_cfg_probe() initializes
this spinlock.

If an early interrupt arrives, it will call hid_go_raw_event()
and then hid_go_cmd_consume(), which locks drvdata.cmd.lock.

Locking an uninitialized spinlock will lead to lock corruption or kernel cr=
ashes.

[ ... ]

> @@ -654,7 +725,7 @@ static int hid_go_raw_event(struct hid_device *hdev, =
struct hid_report *report,
>  	struct command_report *cmd_rep;
>  	int ep, ret;
> =20
> -	if (size !=3D GO_PACKET_SIZE)
> +	if (size !=3D GO_PACKET_SIZE || data[0] !=3D GO_INPUT_REPORT_ID)
>  		goto passthrough;
> =20
>  	ep =3D get_endpoint_address(hdev);

[Severity: High]
This is a pre-existing issue, but does get_endpoint_address() safely handle
USB interfaces with zero endpoints?

In get_endpoint_address():

    ep =3D intf->cur_altsetting->endpoint;
    if (!ep)
        return -ENODEV;
    return ep->desc.bEndpointAddress;

If a malformed USB interface reports 0 endpoints (bNumEndpoints =3D=3D 0), =
the
endpoint array might be a 0-length array. The if (!ep) check only verifies
the pointer isn't NULL, but accessing ep->desc.bEndpointAddress on an empty
array could read memory out of bounds.

[ ... ]

> @@ -2362,9 +2426,12 @@ static int hid_go_cfg_probe(struct hid_device *hde=
v,
>  	if (!buf)
>  		return -ENOMEM;
> =20
> +	mutex_init(&drvdata.cfg_mutex);
> +	init_completion(&drvdata.cmd.done);
> +	spin_lock_init(&drvdata.cmd.lock);
> +	drvdata.cmd.pending =3D false;
>  	hid_set_drvdata(hdev, &drvdata);
>  	drvdata.hdev =3D hdev;
> -	mutex_init(&drvdata.cfg_mutex);

[Severity: High]
This is a pre-existing issue, but this unconditionally re-initializes global
synchronization primitives (and the newly added drvdata.cmd.lock and
drvdata.cmd.done).

If a second device is plugged in while the first is active, will this corru=
pt
the wait queues and lock states of the first device?

[ ... ]

> @@ -2388,8 +2455,6 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
> =20
>  	drvdata.led_cdev =3D &go_cdev_rgb.led_cdev;
> =20
> -	init_completion(&drvdata.send_cmd_complete);
> -
>  	/* Executing calls prior to returning from probe will lock the MCU. Sch=
edule
>  	 * initial data call after probe has completed and MCU can accept calls.
>  	 */

[Severity: High]
This is a pre-existing issue, but does failing here or later in hid_go_prob=
e()
leave the hardware running and resources leaked?

If schedule_delayed_work() fails (or if hid_go_cfg_probe() fails earlier),
the error is returned but the error paths do not call hid_hw_stop(),
hid_hw_close(), or clean up the manually created sysfs groups.

This leaves the hardware in an active state and leaks resources upon device
removal.


I also noticed a few other pre-existing issues in the driver outside the sc=
ope
of this patch:

[Severity: High]
This is a pre-existing issue, but does hid_go_remove() safely tear down
the hardware for all devices?

In hid_go_remove():

    int ep =3D get_endpoint_address(hdev);

    if (ep <=3D 0)
        return;

If get_endpoint_address() fails and returns <=3D 0, the function immediately
returns without calling hid_hw_close() and hid_hw_stop(). This prevents
the driver from tearing down the hardware properly, leaving active interfac=
es
unrestored and leaking open counts when the device is unregistered.

[Severity: High]
This is a pre-existing issue, but can hid_go_cfg_remove() deadlock with
concurrent sysfs operations?

In hid_go_cfg_remove():

    guard(mutex)(&drvdata.cfg_mutex);
    sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

If userspace writes to a sysfs attribute, kernfs acquires an active referen=
ce
for the file and calls mcu_property_out(), which blocks waiting for
drvdata.cfg_mutex. During device removal, hid_go_cfg_remove() acquires
drvdata.cfg_mutex first and then calls sysfs_remove_groups(), which blocks
waiting for all active kernfs references to drain, causing an ABBA deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D3
