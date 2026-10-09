Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466F3B9D98;
	Fri,  9 Oct 2026 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585773; cv=none; b=Fomr0e48wyyiVuBK0Ziy9gQjSzUmP5+IBDnF5lNxP24PBGoqd3rueXg7SEhUoh4KlbUO0ks9UYkvd4ck5TEd9kfEu5as0v+FhrHFwZENv1pQwtikFeKm4/p9X6RHRDKJJnM7q7KIyFpS43CJXcs09QwzkhDFxX+esKcny/RkvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585773; c=relaxed/simple;
	bh=oURz/JmDsetXO+K9ZPONSbCOyrnyxxV0tZ87S08DBp8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i9ArvGhBCJWyG4qs+SubJQfqTrCe3OU6fpxXZCwO4f02Yde3Zpdq+1PxnRUO6A/qWwrAcYF/RoPOJQWLhdMEoclxjdCkFRRV3SairuGJY3J8KBnG/+fFqpTBzEXPS2XU77D8bg720lZ8jMWNnaHE1l8Z7I6quovNN0UATfmVYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieNmLEx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieNmLEx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AA71F000FF;
	Fri,  9 Oct 2026 22:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585771;
	bh=RbV9LR8fZ+2UTC/+k3hm9KTxWxQrO0lb0Ws3Vt/h9nM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieNmLEx5dliMuLi0Y/U460fkOii5DEW3QrzUlOliuw+0y6yE5iSEz8VCE7XMAGVJn
	 b1u4uukJKhFuSNU20HqtjwtSN5kU5CBKHjHMoKsJMzNMiAZwwGFID0IgxgIQMDFmvr
	 b5reHz9xXOkkZdEb7m1uiFihVxL2XOIKmKSBcKDPud0FgrYEWPLKQslEXHiy+qye6I
	 hsrPNURVObZATwKr4358iqo1N4n00YAyuGj3YRt/lnNyd4BaftVxzhdOmoAQZEPnfv
	 hADFASBv5NxR2ucZd09Lf492JI9OG7eNVWMm3+aHxQpVD6m1JOijPWj8LQx5hNU/Km
	 d5UnMzT9qu/2A==
Message-ID: <sashiko-outbox-166154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] HID: spi-hid: add spi-hid driver HID layer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261009-send-upstream-v5-4-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-4-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:42:50 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: output_report callback sleeps in atomic context
--

commit 954a3684cea1bad33a85c00ff6725f7553c75027
Author: Jingyuan Liang <jingyliang@chromium.org>

    HID: spi-hid: add spi-hid driver HID layer
   =20
    Add HID low level driver callbacks to register SPI as a HID driver, and
    an external touch device as a HID device.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 02a7608c4b882..fca7a44eeb9f9 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> +static int spi_hid_send_output_report(struct spi_hid *shid,
> +				      struct spi_hid_output_report *report)
> +{
> +	guard(mutex)(&shid->output_lock);
> +	return __spi_hid_send_output_report(shid, report);
> +}
> +
> +static int __spi_hid_sync_request(struct spi_hid *shid,
> +				  struct spi_hid_output_report *report)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int error;
> +
> +	reinit_completion(&shid->output_done);
> +
> +	error =3D __spi_hid_send_output_report(shid, report);
> +	if (error)
> +		return error;
> +
> +	error =3D wait_for_completion_interruptible_timeout(&shid->output_done,
> +							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
> +	if (error =3D=3D 0) {
> +		dev_err(dev, "Response timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +	if (error < 0)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int spi_hid_sync_request(struct spi_hid *shid,
> +				struct spi_hid_output_report *report)
> +{
> +	guard(mutex)(&shid->output_lock);
> +	return __spi_hid_sync_request(shid, report);
> +}
[ ... ]
> +static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
> +				    size_t len)
> +{
> +	struct spi_device *spi =3D hid->driver_data;
> +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> +	struct device *dev =3D &spi->dev;
> +	struct spi_hid_output_report report =3D {
> +		.report_type =3D OUTPUT_REPORT,
> +		.content_length =3D len - 1,
> +		.content_id =3D buf[0],
> +		.content =3D &buf[1],
> +	};
> +	int error;
> +
> +	if (!test_bit(SPI_HID_READY, &shid->flags)) {
> +		dev_err(dev, "%s called in unready state\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	if (shid->desc.no_output_report_ack)
> +		error =3D spi_hid_send_output_report(shid, &report);
> +	else
> +		error =3D spi_hid_sync_request(shid, &report);

[Severity: High]
Can this code sleep in an atomic context?

The HID subsystem requires the output_report callback to be asynchronous be=
cause
it can be invoked from atomic contexts, such as softirqs for LED triggers or
force feedback.

Both spi_hid_send_output_report() and spi_hid_sync_request() acquire a mute=
x,
which will sleep. Furthermore, spi_hid_sync_request() blocks by calling
wait_for_completion_interruptible_timeout() in __spi_hid_sync_request() whi=
le
waiting for the response.

Will calling these synchronous primitives from the output_report callback l=
ead
to a scheduling while atomic BUG and cause a kernel panic?

> +
> +	if (error) {
> +		dev_err(dev, "failed to send output report\n");
> +		return error;
> +	}
> +
> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D4
