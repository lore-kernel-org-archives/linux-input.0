Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861002F3C3D
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723980; cv=fail; b=UvrXfteSc/jQ3z+fK+/g9ZlCVvfz9daHWhfu86K42eiwGlZfdxdKnRjqWokWT2qC8FtUCaVuOB1wDf0yMHRucXEPe+qKMOG3HbdlRK590eZSKlTUUg4SmXY0qgYn2ikd/irp8jiPj+RCrDjAVB1DhwNk30s7o9vCKbE9uESHfiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723980; c=relaxed/simple;
	bh=UgBmQKhak2qSygH4Y+djepDg8n8b7iZlbnnvCf2ZhuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fn8uiz56NIjM7AVAU1ofwPf724C4X9Ta9IAONRwGa5ENqkrQEwcVURC9mvdNvCB3otvunNU7F5H27LON5KuzaVuUpwNgh6kEjJAajYSLbgbTVK7jbBMGM1kcImXq6Y5VDO7jt3rGMIDPGMzJA5TwdcRyEK7L/Y7juAki1myx9+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exJeZvpY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exJeZvpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785723978; x=1817259978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UgBmQKhak2qSygH4Y+djepDg8n8b7iZlbnnvCf2ZhuI=;
  b=exJeZvpYc63SjXzFy7SD+1eF4fwuqq3v5N8MmsOpVkhCW8qwhYIvGjWS
   W9Jg6Snq76Zmfh+3CH8Pe4O4i3cSKcythklizqAMOechHbNm4xFQSoi8I
   42OjBf9gdFdcI+Jr3wSVchPY623ubKFFxFTgmPyzI1C2n5io+cXcBa9GX
   8HST7NICKRYI6ZwkYZQZhSDGH81mR4wP9+YxWOOIcx2bY+hvv9wQz6nUF
   AwA3Fkh5Ga0WGven59YDBZo5rUsdAYccZ05LdckgmPYo8xq1EQBI2sEeA
   Kmz9YWVzX9wKGFGP97rqQ/PNCm25RHUrw9wbeBqhkUHcPV73si1TwwbgK
   g==;
X-CSE-ConnectionGUID: JtyE47AeQ827ljcCLfx/lw==
X-CSE-MsgGUID: gLRbKY91QWC3UBJNIVFFDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86116425"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86116425"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 19:26:17 -0700
X-CSE-ConnectionGUID: JamD1FImSHSZyhqxws1zMg==
X-CSE-MsgGUID: 43dVIdefQ6en8S2rirzmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="285721101"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 19:26:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 2 Aug 2026 19:26:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 2 Aug 2026 19:26:15 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 2 Aug 2026 19:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stWS0BIaIXp8UdqEbZ2jYrMoFmZZ750l0THP8neY+1OHC89EPND1l08qB0b3T+Sj2D5udO8gQnAspx2FZ7eNrxLVCMYGKkGVyzH52uFWtEXXKDBcZp4SYnnTGcG3YFCGMhidzH9POh93o2nzKIFfGOF9PWxDbiY6CSwDZjrAz52GhKB3c1Th0Fk7LsLiVYHTroB55Ybg/P/J/R+tt7bXV3pVldZcfIDJvNKsCxarUuS1szT9bpl3s98bim171SFZUt6oTyxCJirqnp5G05pQUi3N1KILzCDwj7+BEyyVR9ILoFlBTYP/0qLWKE1t1INwH0V2WrTuO6P9vexjKps6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXcI9jjR0MTDNqsD6HSdqMSYIMJIxU5clUbSb8tosl4=;
 b=Ks1mugqbY3A3yf5gfO8yDdfEt6d3YKanYCNkrNzuoD5aDQw26V3wsc5CbM9hSvGlOhZGJuuQzziY9ezFHada+6IxLYO6BPhxkrs20qN5L+UVUlGDYAbYY2l5RYKMoJV6Sco4MToqiKMq7eQL8Rk1hQ8EdMCF1M82ldS/QTUhdq+wGRGbpXOL16He6eHkD0cX621HotAuMXSojKmEfiS2Px4Nwwm9u75AuYHPnOwnk4PYHucVeeplwcN39toq7lBUyb0LD+dhsQ/FGz8BffGS4MkOfmhY3SAAEyrZKNJNCtQ0irGEmw6X7lJGlP2b2tnSWQVCzJMSnyBXgPmPF7Ohwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by CH3PR11MB870661.namprd11.prod.outlook.com (2603:10b6:610:367::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:26:13 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:26:13 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Florian Gnan <florian.gnan@outlook.de>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "jikos@kernel.org" <jikos@kernel.org>
Subject: RE: intel_ish_ipc: LOADER_CMD_START rejected (status 10) for every
 available firmware image on Lenovo ThinkBook 14 2-in-1 G6 IPL (Panther Lake),
 Zorin OS
Thread-Topic: intel_ish_ipc: LOADER_CMD_START rejected (status 10) for every
 available firmware image on Lenovo ThinkBook 14 2-in-1 G6 IPL (Panther Lake),
 Zorin OS
Thread-Index: AQHdIngYBiXAguZU4EO3kV9VirluRraLmMEA
Date: Mon, 3 Aug 2026 02:26:13 +0000
Message-ID: <SJ0PR11MB5613CE62B68CA4AD9B1ED33693D52@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <DB8PR08MB5306324DF304521067B4DC72E5D62@DB8PR08MB5306.eurprd08.prod.outlook.com>
In-Reply-To: <DB8PR08MB5306324DF304521067B4DC72E5D62@DB8PR08MB5306.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|CH3PR11MB870661:EE_
x-ms-office365-filtering-correlation-id: b6d02435-1c69-4d61-4af3-08def10696c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|5023799004|11063799006|3023799007|38070700021|6133799003|10067099003|56012099006;
x-microsoft-antispam-message-info: NsMZud4BMZRl9g90j9nOvSk0CDaAO6WOvYbSsejuDBHLCo0Zn40VnHntGpEgmSwnx6OsBXIKv+KK9Wdf9xsLN/EOEthSa+ZeXezCKoyh0YEIUE3tACTSnNzL1biI4hyh3lBIOeB+TM+mYZNOrA7KtV1UD6O2SfZQsP8eNmj8pU3D0PwZRWs8Bm3y3FEHsimoR1oTGhe/K2pDSiODIjWVWmrhTpjBpSiY0hmRsT0VfO9A2zJp2G56twD+VK/DSwEvtN5GOWz4/01KUtQl5AkYGGunM0TZB0Xfkr8JjXodcDs5Un4dB/uz6AeV0JJVcVejRa/35MBWgASe5uGiqgbVe3unPpNaUe5tYTCqCZCsqmsibKQGV1dZulaRUV6+shXvGlSMZWFCwGG8tXL5rtJixN+IuSxzXZSadjbzNZCbDueeyBWYP2WhFkedvbzDyHzSxxjMnPY09nV6tsh2spvOefquPgKS1izne3LsmKMzRUdlkOq+xzWnpesAjv6GTk4lHjuePCaACwH3nQkz3049wMebHA3jRmshMOXcUP/lKc98nef2quMB5gQFyO3ygUFqTUxr7OV6w95AxSWNdzyq5YBU5/2svICtewj1j3rApNP1i8mzPWCUj+gvXlbn0MwXPUML/JsQ1lr2pXM+tIJNwKiun1pJZo6Awsw8OEE1zEVNSPVn7vZTOGlCDgjZqRmOOCzCDfQl9TLZE0fGbgNiW7PPbYI/IiEpaUJoDRFX6S8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(3023799007)(38070700021)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tjM8LHyobi4huEk+dZ4cZP+VJVajgwGaone50/qSbsYiDtGdwEZIjYEk/U?=
 =?iso-8859-1?Q?cksqsaemMd9J8shhyfFh04x2QK6tm2d3VWuGkhfudXtGfROJmA6k+27gsj?=
 =?iso-8859-1?Q?c1wkM4xha4+hqxB5v6gTfgxTA0CS6zTU/v1i+7kH5f/1xBcvEjclmGDPgy?=
 =?iso-8859-1?Q?nyOSEeP6YaiQWX6dnWp09TC0FN7Sh40Kl81N3QIRF3ee3dzjoG0ggmJ932?=
 =?iso-8859-1?Q?Ml2g5rYa0Vp67qj41MCqwKJ2Sn/+JKPtJWo+y6nHrmJaZ2iYrCN6OMTQ7y?=
 =?iso-8859-1?Q?pwa4NGw8SOJve41iLc0s08uWGo3nV9hNc7l8OSSylY5b2ZrxaHGxCbIef5?=
 =?iso-8859-1?Q?ckd9m+oqUoRgYtcY6UGjUrcwX5FStAiUcTJRNkT8IMoRRa93QYQU5zu8vf?=
 =?iso-8859-1?Q?SaqPhpcADbrJAqhPVRFC6YJc3Ddo8S7AWu+ysdx12jJ3/ul+omYE+orNge?=
 =?iso-8859-1?Q?uXDKyonYu4QsX76DIz1k0LQl2xlt27C3dhyDDMQByGULAffwXHCy+hCdkv?=
 =?iso-8859-1?Q?NVisa8AThRh714mvLkBBAqb8PmIOcP6jD1QRh/o4FkPMPIKKb1Oh0D3BN0?=
 =?iso-8859-1?Q?9ziDr4zv8/nTvhqimEPkISNOofBxHe4MFeCazP/ieJ0pYA/dCqb21i40vy?=
 =?iso-8859-1?Q?ZHPcvPZCLsrgS4oGA4avf8VJ5dP1eySTXasizKieZPlv0fhb57SdDDNUGC?=
 =?iso-8859-1?Q?qK6kThb9qXXqXW3Qre66FOqzjwGRt8BRdsfqNtDXvMtSAPHtvJql6pZLfh?=
 =?iso-8859-1?Q?zjkHh7YnvC9E94615Ob4JmB5zNzygFbN1qwfbsZiwfJEpkytncOJqGe6lB?=
 =?iso-8859-1?Q?sOKXIA4aQPo2GDmI+Kb815gsH6q9eOUfmZkZQCa1654zOzbab72+RknWQe?=
 =?iso-8859-1?Q?5Y5cFjLWg+xXytaFSv0qE8svszbZDqSmdYJ/0Lc87qLqVi6B82/kVzj7Xe?=
 =?iso-8859-1?Q?Go4F56/pliAYCMKSiLaqW+4i6e30SR1xHi5GTnC2yzmtgOhQ4f0prjKawk?=
 =?iso-8859-1?Q?4HbEWqizTOZVk9yqno390kxQZqnJLRKMrU6JhVtNNAhVLoItAb3wFc7/t+?=
 =?iso-8859-1?Q?dl8p6xC/4ANg542Z+mCe1GW3ZDTLY8I3mnaSP9XfbL3yD1Sd2KJvkp+KIn?=
 =?iso-8859-1?Q?bdAruFp52PIwUpFnf69EMj8OVJMlPSLbeJD6vntTiVKXbKU5FGDY2qZRl7?=
 =?iso-8859-1?Q?LaQ9N0fP1egVmPfbkL7v4w7v/kyZZF+bHFCsG048cihaOXexwdPzhOb2mW?=
 =?iso-8859-1?Q?G4ZfjCIKNZ7g4EcRpFv5njoxiIoTE8GNlZ2r227CIqGQLV/ionSii6/rcl?=
 =?iso-8859-1?Q?LsiwUFKOoD9GXGUEpZ+p2jvEBoS3Zk27tllzYUjkHDs6QFXU2NrY4NIsjz?=
 =?iso-8859-1?Q?JPdKZ6Fl7luCPzcGTMMHmQUNOGP5RJ9y5TcZXdM6QGMrHlz0euwyJlGqY3?=
 =?iso-8859-1?Q?v+N3Q4BM0WRZWXSlvTGMIgKVwhmSmJGwk6ILNxMfG+rKmQEJ6w58TfSr/D?=
 =?iso-8859-1?Q?jlno2MXDZhHGdsjuH7Kh/q+Zk1SdMwMYMPqNy9d6xXowlTytXnc51SUK+O?=
 =?iso-8859-1?Q?LccljURjSbUKlf3lywi/n+WX7QaFNw/0d9sa6LIpwLkAuHF8qJdsw4lYZx?=
 =?iso-8859-1?Q?hhesE+9T/5gIGoysFKEmAKK8AKTl4swBHrA9HDYSJGIj0CfTEcdfy9Cnsi?=
 =?iso-8859-1?Q?cc9h+T59PX7hBJWrHBqpEriPGKPxdXg/CGnCi0kPgdpW6sBv858JnsyrF1?=
 =?iso-8859-1?Q?F8ivgFD8t+xkp0aBImcKWfa0xA/mrsglRDB9VY1oqgIYgK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Baf9J4tIGsUZWO4nOtq5N5ivxMAHC1JvWYOWpsOzBbTYCAc+UBpBZGnv4zFZCrryzc8pr5hpUBc/02H9ngEGyH0pFSyNm12PtK3epI7zshaOG6mJFF4Z/9W2I1UgecRQ6vvAYThOfMGx+sDOg65vfGBF/AiUmXX7buvJ0NFRJXhCsxFegKh4MD1c4doZG5G0lbgzQcQC4aytyFQcd7F3cLMtvNiL5TtgMrYPi/OCPNwqAvXSXHyAwc2YjAUmP7KoEq3RF6NIt7IVNatRyJAtAtWN/a2QdyC/1EljdameRGNGPjdAK/98DZagtg6DTbk3xfLrEgyu+HbjNGiTK3NkXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d02435-1c69-4d61-4af3-08def10696c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:26:13.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfCvP/owOMvV7YygHeKWrxRJODrnyYncbJLSGjdzDxh+m65QcTSuZOI0kFZyzQ6ZJfa/rF9y6mih7Bjoo1iOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB870661
X-OriginatorOrg: intel.com

Hi Florian,

There are two kinds of ISH main firmware images:
- Intel-signed images, such as `intel/ish/ish_ptl.bin`.
  These are released by Intel and carry an Intel signature.
- Vendor-signed images, such as `LENOVO/ish/ish_ptl_lenovo_X1_2026_5.8.1.77=
82.bin` and `dell/ish/ish_ptl_39ceeaf8_581.7783.0.bin`.
  These are customized by the vendor based on Intel's release, then signed =
and released by the vendor.

On Windows, the same two categories exist.
- The Intel-signed image is shipped inside IshHeci.
- The vendor-signed image is shipped inside IshHeciExtension(not sure).

> Q1. What does loader status 10 mean exactly?
It means the firmware image is incorrect. In most cases this is a signature=
 verification failure.

> Q2. Does the ISH bootloader version matter?
No. There is currently only one loader protocol version, so the bootloader =
version is not relevant here. What matters is the signing key the bootloade=
r expects.

> Q3. Does the Windows IshHeci driver transform, wrap or re-sign the image =
before loading?
No. The firmware image and the way it is loaded are the same between Window=
s and Linux.

> Q4. Is the fragment ACK purely transport-level, or does it validate conte=
nt?
It is purely transport-level.

> Q5. What is the path to get one for the ThinkBook line (product_family CR=
C32 324d1fb6)?
If the vendor has not developed a customized ISH firmware for a specific mo=
del, they will typically use the Intel-signed image instead.
You will need to confirm with vendor which image they use for this machine.

Thanks,
Lixu


From: Florian Gnan <florian.gnan@outlook.de>=20
Sent: Sunday, August 2, 2026 8:16 PM
To: linux-input@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com; Zhang, Lixu <lixu.zhang@intel.com>=
; jikos@kernel.org
Subject: intel_ish_ipc: LOADER_CMD_START rejected (status 10) for every ava=
ilable firmware image on Lenovo ThinkBook 14 2-in-1 G6 IPL (Panther Lake), =
Zorin OS

=A0 Hi,

=A0 the Intel ISH does not start on a Lenovo ThinkBook 14 2-in-1 G6 IPL
=A0 (Panther Lake). LOADER_CMD_START is rejected with status 10 for every
=A0 firmware image I can obtain - four images from three independent source=
s,
=A0 including the OEM image from Lenovo's own Windows driver package for th=
is
=A0 exact machine. As a result there are no IIO devices, no ISHTP bus
=A0 devices, and the convertible's tablet-mode switch (lenovo_ymc) never
=A0 reports anything.

=A0 Windows 11 Pro was installed on this exact machine immediately before
=A0 Linux, and there the ISH worked completely - tablet mode switching and
=A0 display auto-rotation both functional. So the hardware is fine, the ISH
=A0 is not disabled by the platform, and the same bootloader (5.8.1.7768)
=A0 does accept a firmware load under Windows.

=A0 This looks related to the earlier report "intel_ish_ipc: loader failure
=A0 on Lunar Lake" [1], where Lixu Zhang explained that status 10 means the
=A0 firmware file is detected as incorrect, and vendors were asked to
=A0 upstream their firmware. Here the vendor firmware is available and is
=A0 still rejected, and so is everything else - which suggests the problem =
is
=A0 not "the wrong image" but that this ISH accepts no host-loaded image at
=A0 all under the current loader.

=A0 System
=A0 ------
=A0 Model =A0 =A0 =A0 =A0 =A0 =A0 : Lenovo ThinkBook 14 2-in-1 G6 IPL (MT 2=
2AR)
=A0 DMI sys_vendor =A0 =A0: LENOVO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(CRC32 53c4ffad)
=A0 DMI product_family: ThinkBook 14 2-in-1 G6 IPL =A0(CRC32 324d1fb6)
=A0 DMI product_name =A0: 22AR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(CRC32 308e9054)
=A0 BIOS =A0 =A0 =A0 =A0 =A0 =A0 =A0: U1CN07WW, 02/26/2026 (latest; nothing=
 newer on LVFS)
=A0 EC firmware =A0 =A0 =A0 : 1.7
=A0 ISH PCI device =A0 =A0: 8086:e445 rev 01, subsystem 17aa:3843, driver i=
ntel_ish_ipc
=A0 OS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: Zorin OS 18.1 (Ubuntu 24.04 base)
=A0 Kernel =A0 =A0 =A0 =A0 =A0 =A0: 7.0.0-28-generic (Ubuntu HWE 7.0)
=A0 linux-firmware =A0 =A0: 20240318.git3b128b60-0ubuntu2.27

=A0 Log (booted with intel_ishtp.dyndbg=3D+p)
=A0 ---------------------------------------
=A0 intel_ish_ipc 0000:00:12.0: Going to wait for ishtp start. hbm_state=3D=
00000000
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: Try to load firmware: intel/ish=
/ish_ptl_53c4ffad_324d1fb6_308e9054_dd59d3b3.bin
=A0 intel_ish_ipc 0000:00:12.0: Woke up from waiting for ishtp start. hbm_s=
tate=3D00000003
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: Try to load firmware: intel/ish=
/ish_ptl_53c4ffad_324d1fb6_dd59d3b3.bin
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: Try to load firmware: intel/ish=
/ish_ptl_53c4ffad_324d1fb6_308e9054.bin
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: Try to load firmware: intel/ish=
/ish_ptl_53c4ffad_324d1fb6.bin
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: load firmware: intel/ish/ish_pt=
l_53c4ffad_324d1fb6.bin
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: ISH Bootloader Version 5.8.1.77=
68
=A0 intel_ish_ipc 0000:00:12.0: ISH loader: cmd 2 failed 10
=A0 (bootloader version + failure repeat three times, once per retry)

=A0 LOADER_CMD_XFER_QUERY and LOADER_CMD_XFER_FRAGMENT both succeed; only
=A0 LOADER_CMD_START is rejected. "firmware loaded" and the FW base/project
=A0 version lines are therefore never reached.

=A0 Firmware images tried (all: cmd 2 failed 10)
=A0 --------------------------------------------
=A0 1. intel/ish/ish_ptl.bin from linux-firmware
=A0 =A0 =A05.8.1.7778, 920064 bytes, manifest vendor 8086

=A0 2. OEM image for this exact machine, 5.8.1.7779, 920064 bytes,
=A0 =A0 =A0md5 98b8ade6fe26d777f639a5db96eae6d7, manifest vendor 8086.
=A0 =A0 =A0Extracted from Lenovo's "Intel ISH Software" driver package for =
the
=A0 =A0 =A0ThinkBook 14 2-in-1 G6 IPL (package version 5.8.56.0), file
=A0 =A0 =A0IshHeci/x64/FWImage/0004/ishS_SI_5.8.1.7779.bin. Valid $CPD/ISHM
=A0 =A0 =A0header; contains the sensor descriptors "Tablet Mode", "Hinge An=
gle",
=A0 =A0 =A0"Simple Orientation", "Physical Accelerometer", "Physical Gyrome=
ter"
=A0 =A0 =A0and the chip names BMA422, BMI260, BMI263, BMI323, KX9xx.

=A0 3. LENOVO/ish/ish_ptl_lenovo_X1_2026_5.8.1.7782.bin from current
=A0 =A0 =A0linux-firmware, 858624 bytes - same vendor, newer, and from a
=A0 =A0 =A0convertible (ThinkPad X1 2-in-1 Gen 11).

=A0 4. dell/ish/ish_ptl_39ceeaf8_581.7783.0.bin from current linux-firmware=
,
=A0 =A0 =A0776704 bytes, 5.8.1.7783 - the newest PTL image available anywhe=
re.

=A0 Manifest comparison of the four images: all carry SVN 1 and VCN 21, so =
an
=A0 anti-rollback / security-version floor would have to reject all of them
=A0 equally - including the one that demonstrably works under Windows.

=A0 Ruled out
=A0 ---------
=A0 - Firmware naming. The cascade behaves exactly as documented; installin=
g
=A0 =A0 an image under the vendor+product_family name makes the loader pick
=A0 =A0 that one and stop. Both the generic and the specific name were trie=
d.
=A0 - initramfs. The image is present in the initramfs and the log confirms
=A0 =A0 the intended file is the one actually loaded.
=A0 - Image origin or signing. Four images, three sources; three carry an
=A0 =A0 Intel (8086) manifest vendor, so OEM-specific signing keys are not =
the
=A0 =A0 discriminator.
=A0 - DMA address translation. ishtp_loader_work() hardcodes
=A0 =A0 LOADER_XFER_MODE_DMA, and the ISH device sits in an IOMMU group, so=
 I
=A0 =A0 suspected the ISH was reading untranslated addresses and assembling=
 a
=A0 =A0 corrupt image. Booting with intel_iommu=3Doff changes nothing.
=A0 - BIOS. No ISH or sensor-hub related setting exists; all 31 attributes
=A0 =A0 exposed through think_lmi were checked. Secure Boot is disabled. Th=
e
=A0 =A0 BIOS is the latest available.
=A0 - Kernel age. The most recent loader change (043251b2d, "Add
=A0 =A0 PRODUCT_FAMILY-based firmware matching", 2025-12-22) is present in =
this
=A0 =A0 kernel - the family-CRC names in the log above prove it.
=A0 - Stale state. Every test was done from a cold boot; reloading
=A0 =A0 intel_ish_ipc leaves the ISH unresponsive ("cmd 0 failed 6"), so wa=
rm
=A0 =A0 retries were never used for any of the results above.

=A0 Questions
=A0 ---------
=A0 1. What does loader status 10 mean exactly? The values are produced by
=A0 =A0 =A0the ISH bootloader and are not documented in loader.h. Is there =
a list?
=A0 2. Does the ISH bootloader version matter? Here it is 5.8.1.7768, older
=A0 =A0 =A0than every image available (7778...7783), on a BIOS from 02/2026=
.
=A0 =A0 =A0Is a bootloader/image version pairing expected, and if so, where=
 would
=A0 =A0 =A0a matching image come from?
=A0 3. Since the ISH demonstrably works under Windows on this machine: does
=A0 =A0 =A0the Windows IshHeci driver transform, wrap or re-sign the image =
before
=A0 =A0 =A0loading, or perform any step in the load sequence that the kerne=
l
=A0 =A0 =A0loader does not?
=A0 4. LOADER_CMD_XFER_FRAGMENT is acknowledged even though START then
=A0 =A0 =A0rejects the image. Is the fragment ACK purely transport-level, o=
r does
=A0 =A0 =A0it validate content? In other words, can I distinguish "the imag=
e
=A0 =A0 =A0arrived corrupt" from "the image arrived intact but was refused"=
?
=A0 5. If per-model OEM firmware is required after all: linux-firmware has
=A0 =A0 =A0LENOVO/ish entries only for ThinkPad X1/X9. What is the path to =
get
=A0 =A0 =A0one for the ThinkBook line (product_family CRC32 324d1fb6)?

=A0 Happy to run any diagnostic patch, enable additional tracing, or dump
=A0 further data.

=A0 Thanks,
=A0 Florian Gnan
