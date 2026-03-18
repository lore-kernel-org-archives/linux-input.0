Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBAEED8;
	Wed, 18 Mar 2026 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794893; cv=fail; b=ecuALcnWGeBcGBrQdNdE8PBeWCORE75IhVwRs0dfhD+sdQbDXbPRXr0OeqrS1h25CMGanmZuHwvzzAcKXEjzZy4MEme/asagXZFqc56ALHGnUk0cnDfB/HdnBLNgaS4OVz3VrR16gRc+kS1OAupv+YVA8pCnJ34/1JUxK+WaOvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794893; c=relaxed/simple;
	bh=T/Hvl5AlLTGB5m2jDZULlA0G3SGSEKpI0r1uIVeb7Do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZhwoxNDNO0NgpInOjODii8nbEkrvw5Ql4MlzppsUcQ0jML9kr2KdlcBOlEY1ebL+xVFbo0r7tLsq7j324Adwl7mRnGm59jv1oiPwTgLlFWznyE+ABA4hef8HlYyv0920yyJVJ0pfNBOgp9h5eK64xPiiVPLXLe718bPchlLKHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKt5PKIm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKt5PKIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773794892; x=1805330892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/Hvl5AlLTGB5m2jDZULlA0G3SGSEKpI0r1uIVeb7Do=;
  b=NKt5PKIm/wSrWhVBVB2ZrtRwrr0hJ0iuu6fyJ0XMe3wVbk0mLHrxoQtU
   qz9eI+GRAxeMpQlrJ7D4JlLx72Z5VYBIux1ZdvHhP1PI0Kn5A3A/T0zCG
   mp03IjyS5s1hgNvEmXm9lO4fIVnzEnWoPylr3hTXAwTznMtTRAyg6NRV/
   0aLxDsADrskx95NHbnzCTGy+CzIRe0u8Lr3cehz6okEPn9lwaUwJWnJDu
   31GxVuzQQV7dgEsHU5H7WLFRCp3U0Ko/TEMqitWjgHX6svo2Wug4+XaLD
   ODRZAc7WCtn1NuHVvnoimbKRjkm4O30isWN7gcfESTuc6Zt6dD6qqtUJ7
   w==;
X-CSE-ConnectionGUID: Np6M31tmRQ6FvTdXhurwWw==
X-CSE-MsgGUID: mRJv0uoUSSGwlNdQ0xr3yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92412741"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="92412741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 17:48:11 -0700
X-CSE-ConnectionGUID: 1EM14PZDRxqWxsnRn+IMRA==
X-CSE-MsgGUID: u1n3JogQTAuyxSPb/Fkt4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226903232"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 17:48:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 17:48:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 17:48:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 17:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzLpgLnOIlSUotjMRpjf7lfi19LOPZkZ8YXIyKu5pMHRCS4oi5m1i0JFXCBafyygMHMjVhWBhGYJYGa+BcQew198Sm21T/+4XbwEpmW5EVrKHtCnqqyfWHDefWTvLHz+lLHYihRJMHyNpdFN+03yPoPCkTbBdeIOY7g2y3Cxh1S5aEumfUXr7b03L/ii2/fSdTN8FqEdvsx+2vtWvmyJvz/bOK6MtklGq2aBca/4ly4JTYdwIbQnClyfxORo20ig9v/+d8+aumBnwmNgYq53CylJB7ZVSRo9AqsxivDEtU2I9KqX6bnvVdb7YJma5EDwafE0p7RPbCYPKcib1fb/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EazGZXyDJ5EA8Y2B+9goEvqj5S8DuzlWeym/leYqs8=;
 b=WXOpC/kh3SUaDaY7cwpX9CWnSLAkiQUGIH4Z5p5bYTVuG54p8dcenF9DIWsAuOLZQPrZGhCjSBRs8HOGENAkvu7Q4aTV5PXUzkz1/ZxlqylebPY8rUKxlb2SEkcpsMuhxd1uDGFTA4KaCRYWPtbnc/2s7FH44CsMA2pFiyX1bGsSjWV9ctKYFuVVl7Pt5Ny7Q5M1F45LARBpDkJtChTtzU9U70ILIgu1VxMkzi01axiMHGJG/B8ci/RcwMnYDq3vMaWpo6fATbevto4Lf5tkfV2QTyinSG1xYEw1LTsISaSbvo7htlnBb0Lnfn4WPzs08V+74xjmc2uqfNAWBo7okA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 00:48:08 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%3]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 00:48:08 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Add THC Nova Lake device IDs
Thread-Topic: [PATCH 0/2] Add THC Nova Lake device IDs
Thread-Index: AQHctdKOw3g86S5rFEq6dUugVoR4a7WzWEUAgAAdvFA=
Date: Wed, 18 Mar 2026 00:48:08 +0000
Message-ID: <IA1PR11MB6098CF10902CCBAF33220C30F44EA@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260317055629.3877299-1-even.xu@intel.com>
 <q73969s9-n2r4-10rp-1459-3nnp0322ro9p@xreary.bet>
In-Reply-To: <q73969s9-n2r4-10rp-1459-3nnp0322ro9p@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DM6PR11MB4609:EE_
x-ms-office365-filtering-correlation-id: de239aa4-ed81-4b17-1f66-08de848805f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: md3XOIcZCI85BkLL3CGrKwStmHtvziRqM1m7wgN+nuGSITIvQJnZ/5uUFDaxcRaGblIqWNVizF5uUU9Brr3y18PdqX86mllB2QAIBiKHKMwvsPjAJqspZ5gkya75u5lejXOhp5bgDboMKKFkhMg5f7D/Y7e8DzzNS3+w2DsSEkOPEU3nRw0WMOGSpB64V4PConBLYYsVw/YxsPlXih4w2VgU4lFDRVNxIiWmdIbx/4RmNSjO1w1uJggznvVqYDa7XeD/bWFOrCfwMlA1bfp3ESvkiZ4uqqx+rGSgRgByRrNwUeQ44sbyqHxEfhxkj7I8+8+tzm1ktIfce+qe+qIZTz8JLZg2ZK6Sy2qAiB4JxKabVh260Y1MI3vdT553ftkmM4zF7vKvKZerd1EAqcVgOeJ3EBhROIBb6eFxrQkoKlvOyDzNnzAWN6GtPOm1TpfgBhOjnwlhiuciu62kyHbtRjfvTgXcZvJ72OO9alBEr7EfXj+IoMbGzA/6KvZZXtLczJOJQdoUbsQfbUgp/iD0WEr30VTPS2PP2/pNtyGXftlbXZeX34nQQmpYvxjPLWDwWgaSgGxJryG5BNZi/w6HQDL1XGYNd7fBAL1j/u9lu9dz/O7bryKFu65WNpHW89L9GxYUKTFFleizF0pi7NdVsyEEhiw1zyuIIaQTi05WvdnzfvrQDOUberSV0KMO+2PUOh1n1z1GmZaYCjKFKXYPGGECNKa+RpC2wkHOndlhjVAtRsPH2+LP8blDVD2weXfeeWHwA97BcQ1Ki7sA/j/1P/FNvXDe+bAzjUv1uV9lJz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vaWZgrpCw5ve7/29n6fc+5t9xi7dUzcjHsvFHshdsRsyKRVhrryZ7+E+pXLY?=
 =?us-ascii?Q?IwsbOhSxK/ghdxUzZEPOpuds4hx3W/bRgOEbTgxwhRDPbG4gPHRBJr3vAmXF?=
 =?us-ascii?Q?vbv3k5bMH2iw+RQKeBHpz1xgrQhMjSLdQ7Z+Yqxi4sB6SPdRqG83fPnpqLs8?=
 =?us-ascii?Q?rQaFIvyupJuPvCv2bPJPAZLjQDgkzPLEeIwCB9cDPrgrKJ7VfRaRGncxzSDW?=
 =?us-ascii?Q?emzBz3D+RdvkI/f3WnJed54iNEy3+YDwTsYCMdkCpk9AeAu3MdC8iK2z85Bi?=
 =?us-ascii?Q?ckrYzVrXFIfAc7hd3I3fbjC4E5bwouCJpF2H0213ihv1bIM8wEwuXfOZoD9T?=
 =?us-ascii?Q?JiIktBTJP9wWQW7yLDF3VgTXQiX3iC10/uAAJ4HkVYHVDmJd1APEQrhoI/t6?=
 =?us-ascii?Q?YYNfCfK2SvYuvXcr66OoTPwsnIszmJF0LCSOOXQxh7UplaJhaO3cZnVIgO2Y?=
 =?us-ascii?Q?acUP2xqjJA+HettboN5xnNOKYQ1D5dX+JRGxru7CCvXd1kwQ2jBKS7pm/gBF?=
 =?us-ascii?Q?X5eAfqxk/ZOhgWD7wC/l7aILgGD+F8DTWhWY3B2DtPKdK2cfSzsMO76nmMAk?=
 =?us-ascii?Q?sQNbt1jY+jJpx0H3i64iwNDw4QnDCb6cvk75gCLYXLFPaBeoh0x4FBlYfcY7?=
 =?us-ascii?Q?PQ4CGziw+WgY/QHVSxga8fhn/W6gQmpO3Dks+vPtb90I3kM6Hr44pk04VjB8?=
 =?us-ascii?Q?VajobaTwuM24Q/kp7V91opy32QHLZF+Wp3t+lGWSzZb1xOEVbpo6jME21kZs?=
 =?us-ascii?Q?QN9vX97sQx3EJn4JoOKzY+e6u+YK7M9D9FLNzikp39BuWmygoxieizt+3roj?=
 =?us-ascii?Q?rQqARQfGHAwGnp64pdQD5LtUR3rV05QuB3lqklcVs2n3XZNjT/QWdL61au7S?=
 =?us-ascii?Q?gh0WeWOBLtei5pMawA6AUDIjQr+19OFm5ekQyXJ6ek+p+vcVHEijnzz98fgo?=
 =?us-ascii?Q?EjEFK2UqmKxoikPHJYkW17wvsHzyot9lcEhCKxxashYNpHb60apNQHV4KXe5?=
 =?us-ascii?Q?lmER0YGUxfEOp+Jq483gavafJGl77/KI7VB3R80KgGqPzhWG2yECDOC9GziN?=
 =?us-ascii?Q?E761V6i+3AqiHLr+aJVhybhLtinl72R4vTKW4/3E3TBdzi2bkqjx4ZUvLRuT?=
 =?us-ascii?Q?5VSm4gGqPlCEcXDdjHdp94zWK7C8hv6x4bVefCgygXByEwn9qMJzCn1hQAhm?=
 =?us-ascii?Q?kASj/wkiLhSB1uDhImw0SCxU6C47V1f3mjK4y0P5DMLIxo+1vtP95vo1vIVH?=
 =?us-ascii?Q?VaEwAsUG/28ibaxte1WdMdqMIr5Amw/TaSNur6XVo5CnNPqtv+3gay40leeY?=
 =?us-ascii?Q?2ju8R3N6Q+AjDw1YzZhPU6x7zv5CJ1jg64bwdh7cEmf+LYaL3xWyPLvuGV1e?=
 =?us-ascii?Q?LrxvoO5okPaUQVdeWWQ32EmmpumlJJ+Hd7Gv8Z+EwVZP3W6Dc/5pWLngcD79?=
 =?us-ascii?Q?WXU9Kq39J+2sZNxPWjDoutndtHjZ23A9ItH/xA2DWhw5z38yJGPsHuCX9ry8?=
 =?us-ascii?Q?4OBRlmjqJ3hWS69TTiWklVQIz1SgadtiDEMjfeWmCfwDKT0HwGXPGYV8CGxi?=
 =?us-ascii?Q?xpgjnIWehCxDNNOiWQrXv7MHfgQZP+0pEWpVSHcw0io2QzpnwIZ8VDwOMyKO?=
 =?us-ascii?Q?escYL8DOZl9mXeTgadMkLQDxSUyR6FoF+Zr2thuzUiaHjtNw5OtmZlNyziSm?=
 =?us-ascii?Q?g94fBs75cGsjIXM5ZROemSrxehN81TRv9dcqNz9jy21BpgDL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RtpCAs4ewDF0mOevFpjGY91/6USnvgeKTJTcGjH1CrJaTZFxCzhT+vGJ2ChmCqFRFQU87tuf4XpAwx/2usflf9QnxEmKGdjyYRDPV7v3s/S488c6roaUTVE1Ica/nEKHSxKGiyGpIPrK2l8c76nC5svvzsQN9Fje4LM3LGIFgWFOHC4hsfkwLcIdRKjEf75dfAbAt1R8stf8PWAVSqwh9m75cwWRtnaJVBLvQ61kHAtxRA+BKuPzLz8lMpk85sTsz3+T7WU3RPDhUHOrobY22XOrGh9J1p7u/SAUX6OK3AUXfcQqJe3HJ5MIHOXQV30ngRypvA2dBIQrwF3mcoPv+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de239aa4-ed81-4b17-1f66-08de848805f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:48:08.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsB6o6Y4pSLbivpyhkX+fkNleHBzneu78umfOiQihCRkQf/W+ziy/h+A3unT3MAc1reep/ANIyVBEjbMmh3mtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com

Thanks Jiri!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Wednesday, March 18, 2026 7:01 AM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] Add THC Nova Lake device IDs
>=20
> On Tue, 17 Mar 2026, Even Xu wrote:
>=20
> > Add THC Device IDs for Nova Lake platform.
> >
> > Even Xu (2):
> >   Hid: Intel-thc-hid: Intel-quicki2c: Add NVL Device IDs
> >   Hid: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs
>=20
> Thanks for the patches, applied to hid.git#for-7.0/upstream-fixes.
>=20
> (for your next submissions, please follow the subsystem standard conventi=
on and
> use prefix 'HID:' for the shortlog, thanks!)
>=20
> --
> Jiri Kosina
> SUSE Labs

