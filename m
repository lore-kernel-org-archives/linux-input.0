Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672481;
	b=j0C934U7Wfuk8KwpD3rIxSzF6Yd0ofaIW1VTG5jdEXad2dV3+8BzrV3rhnDMtrstWcJi
	 Ml4pP2WEgVgn6S4fVBN2cBsyW05eWDxx0TM0rZySDV/7ravCqvXUOtYyYoTqqOrJzvUEK
	 k0UdJxK70+mLad0nWTskWWqJXhE2vST+/24+ZRyl4ad9Cre/LMZAMQ4VhgAZnPp44cDxv
	 wEQQPws0wh9MHkC8sy0r+6rGkXECfosdnClfFViPd9xgH7uzeWp0rsDv53BnLynNWaO6N
	 h/+6T0eq1wY4/nNCMvYCR/F1kfwkdKZjcy40dctc6c3DOuj0fF6+Bl5tHqHjuOydlCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WrgmvOPnPHr0k4nptcWpXLB4wm52IJ7Il0Isu8rY6JE=;
	b=L5r3Hv8QvmFioz2pUqBae8rn3Mo3jKY32WrMoWvwrf4j5azU2KfVxflQ4DVRjujALroB
	 ltoJ7cEbB37raWIigPJzVUqEgKvzqIdXUUjDUnD0IXsFNpp8v3woWtgzXpoy26dKH51sw
	 JPs8TDgVge3vW5gdt6Zl539KFhH9DZK/fnT+pQC9J25MfQFV1wVj4cIzG5w0IisZUzVbB
	 07+ibzEviRMzHgCchGnIJa4nBmwM55lOYMNE3/vjgClDJSzFfIlnmsIpOcLGEpcO6I3Dm
	 wWBe/tQW5YU1uuMZSa9bXPxqAyT/G1AUjK0ylnhjfHjqRwzFzjxs4MhBCFKOCnhQvdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQtv4tQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E80606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQtv4tQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E32F1F000C4;
	Sat, 14 Nov 2026 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672481;
	bh=WrgmvOPnPHr0k4nptcWpXLB4wm52IJ7Il0Isu8rY6JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQtv4tQKmRzH7jYe9n5SGnrSA3DayxM1Wk0ksgc2D/nh7VNHXFkIEWTtLXechN4E5
	 pbveB+lgVbIj7YWv+sG3yeyxqESw6w/lbznTNGobWexeND5+oizT8RQQ7wfn0V/rp7
	 SxJFC6obVzhjm6biODDa2iIs/av4tzQszzm89aB4qIBdRQpk5dn6c+uQxTAHmbO5L8
	 3dHKzUmCINXTKvNl3OMd5sUM2zJrfzgnyj9OuXZj8sPYq7VPH1QV+gl0D2CQzSbo8c
	 rAKPHXQd4FN7PMRkuUKXyCIQjbPa06Q7uOG85VZCy7kv6xK3cTRY7DrmW2iPzbD12p
	 +HyOpLGMlHbFA==
Message-ID: <sashiko-outbox-214736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: intel-thc-hid: intel-ipts: expose the port as
 a HID device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114154611.1683519-4-emfox@debian.org>
References: <20261114154611.1683519-1-emfox@debian.org>
 <20261114154611.1683519-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:08:00 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] HID: intel-thc-hid: zero return on SET_REPORT in
  thc_ipts_hid_raw_request()
- [High] HID: intel-thc-hid: DMA stopped before HID removal in
  thc_ipts_port_stop()
- [High] HID: intel-thc-hid: uninitialized frame len in
  thc_ipts_read_frames()
- [Medium] HID: intel-thc-hid: unvalidated feature report ID in
  thc_ipts_get_feature()
- [Medium] HID: intel-thc-hid: racy and zero-length descriptor in
  thc_ipts_descriptor()
--

commit 378fb3be497c5d8bed8daca37c866a233cfb6aad
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: expose the port as a HID device

This commit registers a HID device for the IPTS port, adds TX frame helpers,
and implements report descriptor parsing, feature report handshakes, and
input report forwarding.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 8529b91e063f7..55206205f2115 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -135,8 +137,62 @@ static int thc_ipts_touch_set(struct thc_ipts *idev,=
 bool enable)
>  				 &touch);
>  }
> =20
> +/*
> + * One frame to the controller: code, length, then the payload padded to=
 four
> + * bytes. The frame is built in @idev->tx_frame, so callers serialise wi=
th
> + * @idev->req_lock.
> + */
> +static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *da=
ta,
> +			 size_t len)
> +{
> +	size_t padded =3D round_up(len, 4);
> +	u8 *frame =3D idev->tx_frame;
> +
> +	if (!idev->dma_ready)
> +		return -EAGAIN;
> +	if (THC_IPTS_TX_HDR_SIZE + padded > idev->max_tx)
> +		return -EMSGSIZE;
> +
> +	put_unaligned_le32(code, frame);
> +	put_unaligned_le32((u32)len, frame + 4);
> +	memset(frame + THC_IPTS_TX_HDR_SIZE, 0, padded);
> +	if (len && data)
> +		memcpy(frame + THC_IPTS_TX_HDR_SIZE, data, len);
> +
> +	return thc_dma_write(idev->thc, frame, THC_IPTS_TX_HDR_SIZE + padded);
> +}
> +
> +static void thc_ipts_descriptor(struct thc_ipts *idev, const u8 *data,
> +				size_t len)
> +{
> +	if (len < THC_IPTS_DESC_PREAMBLE)
> +		return;
> +
> +	len =3D min(len - THC_IPTS_DESC_PREAMBLE, idev->max_rx);
> +	memcpy(idev->desc, data + THC_IPTS_DESC_PREAMBLE, len);
> +	idev->desc_len =3D len;
> +	WRITE_ONCE(idev->have_desc, true);
> +	wake_up(&idev->wq);
> +}

[Severity: Medium]
Can a delayed retry response in thc_ipts_descriptor() overwrite idev->desc
and idev->desc_len while thc_ipts_hid_parse() is passing them to
hid_parse_report()?

Unlike thc_ipts_feature(), thc_ipts_descriptor() does not check a pending
flag or whether idev->have_desc is already set. If the first attempt in
thc_ipts_hid_parse() times out and a second THC_IPTS_TX_GET_DESC request is
sent, the delayed reply to the first attempt wakes thc_ipts_hid_parse(),
while the second reply on the IRQ thread races with hid_parse_report():

CPU0                                     CPU1 (thc_ipts_thread)
thc_ipts_hid_parse()
  try 0: thc_ipts_send(GET_DESC)
  wait_event_timeout() -> times out
  try 1: thc_ipts_send(GET_DESC)
                                         thc_ipts_descriptor() (reply 0)
                                           WRITE_ONCE(idev->have_desc, true)
                                           wake_up(&idev->wq)
  hid_parse_report(hdev, idev->desc,
                   idev->desc_len)
                                         thc_ipts_descriptor() (reply 1)
                                           memcpy(idev->desc, ...)
                                           idev->desc_len =3D len;
                                             <-- data race

Also, checking len < THC_IPTS_DESC_PREAMBLE allows an 8-byte preamble-only
frame to set idev->desc_len =3D 0; hid_parse_report() then sets
hdev->dev_rdesc =3D ZERO_SIZE_PTR via kmemdup() and registers a broken HID
device with a 0-byte report descriptor instead of retrying.

> +
> +/* The report is collected in a private buffer; the caller copies it out=
. */
> +static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
> +			     size_t len)
> +{
> +	if (!READ_ONCE(idev->feature_pending))
> +		return;
> +
> +	len =3D min(len, idev->max_rx);
> +	memcpy(idev->feature, data, len);
> +	idev->feature_len =3D len;
> +	WRITE_ONCE(idev->feature_pending, false);
> +	WRITE_ONCE(idev->feature_done, true);
> +	wake_up(&idev->wq);
> +}
> +
>  static void thc_ipts_handle_frame(struct thc_ipts *idev, size_t len)
>  {
> +	const u8 *payload =3D idev->rx_frame + THC_IPTS_RX_HDR_SIZE;
>  	size_t capacity =3D idev->max_rx - THC_IPTS_RX_HDR_SIZE;
>  	u32 code, size;
> =20
> @@ -145,11 +201,28 @@ static void thc_ipts_handle_frame(struct thc_ipts *=
idev, size_t len)
> =20
>  	code =3D get_unaligned_le32(idev->rx_frame);
>  	/* The header may claim more than what actually arrived. */
> -	size =3D min_t(u32, get_unaligned_le32(idev->rx_frame + 4),
> -		     capacity);
> +	size =3D min_t(u32, get_unaligned_le32(idev->rx_frame + 4), capacity);
>  	size =3D min_t(u32, size, len - THC_IPTS_RX_HDR_SIZE);
> =20
> -	dev_dbg(idev->dev, "frame code %u, %u bytes\n", code, size);
> +	switch (code) {
> +	case THC_IPTS_RX_INPUT:
> +		if (idev->hid)
> +			hid_safe_input_report(idev->hid, HID_INPUT_REPORT, (u8 *)payload,
> +					      capacity, size, 1);
> +		break;
> +	case THC_IPTS_RX_DESC:
> +		thc_ipts_descriptor(idev, payload, size);
> +		break;
> +	case THC_IPTS_RX_FEATURE:
> +		thc_ipts_feature(idev, payload, size);
> +		break;

[Severity: High]
Can thc_ipts_handle_frame() be called with an uninitialized len and
redispatch a stale idev->rx_frame buffer when the RxDMA2 ring is already
empty?

In thc_ipts_read_frames(), len is not initialized before calling
thc_rxdma_read(), and thc_ipts_handle_frame(idev, len) runs before checking
finished:

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_read_frames() {
	for (;;) {
		int finished =3D 0;
		size_t len;

		if (thc_rxdma_read(idev->thc, THC_RXDMA2, idev->rx_frame,
				   &len, &finished)) {
...
		}

		thc_ipts_handle_frame(idev, len);
		if (finished)
			break;
	}
}

In thc_dma_read(), if is_dma_buf_empty() is true on entry, *read_len is
left untouched while *read_finished is set to 1 and the function returns 0:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_dma_read() {
	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
		...
		*read_len =3D status;
		...
	}

	if (read_finished)
		*read_finished =3D is_dma_buf_empty(dev, read_config, &read_ptr, &write_p=
tr) ? 1 : 0;

	return 0;
}

If a second frame arrives after pass 0 of thc_ipts_thread() clears the
RxDMA2 EOF interrupt status bit in thc_interrupt_handler() and before pass
0's thc_ipts_read_frames() loop finishes draining the ring, pass 0 consumes
both frames, but the newly latched status bit causes pass 1 to call
thc_ipts_read_frames() on an empty ring. thc_rxdma_read() then returns 0
without setting len, and thc_ipts_handle_frame() uses the uninitialized
stack value to reprocess the previous frame in idev->rx_frame.

[ ... ]

> @@ -291,6 +378,175 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
[ ... ]
> +/*
> + * A feature report is not pushed by the controller: it is asked for and=
 comes
> + * back as a frame of its own, so the request waits for the handler.
> + */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
> +	int ret =3D -ETIMEDOUT;
> +	int try;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	WRITE_ONCE(idev->feature_done, false);
> +	WRITE_ONCE(idev->feature_pending, true);
> +
> +	for (try =3D 0; try < THC_IPTS_REQ_TRIES; try++) {
> +		ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
> +		if (ret)
> +			break;
> +
> +		if (wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done),
> +				       msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS))) {
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	WRITE_ONCE(idev->feature_pending, false);
> +
> +	if (ret) {
> +		dev_err(idev->dev, "controller did not return feature %u in %d tries\n=
",
> +			reportnum, try);
> +		return ret;
> +	}
> +
> +	/* The payload is the report as user space writes it, report ID first. =
*/
> +	len =3D min(len, idev->feature_len);
> +	memcpy(buf, idev->feature, len);
> +
> +	return len;
> +}

[Severity: Medium]
Does thc_ipts_feature() need to verify that the incoming payload is
non-empty and starts with the requested reportnum?

If try 0 times out after 300 ms and try 1 sends a second request, a delayed
reply to try 0 completes try 1 while the second request remains in flight.
On a subsequent thc_ipts_get_feature() call for a different report ID, the
late reply from the earlier request is accepted by thc_ipts_feature() and
returned to the caller as if it matched the new reportnum. Also, if a
THC_IPTS_RX_FEATURE frame arrives with len =3D=3D 0, thc_ipts_get_feature()
returns 0 without writing anything to buf.

> +
> +static int thc_ipts_hid_raw_request(struct hid_device *hdev,
> +				    unsigned char reportnum, __u8 *buf,
> +				    size_t len, unsigned char rtype, int reqtype)
> +{
> +	struct thc_ipts *idev =3D hdev->driver_data;
> +
> +	if (!buf || !len)
> +		return -EINVAL;
> +
> +	if (reqtype =3D=3D HID_REQ_GET_REPORT && rtype =3D=3D HID_FEATURE_REPOR=
T)
> +		return thc_ipts_get_feature(idev, reportnum, buf, len);
> +
> +	if (reqtype !=3D HID_REQ_SET_REPORT ||
> +	    (rtype !=3D HID_OUTPUT_REPORT && rtype !=3D HID_FEATURE_REPORT))
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	if (rtype =3D=3D HID_OUTPUT_REPORT)
> +		return thc_ipts_send(idev, THC_IPTS_TX_OUTPUT, buf, len);
> +
> +	return thc_ipts_send(idev, THC_IPTS_TX_SET_FEATURE, buf, len);
> +}

[Severity: High]
Should thc_ipts_hid_raw_request() return len on a successful
HID_REQ_SET_REPORT instead of the 0 returned by thc_ipts_send()?

thc_ipts_send() returns the result of thc_dma_write(), which is 0 on
success. However, struct hid_ll_driver.raw_request must return the number
of transferred bytes on success. In hidraw_send_report(), the return value
of __hid_hw_raw_request() is returned directly to user space for write()
and for HIDIOCSFEATURE and HIDIOCSOUTPUT ioctls, so returning 0 causes user
space (such as the daemon sending the report 5 set-feature request) to see
0 bytes transferred.

[ ... ]

> @@ -413,6 +669,8 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
>  	cancel_work_sync(&idev->recover_work);
>  	thc_ipts_dma_stop(idev);
> =20
> +	thc_ipts_hid_remove(idev);
> +
>  	if (idev->running)
>  		thc_ipts_touch_set(idev, false);

[Severity: High]
Can stopping DMA before removing the HID device in thc_ipts_port_stop()
cause a NULL pointer dereference or use-after-free in thc_dma_write()?

Until thc_ipts_hid_remove() destroys idev->hid, user space (via hidraw) or
a HID driver can still invoke thc_ipts_hid_raw_request() -> thc_ipts_send().
Because thc_ipts_dma_stop() does not take idev->req_lock or
idev->thc->thc_bus_lock, it can free the DMA scatterlists and PRD tables
while thc_ipts_send() is entering thc_dma_write():

CPU0                                     CPU1
thc_ipts_hid_raw_request()
  guard(mutex)(&idev->req_lock)
  thc_ipts_send()
    if (!idev->dma_ready) (true)
                                         thc_ipts_port_stop()
                                           thc_interrupt_enable(..., false)
                                           ...
                                           thc_ipts_dma_stop()
                                             idev->dma_ready =3D false
                                             thc_dma_unconfigure(idev->thc)
                                             thc_dma_release(idev->thc)
                                               sgl_free(config->sgls[0])
                                               config->sgls[0] =3D NULL
                                               config->prd_tbls =3D NULL
    thc_dma_write()
      write_dma_buffer()
        sg_copy_from_buffer(write_config->sgls[0], ...)
          <-- NULL pointer dereference / use-after-free

In addition, masking interrupts before thc_ipts_hid_remove() drains active
callers causes any in-flight thc_dma_write(), thc_ipts_get_feature(), or
thc_ipts_hid_parse() to stall until its timeout expires. Calling
thc_ipts_hid_remove() before disabling interrupts and stopping DMA avoids
both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114154611.1683=
519-1-emfox@debian.org?part=3D3
