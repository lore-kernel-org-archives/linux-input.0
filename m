Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296063AE1A6
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437543; cv=none; b=P/LzyCCAlgUxs1dnOL5HURLhnLpMQwjOVo6o9nlOKP8CbPMIikenkuy+j7FsJjVMqYvO4L4JRSXFk/iR6OqYT841X8XrM4eCcBn4US7mwkLC/zHNkqhF6MYfMeBqVfulaq74d88xzeVaI7zg0nVPm4oLaqA46bt9QHCbUmckITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437543; c=relaxed/simple;
	bh=Tc/+NV/kn0eF0AEdWjxoP08LXHr862Uz8Cwk2GvLYHU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wa86ghAORYcfitN0q/f8UR8fBzcvAk0ay1kZHDibDhzg0xJYmaZt629fmF3fN1JXUNSca+qadQECEjleQA+1MhuzwTF+fabCDvHiVTOGntPUiMucTQI7qdAf+lsjzrFmInVSvIMBRxmP/aZeROSAAywhFNvwm1f9XlFVos8APz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oevb10F8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oevb10F8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso4920217b3a.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437541; x=1784042341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QXR4bewYefu3+kO4hCMBqgEy8jEESEUp6CSGCcVG80c=;
        b=oevb10F84jU6wcznsFWv6gMzNwjkPURWNY2Fv20YGsWNJ9FZXO/T/b8x7ubiIPA1cJ
         yNf+RX8+WS/9XSlOc8ebdrHEcXuKssrEmAqP8/CI51wQxByfNPy21PtTQOoKd4ioOzrt
         OWw3X/2NFKeEpiw+/iyjzsI+/nP3KpOrGatxqbA97tCXN/gsuB174om4b67pChDphYcp
         +mfHb2VPg5XbcMzPdeCYxcVbhkXu03lQeWtlybjVlE3E+zS4hRsSHgJDspcG9wnAEhky
         YuiQLzl2bjCGLgyRBYNdaJc4npeWwAfZOWI04ysEZNiXB3i2CtBNKLkBAESccQUVDSdO
         4dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437541; x=1784042341;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXR4bewYefu3+kO4hCMBqgEy8jEESEUp6CSGCcVG80c=;
        b=rjGr+oiNwWp6l41GFg5fvFRcynjWfQQuDmTWDPMvAWymjaGgeLB0POA+BgpmabisMp
         n3KZChQONNmEhg3eR+lbcnb7QUD/DGfKdnursbVH4l0ZyDRhUlwV4RMkW455p38OVbjs
         LvNKaZEMYFIq/3fF1eOeFPJEQBJgFlxsxZYXVyYK4Q/RCu0SI7W/CwSk0jpR7Ox1Sd2M
         WMgb9DOM51962xGTfEi81YBJyM0DLJNqJrvCBSiGSX2sJOmnMflkpQpyazEqU5SnArct
         HWyz8ZtEi73V4n51iZCYl/PyINnYfhO/LmtNtqqLnU0I+b5a5GdsCSJ8ul+MvO+jBHeV
         XAIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqF3odxnAU6eqjgx+2gqvhzG8u36BuQFjYRWEcUFjXpua6OjEcgYQ9w1d8GpXQzS3P+JUzNYD51Z8belA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcUl0z/HWKPIZ4HRtX663oUz2ANYEbv08wyVVGrTf0G0nW/nX
	Gfo5P1HVRa452eXoTisMbpAnVPXvZCuJJJRdJz8CtOGAHLtbSiXPB/y0
X-Gm-Gg: AfdE7cn40GvKLIRZoqTy5RIPadBP6o2Vf7j87/T8k0J/5EXGZiXiwCXopFq5a+VrZOx
	Slyn3ul8J36dmjnCjywSQHtmiC/tJzF1fBNGnKz34uPGg2tZhUyrKjm3z7WkJx/o5O9oQHOOjZE
	rdKXM+DgQOVgn//S2SNi+NVhkfj3GhzwBiBMQiM82hd0nNLQmza2v26JQMF1vr+c4G4+aaLHHeQ
	LV2ApoPOtdvLBZFLe7IJe4kBAbTjKD2gSNyABt9ADKU/APuq+mQGgLISHtkQkZuT2+zKhRLyPe1
	5ILGRPm2xo3d+h4E+nn8ks+4GRxAkwWgBKVupqJduLyQVFZ3kR+IZra/ue8w2v2oPECW5k54Cbq
	pLQ7c5vmuSLcwWVB6WFam16vbqCbTdQA2thsy2inwAORRXhg1QFc5n9Cg2//r99a3rXn+7O1Agd
	cYbVJjppgRlEoIAstWEGdjfzLBfiE00/mEYkwzbalXi891oYmK2aAKdLCKuXbM/ImJPzdaa81tF
	JYD/Zy3tdw=
X-Received: by 2002:a05:6a00:4b0b:b0:848:2f84:735 with SMTP id d2e1a72fcca58-8482f841650mr3042962b3a.72.1783437541276;
        Tue, 07 Jul 2026 08:19:01 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afeb060bsm1188440a12.14.2026.07.07.08.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:19:00 -0700 (PDT)
Date: Tue, 07 Jul 2026 08:19:01 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?ISO-8859-1?Q?G=FCnther_Noack?= <gnoack@google.com>
CC: Manish Khadka <maskmemanish@gmail.com>, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Lee Jones <joneslee@google.com>, Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_HID=3A_hid-lenovo-go=3A_canc?=
 =?US-ASCII?Q?el_cfg=5Fsetup_work_in_hid=5Fgo=5Fcfg=5Fremove=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <akzBhKTOVpaTb4nT@google.com>
References: <20260515174511.78486-1-maskmemanish@gmail.com> <20260515182347.6C82FC2BCB0@smtp.kernel.org> <akzBhKTOVpaTb4nT@google.com>
Message-ID: <11817F6E-710C-48EE-A48A-9D4F8476339F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 7, 2026 2:06:12 AM PDT, "G=C3=BCnther Noack" <gnoack@google=2Ecom> =
wrote:
>Hello Derek and Mark!
>
>May I please draw your attention to this issue in the hid-lenovo drivers,
>which was pointed out by Sashiko:
>
>
>On Fri, May 15, 2026 at 06:23:46PM +0000, sashiko-bot@kernel=2Eorg wrote:
>> Thank you for your contribution! Sashiko AI review found 7 potential is=
sue(s) to consider:
>> - [Critical] Hardware state corruption and crashes due to use of a stat=
ic global struct for device data=2E
>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
>> > diff --git a/drivers/hid/hid-lenovo-go=2Ec b/drivers/hid/hid-lenovo-g=
o=2Ec
>> > index d4d26c7833563=2E=2Eb9d8cde531365 100644
>> > --- a/drivers/hid/hid-lenovo-go=2Ec
>> > +++ b/drivers/hid/hid-lenovo-go=2Ec
>> > @@ -2408,6 +2408,15 @@ static int hid_go_cfg_probe(struct hid_device =
*hdev,
>> > =20
>> >  static void hid_go_cfg_remove(struct hid_device *hdev)
>> >  {
>> > +	/*
>> > +	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
>> > +	 * and dereferences drvdata=2Ehdev=2E  Drain it here before tearing
>> > +	 * down so the workqueue cannot run after hid_destroy_device()'s
>> > +	 * put_device() has released the underlying hdev and dereference
>> > +	 * a stale drvdata=2Ehdev pointer=2E
>> > +	 */
>> > +	cancel_delayed_work_sync(&drvdata=2Ego_cfg_setup);
>>=20
>> This isn't a bug introduced by this patch, but does the driver use a gl=
obal
>> static variable (static struct hid_go_cfg drvdata) to store device stat=
e?
>>=20
>> A second device probe would unconditionally overwrite drvdata=2Ehdev an=
d
>> re-initialize both drvdata=2Ecfg_mutex and drvdata=2Ego_cfg_setup=2E
>>=20
>> Re-initializing an active mutex destroys its wait lists, and re-initial=
izing
>> an active delayed work overwrites its linked list pointers, leading to
>> immediate memory corruption and kernel panics=2E
>>=20
>> Should the device state be dynamically allocated per-instance instead?
>
>
>This is the same issue which was also introduced in hid-oxp, which I
>pointed out in [1]=2E  As the review-bot points out above, while the data=
 in
>your static drvdata variable is maybe only necessary once (but that
>also seems questionable?), I think the mutex and workqueue shouldn't
>just get re-initialized in the middle of being used, when a second device=
 is
>plugged in and the probe() hook runs again=2E
>

Hi G=C3=BCnther,

While this is technically correct, the likelihood of this happening is rea=
listically zero=2E All of these drivers are used for handheld devices with =
built-in HID controllers=2E There is nothing to "plug-in" per say=2E

That being said, I do intend to return to these drivers and fix that issue=
=2E I was waiting to do that after the claw driver is merged as it is essen=
tially dealing with the same issues and that will provide a blueprint for a=
ll the needed changes in the others=2E=20

Thanks,
Derek

>This pattern is used in both the drivers hid-lenovo-go=2Ec, hid-lenovo-go=
-s=2Ec,
>as well as in the newer hid-oxp discussed in [1]=2E
>
>Shouldn't the drvdata just be allocated with one of the devm_*alloc() var=
iants
>as in the other drivers?
>
>=E2=80=94G=C3=BCnther
>
>
>[1] https://lore=2Ekernel=2Eorg/all/akfGTjId84EjV141@google=2Ecom/

