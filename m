Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013094.outbound.protection.outlook.com [52.103.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FA47A0DD;
	Mon, 12 Oct 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807462; cv=fail; b=SonPB/yBgyhIqKrWf49R7jhk1NYDd/MzrnAGsRYo+iSgq0d9iiTzdZL0mIlAZRSLX+LtJ1rAbdhKhVGcAg1gKoUXlwdoUJMOgDgwhdeyRgZoCIge7Rx/KDIGuhfIrcVaCVkxlq0pB2UffdVxruP77Xd5fa7WomGacge1Macg8+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807462; c=relaxed/simple;
	bh=1nZ4MczVCT8HRbbJbrHL5AnlddzIyQtTRDgVAAvPuVc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ETXzFaPJ45g4dm664QQjVKNtQYDxsJHP6mYhOvwVHIzDgumou9dAd6NBlZA0mRyCz0saVJuNlO2Wd2RyT3/iZd1IZY371NEb8LE1zm6PVlzyez2OhMcqeVnh41uYeYtImxUY26JB1XHW0kcmyzKVJemjqIt4mEgUhS2MZwl3jzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=F7Q8oinH; arc=fail smtp.client-ip=52.103.20.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="F7Q8oinH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBCdNKd8+v7fryoPDu0jWFFVIj4MKysfNF2lg1/p935lLlyw4avSMx3PTl81yq5206nkoR3jFcW9AwDts37MuYcdwhZeynZfP2uySCMqBQjlq/DxoF/9Xc3YTSkJH2vsl88Db4NolSPxGe1H79yfS2kUoU0dVcg1X0ave0/1YDWY1yTkLiVG+v35/Gm8QYSmVvw0TLmp3a9kJhdxfM/8z8kTfrKLsQ9FjjkY02gIdUNQ6M2Ez6DSyEGQclv3Gr9XJZRxxxfBD+mEdb8L2AEEMXv7VpTGGGhgBOVRs0p83C4Q1veZZ6hRnPgZwTl6LkWN1TSiUGZAw2nN+onlCBbqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nZ4MczVCT8HRbbJbrHL5AnlddzIyQtTRDgVAAvPuVc=;
 b=SlIiCxK2BfIDVDjIjbi1aIFdlGGAip23oP2wNZN69lSwrZLKU9ssjj0IMRgpsW6tyWDaDXQ3TrjXIWqmRi98ZeI6+BgM4FGQeH1TbzeVELHc7RNzXgmok8AIRO+hATbznWt5XyAaKiDRO+AoJk9YORlPkok0mOC8fSVKtojaq1rOzB4wWQlKrSshcFEHZK7akjd13Pa7bHn4Oqnn8FiAV6l0oRXk70ynVNnc6v/pprPMCov3xBlzQtSRQ4eqr2M5Ykxk0J2d92s+9IDknDcjQVw3XZiXxqvanhQOsufcq+20haEg2sXct0fytdfIv0VS8GP+4/mNHiEG+urbsWUQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nZ4MczVCT8HRbbJbrHL5AnlddzIyQtTRDgVAAvPuVc=;
 b=F7Q8oinHqOkuEkrURbLodUmeMWn3VeHz82ySp8uyMMO0EIJuJwJYkenAAo9Vc7Z6K53ToETtEEXsy2Nlj9YBLMoJriywKdrYNgvNwA/YXqeb+aHJHPGNLG+PdmJhz8PH/hUpsLdDoooyt8q9aAzxyOdYyqRCbQvyM01h/Iuh4MrQxO/Y0bfF7bR08qtNLFK/9ew31EZ7p/rLLKoHBRL7OwHS4IOTvffguNXtQUdp9U8jHPFCnZNwCsULuAe1KWmsH/dB6vngSoatVfWgjSl2cfUR3TFzU2l3Jc0eTBZo0uCUfU3oo3jVNfDnW1M59K7Bs0CBtdBjFzrXM0RwpK39Nw==
Received: from MW5PR10MB5715.namprd10.prod.outlook.com (2603:10b6:303:19c::10)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Mon, 12 Oct
 2026 12:17:39 +0000
Received: from MW5PR10MB5715.namprd10.prod.outlook.com
 ([fe80::37c9:d2b:4480:8676]) by MW5PR10MB5715.namprd10.prod.outlook.com
 ([fe80::37c9:d2b:4480:8676%5]) with mapi id 15.21.0522.009; Mon, 12 Oct 2026
 12:17:38 +0000
From: Andy Smith <Pendog2026@hotmail.com>
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: ThinkPad L14 Gen 1 AMD: Synaptics LEN0411 cannot use RMI4/SMBus
 and falls back to slow SynPS/2
Thread-Topic: ThinkPad L14 Gen 1 AMD: Synaptics LEN0411 cannot use RMI4/SMBus
 and falls back to slow SynPS/2
Thread-Index: AQHdWkMkXbaCbw/MskyBkxsmZlgMjg==
Date: Mon, 12 Oct 2026 12:17:38 +0000
Message-ID:
 <MW5PR10MB5715DAAF11B42B77F9126076DE9F2@MW5PR10MB5715.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR10MB5715:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 94a078da-b6f4-4922-7232-08df285ace9d
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|8060799015|19110799012|8062599012|25010399006|20031999006|4140399003|31061999003|15030799006|2604031031799003|15080799012|36102599003|2607281247196008|40105399003|102099032|4295299021|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+xONk1srZhiTQBs2t4NcR6RM6vOFValYVm1gPgKYCEFQjJJG1+Wj56Bg2U?=
 =?iso-8859-1?Q?KFI1b0ckrSNZIjITkIqH4fMjoEFxG+I46wZSMw37wqU7owWOj9WDcPlDjm?=
 =?iso-8859-1?Q?J+rYYihMTEgzkdEjE0WCq5tW82nqKyOVuB/w4YvNx9zjypKwKgxHTeBaxY?=
 =?iso-8859-1?Q?iy4GJItI/tO+My9T8fUc19XAfCu6+ISwf6eBk40EdRMOb3visd6bIV7cYH?=
 =?iso-8859-1?Q?u0r/5XtpiAe06U3Mj81pxjGvtfO0irtxHZJL3f7tb0HvEhzgy+iDXhE5bL?=
 =?iso-8859-1?Q?Vz3brZQF6WJrZgV06JTmAi6dQEDU3vZvQ2ZhfRxjPVksnnsCs5BjQObheu?=
 =?iso-8859-1?Q?dmU7PW8VFld6h7wIljPriKKV8g5I5gT36BymEkDP15fsscVNYC5s3s+8p8?=
 =?iso-8859-1?Q?Ent9juH7iHgQDkrRinBo5+q+U7qwFZ2diLYXtmhH0Bf3XLPREFSTz/mHNS?=
 =?iso-8859-1?Q?t5ydRdja5G70sCjo8AvSZWZpsmF4Mvcdwa+8PEiMp6Mxl5Q27YWwoqQoT5?=
 =?iso-8859-1?Q?qev93GvG8FU8q6TuCYx42l5lqFkjE7TJtQ7PvYNpzbaBGi/H0gIdayft2p?=
 =?iso-8859-1?Q?gHAJ5hGpit75FHD/TX6DgeVVBlF136gqJWwA9CNUK59p6/sTvL2e2iFChb?=
 =?iso-8859-1?Q?mf+XggvuNApH9zUJwjWhgBAowNPeIl326SMa0T++vwsh3I5wtoqCGNoZTj?=
 =?iso-8859-1?Q?Zbz2HYnoiQPI2f3FsLeJ6eWTcwXqO082nf04OosKGHBFuyzSiX+cnWMeZW?=
 =?iso-8859-1?Q?OwUmS6irggF3JHw/TITzqpEKM/ldCUzSk594Ui0FqEWM1Gasj2YUNW7fqJ?=
 =?iso-8859-1?Q?Q669gJzhlZwbY0WEFqpuNtuQgQbCZWAobOdMrf+z8tl07m3Y1cAHsxNRMZ?=
 =?iso-8859-1?Q?FI/7uijng3018JYATVCDGjyMeqln01bqvzd1KwwSalquWqXtoA8VGiWgn7?=
 =?iso-8859-1?Q?otavy7zPWjy81BXaNj52Ev8FfuLj4Yn7KBfU6P6zEghQandYUqSVOKMDci?=
 =?iso-8859-1?Q?54+lkBrwHGkkQeGuKDxmtFZAuCSweGroBCwtUM/HbLN+vy3VAUjyPmoIoC?=
 =?iso-8859-1?Q?xpAf2fT1DU5yF9oB028N/RY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PkCiIZfiEOTJukE67Fm+l0UmnJfe88iTfKuxp9V0XAybJ7aS/fBLseDBWf?=
 =?iso-8859-1?Q?mnEIBX8PG3U2oq06vny6M4EF9aWoRZ9k05zyq6+cn4OvSHDKdktLDeZKmr?=
 =?iso-8859-1?Q?wfIYBfm8+kpiDvbbaT4hvFrP69pqVnMHVQ9TgCWlQVBMERwzqFwqfVFT25?=
 =?iso-8859-1?Q?wUDnYHeWrcVkVihjtAsZajPQ4kjh+DIdgXtEVmHoJKC9Dw7Nts3gIY4m2w?=
 =?iso-8859-1?Q?5IrKIwcGpVofVvkmC6zZ2R5EKnFGQl96yNiVm84p6rXVTkyOBNWanbMGSz?=
 =?iso-8859-1?Q?BZhAN0yLjdaRK1QF7FPwYKpKph9CQ3iCK51t67tGrBRE99Z8DrXlB5GtG3?=
 =?iso-8859-1?Q?OlCCqCvm4fTkZZ7ufF3Gl4zTi+MLeAR1bDOz/IXo0KxvuQIW/YpdzG8mwN?=
 =?iso-8859-1?Q?hGlOb0/Gk6e458OfohZ1MdsV8r0OwJ9166QKVWTO8RLGjQxiKGm5JrRlBp?=
 =?iso-8859-1?Q?9CubM6zIY/g0ZyQapBhxJZRUA04lViHS3uwFkQqbQFpj8hjDUHVmYm26xQ?=
 =?iso-8859-1?Q?pIcxp6jyz2qtk6YFdLTnZMzLh/CJvKJ5XOaO1FZuTijUXVrfJYZbWm+ugx?=
 =?iso-8859-1?Q?Ht4/fLGreBAvQu/7UI+8JGtW5hAX7iIVpW4y9m1quXsZlr/qhH+sMv9EIJ?=
 =?iso-8859-1?Q?BkS5DPfm0qlcM3YXbiGLBGI2GdYCGSQPZL5VDAEP329CftOIUjoS56HX2F?=
 =?iso-8859-1?Q?JMKaM1+MFM0SS6Lm0znxDuNU/RtkGBnNGmbO76tkvI//jv4nJ0gm4/ijiE?=
 =?iso-8859-1?Q?fsuuYPi7OKIFS9UIFoI7IrQh2uD5ufNw7lGpvYHkINqzVE/NSFXpU2T7SD?=
 =?iso-8859-1?Q?oAf/cLaJ1S7UgklRDKww6pnnddX/LN45CbXAWZ2e503iR5yV1wD6CIKR6k?=
 =?iso-8859-1?Q?JXzFsOLA4k4/HJCJQupdoeFS/tGjhI7FvO4yg6aO8KDqPFfdr1yRhAk/w5?=
 =?iso-8859-1?Q?XGH0CCVgA8UctmSDvKgWSYDEk2Z8kZRLKgVHthJ0u1ktMdA+RJPiSGsRRL?=
 =?iso-8859-1?Q?on8L7r3zjpWv/tGrGtn1U7NTnzzt5On1BN6lcRzZVyr2IzifFZd8CVn1mk?=
 =?iso-8859-1?Q?v2KY+6FK6yC/SFpctVg/SgItFjRsGGJ0QYYLkWhWJigXlHvyjQI50H5d1w?=
 =?iso-8859-1?Q?ui/tqCPMBhqjuQqClu959msP5Zl86TAmcEKowRKbihdchNaPug2VCOHKI3?=
 =?iso-8859-1?Q?qV4eCuj3/PdUGyYc4a5+UkG6RmV1LsCaaAHXI+FjO25zVcrP/aFp7xEeVo?=
 =?iso-8859-1?Q?C/xAsrUFOoENvYW5rw+cKpxTlLCw0c5EKB0A8vhvQwFyZETcNqp1eL0vwE?=
 =?iso-8859-1?Q?mhpiaQjWBK/hmhduon4HKk54mAz9VGUItYZxvo9mzI49uvoEZaZ0Ewf1Yz?=
 =?iso-8859-1?Q?t22Kre7+y/9Ln89Dq43zyoiV12PWg9qcq10xpV6XsPV4jv+OrPt3k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-664b6.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a078da-b6f4-4922-7232-08df285ace9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 12:17:38.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788

=0A=
Hello,=0A=
=0A=
I am seeing the same problem as the 2026-09-01 report from William Luther Z=
ambo, on a different model: a Lenovo ThinkPad L15 Gen 1 AMD.=0A=
=0A=
System=0A=
------=0A=
Machine: Lenovo ThinkPad L15 Gen 1 AMD=0A=
Distribution: elementary OS 8.1 (Ubuntu 24.04 based)=0A=
Kernel: 6.17.0-14-generic=0A=
=0A=
Touchpad=0A=
--------=0A=
firmware_id: PNP: LEN0411 PNP0f13=0A=
Synaptics firmware: 10.32, model: 1, id: 0x1e2a1, board id: 3471, fw id: 39=
72349=0A=
=0A=
SMBus controller=0A=
----------------=0A=
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controll=
er [1022:790b] (rev 51)=0A=
Driver: i2c_piix4=0A=
i2c-0: SMBus PIIX4 adapter port 0 at 0b00=0A=
i2c-1: SMBus PIIX4 adapter port 2 at 0b00=0A=
i2c-2: SMBus PIIX4 adapter port 1 at 0b20=0A=
=0A=
Boot log=0A=
--------=0A=
psmouse serio1: synaptics: Trying to set up SMBus access=0A=
psmouse serio1: synaptics: SMbus companion is not ready yet=0A=
input: SynPS/2 Synaptics TouchPad=0A=
=0A=
I also loaded rmi_smbus by hand and reloaded psmouse (modprobe -r psmouse, =
then modprobe psmouse). The result was the same: it falls back to SynPS/2.=
=0A=
=0A=
This looks like the same i2c_piix4 limitation described in the original rep=
ort, on a second ThinkPad model with the same touchpad ID and the same SMBu=
s controller.=0A=
=0A=
I am happy to test patches on this machine and can provide further logs on =
request.=0A=
=0A=
Thanks,=0A=
A Smith=
