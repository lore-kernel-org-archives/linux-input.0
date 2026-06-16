Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172423C8738;
	Tue, 16 Jun 2026 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583889; cv=none; b=u5ZLQzSQED2iZZLOX9NWIeXKKDpWYud+K7GA4AeVmR/yUHdS5EufG34NbUG14OufKm7tb9Yi7vs0/gHSucl/pVkXvwY836I+BJ1Jb2R4AlMykCsk+GqqPCK6WNokx0rRLgjHWO2rNV1y4FLMLZuPgpZHg/DlM4BFDoRkNjY5vsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583889; c=relaxed/simple;
	bh=TooB9fuNzqFzvlDpyy/qp361HVzKFMwkSEWbbK7EuS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpBkjH27+zUy51kEOkgfncA/ziebcarOmUNf7B5R6bT1OZvFil1H6F3XUabMuZSxwsZuVaV4vTup4fDQhAJOLKACg8cj/sGuDDVM77PUK143ntjMHI0nf0gd9kiOIjVy3wh5/+ZYt4uOfe+4Q9t3c6u1H5qmMWXha7HoeQVacr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=LgBzFEHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVRs7coz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="LgBzFEHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVRs7coz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F1332EC0032;
	Tue, 16 Jun 2026 00:24:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 00:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781583886; x=1781670286; bh=aIbjbQoCoZ
	WMWxtel90tXuoxffLrjBDNWsWDrpsWKmI=; b=LgBzFEHK/Akw5SEzLDrCNTvBM+
	VY62UW58979lF2YvUaR36oj4fLVLiSPn+boVxpdDhWn8QqTXjG3/4m7gCnIPYpP6
	N2IpprFU0sVGEUUnlQpZzaUoBWqLd8spZrTyImZ7CFIMprsutU+jV3gudutlOLl/
	Nf/0fpPtTDUjS2YDHOvrdHWt+1N5MVeLyDJ1fDO7FddWriA4UpaVeKv7ZidN157g
	wgj0+2c9OpbHxXinw1b5uQoTw2usNWhvjcnu1Acew1fTHsoMaIru5fnSQy3xlB5u
	QLfKRoDwtDSxAI+oPmFtjSFqJMB64z8i2iWZnRe3R7+cmhVmErlUfihLfnlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781583886; x=1781670286; bh=aIbjbQoCoZWMWxtel90tXuoxffLrjBDNWsW
	DrpsWKmI=; b=YVRs7coztl+SGKpIhsNi6UH5OgARFPBK6QljsBzmaLGjN4xDJ85
	lUhuOevl0xmHXe6qBATyn+unw+N3aWkCQdAeNrJbDLlyYaFfuAEoV6H4DPPSZHqg
	WDJFrCeVtsFxWahVIeeXwrHLqj8Qc4TG0kgyiyDV87zjMheyHyHLtIq7RiVGZERk
	IA96PMvEbr1Ooh3Fu+is5pIC4aIoo+ucjLSXQDNchM6twYFQFnjmC/mx0V9Tow82
	7oM+zW+QFar9AC34cYRiRdvIhFcRUoor5/MhvBFF8O/+0ouW0/UpvjsHmSRzI67J
	6Iv8ytZxT58eCFtqoBc2KNpfNoCmhdKgBKA==
X-ME-Sender: <xms:DtAwahXPCNolTxTMDa_vKii9sfBaDn0DgLzNsSSEJ_q9KHt9A7483Q>
    <xme:DtAwanmBK7Y-RHcJMGDuRQKbBftEhoTUZNMGrnK1PA6s3U294f0X9q1PMxeDovv-6
    UwIWYGYq-ONgwOFine5xBQRP2Wk9NaSxte8EMOerrW6yMupb96iVQ>
X-ME-Received: <xmr:DtAwaoM_JYSaoCwQ0lZVHBYeIsGmpPVvmQ8_pn1PN8eHQfusu7Ln9F_2k-Z4TE-13LwcDIA-yoGD1Q1vpjHsmVCO-ns16agCpA>
X-ME-Proxy-Cause: dmFkZTFTwNYV1A9vcUb2j+PTRx6CVToqXdqHI4adD1QS9KOCGDCdueKGbhjKs1LJlhHjmr
    0VK9oFORXz9+5X1344a6E6/OCbrawVN5mCjeKD4QMVCkaO4D2VWJpAVXfMoSHypnNt4CnB
    5ixfxlQobP6y2umFS0QcJ6Qkvl34YRP6YU64M/ZF0j/WX71t2j1k5f7X/DmqhNm98lZjIH
    QDUqwSjWqzlHcj2rDW+EzV8F0lxz77kD8HMay/afW4Wj+K886b9dz1Pg27hyV2fLi1d0Th
    5Cmxx6dZUJjFmD+2FvyY6s9ROVcBY9uHg/mrVg4JVszbCMWyiGD9puPZdZJ1dJ3RJlIwg3
    7soxpiNR2/kUpxBE58575RJKfXvG+Cu96fV911ml1M0SGqCQRi+9nr5iF82Oy1LHGGvTAw
    apYX6J0oM+bLVkatnQliFxwiTiUIEYYf6oMmRSsWSqzNletICuPLBv/xkcrRwNm55jEcX0
    tVT9EIyzl/ZTWwwsWDgancCUOxhC/AL5tbhZ0C0Qf/3iwICVS02mfFm1PczQbQswD61LXk
    fx74NAp7XzpdrzqxvP7pBgCRoz7dRX/SvAmJidvg/7dT8feje2JvK/+1BoLhVAaKC7+47/
    AtkLji6iL8c43NWF4E2Lh9eNHI6MOiPXc2o7KvRTBd2i2T8UakqnnnjKiMtA
X-ME-Proxy: <xmx:DtAwanLNIaRMP4BLXzb67L1MJZteapRGYVFi30XSSWKIx1E-Gy_tNg>
    <xmx:DtAwaq2niwuL8XZrDZ9xg0eoKAZ4X1txBq0gW-ihynwI09CpMTTmFA>
    <xmx:DtAwarVYEF89C3h3B0LatGaLJHI-Ty3dW0bFLs9HnyU13HA1zrErww>
    <xmx:DtAwasOm0t0FtBdJ1CEIlMg9FExuUBxljTPtDR4IkZoTUwKGPLGtNw>
    <xmx:DtAwasvS0UwXcE2TTUAKkK92_Q-rwW2xamkqoOt-oLhXb0ReJDDU0Fn1>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 00:24:42 -0400 (EDT)
Date: Tue, 16 Jun 2026 14:24:38 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Rong Zhang <i@rong.moe>
Cc: devnull+peter.hutterer.who-t.net@kernel.org, bentiss@kernel.org, 
	dmitry.torokhov@gmail.com, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	vadim@cirque.com
Subject: Re: [PATCH v2 1/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD based
 on Digitizer/Button Type
Message-ID: <ajDO531wxzVZlL4g@quokka>
References: <20251222-wip-hid-pressurepad-v2-1-054ac9689bb7@who-t.net>
 <fb198851093477d958eae61665e9cfda0be5b48f.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb198851093477d958eae61665e9cfda0be5b48f.camel@rong.moe>

Hi Rong,

On Tue, Jun 02, 2026 at 01:25:57AM +0800, Rong Zhang wrote:
> 
> Hi all,
> 
> Hopefully I'm not too late to show up here.
> 
> > From: Peter Hutterer <peter.hutterer@who-t.net>
> > 
> > A Digitizer/Button Type value of 1 indicates the device is a
> > pressurepad, see
> > https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report
> > 
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > ---
> >  drivers/hid/hid-multitouch.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d028abb8be7cb2e6e7b8e 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
> >  #define MT_INPUTMODE_TOUCHPAD		0x03
> >  
> >  #define MT_BUTTONTYPE_CLICKPAD		0
> > +#define MT_BUTTONTYPE_PRESSUREPAD	1
> >  
> >  enum latency_mode {
> >  	HID_LATENCY_NORMAL = 0,
> > @@ -179,6 +180,7 @@ struct mt_device {
> >  	__u8 inputmode_value;	/* InputMode HID feature value */
> >  	__u8 maxcontacts;
> >  	bool is_buttonpad;	/* is this device a button pad? */
> > +	bool is_pressurepad;	/* is this device a pressurepad? */
> >  	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
> >  	bool serial_maybe;	/* need to check for serial protocol */
> >  
> > @@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
> >  		}
> >  
> >  		mt_get_feature(hdev, field->report);
> > -		if (field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD)
> > +		switch (field->value[usage->usage_index]) {
> > +		case MT_BUTTONTYPE_CLICKPAD:
> >  			td->is_buttonpad = true;
> > +			break;
> > +		case MT_BUTTONTYPE_PRESSUREPAD:
> > +			td->is_pressurepad = true;
> > +			break;
> > +		}
> >  
> >  		break;
> >  	case 0xff0000c5:
> > @@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
> >  
> >  	if (td->is_buttonpad)
> >  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +	if (td->is_pressurepad)
> > +		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
> 
> I noticed that this leads to dual reporting on my device.
> 
> Consider previous checks:
> 
> 	if (application == HID_DG_TOUCHPAD) {
> 		mt_application->mt_flags |= INPUT_MT_POINTER;
> 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
> 	}
> 
> ...
> 
> 	/* check for clickpads */
> 	if ((app->mt_flags & INPUT_MT_POINTER) &&
> 	    (app->buttons_count == 1))
> 		td->is_buttonpad = true;
> 
> ... where `td->is_buttonpad' is set to true when a pressure pad has only
> one button, i.e., the "touchpad button integrated with digitizer" [1].
> Most (if not all) pressure pads fall into this category. As a result,
> the presence of INPUT_PROP_PRESSUREPAD is always accompanied by the
> presence of INPUT_PROP_BUTTONPAD.

Yes, this is intended, see commit
ae8966b7b5bd69b86209cc34bcca1ba9f18b68e6 which lists this in the commit
message:

```
    This means:
    - clickpad: INPUT_PROP_BUTTONPAD
    - pressurepad: INPUT_PROP_BUTTONPAD + INPUT_PROP_PRESSUREPAD
    - pressurepad with configurable haptics:
      INPUT_PROP_BUTTONPAD + INPUT_PROP_PRESSUREPAD + FF_HAPTIC
```

We have to keep setting BUTTONPAD on all pressurepads because otherwise 
we'd break existing userspace which relies on this.

Cheers,
  Peter


