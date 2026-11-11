Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794366705;
	b=IHHN1SZExDFaNEDMDtP+rIMz2UR+ygvXt9GQXnBW9AhlOAD6xyxF7zZou7h+qB1bbvAD
	 VKdmIINeIUMw3l99pkWY8deVN6jeWJ5m5EbYCeQpUuj/MgQjBeEggr4zD8qW3BXJW7a8M
	 3f4/brY0ZtbNHsxNFhenmaMYWzBhIPyNCC78zC0R0bJAp1Fq1mJnveSc5rQdNhINTpDAX
	 S5uK5QrNjHsjD7DxfrOR0b5FDt4iKPo5/mboKH+NpJlhnyt3Hs76Vmrw9eN2nH9ZZLz5B
	 ZSCuQOxiIcnLBqtEJP4qumWhYTNKj5hctyanisEJAsH+TIkkl9m2Uv01DGpvQM/YM/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
	b=uGNFTYolOe2SFMd79iSMhACl0Q5/EmO7cMOPvPWdllYGirwW23tK4t+n2h1fL9IwGaSN
	 BUhHRs2nYcioZjfC4yyg0qPN4TTfLGnp326+Xeb/Upa8jrhcTSsa70FKnBtLJgJy6Dcp3
	 0Qvk1+Pe6TBAZYBFcGeHGOOa19z/wROj++yUeQVrfh3GlY4sQdL6nWrBXC2A0+Z1x9n4A
	 JnTZoj2U7dexjI9WrE8plbC9VMy3OyD+AyXsz+46vVtiRIAL8cEcyp80ZazRJqPS6PGq6
	 l/UIgzQBLdGyQEv/B3XxF9L09wytLRQRnmHX04IXnZCXHZYa/Pcq8fGtVzYMm0rb9/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=murgatroid.com;
	spf=pass smtp.mailfrom=murgatroid.com;
	dkim=pass header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=ahr0TwL5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B9606A320
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=ahr0TwL5
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so4966728eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 19:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794366704; cv=none;
        d=google.com; s=arc-20260327;
        b=iLEj/8xeJuzgmPfgcMfRElZ9rQJ4WK2pG16lmWz0l76UCGIzrXWnK/mChdyiB1OFm+
         aCRJY9FlZ25Kg1equzQugn1UKOBp7Y8qbEbUJgi3XMM8jgHHhS0k0HamdY5ul8pOorn+
         L/nCjuwmOt61zkGkj48FZCQcL4yOc/SSsp1QZIxNyFqNgID2YmDBvx/EbMFVE/D9mIh9
         HghoZ6yLcqM79M1caQoF/XGkelS+yGnAoMx8OMzgn1htEmra7do82oqvXCz5fGjW/Yr8
         RJYL4/IUNUpamF/tBQrPFno3164SUn7QgwQ+LKXkq4eFotIZGvF7FLMOXkfyMMgZlq+g
         2G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        fh=HArRTnl7A5AirnzrqQw+KkQ3XgD2MBzXnU0admc7I2U=;
        b=KQqUP3Uh4yX9dpyY5cN4aetDskuvs/7WEp4vCXcuuPgoDAnz2mmLha539IDvq9Fimk
         B4yXe8OkISIAV/+bfIp7NIQXJrQg1XsElvfqezE5FEPsRdPe/knRO6e6SO0KijqcBr6P
         4RVlU5kyoz8ZzizNazWYToYg9k8txOai7+MuHrofMEx5MP2p+kko4ib7Rctnw5eYPU9X
         43VX/09Xvhwdm4Jiy03kk+6DLXPDWjREuhdWsIl9FQY8mWrqN5knO6JTB/g0oXS5gWts
         jakjRWYPMIYNijOMqS7mnJWliwCKtfuV1K2U663W67gYvjYwTt2RvNQg/PU8et3gP2Jx
         RXcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=murgatroid.com; s=google; t=1794366704; x=1794971504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        b=ahr0TwL5sXnss274qbskTXY5FmMPs2iFVD9HrT9uVudzZC/sj3d3unabJNQluhywMS
         IvwccBvLRok01eX2qO82HTDDomSYhoyPMh4DVYh4JUEedevvW4Q7zJF2roHE4t6Oggb+
         27lTmfSdauf3vipbuS5bHQ30aln7L9wdI/2ml8wSBxrFMZ4e4jmTtlLd9UQsn7CjCPiZ
         cczTGkTBsnontIFnTY2gMoVLM//Iu+c9ehsJLjsSFQTi+3SLn6n2jQteNUXruqMrPmGg
         dM64JYzmtir8m3mD5NZpr6HrHxJ5/OO63w0zFiRg/p884P3aPhqo58cOA6hdMpDB87l4
         ex3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366704; x=1794971504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+temhaowl0XJ/anU239LQ8gF9cvIIzxMmHoQ4oEdHg=;
        b=Z6u3fCmY9Pnbf9JY81YH3c93Tu6z981lsfxB6NRL6MFqp5X49hA0DyB+sM3TwCwID2
         X2wymnCY8JQtroPSlHpsO7hr4XwWWJVutP64dTwDGG5eJZh6STTfoNzjE5FgxGK6oQ7F
         OAqI6BccfJPZAAB/PaNDGhRtwuUvuyXCOcKfgQx9BoizyoOuJ/pqaEnnLhS1vsAgiIn+
         2tMD8XGhgGpqwVK95bh0E0QBMAlBwZq/uvkOjxZtKpK83nPZiggkYptnyV+u86NL5ZY7
         6MSSiVS6UJDupSrT/8G3TPr0laid28WOW9KQda6Jb9nusDFgimp3IxIOsWjlHCoL2BiI
         cDaA==
X-Forwarded-Encrypted: i=1; AL+hErEgXRj9YpNBXlvsbzgEvx0SMFOT4b2PIuOTfiAUFYd0b3AKrgUtS5/BWpbsp5dX0Ula8F3ChB97Wd+ADQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pdrIY2Xm/tTfCy6OnYX4V5nyx7A8xqsVFcCtnhVSgV7a4BegK
	5tHY4OjOhVkjT26enN4GduTn2LGCkubAUuO/7A7gcC0STp1+CKyFB6XFglEhnXPjfAyQpNg+Ulx
	CxqaYUlKQD3yc5k3n8FdwwZb2O4fYgiE/hSK2PHhq
X-Gm-Gg: AYBFou0TO0uZ3pOx2o71II9PYa0c9vT+qQBJLC4jt1HUKK6MbUhROwPrnC9UcBnuADf
	uWdQlGvR67fbNO06BwQ0pxOsYp38+lhIeMD3pxM9NUBT9HLxJjwFd/9FDMaLaJ5y2paKkmXimrf
	X1nYd7kJgXQ7oUtEROt5SDvTUWK0Gl9Joz0plsiQ1pTLV+PQgWwyVYQT0U+F/YPWgLPQr8wEmYw
	t2+RdsdZFiYGNGAqrgWzNtbuO0dxDa3HrW0pQy5N+nSma9WDPN8HF9W9f5z43lLx6nvqjFqqVIj
	TIjHNsf5AnaAwreBp3EfDg6k0KU39oaI9Iw4yEErx5FwBugfmFBzRPqCx5773xejzpdRcFDE2Vq
	ODWVSgBzNIBXeX8m7P7mKWL49dv8WXzTZeIRuuFgVBp7G2G499Y7W62Z6dseFPOlEC4cYDW7GLw
	9JhC8BVKi6QSzAOgo51Ofqy1nunp30hTFmNIPn6tx+qbwp9FUn04pc/8Ly
X-Received: by 2002:a05:693c:42d1:b0:36e:c9e5:33aa with SMTP id
 5a478bee46e88-376854ba4b9mr1792132eec.13.1794366703578; Tue, 10 Nov 2026
 19:11:43 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019023420.83976-1-ch@murgatroid.com> <20261102215606.5e36a2a2@jic23-hlaptop>
 <20261111025336.051fbbcb@jic23-hlaptop>
In-Reply-To: <20261111025336.051fbbcb@jic23-hlaptop>
From: Christopher Hoover <ch@murgatroid.com>
Date: Tue, 10 Nov 2026 19:11:31 -0800
X-Gm-Features: AclHuK-SGhvKm-m3dPF7X4f2O9KsRDzR0B5VWRGLdjPvi8wmwehWFpB8zvORHv4
Message-ID: <CACw0PsZ43YAQUcPuP7ec6gjd03Srn5QYUWp74SMZ0gzPLUp71A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lixu Zhang <lixu.zhang@intel.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Dropped patch 1, that should go via the hid tre

Do i need to do that ?    Sorry for the possibly dumb question -- I'm
well out of practice with the process.

-ch

On Tue, Nov 10, 2026 at 6:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 2 Nov 2026 21:56:06 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sun, 18 Oct 2026 19:34:17 -0700
> > Christopher Hoover <ch@murgatroid.com> wrote:
> >
> > > hid-sensor-temperature and hid-sensor-humidity share one static
> > > struct hid_sensor_hub_callbacks across instances and overwrite its pd=
ev
> > > on every probe. With two temperature sensors, reports for one go to
> > > the other's pdev; once that device is removed,
> > > temperature_capture_sample() dereferences NULL. I hit this on 7.0
> > > with two uhid-created sensors.
> > >
> > > Patches 2-3 make the callbacks per instance, as the other HID sensor
> > > drivers do. Patch 1 makes sensor_hub_remove_callback() take
> > > pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> > > unbind cannot call through the freed callbacks.
> > Applied to the fixes-togreg branch of iio.git with the ordering tweaks =
Andy suggested.
>
> One day I'll remember some bits of this driver are in hid.
>
> Dropped patch 1, that should go via the hid tree.
>
> Sorry Jiri / Christopher.
>
> I only seem to notice I've done this whilst writing pull requests :(
>
> Jonathan
>
>
>
> >
> > Thanks,
> >
> > Jonathan
> > >
> > > Changes in v3:
> > > - Patches 2-3: set the callbacks with one compound literal (Jonathan)=
.
> > > - Kept Joshua's Reviewed-by on all three; patches 2-3 changed only in
> > >   style.
> > > - Rebased onto v7.3.
> > > - Sent as a new thread, not a reply to v2.
> > >
> > > Changes in v2:
> > > - New patch 1, for the use-after-free on unbind found by the Sashiko
> > >   review of v1.
> > >
> > > v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatroid=
.com/
> > >
> > > Christopher Hoover (3):
> > >   HID: hid-sensor-hub: Synchronize callback removal with raw events
> > >   iio: temperature: hid-sensor-temperature: Use per-instance callback=
s
> > >   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> > >
> > >  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
> > >  drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-------
> > >  drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
> > >  3 files changed, 24 insertions(+), 16 deletions(-)
> > >
> > >
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> >
> >
>
