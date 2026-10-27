Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793066730;
	b=VXmFqVuW69WDv0s54YXFR90DXCbq0L8Z9gpNIDSxah/Jr2stKn0qW7DKTpQzKLy/jeny
	 vvMJiiQhggG27sRY4GLJvNL9OtqYdvhAbFPhKLFA27SSbrbtD3b3Mh8VdaYhnkapvmg+2
	 0411eo58WVR2aMPDyWFYcIHvtiwVDjbMpsKxq/WiUYZFN/CKKVxGKHaJJRd8EPZkh1esr
	 xTLNwumEUrj17y40jaw2TPqPSgt6PCgKdpCU8eBB90yJYjEV6nmkeqzgD5yAR9NiEe/bR
	 c9FhcKp0w+u/zvSoHmCOLieiATfq+LS7VzkSGKXvW4qEp5iR+ddYGh/vsakgvhqd1lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066730;
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
	bh=cvlIfHRlilLAJgnNUDTeLCjBBcZmVmtPQnvW5R/rSak=;
	b=bxYO4xHD5mE8VjQ10UCKip4PlwY6IPewHUt/kb44MMx8x2bwxYe2mEdqgAA6YLMHTvYL
	 axFdyYYhqWwxHrrmsFdkbfAphWKJin940rAFi479N10wxDIy7ajqy0omsD6bepKmaEEak
	 TsQiL+y18uEXfCTMzKQWEkTHADjFhSHg4HRQXCRrTOAmL7EK/C2cqHrN01YsdoIeDWCxP
	 yCX3Hf7qMepGdS5FSImYhjxnlxp+44OIVuS9nol7KnETrtElK5S5xXhGhzAq2CJwpKyfM
	 hGwKwiGiGQq66HDQFvJtC1vVjb4vEvRnNqHl4p85Ry7MCwZT/pOy5MxhOTyVdAh0Flg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fSiH8KjT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A19606A31F;
	Tue, 27 Oct 2026 02:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A19606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fSiH8KjT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793066728; x=1824602728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvlIfHRlilLAJgnNUDTeLCjBBcZmVmtPQnvW5R/rSak=;
  b=fSiH8KjTPKsDPP4FhdBJjpgAc/+j0945T7bXdGYRtXpHdZdvLFQ0IHJ7
   Q7BEZhXiaoxnD/n6/Fyt1+tdAc7DVC28fEg7mDHmT8vVvUh/26gyhxn4K
   0X3gt1qr4bXkcp1edKnsAjyIEjsXbgCTMlONrbPNy2IcHeDbySt3ZwEoT
   RF0tN49Ye71jKsNahmuGDWH3K+65bpXpRFcyLNttQr86Y2VxuxkUaPCBD
   N2RqkvtpsP50TNTwp91mNbYug9SomknxT92nDRDxXnB+wXBvAOam0u0cd
   lEmF2W3mIfZBP2XTVj/sLsWFbmsrCw5kzB1N/NrtZZ+4Ir81BmbmT2J2x
   w==;
X-CSE-ConnectionGUID: 2n/3uEPrQwSPG9DpZM89Xw==
X-CSE-MsgGUID: fTeZcAJjTQCoyJ8Xy/kg+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1749274"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1749274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:05:28 -0700
X-CSE-ConnectionGUID: k55Jn62JRlWwHimoqveD5A==
X-CSE-MsgGUID: OyQIninoQaaOUDFQNL0tkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4764893"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:05:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 19:05:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 19:05:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 19:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqS1zRo7gzIdKSxenbWqh3zgQUqFW5Peztd0aTF8+d/7Q5xE4UgxpRs46J3YW6YfVYJRZU6YYwc6F2KIymRAU5b06OQBkMKzXuxLZw9jNZBuEwunaYmVmhBnCiEmYXdM4VlVfKacYg0CUaDi+08M2ldqiZGE9hoMFCaHRG8G3i5PHQQzVRFrANMUn3t/O40pfvmWv0AqBWUh9JJtDkuOP85Wh8WI69VNkHNGX99KVSHrmh+3pSYIDWw5RYtdNaKQ87pFZ7ZDiwvgPP4RbRfpBDTRyDpU55NMWuhGXXsEJ4bXNvDoQnnZiVsRGnS96U5SH117s+QL7m2r544YBtDgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvlIfHRlilLAJgnNUDTeLCjBBcZmVmtPQnvW5R/rSak=;
 b=anA3MS+W/90PwYO83QEW0ncx8MrUqbf40k+3ty/+g41L7INHnWIGLAxouQ+Oj0slS8QNrjFI1E+h7wjqoMJ81hOIOhJbuXV6BFZ7FBsp7tpQhNTVl70W8UEhN5KFB55ZIUb1gQl6pD777iBx6wxyVuYB+lThBqpg876bP7KA+iHCnxTOv3MqxNWQ05iwvoh3EmE8KyfFhmXiaSFHjvMq9CmnBUGBDc4+N9KEVwfnKGKUjkKfsCpvRw8dA1EVJHHPeAvDQq9XOKatoe9FiyjoIxW/1vSGAiZG5Wh1jZ3+V8nCqgnY8em6EpK1VCGGNZli5QF/8Mtugpi5ct/fFbD94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH8PR11MB9698.namprd11.prod.outlook.com (2603:10b6:510:3a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:05:18 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:05:17 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdWcy4vOmMlsQh90ux6EsTDq93ibb6pUzggAMhZQCAABUAUIAS3vmw
Date: Tue, 27 Oct 2026 02:05:17 +0000
Message-ID: <SJ0PR11MB77049F097D7061D769DE08A5F4602@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-2-mhun512@gmail.com>
 <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
 <CAGEsz8H4z7cpJQkmFGcqnCT+H56OuUHQDch6kh13TiOo0b-TFA@mail.gmail.com>
 <SJ0PR11MB7704B813C9011D9478BA2BF4F49C2@SJ0PR11MB7704.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB7704B813C9011D9478BA2BF4F49C2@SJ0PR11MB7704.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH8PR11MB9698:EE_
x-ms-office365-filtering-correlation-id: 0d4e5b1f-712c-4b24-170c-08df33cebf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261026121527099003|38070700021|4143699003|56012099006|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|10067099003|11063799006|18002099003|6133799003|22082099003|261026140227099003;
x-microsoft-antispam-message-info: BWP1OdYhL+es2d2cpXSTxe5KcOyfRqDzH1ipfk99NJG4nmlZXyFNj3XH3FUhrcUbD+wXZP4CeBFbV6AfLpfoJ8PJPPv6hFLG7kjiVieqr6RqiBmcCbgRxWRp4RubFCrWPJJfQnChqwhZuOG1z0sSjn4A7TtAAhny7TLussJviTrIj41Jq2DhFl2rFRLuDzA8qJUt+mFImKvMW5KaftiYCHHVca8AwB30X+dCpA/bVRQ+hIv9YqeVAEiTuMYXO0qVGeB2nT2f0ygn8ox909Q4MAOdgH2O0enQNt2/+Vv6JuqxROLHd6EPu6dVVRH5FWoqiyJ73GPN4qjRGmL6NlSKbkoDvg0dEdQfUJjVK86N84ok8DhgZhR6GuEL6Xm7BmW0Vd3b5rhoo0B8az3tOff0x2FzkG3THe6HCaP0vcDrOpWeUonFHWSjDHCG3KMJYqWHcI1kgjqwh2SxqLYliajRag516a+t9iiza9KxR1cUabvnnPKIRG1foQyrjYzhU2/mnrGI4onkb7mtZRBrztCqkaFvicJ5vLdg+TcvGgw6ZuYe0ni1V051KOCShpdpyzaxsln5e9550qbvPQ3G9Ml4G5FIkAvhdJmAV87hwF0x7HN7XJhDR4Towz3/g6hnaal3JKECbQU4+AilHRAvdd+Pnc7E07ePcsfT5etcz/DfNsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026121527099003)(38070700021)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(11063799006)(18002099003)(6133799003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0IxOEhUdm0zTnVPVFNsVnZSVkZMUkk2a0x4NVgrMk1kUVdSUzVPdUxHc2VG?=
 =?utf-8?B?RFN0eVhFRUVQUm1SUU1YelJGaDl3cGJVbkNXOWh1ckhUVVROSStLdzRiZjFj?=
 =?utf-8?B?Q2dydC9LVCtGSU1TZGl4OWdVT0VZQnBMWDN5VUNuV3p4dytIUDJCN0tvL2xZ?=
 =?utf-8?B?Q3Vza00wU3RXcVA5bDlVY0xQNVd5c04rbkpsQnB2N053U3FObkpBSmxsVExT?=
 =?utf-8?B?dG0ySlFKcFJvdmsxZ1VjUmNSeTg3NFhlRUMzY1JBelRsYVVGSWZ3NDRna2Na?=
 =?utf-8?B?ejU4TUZvaEo3cEVHNkNMR1hsbk1rVWJNTjZKdEtmcDJwK0FsRGpvVzVtMnRo?=
 =?utf-8?B?cTNMZmwrRkFtNm9GR2hPSjJyRDI0L0ZsRXVNYWFmVHRXRzhpV2dxWXBTVFcr?=
 =?utf-8?B?MzJCUU5JMUJjRU5NOWVIL3RrZFZEUzdIcjlZMldxZ2ZqU3o3V3BvblBqSmox?=
 =?utf-8?B?Y3R2TU5YZk54N3gweThSWEprWEVSVkJRM0prZmt4NmlXTGJCVjdES0RETHBV?=
 =?utf-8?B?N25zbVp1V3RNMFhDOG5SRFlNV1h1VUs3SW1NT21tck1ic0kyMGRGSnJkQm1l?=
 =?utf-8?B?d3dWdU9yMHpzc1RMdDFKVFZjd2JEbitiNXhwREVYSXlLSWl5Uit4R1ZyTHlT?=
 =?utf-8?B?L2hxNUJ5YlVOQmdJZDUxa1VoTGVaRmg1aVN4M1F3ekdPcGkrYWdmSEs3MWxa?=
 =?utf-8?B?TCtMT2dWdUJ3bWgvV3BBVTBBdWl5WlVNZWRwQ29SN01FZjRtSlgxc24wdmps?=
 =?utf-8?B?eWxzUGNHYXhMeVZ3NS9lTVc4WmxiNExnazlteHNWV28vbnlhM1BEQVNPdE0x?=
 =?utf-8?B?dWRNTGJvc3RQTityUlJPaUdqM1VKRUxabjVsVGpJTDg4bGxiZTF1TjhHbGhn?=
 =?utf-8?B?aDBpTmVJVTdHVmZrdFQwMEU3M3NKeGdDWHFLYlU4SExMNk9tZVN4Mi9OOFhm?=
 =?utf-8?B?U3F3ZWhscXdZUzdkbWxaNDlNazhtbWZTNTNUNTdJUU5JaTFVUWUxbnNra3Z5?=
 =?utf-8?B?MmVjQjZLck1iZWlJaXNPOFhKR0hFaCt0Z0xjODdZUHJvTDAyR3hHMUpLY1d4?=
 =?utf-8?B?akpYQytpbmNoVGJpeFRNSmN4UTZjZHRCOWMweG9NL28wL0d3TUFKV2VPczVF?=
 =?utf-8?B?RmlGWlBRcHl0V2k3QitPOVVvSXNHUjJxTi82S2RHZlo0ZXhsenNHZndlUTNt?=
 =?utf-8?B?RnZ4Y09jUEFsQ2VaeDI4ajdOVGU3ekxVM1ZmSzRHQmw5N0JIaC9zaU1vWjVV?=
 =?utf-8?B?MkNZM1dRaW5tMjVTelJtVTBZLzJrTmJGNXpIUzJHbTFuWTU5L2R1UGxQOHVO?=
 =?utf-8?B?MTErZXJaaHB6YWNONkpNOXJVYUxqWnFVVlNRK3Z3L3p3RTFwQUpUWkRtYVhJ?=
 =?utf-8?B?ZlJnbFFKK3Bia2R2N3hVMFVzWkh6dUN0QlRSR2Q1ZnpEMlNnbFhHUzRXLzZ5?=
 =?utf-8?B?UlJXanpxN3V4NmgxWmw0bGNVRm14ZTJPQW01ZVA3L0lzWHdFclNpZzhSN3Br?=
 =?utf-8?B?RjJDekFBQzFsTmhmVkhwR1R1ZUFTV0FHR014dzdqQWxPZTJYUkQ2UUI1dlJ6?=
 =?utf-8?B?UU9PcytLeXYzYlgrY2ZuL0ZqU0Y3Q3VzakUwenZsR0Y0ZzNyTXNQY0xZMXhU?=
 =?utf-8?B?dlBkZnhsUjlQWHZoeTNCYjRkMkF2c21rVENVcGg2L1d1NE1CdHVkSWZ2U0d1?=
 =?utf-8?B?aVpPSHZRWGtSVlZ6aTh1THNMaG0zOGRVMDF1TmZRajNsVzY0WmlYMTZKM3E0?=
 =?utf-8?B?VTZLMDVGWWVpVzdmdkVkdmtkUWFPNGNyQW93OTRyUXRZcXJnNWxpY2ZkR3Jr?=
 =?utf-8?B?N003VmFXOUV5QXBSa3Mzbmpiakpkd0tLRHpHbjdYZWRUVWZqeDcwTEJuVnp3?=
 =?utf-8?B?YjhVdm1iWVJhMWpWTmd1OFJPVjhGenpYelp6YVMxQllmTjF4T2F1L1JpRGNM?=
 =?utf-8?B?MG41Nll3R0xER1Q3dzMzZFdhMXlHcjlscjhEdFMzR0pKZldlVmJnUUo3ZkRW?=
 =?utf-8?B?MlRqNlhXY0VVYlYyazg1dHRIY2VCSi9EN1lTOXhvb0pXTGl5ZU4xSXplT3cr?=
 =?utf-8?B?U2xNRG1OcHNGc1pKelBmbGlVVGF3eWM3VVZIYWlrNytnbjR4NmMzeVh0c0FP?=
 =?utf-8?B?MEpUemJhdVBFOUVQQzZibXpTOERVNkRqNmFydElzOUduUDJycXhXdEtjaGsz?=
 =?utf-8?B?L1ptd2RDTjRRWnAxS0VWU2V4Mk1OQk9MclhHcC9neEpHblV3bGF5emRsM3V6?=
 =?utf-8?B?Q1hraVNYRmNWV1NxL1lEeGF5RlFxaFhmd295Rkc2L1EyVTNLUjQ1U0RrblJu?=
 =?utf-8?Q?7HpnTY8SYMxt1Mwurt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wJlc5NwEiTwVQmhKXDEACjUGmPGb9z9qMnF1RzvuFPbuN7O+hPdHZ3NEaCIIifae1ENLyKPe8RfIURZtIPspC43eqHYyiSb8ci+yFybx/IwifEtbfKw/BeAiJN2imCH032/oWGM2vHCeXUJV66q0cZ7XvEOmWFIu20lc65D2ZtJJUQMKjyVHG7AKl15mDmjleY9b5u10HjUg3tU/lzqlhDf+MyWdeFthPWTtXNE7Xr7FP3aMoRGJqM4bZY17dcJxpL7mrGBl6WrCfsEWDnAO/ClUUQiRMvdb8jEhnFOy5rVIjeLt5hsNSQqpcn8EWXS9HpEYY+LPb5nxHkmiNkOBuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4e5b1f-712c-4b24-170c-08df33cebf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 02:05:17.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RIPlr7bJvBOo/Sdsib6A8g5wKwLj/VIp2K9yTxaMiSvJPkWEHnUHkchN0VD8ar64FQRScDXs1cU81MBlhKbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9698
X-OriginatorOrg: intel.com

SGksIE15ZW9uZ2h1biwNCg0KVmFsaWRhdGlvbiBwYXNzZWQsIGJ1dCBJIHN1cHBvc2UgeW91IG5l
ZWQgcmViYXNlIHlvdXIgcGF0Y2hlcyBvbiB0b3Agb2YgbGF0ZXN0IG1haW5saW5lIGtlcm5lbC4N
Cg0KQmVzdCBSZWdhcmRzLA0KRXZlbiBYdQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFh1LCBFdmVuDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE1LCAyMDI2IDk6
NTMgQU0NCj4gVG86ICdNeWVvbmdodW4gUGFrJyA8bWh1bjUxMkBnbWFpbC5jb20+DQo+IENjOiBT
dW4sIFhpbnBlbmcgPFhpbnBlbmcuU3VuQGludGVsLmNvbT47IEppcmkgS29zaW5hIDxqaWtvc0Br
ZXJuZWwub3JnPjsNCj4gQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+OyBT
cmluaXZhcyBQYW5kcnV2YWRhDQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNv
bT47IE1hcmsgUGVhcnNvbiA8bXBlYXJzb24tDQo+IGxlbm92b0BzcXVlYmIuY2E+OyBsaW51eC1p
bnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IElq
YWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSBI
SUQ6IGludGVsLXRoYy1oaWQ6IHF1aWNrc3BpOiBxdWllc2NlIElSUXMgZHVyaW5nDQo+IHRlYXJk
b3duDQo+IA0KPiBIaSwgTXllb25naHVuLA0KPiANCj4gVGhlbiBsZXQgbWUgdGVzdCBpdCwgaXQg
bWF5IHRha2Ugc2V2ZXJhbCBkYXlzLg0KPiBXaWxsIGZlZWRiYWNrIG9uY2UgdGVzdCBmaW5pc2hl
ZC4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gRXZlbiBYdQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwuY29t
Pg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE1LCAyMDI2IDg6MzYgQU0NCj4gPiBUbzog
WHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiA+IENjOiBTdW4sIFhpbnBlbmcgPHhpbnBl
bmcuc3VuQGludGVsLmNvbT47IEppcmkgS29zaW5hDQo+ID4gPGppa29zQGtlcm5lbC5vcmc+OyBC
ZW5qYW1pbiBUaXNzb2lyZXMgPGJlbnRpc3NAa2VybmVsLm9yZz47IFNyaW5pdmFzDQo+ID4gUGFu
ZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+OyBNYXJrIFBlYXJz
b24NCj4gPiA8bXBlYXJzb24tIGxlbm92b0BzcXVlYmIuY2E+OyBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSWphZSBLaW0gPGFl
ODc4MDAwQGdtYWlsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gSElEOiBpbnRl
bC10aGMtaGlkOiBxdWlja3NwaTogcXVpZXNjZSBJUlFzDQo+ID4gZHVyaW5nIHRlYXJkb3duDQo+
ID4NCj4gPiBIaSBFdmVuLA0KPiA+DQo+ID4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNo
Lg0KPiA+DQo+ID4gTm8sIEkgaGF2ZW4ndCB0ZXN0ZWQgaXQgb24gYWN0dWFsIGhhcmR3YXJlLiBJ
IGhhdmUgb25seSBjb21waWxlLXRlc3RlZA0KPiA+IGl0IHdpdGggR0NDIGFuZCBXPTEgb24geDg2
XzY0Lg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IE15ZW9uZ2h1bg0KPiA+DQo+ID4gMjAy
NuuFhCAxMOyblCAxMuydvCAo7JuUKSDsmKTtm4QgODo1MiwgWHUsIEV2ZW4gPGV2ZW4ueHVAaW50
ZWwuY29tPuuLmOydtCDsnpHshLE6DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogTXllb25naHVuIFBhayA8bWh1bjUxMkBnbWFp
bC5jb20+DQo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMiwgMjAyNiA2OjA2IEFNDQo+
ID4gPiA+IFRvOiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+OyBTdW4sIFhpbnBlbmcNCj4g
PiA+ID4gPHhpbnBlbmcuc3VuQGludGVsLmNvbT47IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwu
b3JnPjsgQmVuamFtaW4NCj4gPiA+ID4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+DQo+
ID4gPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT47DQo+ID4gPiA+IE1hcmsgUGVhcnNvbiA8bXBlYXJzb24tbGVub3ZvQHNxdWVi
Yi5jYT47DQo+ID4gPiA+IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gbGlu
dXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+
DQo+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIEhJRDogaW50ZWwtdGhjLWhpZDogcXVpY2tz
cGk6IHF1aWVzY2UgSVJRcw0KPiA+ID4gPiBkdXJpbmcgdGVhcmRvd24NCj4gPiA+ID4NCj4gPiA+
ID4gVGhlIG1hbmFnZWQgSVJRIGNhbiBhY2Nlc3MgSElEL0RNQSBidWZmZXJzIG9yIHF1ZXVlIHJl
Y292ZXJ5IHdvcmsNCj4gPiA+ID4gd2hpbGUgcmVtb3ZlIG9yIHByb2JlIHVud2luZCB0ZWFycyBk
b3duIHRob3NlIHJlc291cmNlcy4NCj4gPiA+ID4NCj4gPiA+ID4gRGlzYWJsZSBhbmQgc3luY2hy
b25pemUgdGhlIElSUSwgZHJhaW4gcmVjb3Zlcnkgd29yaywgdGhlbiBtYXNrDQo+ID4gPiA+IFRI
QyBpbnRlcnJ1cHRzIGJlZm9yZSBmcmVlaW5nIHRoZSBJUlEgYW5kIHJlbGVhc2luZyBISUQvRE1B
IHJlc291cmNlcy4NCj4gPiA+ID4gVHJhY2sgSVJRL0RNQSBpbml0aWFsaXphdGlvbiBmb3IgY29u
ZGl0aW9uYWwgcHJvYmUgY2xlYW51cC4NCj4gPiA+ID4NCj4gPiA+ID4gRGlzYWJsZSB0aGUgSVJR
IGJlZm9yZSBzaHV0ZG93biBkZWluaXQgYXMgd2VsbC4gS2VlcCBJUlEgZGlzYWJsaW5nDQo+ID4g
PiA+IGFuZCByZWxlYXNlIG91dHNpZGUgdGhlIHNoYXJlZCBoaWJlcm5hdGlvbiBoZWxwZXIuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIGJ5IHN0YXRpYyBhbmFseXNpcy4N
Cj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4gPg0KPiA+ID4gSSB0aGlu
ayB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lY2Vzc2FyeS4gSXQgY2FuIHByZXZlbnQgc29tZSBleHRy
ZW1lbHkNCj4gPiA+IHVubGlrZWx5IGJ1dA0KPiA+IHByb2JsZW1hdGljIGNhc2VzLCBzdWNoIGFz
IGFuIGludGVycnVwdCBhbHJlYWR5IGJlaW5nIHF1ZXVlZCBpbiB0aGUNCj4gPiB0aHJlYWQgYmVm
b3JlIHRoZSBUSEMgaW50ZXJydXB0IGlzIGRpc2FibGVkLiBIYXZlIHlvdSB0ZXN0ZWQgdGhpcyBj
b2RlIG9uIGFjdHVhbA0KPiBoYXJkd2FyZT8NCj4gPiA+DQo+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+
ID4gPiBFdmVuIFh1DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogNDEzOGYyMTExNWFl
ICgiSElEOiBpbnRlbC10aGMtaGlkOiBpbnRlbC1xdWlja3NwaTogQ29tcGxldGUNCj4gPiA+ID4g
VEhDIFF1aWNrU1BJDQo+ID4gPiA+IGRyaXZlciIpDQo+ID4gPiA+IEFzc2lzdGVkLWJ5OiBMTE0N
Cj4gPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBJamFlIEtpbSA8YWU4NzgwMDBAZ21haWwuY29tPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBJamFlIEtpbSA8YWU4NzgwMDBAZ21haWwuY29tPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBNeWVvbmdodW4gUGFrIDxtaHVuNTEyQGdtYWlsLmNvbT4NCj4g
PiA+ID4gLS0tDQo+ID4gPiA+IENvbXBpbGUtdGVzdGVkIHdpdGggR0NDLCBXPTEgKHg4Nl82NCku
IE5vIHJ1bnRpbWUgdGVzdGluZy4NCj4gPiA+ID4NCj4gPiA+ID4gUmVsYXRlZCByZWNvdmVyeS13
b3JrIHJldmlldyBhbmQgc2VyaWVzOg0KPiA+ID4gPiBodHRwczovL2xvcmUta2VybmVsLmdudXdl
ZWIub3JnL2xpbnV4LWlucHV0LzIwMjYwNzE3MDM1NjA5LjM4NzQwMTUNCj4gPiA+ID4gLTENCj4g
PiA+ID4gLQ0KPiA+ID4gPiBldmVuLnh1QGludGVsLmNvbS9ULw0KPiA+ID4gPiBodHRwczovL3Bh
dGNoZXcub3JnL2xpbnV4LzIwMjYwNzI5MDUwMTQ1LjIyNzI1OTctMS1ldmVuLnh1QGludGVsLmMN
Cj4gPiA+ID4gb20NCj4gPiA+ID4gLw0KPiA+ID4gPg0KPiA+ID4gPiAgLi4uL2ludGVsLXF1aWNr
c3BpL3BjaS1xdWlja3NwaS5jICAgICAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrLS0tLQ0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9kcml2ZXJzL2hpZC9pbnRl
bC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jDQo+ID4gPiA+IGIvZHJpdmVy
cy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9wY2ktcXVpY2tzcGkuYw0KPiA+ID4g
PiBpbmRleCA4OTIyNmY1Y2U0NWUuLjBiZDIyZjI4NWM3OCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
ZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9wY2ktcXVpY2tzcGkuYw0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3Bj
aS1xdWlja3NwaS5jDQo+ID4gPiA+IEBAIC01OTcsNiArNTk3LDggQEAgc3RhdGljIGludCBxdWlj
a3NwaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKSAgew0KPiA+ID4gPiAgICAg
ICBzdHJ1Y3QgcXVpY2tzcGlfZGV2aWNlICpxc2RldjsNCj4gPiA+ID4gKyAgICAgYm9vbCBkbWFf
aW5pdGlhbGl6ZWQgPSBmYWxzZTsNCj4gPiA+ID4gKyAgICAgYm9vbCBpcnFfcmVxdWVzdGVkID0g
ZmFsc2U7DQo+ID4gPiA+ICAgICAgIHZvaWQgX19pb21lbSAqbWVtX2FkZHI7DQo+ID4gPiA+ICAg
ICAgIGludCByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC02NDksNiArNjUxLDcgQEAgc3RhdGlj
IGludCBxdWlja3NwaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxc2Rldik7DQo+ID4gPiA+ICAgICAgIGlm
IChyZXQpDQo+ID4gPiA+ICAgICAgICAgICAgICAgZ290byBkZXZfZGVpbml0Ow0KPiA+ID4gPiAr
ICAgICBpcnFfcmVxdWVzdGVkID0gdHJ1ZTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgcmV0ID0g
cmVzZXRfdGljKHFzZGV2KTsNCj4gPiA+ID4gICAgICAgaWYgKHJldCkgew0KPiA+ID4gPiBAQCAt
NjY3LDE3ICs2NzAsMTggQEAgc3RhdGljIGludCBxdWlja3NwaV9wcm9iZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwNCj4gPiA+ID4gICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJTZXR1
cCBUSEMgRE1BIGZhaWxlZCwgcmV0PSAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gICAgICAgICAgICAg
ICBnb3RvIGRldl9kZWluaXQ7DQo+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4gKyAgICAgZG1hX2lu
aXRpYWxpemVkID0gdHJ1ZTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgcmV0ID0gcXVpY2tzcGlf
Z2V0X3JlcG9ydF9kZXNjcmlwdG9yKHFzZGV2KTsNCj4gPiA+ID4gICAgICAgaWYgKHJldCkgew0K
PiA+ID4gPiAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkdldCByZXBvcnQgZGVz
Y3JpcHRvciBmYWlsZWQsDQo+ID4gPiA+IHJldCA9ICVkXG4iLCByZXQpOw0KPiA+ID4gPiAtICAg
ICAgICAgICAgIGdvdG8gZG1hX2RlaW5pdDsNCj4gPiA+ID4gKyAgICAgICAgICAgICBnb3RvIGRl
dl9kZWluaXQ7DQo+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgcmV0ID0g
cXVpY2tzcGlfaGlkX3Byb2JlKHFzZGV2KTsNCj4gPiA+ID4gICAgICAgaWYgKHJldCkgew0KPiA+
ID4gPiAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byByZWdpc3Rl
ciBISUQgZGV2aWNlLA0KPiA+ID4gPiByZXQgPSAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gLSAgICAg
ICAgICAgICBnb3RvIGRtYV9kZWluaXQ7DQo+ID4gPiA+ICsgICAgICAgICAgICAgZ290byBkZXZf
ZGVpbml0Ow0KPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgIHFzZGV2LT5z
dGF0ZSA9IFFVSUNLU1BJX0VOQUJMRUQ7IEBAIC02OTIsMTAgKzY5NiwxNiBAQA0KPiA+ID4gPiBz
dGF0aWMgaW50IHF1aWNrc3BpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ID4gPg0K
PiA+ID4gPiAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4NCj4gPiA+ID4gLWRtYV9kZWluaXQ6DQo+
ID4gPiA+IC0gICAgIHF1aWNrc3BpX2RtYV9kZWluaXQocXNkZXYpOw0KPiA+ID4gPiAgZGV2X2Rl
aW5pdDoNCj4gPiA+ID4gKyAgICAgaWYgKGlycV9yZXF1ZXN0ZWQpIHsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICBXUklURV9PTkNFKHFzZGV2LT5yZWNvdmVyeV9kaXNhYmxlZCwgdHJ1ZSk7DQo+ID4g
PiA+ICsgICAgICAgICAgICAgZGlzYWJsZV9pcnEocGRldi0+aXJxKTsNCj4gPiA+ID4gKyAgICAg
fQ0KPiA+ID4gPiAgICAgICBxdWlja3NwaV9kZXZfZGVpbml0KHFzZGV2KTsNCj4gPiA+ID4gKyAg
ICAgaWYgKGlycV9yZXF1ZXN0ZWQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgZGV2bV9mcmVlX2ly
cSgmcGRldi0+ZGV2LCBwZGV2LT5pcnEsIHFzZGV2KTsNCj4gPiA+ID4gKyAgICAgaWYgKGRtYV9p
bml0aWFsaXplZCkNCj4gPiA+ID4gKyAgICAgICAgICAgICBxdWlja3NwaV9kbWFfZGVpbml0KHFz
ZGV2KTsNCj4gPiA+ID4gIGRpc2FibGVfcGNpX2RldmljZToNCj4gPiA+ID4gICAgICAgcGNpX2Ns
ZWFyX21hc3RlcihwZGV2KTsNCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTcxOCw5ICs3MjgsMTIgQEAg
c3RhdGljIHZvaWQgcXVpY2tzcGlfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ID4g
PiAgICAgICBpZiAoIXFzZGV2KQ0KPiA+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+
ID4NCj4gPiA+ID4gLSAgICAgcXVpY2tzcGlfaGlkX3JlbW92ZShxc2Rldik7DQo+ID4gPiA+IC0N
Cj4gPiA+ID4gKyAgICAgV1JJVEVfT05DRShxc2Rldi0+cmVjb3ZlcnlfZGlzYWJsZWQsIHRydWUp
Ow0KPiA+ID4gPiArICAgICBkaXNhYmxlX2lycShwZGV2LT5pcnEpOw0KPiA+ID4gPiAgICAgICBx
dWlja3NwaV9kZXZfZGVpbml0KHFzZGV2KTsNCj4gPiA+ID4gKyAgICAgZGV2bV9mcmVlX2lycSgm
cGRldi0+ZGV2LCBwZGV2LT5pcnEsIHFzZGV2KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBx
dWlja3NwaV9oaWRfcmVtb3ZlKHFzZGV2KTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgcXVpY2tz
cGlfZG1hX2RlaW5pdChxc2Rldik7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC03NDcsNiArNzYwLDkg
QEAgc3RhdGljIHZvaWQgcXVpY2tzcGlfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYNCj4gKnBkZXYp
DQo+ID4gPiA+ICAgICAgIGlmICghcXNkZXYpDQo+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiA+ID4gPg0KPiA+ID4gPiArICAgICBXUklURV9PTkNFKHFzZGV2LT5yZWNvdmVyeV9kaXNh
YmxlZCwgdHJ1ZSk7DQo+ID4gPiA+ICsgICAgIGRpc2FibGVfaXJxKHBkZXYtPmlycSk7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gICAgICAgcXVpY2tzcGlfZGV2X2RlaW5pdChxc2Rldik7DQo+ID4gPiA+
DQo+ID4gPiA+ICAgICAgIC8qIE11c3Qgc3RvcCBETUEgYmVmb3JlIHJlYm9vdCB0byBhdm9pZCBE
TUEgZW50ZXJpbmcgaW50bw0KPiA+ID4gPiB1bmtub3duIHN0YXRlICovDQo=
