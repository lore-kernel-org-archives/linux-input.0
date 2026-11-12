Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473571;
	b=tCcwtrSX5nafQh3TKW7GbgbC+PpwCulrSg3z21RFnoJqTCCztRn11+bwH9P8z+m4eihw
	 x2Nmwba0ImEPzcHTGRA0Q9d5ghBpm8oCEDtlsMbGEzKDdNhikJ3LFLp3yrZWhjmlWkwJY
	 cRH9nAzuzSl4bHaGt2MYcO3t34hnl1coBgj+bPk+Uk+jNY90O1i4uYaCwE0VOChlo6V1/
	 d9fzwEpNoGuRHPDVD++bstQfsq45XTaSyjZITVVue+H2jk5q+t7MpRSm8gl2OgCtY/z8C
	 gndFXqm6OEUDbVhBgx8adaG7yxw24DO5KbjvF46X9bWy4jBqGXbpM8HgPEsggVqRPjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=OxQ5x2Qx9FEmnWa6MRVlR2w+UHK3RcpxZVV81ohc54g=;
	b=OMa2LrM9loLO6Y9VgS2BfIyFcd0C3CFDwDtWBaMLYMQ/m4DOZ0wyt7ZdkCW9jQhOMAbh
	 GzmdIn2Ww2lscolN5s4fXSSi3WdfLOpDZkcMk6DuxmesbhfnxfZz+TTJlpfs8zgfElPGe
	 /Nbt0b8eapFnHn01Zlwk9StPDFVaE/nz0vs/L0KKU3fzCFgLuF0WqSpcwAOciH629fi1h
	 opv2hUtvx0dsZ5EwK/eZ8PZdDOY+zOi0FZMoY1dO2We3BlmMI0fWkEp8ZlLbKcXd8f6j8
	 u/cmaI/AsimvIsveHV7hW2uMZz5oqGoxiFw7DMWkKkNbV92uEkVuII/uNq4qLiVAr0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kklsJQDY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E99606A327;
	Thu, 12 Nov 2026 08:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9E99606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kklsJQDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794473571; x=1826009571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hcUOaU8TU4wSZQuAHenYyca+Z4jEIAOP8RmINwPn+nQ=;
  b=kklsJQDYEfnGecvCSAS5jC+73T753KD4vG2yEo1uVfX1BjmFmwuZj2aB
   Tu+KDanT8ZgkK0ED6aq0T2udaeJGwrI/XIEw57Qe0yGu2s3mhjP7nX7RT
   M1RQK/R5AyP20mvb3oOqiYGGyziKJHki+6dTABgO6wx7z6Ujm0CFrRigL
   +GlgBqUAKpGFN3RiuGZco6cJ4B9BgM8yFBsG5nBugBHTNbqkckcMByC5c
   /gztuOPigVmL8XT52JC8aTRYAWBpcT2s0CcRLEXoBCchGO6KciXxYYjdf
   a3Flaaefnm/xrApszun1XrwKx9R2wMK5b8+WRm0N1XeNx6dJv1M3CLqeu
   Q==;
X-CSE-ConnectionGUID: c2tIp1AcSnOYiltn51x6gw==
X-CSE-MsgGUID: AjYBNaYWRR6PC+F0ZgSaeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3133926"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3133926"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:52:50 -0800
X-CSE-ConnectionGUID: ikcf1yRIRk2kIuIX6hBT3Q==
X-CSE-MsgGUID: OwUS7mg1TU6iCS7+ikpU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9177481"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:52:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:52:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 00:52:49 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:52:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdqYj8Bvgh21FGcL8VNFLraEBj6tjw2CWudKpfTdnSQagRZtSPhOZSllDJnbbuFnJpTPwgbt6/CumewmAkwI62IE/Ag0+HjWOGO2VAyVptLBb58IdBPf7jVjQ2MIBw+onZ1skfAebYKxGcptTReI5whXfqbVDZbnNmHOIqin8KT4sCxeOJLPLfNMQ679fb+18vn9C6C8HksRgE9IiRpfj3Iu8rMj9fBckle02wBAyI3Qdq8YWzwLBHhsU9vaLPeeYy3MLv8Kl3BSrwKA3TlikSJBHtcf9td6NkjYh0plDtAV1BLwAERMNWhH9cXyXb/+18ZlKk4ZnMy7BAhc9LyKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxQ5x2Qx9FEmnWa6MRVlR2w+UHK3RcpxZVV81ohc54g=;
 b=C0P0CF4CqHMo33KL6j8yWkK+bB6xNWTNCEOge/LrTN0hR4fJAtvd6OED9g0eT0DUsfCXgfTFGECsJJpis2xzK1euriA272tQkVG3Uo82qX2OMID25LAtFUqfYBGzikvu2Na9Q5KBep0wW5/gZ3wAABEAPM+xIPoAIpuSCUSP7EeExXwjma2BF9uOFrS5CZU1XEyWHWFChZJEHRicj5cyxfjLJvPvN5I0gCAsFSLD3puPBiGDzgWo2Tfx8K9HtXC7N7gaYOoIkQRcQDKB0ptVDVUI5IFkp9dZ3EJ+uldvGNkawiXVYtuMJgNT1MvrvZLtWsiXtz4h9WIv7B5yIBvm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 08:52:34 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 08:52:34 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ae878000@gmail.com" <ae878000@gmail.com>
Subject: RE: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs during
 teardown
Thread-Topic: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs during
 teardown
Thread-Index: AQHdcnBjhwsaaIQuE0SNnpkjlm0NubcqIWUA
Date: Thu, 12 Nov 2026 08:52:34 +0000
Message-ID: <SJ0PR11MB7704B49DFC6AAD329A8293F3F4702@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
 <20261112T063704Z-thc-v3-2-mhun512@gmail.com>
In-Reply-To: <20261112T063704Z-thc-v3-2-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH7PR11MB6403:EE_
x-ms-office365-filtering-correlation-id: 03eea643-56d1-46eb-1c58-08df409a4ba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|38070700021|10067099003|56012099006|4143699003|261028144727099003|11063799006|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003;
x-microsoft-antispam-message-info: yPuO0XNAunxiFHuaHHAZlDDeGzuVYxW0cPTjFNJ6IgH8CGagQYzXEyFVfiiL+aOWC/LewxZALT3wxZsSBsrNtI1km0Ut38FlNuecdiLiPh+Nw7F6U6W9RVCT24K6/lfzMub1l766O+cY03AVHJjxQvmXK/v67OLDO+LL7RwhExPWBCcpsJyYi6CfTK2HUO9Zf1tbqDkJNWTVChMP+4lzSNhSlvTbnUgzJ7Ik/iCcz2N3z9AQPsAInITlPSHo+TxU8KXD6E1jOQdfHkgXRZiwlQY3nqmr94soece2CrfNhYHpuN6Zqiv2nsXGDuKoHLFL11TGM6o4fZJvrY8ZStDQ8yA7JzgFiejPcyXeQia0gvF1Bf4+aQPWd7OpxOo6U9kWkFLXbaZ/5FC1sGQk306txOxRXpn/UAaPtJkQu3IRoxN2f6LPgw+icOPpjyDvtsYCebDv5sQ15O+TdUMTC/INqrzYnWipCzd1K134nMV//9zOEoT/tCdPk4T1xrC2V/nbAtstY/Iw2ZQyiEOrethzAzGZ5N8VeU5jXZsOVmjGWnypo+IJs+zNA60fcZwSPUB0tSIPhE+7mkRbY7m1c1XRb6ifwgvf0KLNWsG0y8bm5iDnpWd9omEsa/+dBHEtSWivmwHQKJPFjxznnYVR8EHGTNe3Dt2vffXG7QLs5LhcbJWXj3PjVc3O211fWRLvb2y0+OuRDvN+cHoseDld8OJg/ialx0BBGryuBC/Nx/HHEJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(38070700021)(10067099003)(56012099006)(4143699003)(261028144727099003)(11063799006)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XiClmN2fFtobzbobPrkAiQqQvLpb+uaqo0opVs2+caHlN1UaBcMim0rhJqw?=
 =?us-ascii?Q?0Bwu9tqBPuuqhBewlC9ve+rUYS2VAiPIaBTDqe95oaO2fTM9pglwYtIkIrLP?=
 =?us-ascii?Q?aD9whN/jcdxVXeckZU6RAqkZ3kFw6FhGsUsG/VwmuQ++eIfp59lpkDQD6xpF?=
 =?us-ascii?Q?F9fi4ZCYKM2N+cH3z2SnoDJpZMRIRbT01T+Gbq957FMeMUTA1Gazh+LCiRUq?=
 =?us-ascii?Q?/fJec8/x99ZpzveUPAZSFOSXnLUQEOyRaWTIgqaZHchGl83dZb8xPyPZFCvF?=
 =?us-ascii?Q?XzIoGuAfqLtsabNaQPl+QrI1tOVw73O3HQHn4LbhkzJmKDorJ6ffIORvbzdL?=
 =?us-ascii?Q?G4n5v23o+g9p/Sb6/ph4BOj0+s9d+QZiPN93Ty7oonyGD5yVyWFZogUD34h/?=
 =?us-ascii?Q?WPlMMOUxM/Cp2jdPR4aZxozeKljOxwt2/U24Mny0zml70SSqC5uPVmyUiRSt?=
 =?us-ascii?Q?7FKoJIfWTAwxo0FGLBxSYq21FJQKt3zyl/rT05Lfk5piYlyfARaUam/FgQcG?=
 =?us-ascii?Q?kOli62KGWoYhXBx3XAmC7pUyZm3Tu5sQF3Yg1Bs0MWa7A29+vDUCM79lsMsw?=
 =?us-ascii?Q?uxBXNQT6GE1/dmaLfCTcl5dqjGETvqHwClsIDIE8utdo0OnpAlL/Y19FK9ll?=
 =?us-ascii?Q?S1rNY5U+k4H6OH6H+ZbThX/4DYJYY6KReVNCCZJXyaKoPntQioj9MTWLqgi3?=
 =?us-ascii?Q?vAH7O7flbUz46VDHZPjp9WWzjyu/2obELcdR8jmrN/0rW+Bhj3AmEg1ZgeGX?=
 =?us-ascii?Q?8BUpWJlFwBMrbzcABROyngHMY3HQsXoGK4zoSfSSnMsipXOjlYIufIOXG0A5?=
 =?us-ascii?Q?DnNzZacyKfea4/j+i7GmcF6hcP6MRkfJo+yOYMQPYfPgcRZ5aOXwF+/9ZyIw?=
 =?us-ascii?Q?kSQVgR1jGfJn6hBrklWmgX5uGG8Xcy76DdiFkpZAeemzi91nULxJoWKuAg+e?=
 =?us-ascii?Q?Qeun2RZapjXuznp2lCfMAsb6TD3TVcc6NleifojixWmitgGgRgq88IYP4OVU?=
 =?us-ascii?Q?Mn6O30yCzubv+S8v9fq+oD4wdw3fUyecoWH2p5DTJqqBo37febwK3fejIYsW?=
 =?us-ascii?Q?OLifgBTIYRIXVZIPV98fjgd6/+SDjarWxES42CB6sxFKtLm/GMG8sv6mxhr4?=
 =?us-ascii?Q?v8kHafpjOwXcDlGy6ppesIb7Cz3x1xwwO85i4XLwv+e3h9PCOUmVaPBM9y4F?=
 =?us-ascii?Q?Ci5nalnsKX/uf0zTb62cznDuKa/AY7W5Ccu75wdq/iTATUUkaTI8Qkl9PftI?=
 =?us-ascii?Q?8QxhyR8/UvE8ilJd1O8mys4nTxEys1Umhdg3NYf2B8lGGuKpGmAAYxy2WL7j?=
 =?us-ascii?Q?0vdPmZsZ+i5undbN0gTM8d7n+uktEnXlce9sq+xMhHXmitbmiG1tFFDRGa2b?=
 =?us-ascii?Q?rq4lkFPaFkqOV0aIEMpj1eVu58TtvjbQOcIzAnXWSwG7noH8J5iq0a7pEkd2?=
 =?us-ascii?Q?xWwh14fyoTK3RpYPKm9UuPntDvGzyR8AZkEI1EtfbsMNnQXbwU5yhO6phIxv?=
 =?us-ascii?Q?ijsYNAak65oIMITGQFz452wYg7zgufyKgLWiic5DV1TRvzyiQP+fG0R2zKr5?=
 =?us-ascii?Q?3C8ZfAWl47YlyI7bsoBAiWJzn7ixgUW7WXhVWjPn2evGjBcv6evwSOh6MZG4?=
 =?us-ascii?Q?DKsH5mzesabz6z3UYWow1QsS24SGriznDimI8lcN8katLKj2fQhhZ3ClK+Q4?=
 =?us-ascii?Q?TWNDCsCN4F9mseOOgMn+9fEu6tZFzji2GlzfPQia4DQqwSW+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N5sQ+c+/crDHsXuTLOgtiOsy6nKpYYGCs15wkRxF8aVIs8Qp57Z6Vn7ZK6wPJERSHyiXbf/CDpOgPv8k36uYlDUpxRui2VpowU+pnBSzpYILki3MM9kMrsbcS378aV1IC7BL4yQKFoWeGHQNzcAZ5RsQfiAcvSdW1jb+Qu571njRCUY6jQNFQn0cHVwPp17PhcrjMx8mc/6qWxbYor2gXRAj9JTA/pabHyv0B/VSiDiLcxnZlAISBDSDEyqoveJ2UdrNNe9pX8DaMHqhXUif2GFrtkhGboHFlUfTuAfxwGghBvcFWw3ccF/a5k7jf51epW6lE1D2qi2uF9QWzyFk7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eea643-56d1-46eb-1c58-08df409a4ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 08:52:34.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm0mDBFgF67K8cGHnzbLBU55sAzWSuNtwLKaMJ+CplXTwev5K3JjlYWRIcy6RxmXgxsteDfgV0HbpjXQb3SYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Myeonghun Pak <mhun512@gmail.com>
> Sent: Thursday, November 12, 2026 2:38 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> jikos@kernel.org; bentiss@kernel.org
> Cc: srinivas.pandruvada@linux.intel.com; mpearson-lenovo@squebb.ca; linux=
-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; ae878000@gmail.com
> Subject: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs during
> teardown
>=20
> The managed IRQ can access HID/DMA buffers or queue recovery work while
> remove or probe unwind tears down those resources.
>=20
> Disable and synchronize the IRQ, drain recovery work, then mask THC inter=
rupts
> before freeing the IRQ and releasing HID/DMA resources.
> Track IRQ/DMA initialization for conditional probe cleanup.
>=20
> Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and re=
lease
> outside the shared hibernation helper.
>=20
> Found by a static analysis tool under development.
>=20
> Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC Qu=
ickI2C
> driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>=20
> Changes in v3:
> - Add blank lines in the probe error path (Even).
>=20
>  drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 32
> ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 29319b6227f3..84e458fdd69c 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -652,6 +652,8 @@
>  {
>  	const struct quicki2c_ddata *ddata =3D (const struct quicki2c_ddata *)i=
d-
> >driver_data;
>  	struct quicki2c_device *qcdev;
> +	bool dma_initialized =3D false;
> +	bool irq_requested =3D false;
>  	void __iomem *mem_addr;
>  	int ret;
>=20
> @@ -704,6 +706,7 @@
>  					qcdev);
>  	if (ret)
>  		goto dev_deinit;
> +	irq_requested =3D true;
>=20
>  	ret =3D quicki2c_get_device_descriptor(qcdev);
>  	if (ret) {
> @@ -722,6 +725,7 @@
>  		dev_err(&pdev->dev, "Setup THC DMA failed, ret=3D %d\n", ret);
>  		goto dev_deinit;
>  	}
> +	dma_initialized =3D true;
>=20
>  	ret =3D thc_interrupt_quiesce(qcdev->thc_hw, false);
>  	if (ret)
> @@ -742,13 +746,13 @@
>  	ret =3D quicki2c_get_report_descriptor(qcdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Get report descriptor failed, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	ret =3D quicki2c_hid_probe(qcdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register HID device, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	qcdev->state =3D QUICKI2C_ENABLED;
> @@ -763,10 +767,20 @@
>=20
>  	return 0;
>=20
> -dma_deinit:
> -	quicki2c_dma_deinit(qcdev);
>  dev_deinit:
> +	if (irq_requested) {
> +		WRITE_ONCE(qcdev->recovery_disabled, true);
> +		disable_irq(pdev->irq);
> +	}
> +
>  	quicki2c_dev_deinit(qcdev);
> +
> +	if (irq_requested)
> +		devm_free_irq(&pdev->dev, pdev->irq, qcdev);
> +
> +	if (dma_initialized)
> +		quicki2c_dma_deinit(qcdev);
> +
>  disable_pci_device:
>  	pci_clear_master(pdev);
>=20
> @@ -788,9 +802,12 @@
>  	if (!qcdev)
>  		return;
>=20
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
> +	quicki2c_dev_deinit(qcdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qcdev);
> +
>  	quicki2c_hid_remove(qcdev);
> -
> -	quicki2c_dev_deinit(qcdev);
>=20
>  	quicki2c_dma_deinit(qcdev);
>=20
> @@ -814,6 +831,9 @@
>  	qcdev =3D pci_get_drvdata(pdev);
>  	if (!qcdev)
>  		return;
> +
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>=20
>  	quicki2c_dev_deinit(qcdev);

Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
>=20
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> --
> 2.53.0
