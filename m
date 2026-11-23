Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450399;
	b=gpGvO/SM8FMkBjUEC1oQAB/1EQF0CK/1ibYSt5gsKwlQ9sqwXjxITRC+UvChGtU7qZW8
	 K6t8IE7L+iVECQULlm9zHNI9PhMjDs6AoU12cpzfLj7VqxqXzhxDCtYUeTBfrCW4lA9RO
	 ozySShUh90dx44i7kzVBhILt1WRXpmgOnJBZVd+B4AdwLNSanpFD8qhpaA3k2ge5kGqZo
	 U9+xhsUcW3d2PzAf1/7CCTg2NPhqmoXWM5nkLAtfHdFiNc9gRVNhXfQsTb5fPf5lf+K8X
	 JbZSZkLTOfgiMGR6ACPUCSVASjBaA8YpXJTS/N2+K7G+mH18GVt+AhoFFVk4cqkMbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yLg7CtvCWS7g2MW1oLG7yOqSSijURNDskxDbBDbJcfI=;
	b=oIjZP2ClS7QPz4LS7ZJU9nX5+hsgQUZHQknkhewDdsvXWyFNeHg5D0yqk2vfjQUu0uhV
	 6mPi6RQgAQPpBChT7joeNMaH7KkzfLFy99j7pwbSGnksDLW6VqPiPrke7lG+DMyGrrS8a
	 hKzhUvjyb76hL11KLptHBS+tsg4zTt96zeVRMBu9SdNqwMzLq6q7GWBIbf/dyq9eR/CxL
	 qspSzuHH2oG2p+wiHMTm5Yvix7g++Fa+JgFA2mjJCuMmXcMIEs4RcMJnmJB5PZvGJg0Bs
	 fQvj9OQQMinCqtHxpAz0G0hP5SIBLtvBBiOA4ObREul045XWvl5KnG/Lb9K+OlXRf7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/E6rmVw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47643606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/E6rmVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0BA1F000CA;
	Mon, 23 Nov 2026 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795450399;
	bh=yLg7CtvCWS7g2MW1oLG7yOqSSijURNDskxDbBDbJcfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/E6rmVwVg880NklwFd9QWlWI4Iq+9lhczoYXZ5yY/++ZCbQM6bCRDyVjeM9rBKE/
	 QsOIGhupoXxFq3RCV6WNUfvrZh4F5kNqPBuKJqXFSyID0n8KT/aHrag8+SF2MvohER
	 B8VKLU86TI1z79K36xo/Vkn29MOKrapJF9AQc+XO5c2dxTIGHV98ZIUiVFtS9HEhYr
	 aCobavIU0LdPxsU9oEVDmQpe5f9h3Kz7SkGPY51fbE/RTVFaJSXSMypiJMkaDQWeJK
	 ML7k9dRF1wn0DI9tG97PvEtG+I58lJK6jLat+JPfdbgJUJnLaRCkFbs7vxxMfnYYGJ
	 TfsaUUQPq887g==
Message-ID: <sashiko-outbox-229647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] HID: sensor-hub: Serialise synchronous read
 teardown under data->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123155138.2907049-5-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
 <20261123155138.2907049-5-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:13:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] HID: sensor-hub: use-after-free in sensor_hub_raw_event()
  [1]
--

commit 60026af9c0858d9a91fa3bec4905b88a658f6493
Author: Lee Jones <lee@kernel.org>

HID: sensor-hub: Serialise synchronous read teardown under data->lock

This commit acquires data->lock when tearing down synchronous read state
in sensor_hub_input_attr_read_values() and
sensor_hub_input_attr_get_raw_value(), and frees any prior
hsdev->pending.raw_data before allocating a new buffer in
sensor_hub_raw_event().

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 028e70ec7bace..6aaf0df4b6dc1 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
[ ... ]
> @@ -625,6 +638,7 @@ static int sensor_hub_raw_event(struct hid_device *hd=
ev,
>  					}
>  				}
>  			} else {
> +				kfree(hsdev->pending.raw_data);
>  				hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);
>  				if (hsdev->pending.raw_data)
>  					hsdev->pending.raw_size =3D sz;

[Severity: Critical]
This problem wasn't introduced by this patch, but can
sensor_hub_raw_event() race with sensor_hub_remove_callback() [1]
and trigger a use-after-free on callback?

sensor_hub_get_callback() returns callback->pcallbacks after dropping
pdata->dyn_callback_lock, while sensor_hub_remove_callback() only takes
pdata->dyn_callback_lock before freeing the entry and returning to the
client driver teardown path:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
	...
	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
		if (callback->usage_id =3D=3D usage_id &&
						callback->hsdev =3D=3D hsdev) {
			list_del(&callback->list);
			kfree(callback);
			break;
		}
	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
	...
}

If a client driver unbinds or fails probe while an incoming report is
being processed, the client driver frees its callback structure and driver
data while sensor_hub_raw_event() still holds the returned pointer:

CPU0                                  CPU1
                                      sensor_hub_raw_event()
                                        spin_lock(&pdata->lock)
                                        callback =3D sensor_hub_get_callbac=
k()
sensor_hub_remove_callback()
  spin_lock(&pdata->dyn_callback_lock)
  list_del(&callback->list)
  kfree(callback)
  spin_unlock(&pdata->dyn_callback_lock)
// client driver frees callback and priv
                                        callback->capture_sample(...)
                                          <-- use-after-free

Acquiring pdata->lock around the removal in sensor_hub_remove_callback(),
or holding pdata->dyn_callback_lock across the callback invocations, would
serialize teardown against in-flight events.

[1] https://sashiko.dev/#/bug/linux-a1e2f25c-d273-4b88-b53e-c38049ea2d5d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123155138.2907=
049-1-lee@kernel.org?part=3D4
