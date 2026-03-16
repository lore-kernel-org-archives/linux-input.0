Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E220ED
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773632309; cv=fail; b=V1TGN3yDLAri/HGeritJS0mQusiyKENs89sbdbMCRAWwYcYe73w4iQ0r0aIti0urggxnxjQ1c2AlZ8WcoeNuZa15RvW/yd7j/OgelCEx8sclXI/B6EdEAnujjmaUOMDLAUkYzkOS74KKyZZZ6bHRzSmDPIw2Rcj/qkS/ylf3azY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773632309; c=relaxed/simple;
	bh=6P8WKqmFL1hcsYcU1R8YtomQ5U7VNi29xJsCJOaFpJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4J7Wihsnyo9Bg/SZXkhDM61U5KPT2wapspnwlOHuTJ/Kxp23oFGBtN0qZXM8dn9m5Vazs76ED1vzO9sc+FOHxygBYXHd+HmFcMB96TDrQ8qKIJdDh/UYzxjepWYRWxqdYKY/ffNaa2M5xftGTHhP4ypkTQ9S9g+eicxUGR3S2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrWfPEf9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrWfPEf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773632307; x=1805168307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6P8WKqmFL1hcsYcU1R8YtomQ5U7VNi29xJsCJOaFpJQ=;
  b=WrWfPEf97QKEyy0Y9eMk6bZWYL1TKik7lJ+Vg5z4aKyvOemQ5Sg0uBOX
   FVDndFWGOUccPDOIdnYyW1abZ9ZR4v6wySkAOoR2PlKgH5DJmDEucdWSC
   aujmTS1GhOU0Qd4DIJZv+MgazAVlhL2vcEQm5k4rm1Kse3bIvcTLUgoT/
   r3MX1aW8h5U3kolLrcqDiDuh+Hxdr/wvX01Y27bpkwX4GabKgAmNKpG4h
   tDHh1TgULp8LVsX6f4k7gI/FZOg+555yYEOoxoykzQvz4W6ZUiK/ry2jX
   NwckeBMfEMFkSybrcnxRczyGTKsEicujKvh1HIvj5Ni/069JolEMDSdTC
   Q==;
X-CSE-ConnectionGUID: 6ebyLKBCRRaXRmwhhpHwbQ==
X-CSE-MsgGUID: PutmL2KQQVGT2B+kbzYWrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92028635"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92028635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 20:38:27 -0700
X-CSE-ConnectionGUID: RR3ZYpZqQZW2as9cT1UH6w==
X-CSE-MsgGUID: xxJlW0KvSiG3frcbVU3bCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226454905"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 20:38:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 20:38:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 20:38:25 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 20:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiDVEWQSWMPPPO/70VyXLBMrRptb1PMNN46H8TaxMcmatKpVHI8JqI/4EK+xPipPkALLhaqYmcxIWqGh1L3jZlc0c+zyYxnavqZrhBGZanTbr2NULBU7Q7dJzpd9EhixJa4RI8B7c/qnmHYnhEZJgpIUFcvai3XJHcbPD94zzIL1BLwKrXUXOBojV+I8XL8CYtIQREiZyzG9ed16HV7aOy4ok7ObS1KVI/U+hDwi+tIfeZdQLeexnoq905XWCprIrsxh/O02RCGdCVmRbAa/Mcca0GvB153WpNFLafjIJPMUEaWErGC2ynjKXWNWyv+4r5JLIA/2fDbOs6R4yUbSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HstMdsXWp86Shb8NIlftAkI+4oeaAR8KB4AP7g5Lq4=;
 b=HPkoyC1ppwRbS8deOVtZbc9t288RNiSaeR6cCgwb9D42qtR1cTifHXXU9HWdlp53OkTknOQCY0jfoNg//B2mI999ke9mNb/9iGfBGgm0I18nk/zrHOTsuk/QV4/83awrSleXcykZHS9TIK2iAsZdiWyFy92AHDXJahEDiSteFSjz0Po5yupC0g7xJlvsPKoyUQ/qoOxvpU97K9Wfr/jEaJ9AEP7VXiW0ValKnC9YAJ3fcKaSqmT28WoEdNuR9+CRoaGLRK86fz/jP3Rd3yTd7SI24BiHkuplrGLm0KWkvQ/Vw4I6qCJB5uCTh5pZNKB4ysZA/nQ11wBjcvonyoupSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB6331.namprd11.prod.outlook.com (2603:10b6:510:1fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 03:38:18 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%3]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 03:38:18 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Daniel Schaefer <git@danielschaefer.me>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>
Subject: RE: [PATCH] HID: intel-thc-hid: Set HID_PHYS with PCI BDF
Thread-Topic: [PATCH] HID: intel-thc-hid: Set HID_PHYS with PCI BDF
Thread-Index: AQHcsu7dFf3ievUUekGmAp36FTyTd7Wwhpuw
Date: Mon, 16 Mar 2026 03:38:18 +0000
Message-ID: <IA1PR11MB6098CBBFB1A9195E394F7D63F440A@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260313133925.35740-1-git@danielschaefer.me>
In-Reply-To: <20260313133925.35740-1-git@danielschaefer.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB6331:EE_
x-ms-office365-filtering-correlation-id: 8f2b2ab7-5233-45d6-81fe-08de830d76ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: nWCNC103FS7qO0w4csd0M1w15PjVxmZ1S7S0z09jF28Yl21+4sN7lmMVadxWLXe1hRcCrd98Ut22oSPuzIuMrRfnBV4SuzuPhqKmzcDfMXp49czN4UQ1k2g26xLVuPMM2hpmLaI6o427JPi7hgsjqW0KSKIMZMKCaUTcoqmx+Mwsuufu6n/nlCtfB5bqk2CqN3Pqg1hTsR46S/Zxj4omHQ/lpWnxr9BhaGcKs/oDjOHrQsLDXB7oc1wYSdMp92ZdorIM/dKLWGgVmffkEcUO8WkLnFy5nzBxA3vq30i0vCkKN44ITS5YVf/tphqdDSVhW89zAVQZJF3hOixbMMSofWYRXY06j6FhRJwAVv/3j+wca0kAnj+WyVeBahbQKq6ZL09DjrmzLkUhECDL4BuzLB9yeLzbgEciYnkYFTBVX1lVTDG2BlYowvJp2mTOMuUhVUud6WhU2tvIoA9NReuqg14YCzsKZPgpFrM7dv+P7wGTbD5e3fy9PobfTC3QskloyCp0wE6OB0irCHECUBJdSjSvKznJKMQLCy0tco95lqToF3l0oOYrKgtmReP0bj4cPROD79PCDIYSMMMNJDkhTPDgP5Byy5LQIeb8rMSm0AJBLHUC5c+jOyOE2tRCZLdvg2lCzNPWNC8RPYKqRoOkw+X63JHDKb1zhETMCSfOZ7zthDeJsyOziQJ/TbF2UFc++uVbtuqsV20Q/buF/c83icxUa93QiQ/a8h1CWAlFr0tNu4MeE8iCOaPHA1tyd6n7GIA5F+zRr5431UFpQ6cf6uIr5lKjkmv3FQAK2hFk128=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fdKot2nShYHTwapbpLqwKGPTNTwclqPEiDZ6C2mXhIRKC2klttsgu4E1QN1t?=
 =?us-ascii?Q?ubOIthp25910G9TaVWYNXt8Bj/wuI9rgYVfYBhKXjKDdY+NPdCUq4s7XwaW4?=
 =?us-ascii?Q?srD/LeNlINSV5rhQsjiymY8/wb88Gt6fH4t3LtZW3FDsoiOJ84g2ShvNrIi8?=
 =?us-ascii?Q?P2JOujUKZBTOSfU9Hw+/+Lv/ZAJa5uog4n15rQf4BmrC6czSqvNEmoTUXvjo?=
 =?us-ascii?Q?PenNpF5yLP/gBJ8GwhgyXLq/fAn32e4RiFbDl9CXeH3Byk4dmw9QwBO4cKQQ?=
 =?us-ascii?Q?yVYO2O8jLWMRaNQGSND7UTy0s9q7S57YSEZP++VLESDy7Bow3SwHO3XOUhi0?=
 =?us-ascii?Q?CHl+mVOjuF8NHXvaoi/e47QyzgBhUdaKQFwZsMDBQ6HKM4vYaBylugHgZ9wU?=
 =?us-ascii?Q?SCZ5EcaBulnAU+U2lEo/l/tU3SP/b8oMeuTBnMtEK0dbuGM+afOUogoymNd7?=
 =?us-ascii?Q?3PXWSk5O7mgdwZSTVtG0EpoLIZfkoqYQZsGj/t5C7ugcgwm5KRJI+AzeMU//?=
 =?us-ascii?Q?KgPitbOYDFFLzk0OfSPK+4svuJ2FKTYDHmzlXkiHT68rh+2OCrtn44dFnrtl?=
 =?us-ascii?Q?lsAGt9BnD/SnG0W5PcKEK/zJ1JDexAIlTUq0IFpVSyB+7r4/OcNy/Jftu6Lq?=
 =?us-ascii?Q?3SxXFgDKn8AZIBKCJaiiCwbYjEh/l9+cpoixWpwUFCwshCyEasjNtygFiXeb?=
 =?us-ascii?Q?gVm8g2831+KMOpvIqfItd/SGvTW10ljydLFAUNWpWmXxjVtFdShU7oHt8aN7?=
 =?us-ascii?Q?GVENoT8SsLXb7KSGWRVYlGuZaj3F0JS8Ch3m441pnAbFWaVTMlCeItacTjVd?=
 =?us-ascii?Q?WXnl6eczDA7AXh22HPoDzRtb2UvboT+tzLZtFUrvbktxBQ/82wJPbfeMHKMT?=
 =?us-ascii?Q?/+b5Ve0/Xt4Xs3kPLWF5GzJpyGEdZkcz3LeiCS7pNAwct8wGmVSfTNBIozao?=
 =?us-ascii?Q?MUFFPHfmCImGYt3FzFcDRGrIJ5cGRz6pKZzoGW1NFGzAEjJZy4R0H43BNyOJ?=
 =?us-ascii?Q?SX91MlpeTKvzzosRIqkNnFMHTwK4L+IGWR/a1I/lvBIY5vfxqdG9emyn9Mq2?=
 =?us-ascii?Q?YfCQ1S7Oqhr+gx2UK6+j+TMA7Y0CX1vzmkvI4OUAI4xNwYxHGk0j/NfOR0Y3?=
 =?us-ascii?Q?42Jl1Flj2rddx+LPtzUu6wZKIjtIW/s8BTloY8xXLbQkptTEQ6xVzyAefVHq?=
 =?us-ascii?Q?pkb39hAcHOls9b9lo4CwBq3RIsGXmen8QsE+PGRPg11cE9BR8eFw5+B2a1P7?=
 =?us-ascii?Q?uRLEXqW3J5cG2lAMjzOu/qKz6qnHiepYUmHcK+5Lk82iiIgp6m8KQ+EOfRt2?=
 =?us-ascii?Q?rNs00aR+jbm+dMxJsA7GaZgTADjDo5ZOlfjCA0LWKsK7fHun11CHE0hjjhOK?=
 =?us-ascii?Q?0Z48f9xw/qSJBqQMTRK5/Kns3SekGuLYa/4y7creu8OAzEAe2pgYTdUbNAUD?=
 =?us-ascii?Q?BfnEPbkZGTC01smtY8rx4t0hO0SDeVDR8O0djXj7mKo2ONVoxQ5sk97vGiWa?=
 =?us-ascii?Q?fmNDstMJ3Cqcb04qU6od3E55sYATtgGVuNBSC4UumHCJdJAmy/D5aQVSaHZB?=
 =?us-ascii?Q?XLh+cRITdiediIZaEEh0TXYnaLam75Vt9taLerjpBuzxqzgt5MmVJ4FTvcL1?=
 =?us-ascii?Q?eK2mpFBIREQQ68NWIyjdqSt4Vm3YLYrQUty73GL26TBNSjP00p2JH15+w79h?=
 =?us-ascii?Q?vDTZkBtKsu8mOfDbh6LWMm3JlEYtklfytKnlxGf3y346PwQU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VfOlHJZS2hfCEv/23dpO1jsNAt53b4GZNxhfX6tMrFznGAPFAtnmzM9J6bOeFGnfKGLS+bVAP+49GaalrBdkO5G6LrTKwGTh3WfgeLC3ldnsUzlZnarWKG7RzjjEbkRHkmmMH80FYe5dwsd4D664Bi08Ua+iHq8ALEDqk6fwEweHFh7SUxWeMK15ww3JBA7bAbbDv2bNB7Q0SMaKhEfE+ZC7F0WZKOJVZlzI6C/xOXkxEqe2HNdQaMjbd505fZ9YqO3HLZ33EUr+S050Ra8UX+CIpKrPsUk9gJAerBbDDUnkii/P0Ds42NZx7tkVZ4my72fq6zH7ZL7uOabcVX19lA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b2ab7-5233-45d6-81fe-08de830d76ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 03:38:18.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7j40RH9Ryb8tUwthnLWBcENGIRhSa+0V5UlLUzpDKKjvEHa7LeXbqNNOkEInRgfHbpv9YKw8ft2qhsfkAf/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6331
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Daniel Schaefer <git@danielschaefer.me>
> Sent: Friday, March 13, 2026 9:39 PM
> To: linux-input@vger.kernel.org
> Cc: Daniel Schaefer <git@danielschaefer.me>; Xu, Even <even.xu@intel.com>=
;
> Sun, Xinpeng <xinpeng.sun@intel.com>; Jiri Kosina <jikos@kernel.org>; Ben=
jamin
> Tissoires <bentiss@kernel.org>; Sakari Ailus <sakari.ailus@linux.intel.co=
m>
> Subject: [PATCH] HID: intel-thc-hid: Set HID_PHYS with PCI BDF
>=20
> Currently HID_PHYS is empty, which means userspace tools (e.g. fwupd) tha=
t
> depend on it for distinguishing the devices, are unable to do so.
> Other drivers like i2c-hid, usbhid, surface-hid, all populate it.
>=20
> With this change it's set to, for example: HID_PHYS=3D0000:00:10.0
>=20
> Each function has just a single HID device, as far as I can tell, so ther=
e is no need
> to add a suffix.
>=20
> Tested with fwupd 2.1.1, can avoid https://github.com/fwupd/fwupd/pull/99=
95
>=20
> Cc: Even Xu <even.xu@intel.com>
> Cc: Xinpeng Sun <xinpeng.sun@intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Schaefer <git@danielschaefer.me>
> ---
>  drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c | 1 +  drivers/h=
id/intel-thc-
> hid/intel-quickspi/quickspi-hid.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> index f9fcb398673b..8075992e8732 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> @@ -127,6 +127,7 @@ int quicki2c_hid_probe(struct quicki2c_device *qcdev)
>  	hid->product =3D le16_to_cpu(qcdev->dev_desc.product_id);
>  	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "quicki2c-hid",
>  		 hid->vendor, hid->product);
> +	strscpy(hid->phys, dev_name(qcdev->dev), sizeof(hid->phys));
>=20
>  	ret =3D hid_add_device(hid);
>  	if (ret) {
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> index 82c72bfa2795..91d5807b4a83 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> @@ -118,6 +118,7 @@ int quickspi_hid_probe(struct quickspi_device *qsdev)
>  	hid->product =3D le16_to_cpu(qsdev->dev_desc.product_id);
>  	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "quickspi-hid",
>  		 hid->vendor, hid->product);
> +	strscpy(hid->phys, dev_name(qsdev->dev), sizeof(hid->phys));

Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
>  	ret =3D hid_add_device(hid);
>  	if (ret) {
> --
> 2.52.0

