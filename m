Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0237E5D1
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061052; cv=none; b=Tm8qlJY8CGTdmYbtDUAmVQEHCrAPWgLId8TFNmQcRjctvHSe/l91gBWl2BIvh259/JqzDBP6krUTLY66T1dliOhqXxcvAE0GGVGWsJOafUczvEqWx+/xM69HIhU0hVlDxcEXxJRG7f22nWaar3RfZ7aRxxHnsgJyYGsHi/tcXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061052; c=relaxed/simple;
	bh=x5Iilz/lxehhrk8Fng5Cjg+xaEw8uIKDfQysJO3xwT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=BTxGBf+QhVjbuWxLX8WOuuNjOoWaUXksU4IS1jZ3nRh4b9URjndqQC0Io25mhPFD/qq3OKrSSXkxQSOBSAp9sCdgbr+RMAMN2KXoIUwxk90lE4f1TH7fjeGZ10L8PcuKhZBv78RPcAfeAaz+VJ/R0pf9Vd9/eCfCbATLJ1v+O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=GripJtA5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SljonBVz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="GripJtA5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SljonBVz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=GripJtA5WTeupzUfgtGM52DAxOyu15VHAk+BixpMYaUIl8WjPEEkOJhuW0V9wjZPMqnsAMNFvPRCk63bRKSjAoHl5OO1BNLtL4hGfkhopxBDZ/p+CRbF2/n5ah7uYxxWCT9ozZ20eIopFAGpXr1lv5h8t9CzdKbDdbjmt6SVqvzNzV2ImFVRaXMIELyS2V/3LybnZjSrTYPTTO1/mChkpWJSE0i9N4veTCbeOtSMeOOrOdQwr/756OT5/+tQ23qMTNeDLCSpmhwucl7CDdIQ1YGmDZBNQLjYuX7KaCGaHTXlk+8Pgwv2gq0/7jkXKlUNc0/+rdtUXq5MUfNHBbkJXQ==; s=purelymail1; d=rcpassos.me; v=1; bh=x5Iilz/lxehhrk8Fng5Cjg+xaEw8uIKDfQysJO3xwT8=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=SljonBVzDHPet0NmiqtqB9XTW6RsYlrGf5CFX1E8SSBD49m7lIpZWhnGgLdJJD5PVGkNaDYHL3ZOsHMRvUaKDuBJud7v1Z9ur3ns5oFUXmkUV1xSfFlv1ZeAwwDNUf9NAkm2SLF0IfH4P9M2X0AsnJ7dmKkl4kt7KlMFkSbYRu8CZyKrxkz6kBUGOhkuiBfgj/clKhBLyOKUlncxVYximmH1HBUu+Mze+4Nj59G1/jhdJcURkf1qzsaqPfkyzKE/yukt3RwHDeN/7QFWuN1jKDiOgTrKhlYv2o0xT29vjIw/3FIBtYWer/uDNXy4hb6eoxUhEOsGzKXKY6ODq/DHMw==; s=purelymail1; d=purelymail.com; v=1; bh=x5Iilz/lxehhrk8Fng5Cjg+xaEw8uIKDfQysJO3xwT8=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 951244302;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 20:30:29 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 17:31:50 -0300
Message-Id: <DJYKVRU31TCD.1M8E9KUMBZL1I@rcpassos.me>
Subject: Re: [PATCH 0/3] HID: wiimote: new LED behavior on connect, and
 scoped guards
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "David Rheinsberg" <david@readahead.eu>, "Rafael Passos"
 <rafael@rcpassos.me>, "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri
 Kosina" <jikos@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <DJV56QRLBO6S.3H33MNASQ866@rcpassos.me>
 <850e8696-311e-45e4-874a-8089afe35907@app.fastmail.com>
In-Reply-To: <850e8696-311e-45e4-874a-8089afe35907@app.fastmail.com>

On Mon Jul 13, 2026 at 6:28 AM -03, David Rheinsberg wrote:
> What device name are you referring to exactly?
I was looking at the `wiimote_devtype_names` table,
but I figured out its only used for logging.

What I actually wanted, was a way to return a propper name to the user,
with a controller/player ID.
When listing bluetooth devices, I have 4 entries like the following:
    `Device <UNIQUE MAC> Nintendo RVL-CNT-01-TR` (x4)
I wanted to display a friendly name to the user, like the one on dmesg:
    `Nintendo Wii Remote Plus (Gen 2) (1)` (where 1 is the player id).

If you think it makes sense, and its possible, I would love to make
this change in this or a future set :)

> Anyway, I like the series. I will review your v2 properly, so please go a=
head!

Thanks, will do!

Rafael Passos
