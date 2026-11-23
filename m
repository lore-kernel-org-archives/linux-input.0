Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426979;
	b=TPTsLlR8Ozt8HwID2/I4V3aD70eGcGi23gXxaQ9j8BGVoSTpb9JU8UrV6R+K6XKsNz8i
	 FlxZ9DPMe7nHd2OM4HJe/rdTCxsfrjGfeSb80ZTrkgMV5SxS2NbFDkxinnti/vhYI2mC4
	 IEqWWy1vgKl0M819eM1eiBiwfcE9Yr2a2UfForaESDh+OmPqHaR45Rd+7946y+Y4CExZC
	 XxB8pQKKTs6Hpg3iYJpeYkIIE7nlaVshQMEHzK7hJrvP5GgC0nGsvNFHm+pR7J5pXLZms
	 /qv8N/je9NYK8j55C3CJnqT7RE8nKBZg8EKsHHYV5N6vrzezzlJaCOWNlIUoWcx+qCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=luKx7xLkJD8cEmgpccLceBgBfdp4a2QrKT9YJd2DqYg=;
	b=WENa/Zj8/4k4s2+mBwBlE+xutTVIoX/xeAeW4gzYyPu1MDXs1ndEJ9x6LxjTg2j6TFC9
	 6Cu0+z9VGeFh+PaqCzv9oO/pVY7y9zGThBEtiFQcPfAYkxRYWCwBq4mdMmWwEoriDVc+9
	 A3shskSl9cFfObWHBVpTsNCG07jB+tAvK6o94EHl6ArP7h/4bbOykOYinIQpvwTR1/6mt
	 k+/8Zek67we4hwe6MEj02yC7Lz2cxkL4XzAkhhTCU/20jmfZRnZO+jAFhZyo7svX8RUpY
	 kwFrJMnB+pvu3n1gqP1Vv7xwfN7PL+oNHIJpGZwowb7RTDlvTvCPinH3qNNbNKpWrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cX8V/VXH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F23606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX8V/VXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08541F000D3;
	Mon, 23 Nov 2026 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795426979;
	bh=luKx7xLkJD8cEmgpccLceBgBfdp4a2QrKT9YJd2DqYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cX8V/VXHBZNhOw0SmAqbnKBihFScGjrvqZXHUPli1AHQdCxRA3fygqUVtSaXqapFj
	 lWv01L/bW49BdGDKivOkEVcdDP591+KAxYMLiy/cRk5ayFBybgdhUgdbvqc5JgpwPF
	 rQG84Qil6kUx7/1kR4yr1CHpUj0rLOPZCLbWqkNIFiMJ3+wM+QbDxalE+IOlAZTvUt
	 Ki0j3+djJQnwiAUUqT603/1772yqjyOlIb6CCnVDG82YIJ5HIjQ52AwnCQthhXbvxw
	 Zul8fCkfz4i3G2In1o7Q0ki9s+BJP5jQYROQC9y8uG1Cxzz39+fA7d7SUnpOCOXnbc
	 4NxhqdbpkLShA==
Message-ID: <sashiko-outbox-228999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: intel-ish-hid: Reallocate the descriptor
 buffers for a longer response
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maoyi Xie" <maoyixie.tju@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261123092816.2200718-2-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
 <20261123092816.2200718-2-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:42:58 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-ish-hid: UAF race in process_recv() on duplicate
  report descriptor
--

commit 024e9922cb6a61e316edcda24a29fa99a9eae537
Author: Maoyi Xie <maoyixie.tju@gmail.com>

HID: intel-ish-hid: Reallocate the descriptor buffers for a longer response

This commit replaces the one-time devm_kmalloc() calls for hid_descr[i]
and report_descr[i] in process_recv() with devm_krealloc() so each buffer
is resized to the received payload length before copying.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index ec5e8afe77bd4..24f4032d6dfe1 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
[ ... ]
> @@ -197,11 +198,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp=
_cl, void *recv_buf,
>  				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
>  				break;
>  			}
> -			if (!client_data->report_descr[curr_hid_dev])
> -				client_data->report_descr[curr_hid_dev] =3D
> -				devm_kmalloc(cl_data_to_dev(client_data),
> -					     payload_len, GFP_KERNEL);
> -			if (client_data->report_descr[curr_hid_dev])  {
> +			descr =3D devm_krealloc(cl_data_to_dev(client_data),
> +					      client_data->report_descr[curr_hid_dev],
> +					      payload_len, GFP_KERNEL);
> +			if (descr) {
> +				client_data->report_descr[curr_hid_dev] =3D descr;
>  				memcpy(client_data->report_descr[curr_hid_dev],
>  				       payload,
>  				       payload_len);

[Severity: Medium]
Can a second HOSTIF_GET_REPORT_DESCRIPTOR response cause a use-after-free
on client_data->report_descr[curr_hid_dev] in ishtp_hid_parse()?

During initial probe, hid_ishtp_cl_init() wakes up as soon as the first
response sets report_descr_done and immediately calls ishtp_hid_probe()
while cur_hid_dev is still i and init_done is still false.  If a second,
longer (or zero-length) response arrives before cur_hid_dev advances,
devm_krealloc() frees the old buffer while hid_parse_report() is reading
it:

CPU0 (probe)                      CPU1 (unbound_wq)
hid_ishtp_cl_init()
  ishtp_get_report_descriptor()
                                  process_recv()
                                    report_descr[i] =3D descr
                                    report_descr_done =3D true
                                    wake_up_interruptible(&init_wait)
  ishtp_hid_probe()
    ...
      ishtp_hid_parse()
        hid_parse_report(...,
          report_descr[i], ...)
                                  process_recv()
                                    devm_krealloc(..., report_descr[i], ...)
                                      free_dr(old_dr)
          kmemdup(start, size, ...)  <-- use-after-free

Ignoring or rejecting duplicate responses when report_descr_done (and
hid_descr_done for HOSTIF_GET_HID_DESCRIPTOR) is already true would avoid
reallocating the buffer while the waiter is using it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123092816.2200=
718-1-maoyixie.tju@gmail.com?part=3D1
