Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE72E8B64
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488639; cv=none; b=jeutndSsl7QR46z+qtipZkc4DTg8F89Eoor5awlp0lBatSoYCy7fzc62H1mbmaVqzB+tutsOI4hP+xVew24MzLVLyEa0VlViglvtSqbw6dZsvCYBw8ZLykoaMygkSXZ1jK87APOcveTArbGz5vM8oKz5g3Pdu/Qh7Ot5sUao7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488639; c=relaxed/simple;
	bh=+ufriLf5n0i9JMuh78M6D3ei5AF+TgLxp12k7UXo/PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulDPMJt1xR+L8iUNg8uwPxWMG/O+0VaRhyHgolO9ER8RwNeHRL8bOb1A7cE/UA6pl8i8q/KpV0ksohkz4VHSKWDRuGKV2TWqHMcKMW8ROmSyST5L9lRa/RtMkijLyEB7MlhEZw7pN8b3CL4IqqmGqyifhe1858/NcIjxgpHTDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv6S2ob1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv6S2ob1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E61F000E9;
	Fri, 31 Jul 2026 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785488637;
	bh=AEmAuQAdfI27NEq1Tw/oymwQ2Q/F7LF3k99PEWdLe1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mv6S2ob1+88J6JWHnf3WaTBgCS040OxbDyADvpk8pamupPhCiLcsBPb7c0X61+A2y
	 s5IobFKcUjHPWOKtfG+NuBpQ3lr0iRLhtmhxAmdJag0uDyKCSnLIOP52EjeGHRowUu
	 2sPD5iHnR9md5ajY7OIptQWZpvWUozoyOqAybEZxl10IhKj+dxXOkV9i/Zal98rgIf
	 igyY9knzl3KCAf79Fc1tZwwfBBmROejarimGLgu2com/sReBkobHtBo745mJ27nxmu
	 lhVKcF6aD5y4afFWx+yczSvaG6VUqTYKTNPnG9NIkSBrc2Cev0ZyxNQ6h4YFI0u6ky
	 6mI+NHh/PDBpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: roccat: free buffered reports when destroying
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <B93A126D2A126AAD+20260731084926.1771993-1-raoxu@uniontech.com>
References: <B93A126D2A126AAD+20260731084926.1771993-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:03:56 +0000
Message-Id: <20260731090356.B36E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `roccat_disconnect()` and `roccat_release(=
)` leads to Use-After-Free and Double-Free vulnerabilities.
- [High] `roccat_release()` fails to free disconnected open devices due to =
a faulty array lookup, leaking memory and corrupting state if the minor num=
ber is reused.
- [High] Incoming HID events during or immediately after device removal tri=
gger Use-After-Free, Double-Free, and panics due to missing teardown synchr=
onization.
- [High] `roccat_report_event()` acquires sleeping locks in an atomic hardw=
are interrupt context.
- [High] `roccat_connect()` publishes the device globally before initializi=
ng its mutexes and lists, leading to uninitialized use crashes.
--

--- Patch [1]: [PATCH] HID: roccat: free buffered reports when destroying d=
evice ---
commit dad9381303bffdf0e85a009b8168cbabdcb74643
Author: Xu Rao <raoxu@uniontech.com>

HID: roccat: free buffered reports when destroying device

This commit adds a destructor that frees every buffered report before freei=
ng
the device. It uses this new destructor in both paths that destroy a
registered device to prevent leaking up to ROCCAT_CBUF_SIZE report buffers
per device.

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index d6fff53d4ee7a..4f15eb9510396 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -70,6 +70,15 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICE=
S];
>  /* protects modifications of devices array */
>  static DEFINE_MUTEX(devices_lock);
> =20
> +static void roccat_free_device(struct roccat_device *device)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ROCCAT_CBUF_SIZE; i++)
> +		kfree(device->cbuf[i].value);

[Severity: High]
This is a pre-existing issue, but does this lockless iteration race with the
interrupt handler?

If a sub-driver like hid-roccat-kone triggers roccat_disconnect() and frees
its state before shutting down hardware events, HID interrupts can continue
firing during teardown.

Could this lockless kfree() race with an active interrupt handler modifying
the buffer, resulting in an immediate double-free of the buffer memory?

> +	kfree(device);
> +}
> +

[ ... ]

> @@ -226,7 +235,7 @@ static int roccat_release(struct inode *inode, struct=
 file *file)
>  			hid_hw_power(device->hid, PM_HINT_NORMAL);
>  			hid_hw_close(device->hid);
>  		} else {
> -			kfree(device);
> +			roccat_free_device(device);
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does roccat_release() fail to free
disconnected open devices due to the device lookup earlier in this function?

When an open device is unplugged, roccat_disconnect() sets
devices[minor] =3D NULL.

Later, when the file descriptor is closed, roccat_release() looks up the
device:

drivers/hid/hid-roccat.c:roccat_release() {
    ...
    device =3D devices[minor];
    if (!device) {
        mutex_unlock(&devices_lock);
        pr_emerg("roccat device with minor %d doesn't exist\n", minor);
        return -ENODEV;
    }
    ...
}

Since it is NULL, won't the function return -ENODEV early and skip this
cleanup logic entirely?

Furthermore, if a new Roccat device is plugged in before the descriptor is
closed, it reuses the same minor number. Does this mean roccat_release() wi=
ll
fetch the new device, incorrectly decrement its open count, and remove the
old reader from the new device's list?

[ ... ]

> @@ -374,7 +383,7 @@ void roccat_disconnect(int minor)
>  		hid_hw_close(device->hid);
>  		wake_up_interruptible(&device->wait);
>  	} else {
> -		kfree(device);
> +		roccat_free_device(device);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(roccat_disconnect);

[Severity: High]
This is a pre-existing issue, but can roccat_disconnect() and
roccat_release() race to cause a use-after-free and double-free?

In roccat_disconnect(), the global devices_lock is dropped before checking
device->open:

drivers/hid/hid-roccat.c:roccat_disconnect() {
    ...
    device->exist =3D 0;
    device_destroy(device->dev->class, MKDEV(roccat_major, minor));
   =20
    mutex_lock(&devices_lock);
    devices[minor] =3D NULL;
    mutex_unlock(&devices_lock);
   =20
    if (device->open) {
    ...
}

If a user closes an open file descriptor exactly when the device is being
hot-unplugged, could roccat_release() acquire the lock during this window,
see exist =3D=3D 0, and free the device?

If so, when roccat_disconnect() continues, it would access the freed device
to check device->open, and potentially call roccat_free_device() a second
time.

[Severity: High]
This is a pre-existing issue, but does roccat_report_event() acquire
sleeping locks in an atomic context?

This function runs from the HID raw_event callback in atomic/softirq contex=
t.
However, it attempts to acquire mutexes:

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}

Since mutexes can sleep, does this cause scheduling while atomic panics when
hardware events arrive?

[Severity: High]
This is a pre-existing issue, but does roccat_connect() publish the device
globally before its fundamental structures are initialized?

The device pointer is made accessible to interrupt handlers early:

drivers/hid/hid-roccat.c:roccat_connect() {
    ...
    if (minor < ROCCAT_MAX_DEVICES) {
        devices[minor] =3D device;
    ...
    INIT_LIST_HEAD(&device->readers);
    mutex_init(&device->readers_lock);
    ...
}

Because hid_hw_start() is called by sub-drivers prior to roccat_connect(),
hardware events are already active. If an interrupt fires during this narrow
window, could roccat_report_event() fetch the device and attempt to lock
uninitialized mutexes or iterate an uninitialized readers list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/B93A126D2A126AAD+20=
260731084926.1771993-1-raoxu@uniontech.com?part=3D1
