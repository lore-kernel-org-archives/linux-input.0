Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEB34F483
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982780; cv=none; b=KsbrotlE1fgnSSYbsPsciE/scYgnYW0wlWN0kEp9DFZ9WbgWxd/4133ZSk38pqTm5zKZy1LwsZR7JUSyZdELIIMVBgdhprFiKB6m/PcPW223qYqrNwHDCjwNq/PbMATYuHBx2Y1ZOdEUxIByQCPc74IhvFy8OmMWLFe80N3y09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982780; c=relaxed/simple;
	bh=EFHHBUqZkulkW283cRClEdU8zex39fRkCXIVj4vCFfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLal8xMa5JqG1OQWvvzOMK2s+D5tvAeO2O/2AHKFhdx1A9OaHDQiEx3RgOcmnW0QtZMLMJItltsWxwPU7skmxJ6dCGpxrfB6uP4+4FzG3VXoRgJDIQagxxtV50A8AGvbLViKpJaulC4o/Sv1e4kI67ddlGoUPDdhplKYUvNwuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiTc0b+C; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiTc0b+C"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd4cc208so3240192c88.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780982779; x=1781587579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVQFitMULzV0jlKXU2oLkFHPkf/TQ1MszSxTz/FIHNM=;
        b=PiTc0b+CZyRB8Yltm7+BJgpMaIj4dNlOAWxYCrRZIxIG3R6sVew4THnLw7/iyXHlfC
         O1Puf2qROlJkidkHeSUnmSJxT83oLYuAqWUBj/CCfTgJSsKKNZy5GAKyvarO9n+t8mXH
         yz2H0bcpTxmdhxXZkp8sCV/0CW4sQtcIS14plCoF04m0ltdSy7ZslKVjgKEc+YINy6PA
         BrnmjuhOx6uxvkL8dcMRDB2TfpZmT6/CECIut5Gfi/wZXsadhdsbtjGPjc95SMEe0EoQ
         ACW30jwMHigyeTQGsgtdPsj8gPQHFrfzVnLiMLRG9jAdf7nrU6KnDt1LQ2DEnXh6B7A9
         hpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982779; x=1781587579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVQFitMULzV0jlKXU2oLkFHPkf/TQ1MszSxTz/FIHNM=;
        b=g8R3YNjNzzLAhDSpaS67Khm9LobYvuVhkmMgd9wsj1MzBJ/5AQACfIjjHpRFqZlCYf
         n/Z2kkM0FZjuDM/r6QKItLIeYfOXMCClQoCqOjpALmHGfx21j2PUx/QZqKcFP0tZ+F/M
         47tjpa0VYa3j5/rTOvKdwIAgyDTMAmms/+S/USPu/Sk26S5lXpF1rXLuE9oV47OW8c0Y
         X2tq2BTXmbGGNFOcRuHJiQVfeYp/Ea/IVmMs7Oih1BcnN4HcuTh9eVRRqqrc5feUmQvH
         p4sL9VXRRUhDbac6eSlj9BWS9myQ8kE5/wIcXNliAgDB1Jcd8B3Ziw0m7h3CF3FMTzRD
         R+qg==
X-Gm-Message-State: AOJu0YyyZaZS/c03H2LKvUAmJVjAhbt+u3Zsq8Z9s2bND9kgItUxq05E
	5zQ0HD1rsR0akbw+RPSHL9gcpaYk/17cCYDkGxoznjl006KWlK4vqDzSTGWzZg==
X-Gm-Gg: Acq92OGlMNNydkqWO2rjd8x0dh21M80WT9XSmr+vAw8rAgyEIWjGubuyudIhL7G1/O9
	hBp/u5RQnX3X9Tqu68IT6uEKLwaBg7cEXuwpRRJvXGaXp7mVt6h2XUwK4j+L2QJU09ieeYWgdGl
	kGXqeYgLN8Ko3uM6/eKZ3Ykdik8fOi/mMggIpilfs3s3nlXW3XoZHymB2e/2JfTOpusRvQ5RaAM
	bP0v7h7wOeMfcpm44d5kd7mMNL3782HXFgIae05CbIfi6SJIlct0hG004//U6tHx74slmXzsuuX
	MKJc+N/N7w2trOIcmLumtmTs7gugVRoseLl9FI5/kXYHZ+EdzvdTME3Z7Gf68GRVYYlph8VfAj8
	BlDc4W3sWcyPakdlSX3JlwSdmjXNRX/goJN7GXE2JPG5w6kholo3IG7ZZimxsLBzlkFaREPF+d5
	mE7ZDIAl0xFeE1zxeARuGOj6RY5dSUojMPb9Le45VX39ToEKBzbhT9YEFddzptVXTzbYoXlq/PF
	mc=
X-Received: by 2002:a05:7022:6ba6:b0:136:aebc:24f5 with SMTP id a92af1059eb24-13807d7e4f0mr9024789c88.15.1780982778582;
        Mon, 08 Jun 2026 22:26:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm13728402c88.10.2026.06.08.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 22:26:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:26:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input: ipaq-micro-keys: simplify allocation
Message-ID: <aiei-6StVryWDvFg@google.com>
References: <20260608045041.4664-1-rosenp@gmail.com>
 <aibx1y8ANiZoMHyY@google.com>
 <CAKxU2N8s8z5jD2JVU4b166jQYsUjWMj4Q5a-B6vkX7-fhCK8LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8s8z5jD2JVU4b166jQYsUjWMj4Q5a-B6vkX7-fhCK8LQ@mail.gmail.com>

On Mon, Jun 08, 2026 at 01:20:36PM -0700, Rosen Penev wrote:
> On Mon, Jun 8, 2026 at 9:49 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Rosen,
> >
> > On Sun, Jun 07, 2026 at 09:50:41PM -0700, Rosen Penev wrote:
> > > Use a flexible array member to have a single allocation.
> >
> > Why does it have to be flexible? The size is known.
> From a quick glance, that would be a compilation error. micro_keycodes
> gets declared after ipaq_micro_keys

We could swap them around, no big deal.
> 
> From looking at a bunch of struct definitions, [ARRAY_SIZE(foo)] seems
> to be atypical.

There are a lot of "#define BLAH_SIZE	ARRAY_SIZE(blah)" that later
used in array definitions.

Thanks.

-- 
Dmitry
