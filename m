Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793549280;
	b=YHOJ45+2yX4UsBCRYMWRrYomc9/QucTWSwAPJYROnM6nFSz/mjW4wskAFxM3e6TTeue3
	 waxR8QrDtxyIUOjN1AVGLXaGW/a8DqW0wFp6mCAUdIkmEpsF8Sp+YknG+obVWUKRakeY8
	 7cxAOdg54l6tA7kTnE60GYLTxmMs8t3bHeP8ubW35pDMpUszUe9TVS9MIki6DfEjVXZ9X
	 zNJY+JZ/JIuJfU4H9sMhVZQdvC5YAbETcDRkZi3pNiR5KcUy3wnp2aMIzfLomlnxQ1vw2
	 Dq9upOmf4toVm9NGagosLTL0aaKBIX4Z6ES83KLDb8L4ZDBSm8OKChmia2+ahQfFe8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793549280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=GmS+E5QIMhY9YUNzSfQwYOhNjcAJL/nI8fxwBEep1B0=;
	b=OK7sbKQxV8G1NRfMU47YqlwA9ze0FzroedODSZ9v/fT5FaeKOMKDFclmt2e9DMREte/E
	 sEZOghyCBPF75KfCpBJIWgv2cEnbqvGRHRdd1z007YKtSDZWfHMDQZ+nHK6I/bI1fPEQ6
	 +uVjHSr33Mi6o7Lb8WIJyaCB2CVfraVhZIctDDrI6LXjD5kzFJHX9l+BcD6RShzBRnowW
	 tJJgI6ezeGD7eyymxBxKigMtOS0iXyihmPOwxXg1jXtZXo9OVlSoRB61AcaUvFamKjbNL
	 B76vrwiMpHUPyFKnXMSufB7LsgJVlntgAw7/eJ+ZTe86qiaeEl72SJU4rb+FtT9oPow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ktyqdmwt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E62606A324;
	Sun,  1 Nov 2026 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E62606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ktyqdmwt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793549279; x=1825085279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GmS+E5QIMhY9YUNzSfQwYOhNjcAJL/nI8fxwBEep1B0=;
  b=Ktyqdmwtfea6SRTzxiMoSEEwvylzpVSuabaEQCbt9myqf7864xOWMuWW
   wot0dQlvpsZ7Neo/79cEkXezEXi08f8W6qgN4EpvNFgp3kTBhjVrmqrda
   hmDwk9lraIKvlXq/kWD86vKGFMaaeQnwTyogy8pKAv3hMl83sgNMUP8wy
   TRtVEQSllBy86RvS9de5B4OAOJa/xMQz2rPGHo/wQVwTDANhHMJcEHbif
   ZqifMTv600/BWjcK/bVK8wiUmx+qPQagu4kQQHK5kw5O6FBnhkaUNYYg1
   amAmMcwrED7pu8CWFymoDZsJKhGRJOCELVN0L+53T7qqUaXvmu/j0NENA
   A==;
X-CSE-ConnectionGUID: vPa0KI2XT6KcvRe8Ih/MQA==
X-CSE-MsgGUID: 1enjWYqOQXa/+iFa/R8mLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2239175"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2239175"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 08:07:59 -0800
X-CSE-ConnectionGUID: ZCgFKO8pQWOT1ljmn+Algg==
X-CSE-MsgGUID: 9MOpBNsoTeGv0HrWC+lYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="7671413"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 08:07:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 08:07:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 08:07:57 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 08:07:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk5R3MS25xFvzJG33hJYBzsHGwS6pjqITfQyLU1czTX/o/P+NmJwjbly6PoZkpFIk/OOU4U69LqPvUaJjeS8P4sUtcxyPU7GpzEVqJbye6DmXgbLtUgeJPLO/cYfcNV2+s2CZS+tl4HyI9Ch2Had6MnWvfSSbTLJ6AS4mkE/JWxRauTC1kSkMQ92jNRWK24+TzW+9LV0UQq/PqQd0PIDrZ4+qW6gZ4fZ+7idRuLMQF91NfnO/vG9vM3tfyvW8XCbqSv+0uXgn5NcOKcHElsKFqRtntPAXFptxRK5oZdgX4Fu5KZg+QJ6B2A0Lll5F78mgut7TMsQMsaGs4ZfcFQNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmS+E5QIMhY9YUNzSfQwYOhNjcAJL/nI8fxwBEep1B0=;
 b=ueFAAR+K8O+fcamIyx39/rtITUsjOgDLVJf7tSo4/jvr5yUuTxGc/79kLSBijeuVm3Z1Tsq+PZf5mClPxJ1yZMOpraoMWXSoKtCpGCkSkRt9fs/XkQGQLlpIdiGgld2FJ/hOCYMmL0jO1v1x5WS0ovbRFIbkNmUx7O+7BFSAxyYma2e6Vh3dzsw4thCHgT2ishPBgWQCLtJ4K9GEYWyldSjEV1Jl/0hEV5Yq6Fl/PqH8mBE70YamSMZNqOzgz/nkFS0Bl6lRcxdAaSnz4uQbqxAZKXJvJ3yYcEArlQrKcIYvYj+yKTDIzLmxR1jKmGpRR24PsiNZRtA37BD226SSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sun, 1 Nov
 2026 16:07:52 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 16:07:52 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "devnull+dhs.frame.work@kernel.org"
	<devnull+dhs.frame.work@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "Schaefer, Daniel" <dhs@frame.work>,
	"sven@xn--vainkla-r2a.ee" <sven@xn--vainkla-r2a.ee>
Subject: Re: [PATCH] iio: light: hid-sensor-als: Don't read past the end of
 short fields
Thread-Topic: [PATCH] iio: light: hid-sensor-als: Don't read past the end of
 short fields
Thread-Index: AQHdZgIwML3t6L79PkKhHW8qyrn6NLcYmKiAgADRnAA=
Date: Sun, 1 Nov 2026 16:07:51 +0000
Message-ID: <76fd7b88769857da1c7dfbc6570ba335e71bf39a.camel@intel.com>
References: <20261027-iio-als-overread-v1-1-e47e2706368b@frame.work>
	 <20261101033737.6c613263@jic23-hlaptop>
In-Reply-To: <20261101033737.6c613263@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-2.fc44) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SN7PR11MB7018:EE_
x-ms-office365-filtering-correlation-id: 496ea5c9-fdb6-417d-e71f-08df38324858
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|6133799003|10067099003|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003;
x-microsoft-antispam-message-info: yohwlWp4gkHdycbMxuTtGoMLFU8WtricDed5pEisXzUDY4W7sCn1zIB+a2QA/bQ92EWzOjswbWcw6kII7KafDIhoj2/tSo2APhPzb3gwHt0rjH76iKhpMJ9yZXgxNNKBcr/lw6MSNcu8vHfHGZk5EFRjfN23HF2gFn7zuD7OZRVC3CYIICW/kNKsSodBZsUvTV1M4NV0TjyHm7wR7ZWlgMaKMSLbrIjXtuus4m7crIqAHmcy+dKloygJsje2R1E+EQKHvgOpXUQt28Cv3F0tROdus95oAb14yZ7dMHJlKCcUDRYMjkEJ6D3pG07yb2Kn7F1vJRjnorLGHF9AAFubAFRYf2yrvTvpRqN1R6YfGIXUFb2XQYOmynBugvj1STpwbs+IlolRuUFQh63rreR7h/6mLdmx0Ngf7VIErsMFwpV7Tx8asEvuL/Uo0kEZaPpauf3HDhucxbaWL83lOICgPBZiQgDS0Exx1Nna7vDxj5vSMCUA+cNRHyIeF89tyhRoh/LcnWLSbtO7xyRIvnObzd/fwLFSY2cwRiJ7b+Bqz5A1KmsuVDglDgBeGKwwoAARLTUlTv7cwwAv0eDG3O3WHDKCLVfol9Xu9xl2a8M5mMnYQVDyPASzhYdpINQOlwG0y5litMeAgeh6BaViSuFRB4RWFYMx73AkH7N9CEDEgIfdl70O0RCXxbWWqF9QrPCVK/sT30B0eo85m5p4JZi2O1s3MFkQSZl7rrvyCK0GhdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJXYjc5RDNkNngybnBUM3N4VC9vb0lrWWVJOVRPSm5aYk9ZMEZ3MXFTbUl6?=
 =?utf-8?B?cjNURGVvSDhUbG1sY3lucTVlT3FpakJKNDY3ZkFnK3NSeFJLbkJhN0t4LzdD?=
 =?utf-8?B?dHZKc1p4cXdUc2VFRExQQkFlQzdQMUJEdDBzTU1ReDZPM3hwSXdKNUYxbVRn?=
 =?utf-8?B?OXFDOEs5cWRLVlpIbmwwK2dHMHNhbTBVSlRMMXF0bFJENDl3SUxtaWNLV0V1?=
 =?utf-8?B?dnpVUW45Yi9Rc0Z3V0VDZ1lSd1lTcWJQUy9ZVHg4bUtKRWRDcXZhYlg2OHIy?=
 =?utf-8?B?NlUxU29acWQ1MmNpNHlqd2IxSzFCNzMxVWlMaGpET1ZmVDB3d0dadTdNMlpa?=
 =?utf-8?B?ZFZHcFpuQmNuenFEWTJCOXZxcHBrV2NDeDlTVktIMVdaanRVRk1OMWdjYUtn?=
 =?utf-8?B?c2oyYzljbk05QVgxT3A5aDdxOE9VOVVQdWkyRVVCK2tDdmZhZDgvZjgrcThn?=
 =?utf-8?B?T1cyNThhSVgxc3ZzUVZzYkxOamFnYlNCR1Bua0xGb1NZVko5TjJjbUVNS0VI?=
 =?utf-8?B?SGtaa2ZIM1dLRkxzeTgyeU1lSUhIamk3amFBOXdxMFYvV0FPa1Z1anVRQ0pE?=
 =?utf-8?B?WVpoOG1rMUhhZTRiSlhXUU5IYzVVU2h6bGxDcW50cGhaQWhPZU10RGdtb1I4?=
 =?utf-8?B?Vnl4SGJhK2dobHd1WnR0WlFlMk9JeDZSOXdROENPTSs0OFI3MnVKaGNWZ2lW?=
 =?utf-8?B?UFIrekFLVU9PQ04wa2h1alBRTDlEd0EzYmh2SGlXMHVNWUZsK2hSak5ZeGNG?=
 =?utf-8?B?UWlXc2RyZGRRZEc1ang0eERBZWdQNzVYUU5ZdGxqR3k0K1lydEJISFRHSXRt?=
 =?utf-8?B?OGpKcG1pd2FLZ1R0dzU0WWllSUgzQTh5dnFVUWRVT29yOVBrUkFzYXhPWUVh?=
 =?utf-8?B?ZlRJZnRmWjhpYW1FMXoyRDJManYxU1pYa01NKzFJZ281OUFvQzAvYm1nbUU4?=
 =?utf-8?B?MlVndVBwbWU4dEJoTWs4d3RYeEM4VjI4WUtnSjdkNEdFeEwrOVNGT1d6cHFp?=
 =?utf-8?B?bXlrMnJFRnZNZmZva3d4Qm1rejNLQ2xXMmRXLy9MVTRVa3ZKWm5ualhnOEwx?=
 =?utf-8?B?VkdVUjVpMjl1dUt6ckIzeUtkNlJMZnpsa2xlR3IrQmZVYXJ1L3FlNGpWdlc1?=
 =?utf-8?B?VWUrajY1OTVYbkxrbFFnZlJNRHlxTlhjQkhRZEtJZTk1MGhsVUUxSXJWWDZ3?=
 =?utf-8?B?RG9CaUliYVo4UFJzYjByOFZYQTdXK1h5LzMyS245ZmRmRWh1NitzVzg1VUZi?=
 =?utf-8?B?cjVuWjM0T1IzMGJJdkJrYmZsekRFeWVOc3RrQVUwZk9YbDFqSTNwL29oaXFH?=
 =?utf-8?B?ckVmV3lJSzFxVGF4VVNPSFhhRVJBWGwxcHR5NDJubHhsend5ZklXSHk2cldl?=
 =?utf-8?B?V2hlSlpzQkd3d3ZrMk4xSEVWQjFuNXIxUGt1VDRnSkd0WElUWWRqaWQrMUVh?=
 =?utf-8?B?VDg3U0FWcTNyTisveldTeEEvZEZxaWEzVUdxRVgzdTVHa0UvNGQ2OVhXa2VD?=
 =?utf-8?B?T0RCemZiNldyQkFTSjJuejdzb2lMMEV0d2g0TkdReWZERGVtaCs3REJIc1hZ?=
 =?utf-8?B?R0VZeVl0V0RETk1DTHZEUlNxL0RUM2RnUnVMeWFPM0xwcEUySFZQeGRjbEFC?=
 =?utf-8?B?UWFtUVRnV1RqbHU4ZXp0VmxSSGxKR0JhOUEzMGg4OFgxdDFTYXVEcHdPZWF1?=
 =?utf-8?B?VjJXOENndnpqWHRweWgxcFFwN0lxU2F6K09Iek8xMGJzMTB4cEpmNml2SHRO?=
 =?utf-8?B?YWRLaHEyaTlrRHRHOGh6R3BhUkRLMGthQStUbmlYa2dSR1g2QzQycjYvRXQ3?=
 =?utf-8?B?SWwxWGQrazJhamxLRjh5LzEwTHEreEtrUm5Jd2FVZ2RObVdmK0RBZ2RWWEto?=
 =?utf-8?B?ZU0yUktYbEJZM3RZTW85RXRmL0xiQXAwQWs0UXprWHlIaVpqZStkZHRZTERZ?=
 =?utf-8?B?anpqbFl1UEJQaWdSdEMxUE5QR0dtM29MOWxVMml5elFTRC9WNkJIQUtNYWhI?=
 =?utf-8?B?NGp6VlloYktsNGhlazd3ZmUyelN5UzJNU3lRei9aL2h4QXZUOGN2Q1BhZEFI?=
 =?utf-8?B?M3F4OUoyS0laOFA2d203VDZKaGNlZjZzK0VhaG5ydjd4alJtOFhxZWlJNzdR?=
 =?utf-8?B?bld2S1gxY2tSWFdXejNVdUl5QkhXdWxlYmZDL2FtZDYrbHcvbTJBenkvRDdC?=
 =?utf-8?B?alZOcXZRM2g2VWtZUjhxZ0p4YzhVSzBzV3oxY2hxb1RPenZuM3ZndExjT1Nh?=
 =?utf-8?B?cU1maWZXOGtmZUNyL2l5YXZ5ZHhoRE9jK21TOGIrZTRZcGlVenZCN0d4cjFE?=
 =?utf-8?B?cEtuSk54NkNvbEkvbmtzZmxoak85ZDhhWFpSMXBXNVZCMHowQ0QzZHdZUHll?=
 =?utf-8?Q?T8hpM7GRsFHT8uvpQI6N+E+q7m8qGWM408+Do?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D35E23D641902B4E86056F1B8FD81C7E@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: SEYyqh0VbtjGLcR0cIW53NPZzWcbiEfnLFl5NNhRGBpS2j/mxYReKJmZgPckK9lqBMSSb3PFCiJMiywDT9Sjol/jYDxZ3yH3UBRtkoOx67ZnwZd867tP3GQvuY1b6twng3lVK4aPzhybehBOz7lgHkZbcv5qP0QCToOoN0cQ2hQeBefTGGndqpriRXKLDuK0loAyF7vbp7vUkVKmbqOAAkJmJocuw+2HmRZm4QeQzwzP+cQQIE+JCqPNbbIj26XVq+FgQL4doL4vHtpg+NwTP3sBBJJ6IS5cIoYVHzcG6+J7SdIxKf40H+mvSXzGnzqd8NO9ExkSK5XD43SiBVgWgw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496ea5c9-fdb6-417d-e71f-08df38324858
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2026 16:07:52.2622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIejaMoyybMDN2s2BWFVQbFPcZm+Ghe3u2Vr1Z6oFTPHUElvyA6HPnJBP2XV4Nvn6wbWr81Btar0wbxWKxP7kq/DiFtwQTyOunz7r2GuP+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTExLTAxIGF0IDAzOjM3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDI3IE9jdCAyMDI2IDE4OjU4OjM5ICswODAwDQo+IERhbmllbCBTY2hhZWZl
ciB2aWEgQjQgUmVsYXkgPGRldm51bGwrZGhzLmZyYW1lLndvcmtAa2VybmVsLm9yZz4NCj4gd3Jv
dGU6DQo+IA0KPiA+IEZyb206IERhbmllbCBTY2hhZWZlciA8ZGhzQGZyYW1lLndvcms+DQo+ID4g
DQo+ID4gUmVwb3J0cyBhcmUgbm90IGd1YXJhbnRlZWQgdG8gYmUgNCBieXRlcy4NCj4gPiBPbiBj
b2xvciBBTFMgc2Vuc29ycyB0aGVyZSBhcmUgZmllbGRzIHRoYXQgY2FuIGJlIHNob3J0ZXIgdGhh
biA0DQo+ID4gYnl0ZXM6DQo+ID4gMTYtYml0IGlsbHVtaW5hbmNlLCBjb2xvciB0ZW1wZXJhdHVy
ZSBhbmQgY2hyb21hdGljaXR5IHgveS4NCj4gPiANCj4gPiBJIGRvbid0IGhhdmUgc3VjaCBhIHNl
bnNvciByaWdodCBub3csIGJ1dCBJIGhhdmUgZW11bGF0ZWQgb25lIGluDQo+ID4gZmlybXdhcmUu
IFdpdGggdGhpcyBwYXRjaCwgbm8gZ2FyYmFnZSBkYXRhIGlzIHJlYWQgZnJvbSB0aGUgbmV4dA0K
PiA+IHJlcG9ydDoNCj4gPiANCj4gPiDCoCBiZWZvcmU6IDA1ZGMwMmJjIDA1ZGMwMmJjIDE5MDAw
NWRjIDBjZTQxOTAwIDAwMDAwY2U0DQo+ID4gwqAgYWZ0ZXI6wqAgMDAwMDAyYmMgMDAwMDAyYmMg
MDAwMDA1ZGMgMDAwMDE5MDAgMDAwMDBjZTQNCj4gPiANCj4gPiBTYW1lIGZpeCBhcyBjb21taXQg
YWQwMmNhNTdlNDRlICgiaWlvOiBoaWQtc2Vuc29yLXByb3g6IEFkZCBzdXBwb3J0DQo+ID4gZm9y
DQo+ID4gMTYtYml0IHJlcG9ydCBzaXplIikuDQo+ID4gDQo+ID4gRml4ZXM6IGVkNTUxNGM5MjVh
MCAoImlpbzogaGlkLXNlbnNvcnM6IEFkZGVkIEFMUyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFNjaGFlZmVyIDxkaHNAZnJhbWUud29yaz4NCj4gSGkgRGFuaWVsLA0KPiANCj4gU2VlbXMg
aW4gbGluZSB3aXRoIHRoZSByZWZlcmVuY2VkIGNvbW1pdCBhbmQgdG8gbWFrZSBzZW5zZSB0byBt
ZS4NCj4gU28gSSdsbCBwaWNrIHRoaXMgdXAgbm93IC0gaG93ZXZlciBzdGlsbCB0aW1lIGZvciBt
b3JlIHJldmlld3MgYXMNCj4gSSdsbCBuZWVkIHRvIHJlYmFzZSBvbiByYzEgYW55d2F5IGluIHRo
ZSBuZXh0IGZldyBkYXlzLg0KPiANCj4gQXBwbGllZCB0byB0aGUgZml4ZXMtdG9ncmVnIGJyYW5j
aCBvZiBpaW8uZ2l0DQo+IA0KDQpMR1RNIGFsc28uIFRoYW5rcyBKb25hdGhhbi4gU2xvd2x5IGNh
dGNoaW5nIHVwIGFmdGVyIHZhY2F0aW9uLg0KDQotU3Jpbml2YXMNCg0KPiBUaGFua3MsDQo+IA0K
PiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiBUZXN0ZWQgb24gYW4gZW11bGF0ZWQgc2Vuc29y
IHdpdGggMiBieXRlIHJlcG9ydHMgdGhhdCBpcyBjb3JyZWN0bHkNCj4gPiByZWNvZ25pemVkDQo+
ID4gYnkgV2luZG93cy4NCj4gPiANCj4gPiBDYzogU3ZlbiBWYWlua8O8bGEgPHN2ZW5AeG4tLXZh
aW5rbGEtcjJhLmVlPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNv
ci1hbHMuYyB8IDE2ICsrKysrKysrKysrKysrKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2xpZ2h0L2hpZC1zZW5zb3ItYWxzLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2xpZ2h0L2hp
ZC1zZW5zb3ItYWxzLmMNCj4gPiBpbmRleCA5MjkzNDNlNDJkODMuLjAwZGZjMjAzN2MxOSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLWFscy5jDQo+ID4gKysr
IGIvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNvci1hbHMuYw0KPiA+IEBAIC0yNjcsNyArMjY3
LDIxIEBAIHN0YXRpYyBpbnQgYWxzX2NhcHR1cmVfc2FtcGxlKHN0cnVjdA0KPiA+IGhpZF9zZW5z
b3JfaHViX2RldmljZSAqaHNkZXYsDQo+ID4gwqAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHByaXYpOw0KPiA+IMKgCXN0cnVjdCBhbHNfc3RhdGUgKmFs
c19zdGF0ZSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gwqAJaW50IHJldCA9IC1FSU5WQUw7
DQo+ID4gLQl1MzIgc2FtcGxlX2RhdGEgPSAqKHUzMiAqKXJhd19kYXRhOw0KPiA+ICsJdTMyIHNh
bXBsZV9kYXRhOw0KPiA+ICsNCj4gPiArCXN3aXRjaCAocmF3X2xlbikgew0KPiA+ICsJY2FzZSAx
Og0KPiA+ICsJCXNhbXBsZV9kYXRhID0gKih1OCAqKXJhd19kYXRhOw0KPiA+ICsJCWJyZWFrOw0K
PiA+ICsJY2FzZSAyOg0KPiA+ICsJCXNhbXBsZV9kYXRhID0gKih1MTYgKilyYXdfZGF0YTsNCj4g
PiArCQlicmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJaWYgKHJhd19sZW4gPCBzaXplb2Yo
dTMyKSkNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJc2FtcGxlX2RhdGEgPSAqKHUz
MiAqKXJhd19kYXRhOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+IMKgDQo+ID4gwqAJc3dp
dGNoICh1c2FnZV9pZCkgew0KPiA+IMKgCWNhc2UgSElEX1VTQUdFX1NFTlNPUl9MSUdIVF9JTExV
TToNCj4gPiANCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogMDlmNzQyYjQ5Y2IyNzI4MDg2ZDc4
YmUyYjBiMzVlNGQxZDcxZmM4NQ0KPiA+IGNoYW5nZS1pZDogMjAyNjEwMjctaWlvLWFscy1vdmVy
cmVhZC1jOWU1MzhmYTYxZmENCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo=
