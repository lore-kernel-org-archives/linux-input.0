Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CD4A3F30
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530047; cv=none; b=kQfccWFpd5alg9h/IOPxkKiR2liKmLqTQtMu4XTIt8LU+kthBIxeMEKOmVmM2rtthy757tRVMV8v0Vni3qNPtLTZjIuzwv7ZR2P55L9e8xFm7HzuucEhEAplWWIhuLbgq6x6rYTKmGyESy1iQP2THX1nEwR6S/L+QLFETBdXnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530047; c=relaxed/simple;
	bh=s17lTiy+D6tADAFYc9Xowx8cyyRfUwA/rqR3C3PbYTc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O79ZRA2tZlKRDlpIdYldyLbfjyf5QJkb/cwTf9afuRk3qgdIJRLwqMoqCa7so7EReYLkbscliw+nvCX0ULr7xJODcEHHDYrrUuQH1BWd51UCQVdZRrH+4VLfzwW29jk/AvYxG7058Nlv+unJwuDFbCpktlJlNwRJVnMFKQsmFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=exwU6QmR; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="exwU6QmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788530036; x=1788789236;
	bh=jn9QoafObVGn9ANtJC6LKK9l5ZfioNjymM1zIlYTw74=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=exwU6QmR/P6C+JvZuhwAlQ5oluMjNuAVoy2hr23VKDJybDfjLfm3imAHAE5Dr1Gtd
	 P/K+Q+45wkIQLGu3nzjckwrX/oWCsquSAkRX/2lh7C6TzJfk8E1n/OqcpPiNWsiNKD
	 zMBkN5zH5PZPdwAhv0+kENOGFa7wEA3Du4ca6hliaBKpkmL572+UU/t/GH4zB7M/5S
	 1wlJUlf9eqOW574f3g0qRhzGdwRuumc4LpK57mVG4XAGRyZ8Yo3INZ5leyADMrBSu8
	 w+QyV0G2GqVTbN4I+8oqQv0DA9XyhJr7kybjcdh9ESkiuyNGtaNLRgHERqvHxSp3Dg
	 GPbYQkpML+PrQ==
Date: Fri, 04 Sep 2026 13:53:54 +0000
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: budcomfort <budcomfort@pm.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org" <bentiss@kernel.org>, "ian.ray@gehealthcare.com" <ian.ray@gehealthcare.com>, "buingoc67@gmail.com" <buingoc67@gmail.com>
Subject: Dell Latitude 7220: eGalax P80H84 0eef:c003 factory passive stylus not detected
Message-ID: <62t8PiydnEWbOsSM0byy1IRKtFwxg7nfDZUtsgbE_1liuwRpKtyKZYsYwOe52IZ--zdy1QJg11p8u13QajhgH25DexN-Fx71z5TSlcLE6Mw=@pm.me>
Feedback-ID: 145930226:user:proton
X-Pm-Message-ID: 3bf12295e8c47eb4dde3039cffc74a2ab3e57298
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to determine whether support for the eGalax P80H84 0eef:c003 use=
d in the Dell Latitude 7220 Rugged Extreme is a known issue or is currently=
 being worked on.

The tablet is running Linux Mint with kernel 7.0.0-31-generic. The touchscr=
een is:

0eef:c003 D-WAV Scientific Co., Ltd eGalaxTouch P80H84 0710 vA1_N k47_45

It binds to hid-multitouch, and normal finger touch works correctly.

The problem concerns the small factory Dell tethered, buttonless, batteryle=
ss hard-tip stylus that stores in the tablet chassis. This is not the optio=
nal Dell PN720R active pen.

The factory stylus works with this hardware under Windows, but under Linux =
it produces no input.

The tablet originally ran Windows, where the factory stylus worked correctl=
y. Windows has since been removed and replaced with Linux Mint, so I no lon=
ger have the Windows installation available for comparison testing. I would=
 prefer not to reinstall Windows, although I can perform additional Linux-s=
ide diagnostics and test patches or configuration changes on the actual har=
dware.

So far I have tested:

-   Finger input produces events on /dev/input/event5.
-   The factory passive stylus produces no events on event5.
-   /dev/input/event6 is exposed as a tablet/stylus device with pressure, t=
ilt, in-range, etc., apparently for an active pen. The factory passive styl=
us produces no events there either.
-   Most importantly, I tested the eGalax device directly through /dev/hidr=
aw4. Finger contact produces raw HID traffic. The factory passive stylus pr=
oduces no raw HID traffic at all.
-   The device's HID descriptor exposes Report 24 for multitouch and Report=
 26 for the Pen collection.
-   It also exposes Digitizers.DeviceConfiguration, Feature Report 5, conta=
ining Digitizers.DeviceMode and Digitizers.DeviceIdentifier.
-   Reading Feature Report 5 with HIDIOCGFEATURE currently returns: 05 00 0=
0

I noticed the recent MT_CLS_EGALAX_P80H84 work for 0eef:c002, as well as th=
e more recent eGalax/Dell Rugged HID work.

Since the passive stylus produces no report at the hidraw level, I suspect =
this may involve controller initialization/sensitivity/device mode rather t=
han merely parsing an incoming HID report.

Before experimenting with eGalax vendor feature reports or controller modes=
, I wanted to ask:

Is 0eef:c003 already a known variant/problem, and is anyone currently worki=
ng on support for it?

I have the Dell Latitude 7220 hardware available and would be happy to run =
additional diagnostics or test patches. I can also provide the complete HID=
 report descriptor, dmesg, evtest, libinput, and raw HID results.

Thank you,
Orley E Mosher III, TSgt, USAF, Retired
