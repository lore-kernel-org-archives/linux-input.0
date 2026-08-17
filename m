Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA325B09E
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933171; cv=fail; b=ncWjXt3K2t5PxGnnpUSpsNwbOd0ER1+jehgVb3zKbNdCofIIFCMZDeMIKEOqTVawPGttrN0KtxocPyffQWSYCKoaY7icXW1pR5Ypve/Z2YytY4mydHT6pnpCRIbELj+6gS3zoLrg/GdwIXY3QyghgPAc0XWesTWO+JhD27ec0R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933171; c=relaxed/simple;
	bh=myAG5IPk09MRQVSzmbL9dlkhIv1nr9oV7FCJfOYhFzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ea2hvutz2NcqbHpgV/vUI4/UKKIZ2XfNH1HFnY6piSwtVBuYnP9W15uw+/hUPpVie1068IQshQvun5YYJYzL9pt8Ur3t+uWYDJxOXkWcxwLGw4AvJl7MXLuZSmqurtvpmIbNYCZUZPwA9SYWYBungVyAJniI8rzGFTSTxfeyF+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVHcq8HF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVHcq8HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786933168; x=1818469168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=myAG5IPk09MRQVSzmbL9dlkhIv1nr9oV7FCJfOYhFzc=;
  b=KVHcq8HFDag1falokhcHNoflEqL6xhwWDDVFkUovgfv/qj9vAjuwf/vB
   qP0SvSTziH+rFLNdKacnBnXqdQa3Q+lurjzsYYAPCEmVyRJ6izFUa8hq9
   +AcduViyCJU+FdYAz9y/R9/IiA78Yf+1Fv+DvYkyidEL5spcHwX2E4IOW
   nyAHMn4PmKn12F8nXG5/oAPn+Qpp0xgQlg+enVskNa76zvArd9K3Gy48O
   FXQfysqvR1Wj+PD9Aff103LoFHTYpKervI8K51FE3F7BrOyWdcAi0C0G1
   AoZus4howPqcL1kjQzE8hN9eUdLNixn9+f2nBaF6BahZeb4A+QzDpN27Z
   Q==;
X-CSE-ConnectionGUID: Z3wkwApoTHOpFhTIVNla/w==
X-CSE-MsgGUID: Zz6x28pmTwKPVtoYECm5fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87474062"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87474062"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 19:19:28 -0700
X-CSE-ConnectionGUID: 99XNPuysTrmiHrvrSZTt7Q==
X-CSE-MsgGUID: Ge1vj4TQTciyqUNhVeeRnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="258565948"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 19:19:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 19:19:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 16 Aug 2026 19:19:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.16)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 19:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O67wAAo3lzB1ncjYqtIP/6mG5Uisi1RwkfKrAaAAiEezQi+45N5eLlqk7MwvdaYtVtLFPvx61WTSMLpGb8vkDsiPjthDZYU4fXR7wOP1ePESApilUph3z0G/CI7SG8gmoL3YcZ88240mHjEGeSlKpoImqzElcTVrLSVqSH2RXBEM3U1b1HR9f/xotSgufV7MOh/XazrzqdAofOeGl4A705EmRpxIWVs9wwDRJPvZwmUDkJ1tozwFiNv2ULmpZtmQVlASZ17xQ8RRGmsa2vF8EN8UIvgsotMwPS8aEAvB6w8n8Joac7MUL4w5ZurqSxnT3+8G9YuZS6a4Ktq/ojYOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYjaHsf/OGwMchu/HMI1Qxul5Yr787uTKuR6OuspgkY=;
 b=CLwmu22GBVjdj6OJrOywbtP9s6jAuQUGGakuH1E7mmwrLczitfN+fFD5q1KbXQo/YE0fVCzLtJji5rZuBeVCvmDv0zbn14MalkEm+uA235CdnmktaABbFtokhk7VYdY+zcFiwdP8iu1BqaISLZryHKzHl91JJ7lt9ThifUxdSQnII0qQC6SjgNH8s7PHMjR4zx+tqyQaUbLD3IFiOrf53lSepnMkDjfEFUgQ2W624+1FTIjGHTWYMx+z1e0+pPR/IYXbcs9Tmtg+cWOGwYrTav8jdfhf9pHyo8yEY5EDjKF2Tv2vJ2TSdSY0Ad+3Z7Cl/0kT16tlEH43A8w4ZdlCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 02:19:18 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:19:18 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Qiao Ruihao <qiaoruihao20061203@qq.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>
Subject: RE: [BUG] intel-quickspi: touchscreen DMA write timeout (Goodix
 27C6:012D) on Lenovo YOGA Pro 16 IAH10
Thread-Topic: [BUG] intel-quickspi: touchscreen DMA write timeout (Goodix
 27C6:012D) on Lenovo YOGA Pro 16 IAH10
Thread-Index: AQHdLMmBqwhPw6qB20WnMRWO+yMjRrahgqpw
Date: Mon, 17 Aug 2026 02:19:18 +0000
Message-ID: <IA1PR11MB609806D036ACDB2E7A9C7A18F4A72@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <tencent_DBBAC19E701BEFF670746186D3C6B4CA1D06@qq.com>
In-Reply-To: <tencent_DBBAC19E701BEFF670746186D3C6B4CA1D06@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DS0PR11MB6470:EE_
x-ms-office365-filtering-correlation-id: c7060972-7653-41b7-2bbe-08defc05f11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: Eebc9tfI2gWVG2FUsa6cIXfOVIhms09iJCFVMDUnmmasWk/T3pcipFCVHinFA0YRW8JI/fjiHTqHThKt0BifXLZlz5YAlxFDbJsU9xIkji43rbkKAQG2Xd/LyzDw4PQrVLzvjyuAVNOAOsSfmOeQPMtl4+JrSlZDJiECJz5OAThCajlbam3GuR+jJbMrLzrUixxHtxcAwW/rg2GOV6TXWHLqLHwaqh/VEJMEbiEnL1iqImqnLe1XGq2ik71d1Y+pDOk/eWDbTa1uiPmCoF1bM/5JkAazTPRMLaJIfliGSrlBbM+PjPIuFC11zAltBocv8qU8q03cnRwc9KsNYArfVJmDUZpTbLhecC7uNqXbJarOg375E9ZSi77J6YyyIPDZ1Gbe+LOl1EtwyWSuBHD7OoxWQ0GX+pju+bWdNAnW+WfmTBOvDlvYXjiOfGED7EeMHTP1a9Pxmri2oWsJcVgZ9Qu78WNpPLJwTgpkgdYnCVZwdUL9QDaeF3/SiTpOEPdDz1Q7Ql9vEkDmd7jZaWG0ey6WEtYDDx83VEHE4tYKDyeRm7tyXRsW8LxNPeZLBUkUbTNjJVnj9p6TZMBN57BD1RvoUuOC9pxhfgIYFAlCUBpoGgbr3LWSP77upPQX/dknzqzzdjX0q1pQV1HxUAY0ngNS21/G223F4yHELIrBGzm7jubuqiCB78rGEs0MJ6pkAVA9U8vGFnZLEJDgQ1o7SdG3DLYhFPlTQgRJJ3vpmxk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EFENAW5hWYsU1NxiVQCyTtnN4r/oNxdvdfUtLjQgZQ9wHlH4NDxMqrS94Kr8?=
 =?us-ascii?Q?xaDYj4JJjZ3a/ek1kMV76A3Abj/y+tq8ISf7c6neoQtR/QXJTxY1Li5/vJx5?=
 =?us-ascii?Q?oYk/0pVABeJmZhGfZdGAQbXK3fh5gR54jUer5vw1pLEYugAhLTLORt4COhPI?=
 =?us-ascii?Q?2odLv5/NMr3E5Ip58GpAr2Rs6xaMI3ao8yVlPWDASuvOHTyX0ILqT+uRbUyu?=
 =?us-ascii?Q?Js6Epimx7zlavmziLhKrj0CjH/WMoBQxFs4JETn+pcEWdnD4rzeDcfcMGIm2?=
 =?us-ascii?Q?ygi9/X+/1i76Huro/PGx+rggsGbiDIpBUC08VASWZX4P987XqV6CDWTD4Gl3?=
 =?us-ascii?Q?TFZf6V+3yOQCTMTri67dJ/1qPUK/k1Ae3zMZu5xFaidHSkMeGWcia9trMQnk?=
 =?us-ascii?Q?6MT3D/r1hqO0RzOdta2J9k9q17+I8MHbSNcCIH2lmhQJ8j9S2FRLAr2xLJwU?=
 =?us-ascii?Q?YQVujpdpSICkWSPKSnmoRbYyN+oKf5kVafyAuP7LrokvDhsTfmRPJTDvDQdR?=
 =?us-ascii?Q?7FPWVWRHUlMWku2ZsrDZ7debU6Zrfq9L8zYr8J//xvHitU3JG/Y3oOm7oWUY?=
 =?us-ascii?Q?LjPcZW+35mJofEBq7Dqx5fdeZUZvZwRC1gtHO/xjDBBrZ/XKVw2Qt4utBtrR?=
 =?us-ascii?Q?GWHKFVpO+iJboe/XZYPI145a5Pja5A8FqQk0E0QkckxiHOoz/MF5dcYGW7GR?=
 =?us-ascii?Q?lCQeAtDuFpLw7Q2dUIcaBtMzOUvLM5nAsjJ8lEpiOu33Y+Fv8T9UPEH2o33S?=
 =?us-ascii?Q?ka4g39i7L3GaE0RMx+nnSizthuth5puiv25ZCzf9QZjgTVMRh10Ygp7RZ5ts?=
 =?us-ascii?Q?O7MC8JQSeXiDPgDE4gJ9u7EcewWkf1FvZ+HrHEK6cM1JMFrnMeGfo5aNKc+J?=
 =?us-ascii?Q?729JFBx8SIMfZrOLhHilImQPXFDIH8abeW3rveqsdogM6CTo7k4zU2Yb8tB+?=
 =?us-ascii?Q?7YVGUm0toL+euBYoN08E+y5IWeuq4aJOZB2AzdtV44ZozjJzu4VZUWDLLM71?=
 =?us-ascii?Q?pNLNR4XpEn6uWqDFB3isw2RcEEr0XVs3schWvvFdumtDV/QsmZnAfFnnP+NV?=
 =?us-ascii?Q?pp7bGGN79gbuDz8K44HJNcLkoS4lBeeh4LEyCI8lNayWeXzKqFTuXQA1J75Z?=
 =?us-ascii?Q?Je+F/FBKfWLf1NiKyuh97xQFyeYjvus6nhAaoHboQY7oC9zP4cE4bjwyKipM?=
 =?us-ascii?Q?LwS0yHvOg48O/SVaaJXfHEkR2VG6lrpg/UZ5YlhQLZ0X39K+mu2n9eFxokBQ?=
 =?us-ascii?Q?C0ENf0a4zYcPB2N9SC7vHEh82/tghFk6rOZfy4hiJCY4EA9KW7Wi2MQMAmbA?=
 =?us-ascii?Q?ajjDHTbEQ2mB2iHa6hBU9yTQiezkx45Mo7FXABhJx+LpaFqOLA36RyPJ/IHl?=
 =?us-ascii?Q?qIKeJg75PJisn2poxMEZI6AGOvE9WMVye2+0ZoYpnFd7hgAazJSFmPumB4J7?=
 =?us-ascii?Q?uaVUnRHihwTgt5Dn1qkcpYZri1ywj43b30BJ/FpjZuRKqmdJE3LXwoUFMXzR?=
 =?us-ascii?Q?lwEzYd+zeoi/1o1zKdoJPO3vcPMh0dNTpU+oDBLrQfhSS8PxFi4z/1njP2Q5?=
 =?us-ascii?Q?qhCk/it/6iBV30ATxmHx1UFedG69NMlPfQNlNLuYJOVzoT9qTqTrocOjnbvu?=
 =?us-ascii?Q?Blmp/Y7C0osSd163a+h+S0E2gAIFI9FMrMO8HsoZ/ogroHGTNo5BmR8nYN1y?=
 =?us-ascii?Q?BrHV2r4V62ugBkl+g5zJ7CFB8ZgCndLmOiSIwmwP1fVzMMLG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QZnDNzifua5fRoYQwyt/kF1/QK4WEeRthMDWM0frAUzQ4wezx/70TcqwYKREw1eVPcSekVQphcfduMxYC+BqJNSpwHNPtaEvlMMQvDoc0br9hlRa9YhbSL9iJpL6PzidXOAkvaUUrt3vjWyL/SXSUN4J5v+nZt/hCuR1DfScOGmIYwqB0e2/QEjLmpt8YsVp14QryyVBnwT+lYRrrRkTOvFQ6NySE+lwQDUJql5jrZ6FzVj+l4y7JyuQbquPZJXjaapg9UIejx8yhTBGBeHige3ZuZSrBRRw1U9njtI1UdjDqSUMZm2HPwWlPzWSKHVTAhkzrVA5gtSA0w9jTt3DRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7060972-7653-41b7-2bbe-08defc05f11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 02:19:18.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTIT49tnTBaY71Kq+kk90qV1qHceqtJFIOWrUG7NK5CFiM1ygmPOePs2nlwgrlNmpKZ9jmyuErIoat6iwhezeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com

Generally speaking, a write timeout does not normally occur on the SPI bus.=
=20
If it does happen, it usually indicates that there is a problem with the bu=
s, or that the touch device has lost power.=20
You can try unloading the intel_quickspi driver with rmmod, then reload it =
with insmod, and check the kernel log to see whether a different symptom ap=
pears.

Best Regards,
Even Xu

> -----Original Message-----
> From: Qiao Ruihao <qiaoruihao20061203@qq.com>
> Sent: Saturday, August 15, 2026 11:20 PM
> To: linux-input@vger.kernel.org
> Cc: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>
> Subject: [BUG] intel-quickspi: touchscreen DMA write timeout (Goodix
> 27C6:012D) on Lenovo YOGA Pro 16 IAH10
>=20
> Hello,
>=20
> The touchscreen on my Lenovo YOGA Pro 16 IAH10 does not work under Linux.
> The intel-quickspi driver detects the device, but the feature-report fetc=
h
> (GET_REPORT) fails with a TxDMA write timeout, which makes hid-multitouch=
 fail
> initialization and fall back to a generic keyboard, so the screen does no=
t respond
> to any touch input.
>=20
> The touchscreen works correctly under Windows 11 on the same hardware.
>=20
> ## Hardware
>=20
>   - Laptop: Lenovo YOGA Pro 16 IAH10 (MT 83L0)
>   - CPU: Intel Arrow Lake-H
>   - Touchscreen: Goodix 27C6:012D, connected via Intel THC QuickSPI
>   - THC controller: 00:10.0 Digitizer Pen [8086:7749] (rev 03),
>     subsystem Lenovo [17aa:3815]
>=20
> ## Software
>=20
>   - Kernel: 7.0.14-070014-generic
>     (also reproduced on 6.19.14-061914-generic)
>   - Distro: Ubuntu 22.04.5 LTS
>=20
> ## Problem
>=20
> At boot the device is detected (reset + device descriptor read succeed), =
but then
> hid-multitouch fails to fetch its feature reports because every GET_REPOR=
T
> command sent over TxDMA times out.
>=20
> ## Relevant kernel log
>=20
>   intel_quickspi 0000:00:10.0: Can't find wake GPIO resource
>   ACPI: \_SB.PC00.THC0._RST: Excess arguments - Caller passed 1, ACPI req=
uires 0
>   input: quickspi-hid 27C6:012D Touchscreen as
> /devices/pci0000:00/0000:00:10.0/0001:27C6:012D.0002/input/input7
>   intel_quickspi 0000:00:10.0: Wait Get Report Response timeout, ret:0
>   hid-multitouch 0001:27C6:012D.0002: failed to fetch feature 2
>   intel_quickspi 0000:00:10.0: timeout for waiting TxDMA completion
>   intel_quickspi 0000:00:10.0: DMA write failed, ret =3D -110
>   intel_quickspi 0000:00:10.0: Write GET_REPORT command failed, ret =3D -=
110
>   hid-multitouch 0001:27C6:012D.0002: failed to fetch feature 3
>   hid-multitouch 0001:27C6:012D.0002: input,hidraw1: <UNKNOWN> HID v8.65
> Keyboard [quickspi-hid 27C6:012D]
>=20
> ## Analysis
>=20
> The reset (acpi_tic_reset via _RST) and device-descriptor read succeed, s=
o the
> SPI link and interrupt path partially work. The failure is specific to
> quickspi_get_report() ->
> write_cmd_to_txdma() -> thc_dma_write(): the TxDMA transfer never complet=
es
> (write_done is never set, 1s timeout -> -ETIMEDOUT).
>=20
> I would be happy to provide additional information (full dmesg, ACPI tabl=
es,
> register dumps) or test patches.
>=20
> Thanks,
> Qiao Ruihao

