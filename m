Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906250;
	b=2goCs3d8wXkhfPlH4I0/8r8KP9CZ/7IANdjm29Pf/BLDKEvh1mVUwqq9Ohkr3MO/KQCC
	 3g5sSCiIV9+QjSpGTNsN0QgrbCMoydJs4/QG5Qwr3fHtcgz/96K0a9g7tHGrebINPHM+o
	 j8a2QzKv7KnvjQA7sVQRlKkOICRaZ7DwpThBMPOziqdXt/uGKdnscVDgZtsfxbDQvmD3w
	 MZuFC11hlBJm3IgDZjpV5Zrt4Hch52oWKu32G0XVJpAxUCfebxGlQWnCR0me6Vesw3aYW
	 049F8CW5wrYJTvdvIEubjJ8mS21NT4kCoybKh2a9Vq4jY5vnlFdXwWatSrj14ZR9j9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=zXV6RT9kjVbaPxR7LiyTL2haaz79KhRGB/dQwKgZyxk=;
	b=vDdSEmB4AbKbvLGoUvP8CTTDTNumxsd7mJd522I568Y4cR7BLCjAbPbyk2YUxJifzd93
	 pVhoxj8USqDWpz8phHeOCo5baPCYklgEiZ8bYODz9i/TE6eCvlUg/HB/oYCTkY7ftkfo5
	 Mi7fIf796aJ3cbhrID4vtPc46k/PlpU/BeANBsvRK80e5QU2fIOFcQE/ZuD2DAy+fWyoP
	 mM5qzhg67kxjokObMkyJZyoLYEHw8a6DsKSiuuFKwEykyTfsEB+gFAc+r6TewY7bf4UHZ
	 TeCN4PgEy9qs5shA2onuZyGSIvK9kmDmWOcBURiBg3S4SCVL0yuHA+BQTXRfb7xD81Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EktWYSMi;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26314606A31B
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26314606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EktWYSMi
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so19881eec.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906249; x=1794511049; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXV6RT9kjVbaPxR7LiyTL2haaz79KhRGB/dQwKgZyxk=;
        b=EktWYSMiEImy88FaS/DyQDzM/n8SOCbr3+TzGTTc493Ge5kmN7iRRGecsDHjHQvwo+
         kCilcxLHHYbNcgd7iCUrNBijZzl4ubjJdVzJ6YBZFARUV3fDjXSkUfmsRu+7VUgbVxHx
         nZW7swDliKuR6Os9cre3UhlFLlLrzZL2RfTt6Isbohmls75+y7NMItsZh7wi8iahQhQk
         F66Rl8eAGfO5mvE6P1OuB06O5fF7v+UaaDXW9iYItyr4k6YFbkmMETJvqK9v9H5iy/94
         88UiXWP1eastAPOJ+6ho4EAXtrrVDdcdMGf8qHI3Zhb4bIiqblzdjMp/l7C/X48yXoQX
         3+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906249; x=1794511049;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zXV6RT9kjVbaPxR7LiyTL2haaz79KhRGB/dQwKgZyxk=;
        b=SnD1YkA48YFDso3pT1ehFckXphFajjewbf7qQ8O+6ceUEpJW56suaEah1vWwCGUWpp
         26UyicV9ChLKehYiBH6LH2xymcJzEG9lQDUU/ivjzAmCgi8JPY+VV9BB4Pl0VdQrR0oZ
         pHy4kh9vWdgjiLAtokFv9wtLxS1aZM/H2pWkoabwJDBm3Zf5ByX7AegX6m4LUQMBCVNr
         W7XuK08aBCOTiXvLwA9TZB4OLD7ctDumFEutSwBMjsrnQqgXaUATe2ttG1vV3xm5yxQe
         cpXsk2+o64EcxEHk1BoRI3sJUlOq5MBazaE0rZBcf1WAwX0yL+xANsK43vYwmcTfixCJ
         YIWg==
X-Gm-Message-State: APuU4Z/dQEY6SAqHO8g6CEREpWavxoD5obVQQCW8ojRmvNxFPK4+YXgk
	+myy0G1GM1m6dZVcGQ99Tf9YAN0oZaxNr7DROl+B/gir3tLvcWv3Q1yT
X-Gm-Gg: AYBFou3Jqq1Z21Isi7neL/6SPf5j622ZThraCmx5oSmzSGiF3lVJD5Xf+rCA1CJ355F
	wjPfI3gCj6+VvpA/7thHHXwK9qwnK7IONqvAJBrXgwQ3qgo4sVmVb79WmUKSdCXi3+coURUZvzH
	8/j2k/bJAZMndnIckmkn4phU41p7ebLKZAbY4q+05u/xHtJEtYDAxOWgUGovO9smpA487wqgrbl
	Br3Ux05Qf+UEvJG9YAdml6Qp5Y4SJUImnv7WJYOmn6/XPX58EAK07NNQqQ6zmyFDK3tGKr2K8za
	npKW8xKokCxHgffzzucUYz/9TlahUPRfLIBTiJ5urzjyGmip/xfFkhdksuPROj/V9Hdd1MiKtV1
	YONByp9XJ5g7W40u6Oy+iqfDxwFFPT2PYaYlgvOVUPt6UBKy1yMeT2qmwIf063fUq2IF8xNUHlA
	oqZgKjt3OmasEEQeSkgbmboFCNBnzag6G3UO9FVE4wkQmUdSZQmzXJ6LS4sXCAqw9oY4gm5HA2s
	o9QwyZv4m2QqKFHDoOJFGAD4DklZc61aujtxDw/2uA5vvE+efBk5f4QJPs3zmjvEQGeLpZP9L8T
	jKrc5FDenbvmcHx9prKiQ1pqSnmmN0ZLSYeiNO3zj3BQy/rla4Con2fE6wVaJgDb7YBPhg==
X-Received: by 2002:a05:7300:f0c8:b0:36d:a466:9d0b with SMTP id 5a478bee46e88-36f75b1f833mr86311eec.19.1793906248987;
        Thu, 05 Nov 2026 11:17:28 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f72dc5548sm197299eec.12.2026.11.05.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:17:28 -0800 (PST)
Date: Thu, 05 Nov 2026 11:17:27 -0800
Message-ID: <44267fc27bb527b5ea390ac53553dd7a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.com, bentiss@kernel.org
Subject: Re: HID: logitech-hidpp: G920 FF init fails with -110 since "move FF initialization to .input_configured()"
In-Reply-To: <CAPb1+K0aFMox4-FTjODmOSN7iHDXfFGq-2jGfQyXcp+X_rNioA@mail.gmail.com>
References: <CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com> <f37327374f65a93439c6cf0c6287a820@gmail.com> <CAPb1+K0aFMox4-FTjODmOSN7iHDXfFGq-2jGfQyXcp+X_rNioA@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Wed, Nov 04, 2026 at 09:32:04PM +0100, Gideon Heinz wrote:
> The init failure is fixed:
>
>   logitech-hidpp-device 0003:046D:C262.000B: Force feedback support
>   loaded (firmware release 4).
>   logitech-hidpp-device 0003:046D:C262.000B: HID++ 4.2 device connected.
>
> No -110 anymore, and fftest lists all effect types with uploads OK.
>
> One separate observation: when I play the constant effect in fftest,
> dmesg shows "Force feedback command queue contains 20 commands, causing
> substantial delays!" followed by "Failed to send command to device!".
> This doesn't happen on stock Arch 7.2.11 (no patch, old init order).
> I haven't determined whether it's related to the patch, to other 7.3
> changes, or specific to the CachyOS kernel build. I can capture usbmon
> of it if that helps.

Thank you for testing!

Yes, a usbmon capture along with matching dmesg output would be very
helpful. Also, when you played the constant effect, did the wheel
actually produce any force (perhaps after a delay), or was force feedback
completely unresponsive?

Note that hid-logitech-hidpp queues all FF commands (gain, effect
uploads, playback, erase-on-close, and sysfs "range" writes) onto an
asynchronous workqueue, so fftest prints "OK" on upload even if the
worker thread is stalled. If anything queues a command while the input
device is closed and the interrupt IN URB is not running (for instance
cleanup commands from closing an earlier fftest run within ~15 seconds,
or a udev rule writing to the "range" sysfs attribute after probe), the
worker gets stuck waiting 3 x 5s for a reply and later commands pile up
behind it. On the other hand, if commands are timing out while fftest is
the first user and keeping the device open, the inverted init order
(hidpp_connect_event() now running after g920_get_config()) or another
7.3 change may be upsetting the device or endpoint.

If you can start usbmon before loading the patched module (or plugging
the wheel in), wait ~20 seconds after probe settles, and then run fftest
once to trigger the constant effect before exiting, that should tell us
immediately which case it is.

Thanks.

-- 
Dmitry
