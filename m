Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473600;
	b=FRXUZKKWUmLuElEN7DlbrSgxJH1ywyOREXTfyrcwSO0KQ4SRS018LYSvEtvzk9wMfHPH
	 s6pZjoNmNNhkNbd32zhBYP1zjqrL4SseQOLc3BCdFgOj/UVUC37R6Wlsf6T29paSnQnhu
	 Bh3u9KM8iy84+SeELNbbdCKNSFr+iHspFVj/0Zmx0lCPXXkPlSnbCXJgREVQyhxptzpsG
	 H4SfG//u3wTl4waAGwRrw9h+bUhzflcLHiOTZiZz+hoUyNA6UFRl0Dm03USTOhZO0bEhs
	 ploxG9dk0kGRZ5H+bBHCgQK6qzmoBuNK9HXrAbZv+KwMEqWrZAZ6eh057LyAgO2hWkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473600;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YH8QT86/3LEwYMWvaQz1fNb+ZhsxJmSbAJxTawg7hrI=;
	b=ATs7Z0VPMSXbToz0t0uC0hCVvcHNQPwA5bUE/RlGkgNzO3cXHUVDe+UaEqlxzUFiSRdM
	 M5GxCZXlZQdZhXnogQiTwGdcYEXUSOdQt0qV5SnE8fdwSqoURHyPfH+nnliSVjZn3TnmH
	 TuFCAOc5hM+4wE1LleRTWGqw6nTQahSUZqt/pMxXw5puMUh/jghjj8mBS1K03v681CzCc
	 SVc7+oevYEuie//UTbt04pGPrIWcCNeZUkYFUniMH4054H7SO+xtVyxhYUnvdb1OvsGhq
	 wOnm30OI6tikBE//ohryL/CXvMrviXN24FSX3W2EcCv5FTOQZomL2Cw47og95ytci3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="TLayKH/i";
	arc=none smtp.remote-ip=91.218.175.128
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DC606A31C
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 19:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA9DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TLayKH/i
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=//J0klpCP1jGcPxrQI924zaQVPktO/SmhlzT2RxA1MU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793473597; v=1; x=1794078397;
 b=TLayKH/iZNGDWlGtzy5FtvC2M+g3EGMpJtd9YXC/1qgcHLnp/1G95UwKeaosBLhMp7MYPUAX
 IMIVE0q8SStVDFMeG6vsMM3ErP8uBei5aUUuisnpISy+k9UDzbV3iWFCTJOI1ZlgW6nAd8y2GZs
 V5t9P+57To4u62N8ZB+RQ89o=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ba58de2dfaf3ceff;
	Sat, 31 Oct 2026 19:06:37 +0000
X-Mizu-Trace-ID: ba58de2dfaf3ceff
X-Migadu-Flow: FLOW_OUT
Message-ID: <121eb60f-a78b-49d0-ad8d-88c5f0b6087b@linux.dev>
Date: Sat, 31 Oct 2026 20:06:36 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/17] HID: asus: add support for btn remapping
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-13-denis.benato@linux.dev>
 <sashiko-outbox-192087@kernel.org>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <sashiko-outbox-192087@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/31/26 19:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] HID: asus: ABBA deadlock between ally_prefs.lock and sysfs active refs
> - [Low] HID: asus: mixed cleanup helpers and goto in button_remap_store()
> - [Low] HID: asus: commit message refers to remap_index instead of remap_available
> --
>
> commit eab19113fde5452095dfc729f53ab98ff0fc3365
> Author: Denis Benato <denis.benato@linux.dev>
>
> HID: asus: add support for btn remapping
>
> This commit adds button and macro remapping support for ASUS ROG Ally
> devices via per-button sysfs attributes (remap, macro, and
> remap_available), validating mappings against the active gamepad mode and
> restoring or refreshing the cached mappings across mode switches and MCU
> resets.
>
>>     HID: asus: add support for btn remapping
>>     
>>     Add support for buttons remapping: the ability to assign different
>>     button events to each one of the physical button on the device.
>>     
>>     Each button exposes a remap_index sysfs attribute listing the valid
>>     remap target names for the current gamepad mode: M1 and M2 can be
>>     remapped to anything at any time, while other buttons may only be
>>     remapped to gamepad codes in gamepad mode and keyboard/mouse/media
>>     codes in desktop mode.
>>     
>>     When the gamepad mode is changed the firmware automatically restores
>>     its internal defaults, so the software cache is refreshed to reflect
>>     the hardware state.
>>     
>>     Co-developed-by: Luke Jones <luke@ljones.dev>
>>     Signed-off-by: Luke Jones <luke@ljones.dev>
>>     Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>     Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> [Severity: Low]
> This isn't a bug, but the commit message refers to a remap_index sysfs
> attribute, whereas ally_create_button_attributes() in drivers/hid/hid-asus.c
> registers this attribute as remap_available alongside the remap and macro
> attributes created in button_remap_attr_create(). Should the commit message
> be updated to mention remap, macro, and remap_available instead of
> remap_index?

Not good. And now that I think about it I also forgot the documentation entry.

>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index d20e433af5740..b94cb8c50b28b 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
> [ ... ]
>
>> +static ssize_t button_remap_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct hid_device *hdev = to_hid_device(dev);
>> +	struct button_remap_attr *btn_attr = to_button_remap_attr(attr);
>> +	enum ally_button_id button_id = btn_attr->button_id;
>> +	struct ally_button_mapping *mode_map;
>> +	const struct btn_code_map *code;
>> +	const struct btn_code_map *old_code;
>> +	enum btn_pair_index pair_idx;
>> +	struct button_pair_map *pair;
>> +	struct button_map *btn_map;
>> +	char btn_name[32];
>> +	bool is_first;
>> +	int ret, i;
>> +
>> +	if (sscanf(buf, "%31s", btn_name) != 1)
>> +		return -EINVAL;
>> +
>> +	code = find_button_by_name(btn_name);
>> +	if (!code)
>> +		return -EINVAL;
>> +
>> +	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	guard(mutex)(&ally_prefs.lock);
>> +
>> +	/*
>> +	 * Validate the remap target while holding the lock: the
>> +	 * gamepad mode can change concurrently, and the check must
>> +	 * be done against the very mode the mapping is written to.
>> +	 */
>> +	if (!ally_remap_code_valid(button_id, ally_prefs.gamepad_mode, code,
>> +				   btn_attr->is_macro))
>> +		return -EINVAL;
>> +
>> +	/* Access the mapping for current gamepad mode */
>> +	pair = &ally_prefs.button_mappings.button_pairs[pair_idx - 1];
>> +	btn_map = is_first ? &pair->first : &pair->second;
>> +
>> +	if (btn_attr->is_macro) {
>> +		old_code = btn_map->macro;
>> +		btn_map->macro = code;
>> +	} else {
>> +		old_code = btn_map->remap;
>> +		btn_map->remap = code;
>> +	}
>> +
>> +	/* Update pair index */
>> +	pair->pair_index = pair_idx;
>> +
>> +	/*
>> +	 * Send mapping to device with the caveat that first
>> +	 * generation devices require individual button pair updates.
>> +	 */
>> +	if (ally_prefs.is_ally_x) {
>> +		ret = ally_set_button_mapping(hdev, pair);
>> +		if (ret < 0)
>> +			goto err_restore;
>> +	} else {
>> +		mode_map = &ally_prefs.button_mappings;
>> +		for (i = 0; i < ARRAY_SIZE(mode_map->button_pairs); i++) {
>> +			mode_map->button_pairs[i].pair_index = i + 1;
>> +			ret = ally_set_button_mapping(hdev,
>> +						      &mode_map->button_pairs[i]);
>> +			if (ret < 0) {
>> +				/*
>> +				 * Pairs are pushed one at a time. This pair
>> +				 * already reached the hardware when a later
>> +				 * pair is the one that failed.
>> +				 */
>> +				if (i > pair_idx - 1)
>> +					goto err_restore_hw;
>> +				goto err_restore;
>> +			}
>> +		}
>> +	}
>> +	sysfs_notify(&dev->kobj, ally_button_names[btn_attr->button_id],
>> +		     btn_attr->is_macro ? "macro" : "remap");
>> +	return count;
>> +
>> +err_restore_hw:
>> +	if (btn_attr->is_macro)
>> +		btn_map->macro = old_code;
>> +	else
>> +		btn_map->remap = old_code;
>> +
>> +	/* Try to recover the mapping presented to the user. */
>> +	ally_set_button_mapping(hdev, pair);
>> +	goto err_out;
>> +
>> +err_restore:
>> +	if (btn_attr->is_macro)
>> +		btn_map->macro = old_code;
>> +	else
>> +		btn_map->remap = old_code;
>> +
>> +err_out:
>> +	hid_err(hdev, "Failed to set button mapping: %d\n", ret);
>> +	return ret;
>> +}
> [Severity: Low]
> This isn't a bug, but button_remap_store() in drivers/hid/hid-asus.c mixes
> scope-based cleanup via guard(mutex)(&ally_prefs.lock) with goto-based error
> labels (err_restore_hw, err_restore, and err_out), and
> ally_create_button_attributes() similarly mixes __free(kfree) on entries
> with goto ally_btn_err_cleanup. Could these functions avoid mixing cleanup
> helpers and goto error paths in the same routine?
>
> [ ... ]
>
>> @@ -2429,11 +3248,9 @@ static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
>>  
>>  static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_device *hdev)
>>  {
>> +	const size_t entries_attr_index = ally_prefs.turbo_support ? 4 : 0;
>>  	int i, ret;
>>  
>> -	if (!ally_prefs.turbo_support)
>> -		return NULL;
>> -
>>  	struct ally_btn_sysfs_entry *entries __free(kfree) = kzalloc_objs(*entries, ALLY_BTN_MAX);
>>  	if (!entries)
>>  		return ERR_PTR(-ENOMEM);
>> @@ -2441,13 +3258,33 @@ static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_dev
>>  	for (i = 0; i < ALLY_BTN_MAX; i++) {
>>  		entries[i].btn = i;
>>  
>> -		if (!ally_btn_param(i)) {
>> -			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
>> -			ret = -EINVAL;
>> +		if (ally_prefs.turbo_support) {
>> +			if (!ally_btn_param(i)) {
>> +				hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
>> +				ret = -EINVAL;
>> +				goto ally_btn_err_cleanup;
>> +			}
>> +
>> +			ally_btn_turbo_init_attrs(&entries[i]);
>> +		}
>> +
>> +		entries[i].remap_attr = button_remap_attr_create(i, false);
>> +		entries[i].macro_attr = button_remap_attr_create(i, true);
>> +		if (!entries[i].remap_attr || !entries[i].macro_attr) {
>> +			ret = -ENOMEM;
>>  			goto ally_btn_err_cleanup;
>>  		}
>>  
>> -		ally_btn_turbo_init_attrs(&entries[i]);
>> +		sysfs_attr_init(&entries[i].attr_remap_available.attr);
>> +		entries[i].attr_remap_available.attr.name = "remap_available";
>> +		entries[i].attr_remap_available.attr.mode = 0444;
>> +		entries[i].attr_remap_available.show = btn_remap_available_show;
>> +
>> +		entries[i].attrs[entries_attr_index + 0] = &entries[i].remap_attr->dev_attr.attr;
>> +		entries[i].attrs[entries_attr_index + 1] = &entries[i].macro_attr->dev_attr.attr;
>> +		entries[i].attrs[entries_attr_index + 2] = &entries[i].attr_remap_available.attr;
>> +		entries[i].attrs[entries_attr_index + 3] = NULL;
>> +
>>  		entries[i].group.name = ally_button_names[i];
>>  		entries[i].group.attrs = entries[i].attrs;
>>  
>> @@ -2465,6 +3302,11 @@ static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_dev
>>  	while (i--)
>>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
>>  
>> +	for (i = 0; i < ALLY_BTN_MAX; i++) {
>> +		kfree(entries[i].remap_attr);
>> +		kfree(entries[i].macro_attr);
>> +	}
>> +
>>  	return ERR_PTR(ret);
>>  }
>>  
>> @@ -2477,11 +3319,19 @@ static void ally_remove_button_attributes(struct hid_device *hdev)
>>  	if (!entries)
>>  		return;
>>  
>> -	for (i = 0; i < ALLY_BTN_MAX; i++)
>> +	/*
>> +	 * Unpublish first. A mode-store notify holds the prefs lock and must
>> +	 * see either the live array or NULL.
>> +	 */
>> +	ally_prefs.button_entries = NULL;
>> +
>> +	for (i = 0; i < ALLY_BTN_MAX; i++) {
>>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
>> +		kfree(entries[i].remap_attr);
>> +		kfree(entries[i].macro_attr);
>> +	}
>>  
>>  	kfree(entries);
>> -	ally_prefs.button_entries = NULL;
>>  }
> [Severity: High]
> Can this cause a lock ordering inversion and deadlock between
> ally_prefs.lock and the sysfs kernfs active references on the button and
> gamepad_mode attributes?
>
> When userspace reads or writes the remap, macro, remap_available, or
> gamepad_mode sysfs attributes, kernfs acquires an active reference on the
> kernfs node before invoking button_remap_show(), button_remap_store(),
> btn_remap_available_show(), or gamepad_mode_store(), which then acquire
> ally_prefs.lock:
>
>   kernfs_fop_read_iter() / kernfs_fop_write_iter()
>     kernfs_get_active()                 /* acquires kn->active */
>     button_remap_show() / button_remap_store() /
>     btn_remap_available_show() / gamepad_mode_store()
>       guard(mutex)(&ally_prefs.lock);   /* acquires ally_prefs.lock */
>
> In the opposite direction, during device removal or error rollback in
> ally_prefs_setup(), ally_prefs.lock is held while calling
> sysfs_remove_group(), which drains active kernfs references:
>
>   ally_sysfs_remove() / ally_prefs_setup()
>     guard(mutex)(&ally_prefs.lock);     /* acquires ally_prefs.lock */
>     ally_remove_button_attributes() / ally_create_button_attributes()
>       sysfs_remove_group()
>         __kernfs_remove()
>           kernfs_drain()                /* waits for kn->active */
>
> If a sysfs read or write is waiting to acquire ally_prefs.lock while
> ally_sysfs_remove() or ally_prefs_setup() holds ally_prefs.lock and enters
> kernfs_drain(), won't both threads block on each other?
>
