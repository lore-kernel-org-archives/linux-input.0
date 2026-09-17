Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF35353A64;
	Thu, 17 Sep 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607784; cv=fail; b=C6u2vZZAVzKH3Psr8y6TgDLHN09oZGXg2M24rqK/Ns/XnV2tnbq7MnLwlCUVG4Akohs1rWdVaT+fj0oZ15Z6Am7VDCmuZ5z/GFdl96vitvl0jV+DsUXkKrE8onLAVvyASoTaPox0x4ENcPJE2KBES9+EpYhkT4uifp5lwLtB/8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607784; c=relaxed/simple;
	bh=ycUJiykMwjVgIjRI0/4okJspk/sBu6dygx3peAK2t7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=koHTr60muJj8Wntqzyg17ux5AZ3Wh60izJYDbAfdKBXTvziL/+lahTE7+8N0crob0z/QI4qfrkFw7WruxwDMlm8yPY1Zc7pH303mrefegTH+TdB31eqFYmAkVSE1dRx/5oEEA77fOgRCVyY1uMM+REq6ppIiWO8vWa0TXHU1ftI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5xjB/Td; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5xjB/Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789607779; x=1821143779;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ycUJiykMwjVgIjRI0/4okJspk/sBu6dygx3peAK2t7c=;
  b=m5xjB/TdOh3+SZe4xbSD6MUCzPBF94KInZ6nKlCHSX66ocei1cY1sFIm
   wJse4VJW9dzkRStm+q/cPojzxVQFN/Oisc5Vpc2CtyBJw1o8CIDxwBn3H
   MCi+raAXFT8+b0DDBGFMWctEbVrBScKzQ/ii/vfMJlMc7TB5L8tvsFlmw
   vmPNg5iWdv33cZyfOkkXOuECBnPndByhhKPPTdaJ0kQA4evUB2bvHicvM
   ol3MhcYLabW6sVB/GTxMGTh9tScqpFs2FtjOhlnSbITPnKr+nRXoEu0Fo
   Z8IUn/HrI5ROMTYTUTkNtOFQ9v5RCltDXtqxrwtIUwvEtESEtfa3DQ0wx
   g==;
X-CSE-ConnectionGUID: /meteYy5R8i1CxzpFVFD4g==
X-CSE-MsgGUID: cVoSIubmSvO4KrHZrnL3tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="500649"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="500649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:16:18 -0700
X-CSE-ConnectionGUID: 8KqhQh9uQZq5OHW7IATF/Q==
X-CSE-MsgGUID: Q65Zt5PuRdm8khD2DwrFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296999488"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:16:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 18:16:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 18:16:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 18:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8BkpjNCAHd3yyHbzJRYlczM6rz0VNfYLqasNchfnFr9jAMEh+CUVrbCDNhoq4kJ7overhpOtZntJGKYzEsheC7c5syYrzBJJNI3EmL5m5pTeocguZGXhVZAvYyTB74ivYSbTgg5Xds4AGxdbnLesDwyWHgsQ5FaaeAkD5ISJF4epVrtrBQQdqPIZhUNIfrA/WETmaZhgx7nTVgi6X2v0fGIKozow3NyyxZZ/VIDOH5QgalXaC24u0eWaSoRJq3kbaGkdKPo0Ds2VfUoW5FDC4+XoDmnOgWtg/pL3xJrJGOXlYx1yOF3ZXlsFlQy22D6f8a3F3Bhdkqs/z4HVOxzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycUJiykMwjVgIjRI0/4okJspk/sBu6dygx3peAK2t7c=;
 b=VROqEdSLMGS16mrSTpDqs7RkmOXZOL0PSj8kuwh4bXrrdktQgc2NElgU4hxY9RNoepUoPGbAxWtfxaIMsYFmnllL2WvuLf4Fvuwk3OvnGiJ1lLxrkiUQdmDlfgnMS5ToiGznw1rr4u2YRcHkD7EZWYr6tdOU6QCMeQdW2uW7L2kWPtYfarsFT+yIDAQ+s6XPXOguyIKOZjKtALKcbN9bLcL1n06RCYJsoVdmXcPLqjogQEQVnWHY7Nfmyghi/ji9q0hreB5IV6Vr1skSF4KMJVQaxsI73xN2B7rAVmE0Sg56TnhCiXnlAvHoEbdX8zOx0vzN6WVB+1TIv0cIy/5rCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 01:16:09 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 01:16:09 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Yibo Tan
	<lhfff@tju.edu.cn>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
Thread-Topic: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
Thread-Index: AQHdQRbiDoQ1eJbHwUCBE8kPfdnpmrbIIi8AgAC0LgCACSqIEA==
Date: Thu, 17 Sep 2026 01:16:09 +0000
Message-ID: <SJ0PR11MB56133EB59F6A661ECE3820D593B82@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
 <9ae8e6b44ffaf5affb7324f802a3626c581ac461.camel@linux.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|SJ0PR11MB4973:EE_
x-ms-office365-filtering-correlation-id: aa5cfe2a-cc67-4962-ec43-08df1459415e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: jmm/6q/PTT3dt3af0ZHRR/7T2OVT2V/VENHNwx3tSnSqdll/oKQTwLL1CKp4tsFETMIbwnsgvuQF70AR2JYw7JuRgiq/MV8AATGey0uvUbi+yNgzM64VvjHO/ZCMOhLHMnDcjBXF/EMdgFA/dI1XrhPR9AditIXcWa4xlMJ9RLh7u2cx52SlcMadKCFXp9umWyUviM6feixkHSPN9dNc/DQ46clexatjxoWnnELRAv/8y3TcueeVsEURM3WBKN5mpIpXyJxMQ3102AV5ARS8V2vyPGjTtGj+drFyav0sphvFQv8JKW9GsLE4wnjXdKtdnl6aSzMWjkEYUfjggG5pl5PUV9JAiCqmRHNqJg3TF8MEoZM8Rgmp3kURlr624u83BdRAHZY7O67Y429srrwNuR8d3bRiCXigQpqtZLyyJiwFhTWnLK9Fb3esF9m27JcFtVxnVL5N8Gr+3Bz06ZnM+Jsno1HkUYsHm+4l2Khit8H94sDJUNaL9LhXl+fdVGTXmDVClZpOMr2w6GdTxv++jjCFDjGJuLZwOM1AWo+8DVkehY6HYdgHjsa+42o70l7m10f+KLxcRKUIkCKLgF7ncYhm4iUAznjIYExJMmzU/Jy0xrqe3X3IBhHo0Yb/XewIiYGZ+OCnPDpiPRAXHtX03JfegukOHzBnLHwlUGX+fsY1HxFdSAdNndp00NqiQK8J6scqrI4RfhL1/9Z/vO9OHmgcxw80ztZEBYqwSLOl0ic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZmV3VxVlkyby93Nzkzd1ZBQXZGR094a3lnRi9jb003OWlacDRJeTc0QzNU?=
 =?utf-8?B?MjFoMTg5eldDSEdWa0VuTnRmZTM1ZERRcnhsdVpTSE12MlRmQ3FPVDZ6Q2Ez?=
 =?utf-8?B?dm1pRkQzOVRHS3JJWnQvaUdqaVd2Yyt6Z2lTcmdTbTI4NHM4NXdlL3h3aEto?=
 =?utf-8?B?NGFVOTRoWHJCclhOeEJlc3ozekFUQTNVUHl1TXBuVVpXUTBXUXh2N0p0dlM0?=
 =?utf-8?B?eW9aT2YwVlRlVVBXWm5LYXo4ZVArZ25raUZhYXhHenhsWUo0UXVVaHlpSFc3?=
 =?utf-8?B?MTMzNHJtT1BMT0xlRzFmdG1IVGxwWGRrUzJrY1NmWWgyQk9ieVRHOGZPaGRk?=
 =?utf-8?B?MjAxamMzRkxBVjIvRVBXVWhaalRPcTZnS2o4MXNvSGZQcXpoNy80cnBOTk80?=
 =?utf-8?B?Mjc0VE9KQlp5OFFMWEFYZ01neVBiME5CZ1FQbmE3ZFlaN1JPQkZ1eVExNzFh?=
 =?utf-8?B?OFh6TkZoVkMzV2Zrd1lic2NZdzRhenJGV2ppWTZ5eE9JTFpkRFVlSmwyV3Ns?=
 =?utf-8?B?VEV1dVV2WVNocXk0b3hlMmR2VlUzakU1dFpNTm5TTHk1c3lDd0RNRnpqSzI5?=
 =?utf-8?B?WHJ3UUxzdFNNN2xTQnY3Zks4NkZQcGVIVGx4ekE1ZlBWQ3dxVDY4Qi81QWFu?=
 =?utf-8?B?MCtSQno0K2c4RysvQlFnY3g2NGFwaTdhOGpXL3FieW53WkdWQTNRTXZlZ3BP?=
 =?utf-8?B?dzJ3SlZvRjBFSjdFdC9ENHV4TWh2dWlheVdNUG9Wa3hWVFU2MnpFM2t4aTA2?=
 =?utf-8?B?WUNZMlVHenlJSWdtS3BjcUZBKzdBcmtOb1FVczN1dzlSNzJLZ0xVQndoZFFL?=
 =?utf-8?B?V1RHb3BqemM4VVdNVm5HNlhjbHRTdU9OaUpweWpxa25EaXptYTRGRWpwRE5I?=
 =?utf-8?B?cDNURlA5TTZTdWF2ME5IaWpBRTdUUFBrRmlxZ25ITXRtRDg0bXZTbGF1R01z?=
 =?utf-8?B?ZDhnS2lGUHpiTjF6NGZXZFFkclJKSEhLL1hmRzN0bmN6MUFRUFN3c1owSHZp?=
 =?utf-8?B?V1FudXRLdGVMeTJUUFVVZmlCaWxPZ3FmTURXRUl1ZE1JQzJXY0l5dmduZzlm?=
 =?utf-8?B?K09QQkxpR1BCbktSN0R5Sk0yRzN1OUIvZDZvdjdnV0U5akdacDRjVFlPdWc2?=
 =?utf-8?B?eGFVQ1ZNSFg1RkJTTEpjYW1TVFo0NG9GOFpaazB2ZWV1Z2hJYzNkQStKbkZD?=
 =?utf-8?B?WFFsNGhNRmd1Qzg3bWFyNzJaaDBlMndVNDlGSGg4QUxSV0NYVENkak4rVHpW?=
 =?utf-8?B?ZUdYNFhjbUYrbTNNWDFZQWdiZ1RnYUNDMXN6WUtpRUV0YWNGTVE0Vkt5U01Z?=
 =?utf-8?B?NGZNdkJRNDRIWTVQN1RtUlFRcEVEcjdIb2Q0dEJxalJEOVh1N0hORGticWRu?=
 =?utf-8?B?MDhOeGxjTTZEbkxHbzI0ZFByK3VmM2srd3gzbUhGTWQwSVVSODNOdXpmaVF1?=
 =?utf-8?B?cnhBWGEvbTlTZ2lsOG1mTnJLM0ZYTlE1WGVKMU9iU2M2VkFQRDUyZWxlbXpv?=
 =?utf-8?B?dEEveFFndDVzNlZOczNDYVdtV0dSUFZBR2ZQNVlUVEl2ZC9xcjZlMWRBZ0pF?=
 =?utf-8?B?aWI3QXRQYk95TC9ZSWxXK1J3Wlo2L1RtSlROMy9xdGtyNzFxSnFCYWxielVm?=
 =?utf-8?B?VmZMVlBZdlBDRGpCMjRIaDdFUmRFYmYrNHVRU3BrZ1NlOWRqZmJ5SHJ2Smc2?=
 =?utf-8?B?UC9KZlpjd3hyTmdydHpPTFdyRnArRGdDV0dhYTBsVmZqSXM0OUVwb2lqaity?=
 =?utf-8?B?cXM4SVRFZXVHZk9xZTdPNm45c2c4V1pZaHBveERIeFNDNmtwbTV2S0RHdE5h?=
 =?utf-8?B?NUN4YmJwSy9wcldrWFhnSERGV3UzaXRzcllNbS9FcUVtRDdHcE5NbzZoTzdM?=
 =?utf-8?B?SitYdFNYN2VtMkZ3VlEyQ2FPMGhweVNteDQ5b3BYdUVCdHlwd1diZktKb2VK?=
 =?utf-8?B?dDAwL3Q4R2hGSEVmMlhVOHdWaWxKSjcwaVNObGs2TEh1OFNFK1dJcVZNYmhG?=
 =?utf-8?B?M0RrV2hlcTZXdTBSZU93Sk9WM1lVZFlScE5xZTFRM3AxaGV0bVlUbTJ1SkZB?=
 =?utf-8?B?SUVoNmZqZEtXNFhZYTJ3NEExandjbHFFVFc1d0Y3OElPd245WFJjNTRIOWdz?=
 =?utf-8?B?WndHazRwQ3ZzMlMrR3lCd2UwS0l3RGx3dTVPTE80S0x0b1U0SUVuVURrZHNB?=
 =?utf-8?B?SXRZM0hsViswL2h5aWZGS3BQdG1jQkx0QUpCSjg0QnJQUHZ2czJ0Q3BOWEFo?=
 =?utf-8?B?Y2FldFB2bWQyc1FYNmpyNEM1QzJ0Um1UM2hJeFZNNVAwanV2NVh1MHM0M0Ra?=
 =?utf-8?Q?yrLZ3yBV4msnpDxwxs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xY4Gld7yATBrpsDCrFQTsxpd6NnzOBjYcbG7wa7nmlmjUd5FNuiQC5BEEsdQq01vAGm2ZKDsk2LFtbOf/KUZ66spfb4c7DE+erY7A1BDlkp9mmT7BA3sOcQhN0F914o0LKMu3WBbYudKo9GarIfqP8Hx6SGF5kg4n5Kb9oBDtboAaLWtVhR7Gq74rejbdkfttKuwslSDrZsJxV7a4uVULu0k7rRMxfnE/JHoRxbcOxltm879hglkYd9I/YlkOH9iJkG0m5F/1gxy9d+jFNZIoAwJGDpw1Dn+2Mfn+nvWXCnDgCqoa5QsT2UhhrBwtUwtEWpUH8baXayBoECKYUvIMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5cfe2a-cc67-4962-ec43-08df1459415e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 01:16:09.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYv3qNKj+OQCty+n7SzVa4Ubh4r963gxyu5ahLCyPolQuwlZoUB0m6mFoDGp1rqBDxHRc+Iq89xJHe0ltq6+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogWmhhbmcsIExpeHUNCj5TZW50OiBG
cmlkYXksIFNlcHRlbWJlciAxMSwgMjAyNiAxOjE3IFBNDQo+VG86IHNyaW5pdmFzIHBhbmRydXZh
ZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPjsgWWlibyBUYW4NCj48bGhm
ZmZAdGp1LmVkdS5jbj47IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPjsgSm9uYXRoYW4g
Q2FtZXJvbg0KPjxqaWMyM0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNz
QGtlcm5lbC5vcmc+DQo+Q2M6IFNoZXZjaGVua28sIEFuZHJpeSA8YW5kcml5LnNoZXZjaGVua29A
aW50ZWwuY29tPjsgbGludXgtDQo+aW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUkU6
IFtQQVRDSCB2MV0gSElEOiBzZW5zb3ItaHViOiBzeW5jaHJvbml6ZSBtdWx0aS12YWx1ZSByZWFk
DQo+Y2FuY2VsbGF0aW9uDQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206
IHNyaW5pdmFzIHBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29t
Pg0KPj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyNiAyOjI5IEFNDQo+PlRvOiBZaWJv
IFRhbiA8bGhmZmZAdGp1LmVkdS5jbj47IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPjsN
Cj4+Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IEJlbmphbWluIFRpc3NvaXJl
cw0KPj48YmVudGlzc0BrZXJuZWwub3JnPg0KPj5DYzogWmhhbmcsIExpeHUgPGxpeHUuemhhbmdA
aW50ZWwuY29tPjsgU2hldmNoZW5rbywgQW5kcml5DQo+PjxhbmRyaXkuc2hldmNoZW5rb0BpbnRl
bC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj5paW9Admdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PlN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjFdIEhJRDogc2Vuc29yLWh1Yjogc3luY2hyb25pemUgbXVsdGktdmFsdWUgcmVhZA0K
Pj5jYW5jZWxsYXRpb24NCj4+DQo+Pk9uIFRodSwgMjAyNi0wOS0xMCBhdCAxOToyMyArMDgwMCwg
WWlibyBUYW4gd3JvdGU6DQo+Pj4gc2Vuc29yX2h1Yl9pbnB1dF9hdHRyX3JlYWRfdmFsdWVzKCkg
cHVibGlzaGVzIGEgY2FsbGVyLW93bmVkIGJ1ZmZlcg0KPj4+IHRvIHRoZSByYXctZXZlbnQgcGF0
aC4gSWYgaXRzIGludGVycnVwdGlibGUgd2FpdCB0aW1lcyBvdXQgb3IgaXMNCj4+PiBpbnRlcnJ1
cHRlZCwgaXQgY2xlYXJzIHBlbmRpbmcuc3RhdHVzIHdpdGhvdXQgdGFraW5nIGRhdGEtPmxvY2sg
YW5kDQo+Pj4gcmV0dXJucy4NCj4+Pg0KPj4NCj4+SGkgTGl4dSwNCj4+DQo+PlBsZWFzZSBnaXZl
IG1lIHF1aWNrIHRlc3QuIENoYW5nZSBpdHNlbGYgbG9va3MgZ29vZCwgbm90IHN1cmUgaWYgd2UN
Cj4+bmVlZCBzb21ldGhpbmcgbW9yZS4NCj5IaSBTcmluaXZhcywNCj4NCj5UaGUgbWFjaGluZSBp
cyBjdXJyZW50bHkgcnVubmluZyBvdGhlciB0ZXN0cy4gT25jZSB0aGV5IGFyZSBkb25lIG5leHQg
d2VlaywgSQ0KPndpbGwgcnVuIGEgcXVpY2sgdGVzdCBvbiB0aGlzIGNoYW5nZSBhbmQgZ2V0IGJh
Y2sgdG8geW91IHdpdGggZmVlZGJhY2suDQoNClRlc3RlZC1ieTogWmhhbmcgTGl4dSA8bGl4dS56
aGFuZ0BpbnRlbC5jb20+DQoNCkkgZGlkIHNvbWUgYmFzaWMgdmFsaWRhdGlvbiBvbiBhIHJlYWwg
SElEIHNlbnNvciBodWIgLyByb3RhdGlvbiBzZW5zb3Igc3lzdGVtIGFuZCBkaWQgbm90IHNlZSBh
IHJlZ3Jlc3Npb24gZnJvbSB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpMaXh1DQoNCj4NCj5UaGFu
a3MsDQo+TGl4dQ0KPg0KPj4NCj4+VGhhbmtzLA0KPj5TcmluaXZhcw0KPg0KDQo=
