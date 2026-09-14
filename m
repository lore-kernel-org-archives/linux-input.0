Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B235292A
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391239; cv=none; b=BMneLs4J9hwPZWmLusIgkBYVL07HSSe9KdnUg3H6voqaDbUgaL4/R4XpjB+jp8DPJAcKsuR5fT+Ug4/DaR1PawH/5XsLhoSFWdtpd/bRz+7kzUp4dSkTe0XscZR5uuyr3gw0X24TJsARSS5K2XVDXZy4J/fAdfN11cdXumEh+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391239; c=relaxed/simple;
	bh=s+3PMVS4sD7ZZ7Yjn6/i4hjahQlw98NDmwzfiYlJGFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmBS04DTDx/RvEiqZ7h0dHl2Gsak6FNr7phr1JUng/KWqbiXR+purW4cLlhzsvOKr+j4wqi4K5Jbje1642W4i5r9pZukf26egMfK741T4zxFngZwdVQaMp0d9NvACv36Ote3yUavoU1Qal1tielTGOaQJpqeggAxlMlvUMGRr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObwCb2R/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObwCb2R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8281F000FF;
	Mon, 14 Sep 2026 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789391238;
	bh=0hUG/P5ohyCTQ8HtvES/4aGMYdRrc3OQvSLN7JQM6X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObwCb2R/Oz2mjmyH/169cXOW5T2VBCTCWJ1rnOb/8AMORTe4TYSRvOeImBGipQPLz
	 iGBg0CEOxAe/R9eg6OOuODtLkLZrXjegaOgsomzj4Qflt2dB/0cVCJHVlCVZ3XU8B7
	 aFfUBHOoXhAywmfy44nVm2ikdDr9oshG0NlnVgHG3ENrFXOggckBfAOiqf+8IYoOH1
	 RvRFcpa4UJwJtPdi5D/+KtlzAEK7DBokMC8A+eQmOEUgjQCxLOQLkT5+w+6DvdaO/X
	 fWLOuEHQkAA/KCqweOv0Jp5Jydus17aZLepzDsoL9Cmjbqen1J+VvsOblkKP8/q6r5
	 duV2enyvcyn6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: roccat: use kref to manage device instances
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914120240.1625442-4-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
 <20260914120240.1625442-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:07:17 +0000
Message-Id: <20260914130717.CD8281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] A TOCTOU race condition between `roccat_release` and `roccat_open`=
 causes a new reader's device to be incorrectly powered down and closed.

Pre-existing issues:
- [High] Data path UAF and NULL pointer dereference in `roccat_report_event=
` due to lockless device access.
- [High] Custom Roccat drivers violate HID subsystem lifecycle rules by fre=
eing their private `drvdata` before stopping the hardware, causing a UAF in=
 their `raw_event` handlers.
- [High] A race condition between `roccat_release` and `roccat_disconnect` =
causes `hid_hw_close()` and `hid_hw_power()` to be skipped entirely, perman=
ently leaking `ll_open_count` and power references.
--

commit 0e2654cfadc18d56d9b77ac333344436bcca55c7
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use kref to manage device instances

Use kref to manage 'struct roccat_device' instances and fix
UaF-triggering race between roccat_open()/roccat_release()
and roccat_connect()/roccat_disconnect() pairs.

Reported-by: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dd632e93ffcd1452bc61e
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yand=
ex.ru?part=3D2

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index d1df4ec34a1e6..32927b20bcfe0 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -227,9 +231,8 @@ static int roccat_release(struct inode *inode, struct=
 file *file)
>  		if (device->exist) {
>  			hid_hw_power(device->hid, PM_HINT_NORMAL);
>  			hid_hw_close(device->hid);
> -		} else {
> -			roccat_free_device(device);
>  		}
> +		kref_put(&device->ref, roccat_free_device);
>  	}
> =20
>  	mutex_unlock(&devices_lock);

[Severity: High]
Can a newly opened reader's device be incorrectly closed and powered down d=
ue
to a TOCTOU race?

Looking at roccat_release(), the open status is determined early while hold=
ing
device->readers_lock. A concurrent roccat_open() can then observe the empty
list, power on the device, and add its reader node.

When roccat_release() later acquires devices_lock, it acts on the stale open
variable (which is false):

CPU1: roccat_release()
    mutex_lock(&device->readers_lock);
    open =3D !list_empty(&device->readers); // false
    mutex_unlock(&device->readers_lock);

CPU2: roccat_open()
    mutex_lock(&devices_lock);
    mutex_lock(&device->readers_lock);
    // list is empty, power on and open hardware
    hid_hw_power(device->hid, PM_HINT_FULLON);
    ...
    mutex_unlock(&device->readers_lock);
    mutex_unlock(&devices_lock);

CPU1: roccat_release() (resuming)
    mutex_lock(&devices_lock);
    if (!open) {
        hid_hw_power(device->hid, PM_HINT_NORMAL);
        hid_hw_close(device->hid);
    }

Does this clobber the concurrent open and leave the newly connected reader =
with
a powered down, closed hardware state?

> @@ -362,6 +366,8 @@ void roccat_disconnect(int minor)
> =20
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> +	if (!device)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does roccat_report_event() r=
isk
a NULL pointer dereference or use-after-free because it accesses devices[mi=
nor]
locklessly?

When the device is unplugged, roccat_disconnect() sets devices[minor] =3D N=
ULL
and drops the kref. Since the transport hardware hasn't been stopped yet (d=
ue
to the delayed hid_hw_close), incoming USB events can concurrently trigger
kone_raw_event(), which calls into roccat_report_event():

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    device =3D devices[minor];

    new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
    ...
}

If devices[minor] is read as NULL here, accessing device->report_size will
trigger a panic. If it is read right before kref_put frees it, does this re=
sult
in a use-after-free, defeating the intent of the kref fix?

> @@ -376,10 +382,10 @@ void roccat_disconnect(int minor)
>  	if (open) {
>  		hid_hw_close(device->hid);
>  		wake_up_interruptible(&device->wait);
> -	} else {
> -		roccat_free_device(device);
>  	}
> =20
> +	kref_put(&device->ref, roccat_free_device);
> +out:
>  	mutex_unlock(&devices_lock);
>  }

[Severity: High]
This is a pre-existing issue, but can a race between roccat_release() and
roccat_disconnect() permanently leak the ll_open_count and power references=
 by
skipping hid_hw_close() entirely?

If roccat_disconnect() sets device->exist =3D 0 concurrently with the last =
reader
calling roccat_release(), both paths appear to bypass the mandatory cleanup:

CPU1: roccat_disconnect()
    device->exist =3D 0;
    // open is false because reader is removing itself
    if (open) { ... } // skipped

CPU2: roccat_release()
    // open is false
    if (!open) {
        if (device->exist) {
            // skipped because exist is 0
            hid_hw_close(device->hid);
        }
    }

Does this leave the hardware permanently active and prevent proper unbindin=
g?


While reviewing the UAF fixes in the roccat driver, I noticed another
pre-existing UAF in the kone driver's lifecycle handling:

[Severity: High]
This isn't a bug introduced by this patch, but does the kone driver violate
HID lifecycle rules by freeing its private driver data before stopping the
hardware?

Because kfree(hid_get_drvdata(hdev)) is called before hid_hw_stop(hdev),
incoming USB events can still be delivered during this window.

drivers/hid/hid-roccat-kone.c:kone_remove_specials() {
    ...
        kfree(hid_get_drvdata(hdev));
    ...
}

drivers/hid/hid-roccat-kone.c:kone_remove() {
    kone_remove_specials(hdev);
    hid_hw_stop(hdev);
}

If an interrupt arrives before hid_hw_stop(), kone_raw_event() accesses the
freed kone structure:

drivers/hid/hid-roccat-kone.c:kone_raw_event() {
    struct kone_device *kone =3D hid_get_drvdata(hdev);
    struct kone_mouse_event *event =3D (struct kone_mouse_event *)data;
    ...
    if (memcmp(&kone->last_mouse_event.tilt, &event->tilt, 5))
    ...
}

Can this use-after-free be triggered locally by unplugging the device while
USB events are active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914120240.1625=
442-1-dmantipov@yandex.ru?part=3D4
