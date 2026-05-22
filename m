Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D31F12E0;
	Fri, 22 May 2026 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429887; cv=fail; b=WU8gX4C1jtfzO0JOZEa0zELAQCwjxdGe4NRU7n84JKXisACc0RYpoy+vb74Uy6TASko12OTK4wnbpMbgfSiwGdUo++zEEibE1n0C0MsCrs3pVn1YY5J7Qzix970DKYTejpPM17NB3gdTCXcfBGiFjkEX+8KMkFCU5JyQO4kYi/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429887; c=relaxed/simple;
	bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p+TfhyYQGSXpI+IP7T3QgDpAk0Ge6xdvUtCRbBscum5z+2HAaEMT9Ncn+fm80KnbsxHx3fNCu6uW5wzbEVKEI5FOiI2lnrRBduqypG9J7H+dlMyE42DkUdzM43eSeBH2MmFc1qQgUJ0/rep4NfZnWRBg2FIW5ugMc/RE4xIbTuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fwkeA4rO; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fwkeA4rO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXfol0zZ5lPU/SWX4J7mAMU2H4X8/ggBGE+6UMzHpIR7nr80Ieck6c5Yip0LubQe8MBaQ7F4RhN1/ov7ECIXwfqTr677lUK/00QKJxh/j7gYXfkGF1dFm86t/dHda7wAey67QDk79qc4XMYYtNgg3+//efh2QfZ0fOhegyHwh4KpaqRyf2hurPfZ0pigU453w0KsY1lUDjlvuphEwZmMmY27gyRluMlRALtsmpw1LFaPZS6vJ2gsJWELirTKlVcQ2EG5qqJdc+8cNEw9bzukAKkzHjgyc/V0ff1cE6fnQCUAUkix0VCrc4oM5YJGK5rmdMbVr/XTiPuxZ/V6zkep3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
 b=LVT4teti8PU40sxFOpVHiiACE561VHWOsHJA8+2wa7325YKg2RE70j4TZhxAx2XIwKlEIZ0oqBcc0WKGuNhq/L3bpua7rOepO0b3hzsKk2mzHwAVXUrDV+zzv5OX6xN4ViyEoqI/1Kv5rLkqDCxR1hTdfZQK+Mm5qghMkBYSzlqGPwDCSKfzg60l6xm6IhxYT1HZ0vO8eDYctXMKezABThniP14iS0g9j0lbubWSLW5UfcFguXzGEy6wHa2dZojllcEOeuCq9SVDQ59B769g6qAypoTRFh3CQv7mmvyDToy8leysLOXq0z8MieRf29QrNx+YulzH61K5zykm/v/5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
 b=fwkeA4rOLSLg5Ql/nUs/yxykp/33KCMmLNhj/pvK8T2dgIeIzQvwICz4XmCXey6JDO3i9wt7bK4hR2WtnUpN6CiC9ab+qq+3sZb73poKFmMtVkU/l10cxfpNkQf46Gx+0gENxBj5wDGk/yI0ePoADN1K7kJf2LUd0dGbM0c+RFkbf9+c38pR7g8j1PUPhDlh0VSumzzZ56kRbxffbqVhr7Qofo69oRFHHuAbLdVeJUWxl1N4CeUV55Z+znWqJCMg6Sjg7vcxD3oOZNpOYtM8Bb7NSyoxogNlNdfw+Y/WI189Zo0V08aeSEwV0Ehf7a3Hjia9yROgHvBZvNSzoOIyJA==
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com (2603:1096:604:162::11)
 by OSOPR01MB12186.jpnprd01.prod.outlook.com (2603:1096:604:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:04:43 +0000
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01]) by OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:04:43 +0000
From: Liu Kai <lukace97@outlook.com>
To: Benjamin Tissoires <bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Topic: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Index: AQHc6bDifUxb4nYwLk6JQbrIc0gbzA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 22 May 2026 06:04:43 +0000
Message-ID:
 <OS3PR01MB79698CFE4F669A75D93A498EC70F2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB7969:EE_|OSOPR01MB12186:EE_
x-ms-office365-filtering-correlation-id: 87f2fad3-12b5-4d39-0bbb-08deb7c804de
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|37011999003|25031999004|15080799012|31061999003|8060799015|8062599012|51005399006|24021099003|3412199025|440099028|102099032|26104999009|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0zcoj8c6/rDUFZXdQ+9AkiT8uZfe32i/4xlnLwbRPqBFkkBGgs9C3IvXHAwS?=
 =?us-ascii?Q?sfhIn5nIRMrW4P4QUbB88NEUOCzK6hg9X3ONNWNjw+8+YAEH6tmwgJEuvArj?=
 =?us-ascii?Q?ji3Rsqjkx21kDTiTPvNSu1V346vpPwNQ9YEjUcKPl/pzytztaWK5FaHXQZbh?=
 =?us-ascii?Q?xVHSK8KoIg9tcNwdslLKEqOIseXH6mRNBe7OB0zY53J6rPcikxIkpNud8+bK?=
 =?us-ascii?Q?1cAb/Yw2jHfcas6gZjow8pCGP1bDkrlPT9vWxiuUo4MAvj1FYIkVgffql2Ny?=
 =?us-ascii?Q?xvJ5Zz/M17i7s6JpCwIMHgXNNRTDTBhBDRDPrwdzG8ao5i4JC1CFT3HTnGQY?=
 =?us-ascii?Q?g/qs+S7R+AowmFoVX3/c1Te7UBVZOujUOiddqNojlv4v9s5ZBIYWPFNCkxve?=
 =?us-ascii?Q?ILso10RfOBmlwVoNIW4g26gBBBdk1eqkZzX+E3FuiMg+A8LAL1167XuJoLza?=
 =?us-ascii?Q?0/JxGAPU580CZXvnSUopNS5Zv4O1QZxGXXwiZGfgC5SJu0vJ44zLobxKzo8c?=
 =?us-ascii?Q?fc8Ors0koq6xqCYs/5Sv3C9bNXRSak7bW9o7+jOUqt6yPRZww53SFsho5e9R?=
 =?us-ascii?Q?abuGJ8Pu4ipkZ+tb3hgB2u6IzgTWrzIkRoFpbVYGHYve8zSZ0qKbcay0SvUE?=
 =?us-ascii?Q?vbzPZGIzEhBWBPjvJHkTS5vp52K+AKHobBxeUnfkZVGLX3bnqjfoj+uScNH+?=
 =?us-ascii?Q?adXpwpvkWglC/gUm7ZB8ygZNvqCKq0D2g0Oue89xAZSy82TLKpKGmLxFTYMn?=
 =?us-ascii?Q?CLYJ/1REXtzivvz0ZJST2zjejuH96nOcnv7gEYlKutqCzV4G2TchZcC/Q49g?=
 =?us-ascii?Q?+bO3YolHriQBDM4IDzv29WOSkFMbjGGirRo7dgmcBICy3Pds49YSJZ2pNj+2?=
 =?us-ascii?Q?kFItgCzf1RtVqkDrNISBwIkzOlwaGJqFCfxOVxg1k12sYt3ll4kSFw6Y8RXn?=
 =?us-ascii?Q?xa3RZbbYCuIcOQRghTDI8Mx29stDorNrGcwRgASvfjTGy2sJ8RtutsZYa4IB?=
 =?us-ascii?Q?ceLL4PtrPtn50gvVLGHUC+OqXLAOUdiBW9SrtWc7kYju94c=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tD+IPuCBHEIjqlP0L8XzleCxUv/B00oVKdi9YrmA7icwO6ycr5seSGjgfGYO?=
 =?us-ascii?Q?apBYzsN9P7WwNxJBr/vrS04ttDcUc7Z2nAN1BJg5rQaisoxqPnI7dRrXtmZ8?=
 =?us-ascii?Q?B+jSbCTXUeTc6U2ecPrSMxq4zNIN9rLSAyG8EaKfuCQywv8eECHaQ4dca9d0?=
 =?us-ascii?Q?2xDwU2gbAjIveP6GGXhD+0vp2llH14fzV3dX5AfUuJKmHjCmvqPcQ/B81eLC?=
 =?us-ascii?Q?XqxNGRbmnM1zaDWebY3jV/CkAL5ok/J48Kl2W4KTK3aUnm++6DLh2GFjCROH?=
 =?us-ascii?Q?9hlcqFk6jolUK2TW5LWrv/ybALdUUvbnGWrb9bAMtlI3NYOHMmIC3vALWd7b?=
 =?us-ascii?Q?JBFgDL+mHQsh1fReKGxBGElucRIhUWvzkZKPpepQkhbB5bBjda6tMgIdCNww?=
 =?us-ascii?Q?nh/V87uulIHKI/aTfhdLj2dbwEJ0W69cFdaExtWP4dgUcyx4PDN9NONitAFS?=
 =?us-ascii?Q?BLhilsY/ebH6cyFxcOsa9N/UFIrJ78VMeDCH5Mst9FxwXIoTtPWL9O7AWDne?=
 =?us-ascii?Q?sBnZgJi7RuykzZWuZf6V3KuSajjioVmdlD96t9D8HcIODmfCh7JNPj3PyIe3?=
 =?us-ascii?Q?iDKV7p85XgROtesHUp0CE/LGm8PDcyvsi3UEt9euTtIGe0nPm1teWkSsaxqE?=
 =?us-ascii?Q?LeErYTFzv2Rq1FzFO/gHfac7UvtJOMzGi3FTuBINjtWZXrluUmrVx/FJ58wM?=
 =?us-ascii?Q?6IgWwPKNkR6Bx7HkHHVlNT1QyYNPO0iRZk1327A7FPbqG4Jm4aR3q4eX+7+a?=
 =?us-ascii?Q?nn617cjd1LOm50jaWTJD3DjVb5lJgPHiOlQS/TsHH9CQd1kKvbZic5l+9gwd?=
 =?us-ascii?Q?FxAeadh+rQfBiRMdrwoYhYvvamnDjn4O23f8DMI7hvBqK21TB4zoCiK0Dm9s?=
 =?us-ascii?Q?INh/36t7+5pMo7Ei0SP3MNyNBL4ftgfnNZIiKqYWmdNUpyPpZNBvZBFa9M60?=
 =?us-ascii?Q?0VP/izsUtmomucAD08glKK58JxV+A/BWWVgVa38vHXlaXMsBPZ/OMJ56X6uX?=
 =?us-ascii?Q?aVyoC+F0R1QOIYZi6wbm6LB8g0qaJKXlgVN4uUnlFyVrFo67KtLRe9WhtZ0+?=
 =?us-ascii?Q?XpTLQdDFRhgrVrMsjrvTM3zFrJ7igXK/3YlU++tWPON0mPADMX/msKm3/Uxp?=
 =?us-ascii?Q?gMAeIZRg1desgjQorA1heK5BojDvhQb8pXQY33FPrJVjSW2qdXjgSXC61khL?=
 =?us-ascii?Q?+jHpysKq48q7Tz4WuGSvlBiszLjEykvGLyOTlS4eChJSpENLo5HQE4JaECKi?=
 =?us-ascii?Q?aOOEWC+MVQomewiLgd8dxmv73uZI8LnzZ/tGiAzEh30XBh3RaDekZHL0/kJ7?=
 =?us-ascii?Q?D7oL5rI+5KPJLlXlO/H1Sq57GdN8quV6KV8g0WZ0rUPIyRiJP/ZlAz4BYJmh?=
 =?us-ascii?Q?hUwCvGE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7969.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f2fad3-12b5-4d39-0bbb-08deb7c804de
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:04:43.6165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12186

Liu Kai would like to recall the message, "[PATCH] HID: remove duplicate hi=
d_warn_ratelimited definition".=
