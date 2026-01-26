Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.85.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616592264A3
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444891; cv=none; b=PKLkHMmWiZq9JGdU1mejHssmvOMLvA4AEyb+Ra61gFSOt5CqWLCt9gsRyr2p+59gj45rKnElDHSPCuFTgn7aOrOllKBzw/HRRosD56Kw+40scTGtvRTIIRe5hCqwApZwbWTiYYnnGAJ8E/9HR+vGml9inElZmV2dHTO/MvgibGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444891; c=relaxed/simple;
	bh=CukHOPWT5nQ7LEwSBKYOykkbYRI67vycnHUZpKy8cL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ImdO7z8zlhPq/XV+yOMvnk9fQqXaTvxdqq4iqZMEVd3chReSZh7SkKxybTQQSJl8w899vLjsiHOB9bqHp9g4njTmOwXA8SIIkJiaLbOEIEaCEvXFDezxcb82BjtVtQh7rgmq7MMzZz5gDv01uS4s7qMDdBWqZHNEXXFZ3lZjB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.85.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021110.outbound.protection.outlook.com [52.101.100.110])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-204-NKF-hBIKNUavxcG-PyjY5g-1; Mon,
 26 Jan 2026 16:28:07 +0000
X-MC-Unique: NKF-hBIKNUavxcG-PyjY5g-1
X-Mimecast-MFC-AGG-ID: NKF-hBIKNUavxcG-PyjY5g_1769444886
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO0P123MB4185.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:155::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 16:28:03 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:28:03 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark
 Satterthwaite <mark.satterthwaite@touchnetix.com>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, "kamel.bouhara@bootlin.com"
	<kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v1] dt-bindings: input: Add TouchNetix aXiom touchscreen
 driver
Thread-Topic: [PATCH v1] dt-bindings: input: Add TouchNetix aXiom touchscreen
 driver
Thread-Index: AQHci61hLaSdtyE8Zka2qQqTrxqNc7VfXAyAgAU0zY8=
Date: Mon, 26 Jan 2026 16:28:03 +0000
Message-ID: <LOYP123MB270141B8B8CAC308B0D113C59793A@LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122144052.358956-1-andrew.thomas@touchnetix.com>
 <c6fabbcc-4a18-446c-b97e-944cfd23b87e@kernel.org>
In-Reply-To: <c6fabbcc-4a18-446c-b97e-944cfd23b87e@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
undefined: 1711703
drawingcanvaselements: []
composetype: reply
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOYP123MB2701:EE_|LO0P123MB4185:EE_
x-ms-office365-filtering-correlation-id: 512fc651-c0d9-4da5-9046-08de5cf7e0f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021
x-microsoft-antispam-message-info: =?iso-8859-1?Q?B3vOKN0VRqovEHFzHD3sNXqGg4yTI92OeSHioB2LdDPQ70IkJH97JXaA5x?=
 =?iso-8859-1?Q?RxA/ztK8Z9z1Zx4niDjuZ+gsiT9xG6LsMoonJlhpSOwiju2TSm22VJWxWa?=
 =?iso-8859-1?Q?2IZVt/K9NaamHbZFrlRr0g01IJkB6nZAujilFXsg/W+vRG8T9IzRvOkNbf?=
 =?iso-8859-1?Q?dP/baHfDoUd3Sqya7p3AvA0+CJ5mHVSNsT+p8V8wN667bW+Z6srQ9nhXgz?=
 =?iso-8859-1?Q?Nz/WIxYY0KxNj/LSJo1v/Plq9+2JWWCZDjAFS4jkGcsn7BGSp1vx0abOn7?=
 =?iso-8859-1?Q?ROALSZpZh/ysZ0mCqNzXy54h5whDZji84DRxf7yKpjroAbH9e8gEJTn6vG?=
 =?iso-8859-1?Q?NCz1Q0b1iRrMrilYhB5/Yhtyf/LPOUu0fF4pmC7Qf+8oBI6D8uQnnmC4BI?=
 =?iso-8859-1?Q?eKEEDuY4Mjn8uiseL3hhHafhih+PP6iVSf5LhfO52TyMGt4ApVL0hlYH7v?=
 =?iso-8859-1?Q?qGby/8XYtL596tuvNRm5MpR5zkYc3XAhWAjXWRfXC1oSy/+g0r8nHM0Wj0?=
 =?iso-8859-1?Q?BA1vAENHDQs4uoni+a2lr9i9ieuMLgm5DcIVeEC8oCotRuLHTPQQOTrZZA?=
 =?iso-8859-1?Q?tCsS9YvkdXHhVow1Bbb5pJBo0ktVMjaISbbCrHwujRbKP+DiIGoDhdXh58?=
 =?iso-8859-1?Q?XeOlDK0A+aRCadXor+RLA2zPxURrbiR7sYcCm1GxsfLsF4HHrxddW2p1Rw?=
 =?iso-8859-1?Q?vkWhog6v8iVn7DQT/emdWgCr+U255cAvCpm5EmPyjNXZK3/zIcjGI7TxDe?=
 =?iso-8859-1?Q?+Rs/Dt2Oaz7Hn6o0RnIADm6S/yDJwULhSbXWGfvnTnS5HIgAGl3BKr18qb?=
 =?iso-8859-1?Q?lCjXrQXy5k2oybwwXt2NxoMUv11IWPKnuJhaDGF80lhyv0pzBIRtLUfels?=
 =?iso-8859-1?Q?pyQ8DRVBuXJHTQZh4jU4vssdbSxeXHHi4IxLqfOcIKxq4O4Y9OQeluXY0x?=
 =?iso-8859-1?Q?/PX75DY0HSr5x7eW4LXyq1RhArNRzL/dDpEVfjyd36tXkaxUKT2AM3LcHh?=
 =?iso-8859-1?Q?ARRmiLWqDzcM7/97hUkn0SE+Wi/HppzMwy2H6UQzeeMiIW1ditTNnWGUEx?=
 =?iso-8859-1?Q?dkI+a0lPsfyXlmIAZSxB3w+wdKC8zYRgGnXWIII6sO+kwxXqTq4UaAJz6V?=
 =?iso-8859-1?Q?u8IExkAQp7B5Wz/N15ex8gzMviLLKMmDv25VsGwfzUKitiTAlmacAA8sTX?=
 =?iso-8859-1?Q?iB8C9S9GSq8y+bC5ckkk1TYvGemwttvh3iENBhuqeYTNzqUGeDOtMi5Gg/?=
 =?iso-8859-1?Q?vBC2BsCAz6uLJNTToNTKL9gwMbC8+zhjGEWQ3tLW4aariKaT+bpFxkF5VX?=
 =?iso-8859-1?Q?tyytzgl7g8vbM9Jkfu328ssYg/nq8/uq75RD+UXyyBkbpVfXxdmJ3Dg9Nv?=
 =?iso-8859-1?Q?aEE1KxHnKW2Vw06wTC444TIxAoGr3sTWFPL+PYFQxAlQbd5Nu29xmdmcUx?=
 =?iso-8859-1?Q?P1KPjqiKqSpPkPq63eWkZanypTXo8UDWQQ8BehL8otmfG7UJbtvUyHGwtp?=
 =?iso-8859-1?Q?yMvD/+oLkpDSKLgYHoeA+DSRD7bUcj2SLwE5yuahTyLp+7peZbsuFYdima?=
 =?iso-8859-1?Q?+zQ3bPNbezfiWjjDiieYEOZY2cH1nLPoWyfDeuHsxMyIbTnsOFc/iQraYN?=
 =?iso-8859-1?Q?woKit91izHC+8Q7njAcDD8TkWGTUV70Z7TKUNbOp9Qqr3c7cY4uLPtZnOq?=
 =?iso-8859-1?Q?bFP1pyAg5bTyZ9H4Ok0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sqCoHiMP+/ISFCGPliO83ErZKzR98H7hWEJLGWGHsQiknWv5Y6ZXz2Uriz?=
 =?iso-8859-1?Q?bwCBi0zik8lKpuSXnpM2YCjWSyTjI/z5Rg6WuedGsBqa7LDNyVB2Iz2Xwa?=
 =?iso-8859-1?Q?yMuIAXyQM94zITo5+0p0RX9Udouy8svrXLfRZxKID1Y97GQfyJgObXEu0Q?=
 =?iso-8859-1?Q?F3Xsr1acCxr/i8qyv2ywCooO/PnF6BAabbOdfF5F9Fb3NUMKs1aTHylAOT?=
 =?iso-8859-1?Q?q7FdgWzXQIhlKkkvZ0s63ZvYh61Y6ZcYGljdRFg38b28u2rX3mXy9NcVKr?=
 =?iso-8859-1?Q?WTMakL1ZxaeB3ZFy0/18K94G6qSrQ3kEwrr3vGi7ScV2KLcZ0JUrUsqpRp?=
 =?iso-8859-1?Q?aqUhzuyCrRDKxCJtmn9SpnbfD2npClL4oUry+qrGRjpXR+hx70PviSmJf8?=
 =?iso-8859-1?Q?eGSrx7E9W+SBu4ywlLE9pCNNF6SI+ggl/fjIiNlLqtrDKnyMj3W5MNcwzg?=
 =?iso-8859-1?Q?Y8ISGUiTgLb/mQsyC23oqravgo106/Sc1mzskwmUMDcr5lm0xI6NbJLKzB?=
 =?iso-8859-1?Q?VW2BKfNLBBVU8RbsHpi0/ewEci28im7qY1I9UcOVNNu/drsk+jWGpsr0yf?=
 =?iso-8859-1?Q?4xEymA/Cm2SwYpHN2PJI+1JNEC1VrRDIhGGWGuvhLgy20d6HykgBzDi1Nk?=
 =?iso-8859-1?Q?4bj5ckhGgB1V4RRBlo/II87f9RGjjTF/yxAIoYP8RX/MgKD1BPpGTYYdef?=
 =?iso-8859-1?Q?NkwG3TAwcAOBkFmYvnG874qSnyL3q95fzlhtgSthTg/xSu6+HWSaRATtG5?=
 =?iso-8859-1?Q?Pa9/h+UdOsKSm/h335DnYo7VWFaLvJ5LXp0hvSygx1g1rHW5w/YHE98Bt3?=
 =?iso-8859-1?Q?zyBLZbHYg1EyLAnnH2F3abuASWWRqC72EeRaoVpPOWIB/373IWWMUCbp6F?=
 =?iso-8859-1?Q?kf1QPmBLpFwybPoXcdSclSLxAJU6xDmpvqMnEexdg3gRQB5jbUbVYkMhsc?=
 =?iso-8859-1?Q?bz2U6wE6a0fjM3DRKYVqIxtRv2W73wjQ9JjMyUMXpJ/fUsL9n4yQKUNyEM?=
 =?iso-8859-1?Q?VIOCevCwi92j0IKF2f3S2u1buqzXja8DXmdYS9OJvMyvwKvHM7X1GarGHm?=
 =?iso-8859-1?Q?JeNHByuKB9smCKwjUE4eIPD+9L0jaiFVNpLzH0H++wfRm4aaPCirB/Prfo?=
 =?iso-8859-1?Q?Ngk3VB2qWV1VGmKW/upJc545S3+zf2rMgoub8LXBtDoLrKWm57jC1JTq5J?=
 =?iso-8859-1?Q?L7+NV+b0NTyfvI7QY6x+vY8Y277Ce6xvOSUPVmbgZ0lBqjmxkkpT/rR/dz?=
 =?iso-8859-1?Q?cfEA20Dqx4xfh3psAA7+ErTOs5GFJjRGRGn3V9jEOYtTdjGpeCcoIRR+Zj?=
 =?iso-8859-1?Q?LkDV6zBK1zY+6RaI8JOdp3ffi43RRrE8JkBWKv8vU2ZnSGfIw/ykJNoPKX?=
 =?iso-8859-1?Q?yX949rknay2ga0xIMdcV37xWtqokg0A8a0P/TfP+XlnCgzbkhjcntKhmGI?=
 =?iso-8859-1?Q?D73lL4/q6o03hgz9zguxpCqIKiBRDhFRo5fvkBV9qfVF4BdwwdJaOparNp?=
 =?iso-8859-1?Q?bJ4pFFWZhLzk02NQEgVq+RDWzsrvcc5YWz8tZrAAKAa33RNXuEF1eI1h+V?=
 =?iso-8859-1?Q?PjpNTDHDHV2yYS7w4bVlSqFdCvcndBulPWr8NxeSjH5nCgz+nCH7/g+7tG?=
 =?iso-8859-1?Q?HuhFNrdfptUgTCUkX3BZRJwYxZMtr3CPEdr57wdfvq1aDeyjSfSU3/HVCR?=
 =?iso-8859-1?Q?RkF5vTuCSUYYyox5CkCs23br8AcipstzAlfYUMe6V8Asjj5bo43Tedyh/2?=
 =?iso-8859-1?Q?LRDd6PIPEtk6TdHSEBqIQsXh3HEDzyAvjeVVw7j2NU7FCw5LkjzXEHH7n1?=
 =?iso-8859-1?Q?M3TB5f0FOA=3D=3D?=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 512fc651-c0d9-4da5-9046-08de5cf7e0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 16:28:03.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdosSqNmf3RPmegH8++UCSd6nIRgnTdBiMiy1HYy7TUAzsdCV5PPl0O3L8eUtjWMUjiWkLSVGFyyXgbkDFA5YXGCqRp9LsWJ9VarJoBV04s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4185
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R4hep8C2Wmfem_vqnT1sQhnfgPXHbvplIrBMbA197Bw_1769444886
X-Mimecast-Originator: touchnetix.com
Content-Language: en-GB
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,=0AThank you for the quick review and giving me a lot to look =
into straight away!=0AI shall resubmit my patch correctly using b4 in a sep=
arate email.=0A=0A> > + The TouchNetix aXiom series are high-performance to=
uchscreen controllers=0A> > + supporting various interface methods includin=
g I2C and SPI.=0A> > +=0A> > +properties:=0A> > + compatible:=0A> > + enum:=
=0A> > + - tnx,axiom-i2c=0A> > + - tnx,axiom-spi=0A>=20=0A> No, these are t=
he same. Use only one describing the device.=0A>=20=0A=0AFixed.=0A=0A> No d=
evice model? Really?=0A=0AThere are device models, but all devices use a ve=
ry similar interface which=0Ajust changes with revision.=0A=0A> > +allOf:=
=0A> > +  - $ref: touchscreen.yaml#=0A>=20=0A> Missing ref to spi-periph.=
=0A>=20=0A> Look at other bindings instead of inventing your own.=0A=0AAdde=
d.=0A=0A> > +=0A> > + reg:=0A> > + maxItems: 1=0A> > +=0A> > + interrupts:=
=0A> > + maxItems: 1=0A> > +=0A> > + axiom,poll-enable:=0A>=20=0A> There is=
 no such company as axiom. You just said it is tnx.=0A>=20=0A> > + type: bo=
olean=0A> > + description: Enable aXiom polling mode instead of interrupt-d=
riven=0A> > + reporting.=0A>=20=0A> Anyway, drop entire property. Not a DT =
suitable, not hardware.=0A=0ARemoved polling from device tree and added as =
a module_param.=0A=0AMany Thanks,=0AAndrew

