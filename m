Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE390283FD9;
	Tue, 30 Jun 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827886; cv=none; b=LFMy+H/B47TBcojF3jw3gVu4/497EwI+K3KenewH3/11fbmOq/UMp/nRwhg++4BroGso2ImCtDAcdThbww9Ed4w42qFuhV3PldPqnAYTzwL24Xai9/zc8eyNJ7/PjCFRwUFS5dXv3X1tO5epOT/QeNIIhtnpaof/twMFNSkOk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827886; c=relaxed/simple;
	bh=PSQxQ4akFmmyR2PhhnlYsv42ZGE3LJJ7clgg23SFKYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwAHN88vDKCG9BuVeRgNUesYSwvTP01lihtyytWRgBo913z3Nh6w/ErNGUWAIoRrSiz4VxKK3vJT3bah5GkwGXKvKjf2hS4RxIoAQJbAqCSUjz/uopoDuA0TklXuUYSeTSf6RCB35R3DbqaewQHkxi+eVhlyzsqqqzX8m8pApvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3TUXrvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3TUXrvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39741F000E9;
	Tue, 30 Jun 2026 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827884;
	bh=i0WyWlTxWTzUX3Pom7M+EpE3G1f/6rB5cRpuG1sDm+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3TUXrvFNoD/0j9ErCNLD2YYOFgkD5/GK+HeNcKocCyBbqMhMcxkrgh+NkE1EJVNX
	 VyuaupgKyezwNlWgON4Vne2abG7IwgTm9gvLiC8hLIirgZ8yDgOSMRRQe6gIL6vTvU
	 dNjTTiVgGzWrolgtXXKVQm9nbrEjpnJksc1mpuWqNTAiDYgls1P/F4je2GUJWOEbqm
	 FJ1SrZ6iSCmqvHPxtGKR3AHLKmnQ3GhHnNK+CXUmJFmj187iacPdEWlah7Dvc9Mqyu
	 coK97RuKh65vDZAEGC+tBWbF/zmvEPcmsfYCCVU9qJRqtWyky0X90RFPRUEtf445Vx
	 mcd1IoAyEwoIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves via B4 Relay" <devnull+michael.reeves077.gmail.com@kernel.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:58:03 +0000
Message-Id: <20260630135803.F39741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Flawed teardown ordering in dchid_remove leads to Use-After-Free o=
f HID devices and transport channel.
- [High] dchid_raw_request returns an unvalidated length from the device, l=
eading to a heap out-of-bounds read in hidraw.
- [High] Missing null-termination enforcement on hardware-provided interfac=
e name leads to an out-of-bounds read.
- [High] Concurrency flaws in dchid_cmd lead to kernel log spam and state c=
orruption.
- [High] Unbounded devres memory allocation in dchid_handle_descriptor allo=
ws device to exhaust kernel memory.
- [High] Missing memory barriers when publishing and reading dchid->ifaces =
array causes a potential crash on weakly ordered architectures.
- [Medium] dchid_raw_request returns incorrect length for HID_REQ_SET_REPOR=
T, causing false short write errors.
- [Medium] Missing cleanup for the ASC coprocessor and RTKit on probe error=
 paths.
- [Low] Native pointer assignment writes the checksum in host byte order, c=
ausing failures on Big-Endian systems.
--

commit 73972b8194e713fd30c0d82321eb7f0553221fd5
Author: Michael Reeves <michael.reeves077@gmail.com>

HID: apple: Add DockChannel HID transport driver

This commit adds a transport driver that boots the MTP RTKit coprocessor,
exchanges HID packets through the DockChannel mailbox, and registers child
HID interfaces from devicetree.

> diff --git a/drivers/hid/dockchannel/apple-hid.c b/drivers/hid/dockchanne=
l/apple-hid.c
> index 0000000000000..162fcfb5ab1ce
> --- /dev/null
> +++ b/drivers/hid/dockchannel/apple-hid.c

[ ... ]

> +static struct dchid_iface *
> +dchid_get_interface(struct dchid_dev *dchid, int index, const char *name)
> +{

[ ... ]

> +	iface->index =3D index;
> +	iface->name =3D devm_kstrdup(dchid->dev, name, GFP_KERNEL);

[Severity: High]
Can this cause an out-of-bounds read if the hardware sends a name that is
exactly 16 characters and not null-terminated? In dchid_handle_init(), the
device provides a fixed 16-byte character array for hdr->name. If it lacks a
null terminator, devm_kstrdup() will read past the end of the array into
adjacent fields. Should this use devm_kstrndup(..., 16, ...) instead?

[ ... ]

> +	dchid->ifaces[index] =3D iface;
> +	mutex_unlock(&dchid->ifaces_lock);
> +	return iface;
> +}

[Severity: High]
Does the absence of a memory barrier here allow the reader to observe an
uninitialized interface? The interface is published to the array here and
the mutex is unlocked, but dchid_process_packet() reads this array lockless=
ly.
The mutex_unlock() does not prevent the compiler or CPU from reordering the
initialization of the structure (like iface->wq) to after the pointer becom=
es
visible. Should smp_store_release() be used when publishing to the array?

[ ... ]

> +static int dchid_send(struct dchid_iface *iface, u32 flags, const void *=
msg,
> +		      size_t size)
> +{

[ ... ]

> +	*checksum_ptr =3D 0xffffffff - dchid_checksum(buf, total_len - DCHID_CH=
ECKSUM_LEN);

[Severity: Low]
Does this write the checksum in the CPU's native byte order rather than
the expected little-endian format? Since other fields like hdr->length use
__le16, it appears the hardware expects little-endian, which could cause
packets to be dropped on big-endian architectures. Should this use
put_unaligned_le32() instead?

[ ... ]

> +static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
> +		     void *data, size_t size, void *resp_buf, size_t resp_size)
> +{

[ ... ]

> +	/* Only one command can be in flight per interface */
> +	if (WARN_ON(iface->out_report !=3D -1)) {
> +		spin_unlock_irqrestore(&iface->out_lock, flags);
> +		return -EBUSY;
> +	}

[Severity: High]
Can userspace easily trigger this WARN_ON and spam the kernel log by issuing
concurrent hidraw ioctls? Furthermore, is there a race window here? In
dchid_handle_ack(), iface->out_report is cleared before the waiting thread
completes its cleanup. This could allow a second concurrent thread to bypass
this check and set up its own command, only to have its state clobbered when
the first thread finally wakes up.

[ ... ]

> +static int dchid_set_report(struct dchid_iface *iface, void *buf, size_t=
 len)
> +{
> +	return dchid_cmd(iface, HID_OUTPUT_REPORT, REQ_SET_REPORT, buf, len,
> +			 NULL, 0);
> +}

[Severity: Medium]
Does returning the result of dchid_cmd() here cause false short-write errors
for userspace? The HID core expects the raw_request function for a SET_REPO=
RT
call to return the number of bytes written (the requested length). However,
dchid_cmd() returns the length of the device's ACK payload, which is typica=
lly
just 1 byte.

[ ... ]

> +static int dchid_raw_request(struct hid_device *hdev, unsigned char repo=
rtnum,
> +			     __u8 *buf, size_t len, unsigned char rtype,
> +			     int reqtype)
> +{
> +	struct dchid_iface *iface =3D hdev->driver_data;
> +
> +	switch (reqtype) {
> +	case HID_REQ_GET_REPORT:
> +		if (len < 1)
> +			return -EINVAL;
> +
> +		buf[0] =3D reportnum;
> +		return dchid_cmd(iface, rtype, REQ_GET_REPORT, &reportnum, 1,
> +				 buf + 1, len - 1);

[Severity: High]
Could this return an unvalidated length from the device and lead to an
out-of-bounds heap read? In dchid_handle_ack(), iface->resp_size is
overwritten with the hardware-supplied sub_len. If the device sends a
response larger than the requested length, dchid_cmd() returns that larger
value, and hidraw_ioctl() will use it as the count for copy_to_user(),
reading past the end of the allocated buffer.

[ ... ]

> +static void dchid_handle_descriptor(struct dchid_iface *iface, void *hid=
_desc,
> +				    size_t desc_len)
> +{
> +	u8 *rdesc;
> +	int i;
> +
> +	if (iface->hid)
> +		return;
> +
> +	rdesc =3D devm_kmemdup(iface->dchid->dev, hid_desc, desc_len,
> +			     GFP_KERNEL);
> +	if (!rdesc)
> +		return;

[Severity: High]
Can a misbehaving device exhaust kernel memory by flooding the host with
descriptor packets? The devm_kmemdup() allocation is performed without chec=
king
if iface->hid_desc is already allocated or freeing the previous pointer. Si=
nce
the check for iface->hid only bypasses this once asynchronous registration
completes, a rapid stream of packets before that point could leak memory.

[ ... ]

> +static void dchid_handle_ack(struct dchid_iface *iface, struct dchid_hdr=
 *hdr,
> +			     void *data)
> +{

[ ... ]

> +	if (shdr->flags =3D=3D iface->out_flags && iface->tx_seq =3D=3D hdr->se=
q &&
> +	    iface->out_report =3D=3D payload[0]) {
> +		if (iface->resp_buf && iface->resp_size)
> +			memcpy(iface->resp_buf, payload + 1,
> +			       min_t(size_t, sub_len - 1, iface->resp_size));
> +
> +		iface->resp_size =3D sub_len;

[Severity: High]
Is it safe to unconditionally overwrite iface->resp_size with the unvalidat=
ed
sub_len from the device here? This causes the calling function to believe m=
ore
bytes were read than actually requested, setting up the info leak mentioned
earlier in dchid_raw_request().

[ ... ]

> +static void dchid_process_packet(struct dchid_dev *dchid, struct dchid_h=
dr *hdr,
> +				 u8 *payload, size_t payload_len, u8 *packet,
> +				 size_t packet_len)
> +{
> +	struct dchid_work *work;
> +
> +	if (dchid_checksum(packet, packet_len) !=3D DCHID_CHECKSUM_SEED) {
> +		dev_err_ratelimited(dchid->dev, "checksum error\n");
> +		return;
> +	}
> +
> +	if (payload_len < sizeof(struct dchid_subhdr))
> +		return;
> +
> +	if (hdr->iface >=3D MAX_INTERFACES || !dchid->ifaces[hdr->iface])
> +		return;

[Severity: High]
Does reading the dchid->ifaces array locklessly in the RX interrupt context
require an acquire barrier? Without READ_ONCE() and corresponding release
semantics on the writer side, a weakly ordered architecture could see a
non-NULL pointer but read uninitialized memory for fields like the workqueu=
e,
leading to a crash.

[ ... ]

> +static int dchid_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	dchid->new_iface_wq =3D alloc_ordered_workqueue("dchid-new", 0);
> +	if (!dchid->new_iface_wq)
> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate workqueue\n");

[Severity: Medium]
Will this error path leave the ASC coprocessor running and RTKit awake? If
probe fails here after the hardware is started, it returns without calling
apple_rtkit_quiesce() or writing 0 to the control register, which could leak
resources or drain power.

[ ... ]

> +static void dchid_remove(struct platform_device *pdev)
> +{
> +	struct dchid_dev *dchid =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	if (dchid->dc_mbox) {
> +		devm_release_action(&pdev->dev, dchid_free_mbox, dchid->dc_mbox);
> +		dchid->dc_mbox =3D NULL;
> +	}

[Severity: High]
Does freeing the mailbox channel early here introduce a use-after-free risk?
The HID devices and workqueues are still active at this point. If a userspa=
ce
process continues to access the HID device concurrently, or if a pending wo=
rk
item executes and calls dchid_send(), they will attempt to dereference the
freed mailbox channel. Should the teardown order be reversed to destroy
consumers first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-apple-mtp-=
keyboard-final-v1-0-506d936a1707@gmail.com?part=3D8
