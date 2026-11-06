Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793930818;
	b=mn9zWcKtPsyT9eYpXgGBI95f8Isogvhksq5iVgUUF3otSsVOltZ6jNIN3qOg2bFuoGIq
	 RugfpRwgvgVGbVCL8/ZVk1zsAUuVRyFO+Kn1z+Omr4L1D69TPUIy44vNyLIEte+RI33CD
	 V1Vz0tjMAnTz2V0QzwcwYHF/341ZDGdNrh0Kdj+i535kL9uB5NdRP+/gTs882yyJYRdfE
	 jEgc9u/ApWlly7N0CCon8Yj0Z+ljRTB6vK2No/tcNDNwivKe1WODkYtnPLImHWY75hh0l
	 Mqf6He8WyZ7Q1kSA8QabMN9pdQcfHGbRBdT/qsLXeMmUmEzxO0d/TkNfHF/D4SbE77Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=l0gMFmdRWcZkGUi3skBiiP3zznOLqEeQ6/nyO8SA+pA=;
	b=m2geQrO93OOB9ao298VX0UOXqI8ofMxA6VWqpyxPpFMde4ZakdLG1dV3lRuwGkfE8ZEK
	 TMsgQd90FSXIoj/ezPaMQHLUm56Z5oMPyyp46bqWZNOYlB6t3vPE0eHXqIXWCwlovS0nW
	 cL0QOJSP01VXNKVgIWLHVS3Tn+IAdZzPM1f4mkGlFpUmIvh1CzNyfAQq/H9IJAkCVaK1l
	 Y91q4EDEAJbl8pWEQcnlkmrRobN0DRSWIZgs/sWeZ3Ze7rVNpfvG5TonXHad4IOy08+sh
	 QwMpH17unoETgzVqKV3gvvhfiaANuCSOsTll/FDTMLL2IkSTeJ9kNllxSlrAi0ungmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bTEwsWl8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77F606A31B
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 02:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E77F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bTEwsWl8
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bff8fc7cf2so164239e87.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 18:06:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793930817; cv=none;
        d=google.com; s=arc-20260327;
        b=N9ElKDZ7pkMXoLJ35GThkrcMfKMTXm8J8gCYc2n3hMdPePF70cwk6ULpFZ8PBSSA4/
         6s9oP1q5ws4AVf4z4fLltOu9znaykkC2KxCpeD4X2bSN3mic7nH2vau2khVJV+q9XBKk
         mXRbk9zysO3RxJLCfBmcIlzeCHmBmysmkp8skcCOL8OHMToH+F+rA0J7zLsTSRaFmnr8
         G2AGM9wvLvtPkT6QxsuvQOZtgZZ/5tRIUqiBPZi/yyWUInfuwou8Q8hNJC8Waxvxa7iZ
         aaFTM/xo4pKZ0/NblqOcaJdXyQeDy/IVsvEwCYW7tD5gny0rP9jPIOc21nSVkKnuk6hX
         /5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l0gMFmdRWcZkGUi3skBiiP3zznOLqEeQ6/nyO8SA+pA=;
        fh=SnzE4OilEOFaHN42bTUFH74gXJshvY0kpR+c4U5TPyM=;
        b=q3jB/GlKMctiQzzuWsnu5Cxp9fTMogSUIoPjVtPCEwGoLlkltCqtRDuGJXt1Pt/7v7
         maZbCTC9cfqCzqma4IrCsKKF3bQQd2HrjLPqkXm/6bZtQGJMhJUP7T6tO+JyHx5YL6aP
         aZrtX2P6GcL2iOEjaiG6s8y/mICgoYU/bb2yaZtO7OlxZN+7jblhKtBQe8i20XgAzeO/
         p8glxyJF7cuwk8n1TuUXmONQQaE+491ZSsvV28Y3pjFtyA9zMa4AxebVy0fZ9Ul9xtdk
         p9vef8fX0Uys0Gpoej+UONv7IwIg0hP7lTLKkzOnRChrIluEWPEAOGBEyF3m0kIWE95b
         rkHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793930817; x=1794535617; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0gMFmdRWcZkGUi3skBiiP3zznOLqEeQ6/nyO8SA+pA=;
        b=bTEwsWl8rP2auRdtT4mOy0IVH5JLTqmiNuqmiS+MtYbshLaP8eA5geIvLJZ/gKR07K
         9tvKCJkc0m6slg/AiadE6ja+4Pim1USQNbVczaJIK31GIs6b19NAvck+7xUH47jpPT/7
         dGkS9JpQE5854/6z/jA7cDDUYbZiNo7bKV0RXIhJlajwKl9MCyHyfubu3khlbPVnZHQU
         fjkX1MXiJcTOeTZMrBNuYnc7sPcCNIK8JjMuWse6HYHxSbZjWYkzJaJFMg2W0y64PhrJ
         dIsyY6pr3AuOs4U5BRc6Ml6P0G1Q/ABZ27onhRJ+T/0GJ7LDD+t9Kz0hfbl9Xu57cEAE
         ekRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793930817; x=1794535617;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l0gMFmdRWcZkGUi3skBiiP3zznOLqEeQ6/nyO8SA+pA=;
        b=1/o2SIjWwnIOo8olZW7cP1jaFmyAvBhy+t1Ri5Wde+0fcOQPyfE+8MHn3xuol6Ba0W
         QYlXFhM2TRV9G7Je8z91mZ1iStkWc9Am3vz77wki1HINiyfTUfDKDV3Zpw412Y3Eun4T
         ZYD+csSQHG+mSVFp+TJkokmBXrzWZhYET1b03WiXyxoGMvfDrGZTsMhShakJyxCffR6F
         RoJZwkSzfbzGFeJUtNKpknoLadg/asoFanHBujr9/eZsyGcc6y9aDrvg9CVvGhRVq5B3
         RTJI3s+BhA8SrB0SoVsV+aUkfdylLayJWqehuvYa0aOmXkRkOxF0wdeTGZkDflmpwfYO
         dfbA==
X-Gm-Message-State: APuU4Z8qF9AA+iWx+bb0cFUgXCK8gBaTHHia2AMSYV5q2EqQwP4np/7c
	fqFmn7eBqXVCMs+VBrvgRm/u+MVIVRfui4GCqirTpl5ND2SDp9evrpxBJ5pMSamzC01fS5xWSUI
	z7jOq7JHDluxPuVCzlANuauZp6Wt3ceT/HC2Ith7mlly981sz6UeXAHYN
X-Gm-Gg: AYBFou3DJAXkMJ4+CSOWJPA1AOftUstPm85t+oi/xpp7z3BPJKLSodWqWhbmEpZFqwH
	GKgyNkhlAF6C4XGrG6Nz/b3CKtu5WSRGbjCd8PIqgNnMuAGAcgysT6ywcwuwL/tfxW8NoF2HLyT
	mt+/382bZGJVOR6pMEHoAUtzNrGoFfYHA1nn6Syw79IKdsGpAR2D2T983DZQt0EtSQmxwtn/2nl
	aR+1+7ypNYfxR0MInSfwTG2z9sB7BWCdyEVEAqAJkhOsP6AdxExYRAJVa+5Ngfhu+v9FdVGaZyv
	lXPdX2DEOgNXW1pHPqxUWfSNounxDVpRBGvDKC5oWSL3iKpY+WV2RAS8CSUMruQX6kdVfjr7N1F
	2Y7dxZhECO4K2v9UPCogK4Ff8SNaaBk4x4iAE
X-Received: by 2002:a05:6512:3c9d:b0:5bf:cab4:e497 with SMTP id
 2adb3069b0e04-5c003a90393mr288409e87.10.1793930816185; Thu, 05 Nov 2026
 18:06:56 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027061258.3900768-1-apusaka@google.com>
In-Reply-To: <20261027061258.3900768-1-apusaka@google.com>
From: Archie Pusaka <apusaka@google.com>
Date: Fri, 6 Nov 2026 10:06:43 +0800
X-Gm-Features: AclHuK8yfmSwjKMfM9dW57iuCWESviIJvILa2tdEOq46b5OhHOpNvCgyeKuucsM
Message-ID: <CAJQfnxFCMtr6AyGqRqAYQe461U0m1WBgzZ_psuTnU+1kS8-5Ag@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: connect Bluetooth devices before
 HID++ handshake
To: linux-input@vger.kernel.org, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Maintainers,

Please take a look. Thank you!


On Tue, 27 Oct 2026 at 14:13, Archie Pusaka <apusaka@google.com> wrote:
>
> hidpp_probe() opens the device and runs the HID++ handshake before
> calling hid_connect(), so that the HID++ name can be stored in
> hdev->name before hid-input and hidraw expose it. Opening the device
> tells the transport that I/O may start (for uhid, UHID_OPEN), but any
> non-HID++ input report received before hid_connect() has no consumer
> and is dropped. Over BLE the handshake takes several hundred ms, thus a
> reconnecting keyboard might lose the first keystrokes.
>
> Bluetooth devices already get their name and serial from the transport,
> so connect hid-input and hidraw before opening the device, like
> hid-generic effectively does. hidpp_connect_event() still fetches the
> HID++ name into hidpp->name, so the battery model name is unchanged.
>
> As a consequence, the input and hidraw nodes of Bluetooth devices are
> named after the transport-provided name rather than the "Logitech "-
> prefixed HID++ name. Non-Bluetooth (USB, Unifying/DJ) and DELAYED_INIT
> devices keep the original ordering and naming.
>
> Signed-off-by: Archie Pusaka <apusaka@google.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 67 ++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 27d83b8bb..b552f31f0 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4673,6 +4673,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         struct hidpp_device *hidpp;
>         int ret;
>         unsigned int connect_mask = HID_CONNECT_DEFAULT;
> +       bool early_connect;
>
>         /* report_fixup needs drvdata to be set before we call hid_parse */
>         hidpp = devm_kzalloc(&hdev->dev, sizeof(*hidpp), GFP_KERNEL);
> @@ -4734,12 +4735,31 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                          hdev->name);
>
>         /*
> -        * First call hid_hw_start(hdev, 0) to allow IO without connecting any
> -        * hid subdrivers (hid-input, hidraw). This allows retrieving the dev's
> -        * name and serial number and store these in hdev->name and hdev->uniq,
> -        * before the hid-input and hidraw drivers expose these to userspace.
> +        * hid_hw_open() below tells the transport that I/O may start. However,
> +        * Any non-HID++ input report (e.g. regular keystrokes) received before
> +        * hid-input is connected will be dropped, and over BLE the HID++
> +        * handshake below takes several hundred milliseconds.
> +        *
> +        * Bluetooth devices already get their name and serial number from the
> +        * transport, so for them there is no need to delay exposing the input
> +        * and hidraw nodes until the handshake is done: connect them right
> +        * away, like hid-generic does. hidpp_connect_event() still fetches the
> +        * HID++ name into hidpp->name (used e.g. for the battery model name).
> +        *
> +        * DELAYED_INIT devices create their input device from
> +        * hidpp_connect_event() and keep the original ordering.
>          */
> -       ret = hid_hw_start(hdev, 0);
> +       early_connect = hdev->bus == BUS_BLUETOOTH &&
> +                       !(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT);
> +
> +       /*
> +        * Otherwise, first call hid_hw_start(hdev, 0) to allow IO without
> +        * connecting any hid subdrivers (hid-input, hidraw). This allows
> +        * retrieving the dev's name and serial number and store these in
> +        * hdev->name and hdev->uniq, before the hid-input and hidraw drivers
> +        * expose these to userspace.
> +        */
> +       ret = hid_hw_start(hdev, early_connect ? connect_mask : 0);
>         if (ret) {
>                 hid_err(hdev, "hw start failed\n");
>                 goto hid_hw_start_fail;
> @@ -4755,25 +4775,32 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         /* Allow incoming packets */
>         hid_device_io_start(hdev);
>
> -       /* Get name + serial, store in hdev->name + hdev->uniq */
> -       if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
> -               hidpp_unifying_init(hidpp);
> -       else
> -               hidpp_non_unifying_init(hidpp);
> +       if (!early_connect) {
> +               /* Get name + serial, store in hdev->name + hdev->uniq */
> +               if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
> +                       hidpp_unifying_init(hidpp);
> +               else
> +                       hidpp_non_unifying_init(hidpp);
>
> -       if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> -               connect_mask &= ~HID_CONNECT_HIDINPUT;
> +               if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> +                       connect_mask &= ~HID_CONNECT_HIDINPUT;
>
> -       /* Now export the actual inputs and hidraw nodes to the world */
> -       hid_device_io_stop(hdev);
> -       ret = hid_connect(hdev, connect_mask);
> -       if (ret) {
> -               hid_err(hdev, "%s:hid_connect returned error %d\n", __func__, ret);
> -               goto hid_hw_init_fail;
> +               /* Now export the actual inputs and hidraw nodes to the world */
> +               hid_device_io_stop(hdev);
> +               ret = hid_connect(hdev, connect_mask);
> +               if (ret) {
> +                       hid_err(hdev, "%s:hid_connect returned error %d\n",
> +                               __func__, ret);
> +                       goto hid_hw_init_fail;
> +               }
> +
> +               /*
> +                * Check for connected devices now that incoming packets will
> +                * not be disabled again
> +                */
> +               hid_device_io_start(hdev);
>         }
>
> -       /* Check for connected devices now that incoming packets will not be disabled again */
> -       hid_device_io_start(hdev);
>         schedule_work(&hidpp->work);
>         flush_work(&hidpp->work);
>
>
> base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
> --
> 2.56.0.307.g5fe7bd680c-goog
>
