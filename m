Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427440;
	b=qjWLrKwBxhnpoepprBGNYbyT77ezDE9yNMfM1iijbrQ9gMOGXgKZl2IeWij7HQtOMlL0
	 D0KlzzKNg2GZLuBfQrUXqIxu+urjPSgrtQZhR2aSLTOFM77MXjXhGy10XTPx7zQFdqK90
	 SuJHfznffZ1vX9On/qbKme87cY1YvpCGcd/pK9JX2PXD5A9TVjCFBmZ+onV6XK+vd8Ef0
	 bPBIaZVr87uALlEiIi8Bj9qHZRL1OJKCmm+ks2w+1Ll3fUEDaZcBerlDTtd/LJZ7DxbSW
	 WRrau84hs1rnZjH8zHtjBuf62rL/LoSIqfVpQvazkX8imquwxLRVGTWq+QJJChWSzMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wQ5HxMKBN9+cpxRgNYUc0mLXgwK6Ebc3oSMgUp1t0Is=;
	b=W8UC5RTjG0VwBP+pFnNdjGS4spI4JqDYS9K3yobP+pW6ly6KXt9briQxlxLe2fTF5y4/
	 bHYxiCZmWEt+4ljDuSvPfrv91i/0s+TrTezEZkipAyyMxLubiN861szFfd3XzbcwbTl24
	 0xBQzgRYxCbKbgMdBKJX4buA+Bih+pOHNa0dKRctYQt5wx3GJ8UtV3NwRROij99Vtc7Zh
	 Ib8tW8+CDZ9abBJhL49vNiFVy9QsmbF2JRoN2LlLYkUBPmqLRbbVqrwn7Xo8ED7Nk8M+q
	 HnWUg5FOBFBgtyH5Fqf7ftgmC8U4zdDgaJ7Vvy2hiunq7HawoOiyZOJ/R8ipIKWAGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJqa+w4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96A606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJqa+w4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC171F000D0;
	Mon, 23 Nov 2026 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427439;
	bh=wQ5HxMKBN9+cpxRgNYUc0mLXgwK6Ebc3oSMgUp1t0Is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SJqa+w4+S7Stm5qUtPmIII7crcnmylesb5/fqspHrzPlErI2IkO+bNLo0NJ/kJkQ8
	 ZVOnsKl8K8Fn5uZxta5sXTNK6/Qp6w1BC+buB2kO342x43O0GTYr9DOPOvNDFiud/g
	 kDVYuv5kAgTHkD9ujuHrSbgi/wPmbME0NgOEd2hn8vyP3JIw34lPsQ3QsjGWtb1997
	 liiE8LmWIh1tr1FY9Ay6t1xG4Hjdcv4/24R9o9xkimHoXcL992E7zMTsqKcupg13tL
	 rlSBD2tVPz56stHPjnBM+g1pT74PYKT7ICOCieRCqPNPm1gX24u+3ioM0wRGF9t6la
	 q18elTfN56oiw==
Message-ID: <sashiko-outbox-229009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: intel-ish-hid: Reallocate hid_devices for a
 larger device count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maoyi Xie" <maoyixie.tju@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261123092816.2200718-3-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
 <20261123092816.2200718-3-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:50:39 +0000
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
- [Medium] HID: intel-ish-hid: use-after-free in process_recv() on
  hid_devices realloc
--

commit 354365a28c1b9e56e376d6cd317766efa118e7ec
Author: Maoyi Xie <maoyixie.tju@gmail.com>

HID: intel-ish-hid: Reallocate hid_devices for a larger device count

This commit uses devm_krealloc_array() in process_recv() to resize
client_data->hid_devices when a HOSTIF_DM_ENUM_DEVICES response announces
more devices than previously allocated.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index 24f4032d6dfe1..864a06a7bd3ff 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -70,6 +70,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl,=
 void *recv_buf,
>  	unsigned char *payload;
>  	unsigned char *descr;
>  	struct device_info *dev_info;
> +	struct device_info *devices;
> +	unsigned int count;
>  	int i, j;
>  	size_t	payload_len, total_len, cur_pos, raw_len, msg_len;
>  	int report_type;
> @@ -124,19 +126,21 @@ static void process_recv(struct ishtp_cl *hid_ishtp=
_cl, void *recv_buf,
>  			}
>  			if (client_data->init_done)
>  				break;
> -			client_data->hid_dev_count =3D (unsigned int)*payload;
> -			if (!client_data->hid_devices)
> -				client_data->hid_devices =3D devm_kcalloc(
> -						cl_data_to_dev(client_data),
> -						client_data->hid_dev_count,
> -						sizeof(struct device_info),
> -						GFP_KERNEL);
> -			if (!client_data->hid_devices) {
> +			count =3D *payload;
> +			devices =3D client_data->hid_devices;
> +			if (count || !devices)
> +				devices =3D devm_krealloc_array(cl_data_to_dev(client_data),
> +							      devices, count,
> +							      sizeof(struct device_info),
> +							      GFP_KERNEL | __GFP_ZERO);
> +			if (!devices) {
>  				dev_err(cl_data_to_dev(client_data),
>  				"Mem alloc failed for hid device info\n");
>  				wake_up_interruptible(&client_data->init_wait);
>  				break;
>  			}
> +			client_data->hid_devices =3D devices;
> +			client_data->hid_dev_count =3D count;

[Severity: Medium]
Can reallocating client_data->hid_devices on a second
HOSTIF_DM_ENUM_DEVICES response cause a use-after-free in
hid_ishtp_cl_init()?

After the first response sets client_data->enum_devices_done and wakes
client_data->init_wait, hid_ishtp_cl_init() proceeds to read
client_data->hid_devices[] across descriptor queries and
ishtp_hid_probe() while client_data->init_done is still false:

CPU0                                  CPU1
hid_ishtp_cl_init()                   process_recv()
  ishtp_enum_enum_devices()
                                        case HOSTIF_DM_ENUM_DEVICES:
                                          devm_krealloc_array(...)
                                          enum_devices_done =3D true
                                          wake_up_interruptible(...)
  for (i =3D 0; i < num_hid_devices; ++i)
    ishtp_get_hid_descriptor(i)
                                        case HOSTIF_DM_ENUM_DEVICES:
                                          devm_krealloc_array(...)
                                            /* frees old hid_devices */
      client_data->hid_devices[i].dev_id  <-- use-after-free
  client_data->init_done =3D 1

Because HOSTIF_DM_ENUM_DEVICES only checks client_data->init_done and not
client_data->enum_devices_done, a second response with a larger count
frees the old client_data->hid_devices buffer without synchronization
while hid_ishtp_cl_init() is still iterating over it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123092816.2200=
718-1-maoyixie.tju@gmail.com?part=3D2
