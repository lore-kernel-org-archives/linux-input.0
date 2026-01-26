Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.85.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0401330668
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444952; cv=none; b=cOVapR8J5lqMhpohEnD8lGU+OAKdTn/LSK8la+ceeb3ZN3iMdYWyUXCWEZDgymgK+qpMTJmpdDr8iyzGhTbzihetOpNysgMcM1AoEmZJzvgR6uq3qjMZfn0R1HfENPMl3gb6F9u0qxdaiVFr80SJLOvIE8K/dE3IfIsRD2ZVVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444952; c=relaxed/simple;
	bh=GStZm7ECMYYl0GSDY/kTFfHt5kzc8hOcD/7M5vMlfgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=IB4N+ewap4D1+Sss9qv2o/OJQR99zj6Kov3gsQpWdPGyk9AyT9eqQaeCbxOaGT8Rw63WNGY4NSpyqif27pdfoBO+0hMcfiOvBfscN6rfbBG8kECcLG8h9MvY0gygCdvzaExPpFA3D+D02yEQ20kYv4plx/66faM0xzbbLMWrnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.85.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021107.outbound.protection.outlook.com [52.101.100.107])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-260-AXKqBXGdOrOats1Z48cRnw-1; Mon,
 26 Jan 2026 16:27:55 +0000
X-MC-Unique: AXKqBXGdOrOats1Z48cRnw-1
X-Mimecast-MFC-AGG-ID: AXKqBXGdOrOats1Z48cRnw_1769444875
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO0P123MB4185.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:155::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 16:27:53 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:27:53 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark
 Satterthwaite <mark.satterthwaite@touchnetix.com>,
	"kamel.bouhara@bootlin.com" <kamel.bouhara@bootlin.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/1] Adding support for aXiom touchscreen controller
Thread-Topic: [PATCH 1/1] Adding support for aXiom touchscreen controller
Thread-Index: AQHci51spqwBeAXsuUWcLtgmGMZ5nLVewEYAgAXShgg=
Date: Mon, 26 Jan 2026 16:27:53 +0000
Message-ID: <LOYP123MB27019D7C9A3EEA198CAEB08C9793A@LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122124819.273188-2-andrew.thomas@touchnetix.com>
 <20260122220918.uuy7rlvtcrsmfqmd@pengutronix.de>
In-Reply-To: <20260122220918.uuy7rlvtcrsmfqmd@pengutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
undefined: 1711704
drawingcanvaselements: []
composetype: reply
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOYP123MB2701:EE_|LO0P123MB4185:EE_
x-ms-office365-filtering-correlation-id: ba3f9627-40ea-4b85-8cfc-08de5cf7db20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pUnptsewfA8+1AlxGA/eyQHuhh9W+siJOQ6UsMeoG7IEAYZ/d4iu9vxdiE?=
 =?iso-8859-1?Q?fDF7HwS79MzFYrNZV8I7+UaLREL90amyfwnQR2FzvLdqUVSbsIp0H3WC5w?=
 =?iso-8859-1?Q?BkMRjOm+5bqq4DcFqoXYuwp9u4fum76Id0r6pjlOVpaQ9WHmGoJs853W1+?=
 =?iso-8859-1?Q?/gMcMXU+qeidlZF3eTbMEPsru1Kr+pCK0utL8TKpOtWfxVv0/SrJQQaX5U?=
 =?iso-8859-1?Q?vH5r3qhiQe+zb9pvGUw2BHX6p1ses7Zg/XnHU/GGzrB/eCfqeivZdEMWPv?=
 =?iso-8859-1?Q?Fb0QTKICJEo8uOu7hcsNjjGEjOzlOhmGEVylpUOcqpS5JU1nHaeSxptGbC?=
 =?iso-8859-1?Q?GEcuo5n+ZFF9uSGJSsAoVEap8sA8a6TJee4rZ1VJOwFk4hNVYpU3NUfvbd?=
 =?iso-8859-1?Q?pZIZykBIKhqWgHKlzJ2uP5E4J6lfFNxDvfGVFVB8nhAObDWJ0tk2nvrdR5?=
 =?iso-8859-1?Q?cx7x7F//PDRgy+2qK2IBAu6BxLKPpbI7HWY14FYMgOeyJQsKFVjShNI3/g?=
 =?iso-8859-1?Q?apWlEhu7QFD/UKwfWSysnd9x+5LxrN8FW1yObgiHLNLvyda4wh9KJrWW1E?=
 =?iso-8859-1?Q?/+avRjky4J19yAjH85fYeDQE+yIVXXx4ZzWDqWfSGXjAmjzR6iPORWh5uL?=
 =?iso-8859-1?Q?n06rE/0lNWXTprzL5cutXgZvzjou/wezrgMxnDjUN6+5Nh2fsJ50AqwRnA?=
 =?iso-8859-1?Q?FXEAfUSh7+KyyxsGon7Yjmx9QOVtsmFtPVM7z7Nu3/Qe34J+vhp4AdLbN3?=
 =?iso-8859-1?Q?9tnqe+Q8aoAwIK2YVtilY1N2KIZUtplrffbcvlTX7k+iLChQc3dCM7iYp8?=
 =?iso-8859-1?Q?OAp/gq3ZJNtH0vemCDWSZV3d6w78aAD0HBdyniDDTvJOXd7LHAVFZvMqtw?=
 =?iso-8859-1?Q?Ujfs+ecjhfeO4xSi0ooXhMGIn6ZWmUm0P3ph9+M8k2SLR2FEC/l+k2pT7T?=
 =?iso-8859-1?Q?MTNSY4dzrYRnz+D+4o9erg2R1XRqUVME5e1I11dPvDcX61/gha/2H1lgIp?=
 =?iso-8859-1?Q?AehZD5S+O0K2DegyVO0+MlGEpeLlPmSGiufQet8rfVojvZsO2+Iy8OgBEv?=
 =?iso-8859-1?Q?8PL/HsKMVSFZBwixuDFWqW3UIzAJOTNiFKq6i5Fv31X+OwVU+d219EVIMF?=
 =?iso-8859-1?Q?fOfkNwuliEMwFBDsAai1esfGB+dJGY7wqKViQA5C8oK6M3f+7sSWkoa3/h?=
 =?iso-8859-1?Q?TEYJcmVTOYvt7RFMeIoB+ShobT7702VFzh4LoNJ/culKI8HrxCPGcE/Ktr?=
 =?iso-8859-1?Q?6tBA4m2YOXmXIF/q9Rvu2bz66Fw+8v68spGVr6HKIq4g4Jt5DHeJzqbryN?=
 =?iso-8859-1?Q?4+RfWHY5VIZ04iR/gPaJpDxYX51DBygln4Z5lLZS8osvgpEW0ZTitzFMp8?=
 =?iso-8859-1?Q?KCydMC/UflVT8PVBoRcL0hsFv+OioaNK9mQSZJ/1Dlvt9zQfZhKEpQuw9I?=
 =?iso-8859-1?Q?9ZWD2Ceb9rVJ4pu39/00De4BzkS2sLgYaNV8Z62RRTadKBIirSzyXhq9yY?=
 =?iso-8859-1?Q?XskNAPR3ZYffwq3HGm+jEqEm088fn6t+N6IW1prmgfmLKC6P4RDbaX6vjo?=
 =?iso-8859-1?Q?5Ge7ToTpmZl13bbB1nj/MbrQhIMrU7JDATcJWSVC/2nJY0J/vqyBIE3jfm?=
 =?iso-8859-1?Q?yN3wDcj0Ej1N1RSNjiFUjMTV2jHzFEzLtxs97AV9JRIIRW+G11Xz3miUmQ?=
 =?iso-8859-1?Q?AyiV6W0tlYn+VPMkueM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dqQ74SvVQbgYcaMv0XR78KfqjRgl0Bu+jFax0c0xRFZ6ARx9rqKS4V+XDH?=
 =?iso-8859-1?Q?jeEjqIfwHXzA7FGx0YTgwA1h1iFgn4qLe3qTzrH/p7znIrkNa5RIqaecnm?=
 =?iso-8859-1?Q?meC4vliIzy/ueAHblfTxheJ9EyFFjmfAh0vtJPr1H8bxyK++uf+FwoCRC1?=
 =?iso-8859-1?Q?9F6Gs3xWuqYuWlaEX+a2QHjt+01RE30NHXaTY07G0CUUAAvazTKNsg+kSN?=
 =?iso-8859-1?Q?3mQHhlTAZprP8vRGEi5s2oOey5z3HOdcT1kSxnTNeomYGeYnEqc96B/1ey?=
 =?iso-8859-1?Q?7GAchAX1YnI0Kx47aZEQenPaadcgVIQXr0bH0VSuuaoyUJlFzYUDgR/zoO?=
 =?iso-8859-1?Q?rB+bfrjm2gV6EEnNrXFb7FmamFisUzEGB7heTe2kEPEetTLhW2p5Y8ZaNZ?=
 =?iso-8859-1?Q?iFziJkPKroBTB7uQYOd0pOHM40wyuo3rM6D307d8H+GfAcXr3iWfsc6LlH?=
 =?iso-8859-1?Q?Qk7xrEBrJ7PnuvTIGwBsRINznzRW5Vd8vbsKVCe53A0mU1nKrJg920B+XN?=
 =?iso-8859-1?Q?HA87NpsAisL+jeQ9lVScV6l+SocX+0PzfjLOf1bZ1WEinOhLUmf2jKuYOj?=
 =?iso-8859-1?Q?mrz//yTchPdFLFbPRs9hQAXXWLPA7WOmn304/BLLTs+9O6qaLNJbLRlGnh?=
 =?iso-8859-1?Q?wyl3iCguU+O3H6vQUoPhyRpmJjIADgdXaTYclgI2slN+S8GfdwiiwpQKXe?=
 =?iso-8859-1?Q?AFBiqBahuqsG89oH+vR3Ta0QEwU7/eDnFfsiuZrlhuqSlcwD68XbV69mL2?=
 =?iso-8859-1?Q?uJYL3PypGwgYXTVvfpQwrDQiVvWjjWvRYlrB84Oj2Wjt6uutfN8TvO3K5K?=
 =?iso-8859-1?Q?bzdSC+0z/v3Ln5RJ1yefZhpxlzEvOPAPMOdtNj1WXZrilWLB36O1WuwrPQ?=
 =?iso-8859-1?Q?DqqoGo5eIgmniR/TyYdBTXMmm2xluP8u96jLI5dWpDzM9B/Q6dqBTxxzrX?=
 =?iso-8859-1?Q?D1KKdDP5X1xNfMho3cgnz28weuILGkqOcTNyqLg8tGXL+EYHcu6oI/g+OV?=
 =?iso-8859-1?Q?zp3PlUzd/MjCCY0/sx/AG3Wbthm8Q8qky5jyjBI9+NpVA6uySt3h7zM09d?=
 =?iso-8859-1?Q?lt6D6mD3ARJ5RXaMNIxh5X7Uoc5gDxH1vUgsyPveabThqXAug3nrzUK9gG?=
 =?iso-8859-1?Q?TOXWbQTin4qggw3VAOLezlBFuwgn84E1398fWtRZmEbJfz5Sp9W4QoG6Hc?=
 =?iso-8859-1?Q?h1qKL/mihepnQvyEkkSrmK2JjTGd34iSH//XZA1N8+sK5ntla24kcQIrst?=
 =?iso-8859-1?Q?67KeDa9SIoWc2gVVn/SeeSddvZbgD4UBKCYO4ksHvhfrWTeuDWTEkpWqqm?=
 =?iso-8859-1?Q?+AIf8LwMOYM1Ifno3PYswhleTESsb29tKllSbzLnJEDxJ9vziB7Vi50h43?=
 =?iso-8859-1?Q?3MJLQr8zYzGJmhUxbz/r1LAfxsptQc4UcgqHKHGBBovLZb8X6KXgJ1pffu?=
 =?iso-8859-1?Q?NnzORInA0RClTDYbTOUfUKQ1o/I6CAFPCAUNtMcetI8Fqmt0NPOQxcSjv+?=
 =?iso-8859-1?Q?SaDtqvS5s9geT8cPuM2hH111klyDrwrybscBmrnB5PXACXBzZWxWOq7KmC?=
 =?iso-8859-1?Q?j/L364iYZzIZRrbGZFEBQlC2L8vEkZzNBBvl2d/GSWpFAGw1UjZdvDdnnF?=
 =?iso-8859-1?Q?MLfH2e7JxgW4tziNpICfSEaw1Z6Sd+gfC9OE1i/y9TS58oMz9FuGRU5jNg?=
 =?iso-8859-1?Q?oHtlOxOy6Y6VLtDvGhkEAPm/cEENkKPkNtYEhzZR9WreDhs428OFfm86Tr?=
 =?iso-8859-1?Q?bWD97lVAd2Fr5pPK834NFKhXHO8N6CRHaN9D+b8JK4Yfyu0R5fDNMUN4+w?=
 =?iso-8859-1?Q?57FMylbXTw=3D=3D?=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3f9627-40ea-4b85-8cfc-08de5cf7db20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 16:27:53.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nilQ8IponKLdWtHCIu89DHipZJV7/DmzSw0SwNGFF0xyxuOxZ0Lge+XPngWDo93LqutinYr6P04dNDTb8mZspQ0fSSXckFb4jtMGnKyAfv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4185
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uoH-oPtKV1l35GOKUnGXS1GKSwCCFxau1Brdu7s0apo_1769444875
X-Mimecast-Originator: touchnetix.com
Content-Language: en-GB
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi Marco,=0AThank you very much for your quick review.=0AI have addressed m=
any of your comments below.=0A=0A> >=A0+config TOUCHSCREEN_AXIOM_CORE=0A> >=
 +=A0tristate "TouchNetix Axiom touchscreen"=0A>=0A>=A0Nack, the spi or i2c=
 should select the core.=0A>=0A=0AChanged.=0A=0A> >=A0+#define U41_COORD_SI=
ZE (4)=0A> >=A0+#define U41_Z_OFFSET (42)=0A>=0A>=A0Align your defines.=0A>=
=0A=0AChanged.=0A=0A> > +=A0input_set_abs_params(input_dev, ABS_MT_TOOL_TYP=
E, 0, MT_TOOL_MAX, 0, 0);=0A> > +=A0input_set_abs_params(input_dev, ABS_MT_=
DISTANCE, 0, 127, 0, 0);=0A> > +=A0input_set_abs_params(input_dev, ABS_MT_P=
RESSURE, 0, 127, 0, 0);=0A>=0A>=A0Max values are coming from the firmware.=
=0A>=0A=0AI am trying to keep the initial patch as simple as possible.=0ATh=
is is a fixed value describedin the usage definition.=0A=0A> >=A0+=0A> > +=
=A0input_mt_init_slots(input_dev, U41_MAX_TARGETS, INPUT_MT_DIRECT);=0A>=0A=
>=A0num-targets can be configured via firmware config IIRC, so nack.=0A>=0A=
=0AThat is correct, all u41 can be configured separately.=0AAs above, I wis=
h the keep this patch as simple as possible so we can=0Aadd support for thi=
s in the future.=0A=0A> > +=A0err =3D ax->bus_ops->read(ax->dev, 0x0, SIZE_=
U31_DEVICE_INFO,=0A> > +=A0ax->read_buf);=0A>=0A>=A0No need for custom acce=
ssors, use regmap API.=0A>=0A=0AFrom my understanding the the interface is =
the same.=0AManual I2C/SPI bus handling is still required.=0A=0A> > +=A0ax-=
>bus_ops =3D bus_ops;=0A> > +=A0ax->irq =3D irq;=0A>=0A>=A0You allocate abs=
olute no ext. resources like regulators or reset-gpios.=0A>=0A=0AIf you thi=
nk this would be needed in order for you to test this patch=0Awe can add it=
.=0AAs above, I wish the patch to a minimal support of I2C and SPI and furt=
hur=0Afeatures can be added ontop.=0A=0A>=0A> > +=A0switch (hdr.report_usag=
e) {=0A> > +=A0case AX_2DCTS_REPORT_ID:=0A> > +=A0err =3D axiom_process_u41=
_report(ax,=0A> > +=A0&report[AX_U34_PAYLOAD_BUFFER]);=0A>=0A>=A0May I ask =
why you guys write in your programming manual, that the host=0A>=A0needs to=
 check the usage-revision and you completely ignore this?=0A=0AAs above.=0A=
all usage revisions will handle this identically.=0A=0A=0ARegards,=0AAndrew

