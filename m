Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAE36C9F3
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454695; cv=none; b=Sxl2lDahUsAr7TElLWLtGmISipIEw4YhiUtfR7MI3/qgWCPZa8laj0gVNWjwSYIPOxakMAwRgHCJY2/watjz8DfHzvOmURz76bf+L0LrNwU2oZ4utpVDSveE1NrKTr1ihJ+KrkwVvJltMxijRyIRvFycGryUyezn0Pqmi275SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454695; c=relaxed/simple;
	bh=i5ivVmBTZafAuOlzr85wvD48Evi2ZiUXYHxZOzbjbt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ziq+BzKpXrwe+1Hy1fAFkexll3xj7igzvRg2JCcQEsuIkMoJnia3QLuIN8LHSa8pPG/e4uuUSUuu0wmZZMw0O6AEWLo1oq9eXbif0v8ySvpRnlAitjD7w6qtnuQ+Aph3F1ZDoWddyYQgwEgERv2ZtpYxi9bgEx+vFA87pkCXwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt2MKy91; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt2MKy91"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483bd7354efso59497715e9.2
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454692; x=1773059492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i5ivVmBTZafAuOlzr85wvD48Evi2ZiUXYHxZOzbjbt8=;
        b=Gt2MKy91zZu90LlInAPCddMkscLknzYGVzE/j1FUmBIoXXDtthd1eHHZdrJCtxkrO+
         pnNYliivOUZFTI59us3LO6rXsskDuIJFFHUNz/4cZ5Zt4Yo2B6u6c1kJbbF6cDSLMWaF
         4xTZbLyYLosQQYl7SmrUUl9O69ZNzBaRG2xo6JSbkHR7+Ql88TrqVJM1XrD5Yqf5m0bT
         R+IcEr3U5vrTR64brisXlW6DsC0tUJVmpcXOjFSBgHd02m8Fqydnr97Mq5iEvj8OTYdx
         L8ut00mhIcyQ/Ds5nO+Mf3K7PLhhJ1GQ8h/CUpXGIBjneHqXeyQdR6NaSgIwJl5P0Bnn
         gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454692; x=1773059492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5ivVmBTZafAuOlzr85wvD48Evi2ZiUXYHxZOzbjbt8=;
        b=eILmH+ZcASxtp016moCERSPZ2t5AxmWlN1YKliRsIHuOAlr9R5uY1acrBn1BpcL9AU
         g2r95Uxfbm02MVNi36Cgyk9IvquON9znIqdz1eqiEGHqmbt04tScaDlXlQVVVQs5xiPJ
         neJbexN3gHJB5GSEnDjJRYmk20JDmizUzIZiUNNOjdBXwIln21IRpzZrNmFGZ10fwSKr
         wyQgNCjsFndeDfQOy+c8rYcoC+fw76xjfeFX3melfb1/LgR3Grvmhv6mfVzsFI4cTHnO
         zMD3b6dW4SD3W6lTxc+gkK7eWx9FHmnYfCmqiEAUDq1S5eVTAUDiFhDeMN9XU9G8m8Ul
         qZsg==
X-Forwarded-Encrypted: i=1; AJvYcCVoQcwqoLgy1o1SZEE7Ssk03SIdgthIMiC8mgw5tBnzx1JJdqHft3SjSOD6PkRlgA2/4yNeVN67RIX7nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWtNaA44fMOc7uB9YFXh5tWPH9VGFYQVRwAVAxbldTG8IzmkU
	KinsG4ZibKSITNRqSBEQXwxc4fcVItV2nJ43lBXDyabhxSiKfLw7j9SD
X-Gm-Gg: ATEYQzxx8+10q+hrRX/OpG5Kqc58Eb2gtXyy+b1GiE/ts8Znbbn6WsGhgRTOwuV9AyW
	fOjip90pwIANFQ9h5oofpzyyDTAtl5OVUFrv5k6WxtISmqSHUYhumPjhbGMVw/jVydFXSGTqdiP
	4rdx1mFq4gsRSRoST97jXD/uXrbb62NS13rTS2q58dMJwKVQoSACOHJ3v/TgSoSQQnfJOBl06ve
	a30yx3YEjVQh1iMV357r40BlTX2/T0glW5MBifvdAUGaZ+i6dT3Ne6KxAJ2TZgWKivt8dfVA8KI
	YOqgQj/Dh3uLS7CEgTLogA+WmLTs6RMNTr97vyk70VJohypUJZoD3oRtsBfmiKYQ0FeSOW5sBhP
	hdG9Gn5vCQ7kLm/qtLiblrDKdE9+YXD+QecQ5M/ctgyI9sByd7RkQprDw8m44S31gt59Z+y0bg3
	cK1jHQD3eZCmCeYAGvy60EISYJ2IImO2w=
X-Received: by 2002:a05:600c:1e89:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-483c9ba37b1mr211770165e9.15.1772454692142;
        Mon, 02 Mar 2026 04:31:32 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb8724bsm165419915e9.11.2026.03.02.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:31:31 -0800 (PST)
Message-ID: <6158f495b13f2a8cdc09f37e296166ccf0393c78.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina	
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, Lixu Zhang	
 <lixu.zhang@intel.com>
Date: Mon, 02 Mar 2026 12:32:16 +0000
In-Reply-To: <aaVRIOejIgnOdAfY@ashevche-desk.local>
References: 
	<20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
	 <aaVRIOejIgnOdAfY@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 10:58 +0200, Andy Shevchenko wrote:
> On Sat, Feb 28, 2026 at 02:02:21PM -0600, David Lechner wrote:
> > The main point of this series is to fix a regression reported in
> > hid-sensor-rotation where the alignment of the quaternion field in the
> > data was inadvertently changed from 16 bytes to 8 bytes. This is an
> > unusually case (one of only 2 in the kernel) where the .repeat field of
> > struct iio_scan_type is used and we have such a requirement. (The other
> > case uses u16 instead of u32, so it wasn't affected.)
> >=20
> > To make the reason for the alignment more explicit to future readers,
> > we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
> > array with proper alignment. This is meant to follow the pattern of
> > the similar IIO_DECLARE_BUFFER_WITH_TS() macro.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20
> But this is in conflict with the other hack-patch in another series.
> I'm a bit lost what patch 2 fixes here and that hack-patch fixes
> in the same driver. Shouldn't survive only one?

+1.

I see this is older so should we only look at the other series?

- Nuno S=C3=A1
