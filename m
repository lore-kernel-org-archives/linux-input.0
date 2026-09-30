Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59947ACD1
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808604; cv=none; b=XbpbbV5n/Mo41yofticdYrUom107nMCTI2lJfdre0MBWVcMDGFaP+IG3aYwBrURHSscE4g1848CPTGUTWGaLshTrKowHe3dkzILbyKLJfbACs4J0Slkfc2qsaxinOjjqUaW+4EmR47Wj+pvJpMK9M6N9k3qSxSUE6eH4DdsvILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808604; c=relaxed/simple;
	bh=WizLIhM6TlbVNKCi1noWPXGUULrd9AFMwA2m8n/wriE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwcAMx69+9LTLZN9oh6wNJB2fn7yWByJvHQa9kpcTr2YizjePJYPDnKqKQSOwKfJgw58gGpVnCbT7uE9vPblAtKiGCtFzMIjbnxvG5L1/eo+jU++qhwEv6wNtQbjEboaI7JStXpC2dFU56gPWGwiS5co7GffrO63fYFgrJJXosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2PsvEkh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2PsvEkh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso54178265e9.3
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790808600; x=1791413400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MajK9XnMSU/e1T6MRJFZkvlCwouooPRliaUc8H8wySg=;
        b=c2PsvEkhfXz6xbWmjSMoMBzUOvfaVjjYlT/FL8c4mGbIGYSM8aNFe6vKv68A6IsHRj
         l0rkGboMkRmApbRw6M26P5OIzNuYonDI/B1n6zq2y10WDHHRFQFVxfbw4DR7PDaKG3Eg
         KylWrF9MuYkDVOlabcgsGrg8Eu8AK21ozaT9hE1qcm6rjdfRIqomdzez81K617tT8kuI
         YicnTv74zFSAespPYiKXSv54K5shf2RoRVXKiZyloLJX3E91XP1eRqI371R2sKyFnL0c
         vj4Gyq/+amc4SXITnAGbBjDNkYI/STJn0XTvI7Bk/gf4BpMsMneziIcdmEgC3q1QfE4+
         0ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790808600; x=1791413400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MajK9XnMSU/e1T6MRJFZkvlCwouooPRliaUc8H8wySg=;
        b=a80TToltcrXGY98Zs5Tr/fLN7wiVhx6jVsQynD1yfsBhZjUQuJLJfI0s8MoE0Ea023
         2bG9NKwrdM704qX/ryZEKMe0uuJrd9dzxPOKNUYqzGw27DzBQkKh23Q+P2eW9hdeq9CM
         dIB9JJ1b22N3TenLeNIgKuYZnpwqaUbQ3aRpqPQio3uq0YkwZi2+B/csqaL+Lr41NeP6
         Koy3RemdRVyt0QNSacXGqW4/AMZVXAmD9n70E3m9e9c5yA4st1LFqeEeJnaEF+QxtF3x
         8DRWL0I4gutlVYLXwH91YRuwRxDoR/auHjmwy9XX/UdF6+Waz00Elq2d+t7w2Cmw/Yds
         pS1A==
X-Gm-Message-State: AFuF++nPfIJ5Na0sin2k0S5kAX3eAyHGP05l6ICk4dvZ2Dd/e3jd3bd+
	e+Lfo5F9OYa61rs9WeNnSS1VOD7BrlkecpIBs1H7exqktgtR/o1yaauM
X-Gm-Gg: AYBFou20YY3Q2fKe9Hby0pQBkEwS7DGcCi/dvNHEkJUhr+QUecaomIgcvNF6psZ8BRP
	Oo09RHbt1y3DT5MujnPl0Ae/SjBBoZN1+bl9vtOVK9lP6K+vSFvswy5t4KPNIdURrW4oDJfuo02
	8I2PEQ0ezX+jT+8FIujBcZZqCyDUV0//je3L+mb6+Yhb1xem9xyOx+QI7slYtExf0fs3ikgP6/K
	0dYKDZfZ/Q7L5QuaapZvrzKIKaWf0qoyHVy/kUjiSNI4ZUQ9EwmqFCMFB023BWuf7VwGaMDEj7I
	RgAoK4td/spq9L4bvsNkjMLwvoE0f/Anc3RfyBMpmy55sySvT0vuUVphGgIqwr4O+Ly/sIJ6W1n
	8vSiVzteiExlestgAu18kx0VeGhC9pgr5HDxmKV8Ktrm+e4NBy4+drP6VANFMvctRviFcJ/utpI
	Yawxv6SyDV25C31uGVYJuzZ1enyEipQOH0/occOrzqwt7BWdfhe9i267lhPg6EqYodOzFwZC7VD
	dUKbB7hA0NFvqyk+RLFhQraPdLyrtHHx2N6OPnvNXpIs1QkslLiBe27RIU88Dg7NSh5m98=
X-Received: by 2002:a05:600c:8b33:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a020c77b5bmr1641235e9.0.1790808599991;
        Wed, 30 Sep 2026 15:49:59 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f922ac4sm16411015e9.6.2026.09.30.15.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:49:59 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH v7 2/2] ALSA: usb-audio: bind the Topping M62's vendor controls
Date: Thu,  1 Oct 2026 03:49:54 +0500
Message-ID: <20260930224954.121402-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930215023.39C5A1F00898@smtp.kernel.org>
References: <20260930215023.39C5A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 21:50:22 +0000, sashiko-bot@kernel.org wrote:
> Does this lockless teardown open a time-of-check to time-of-use race
> window before the tm context is freed by devres?

No. The two paths are serialized by the usb_device lock, and on the
M62 the path does not exist.

The failed probe runs with the device locked. usb_bus_type sets
need_parent_lock, so the driver core takes the parent's lock around an
interface probe (__driver_attach(), device_driver_attach()), and at
enumeration the interfaces are added by usb_set_configuration(), whose
caller must own the device lock. really_probe() unwinds a failed probe
with device_unbind_cleanup() inside that region, so
topping_master_teardown() runs with the usb_device locked.

The disconnect does too. usb_audio_disconnect() runs from
usb_disconnect(), which holds usb_lock_device() across
usb_disable_device(), or from an unbind through device_driver_detach(),
which takes the same lock. A later snd_usb_mixer_free() finds
mixer->disconnected set and returns before private_free.

So cpu1 and cpu2 in the sequence above cannot overlap.

As for the premise: on the M62 only the AudioControl interface goes
through usb_audio_probe(); the streaming interfaces are claimed from
its probe. If that probe fails, chip->num_interfaces is still 0 and
usb_audio_probe() frees the card itself, which runs
topping_private_free() before the driver core unwinds devres.

-- 
Thanks,
Mikhail.
