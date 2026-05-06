Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA39463;
	Wed,  6 May 2026 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032288; cv=fail; b=utgAFYZyOwNy7kxO3JSEaxSgzLyy7rZeqtXSzWt5qjVpOWMNLyQIao/62ROMLs01Hb1Qlka96XA9v9HAiv0McyUccXBh0sjQVQo2mRCITJOhZltUp59ZI2uGbknDmptq/3ZdWBlwguQhTYRZv81iiRHMqckZ06pkgh/Wqr4zTGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032288; c=relaxed/simple;
	bh=3SuBV0cpxl2yhDPS+2QEKa1n/7RAdNTPfQ2w03IEYC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rc6TC37l6i8HBm2vCcI05wvTW/lhKxH5AOLCwr5tF/0d9czE4Msru4L80GYj2Smqx2TlC3KySmAQINhKH6ToCOIjTRrc2ATHf6PiLceBKp9z9KI/It85i0vVXogHwlNccHTiFWZcYl4JvLapaB+L7T4nOI+Baod+dnJL5bpkV/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gucFt8Zb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gucFt8Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778032287; x=1809568287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3SuBV0cpxl2yhDPS+2QEKa1n/7RAdNTPfQ2w03IEYC4=;
  b=gucFt8Zb5O6sqJ5YUZB6eB64U8SWuaaP7cdktgQ6nQbEbMRNUjwFSzu+
   lFQTs5eU+68XA+SrzMcORnC4QHxBHqEOU+ISPiiq56OxV04N8jJ6CBSMF
   M6idBY70Ts7ydUwsscdGZrIFDSWKBfBTFLb48Vabt/u9xSftit/7qQnSF
   H92EtioKQbHbLZws8FEJAc8DfKxa2J1KVt2QZEzHmj+rd5KLG5VaeB5VA
   UAzkeE6VQMuZU77mmzlyeb4I8p2Il3t57gduyvj5PGXOZ557SQQL5tHtS
   UAn4wiTzKtBouEIkp2rRckZxTFNXWweffrtL2sYSGfrzrDCKf3sEE5PyL
   Q==;
X-CSE-ConnectionGUID: QnqTnsA7TyarwiL1TlUOsA==
X-CSE-MsgGUID: BXapISwNQqGWUbaCwG8/sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89226132"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="89226132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 18:51:24 -0700
X-CSE-ConnectionGUID: b+NUkqbAQ5CErOS992R3Ww==
X-CSE-MsgGUID: n55JKSuUSXi2X/MuUD+0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="232861166"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 18:51:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 18:51:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 18:51:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 18:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4QJX4qKibI+g5xM53yI1LaIm4BIr7wsLZTPPX+3dSbEXDHdyG7thgqwFKTEnMH9n9Wg+IVswhDXN0mhVV3aaGK4e+iloSTwIcWUThDnuMde0jyJTWEqxuLs6VJhXnxhluGBb/FhDwoC+Rn/XkgveklePbekSql4GfCVaBW+zof70HYJ3ok6HKUZkoaNAJXcai4tcJozdrXEi4KHnfXGMyBzlSfPBcjM1Vk+ZGiedbDC4YGV8186SDkHsFqL1MYbXdoQbBFi7TyTD7irvNs33wxksO59VWq72I3mvXQlagf4CmYmkwOXW96pJDP0bgxBSZGFfjGKEF9dDGfDVzYAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SuBV0cpxl2yhDPS+2QEKa1n/7RAdNTPfQ2w03IEYC4=;
 b=FqcRcexGhWld7bRN0Pa19k9dlEPchwf0TpLgiRX0YGPFIfouf+fQzGkGyZ4Oqp0KNIusTZoQX7emigo9jXie3WaoUtwvis/K3DKJY1987LQ5/FUVGxayPnixxZohHA5M5Y0hpFZPc6j6kNQqHPdsToTBSS+qZ/D69oYrXw6U5tjCyY4z94Imv8mwlffRx1COWQkq/BqpNh8/INptIyBXVVjmEkR45zGf8hlzo91uUl/YWe6jRDXvdgd+JPg7WEeAeVNtBmtv3zuhXq1lDypNhaDwDMPtyDN/Cb87UxzHYmaDtnzY6s7X3kp/sh+/3d5kHCih4swtawiJWJVn7QWcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 01:51:18 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 01:51:18 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, srinivas pandruvada
	<srinivas.pandruvada@linux.intel.com>
CC: Sanjay Chitroda <sanjayembeddedse@gmail.com>, "jikos@kernel.org"
	<jikos@kernel.org>, "Lechner, David" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
	<andy@kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Topic: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Index: AQHc2AH/kjTgHMa5MkeqAkfR9yuTcLX5EkcAgAaXYwCAAJszcA==
Date: Wed, 6 May 2026 01:51:18 +0000
Message-ID: <SJ0PR11MB56133DE439A27289798A2975933F2@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
	<15509f5e5a6642d2a4b0ccc13bc7d40d3b79f72a.camel@linux.intel.com>
 <20260505173302.4284a077@jic23-huawei>
In-Reply-To: <20260505173302.4284a077@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|CH3PR11MB8562:EE_
x-ms-office365-filtering-correlation-id: 3484016d-9790-4448-673a-08deab11f724
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: UlhXP8fHWZ6oReOVnbw6MTKBqxmYEAdYLCII+rlW2dLlXh+TGp7znyEoRvYsNqNFv7pU/dsrSNGi6T7oLMiCs1BCB6Yig4g0216vGmH2HQPamxPEeGOOyDVFIpnotIbiU1mzMF7gDvpT+fuA3J2/+pb7SVmTFNDXh8kIhHUmpYzb/DbCLF4pWUsCIFuFvnc3RGpVPltBc+0G194uDthl0ZHpmYpCvt4aAdseD3YjTXMJxybUnruJnU2ZcSoJvu9VnMt/0O+phxSEFprdSU07hiGSlqEn3by3q/GBApI1CvMkY2Van8z6gD0hOUGBK8J7j0Gw/MW7YleB601gB3W0vE2tlZfLKVUXRcaCWEuGuJqd0mpYr/bber51JtmlHFPSQmIapXw6zSYoeVag3SyLVIKFxXMYqr4j+FaFej8Ys0oa8MQFo5MDDrUl/qeRl6DD3NKuxSIuYz1Ze2JAo+2ZTm+0v8nUFWgpXc8EPy3bu8Ougf4ccJd2Xwp8ZIXhRL56+zujxdo/PkwnMxZeTXMKKvDOSTXkxwlFsZylmWPCAXzH3Wso5RzvU2jmtWvR3LzkyYnGEhpsIAJe63Jp8rM+Lqtqlwnk96wPCmZwr/MyFYFbj5loVCNQVKc57cRmZi1c8hUylApFnX+NuSmtHDnqOt6zUkHyIFsm6WsjAgbJ6D8FXY9czttkXOY+lPiXwZzbFxUQUl1gWy3EacR3pphOcUx4YTraAwexNc3onTQEoF5zrAIekLmOmK9YpuRXXGzn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGwxZzh0c09KZzYxTG4wUThMWjIyOHRiNHlQOTgrS1pxT3ZxMWhRQ1FiR0xU?=
 =?utf-8?B?YXEyN0Uvd0FKbjhEd3dQUFczN2IrYUVqY2VXWU9jZGZZZnllZ0lldnNITkpP?=
 =?utf-8?B?NUl2dEQvT0VlZC96NTdheFMvVXVHdWthWG5xcGNEQzBCTEJYSmlkcktmSmh3?=
 =?utf-8?B?cmUvRGVJaXdVZjJ1ZmY0dm5vNG1PSDl5cjBTb2t6N2hkK24vcmdSeGhHWVAw?=
 =?utf-8?B?VVFpanJRb1dTc0FGTW84V3BreUNjcnYwbElEcGhXY0UyQUNJYlZMcEZPYVVa?=
 =?utf-8?B?bko5eUdOVWJDcUJ1L1Mzd09tdTVjQzBEbUp1YU1vbVNXMHVDV0NnN1poelNL?=
 =?utf-8?B?TWJld0xuNFhsalpSK3VnQXdtQkk3eFFxbGpLOGJBc3RYN3Z3WGM2YmVkVFhG?=
 =?utf-8?B?OU1BM3BiVHFwa0UyYU84TFYrQldlaGp2dE1tR3oxc2hPYlB6V2ErbHN0YWJ1?=
 =?utf-8?B?T0pNWFBPTGhYaDdHMTNUREJSNGE0bmF3T1VxaXpQK1FYVmxjdVdDN044cWtY?=
 =?utf-8?B?V3g5Q091UTlEc0l2ekg4c3k0b2hybzZySWxGR2VuZFJNdDA3ZnJXRGRQRytT?=
 =?utf-8?B?TTNxRW1QaFNGOTA1bFlYRWlEMjhwUHNXK1NyMzVrR0hpRG1McUZhQ0gxbURy?=
 =?utf-8?B?SVpLK2VDamhZeTVrMnNrSWJPNEJZVFFVd1d5dFJHNXJETGdlNFdFNHVLMkdT?=
 =?utf-8?B?dTlzdXIwYUlNVUNibXpGUUJkRG5zbFZxRHdxb2NJMVRmSWxhM3hralNPWkN5?=
 =?utf-8?B?bWFGOUtHZHF3bDN1OFdTanFhYXJLQzZ3bnFWaDFETjZsbXlnM1I2L05uWDFM?=
 =?utf-8?B?RzhCZkRwYzNtYzJDbkdoc1JYbjMyd3V6d3UrSVdMT3FSYStvbHNuYVdDa0d1?=
 =?utf-8?B?ZzRFbkxsMVhOdFlrb1diTjJDenNjWXJLL2krLzdXQk8vZkp1OURuUGhZMklW?=
 =?utf-8?B?Nk91SVI4WjZPVmxMVyticUNEQVhQSmFEbVl2WnNYTFdxbXM4Nk1zOWR5RG9K?=
 =?utf-8?B?bFRWMkQ2UFJaQ05QVk5Vd1h6Y2tWVHF6SmoyeUFVaGVmUGgvUjJraTEreEFo?=
 =?utf-8?B?cVFMYlp1cGhwd3ZqOWFjVXpXckFjVjNqMEQ4WGQ0VmhUOFlvV2J1WWYxenFJ?=
 =?utf-8?B?T1lHY09uaFE1RVpIS2NUanRLUUdFcGRxZVVQMGNnQUMrRlc2K1dUMXVuSmda?=
 =?utf-8?B?MUdnT256VmZhUXFVNExxZXJmbHNyRnpFeE4rL01jOG5aQVl3V3EzS2x3bDVK?=
 =?utf-8?B?R1hsSUVydUlUVjhPWnBVRUZWRTg3RCtOUHlBZTdNUWd2UGdYSXV3L3Z0c0pu?=
 =?utf-8?B?OTdRazZqTkxUYVVKSUF2Q2dLWFRnSmlTVGRZU2VueXY1b1FwdXRERDl0Tkht?=
 =?utf-8?B?aDNhRDZPZGE5Yy9hUDlHMnRNYUM0QXhGaXcrbGlYWVJpVDM0ME5aUStjL3pH?=
 =?utf-8?B?N1ZLZGhoZWJDNnpNanZUL1o0SVFWYnBITS8yNi9BbWFYZEtld1lBWkJydzE5?=
 =?utf-8?B?Z1V6ckxrZ2IwcmN0YVpnYmZJbUlUMnVzTm13Sk9wdTU0Y3l0b3BNamVwYkJ4?=
 =?utf-8?B?bk04djA1eVVkeGsxSGEvMlNseFJxVEYyb1kyTEpXejFXTlVQQkRrOHpTbVJL?=
 =?utf-8?B?UW56T2tCQUdOdjY1MDFjWGZQcHlxYVFZT1ZscUF3STd3VEQxZjdRd0VaNW5s?=
 =?utf-8?B?N1E3eUlxYnExeEFiaW9ObUR6VkcyNE40KzRmWjlVU0FYWEJ5bXpjcEZXQk1n?=
 =?utf-8?B?ZER3OUtsVmVNeEh5R285S0dpZVVtdU9JWjg2bmxjWVFCdkZoR0dBRTh0TXRq?=
 =?utf-8?B?ZVNpWXVyWFpSczBVTVE3dHgxUm1BMkhyaTNrWXc3ZDZPeHZuRDY5NHRUWW0z?=
 =?utf-8?B?eTNxOGNBekttdHZrRFhuMmFxVlQwQTdZMFE1VUdSOEl4MXdTL1QvKy91K1Ny?=
 =?utf-8?B?Mjk4Tmc0Mjl2aXRVc1RFMC81V1Zua0NpTEJSYWlsQmFCZFRZUUN0ZGFYTk95?=
 =?utf-8?B?TTlkamRoTXBOdlN4OXpOdEdjTjA1RFAyd0FuUkdmOURBWUJ0V3ZRNUtUcFcz?=
 =?utf-8?B?S2tzK3RxZk0wVkxLbTEwR04yMHVMQmY3ZjRtWHoxamluQ3dpTUlkbGx2NDB4?=
 =?utf-8?B?c0VUYnlXdEtWYlordUx2R1JCZHd5OXRUTWgvNloyYWMyRTIwWGhUNmpYOThu?=
 =?utf-8?B?MEFXcUxWSlo4VGhFMGFqaEZXK3ROcFBjVno3Z29YNFE5Tlgxb0FncUhVZzha?=
 =?utf-8?B?YjFQdjZtMURjcFZXUTROdU4vQUxnL1J4eXcvSVNkTnMxWFJndDRHZTVaMG9Q?=
 =?utf-8?Q?6/DUnHdpDPKpCXQOdA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BD/plRWGTT/sdcGQE50jtqoWwq+hUBRUYVtVMbP5C/FRO4HGNui48gE06BOy06GRkbJMdwUv7fwKMF2Zfp1QSg6Wyw24YHv46UBKr69g+Dv970JhtQl28dB1218pLGKY1zXnpgkCa7nVCPSGZ1rQ7aPUhbOyYbMTWJzrJ/gIjKFVAf6ej6iyTjh9ezp49O8KDmV+DMLTDvRWUMrCyZcX+c8zggkzPkfkIUoR6+zu5474ItRz4h0lfnZYJm8il+iXrK3zsPkUzaZgUyIqqfeJBDA0qD9O0rrTq7bbPlzhq6jTL5kti8O01btxw9GQ7bJ9cH4OPhSkHdXvqgVd7ZW07g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3484016d-9790-4448-673a-08deab11f724
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 01:51:18.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFtOS8U9icDrdHnFsDQE6Pa+/MtAkU5+ZpUo/CghzwmpYw6/qYmloXzQ21UEIdvWBAz/f4VJu0UWlSgo/BLS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8562
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz4NCj5TZW50OiBXZWRuZXNkYXksIE1heSA2LCAyMDI2IDEyOjMzIEFNDQo+
VG86IHNyaW5pdmFzIHBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwu
Y29tPg0KPkNjOiBTYW5qYXkgQ2hpdHJvZGEgPHNhbmpheWVtYmVkZGVkc2VAZ21haWwuY29tPjsg
amlrb3NAa2VybmVsLm9yZzsNCj5MZWNobmVyLCBEYXZpZCA8ZGxlY2huZXJAYmF5bGlicmUuY29t
PjsgbnVuby5zYUBhbmFsb2cuY29tOw0KPmFuZHlAa2VybmVsLm9yZzsgc2FrYXJpLmFpbHVzQGxp
bnV4LmludGVsLmNvbTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nLCBMaXh1
DQo+PGxpeHUuemhhbmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC80XSBp
aW86IGludHJvZHVjZSBkZXZtXyBBUEkgZm9yIGhpZCBzZW5zcm8gc2V0dXAgYW5kDQo+Y2xlYW51
cA0KPg0KPk9uIEZyaSwgMDEgTWF5IDIwMjYgMDQ6NTM6MzggLTA3MDANCj5zcmluaXZhcyBwYW5k
cnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+DQo+
PiArIExpeHUNCj4+DQo+PiBPbiBXZWQsIDIwMjYtMDQtMjkgYXQgMjM6MjkgKzA1MzAsIFNhbmph
eSBDaGl0cm9kYSB3cm90ZToNCj4+ID4gRnJvbTogU2FuamF5IENoaXRyb2RhIDxzYW5qYXllbWJl
ZGRlZHNlQGdtYWlsLmNvbT4NCj4+ID4NCj4+ID4gS2V5IGhpZ2hsaWdodHM6DQo+PiA+IC0gUHJl
cGFyZSBjaGFuZ2UgYXMgcHJlLXJlcXVpc2l0ZSBmb3IgZGV2bSBjb252ZXJzaW9uIGZvciBISUQg
SUlPDQo+PiA+IMKgIGRyaXZlcnMgYnkgcmVtb3ZpbmcgcmVkdW5kYW50IGFyZ3VtZW50DQo+PiA+
IC0gQWRkIGRldm0gQVBJIHRvIHNldHVwIHRyaWdnZXIgYW5kIGNsZW5hdXAgcmVzb3VyY2UgdXNp
bmcNCj4+ID4gwqAgZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkNCj4+ID4gLSBmZXcgc2FtcGxl
IGRyaXZlciB1cGRhdGUgdXNpbmcgZGV2bSBjb252ZXJzaW9uIHRvIGF1dG8gcmVsZWFzZQ0KPj4g
PiByZXNvdXJjZQ0KPj4gPg0KPj4NCj4+IGRldm1fKiBjYWxscyBhcmUgZmluZSBidXQgbmVlZHMg
dGVzdHMgcGFydGljdWxhcmx5IHdoZW4gZm9yY2VzIElTSCBQQ0kNCj4+IGRyaXZlcnMgdW5iaW5k
LCB3aGlsZSBpaW8tc2Vuc29yLXByb3h5IGhhcyBvcGVuIHNlc3Npb25zLg0KPj4NCj4+IExpeHUs
IFBsZWFzZSBjaGVjay4NCj5Ib2xkIG9mZiBwZXJoYXBzIHVudGlsIHdlIGhhdmUgYSB2MyB3aXRo
IGZpeGVzIGZvciB0aGUgZXhpc3RpbmcgZGV2bSBjYWxscyBhZ2FpbnN0DQo+d3Jvbmcgc3RydWN0
IGRldmljZS4NCg0KU3VyZSwgSSdsbCB0ZXN0IHRoZSBJU0ggdW5iaW5kIHNjZW5hcmlvIG9uY2Ug
djMgaXMgb3V0Lg0KDQpUaGFua3MsDQpMaXh1DQoNCj4NCj5UaGFua3MsDQo+DQo+Sm9uYXRoYW4N
Cj4NCj4+DQo+PiBUaGFua3MsDQo+PiBTcmluaXZhcw0KPj4NCg0K
