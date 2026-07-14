Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FF37D123
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029436; cv=none; b=ioRjR9BvpNuzdQyUzUxSjoFXXC31ePb0uX3xQaiHBsLgiIdFymk38M+SWSWqtYsVgh6Eivhdthy/REsEq/PqCag545+iNQUM0Skt0w3SK5ggHQpird8S8YiqFh1FPrjhky7DCCJtVoxnvJ1vQu2bg54XV84vBu/io2sqGFdOqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029436; c=relaxed/simple;
	bh=2IYCOIzTkQg+oj6Gwep5n75zwPuFlAtD6sGfwrQsaKA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ac7PYNYky37Fko/EfEy8vkMjIJZeC+405FymPylOGWccQ+YU88n0sbtZ6DjmJegfeJrH5Y19B4lxUdMECbjmop2+171Z5NYjHHj7LtT+ZQ842ETMnh3E5Gv2fN0HMekYjyY+d6z3vzLUxdPkiNdbq6bocFr+5SdhsyuXDjpR0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuwN66QM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuwN66QM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3346672a91.2
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029434; x=1784634234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LnzwO3yduLUZGDsc0EAbiDA4QgOYTgL4184fJUl1C6U=;
        b=cuwN66QMwB1sDcnAJ501Q3S5WwfS6YUDBMw1CV/rKoUG+DzFvrZXC1jcx7rBosOb7z
         z/jtqfG475cTq/8kkP0J7bPEWpbP34+Bi6m5iW40//PXSESzBFfte8uZYa1lLgDaii08
         Or2puvPSRNzgsXoK6tTNJTz9W9ikggA5AGu1YTmeGK0h8VXym6rCXxEqizIg9kwL+QmU
         iOCs2Fz5tGhFsf7RW9IDXz5b2lLTSYbL1p3NTx2rJX7erOT/2E5R1OFC5RFpCuYMHulW
         XbaDAOxUlcG7EJS/wfJpShF3e4MeCOTwceoKElmPbqor0mqsgIg4dr+IgZrAyBEyQ36R
         ELIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029434; x=1784634234;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnzwO3yduLUZGDsc0EAbiDA4QgOYTgL4184fJUl1C6U=;
        b=ftT9iTDpX96mC6eWJ8TdAupwgcPcurBiGfWFRGh3CQ1GjUl1WSmO+5775vMFizl3Qq
         2eUPhRtyKcssDhb6Thi0/tXxTv4Dq0zpiEFzuVw20iKRM40qKe0qRTFIrhlXujhdIVa6
         HoVZitVktMSlyT6K4Zn9vo4XSh4SecvepgdSA1zC0zWnRzh0T6/RIvx4yaZDXqXgJfGW
         A5yPM+hC9Y19dTKhufpt62UwE5zLVqP589mowg/j/7wDCtkaTSC0Gq1mGZivAMjYknRJ
         7dfSNJFSzDFaMKTNC1yMfPl4YOcOyLyyw5+DJpPvbk/C37O/NkdU6fGNmyfcAdu6+MOq
         a1ag==
X-Gm-Message-State: AOJu0YwijILyu6Jxm7K3ZmnqXhk1NEluIVlPZsiEfPS0Xb4DfMpBM+h1
	sPtf8a1TJjtPcliMsnB8N2/6poaIU7G+6rXj8h5Qm3gxn17+ny2SFawj
X-Gm-Gg: AfdE7cnQmk2K48aqk9ODgXlnDGt53K0bOo2AR8i3zxydyuBuaFL+9eJqFKt1jeu3N3T
	fyIGb5zfsrRkcdhuRbgwCIMEwiygufY+Of4Hufi2kh6rciYWnobsPXbKwh39AAyj7Q4NexsMeUs
	QyYjBqZuIfOSzrt48Ahx/ytWvm8KhqtxqoqTAVN79Mta4Yj4QIBVGU0tk0xAZUCxWLNFXz5boh1
	EXEZyuJSayCAZbPu6hH/fE+7ToFn/xqvNhKE6eC5zdjw0EZI1ovhkDWtC+mEzojwHqvoThr2Z3G
	KRMfkWP+EScyS1oDMK9eyxE527+oWcEuW2hrn+75OovmzfrqVGXrp9GgmWNGtGkmVXtCBjLstoo
	hf8oG5ESkatAEnFV7YfK7t7P1zuuMKzbxgADySIrq+U+NWRS+Q9KON3Gnx+y/VOq5Z/No6TJE8v
	/frD9uPoQu42Pqb7XzLdw5mVodgWVL0uN5WV+9DJmhks/7letSXpt505Rcdg+1eTwU5Sk+Qmmf7
	plrJIMH28M=
X-Received: by 2002:a17:90b:164e:b0:38e:1fba:fd79 with SMTP id 98e67ed59e1d1-38e1fbafdcfmr1210641a91.36.1784029433653;
        Tue, 14 Jul 2026 04:43:53 -0700 (PDT)
Received: from ehlo.thunderbird.net (221x252x203x146.ap221.ftth.ucom.ne.jp. [221.252.203.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e173194e9sm1398648a91.17.2026.07.14.04.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:43:53 -0700 (PDT)
Date: Tue, 14 Jul 2026 20:43:51 +0900
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v12 3/4] HID: hid-msi: Add RGB control interface
User-Agent: Thunderbird for Android
In-Reply-To: <20260714104219.AEAE31F000E9@smtp.kernel.org>
References: <20260714102640.18075-1-derekjohn.clark@gmail.com> <20260714102640.18075-4-derekjohn.clark@gmail.com> <20260714104219.AEAE31F000E9@smtp.kernel.org>
Message-ID: <426987CB-DA21-403D-903E-153D7BC81F3B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 14, 2026 7:42:19 PM GMT+09:00, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>- [High] The `rgb_queue` delayed work accesses a freed device pointer `le=
d_cdev=2Edev` on its error path due to incorrect teardown order in `claw_re=
move`=2E
>- [High] Missing cancellation of `cfg_setup` and `cfg_resume` delayed wor=
ks in `claw_remove()`=2E
>- [Medium] RGB configuration states and LED class properties are modified=
 and read concurrently without proper synchronization=2E
>--
>
>--- Patch [3]: [PATCH v12 3/4] HID: hid-msi: Add RGB control interface --=
-
>commit 2d837d4907cf2b48e7866a46da8d35b754a9f9a6
>Author: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>
>HID: hid-msi: Add RGB control interface
>
>Adds RGB control interface for MSI Claw devices=2E The MSI Claw uses a
>fairly unique RGB interface=2E It has 9 total zones (4 per joystick ring
>and 1 for the ABXY buttons), and supports up to 8 sequential frames of
>RGB zone data=2E
>
>Link: https://patch=2Emsgid=2Elink/20260529072111=2E7565-4-derekjohn=2Ecl=
ark@gmail=2Ecom
>
>> diff --git a/drivers/hid/hid-msi=2Ec b/drivers/hid/hid-msi=2Ec
>> index 9d3249fa50291=2E=2Eddb64adb08b9c 100644
>> --- a/drivers/hid/hid-msi=2Ec
>> +++ b/drivers/hid/hid-msi=2Ec
>> @@ -406,6 +406,38 @@ static int claw_profile_event(struct claw_drvdata =
*drvdata, struct claw_command_
>>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>>  			codes[i] =3D (mkeys->codes[i]);
>>  		break;
>> +	case CLAW_RGB_PENDING:
>> +		frame =3D (struct claw_rgb_report *)cmd_rep->data;
>> +		rgb_addr =3D drvdata->rgb_addr;
>> +		read_addr =3D be16_to_cpu(frame->read_addr);
>> +
>> +		if (read_addr < drvdata->rgb_addr)
>> +			return -EAGAIN;
>> +
>> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
>> +		if (frame_calc >=3D CLAW_RGB_MAX_FRAMES) {
>> +			dev_err(&drvdata->hdev->dev, "Got unsupported frame index: %x\n",
>> +				frame_calc);
>> +			return -EAGAIN;
>> +		}
>> +		f_idx =3D frame_calc;
>> +
>> +		scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
>> +			memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
>> +			       sizeof(struct rgb_frame));
>> +
>> +			/* Only use frame 0 for remaining variable assignment */
>> +			if (f_idx !=3D 0)
>> +				break;
>> +
>> +			drvdata->rgb_speed =3D frame->speed;
>> +			drvdata->led_mc=2Eled_cdev=2Ebrightness =3D frame->brightness;
>
>[Severity: Medium]
>Are there missing locks around rgb_speed and led_cdev=2Ebrightness?

Humans reading this dumb bot's reply,
No, they are under scoped_guard 9 lines above this=2E=2E=2E

>Here in claw_profile_event(), drvdata->rgb_speed and
>drvdata->led_mc=2Eled_cdev=2Ebrightness are written to under the frame_lo=
ck=2E
>However, they appear to be read locklessly in claw_write_rgb_state() outs=
ide
>of frame_lock=2E Similarly, speed_store() modifies drvdata->rgb_speed loc=
klessly
>from userspace=2E
>
>Could this inconsistent locking lead to torn reads or data races between
>sysfs operations, hardware events, and the workqueue?
>
>[ =2E=2E=2E ]
>
>> +static void claw_rgb_queue_fn(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork =3D container_of(work, struct delayed_work=
, work);
>> +	struct claw_drvdata *drvdata =3D container_of(dwork, struct claw_drvd=
ata, rgb_queue);
>> +	int ret;
>> +
>> +	if (!drvdata)
>> +		return;
>> +
>> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
>> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq conte=
xt */
>> +		if (!smp_load_acquire(&drvdata->rgb_registered))
>> +			return;
>> +	}
>> +
>> +	ret =3D claw_apply_rgb_state(drvdata);
>> +	if (ret)
>> +		dev_err(drvdata->led_mc=2Eled_cdev=2Edev,
>> +			"Failed to apply RGB state: %d\n", ret);
>
>[Severity: High]
>Could this dev_err() access a freed device pointer?
>
>If claw_rgb_queue_fn() starts executing and passes the rgb_registered che=
ck,
>but the device is concurrently removed, claw_remove() will set rgb_regist=
ered
>to false and call led_classdev_multicolor_unregister()=2E This drops the =
final
>reference and frees led_cdev=2Edev=2E
>If claw_apply_rgb_state() subsequently fails, this error path will log us=
ing
>drvdata->led_mc=2Eled_cdev=2Edev, which might trigger a use-after-free si=
nce the
>work was not canceled prior to unregistration=2E

Addressed below=2E

>
>[ =2E=2E=2E ]
>
>> @@ -1084,6 +1721,7 @@ static void claw_remove(struct hid_device *hdev)
>>  {
>>  	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>>  	bool gp_registered;
>> +	bool rgb_registered;
>> =20
>>  	if (!drvdata)
>>  		return;
>> @@ -1096,11 +1734,21 @@ static void claw_remove(struct hid_device *hdev=
)
>>  		gp_registered =3D smp_load_acquire(&drvdata->gp_registered);
>>  		/* Pairs with smp_load_acquire in attribute show/store functions */
>>  		smp_store_release(&drvdata->gp_registered, false);
>> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq conte=
xt */
>> +		rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
>> +		/* Pairs with smp_load_acquire in attribute show/store functions */
>> +		smp_store_release(&drvdata->rgb_registered, false);
>>  	}
>> =20
>>  	if (gp_registered)
>>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
>> =20
>> +	if (rgb_registered) {
>> +		device_remove_group(drvdata->led_mc=2Eled_cdev=2Edev, &claw_rgb_attr=
_group);
>> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
>> +	}
>> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
>
>[Severity: High]
>Should cancel_delayed_work_sync() for rgb_queue happen before
>led_classdev_multicolor_unregister()?
>

This suggestion will just reintroduce the bug the reorder was meant to fix=
=2E device_remove_group is blocking as far as I'm aware=2E By canceling the=
 work after that it removes the possibility of re-arming the worker after i=
t is freed=2E The smp_load_acquire ensures any currently queued thread will=
 abort before the call to the led_classdev in the error message=2E If it is=
 really a problem I'll swap the device over to hdev=2Edev, but the probabil=
ity is nearly zero of this ever happening=2E

>Canceling the work after unregistering the LED device creates a window
>where the executing work can access freed led_cdev=2Edev memory (as noted
>in claw_rgb_queue_fn)=2E
>
>>  	hid_hw_close(hdev);
>>  }
>
>[Severity: High]
>Are we missing the cancellation of the cfg_setup and cfg_resume delayed w=
orks?
>
>The driver schedules cfg_setup and cfg_resume, but does not seem to expli=
citly
>cancel them here in claw_remove()=2E If the device is disconnected while =
either
>work is pending, could they execute after drvdata has been freed by devre=
s,
>resulting in a use-after-free?
>


cfg_setup & cfg_removed are cancelled in this function above the portion m=
arker cutoff=2E This is introduced in patch 1/4=2E Bot is wrong here=2E

- Derek

