Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB52DC783;
	Wed, 13 May 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642855; cv=fail; b=kcaoed53rBtXthBBymt8f20byBD+zW6rcpN4ux/0J04LISo2TDaZG/82Um9s6cfRml09ra3Pyoje53uj22fLG99cmzWEJwu9Ldr+cGjg+eA621AJS3aG0G9W4muCT9ex1mJlc5J1rDbu1RxchNIq9Cg+wQN7XTH4hrU4G2Rc3W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642855; c=relaxed/simple;
	bh=QU6hR6c5Gzz08ICnzQ7pihQk4TztNKmI6CR1aYy4u8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alZdA8icmpkhdKw/AG0DtW3iURhCuJz81clcfUMfJSiD/q2dUoywZlns8FD4s4sRTbFUmayjebst/ICGQxVUVcHoGKS4ol8dIp4zNV9r4zEnsa3ElsCNEeuH2lSTsBvH83CI6ootxQUkp2U+/wkP6qsCuq0QYI0uz4kfpyeV+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7sNhhNH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7sNhhNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778642854; x=1810178854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QU6hR6c5Gzz08ICnzQ7pihQk4TztNKmI6CR1aYy4u8g=;
  b=D7sNhhNHWiAvX2jppfzpYY9O1WzyVjyVOsj73VwtrGzNizzv/PHZil0T
   zKPvxHexb991rx3GscZ/6upJWuWekmgja5YytcUJwF7RvuKk6JJUaW28W
   nSnYC6eoGn2G87RyNBnn/zA7ijhFvDeMU/wSkBHy50fLl0HTr5C1FEmQT
   WH0J5XX2s0azLhCk0PRB7uPPc5Pv8IbCBlPwdW9v9UgxPwf2mauXm4BB+
   Hzo63NNYl43y6mK5C9DvbUoXaO6azYLgt4A7G0AJzq1UamCzzP0737o2U
   3ZuKP6Lh7vj5XDmiYbyS0urZA0pqcBuHn9H3uhEO/Pa8InOTC0v/1Qg1D
   A==;
X-CSE-ConnectionGUID: mXyc/8d8TiOC6O/f1FmtKg==
X-CSE-MsgGUID: PYONigKHQfyJjevboefdPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96991022"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="96991022"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 20:27:33 -0700
X-CSE-ConnectionGUID: Wf5y8RfBRFimProMblVRlQ==
X-CSE-MsgGUID: YRsGu+q+S/epxEQ5xAT+HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="276079358"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 20:27:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 20:27:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 20:27:32 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 20:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F02XWhFVSviiCYuKYAJlzRXomVAgvsCd/DLAv9vE6gM6UIMht5TdtNV7USj4eKwK5zpFul8iE0lKGYf+qVS5VOghoH5YnC+RaUxl5CFFt2bYmzy7yrU8m5KNzbWyfgv6SAcxF6rMV53XpxVHBijF8+ywWps/2ycUzZm6r7MeX3QInEa0gK/dzO5gIXbtTmauJzaZ0rUwgKRMTC/9vpLZnhzczqpm2Jz+X/fD6kI1qAGixE3A8UJXwLocU/W1orYHINYmpEcd1Oe2HEXLuULI7jpkdD4gVDySUnQY5zTaP+WIfmPV3CvxeYIYkjoQj/GZwDmsodtlmsYR6Oyil6Hmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU6hR6c5Gzz08ICnzQ7pihQk4TztNKmI6CR1aYy4u8g=;
 b=GUxOROleQuSUBaMRtZzeMZyHfb0rpmjALYpnSITiy5vE39sYDoqCauEiOyM2zve6ZPom0//JzQ32smLdqzY0NAQ12HXee/qHMEc97WUT7XZ+KH4bONMzXvK+FhVkCGcHBgD51LNX8YbT2gnpbE+ZbhVSXvEcAIJ+vOey1Q+p9xmzMxT+uhBJu9iUEm/ff2favk/ZQkA/o32iCtKES/Z77wZYPASzYJqFmGifbxP+XkkxpXczLxy4VLqrQWw1lBfnKhdxzZsdcbzPJSbe4I2Pz8S0fCbUxefE5+Eqb8/7IjvINmc3NPlvaWHihdx0YcOTfBYOB3UPFckw1rbgBVIr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:27:29 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:27:29 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	=?utf-8?B?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
CC: "andy@kernel.org" <andy@kernel.org>, "Lechner, David"
	<dlechner@baylibre.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Thread-Topic: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Thread-Index: AQHc4a35jFWNDiPfx0atDa64awI2DLYKeYuAgADS7mA=
Date: Wed, 13 May 2026 03:27:29 +0000
Message-ID: <SJ0PR11MB56134DDB91B66E4D9E63B3FC93062@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
 <20260512154853.10aa2902@jic23-huawei>
In-Reply-To: <20260512154853.10aa2902@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|IA0PR11MB7911:EE_
x-ms-office365-filtering-correlation-id: 93899d3c-782d-4e85-a5c8-08deb09f8ff8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Yc8qlD7ZNjBk3J7SqRk1c3eHXfolikXOx6TUiuT9jtiW2J/H8dIcsP3hcmDhaa3dZSN8FuBLDG3QYGhtuHwOJwfReXiNeH+m13zSrQnJOOvXRuD9m7Fxi95Wx7b+5koh2C/A5EtHN4D32yChFdenb7+iLmiIwkb4V45pFtXkRwZYsLrO6hPCuLbqnwmhgLBmcxQHwwdvaFLCIIFZ7x2g7V0j1k8d2/wb3hEnPN/X6cKwNfSKnPBqmzCn7h6psl5cimsgXw0mVNm7FO1xLGIhSRbpoCuqBnf6iFEhYrZPNtJ2cw1yXY/ALW/ga3BnC/6QeoCTbs7YpPa+OsJQG4mPJEgKr4rSCfG29MrcjUekFiLAI1ldXV5ScWOSYyxZr+qGSiy/2xFiNQbhLJuUrnQe7gasRkIyEthj1sMUOOo4/V2LPPYL+8mcjNEho0T/Yn5s7IRtMsnMKP8Dce3lmqZw6/oUqaYZcOVdQ+egCaS8y/PZrpmUCMiA3ev8mmGbeyf4xqm7fKyWgNn39rRumzqzM8ow4nQnQeE3d+ZxJrQgb4jgLccr6q3aVv8n+BoU1X1Zqnu6MP9Iezjwi5l4Qfov3FbFIusFsioOJKIPO56SvHuuONv7b78OYScvHvo89Knyw17k/+LhfUKIFZspXIaU4bOLBEKPIsaSdtWhB2tSa4WC8RW9sUQnyMZ6ySP6OjfftvoikzJZ6UvUMYQeCIuQ3EGPYKTrSrkHAOsBSp8jZTzjc3orI0ZGlsw2ohiBaaUo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3NWNXpjLzVsTkc5STNYZG5ZS1FNYjlQcjVEbEN2MFZSRnFQbUZveFVnTU8r?=
 =?utf-8?B?N3FwY2R4cXRMZEpiWXJ6TVoyVnFuU1pjM0gyR0xmK2IyakNiLzFDdDFuTVZU?=
 =?utf-8?B?UWpDK3Npd25GbjJpaE9qdGppQ2hneVJTOHNJOFVORkhaWXh2QXBpekVJd2pF?=
 =?utf-8?B?dlorTG5RRXEwQnNFbUlpRDBueHVtbzJFQmZCTWhXbmdadWhhL0Jhd0JZcWpV?=
 =?utf-8?B?ODNxcEhIVllNbUtXZG9haVQ0SG9IZm9CdWlvamE1ZWMxRkQ2OG1zem5ERE1o?=
 =?utf-8?B?MXRYWlA2aytOSUt2NXJObTFnTi9xNktoQUJqT3lIejA5WlZ4VXRncnlWU2xw?=
 =?utf-8?B?Q0pKR0N4NDNHNmxjQmVvT2xlRm9CVWFGN1ZhTUFuNDRnMHVOVEQweVBvYXBj?=
 =?utf-8?B?WVNvT2Y2Q2lKOXFSTDg3cVBaS2VocmdPK01MZmdOWnJYb3RFZjgxNVBCVjBF?=
 =?utf-8?B?eVNQaDFtMmppSnluWWw4eWgwUFNDL3AwTURlSkFsM25JWlVLV1dJM0VjSldK?=
 =?utf-8?B?TXk3WkhLbWhhRnVYYlVITmo5RTc4N1A4TVFmTXYzT3ZNTlgvOEphTFFxdFJ2?=
 =?utf-8?B?TllsUTJNcERiWnhPbGFDS2xiNEFkcW1wdjlxNVJjcisxRFdaZ2VJbHVPbHdK?=
 =?utf-8?B?S0plNGwzbU5IYm1LaUdKNUlJVjRyeGtLdUxGS1lhVitLd3pMZUIxWnVleTdv?=
 =?utf-8?B?Z2dCV0NtR0hjMHdEdFBJK3l2L0JDQ0lSbkR5U3B5bjk5YXZ6UHB3U1I1d2F4?=
 =?utf-8?B?U2VPdjk0cjFsd3V0aVV6YjhCSDkwekJEOXpXZjZNNVhSSVBoQThHenpzbHJD?=
 =?utf-8?B?MDBNTFdJNlZXTkYwa1NCT2Y3TTYrTGhpRTNOY0JHSUJhNkFiUmNLMEdoazJz?=
 =?utf-8?B?U29hc1dyUVdUNStZN2ZONld5NUdldUdDcjBtMTVmTXZiejI0bEFZcWtrZ1NG?=
 =?utf-8?B?elJmcTNWMk9ielBCak1LNk1ocVJydTZVZzRjZWFlT1lXSlVibjIvZ0ZjZ3Bq?=
 =?utf-8?B?S3BZb3c3VXl5WTNtV1c5SUsySW9JNExqb1lSUThnUmc0NERHRG56OVJEMG1P?=
 =?utf-8?B?TTNtVTdkM3kvWDlFVEdsTCtTcmNRZnVlMGZyM1VQZDhUVnVNR1QwYzhUNDlw?=
 =?utf-8?B?VW00UWFPYWZCVXVhVkxLL1MwNy9rcUc5YmdaU3RranNTdk1UWm1YWTVJZCtw?=
 =?utf-8?B?VnlJZlltSGwxTW8zNkg4ZDJTR0E2MEphbk5nWTNCakY5RGw2TVl2b1pRcmNl?=
 =?utf-8?B?UHZsRURMcWYzYTJnY1lqd1ZJSWFMcWl2ZzQzdkZ2S0FuZ1VRVzJoQ1NvT3cv?=
 =?utf-8?B?c3dLb21NbkNWdElCN0EyN29rNmdHN2JtUjJ0c2tNLytrSFNxRzNPamN1NlE1?=
 =?utf-8?B?ZVZpQ3pXWG05OVRZWUp2KzQvb0ZXY1VWZW5oQUU2cDM4SUlBWGluVjRvSnJZ?=
 =?utf-8?B?ekRhSTBFWFI0V1ZBU2ZjcklWaXdZMk51MWt0MExadG1rTGRqa0J4SEFVTW9o?=
 =?utf-8?B?azE2V29ndm5QSENKamhHdHptZnR5b1FRZjhJRW9xUTc3bnEweTZwaXdBOEZt?=
 =?utf-8?B?VFdmZEVmZDkrYXVOK1RuZ2xxNDQzdEpkVE9NZ0JES0Z4YlpvaWRBSm9NNnpK?=
 =?utf-8?B?Tk1iQkZnUmNTQmg3Mmc1NzVxcFZ5S2RWUUVOK0I3NVM2N1krbVhKT0Q5aS92?=
 =?utf-8?B?dFZQN1dlSU0zT2NSNTY4SVNvczZCZy8xRGlISmVOdjdCbmt2S0JURlIxMTAx?=
 =?utf-8?B?MHY5dk45MmNwV2s1Rnk4ZFFNTUFUeWlwL1RTNTN1QkZ5Rk1yT1JLYlp4a2dM?=
 =?utf-8?B?ZDdnd2xhWHlnR3hyVGhlNFNMb3hBZ0puTWxCN0VMWGM3UmZUaDBGdlpwa3cx?=
 =?utf-8?B?VEtFV2lqTklFb3VuRFNCdnBhclA0T0xPRExwdjZXNjY0bnorbzAxaFhiSWZN?=
 =?utf-8?B?NjRwOGF5aVNGcE91L24xK0U0bzNneFZNTjdoRk5wYllrVWtKZ1B0UUUvYWs1?=
 =?utf-8?B?NFhESnllYytoSC9TaXNRbWx5b3ZNcTdNbEdBQzZiTkticFM3cms4bTNyalpK?=
 =?utf-8?B?dEx2TjI1OVpFOGJ3c2tsKzUvbnRPSkR2TVdDSktvVnhNSDlTZWl1bE5RY1JB?=
 =?utf-8?B?K1d0czcvU0djdTBXU0VVUHRGYWN2U1pDc2FGL2xZblpLRzVpT2RSck1KRVFz?=
 =?utf-8?B?anRGWnA3MTlpekxTclRmTnY0VXpTemlxR0ZpcmdpZUJhS2xwNENXLzFHa3Ez?=
 =?utf-8?B?VnVIUXQ4ejNjcE5WZHA3ZnBsMUhGclJhaWVEdjVkS2VUZWpJV0pmY1g3QW5C?=
 =?utf-8?B?TkNoWWtjRUFlRmhrcFpPZ0dPcG9MNHpqZ0pLdEVnajVjMWNheHVYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ICOy/V1gkSICUYofqst6ZJIpk2k04taMbTZNjT2VFo/K4ajPLm1gB5afX+Wvv95npHsNAw+q87EQHQeUJEMfioEQtaSegExWlMswuU8H0LJLof7pbiPFOn21KErHL8jnA7w+gAzwGu0t5FHnDcUdZZmcEyDHPtvmzz95smdEzaHYpYchmisJRZ12k6LskEBTqh5UWz84htWNJx/afvQ6AXXD+qeuB9e4dFswlRaDG5UMnbbjHHhLz0mpVD4UOdnEIpQZcqaVIT3WWv44Ez1A0BMrSGr+b+0mM0L8J6/GVgZf1NMj3/8K9enDexQ2BIVr7FVpIEIw8M/Bj+4evNESDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93899d3c-782d-4e85-a5c8-08deb09f8ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 03:27:29.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FUAvqE2aUafGelsl5FfnMxWi6baq5SUilhxTCHBpOu/OwAxUUZ2eay6Nfplic/ZQxnhtT/oMqDxcHUruk6fcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjYgMTA6NDkgUE0NCj5U
bzogTmF0w6FsaWEgU2FsdmlubyBBbmRyw6kgPG5hdGFsaWEuYW5kcmVAaW1lLnVzcC5icj4NCj5D
YzogYW5keUBrZXJuZWwub3JnOyBMZWNobmVyLCBEYXZpZCA8ZGxlY2huZXJAYmF5bGlicmUuY29t
PjsNCj5qaWtvc0BrZXJuZWwub3JnOyBudW5vLnNhQGFuYWxvZy5jb207IHNyaW5pdmFzLnBhbmRy
dXZhZGFAbGludXguaW50ZWwuY29tOw0KPmxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWlucHV0QHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIExpeHUNCj48bGl4dS56aGFuZ0BpbnRlbC5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGlpbzogaGlkLXNlbnNvcjogc3RhbmRh
cmRpemUgc2Nhbl90eXBlIGluaXRpYWxpemF0aW9uDQo+DQo+T24gTW9uLCAxMSBNYXkgMjAyNiAy
MjoxNjoxNiAtMDMwMA0KPk5hdMOhbGlhIFNhbHZpbm8gQW5kcsOpIDxuYXRhbGlhLmFuZHJlQGlt
ZS51c3AuYnI+IHdyb3RlOg0KPg0KPj4gVGhpcyBzZXJpZXMgcmVmYWN0b3JzIHRoZSBISUQgc2Vu
c29yIGRyaXZlcnMgdG8gc3RhbmRhcmRpemUgdGhlDQo+PiBpbml0aWFsaXphdGlvbiBvZiB0aGUg
aWlvX2NoYW5fc3BlYyBzY2FuX3R5cGUgc3RydWN0dXJlLg0KPj4gRGlyZWN0IGluaXRpYWxpemF0
aW9uIHVzaW5nIGNvbXBvdW5kIGxpdGVyYWxzIHdhcyB1c2VkLg0KPj4NCj4+IFRoaXMgY2hhbmdl
IGltcHJvdmVzIGNvZGUgcmVhZGFiaWxpdHkgYW5kIGVuc3VyZXMgdGhhdCBhbGwgZmllbGRzIG9m
DQo+PiB0aGUgc2Nhbl90eXBlIHN0cnVjdHVyZSBhcmUgcHJvcGVybHkgemVyby1pbml0aWFsaXpl
ZC4NCj4+IEFkZGl0aW9uYWxseSwgZm9yIHRoZSBoaWQtc2Vuc29yLWFjY2VsLTNkIGRyaXZlciwg
dGhlIGNoYW5uZWwNCj4+IGluaXRpYWxpemF0aW9uIGxvb3Agd2FzIHJlZmFjdG9yZWQgdG8gaXRl
cmF0ZSBkaXJlY3RseSBvdmVyIHRoZSBzY2FuDQo+PiBpbmRpY2VzLCBlbGltaW5hdGluZyByZWR1
bmRhbnQgbG9naWMuDQo+DQo+U2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUgYnV0IEknbGwgbGVhdmUg
aXQgb24gdGhlIGxpc3QgYSB3aGlsZSB0byBib3RoIGxldCBzYXNoaWtvIGNhdGNoDQo+dXAgYW5k
IGFueW9uZSBlbHNlIHdobyB3YW50cyB0byBjYW4gaGF2ZSB0aW1lIHRvIGxvb2suICBBbHNvIGlk
ZWFsbHkgZ2V0IHNvbWUNCj50ZXN0aW5nLg0KPg0KPkxpeHUsIGlmIHlvdSBkb24ndCBtaW5kLCBw
bGVhc2UgY2FuIHlvdSBnaXZlIHRoaXMgYSB0ZXN0IG9uIHRvcCBvZiB0aGUgbW9yZSByYWRpY2Fs
DQo+cmVmYWN0b3IgcGF0Y2hlcz8NCg0KU3VyZSwgSSdsbCB0ZXN0IHRoaXMgc2VyaWVzIG9uIHRv
cCBvZiB0aGUgcmVmYWN0b3IgcGF0Y2hlcyB3aGVuIEkgaGF2ZSBzb21lIHRpbWUuDQoNClRoYW5r
cywNCkxpeHUNCg0KPg0KPlRvIG1lIGl0IGxvb2tzIHNhZmUgZW5vdWdoIGJ1dCB0aGlzIGlzIHRo
ZSBzb3J0IG9mIHNlcmllcyB0aGF0IHN1YnRsZSB0eXBvcyBjYW4gaGlkZQ0KPmluIQ0KPg0KPlRo
YW5rcywNCj4NCj5Kb25hdGhhbg0KPg0K
