Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC62345CD0
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156817; cv=none; b=hOqr8SP+kHZ+71018k4aBNOS4A/p6vnkz3dmfToqwU7QRzNNdocGjiKh2G66QWlNvZglPrf8OMNDyYfFO1jtBf46uhrfyiG3GBWW5Ahz3GcVgKI/wkSEbfFpmB/rAD4Jez1l8VNlD/YK9CzkPWAgaMP7FSFVS93S+a2dwuzMDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156817; c=relaxed/simple;
	bh=b/L+p0LWgh7H+yRgKWKkuN4DFfK0a55DYXswJLOXpz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvtGmlFBlVS5ULXOc/EczOK2bE50MDbGxrzU2OvNBH7NDAVl/plhgsQAmbmsE9PhQ83ymR6qo4JrbzjLvWTTKdLPWLorpvbdRBW7kuF6DcS3ypW7Mrve4N0O3Z3eQR2pGK5weWfn9ZcuFdDPULm9OdQMleAX2myTBW8WGi/rifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMIO52k7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMIO52k7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c21495722so39724021cf.3
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784156815; x=1784761615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b/L+p0LWgh7H+yRgKWKkuN4DFfK0a55DYXswJLOXpz4=;
        b=fMIO52k7MKedN5BrHnvmrHu/VXRyKk+551ATh0T0BcQ2gfENf01Mm45A4q1kXrfpZu
         Qym/pro8+CV9YIno2GL1jJoeaUG6JoWyicvq2VnymDrSwKZiMAGG7uECpaB+xrIlkgpr
         fw3wVhi0bKnzyIN56rwyXsMs/WLSpP5JK/6hHw7Dq2Vc3i7dlN6XR1zwItpEJHWv5qba
         FbiSirMbZuaVKUX7ya4sNT3mqZZGj9WZ2VBHPgUAKZKq/gejp+Rqmc1ZmRNbgQMr+trI
         BOTFXmVZuh9CkFOfxwyIZtnfz70eQnbT+AQhu8cqNAPbBDfuoIpyf2/2y5WEIjWZR3dj
         zAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784156815; x=1784761615;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/L+p0LWgh7H+yRgKWKkuN4DFfK0a55DYXswJLOXpz4=;
        b=GLF1G8xKJVGF1iwR4Zx5BImnS9j05IfMFm+0f8PLh2W66r2ArfOkmf5RMKfdoi4sef
         KI3SSbNdDgOLegtvRpaaN2oRO3gtQS0bMRmVl5qBKOJ/iLkP0kweHrSPRsvniFnvSliE
         c5jDcRX6YZ03IzgIrMYX0H3DWn7KgJvng4mCJ71bYFMobq+adcleavQucNx1bSZjQyzL
         thNS9MBuYGiGhACirqAlJQJ4k6f6IrceLOU7sym/mXC7uCmf6u75U8YvU9jTyN2gG5W5
         p/m/9igVQ+QZc0e3BTnac9PmB2UcdaJmjDuGUHFcvUFmO3+PZhcNOLiVdZ5bTa56kKDk
         QVFw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0FMCoPSZLyyAOhIx21rKSnbMznpFG7oe6V4wP34g83OgSSMWdsKULSE1d6fEIG+XMW2BOApIB/igd+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsnQ+rusMUWA2Dac8a8ChNUxEdhn59fyZIBSd/FinGH6JRXGI
	TwW88OJOn/OVO1HvVOUzCw4MPPvpcIqg9XcmTUt+3hd623sTddWz4/Vb
X-Gm-Gg: AfdE7ck2+zJ+LabJQ+IJWX9lHt7aHIUAJd+zBEC51wcZyywdb+t0yRsQOfPa+XDViC1
	j/R9alpNSYMmWwJ3zmy8FGZlVgn8DFQVoaVXTSanL2/Uwou8sbb9xSvhRx/IZtrDNzdnnlnNAhf
	Fxrm/Bx1BtsgFtKPWF4mg7ObI06f6JvSvqt1r1flXXYgh6hobz0Tq1mjTpGreQIyLR00SjS9Ub7
	vXMsKFheY3Fw7u8tVDD5ogPM18uaeOYsDryoNnpXxF9sNsea9P7z2+0I7CmLgF86GbipwAzEKj6
	50Ub0G8WvM6/rBM7W3wCtJ1UjDp9P79UBcpKjWZIqzhJSG9TZoxrRMJ1qFr5KRz2AWndItOFIjh
	r29IU9de/CtWQC+X6wWdLYmZopaJCNjoS1JqhQaDjlKfrCkDmY4eVyR0aOxhaEjHQaPvQ9PQ+QB
	1A5WHwv08Amep9jhVNoxVrCQmM9gq0x6Rxmg==
X-Received: by 2002:a05:622a:1e0b:b0:51c:84f0:d903 with SMTP id d75a77b69052e-51e3c154be3mr105419001cf.17.1784156815184;
        Wed, 15 Jul 2026 16:06:55 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm141024961cf.4.2026.07.15.16.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 16:06:54 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
Date: Wed, 15 Jul 2026 19:04:59 -0400
Message-ID: <20260715230651.12456-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715053526.574725-1-pepemontfort@gmail.com>
References: <20260715053526.574725-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026, Jose Villaseñor Montfort wrote:
> A double report only ever wraps two normal reports; it is never
> legitimately nested. Refuse to re-enter the DOUBLE_REPORT_ID case from a
> recursive call so the recursion depth is bounded to two [...]

Reviewed the logic: gating re-entry into the DOUBLE_REPORT_ID case on the
new "nested" flag caps recursion at two levels, and since a legitimate
double only ever wraps two non-double reports, valid traffic parses
exactly as before. The guard placement (before the size checks and the
split) and the wrapper preserving the callback signature both look right.

I also stacked this on top of the pending Magic Keyboard/Trackpad battery
series and ran it on a Magic Trackpad 2 over Bluetooth: normal pointer plus
multi-finger gestures (which drive the DOUBLE_REPORT_ID path), and battery
reporting, all keep working with no regressions or splats in dmesg.

Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Tested-by: Alec Hall <signshop.alec@gmail.com>
