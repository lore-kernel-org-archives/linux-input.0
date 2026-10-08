Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4213E5A32
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446161; cv=none; b=HINaGcjWkEFqGY13n04PYUiCYOlh9fh2tEXopCgdfpT4Wb5zRAJZ5cNXF3avnxg5B/nV5T2ZlOtlRw8Wd6EAXa3QBrAVl8RJEPdOeKGvrriY0Dwr4UENGMmgTFDQipidmKV7yVNIGfE+QzIm/n74h/kNdzLG8bSSVoZWesXVkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446161; c=relaxed/simple;
	bh=1eLsAsBcb3/SU5wMEmlWmiLY4M5auQ2xVNRdqlqUs4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4J9/q3W+/9oYnOLVyqvpVV9K/yEUp/L5iil/VIDMsKFXqQEYqfvuff1Ody3Umc5deGfCIiOLjNOHGBz8KjS7WqlQD+bsyLB0RxzH+n0sJliseogjj7KRznCogwnpds5AGK46X3bUs4GwPNHb1v2Z+yKnacUlBndPimHw8lhEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPhLKAKL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPhLKAKL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-487049569b6so1867618f8f.1
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446158; x=1792050958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqJ80RZLGvdSDJWSa/30QB3K8CJAPo6KFuj937ftJzU=;
        b=PPhLKAKLe3Xj3jWLUOoBBNGiy5nU11Mdq8tEOP1WIqNd6b97t8C+0nqokWqG9J2cR2
         KParJi47v2JiNiCIh0v7u5ANu5urcvf5ZsBEBWKjAeOu2zRcIE4mNfdSdZu2uQUXRCQh
         1RWNVNHf36C7BhA781Ua1+oce37wOirjhHrtx1sItMEuPzLa6EI0neX+DO9L7ZPbW6xg
         BEj1zHerprEsF7mmOplUPasj817BHcBCeZ5sdlS3nMfdkNVqiJfJij9Px+SVohyig0k0
         cgo2EPgilaS0Vv5alzeroYb0VoojSzPeuXAlIMKJ18EvRZKsDfgvDWeZEHDWJcN0S3r5
         +jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446158; x=1792050958;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqJ80RZLGvdSDJWSa/30QB3K8CJAPo6KFuj937ftJzU=;
        b=PNI+H9qdpHjusiJMvcy5iFeKpK4Nc8fE/HeJcJ6Hiy6jV2sUTCdRoyCim9DaQGvVg5
         NLWv1OjA66pzaHVlHfgHb0epqHPSQz5nQmpb9LxnlXT/RDrXTtdgT8Qut82f9vFqVSir
         lVUfPP+BhundXYrKGnnaxEQVxzEbDfPW0BWY6TLem19b8DxZos9PzYx8+cnEe2Nbvyee
         hGJom+8zuzQiT/sFgMesTwrnkqSCcFIO2sIBqavSapNdgJ7V8eXUELi4c3XOfo8Xf/SL
         umnPjva8pCurXCfKP1qPeS3S9sOUUF4Q2Eo6ZKMEl+VJNif+YMKfgtl5rrbwp4Ftm7Pc
         yWBA==
X-Forwarded-Encrypted: i=1; AKwUvBwmQcnpSPN6ZxRy9tXR2dKf7M9dId9q2YAkcj+0ROJXPhCDZ1pGobMpX12md3qCwvT0kKaC42jn4izKYg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLBE0UAlR61QHUbcPquGkUvjYRTHAQLSQMboWccqKKfCbfgjFq8
	3U+MhS96pWpofXVkFYHDN/ZB90xXh5I1nbUWAkezyjpdtlfVUI6BEgib
X-Gm-Gg: AYBFou2TgOZUaEUmLnX0f28tgCUIRzHUlJvyDwi1rOe/2+paYvKb5FucscSbpkTmFZm
	xu8dr/828AD4AWt8+g2Z1VbxePDWypb3E2VXn+ln6p2wtEWBKc5Jc3Mf28+FUU6kNQn+/RY4Kaq
	DdcnRKprNIz3PZ8C6zur+FgC1g7WUG+74jV9VKsNR7flDEB4wcjjH8lI4XfBPkJQgcERgEiC7O3
	KB9Ybl2d2/FznJdJWuzqizrH05YbvffqFWBR3Fa6czJLaDE13QvFBgtzO8xAmgScWhwQQFL2PS5
	zNr/tQIRdCunQIYoilfGFtSEYvHqEQHMtvThOq8X7u/QMqMcqwJTVYy/OoidNJzU0cczqCaZV0X
	ibM4t2BgjOni9kAOHhWiXp2znE8RQwoMjm539kX20Ig3O3/B1nzNn/1YhFYwFsvUeTic+D5nDzJ
	WJgkcdpTNq44b8esNTiWb0OdQuPr1ChGpNsWQHTJe0lZa/8oV4DHOGD4X0Hv9sONHLbQ8cCQY80
	oaWgqa4+ByLVuGOORtU0KUNRU9yDiShgwSjgPQ4Km3ILJS2m4IlRRf3TMa5BPq6Y10n7CjaLVTG
	Agpu6q8HxttodeJCdhzhjBb6TSlc7U2JoGTtjFy5tdB2A9GvIpSXuA2P2gsm/QZxHOmLUYuKVrM
	QLTnEpbsPWWsJKA/Do++nemEViu9YdH4oZN7kBpUE8VaYZR6YyTuOGbL9xS2me30XF8Aacs2EBJ
	7koUXA8Q==
X-Received: by 2002:adf:ed4c:0:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48c72707d0fmr7555934f8f.7.1791446158003;
        Thu, 08 Oct 2026 00:55:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm10344398f8f.51.2026.10.08.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:55:57 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:55:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261008095557.0000617a@gmail.com>
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:20 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe.  With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL.  I hit this on 7.0
> with two uhid-created sensors.
> 
> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do.  Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
> 
> Changes in v2:
> - New patch 1, for the use-after-free on unbind found by the Sashiko
>   review of v1.
> 
> Christopher Hoover (3):
>   HID: hid-sensor-hub: Synchronize callback removal with raw events
>   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
>   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> 
>  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
>  drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
>  drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

Also for future reference, please don't send a new version as a
reply to the previous version, it breaks tooling :(

-- 
Kind regards,
Joshua Crofts
