Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198136;
	b=kqIIJ8+lO3jZ+rS+2KDlOqiQy7PcBmtywQGVyW5Fyi3/fZeVxKyPcUl+CmGamY3MDVVj
	 0tKjhm4hPG/no4Dd1DFGGptj4NoV1HMAToOyVOA5jMVUPQwijQmtyir6D8JlIXcS5et+D
	 tIlp+43bkQIHOqxviNeV9Ic++x+dvTrwTJtiqV1udoBXUx1t00QSUpeNFlXWCe3aIwZCl
	 J7EhHrNH5Cn7pyLXY8Z/MCakJBBmxL79dtv3OZQOCJtR1vOblJOkxiLVYwshmGFAiNhzO
	 ik+lWeA36MITaIDUImLLxWuCZGR20wXqZ0HnF9664mHvOh9/X/avr5SkLc88f6/FfSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
	b=XPc6HFQKSWCRNdrElhXIlSGUBns5wAi5FXIyzqNLuVSNLNnHuDngyfS71CXeaS9YpskZ
	 cdwx62MNuHQ/DnwWSCx3BVGnv2sG5cU7yGdt4q2PfybyaO6yxZsHe4Lus2G80A6wD+qdm
	 2rx4ZI25IHmYgBG+BkUjU295SUhv9krMCDL+a9sQMwgS+jK1ZWW7cLQ2jxoBo3ml6w02W
	 HALgY/nhm4TJq305fAkUFhCEkPEZkCKQcWiF1vz8+jREnxH5rrmgEIx4LJXt5LQH0AywW
	 SQT5ccDOc0tx2lPJFaKu3oV2F5f4Us1JNLGzQhVO0Nk6cMJ03r2C8Ph5+bvWKcFbnNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFc1VxT+;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1759606A338
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 18:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1759606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yFc1VxT+
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso1536651c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198134; x=1795802934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
        b=yFc1VxT+yT2G1I/sGQRx4QibLodUnLsBaTiSPX4XJ0/pE8Jva6hBD3bLnvD/yNGTQp
         uz9nguZM9AcuI9q4QQNXAClP6zHpfdRgmQ1nbf+drQcjiJfvlHeh9uKJtcLWxDQ9BcN8
         0ySVL9Xj1upl9OvwyIQtqzNKBTaPmsSJr9VQlx0bC5R8IHXoUkCPkuQrDshql5pcDHc7
         t/r3cfkLRToAOdxiRN4DWhyq0wY2GLff8p/bGpCnaj1X3kjIIy6Q9v5mO65dBQJIfZDe
         tmzw8Lmj84ze00OeZ2ZWqnceTXtnkPhauJRjBeOxGO41qYPyYlc6zCYkNx8NjFouSd22
         e0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198134; x=1795802934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdYm+HHLgR/sC/D+1yqxlL3neqfj1YS7RBw3yZu9BuU=;
        b=R/D2XAg4twSQO0pf8+ZzG+eUMvW1rAPr2ZenbAcFNxrevDaZcdJ5qd9uC0SNf4VFAn
         Y87LOIsD/qAjDAJfuF1m//AEfgNV1ZhVkONKoV9psTRGSao7lwyt5+XtNu2d50olrC0e
         ezOHvwnkBMt8DlddFrvEpkEexJLeFdDSLHae30NV35UvA/nA8zA55dq6/11AB25e2GXI
         ALYutODHeTPDCI9fuPb+iU7u/UybF8LBGM8xQ4bguveH03utHzQPg5qAF7bHtyp4SsRI
         +hEKQxdPoRqs2OyRh3u+QqMtqyHn63fAO49DBqNYVeje0Zgb3/m42QGdszAbCcujOwOs
         cmkA==
X-Forwarded-Encrypted: i=1; AL+hErG0ZGg+XWGDPE+N4esrn5WOwmLyryNW2Uvs3ntNowNOOcmnqo14McWq88Y/HzDs828axXInphVzL/Xx6w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AKyQuro4tOo9MYzcUDKx8a5oe5o5OXUpq65YGLEERxQK7mMqS
	1N+cmfQleAImQL+qBsCkWvzus/CXAfu5h0RwMSdzRtuXc4rDua5DERzk
X-Gm-Gg: AYBFou1tGYL2S+2xlF9+IEsFqpWaULd2bCH/PMFskGpSOLpjK1CIHANaG/5MSVDV+lL
	PxxUml7JHrvQppFEIa2eXMKYSJYDkbjt3dgDc+UdZhM/y7/yeyfCj7WoIoznGXB9FMT1rvOkhEo
	OxqFC9p0ZhTyp9Jf2KXTaXl/isO06/jvmOncUXrl7/4ZdFoGOu4WFnD3RCPEUmBEhFaAUQp/o6D
	axUQeknqsjX+y22rUkkaDIv9cf7qnxmgc1fSlaXjuxlHvW2yc165V/gcjiBDw4hkqoJO2oGa4Ie
	EbAVvkOrpuzq6S1qWenJKc5oGtJ/3NiwCT2bbuUaszHm1brrPeeU+UAJEzjbtu1gGib2e2Wvceo
	5uUD6s6hojdcoxTGU9Bt2GAO0z69Fu1Q57PfjtZkg0qy19Qg25eJld6ClYiYPNoNTL25lGO39YZ
	wro4ELMG9JjCFmzK6Wiilgvv5lOOBC2yr94yyLAiWQsGmT82IKEZXS0X3ztVYwGcU4H+tHCkPQd
	mJvA86JQ8Ukmt95MnRYKljEYQas532lSA1wksQEqMGdUPHAPT1BqQJ6O7upvJXPqm0tMSr1ULiO
	SrxlEml00a9UjNhu2FGuiMwPA860JB2JGwR48Sl2kxcvdiW3JTta3fH3oYwvOJY5GFe+eWo=
X-Received: by 2002:a05:7022:ea56:20b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b5568a65ccmr3689459c88.19.1795198133548;
        Fri, 20 Nov 2026 10:08:53 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm7761240c88.0.2026.11.20.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:08:52 -0800 (PST)
Date: Fri, 20 Nov 2026 10:08:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
Message-ID: <awCMOvYf64DZfuWF@google.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
 <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>
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
Content-Disposition: inline
In-Reply-To: <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>

On Fri, Nov 20, 2026 at 02:51:29PM +0100, Jiri Kosina wrote:
> On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
> 
> > Device removal and the probe error unwind path cancel the connect-event
> > and hi-res-reset work items only after closing and stopping the HID
> > transport, leaving in-flight work handlers able to issue HID++ transfers
> > or register power-supply and input devices while transport teardown is
> > underway. Moving cancel_work_sync() ahead of transport shutdown is not
> > sufficient because incoming reports remain active until the transport
> > stops and can re-schedule the work items before hid_hw_stop() completes.
> > 
> > Disable both work items synchronously before closing or stopping the
> > HID transport on device removal and on the post-I/O probe failure path,
> > and drop the unreachable cancellations from early transport start and
> > open failure paths where incoming packets have not been enabled yet.
> > 
> > On device removal where HID core enters with device I/O stopped and
> > driver_input_lock held, temporarily re-enable device I/O to flush
> > pending work handlers and disconnect input devices before stopping the
> > transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
> > reports can still wake synchronous commands without dispatching events
> > to the disconnecting input device.
> > 
> > Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
> > Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
> > Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index d5f53b35ac6f..0e1a9fd98faf 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  	return ret;
> >  
> >  hid_hw_init_fail:
> > +	disable_work_sync(&hidpp->work);
> > +	disable_work_sync(&hidpp->reset_hi_res_work);
> >  	hid_hw_close(hdev);
> >  hid_hw_open_fail:
> >  	hid_hw_stop(hdev);
> >  hid_hw_start_fail:
> >  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> > -	cancel_work_sync(&hidpp->work);
> > -	cancel_work_sync(&hidpp->reset_hi_res_work);
> >  	mutex_destroy(&hidpp->send_mutex);
> >  	return ret;
> >  }
> > @@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  static void hidpp_remove(struct hid_device *hdev)
> >  {
> >  	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> > +	bool claimed_input;
> >  
> >  	if (!hidpp)
> >  		return hid_hw_stop(hdev);
> >  
> >  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> >  
> > +	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
> > +	hdev->claimed &= ~HID_CLAIMED_INPUT;
> > +	if (claimed_input)
> > +		hidpp->input = NULL;
> > +
> > +	hid_device_io_start(hdev);
> > +	disable_work_sync(&hidpp->work);
> > +	disable_work_sync(&hidpp->reset_hi_res_work);
> > +	if (claimed_input)
> > +		hidinput_disconnect(hdev);
> 
> This fails to build, because hidinput_disconnect is defined in hid-core 
> and there is no declaration for it in logitech code.
> 
> I'll drop this series for now, please fix it and resubmit a version that 
> compiles :))

Ah, yes, I un-exported it in my hidraw cleanup patch series that you
just applied.

Hoisted by my own petard ;)

I guess we need to re-export it now that there is a valid (IMO) use case
to have it available outside of the hid core.

Thanks.

-- 
Dmitry
