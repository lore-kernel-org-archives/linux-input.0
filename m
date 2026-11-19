Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120826;
	b=snWVBkyJJoRu+DWok1ae67wQWFn95Ze2+g8uHTcy/7PdHweEleHqv2HDdcmOHnRY4RI7
	 L413+GgeBbZOu5gQnHcQVG/KeZyOMnyifywmkWCLjdI+1XvGCSMn+zrGzokKLGW5wwgjy
	 bk2E0ywFKH6RYEKW2h3vzCb5ULdtUHcOxYxI66vXp4PZnRcTU7MDNlVP2hFlNfz4dbkMm
	 DsxdASN1S7ohuPN/QlkRVGxGdgehYIHwk1/h7Oj3NmVFmaoEP2AJyYChkr0YJeIVtNBgg
	 OZ3Rr/3xaPxmauEyJOtx3m2yILIE94MctaFmnkMfmB3UZ3xLuJq/WKvIM5EarxKWlIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120826;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=cddWqTP0g+CbpVm+N1Fy6WhhjNR76yRDMyPgxWeMdh8=;
	b=DeNKgJ0QRBpAexiNrHKBUkeUzXtOtWN1vl4+K1VniPgiOb07Wr+Ki2BXQX1G/0N2A4fE
	 /LzITnOTd3IzsXpCH2OQwF5GWzid6MnZOEtt7VzMGKUsG+yGlf4b9azJ0N1bIBq2zUnd2
	 qNHu6UJ/vsAyJzPZlXorR1fNPPVFM1jrHRs/mcw4EGod5WD5T4d3Gq8zSVW7hFQ1A+bwr
	 MlQkITMbiEtXpH0bx39QIPRaWvbK6vJWZLKP9wz9Y0WJVS598vYvsOrreoEL0K5D7Bb5i
	 b3f011SgjtpaXmOpUzXeTrtWm6TKokVNscy/e6yXuF05X0q5pNxXSxDyTWET9sRC55w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN1sg1BL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37837606A93E;
	Thu, 19 Nov 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oN1sg1BL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3857D1F000C4;
	Thu, 19 Nov 2026 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120825;
	bh=cddWqTP0g+CbpVm+N1Fy6WhhjNR76yRDMyPgxWeMdh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oN1sg1BLOKksViJ7ThQi/icfIWDueSsQ6X/ogaMC2mPuwWSZ9fxY9QCIei/Cy3SZN
	 ygT7o8HNrHKWouqG6MczDTVPWmLyqyPah72J1jtpx9xjxWHJ9cEN+fdp4Bel/EHcsF
	 m2PKr3B0oslLDEpDA3jDJTOI9HpU7OTTCmsEU7tpNlLnJs4YHlXg2NZl+rdsZ5iwm3
	 PVTQVxbiLawyfgR+aKAM09QpdMc2Rwl+8kuDPjcSwtVrQkbylCQjZb5Byb7beOSYeU
	 9w2L8y3rmP5c+m8F8iPcFDmxII8Ni6OpXERzGpM7oV2KyxR4LS346kql3a9TgnngY+
	 s3/l0ZFY457EA==
Date: Thu, 19 Nov 2026 21:40:23 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hui Peng <benquike@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Rosalie Wanders <rosalie@mailbox.org>
Subject: Re: [PATCH] HID: fix sony Rock Band 3 IRQ sleep and hid_debug_events_read()
 UAF
In-Reply-To: <20260919222630.3798292-1-benquike@gmail.com>
Message-ID: <30n6p5s6-pn96-7s47-7p64-79qs0pq6qn57@xreary.bet>
References: <20260919222630.3798292-1-benquike@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


CCing Rosalie to Ack/Review this one.

On Sat, 19 Sep 2026, Hui Peng wrote:

> Fix two issues in drivers/hid/:
> 
> 1. In sony_raw_event() (drivers/hid/hid-sony.c), defer the Rock Band 3
>    Pro controller full-report feature request to sony_state_worker()
>    instead of calling hid_hw_raw_request() synchronously from interrupt
>    context.
> 2. In hid_debug_events_read() and hid_debug_events_release()
>    (drivers/hid/hid-debug.c), remove list->node from hdev->debug_list
>    under hdev->debug_list_lock before freeing or when hdev is unbound so
>    hid_dump_input() cannot access a freed debug list entry.
> 
> Fixes: bd28ce008bdc ("HID: move sony quirks")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index f44e6e708404..edc45ca9e024 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -3728,15 +3728,14 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>  				break;
>  			}
>  
> -			/* if list->hdev is NULL we cannot remove_wait_queue().
> -			 * if list->hdev->debug is 0 then hid_debug_unregister()
> -			 * was already called and list->hdev is being destroyed.
> -			 * if we add remove_wait_queue() here we can hit a race.
> +			/* if list->hdev->debug is 0 then hid_debug_unregister()
> +			 * was already called; break out of the wait loop so
> +			 * remove_wait_queue() is unconditionally called before
> +			 * returning.
>  			 */
>  			if (!list->hdev || !list->hdev->debug) {
>  				ret = -EIO;
> -				__set_current_state(TASK_RUNNING);
> -				goto out;
> +				break;
>  			}
>  
>  			if (file->f_flags & O_NONBLOCK) {
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 50f5ad6bbeb4..d3862ddf68c9 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -561,6 +561,7 @@ struct sony_sc {
>  
>  	/* Rock Band 3 Pro Instruments */
>  	unsigned long rb3_pro_poke_jiffies;
> +	struct work_struct rb3_pro_poke_work;
>  };
>  
>  static void sony_set_leds(struct sony_sc *sc);
> @@ -657,6 +658,14 @@ static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
>  	return ret;
>  }
>  
> +static void rb3_pro_poke_worker(struct work_struct *work)
> +{
> +	struct sony_sc *sc = container_of(work, struct sony_sc,
> +					  rb3_pro_poke_work);
> +
> +	rb3_pro_instrument_enable_full_report(sc);
> +}
> +
>  static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			  struct hid_field *field, struct hid_usage *usage,
>  			  unsigned long **bit, int *max)
> @@ -1101,7 +1110,7 @@ static int rb3_pro_instrument_raw_event(struct sony_sc *sc, u8 *rd, int size)
>  	/* Only attempt to enable full report every 8 seconds */
>  	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
>  		sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
> -		rb3_pro_instrument_enable_full_report(sc);
> +		schedule_work(&sc->rb3_pro_poke_work);
>  	}
>  
>  	return 0;
> @@ -2124,6 +2133,8 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
>  		}
>  		cancel_work_sync(&sc->state_worker);
>  	}
> +	if (sc->quirks & RB3_PRO_INSTRUMENT)
> +		cancel_work_sync(&sc->rb3_pro_poke_work);
>  }
>  
>  static void sony_cleanup(struct sony_sc *sc)
> @@ -2350,6 +2361,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	hid_set_drvdata(hdev, sc);
>  	sc->hdev = hdev;
>  
> +	if (sc->quirks & RB3_PRO_INSTRUMENT) {
> +		sc->rb3_pro_poke_jiffies = 0;
> +		INIT_WORK(&sc->rb3_pro_poke_work, rb3_pro_poke_worker);
> +	}
> +
>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "parse failed\n");
> @@ -2391,9 +2407,6 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto err;
>  	}
>  
> -	if (sc->quirks & RB3_PRO_INSTRUMENT)
> -		sc->rb3_pro_poke_jiffies = 0;
> -
>  	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
>  		if (!hid_is_usb(hdev)) {
>  			ret = -EINVAL;
> 

-- 
Jiri Kosina
SUSE Labs

