Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE881724;
	Tue, 24 Feb 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900547; cv=fail; b=pn0rd3OkGkYPWg2Hz9D46PVDSR1GtsJfCbj2+Gv/vsi96GtxG7P5RhKKN8UyK0SNVpvTp+EliNWlhvkty8UUiusL/YBOrkBjrkaMhGp931FNkPoZ6QX07vsYadFVCqvuk2vOLazCBGTcgQwf/7kLMMBC/BA/Ti07Lrqe5G47CRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900547; c=relaxed/simple;
	bh=hfcW6S7wZanRygEvweRb6M4ze7RDjj3WW8N2rntkPUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOZJWqfxwBpziunEdadX3BpUq5g3wu5z0SM96bClWwwhanj5iqa0QsakS/4tKjtDNkwVk8tFRt1ALcyQfR0+X9PKoWZmOUCEOcTOnQxGrTxZ9h1zEn/kznDS8JWI1l4iulvg57w3lc7CFbmsD5J7BLRiDCmnYHacZjgO5pJZmHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhapfBap; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhapfBap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771900547; x=1803436547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hfcW6S7wZanRygEvweRb6M4ze7RDjj3WW8N2rntkPUU=;
  b=NhapfBapaZglk1tODeF/8WcdMKkp2lSJfjUVE201W6KfbrOAkbZ/sYr9
   tLeFaA1sQonvf9AOH53oDiXSd2YnNnMEsIRtODaDUbU1lmU63x++ifQeE
   YiM6acQZIw7UMVvo0SiIUyQBZY5ZCU3KhmPcBdZ0sTKmgTU9QTvy+4KlG
   YL4PzMG87MgnThqc+x8SmleGfyQzUp8nhvpt10Gu2KwfCHb3idy9C8j50
   qHW57DzV7Fa9f2CFOQCWx8M8kQgiuegR04LB77E4dzL4idk3fKe5EKylr
   q5Ziml+5APDn7ZOYrFUmxjLdCW1KKXxEFnOfO9WU5/PbCZxSTUEFUeEV4
   g==;
X-CSE-ConnectionGUID: lUVx8b26TxOOcdyRIoAiuQ==
X-CSE-MsgGUID: 42MunZkvT86aeSQB/vU59g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72784917"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72784917"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:35:46 -0800
X-CSE-ConnectionGUID: tAontyUXQD+m0fvnZigJSw==
X-CSE-MsgGUID: EwdV8QMxSr6KawTxVn8qmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215610723"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:35:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:35:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 18:35:45 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:35:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA1k9IV7YwGucmI8mDIuVqRozhXmVGiwp42lS0NaEmLe0+pPU9el7sEuOX/W7S6Yfru7q9kQ2d/TeR24lj8v4c7OdMWobPwB8poiSm4obCDc/JyMLRitigL5wOSNNzY+5PijNzj1+Naq2Dh5cUJivbQJp0D3Pkd+S3W/auZc9wX0ptrjeOYVXLCCSvWuBsJiFuJEDKls8s4R1LWZU4Vy0AepafwzZ/VRfs1rrewS/5L4jo5pcZjkRj5y5ZoZFq1MvbWPGHFrMeFOTL5ML/sX5XgjF9MeZgB9AmD/BBCqTQ4A0vsqZBq5c34DhTs31RQZWzqLTIEK1ppBgF1HguSNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfcW6S7wZanRygEvweRb6M4ze7RDjj3WW8N2rntkPUU=;
 b=FZ2xWrSGIPVNDyloakuc6rC5lDBq4wbZ2fuXShuoY7q1/2H/J37Bvg1XpxaLzZcHa0I8sWYnrbEfID/luapfP5M9l7O+32JRjb0pmr9OKtsl7AfSn23jiHqlxtniKRlUgQBJ4CMK6vCDtHVYC19fuRc38Yzj7Yu6OplqgwM0vcweEiAedq6C5Vkq46qfJ3+Vmy3RfAi3xBhsmWZmhM7FRMRC3rr9kIAywlZz447Yo2QJe0ejq7Rj2aw5NYB+0UYOKUWTNq55qiQFFHL1vPRSmdWdl8WE/jxmOnM2+k9OE8J96ND/PnKmVzbZAF2jDdRi59NERI7vktqQlyUpSelD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Tue, 24 Feb
 2026 02:35:41 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 02:35:41 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: "Lechner, David" <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "Lechner, David" <dlechner@baylibre.com>
Subject: RE: [PATCH 2/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
Thread-Topic: [PATCH 2/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Thread-Index: AQHcnfUSNrIAahNFbEmcdYU9ivgizbWRMFPw
Date: Tue, 24 Feb 2026 02:35:41 +0000
Message-ID: <SJ0PR11MB5613FDAD41C22FAAF67C094C9374A@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
 <20260214-iio-fix-repeat-alignment-v1-2-47f01288c803@baylibre.com>
In-Reply-To: <20260214-iio-fix-repeat-alignment-v1-2-47f01288c803@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|SN7PR11MB7705:EE_
x-ms-office365-filtering-correlation-id: e6adea30-1a3f-46d9-7592-08de734d6710
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ak9PMTlkYitPMEI1c28wUnpvcFk3UnZ5WElzK2JaMlNOWFE4cXQyMmhlRjIw?=
 =?utf-8?B?cGxQZXNGMjhmaFo2UUR2ZllhRVFWaHpyWUlGLzNMT01CSmtsTkx2bWNtVjBu?=
 =?utf-8?B?b3VRRGFEUnNraDZUMEdZMmFEcjRicWY2ZnZoWFRxaUhBYWdVRk9yZFltcHJS?=
 =?utf-8?B?alZjN3JZaFBKbHIrb2lBdjJSQnNoTHRJZXpTS1pVbXEva3pzR0FUTVAwNTFN?=
 =?utf-8?B?cTQzbkFaaHNuL3RkUGpHZ1haSG9ZN3JpOVhyL2c1OGROQlVHemVJdzFCS3Zn?=
 =?utf-8?B?WlB5NUN3TGxLZ05nMXJwVFZ3dy9rcjVEdEczWlRGTDBPZ1kzSXhSMXp3d0Z6?=
 =?utf-8?B?WDEvS2tncGRJUEYxZDgvK3lZWVRqOWZGT2ZUWEozZjFjR1RqRDJTUndMb3lt?=
 =?utf-8?B?YnFkMUcyODNKM2cwZUlrQW5YK2VtY2JDUVFpbEFpcnJDdk1LZXhsMkJ5NWVz?=
 =?utf-8?B?cDJWUWZMbUtBaDV0VXhDNTdoUVdJUE9EQnZ4dFplUnZnbThhUE5jcXViWGNy?=
 =?utf-8?B?TDVQZzdaM1c4dE1zMFRleUkweGp1dkUwTG82Mkt3YlJBZXordWt0OHVKREx2?=
 =?utf-8?B?UEV3MVpDZEMzYldRb0pkQ2RuRkFqc3VjWHNmS0pLdVJKeVd3SFoxRVN4YkJQ?=
 =?utf-8?B?aEpXSjZBclovN0pVYVRBTzZpOGVhYmp5V0hkMmFldG5ubjNOeFdZeWpWSFJx?=
 =?utf-8?B?SW81YjhUVDNJREFLYURDTk9Ld3lYV2J3cU9wMnc4M1QyNkhTYUIvMU1meDZQ?=
 =?utf-8?B?SXFPalQyTVZMdGhIVHVhOWhISTJNY1RxZncvMnRHa0UrZ1ZCSVkxSzlqbWhP?=
 =?utf-8?B?MlJIaEZ4ajF0N2xzV0JITURld2hLR3BaTUJoYXFwUHlBYm9sQnJvcm1OaW5h?=
 =?utf-8?B?M0tNcnF2bndqVFlPZ25GWHdWeVJvbGNJUVYyV2dhVzkySzVCeU9kOGp3cE1z?=
 =?utf-8?B?VktuVEY5ZGtZM0VISEd6UGE0dmRWT1lVNWhRVXVIUEYxR1JRRk1tUk5oZmhh?=
 =?utf-8?B?Z0I5WlJtejB1ODZnSzIvWlBBUTJ0bG9Salp3Zk9sTXhFbmVZa0xERU5rdWNx?=
 =?utf-8?B?NXdBK2pSdkUwUkVibmNLTUJ4b25CT3JRdFRGRFhGR1AvbEhSaXVqM3FvNHJU?=
 =?utf-8?B?RDBxTW1uUjA0R2ZSVzR4a2t5TExBdWJtcHFraFFZU3dDYTlNZ0JrUi8wU1ZW?=
 =?utf-8?B?STdZekdVYy8vOTJiRTMrRnZGc1ZNejVJdjZVUkNVMWMxWHB6SE1TS29zdjVU?=
 =?utf-8?B?bDAyN2JRdU5lYnVhWHJaK1lNdjVxWVkwbmNRakNFdDdDOVZpOG9FQTRlbUtr?=
 =?utf-8?B?ZmdPdTVSMHNsd3dFTk5yeURqc0VFc3VFeTFvYnM0dWt5bjMyWjIrRVRsTVN1?=
 =?utf-8?B?S2ZDcitGbmo0TDNwZGgxTDZJeFhuakpzMDUrdU1uRlBvazlLUHJtVkRMcVNP?=
 =?utf-8?B?UWo5RWI0UTlhU1htK0hjbzNQamI4MEwyeTRJYkIxWDhGa0hLM094NzdkaWRn?=
 =?utf-8?B?c1llUUFudzh0My8zVlhxZDYzVzdmMHN2MGcrRVVnLy9GYjBLT01Wb04zVlVr?=
 =?utf-8?B?ZVpZSDAySTJUWlRDd2FVblA5WWtuVENBWUlwZTBmcUFxTGRXcDlmUi9SR3hv?=
 =?utf-8?B?eUdHYW9ScXdOdHplMFdSWlNRSVhtc0xybmxGcm9wNkFBbWhuUHIxV25QUnNY?=
 =?utf-8?B?TzVyS2QvUUdqREd2MlNqMWZvUHRBTlYyWC80dW0wcGVnWWJ0bUZ5bHBOMThl?=
 =?utf-8?B?Zkx6bHFqT2s2MG1ObVVTbXBXL3hwZUFUMVlCWThjVHV2c240N0ZRS3F1eWI3?=
 =?utf-8?B?dk8wQW93VHg4LzlIK0hDQSsvUU9KQjZyaWdzbzZ2YzZ5RmY4THlKWkpIQW1t?=
 =?utf-8?B?NTl3WlFpUWpOMm5pb2FPN1FqcWkwYW1IWnZqQmxRVTdXQzVOZGViRlNhWVZw?=
 =?utf-8?B?MldhRThxOEFBZEl0cFIxWndrSDdZMWFnMVV2cnhPSjc5N21idmMzL3NZY0Nw?=
 =?utf-8?B?UjVSc1F3WEtKUXV3MFBOTExwQXpzUTJodG1VWmNDZmRoWjV1UnpkT3R6UGhG?=
 =?utf-8?B?elM4a2IvV2k4TGRrY2wzVW5yZHdGU1lwMFBmUDZSOVRzWmZLYzZzUUREbXZx?=
 =?utf-8?B?VjJZZTJuZ0NqcVM2cFByOWpnNFpSbzFETjU1aWd3NEEzSWQwUnp6UGFBeWEz?=
 =?utf-8?Q?KPDJxE92zlqwoSDJJns7ldQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUZlVkg1Nis5V2VyRzExcGtKaGdxbnRMRndVTjRBOHo3OEdNUDZZWHhpcFdx?=
 =?utf-8?B?Q0FhVDVZQVZUYjR5dmVaZzZJSXhNUForNEpNRS9BY1hKd0xkbHhJbmxyMnZ3?=
 =?utf-8?B?MVBlamhQL0RFK3B0b0prbWdNTmxDRG1QVWQyZmNjZ2grd1JOYU9wUlBBWVJ1?=
 =?utf-8?B?d0hOekxlQ0lIL3dIZkI4bWZjY0RORGZqd0lzS1RScW53Yzk5OTl2bmpDa3RU?=
 =?utf-8?B?NjR4NVVuZUhpczhUVlExRHR2cjZoUTIwWDlhR3dUVlNVQzBkVXB2eXZOeTI1?=
 =?utf-8?B?OElRRDN3NFdzcyt5bE81SnEvZ014OWpNTXUyejhGbWZUN2tnYytCcTE1Qita?=
 =?utf-8?B?OGg3QkM4VDFkd2RGUkpxSFQ5MUdIeklUbE43QVBSSVZaQ0dPaFprc1BNOHNJ?=
 =?utf-8?B?ai9NNnhKbCs0Q0VyMUt4SzNWUnZHamZPMXMveGNqVmIzSmMwVEtPd0s0OERw?=
 =?utf-8?B?a3F5RDNsV0pVdCtsVjFrRzBsMDNWaSs4Y04zUE1yRko5R1VlYW9ocEhad0NS?=
 =?utf-8?B?QnhBYndpMyt4ZFkxVFZTZ2c4dnZpUGJSdnlOOXFlTW4rMEc2N0NydWQyWEpm?=
 =?utf-8?B?T2M0bHNVd1JBbEdFNXVXZCtETjdZQW1uUjMybFJ3d3NoQ1hFK0V1eFlvVnND?=
 =?utf-8?B?TEJFbm5hWHJRRXBOdWUxK2w3L3phektTejhsNE1lcWFXL3ZmaGg5UVo0MXNh?=
 =?utf-8?B?bjdwSFp3di9icEZ1bkIwb3FPTjJLMGdsczBaamIrWHFNNTZTWnVMTk5iYW8y?=
 =?utf-8?B?eU1pUHdvSWxUOVV6c0tJTVRUOUJiZEZtRE8zVWRnbFhCazdJSHRiQkh3c2xZ?=
 =?utf-8?B?S2NGUU1IUjVxSkcvZTlRTUFuOGFNRUlCK1lPR3NYRk8zYVBQZ1R3Vzhkd0ky?=
 =?utf-8?B?RU9YSGdrUXh5aGNIQXBIV3YvS0s1dGR5Z05hYU9VeUFIM01jL2lmZERSczc2?=
 =?utf-8?B?NXJ4MldMZFR3VzlFVEtuc0ZWKzRLVHU0RlFRbzgzTGlnRTgxRkFmSm9uN09w?=
 =?utf-8?B?MXJ3anV4c2tDakgvRzRXNGxtOTNGRmFjZ1M2SmU4OXJ5T1dNUHNUdHVvRngy?=
 =?utf-8?B?cmNPYjcyNFpWTjdDU01yUzVBU09YLzREQlBFTTlnTmVMNUtaT20zUE52ZzVa?=
 =?utf-8?B?WEN6dHpLc0J2bk1NM2M5MnM0RTJ4ZlFYRDk1VVNkU1ByZkV1T214ZU1oUFVF?=
 =?utf-8?B?QTYyVVRocjFRWExoSW9GeUtOUWRTWmlMNTdFcGpOc2IrV3VnTUJZYzVoNTlv?=
 =?utf-8?B?OTJmMzY1WTh6bDFPT215TUV1Y2NLTzhldU11YW5ucW9vdHJMZThXRVYxTEZl?=
 =?utf-8?B?S3BmTVArazc5ekxVN2M5SElLYkJCNXYraTZXNklqS09aYXAwUlh5MGlFNWpo?=
 =?utf-8?B?dEM2ZllQb2RXSmMvMGhFcmF4emtEdUZtVk5OU3ZabGhMc2x4VWRrS3ZEUkIw?=
 =?utf-8?B?L2tpMTkrZXBOUW9NQU8wLzU0M0FFMVgwa0lmTzh6ZlpjbFJMYkI2a2c3QXFJ?=
 =?utf-8?B?Yi9kS3pNeWZhc0lrdzM2Q0lReXVpT29rU1lGT2VyaUtyOHpPSDZPNVRiN1Bh?=
 =?utf-8?B?aFhLdHovQWhwK2pDU1BPbUFvUjRUMGpZQjlSZk1BcmsyaG90Z2FFZ0VWcUJJ?=
 =?utf-8?B?d3A2enl0NHEzQmwwdzEyaDYwSlBJM3B3ZjZxS2ZzU2x4bThtN0FLUExXZEZ3?=
 =?utf-8?B?VTB4VUN4Nmova09LSXpnV3hBNzdTUTdJaFNOZEpwUlZ1SmxGVHE4amtGbmhl?=
 =?utf-8?B?TzhOaHVtbCsrRmR4TC9LdmNac0ZLSnIvSm11UTZTTWZGK2RqRnp6ajBqdFdz?=
 =?utf-8?B?dG5seFRwSmhVVStEUWp3NGVRZi9sOXg3V2puV1Bwd3FJaDdRWnJqbGptZmVw?=
 =?utf-8?B?R250em45NWNycUpwVnoxUHl4T0hZR3VuekNjWG1NYjF0eEF2ckRPMWRhOXRR?=
 =?utf-8?B?Q2Z4Ny9sdUVzR1RJbVp3dkovaE54bTJIdFFXV0J5em14dlJiZlRNN05jRDVD?=
 =?utf-8?B?My9mQnc5OTFTcjBrSjlYS3ZZZnkxN3VvU0cxQTVscThOZWFWT2FuYVc5UHBq?=
 =?utf-8?B?V2pML01QRUlDYzBxVHZvclpRN3VxSXdzSlNNMXBscHVSbnlTTUQ5Y1NBTlY0?=
 =?utf-8?B?SUJvNHMybmFheStZTHJUSFVBQ3htRkwxSVhvZGxZelhZOHVnR242N21peXhQ?=
 =?utf-8?B?TzRIaXZvb0RkckdKNUg3QzdPQ21weERpeUdiMHFjZlFxZGFVbTAwN21QSGk0?=
 =?utf-8?B?ZHB3dW1GWVgvL09hMTdaTjk1aWRvT3NmUWNRa2V2S1RBQkF3V0pIclM4RGNy?=
 =?utf-8?Q?m/xCC3bxM76Z7KkmkU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6adea30-1a3f-46d9-7592-08de734d6710
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 02:35:41.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZuR9+SGy3/5VaBm4quzPzlaqamn7RmiSZDAoKeHF+O2xVbZqzs/KGo5tx7Fkucuun5H5RvcRx9GLpRNt9eU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPg0KPlNlbnQ6IFN1bmRheSwgRmVicnVhcnkgMTUsIDIwMjYgNTowMCBB
TQ0KPlRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTnVubyBTw6EgPG51
bm8uc2FAYW5hbG9nLmNvbT47DQo+QW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBK
aXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IFNyaW5pdmFzDQo+UGFuZHJ1dmFkYSA8c3Jp
bml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+Q2M6IGxpbnV4LWlpb0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENhbWVyb24N
Cj48Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwu
b3JnOyBMZWNobmVyLA0KPkRhdmlkIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBaaGFuZywgTGl4
dSA8bGl4dS56aGFuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogW1BBVENIIDIvMl0gaWlvOiBvcmll
bnRhdGlvbjogaGlkLXNlbnNvci1yb3RhdGlvbjogZml4IHF1YXRlcm5pb24NCj5hbGlnbm1lbnQN
Cj4NCj5SZXN0b3JlIHRoZSBhbGlnbm1lbnQgb2Ygc2FtcGxlZF92YWxzIHRvIDE2IGJ5dGVzIGJ5
IHVzaW5nDQo+SUlPX0RFQ0xBUkVfUkVQRUFURURfRUxFTUVOVCgpLiBUaGlzIGZpZWxkIGNvbnRh
aW5zIGEgcXVhdGVybmlvbiB2YWx1ZQ0KPndoaWNoIHNjYW5fdHlwZS5yZXBlYXQgPSA0IGFuZCBz
dG9yYWdlYml0cyA9IDMyLiBTbyB0aGUgYWxpZ25tZW50IG11c3QgYmUgMTYNCj5ieXRlcyB0byBt
YXRjaCB0aGUgYXNzdW1wdGlvbnMgb2YgaWlvX3N0b3JhZ2VfYnl0ZXNfZm9yX3NpKCkgYW5kIGFs
c28gdG8gbm90DQo+YnJlYWsgdXNlcnNwYWNlLg0KPg0KPlJlcG9ydGVkLWJ5OiBMaXh1IFpoYW5n
IDxsaXh1LnpoYW5nQGludGVsLmNvbT4NCj5DbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIxMDc3DQo+Rml4ZXM6IGIzMWE3NDA3NWNiNCAoImlpbzog
b3JpZW50YXRpb246IGhpZC1zZW5zb3Itcm90YXRpb246IHJlbW92ZQ0KPnVubmVjZXNzYXJ5IGFs
aWdubWVudCIpDQo+U2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGli
cmUuY29tPg0KDQpUZXN0ZWQtYnk6IExpeHUgWmhhbmcgPGxpeHUuemhhbmdAaW50ZWwuY29tPg0K
DQpUaGFua3MsDQotTGl4dQ0K
