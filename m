Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5D368291;
	Tue, 13 Oct 2026 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852764; cv=fail; b=XQPgithtDszjdnNuBguom1pyrfNyuMnRWB+mlBVJYvZSryFzsBNMp5ZJsAMEds4K0zSurVDl2EK3DYCUhTpHz5Mun7cTtB3DUa68LNuUJAj3ZAOjQOdsGVIpNPWewhrTtht85l7qL4UeUpjE2DxkAlVO0r2YjceTFqwFTVoW1D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852764; c=relaxed/simple;
	bh=HUIc6X+RBK0dfgWemiCrfmZ6Z442wyJ7cGBcmfksbNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihyzx7+T9H2KUl9oWHSLgBMeIUYFtw7a1SGC0f+wbnae9PP9gwZOw7GPcsF424yL8kD1N8b1PpIAxwA4fINWzki37M0QGlGRR0TrfVhHrXfXsTpzCQxxFN9P9cXxTKkqJO7rsVGmnlve7Rzb5lMVenEykD4ohNy7bMUFJdg97NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXGkQuRD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXGkQuRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791852762; x=1823388762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HUIc6X+RBK0dfgWemiCrfmZ6Z442wyJ7cGBcmfksbNM=;
  b=mXGkQuRD1eB8NEsNEPLVHBt9xmfPxjGjXToVKtz2GKfezY3wBBOqPGlN
   +rIu+oydtEV/q+ot03Jqy7/0f5MNdqIJAgGpW0IkcwEJHyrAHP/JefvFq
   XCU0FXWmZS+XozBPXvIZwd1TKOJLyccK68FHA1Mo8074VcTmkXqEujr3u
   6GX5BliWQHDvh7+CFzP+Vdaomg+4I70rDFae+njdfGJNADv68OABoOFhb
   nixa+PKksZxTaddvf1azjO8+lQCXyH9zlvyfL+KdluYhsG3YZpcVqw7AU
   UYDZ3OAFmV38bIX5kfICfMH0baR/bcDB64FIlHprux8Kh7wd9xzTIo/E/
   g==;
X-CSE-ConnectionGUID: iUp4MoMnTI+2zdn54VtLBA==
X-CSE-MsgGUID: TqTxmj0HSKCBrYFYblY1aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="585404"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="585404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 17:52:41 -0700
X-CSE-ConnectionGUID: r0Ny02FsRsOKcMmGg5ZkHg==
X-CSE-MsgGUID: MxHmMeOrTGi86+sUufHTUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="946504"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 17:52:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 17:52:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 17:52:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 17:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJwPUaygW6K/k3I6iIFJR69MojNc9QeCYba+wExN8vaMkyIwzgmFuSH7Sj0oQTMDwDzrAH4ykcbjFat9kQ/5ZbxPaC8+cfYPmmHg76O9Kh8mTO3OkA2PLUzBCSUHJq8cQutguGr7g5hWolBqRZHfQb/WRdNF3QgKb5FVejdRaX4RcVgI4xdyvDJuSBHNYhNFNV7GUCYFMhXmgBAjF7feM0Xh8C4q8vgmF1B9GqYdEvZosv4kASYPYUTa14q/2jjrJzvXoPUsth7/OzIY98puVYW5+YTL9cfzrd7krx/hGNUHKZ1IskQYBlEpe1UNS5L4e3QHMjgMWB5XemxLyOlARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUIc6X+RBK0dfgWemiCrfmZ6Z442wyJ7cGBcmfksbNM=;
 b=m3m1Y3j3RRfAVZACcYmfpMclkAMa8mTY4z6gywbYl5G8H+++UHe6zrjEmi/LV+RoIQZ9xjC9XeM4A5s5UiNizpG9MKpWJkBzPBG0Zj1Ig/qi+r2rqJbXBsKOxxhNViqVWbzM3V6kn2SroR+52iSU3Ee5Ifc5LulIX+WQ66uROLFquJycYIIZjGaVU7QhDf7N0aKz8mkF0CuNfKdZbsr37Z8EB3kTqZ8z38LR8CcWFrdAEzhuq2ZkXKu0UgYoKQEGKFJO5Nc530Op4tjdky95xrBVq4sqg2lA3ufDP82czRlcL9zhnz3WoF4Am+kl1IkTz5byOWDTFCL843GBRVSH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 00:52:37 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 00:52:37 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdWcy4vOmMlsQh90ux6EsTDq93ibb6pUzg
Date: Tue, 13 Oct 2026 00:52:37 +0000
Message-ID: <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-2-mhun512@gmail.com>
In-Reply-To: <20261011220531.2073892-2-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|IA0PR11MB7377:EE_
x-ms-office365-filtering-correlation-id: 7c8833ae-1661-49e5-eea5-08df28c44691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|38070700021|261009223027099003;
x-microsoft-antispam-message-info: I5NoKV1YEHp1RotNCwpMbjZkSvd+hpUnzc4gmq/tglZBB/tdSDdEtpJEh296bpwbPeVxpQJoD596FutSNPRc29pHqO2xMwro3qR5pqv3Flq0lNl4zFqrDtOUTkYzEzn1XxxT6tnd9Eki9SXzZwc0Bdc4v3KhH10+/XlGSP1J3AGszqjq5GkUCACyflleC4bqjI+3RtvN16zSrSofLWnChVjeWCciNwLfjz6fShcpJ6QT8MMXid7TNxs+oA+Ru+NxKKDPh2HEzQVo6j4QeVNiWe7Lfg2BkaMl31sX6lTOUYj5sJtsAz0W/OFxNv/zcY8r9af8KCvBJu90Mkuz8vsHNOLt6hIG4EUDwIvEw/S3+WyfAOh3RWrzuM9KAthu2jFmWk2z0+Ek4D/aYNp+pJy6T53LxTgN7+cOZHKMSCkmDtsWfhWIN59MXjejLVOcM/CYSgUw1mGU8Z/xd2irHsdgGFdUP7NB9YKMB59xHFRtReYZ9fWo5fNIaheHg0zOT89yUxfrifNBuXi5Fe6ZVswYtF4Oc6pAlCrv0pHnf9B6DUrUijpk1F9WBySimefUBPaiMy9rRGfunjo370eU6L22SomQ7Vo6fDWM5HSm7hE33J765k/IWujbIMpPIJHItICWijtOtSAaC25Y5oROY6F9qovKgyBg48R236h2Vnl1pWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(38070700021)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTZqMUdNVGRYK2R5bnZGOGxMSmJpOW5yeFlKa1RiaVU0VnJ4eGEzUnRlMW5S?=
 =?utf-8?B?d1FvZXg4OWFBMjRZU3NNZG9SUzZjVFZmR2dyL1lFSUZPRUN3bk5Dc3ZYbXNm?=
 =?utf-8?B?VzFCY2tqRzlFMGEyQWRoQnlKWHE4SzdVY0EvS0duTXlDc2t2Uk9IdXFkZTAz?=
 =?utf-8?B?R3JHUlY0SllRWjU1NFRyOGdLN3dhMW11dnFmTDM0aTNBRzluRVRqVXN1T0Vz?=
 =?utf-8?B?UVFOVVlVYUNRVzNrOW5mNnNJaVF0S0Zyc1pOUzBVWXorUkYzZmdKWGM0ajNo?=
 =?utf-8?B?NG9NcUNuVm83anBTQjJQZGlSM1JsZXR4cHFNb204N1l6aDlIYTE3NWNPV1NT?=
 =?utf-8?B?QXRSSCtyZnlqckZIZlhHNTUwV2ZURWhaaDBFbTRSNFkyQi9ObzRqY0lNK3lx?=
 =?utf-8?B?V3VZeS9xWVcwZEt6aGNvRTBaandVVGZkamFoZFI2WlBkV3pBNG5XeDhYbFE2?=
 =?utf-8?B?QU1mMS81cnp6ZDFTcE9zU1lka2pYT2gybWQvYnZmSU53dnFHb2tRaWd5LzBD?=
 =?utf-8?B?bmZIcXFzejdBVUNoVTNjajNRSi9nM0graUI1ZitXQk40M1VqbTNaYjQvWGdW?=
 =?utf-8?B?MldNVm81MEhZb243TW9WelA3Y2tvS0gyV1RRTnIwQkM5NnYwMjBXZWJKd0Zw?=
 =?utf-8?B?NDhUbkxYaUREREhFakIvMG5wdE5WVU1Oa0E1UkxiTjk3V0ZBM1hlUzFzV2Y2?=
 =?utf-8?B?bHh0WGFiSzV1NnRTa0FHWmJQSjd2MlVsdEttS0lOS1dzNmliaHZOWGZDK3Jz?=
 =?utf-8?B?WlRsUnVZc2JYOVhyYUZiaWY1bk9DT3dFVDE3c2o2MEhDSHYyVXk2ZytEd3RM?=
 =?utf-8?B?L2RkaDNhZ2ZpczI1M1VxZEFnSFhBSUJRQThrVDFmSTBUYW8vd2lNNG1Mb2pw?=
 =?utf-8?B?aENENlFON0VuTS9HRFBlNTJyYUNtNWRMcWhJYy91UTJ2MnE1VHNlbmM3TDRh?=
 =?utf-8?B?ZzFiL2ZocXVMcEd5VU9jaCs0Y09PSm45VnEwaUxKYmxKRzEzZ3NFdFROT3JI?=
 =?utf-8?B?Z2lBZ2ZyZk8yZG9MYzFEK21UVG5lNmpVOVBLSm9LRUxhODZOZGJILzVoWEFh?=
 =?utf-8?B?OVZPSlV2STlNeUFjODY0V2J3VGE1YmpHNWVaK3VHVmR5NkhMclVGc3RDbnVy?=
 =?utf-8?B?QURYMkhiVVNhbzRPQnFHWmFydk50d3BhOExab1FJZDVDUlRzSCszdHhud3ky?=
 =?utf-8?B?KzBGTFBMWkpoUnZTeXhGSTFta2RrbE12K2JhZUx3em8zRTVYcHFTQm0vUjdp?=
 =?utf-8?B?aWdjbUMzSXkrSFBzL0h0QWJWdGtabTVuakFSK1lHNzUrcnB0aGVpS0R4ejFU?=
 =?utf-8?B?NHJwaUh0N1BvNGhWWEpic1U1d2Y1b0M0THpueFZBcm9BcnB1ak52bDNHemVy?=
 =?utf-8?B?aGozMmZKVkgxeWQrOW9aUUwwNEVWc3g3RXpmdEtkZGtPUmdmb3Z6eDNwQ05W?=
 =?utf-8?B?THltWXovMVBZYnc2UThZWlJoOHpLT2pKclJKZ0FBdngzZXRIS29QV2g0eDR5?=
 =?utf-8?B?SEo1dGYzVERMT3YxZUxnVDBSL2hSWkhKbTJ0R3RWL05Kb2lLeVVPV3NBRXVk?=
 =?utf-8?B?UkVHbTBIZVdxNGRBMTVEQ09qOHAzZlFxRXBFZURETzFOc1V0dUpBdjZtN1dJ?=
 =?utf-8?B?ZldQSm05Qm4rK0RaMEdGQXV5Mlphcy9YQ0RzN1V0dlp3NXFQSjh2QjNCamRJ?=
 =?utf-8?B?djF6a3ZwWHlVNFQwMVd6TXhZaVBITmdhZUxITHkyOVc5YkpkOG5KZ1dQc0Zv?=
 =?utf-8?B?NTY0aHJQTG94NEhub3VtS1QwbmlUVndiN2kvWnFHV2lHcFZWc3FWN1Joc1Jz?=
 =?utf-8?B?L3FFY2l3eU1yTUp0VWVnQVUxUnpoNkFMRDdwWlYybk85aDR1dWx2N2NXMFdE?=
 =?utf-8?B?blVJY2xveFRCZktPNzBlMmV5RFgwQUhJM0hXUkNWMm5wNWpoT3liWnFaTGpa?=
 =?utf-8?B?R2Myc3loZnVadGduSFQ5b1ZKK1NTV0s0TXMrSDlyTjMyVm80N244UmZoZ0ND?=
 =?utf-8?B?K1pRdThDbVFhWk5OS1Rma0V0TDUraVlTR3JGSjlPcTN0WU1xYSt1T2x1MVc1?=
 =?utf-8?B?L2QzU1M5YTdicDdoUkY2WVFLVktnUy83Q0poZFkvbW5JRmVjS0dGZzdoc1Nl?=
 =?utf-8?B?RDYwcERQNzZaRlR0bXlKNEZNZ3BwTmRMVU5mK2tXR3MrNDhuVHkyVzgwc0hp?=
 =?utf-8?B?Y1NTeHBJbnlWcDhjZURMUjhoMXZqRWdrYncwa1BrZEZrU3QxVnNway9vNzlt?=
 =?utf-8?B?OWR3M1d0d1FiR2dJNzlKS29DYXBtTndmTGtPS1RsbzBWYTNxODJDcmdldC9j?=
 =?utf-8?Q?avp++EMiJUxj7hCbiR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4w+KTasc5tR4FdmKouuPqpTPH6eLs4Wop4CicorFTFguOc1YwOroQmnxga0vUwcQk11nbuO0hn6ZtmtLoDawQTnXqR2VdNN3g+aRDi9d0G2OYj/DZjMui9lfgxjxwIy8VRQ54v0TR0wljV6uQvN86gIqh5J5tJ4X/Ltts385ke1NJhLBzn3mCjnAu5u6AbWs/Zm2s55/TttxoNtb//pVwhzT4ceRsW2QCek3pyF4vpRHypnZWwYqC5b+fpnQQOlDIBWXmrcK0VrYTZl0gFw+UYUt0bmL2T0cgFUFCemJHzoOXcGeHUBtdn0XcqkUKX33dJOF1j6d+CzRU+6n0TttMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8833ae-1661-49e5-eea5-08df28c44691
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 00:52:37.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqwzML2/aYQI2UfwfIALijW1z6zkORnOo9DJmYfZKxL1YDcQIzHSdywXN4WoT+UPbrdMsAgIOk6SOu+90Om9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1o
dW41MTJAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTIsIDIwMjYgNjowNiBB
TQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPjsgU3VuLCBYaW5wZW5nIDx4aW5w
ZW5nLnN1bkBpbnRlbC5jb20+OyBKaXJpDQo+IEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IEJl
bmphbWluIFRpc3NvaXJlcyA8YmVudGlzc0BrZXJuZWwub3JnPg0KPiBDYzogU3Jpbml2YXMgUGFu
ZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+OyBNYXJrIFBlYXJz
b24NCj4gPG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBJamFlIEtpbSA8YWU4Nzgw
MDBAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBISUQ6IGludGVsLXRoYy1oaWQ6
IHF1aWNrc3BpOiBxdWllc2NlIElSUXMgZHVyaW5nIHRlYXJkb3duDQo+IA0KPiBUaGUgbWFuYWdl
ZCBJUlEgY2FuIGFjY2VzcyBISUQvRE1BIGJ1ZmZlcnMgb3IgcXVldWUgcmVjb3Zlcnkgd29yayB3
aGlsZQ0KPiByZW1vdmUgb3IgcHJvYmUgdW53aW5kIHRlYXJzIGRvd24gdGhvc2UgcmVzb3VyY2Vz
Lg0KPiANCj4gRGlzYWJsZSBhbmQgc3luY2hyb25pemUgdGhlIElSUSwgZHJhaW4gcmVjb3Zlcnkg
d29yaywgdGhlbiBtYXNrIFRIQyBpbnRlcnJ1cHRzDQo+IGJlZm9yZSBmcmVlaW5nIHRoZSBJUlEg
YW5kIHJlbGVhc2luZyBISUQvRE1BIHJlc291cmNlcy4NCj4gVHJhY2sgSVJRL0RNQSBpbml0aWFs
aXphdGlvbiBmb3IgY29uZGl0aW9uYWwgcHJvYmUgY2xlYW51cC4NCj4gDQo+IERpc2FibGUgdGhl
IElSUSBiZWZvcmUgc2h1dGRvd24gZGVpbml0IGFzIHdlbGwuIEtlZXAgSVJRIGRpc2FibGluZyBh
bmQgcmVsZWFzZQ0KPiBvdXRzaWRlIHRoZSBzaGFyZWQgaGliZXJuYXRpb24gaGVscGVyLg0KPiAN
Cj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgc3RhdGljIGFuYWx5c2lzLg0KDQpUaGFua3MgZm9y
IHlvdXIgcGF0Y2ghDQoNCkkgdGhpbmsgdGhpcyBwYXRjaCBpcyBzdGlsbCBuZWNlc3NhcnkuIEl0
IGNhbiBwcmV2ZW50IHNvbWUgZXh0cmVtZWx5IHVubGlrZWx5IGJ1dCBwcm9ibGVtYXRpYyBjYXNl
cywgc3VjaCBhcyBhbiBpbnRlcnJ1cHQgYWxyZWFkeSBiZWluZyBxdWV1ZWQgaW4gdGhlIHRocmVh
ZCBiZWZvcmUgdGhlIFRIQyBpbnRlcnJ1cHQgaXMgZGlzYWJsZWQuIEhhdmUgeW91IHRlc3RlZCB0
aGlzIGNvZGUgb24gYWN0dWFsIGhhcmR3YXJlPw0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1DQoN
Cj4gDQo+IEZpeGVzOiA0MTM4ZjIxMTE1YWUgKCJISUQ6IGludGVsLXRoYy1oaWQ6IGludGVsLXF1
aWNrc3BpOiBDb21wbGV0ZSBUSEMgUXVpY2tTUEkNCj4gZHJpdmVyIikNCj4gQXNzaXN0ZWQtYnk6
IExMTQ0KPiBDby1kZXZlbG9wZWQtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwuY29tPg0KPiAtLS0NCj4gQ29tcGls
ZS10ZXN0ZWQgd2l0aCBHQ0MsIFc9MSAoeDg2XzY0KS4gTm8gcnVudGltZSB0ZXN0aW5nLg0KPiAN
Cj4gUmVsYXRlZCByZWNvdmVyeS13b3JrIHJldmlldyBhbmQgc2VyaWVzOg0KPiBodHRwczovL2xv
cmUta2VybmVsLmdudXdlZWIub3JnL2xpbnV4LWlucHV0LzIwMjYwNzE3MDM1NjA5LjM4NzQwMTUt
MS0NCj4gZXZlbi54dUBpbnRlbC5jb20vVC8NCj4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9saW51eC8y
MDI2MDcyOTA1MDE0NS4yMjcyNTk3LTEtZXZlbi54dUBpbnRlbC5jb20vDQo+IA0KPiAgLi4uL2lu
dGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jICAgICAgICAgICAgIHwgMjggKysrKysrKysrKysr
KysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1x
dWlja3NwaS9wY2ktcXVpY2tzcGkuYw0KPiBiL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50
ZWwtcXVpY2tzcGkvcGNpLXF1aWNrc3BpLmMNCj4gaW5kZXggODkyMjZmNWNlNDVlLi4wYmQyMmYy
ODVjNzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVp
Y2tzcGkvcGNpLXF1aWNrc3BpLmMNCj4gKysrIGIvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9p
bnRlbC1xdWlja3NwaS9wY2ktcXVpY2tzcGkuYw0KPiBAQCAtNTk3LDYgKzU5Nyw4IEBAIHN0YXRp
YyBpbnQgcXVpY2tzcGlfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+ICAJCQkgIGNvbnN0
IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgcXVpY2tzcGlfZGV2
aWNlICpxc2RldjsNCj4gKwlib29sIGRtYV9pbml0aWFsaXplZCA9IGZhbHNlOw0KPiArCWJvb2wg
aXJxX3JlcXVlc3RlZCA9IGZhbHNlOw0KPiAgCXZvaWQgX19pb21lbSAqbWVtX2FkZHI7DQo+ICAJ
aW50IHJldDsNCj4gDQo+IEBAIC02NDksNiArNjUxLDcgQEAgc3RhdGljIGludCBxdWlja3NwaV9w
cm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gIAkJCQkJcXNkZXYpOw0KPiAgCWlmIChyZXQp
DQo+ICAJCWdvdG8gZGV2X2RlaW5pdDsNCj4gKwlpcnFfcmVxdWVzdGVkID0gdHJ1ZTsNCj4gDQo+
ICAJcmV0ID0gcmVzZXRfdGljKHFzZGV2KTsNCj4gIAlpZiAocmV0KSB7DQo+IEBAIC02NjcsMTcg
KzY3MCwxOCBAQCBzdGF0aWMgaW50IHF1aWNrc3BpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LA0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJTZXR1cCBUSEMgRE1BIGZhaWxlZCwgcmV0PSAl
ZFxuIiwgcmV0KTsNCj4gIAkJZ290byBkZXZfZGVpbml0Ow0KPiAgCX0NCj4gKwlkbWFfaW5pdGlh
bGl6ZWQgPSB0cnVlOw0KPiANCj4gIAlyZXQgPSBxdWlja3NwaV9nZXRfcmVwb3J0X2Rlc2NyaXB0
b3IocXNkZXYpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiR2V0
IHJlcG9ydCBkZXNjcmlwdG9yIGZhaWxlZCwgcmV0ID0gJWRcbiIsDQo+IHJldCk7DQo+IC0JCWdv
dG8gZG1hX2RlaW5pdDsNCj4gKwkJZ290byBkZXZfZGVpbml0Ow0KPiAgCX0NCj4gDQo+ICAJcmV0
ID0gcXVpY2tzcGlfaGlkX3Byb2JlKHFzZGV2KTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9l
cnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byByZWdpc3RlciBISUQgZGV2aWNlLCByZXQgPSAlZFxu
IiwNCj4gcmV0KTsNCj4gLQkJZ290byBkbWFfZGVpbml0Ow0KPiArCQlnb3RvIGRldl9kZWluaXQ7
DQo+ICAJfQ0KPiANCj4gIAlxc2Rldi0+c3RhdGUgPSBRVUlDS1NQSV9FTkFCTEVEOw0KPiBAQCAt
NjkyLDEwICs2OTYsMTYgQEAgc3RhdGljIGludCBxdWlja3NwaV9wcm9iZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IA0KPiAtZG1hX2RlaW5pdDoNCj4gLQlxdWlj
a3NwaV9kbWFfZGVpbml0KHFzZGV2KTsNCj4gIGRldl9kZWluaXQ6DQo+ICsJaWYgKGlycV9yZXF1
ZXN0ZWQpIHsNCj4gKwkJV1JJVEVfT05DRShxc2Rldi0+cmVjb3ZlcnlfZGlzYWJsZWQsIHRydWUp
Ow0KPiArCQlkaXNhYmxlX2lycShwZGV2LT5pcnEpOw0KPiArCX0NCj4gIAlxdWlja3NwaV9kZXZf
ZGVpbml0KHFzZGV2KTsNCj4gKwlpZiAoaXJxX3JlcXVlc3RlZCkNCj4gKwkJZGV2bV9mcmVlX2ly
cSgmcGRldi0+ZGV2LCBwZGV2LT5pcnEsIHFzZGV2KTsNCj4gKwlpZiAoZG1hX2luaXRpYWxpemVk
KQ0KPiArCQlxdWlja3NwaV9kbWFfZGVpbml0KHFzZGV2KTsNCj4gIGRpc2FibGVfcGNpX2Rldmlj
ZToNCj4gIAlwY2lfY2xlYXJfbWFzdGVyKHBkZXYpOw0KPiANCj4gQEAgLTcxOCw5ICs3MjgsMTIg
QEAgc3RhdGljIHZvaWQgcXVpY2tzcGlfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiAg
CWlmICghcXNkZXYpDQo+ICAJCXJldHVybjsNCj4gDQo+IC0JcXVpY2tzcGlfaGlkX3JlbW92ZShx
c2Rldik7DQo+IC0NCj4gKwlXUklURV9PTkNFKHFzZGV2LT5yZWNvdmVyeV9kaXNhYmxlZCwgdHJ1
ZSk7DQo+ICsJZGlzYWJsZV9pcnEocGRldi0+aXJxKTsNCj4gIAlxdWlja3NwaV9kZXZfZGVpbml0
KHFzZGV2KTsNCj4gKwlkZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIHBkZXYtPmlycSwgcXNkZXYp
Ow0KPiArDQo+ICsJcXVpY2tzcGlfaGlkX3JlbW92ZShxc2Rldik7DQo+IA0KPiAgCXF1aWNrc3Bp
X2RtYV9kZWluaXQocXNkZXYpOw0KPiANCj4gQEAgLTc0Nyw2ICs3NjAsOSBAQCBzdGF0aWMgdm9p
ZCBxdWlja3NwaV9zaHV0ZG93bihzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gIAlpZiAoIXFzZGV2
KQ0KPiAgCQlyZXR1cm47DQo+IA0KPiArCVdSSVRFX09OQ0UocXNkZXYtPnJlY292ZXJ5X2Rpc2Fi
bGVkLCB0cnVlKTsNCj4gKwlkaXNhYmxlX2lycShwZGV2LT5pcnEpOw0KPiArDQo+ICAJcXVpY2tz
cGlfZGV2X2RlaW5pdChxc2Rldik7DQo+IA0KPiAgCS8qIE11c3Qgc3RvcCBETUEgYmVmb3JlIHJl
Ym9vdCB0byBhdm9pZCBETUEgZW50ZXJpbmcgaW50byB1bmtub3duDQo+IHN0YXRlICovDQo=
