Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F63655E3;
	Tue, 16 Jun 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608933; cv=pass; b=CKN6L80cLmYPMgBnPqggp9MHLQOLVBBR8NAINWcQWBxl8Vi5SvEqINnizkRjGgIENvpkClljpw/r+wgrUcOeDvVvamRznmmJqDJjCZ5eS+krmud+cBse0kImQuzPk7jlsAc6s6CgLmiUakgkgB2CHzeSg5Wxuz8gQ0OyhedV8Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608933; c=relaxed/simple;
	bh=194bDHGBX2w5OKoBEt3U/qw1RmCpPJFiOXtTvIq77Pg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CXXtZH3hNbK+8Z8XetkZ3AouB3nOpCPYr7Zn5bP7Qzyr1ODPyrd8gppyRgE1suzFoqtd3wLHGMmg4bgFBtmLffFHH68H5pWnrQDnn+iUWpT6Fq5jZyF16c5ZWtlj0x8+6irnP4SH96/gmHz+PF0siAomhqMsMaJXN28t2X5zrQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=k1swhVTD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="k1swhVTD"
ARC-Seal: i=1; a=rsa-sha256; t=1781608924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WDSbps19tXm8tAdtFuJbGsx4v2AToTHp2f+JVUrGy+zs0bDibdKbGrUKSbTiT6s5fdTe9z1OPALDd+4TAI3dZWgVqmxa+pEdUyImL5+i3FDWhfrVVBVvYEJyrn9EVrQitPVGj2M+GfcQ6JmwTUJMY2J5s8xDx775XyFQKBUn2xQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781608924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C8KGK+4l5i2+gxRJ2J9XsZYlY9ReOq1QrxuMthUbFeI=; 
	b=VwD5ZvWSzlboXbUcML+kUagZcrRL+FvijgpmORBWCCjOY5p/Smb4bCU5AJvCJ0lrpf5B1oHl9bmQIfeMEsWfY04U9pE7HWmUHx4T1XnX5D4+ZZiHFKCiOIgSeMOZAPcNO5QfSPimRP2gxAToj4EwsiXx4izEoRy/xS9h+XEPxb8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781608924;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=C8KGK+4l5i2+gxRJ2J9XsZYlY9ReOq1QrxuMthUbFeI=;
	b=k1swhVTD9/CJwlymD7ix3zIsM1EAQqaX2aDXoinQ+JXII33PJaUqZTBb1HPkrN96
	a3mgXL2CWp0ztbLste8301PlS2L6Ix/hUKwMNmoD30UhKftRHEc/hUrG3loUpsJd9dw
	DBvIaQtaELHfnnTopHrEHbWrSEgSwEPwDYdLMsb7A5qMRZwmEdbJV3Agt+wH3IScAiY
	LV0XXZ7aSSY525BP7XUNQo67uQZPeQ1ENgvHGQarIh6mAUARFeqQqgp1aDAdTRkPePH
	/aZEvjGiYoqbSVBpbGZPlDygoyetF6Im8C7CFPcnaBPqLqHepxVkwSbAd8yBli65iZN
	69AA0YxEGg==
Received: by mx.zohomail.com with SMTPS id 1781608921588499.920761559355;
	Tue, 16 Jun 2026 04:22:01 -0700 (PDT)
Message-ID: <bc5340b3f3acda46e62cc39d10aec52b73ed104e.camel@rong.moe>
Subject: Re: [PATCH v2 1/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD
 based on Digitizer/Button Type
From: Rong Zhang <i@rong.moe>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: devnull+peter.hutterer.who-t.net@kernel.org, bentiss@kernel.org, 
	dmitry.torokhov@gmail.com, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, 	vadim@cirque.com
In-Reply-To: <ajDO531wxzVZlL4g@quokka>
References: <20251222-wip-hid-pressurepad-v2-1-054ac9689bb7@who-t.net>
	 <fb198851093477d958eae61665e9cfda0be5b48f.camel@rong.moe>
	 <ajDO531wxzVZlL4g@quokka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External

Hi Peter,

On Tue, 2026-06-16 at 14:24 +1000, Peter Hutterer wrote:
> Hi Rong,
>=20
> On Tue, Jun 02, 2026 at 01:25:57AM +0800, Rong Zhang wrote:
> >=20
> > Hi all,
> >=20
> > Hopefully I'm not too late to show up here.
> >=20
> > > From: Peter Hutterer <peter.hutterer@who-t.net>
> > >=20
> > > A Digitizer/Button Type value of 1 indicates the device is a
> > > pressurepad, see
> > > https://learn.microsoft.com/en-us/windows-hardware/design/component-g=
uidelines/touchpad-windows-precision-touchpad-collection#device-capabilitie=
s-feature-report
> > >=20
> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > ---
> > >  drivers/hid/hid-multitouch.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> > > index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d0=
28abb8be7cb2e6e7b8e 100644
> > > --- a/drivers/hid/hid-multitouch.c
> > > +++ b/drivers/hid/hid-multitouch.c
> > > @@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
> > >  #define MT_INPUTMODE_TOUCHPAD		0x03
> > > =20
> > >  #define MT_BUTTONTYPE_CLICKPAD		0
> > > +#define MT_BUTTONTYPE_PRESSUREPAD	1
> > > =20
> > >  enum latency_mode {
> > >  	HID_LATENCY_NORMAL =3D 0,
> > > @@ -179,6 +180,7 @@ struct mt_device {
> > >  	__u8 inputmode_value;	/* InputMode HID feature value */
> > >  	__u8 maxcontacts;
> > >  	bool is_buttonpad;	/* is this device a button pad? */
> > > +	bool is_pressurepad;	/* is this device a pressurepad? */
> > >  	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
> > >  	bool serial_maybe;	/* need to check for serial protocol */
> > > =20
> > > @@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device=
 *hdev,
> > >  		}
> > > =20
> > >  		mt_get_feature(hdev, field->report);
> > > -		if (field->value[usage->usage_index] =3D=3D MT_BUTTONTYPE_CLICKPAD=
)
> > > +		switch (field->value[usage->usage_index]) {
> > > +		case MT_BUTTONTYPE_CLICKPAD:
> > >  			td->is_buttonpad =3D true;
> > > +			break;
> > > +		case MT_BUTTONTYPE_PRESSUREPAD:
> > > +			td->is_pressurepad =3D true;
> > > +			break;
> > > +		}
> > > =20
> > >  		break;
> > >  	case 0xff0000c5:
> > > @@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid=
_device *hdev,
> > > =20
> > >  	if (td->is_buttonpad)
> > >  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > > +	if (td->is_pressurepad)
> > > +		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
> >=20
> > I noticed that this leads to dual reporting on my device.
> >=20
> > Consider previous checks:
> >=20
> > 	if (application =3D=3D HID_DG_TOUCHPAD) {
> > 		mt_application->mt_flags |=3D INPUT_MT_POINTER;
> > 		td->inputmode_value =3D MT_INPUTMODE_TOUCHPAD;
> > 	}
> >=20
> > ...
> >=20
> > 	/* check for clickpads */
> > 	if ((app->mt_flags & INPUT_MT_POINTER) &&
> > 	    (app->buttons_count =3D=3D 1))
> > 		td->is_buttonpad =3D true;
> >=20
> > ... where `td->is_buttonpad' is set to true when a pressure pad has onl=
y
> > one button, i.e., the "touchpad button integrated with digitizer" [1].
> > Most (if not all) pressure pads fall into this category. As a result,
> > the presence of INPUT_PROP_PRESSUREPAD is always accompanied by the
> > presence of INPUT_PROP_BUTTONPAD.
>=20
> Yes, this is intended, see commit
> ae8966b7b5bd69b86209cc34bcca1ba9f18b68e6 which lists this in the commit
> message:
>=20
> ```
>     This means:
>     - clickpad: INPUT_PROP_BUTTONPAD
>     - pressurepad: INPUT_PROP_BUTTONPAD + INPUT_PROP_PRESSUREPAD
>     - pressurepad with configurable haptics:
>       INPUT_PROP_BUTTONPAD + INPUT_PROP_PRESSUREPAD + FF_HAPTIC
> ```
>=20
> We have to keep setting BUTTONPAD on all pressurepads because otherwise=
=20
> we'd break existing userspace which relies on this.

Thanks a lot for your explanation. It makes sense to me.

Thanks,
Rong

>=20
> Cheers,
>   Peter
>=20
