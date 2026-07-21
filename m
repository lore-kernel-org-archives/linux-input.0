Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFC2DECA3
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610274; cv=fail; b=TYpeZQaYsiBVwAoSrPhPhvdCIY5Ytda4/kDASh5sAb/kv0MzCmN2vRkw3GUedz5IOVltz/QQ37bwJg62CNmy0jkhqzVL6/jcMXZIasGG2Z+CRR+eld3JE7dy/S2CTCSyakvyVBK5akke+QQiOmh7XIe/yA2FjVjv2TyGyMrvQAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610274; c=relaxed/simple;
	bh=QHkQF3sacen7oG3UQhfzWVXkQiBzbTTrTY779pS3X+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AK4gSrR/TlFxnbvKntdItoKGjODgCd/Kqip0AXfifKRu86CMs5hflq7HBkYj/vtj+MZnyRK23u/AC/Kj/QaDLcSpPXPc67d+FffG6PzosRA1WaHvzE812MzXq1he4+w52NDiPniT7Eph6JRcO8dcvmS+7VutKTpu5d3p+dODXkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcMDcSuN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcMDcSuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784610272; x=1816146272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QHkQF3sacen7oG3UQhfzWVXkQiBzbTTrTY779pS3X+w=;
  b=BcMDcSuNdPrLopPIRE0xfeBLiUdEmEHvZwnn5yb8bz4putLxKnHHk38Z
   5H3ilAKac6cJtWJna1cFm9ywsq8NcZllFHnQ5MRytqQMaYSXSJ7dBWAy/
   EC4hyz47iDa7Hr7Ti3M1RSy086NowhIOfdmc7G/euddwN/uDxjPLMnVT+
   Q08nhkoav2wybGm5oHF9s2HkWpOAXR59pHIGXa9U0aEhUMfwfHq+IafwG
   agYg2vTK/TI0MmkXOYiaUQH+M44TLXJUNJrQeAeFynfDam3nji3VekUTF
   HFKED76I9tSZJGmcrZ/U8CxVB+pz+dXKkadesAfx2dcJl2xfGiSccA5kt
   A==;
X-CSE-ConnectionGUID: A4yol06EQhSxEJU6g5Yliw==
X-CSE-MsgGUID: Qd3PDXtXQe+WuR03qBm5MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87736941"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="87736941"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 22:04:31 -0700
X-CSE-ConnectionGUID: 0T931lkRQqGGLrG14AdBeA==
X-CSE-MsgGUID: UX+4j6IESP63JAWs3W/zTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255011832"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 22:04:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 22:04:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 22:04:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 22:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWUI3YesSGPGSweYFeJcBjEBKKiQ+a7/DFhUADagpoooSb1BvniLhq8+sgwEho4evsi9Lypy9zYGnIhhjeHaOU/yvKmYG68rXunzTL6PVWXJ+79oH3XwAbTB1/zLQj48UwlaE9J2mDdRrP6lMPgIrjvIBIXyPvWwvhEJLa6W5ujE6cDmlX7z8dDJedFZWtQ/hvIhSrWi9AcjI5OUx6O85PJe3bjqwEltotZiJt0Xb6ILyWqMe6DsoztgIigxdTzLxtGRjaIttvh6LFixYE34mqy2bFU4Et8ZoNT6BdHBOjkUnT7UlZTnjnBX3R7vECfjBRiAWr3zwU7gZ+7iUTpvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHkQF3sacen7oG3UQhfzWVXkQiBzbTTrTY779pS3X+w=;
 b=Dv2I98lcfKsHA3JHxuY4NKuabf3Su6FZCdb0R9WFSnAgt8UbLC+Nhpe0aMNL/w9Zoo/A3mxOufzj6A2XSvkASZRSMsHJcanZ41rYKdbO+CtfA0GMU5wOsHdIlytewHjVTh58h/m93ClE50xRtagQtGXwpa6WzmMjB3iOQhanAGA8pHuM2LUY03heCHKOniO0aPTp+cv1Um7eIq3E62VB2uX1GDK9LWKQR0Ffb7RaXKGxAmE/lPy/l4UYHPP4GhDeygFJxQbp71mPrSgaE7D3e64QATZtd7fsm4eh04wlC6//ZNJiVMMgBHSSb/2ItpAn2YWyKM1me2n3T905rWpxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by LV2PR11MB9538.namprd11.prod.outlook.com (2603:10b6:408:378::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Tue, 21 Jul
 2026 05:04:28 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 05:04:27 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Wahid7852
	<wahidzk0091@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>
Subject: RE: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Thread-Topic: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES
 from firmware
Thread-Index: AQHdGHFL7X/YoUxdM0y47RHoMwGmf7Z25I8AgACGsBA=
Date: Tue, 21 Jul 2026 05:04:27 +0000
Message-ID: <SJ0PR11MB561306AD26941EA186A7921393C22@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
	 <20260720175656.559351-1-wahidzk0091@gmail.com>
 <efbf11ebb2faa0a60857408d3b820dffb890666c.camel@linux.intel.com>
In-Reply-To: <efbf11ebb2faa0a60857408d3b820dffb890666c.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|LV2PR11MB9538:EE_
x-ms-office365-filtering-correlation-id: 29e2c75f-6acf-4ec0-b8f6-08dee6e58a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003|6133799003;
x-microsoft-antispam-message-info: woRPq/pb+GtAWftxyplTaW9tX3hPPraZN5BEgdN+AbLrEss/u3KhcTMb2zVGwIwsTMACbuhW4qg42yqOe6C/9Z//c7M0xBB8J5qXy1UMIKgCcs8PfhekGZYgNs7XZ9PRgVVt5Sg3FTojGQqsclpX91bR0TiwFysiU9OgCvgLfMTIlrLu9jN0l0zEj8EkB+SskOi1fNMZuTT4P3TAB5+rsgABVH3TqUnZh4XD96G8jHm/CBMzfnjXqmO+4OSKFAUciJS9UCPaeQNfx8TCzP5e9RPnzVIz1BLvK5qOjZFiHYL/W7fmBW29opH+5aoC8M5SZ6kOpIR2LwVq37DWSzBygqytvtIbWFXVoHqOnd/uzi/KNchcJGANJ00Vu2dzvcZB314NL6IwAp2V5BdyENUiLBUWvf0iw3ZSPcW8Z4Yi76FEbY4aStqTa3g08FwZme7Sn5dMNNlYkoRgDNyBhpfrdKeix58bouG8H0KHNXO2Efjl4pZgHau6zURTCoCTFth62vCG3UZfWaphPXA5Ql5nYtMYXFdaWC7ZzzrZzrmx5xAuCmMnec37gsafW3trGe3qryTzS93Pjm89tMUyWTQlw9raqBUbluQQxnz9QdvAkO6Os0oJ0GRhjNjG6rUbsskbXeuxvewRdWfTWYi864ex9sowxjYGwz6x8P1PzlZ8tr5oMWRW8F33gbVUzRMJhPiOt/ylF9jI+i2/yTOGki5X4o7cBTLcUBsAWoNSLr8n0HI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWU1NGpBMjgwc2xhQm5yTjlOVlVwNEFnWEdmVkVUbXdsL3orNitjTUdsWlgz?=
 =?utf-8?B?UUh6QzVVTTJ2SG01bG9ib3lMTS9reUZ6MGVaWVd2REIrWFdXZmtNU0hxaTJa?=
 =?utf-8?B?bU50RTN0S0NDWjYwNVZKNXp6QUJJdVZMVXFkSWhaQ016cUk2dG9Bb2JzZGdU?=
 =?utf-8?B?RXVaelhOcDlFaEpsaGNiMFphUVcyOGZLcUdZckU4bzRDQjRrSkJWUzdpSzh3?=
 =?utf-8?B?cEdrelhKY3ZUYVhFT3VNM0lLZHpmVVVVVmlncHZOL2hSVXFUcnkyaHZBM2t3?=
 =?utf-8?B?TWtWY2RQZUprODV2aGE2SXJpcG9aNktiUG1VR0t3UEd2NFlCaDdFdWwzVXg1?=
 =?utf-8?B?QmxMcUh6N3lMbks3aVR4R0lFWGdoaXh1TXNZRFhOdXNDV28xV1Z5dzdRbWw3?=
 =?utf-8?B?d2YrRmN1aUI0VFdXcldBbE1DZlJGa0tiZ2RoSjA0anI2ZTllb2wyWkFwV3Rh?=
 =?utf-8?B?ZzVYMzJPLzlQanZ6NUNPZjMyZmtuMWdWL0JFQjhDREtEbGZXNExudldJWjlH?=
 =?utf-8?B?ZUZ2bnFWOFZkSjlhZmxhQnNYajV4cEVrWGdOcDEwTkhoV3pkVkc3NzVyeHBo?=
 =?utf-8?B?YjhVNkVQTzc3UTVBRkZ3eWVtM2UyWkhzZ0MxRW8xUjFLSC9LRFZ3cjg0aVVx?=
 =?utf-8?B?eFBwdHhQcDNhMjBzUGhjajBKRXRDT1F3NWRhVFRySFlRVmRuUHppQmxRcDBt?=
 =?utf-8?B?M0tubjhGR0VwK2U4d0xMVFVDbk1remNHY2o1eDhZeEFvOUhCbmlZOGIrT0Nq?=
 =?utf-8?B?d1VyMDZFamt4Sk9NY1BYcVpuK2lMNk5Cb2VoeExzSjczSEI5cEozMTZlTE1Y?=
 =?utf-8?B?QTh0OVlOM2thUmFMOS9ldHVwMW5STXhTaHd1VVVHdlQvV2RUSDhKckpFcWlM?=
 =?utf-8?B?WUo1M05ETWU5N1pTdkRLOUlMS0lHRHdzbmNtaDZvSUxKYld3Mk1Wdko2QUJY?=
 =?utf-8?B?ZHVyNUlPTTh2VEdxMURudFdGMWlJU3VmclZuWkJuTGkzbmQ2Y0JUeDQ1L2l0?=
 =?utf-8?B?ZEZzcnExamUvRWNpSVF0NVc0aXEycTA2a3RpZHNhZWtEdG9sSTRvSG11ZlRX?=
 =?utf-8?B?UCtTYktNMjZQRGhpTExKeStKZUhoLzhjc2ZEL2NqSzBBcEhkVWdFRGpidUk3?=
 =?utf-8?B?ZmVBd2NCY1h5Y0xuWWlvNzMvY01BT3RyWm5UTTQxdWJTOE9RWUhqeEZ3MzNQ?=
 =?utf-8?B?K0ZZeVl3N05ZZU9udGZXUmtQa090enVBTmdjVTZPSWx6QUhkYlVCbTVlMmhY?=
 =?utf-8?B?THlad0hrWHJBNUkzbmQ2Sld0VkVra25nQ1FjdGtPQStGcUNwd2dNWUJ0dVlZ?=
 =?utf-8?B?dnhuOUZHalh5eUlacTZ0bjdRSUpoVklyVnJDbzRSSUhKQ1FVdzkyaHlKemZZ?=
 =?utf-8?B?YTBHNTY4STZSZzdjUUxFNXNPK1ZBSG1hU1hkVjZjTFh6ZnBBaC81YlQxV01T?=
 =?utf-8?B?bnpwZG5nZHdWSGhHR0ZBZkhPR3FSa1c3NHVkejFpdXA1cWpxMElIRng1Y1ZD?=
 =?utf-8?B?VUVUR1A5UEVMKzJjc0tVWGJrekpad2xEa1ppWFl2a0s0OGhVVEJhQngrUUNC?=
 =?utf-8?B?MTBvVWxFUVRQVHJSSmhwc3dFSjBEVEp4bi8yNVVsUElMcXREa3BmSzZmRWFk?=
 =?utf-8?B?Z3FkcXpNak92QTNqcElRVGZPWmF2YW94S05Pb1ZVMW9ZblpzbHN6eXZKVkpy?=
 =?utf-8?B?NEZRWDYvSkxTR2dLMWZBSG8xWEVKM3VPa0hTZWh4eDU3V3kwU1lrdncwaUJo?=
 =?utf-8?B?Nkc5OXhWUU9GNG1KQXJjMkVkR2w4SEdwK3R5blZFRGRIMXpHaXMrNlFCVWhh?=
 =?utf-8?B?YmtGQWJGNUtSQ2JGWldpbFd4WWJHSStXUXhHNnBrVWlhRG96WjRkUEpqRUVi?=
 =?utf-8?B?SWpiY3h3UUtaa0N6UW12VGVLUlJBMGZDQU1OMndQNFNxdHNLd09zV3doQkM2?=
 =?utf-8?B?L2pZbHA3SFpXdnBXTHcreTIzU2FmQjUvNmoxMk1uWkdwOG90NXg5K0hydnVk?=
 =?utf-8?B?T2JJSkcwUjZ4NFlvcTY1MGVzdEpDb29lNkVwQjhlM29lbVZsQUMrZGt4Sno3?=
 =?utf-8?B?OTF4T2ZKZVZ5RWJ4M0REV0ZqVWpwZHZZdzZ4NWpNaWRnUSttbEpUUkFVL3FK?=
 =?utf-8?B?MXFUTy9PTEcyZFJVdCtxd015UkozY0hSL0xmUUcyS1VzS2N0RHdrcnd1TUhl?=
 =?utf-8?B?b3hlN1AzSlpFb2N0ejh5eWZXQmFna2pVZDhIblZFZ2xiTkl4ZFRXdHBuK1ZX?=
 =?utf-8?B?bHJGdUowOUNhcFdYSmRmLzloMk1TUGg2MThNK09Mckt4RFloNGhITVNQUzFx?=
 =?utf-8?Q?XDuDhCSCqgIjzZKMVu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VWdvRDoh1hsULUloWTjSDQxY6V57slCF5BRN4DqIWfKFnrLFU53pIvouJVh/HGVTaSZiu5T4VYqTq/qkCK7C2C8pUQgOvzGJVwQAVWn7jFlmrnWJO/v0wxEDi/WfHbqJoj4V7axzWfpP6k4y6G7F4YueiNsAT9qH3JOFj0u1uFUqUxcUzOT6/nohfGd6WOaa5nuNDhA2/OHCWF5TRbPSun017wKh/AOGi69ogYNS7g1hTT3JN0KSyWGnkp5aFK/0CE+MZ1s+eKVrHRpDDRxIOn2/+IyI/mf82a2xf/zl94Xd8Uhfz6IEMrAtSbowyXzDLAXw/U0qIm2xLpsU/MmfZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e2c75f-6acf-4ec0-b8f6-08dee6e58a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 05:04:27.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peleqsbj8ha0CPSxG684l4k8SAlsHWOSNEyDliM7EG4hoZTVwqIu19zwdFLU0Kdkn78kCj40qfOYYvZsLk4QOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9538
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogVHVlc2RheSwgSnVs
eSAyMSwgMjAyNiA1OjAwIEFNDQo+VG86IFdhaGlkNzg1MiA8d2FoaWR6azAwOTFAZ21haWwuY29t
PjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+Q2M6IGppa29zQGtlcm5lbC5vcmc7IFpo
YW5nLCBMaXh1IDxsaXh1LnpoYW5nQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBISUQ6IGludGVsLWlzaC1oaWQ6IGlnbm9yZSBwb3N0LWluaXQgRU5VTV9ERVZJQ0VTIGZyb20N
Cj5maXJtd2FyZQ0KPg0KPk9uIE1vbiwgMjAyNi0wNy0yMCBhdCAyMzoyNiArMDUzMCwgV2FoaWQ3
ODUyIHdyb3RlOg0KPj4gRnJvbTogV2FoaWQgS2hhbiA8d2FoaWR6azAwOTFAZ21haWwuY29tPg0K
Pj4NCj4+IFNvbWUgSVNIIGZpcm13YXJlIHZlcnNpb25zIChvYnNlcnZlZCBvbiBUaWdlciBMYWtl
IExQLCA4MDg2OmEwZmMsIEdVSUQNCj4+IHszM0FFQ0Q1OC1CNjc5LTRFNTQtOUJEOS1BMDREMzRG
MEMyMjZ9KSBwZXJpb2RpY2FsbHkgcmUtc2VuZCBhbg0KPj4gdW5zb2xpY2l0ZWQgSE9TVElGX0RN
X0VOVU1fREVWSUNFUyByZXNwb25zZSByb3VnaGx5IGV2ZXJ5IDc5IHNlY29uZHMuDQo+Pg0KPj4g
VGhlIGN1cnJlbnQgZ3VhcmQgY29sbGFwc2VzIHR3byBkaXN0aW5jdCBjYXNlcyBpbnRvIG9uZSBj
b25kaXRpb246DQo+Pg0KPj4gwqAgaWYgKCEocmVzcG9uc2VfZmxhZykgfHwgaW5pdF9kb25lKcKg
IC0+wqAgYmFkIHBhY2tldCArIGlzaF9od19yZXNldA0KPj4NCj4+IFRoaXMgaW5jb3JyZWN0bHkg
dHJlYXRzIGEgdmFsaWQgcG9zdC1pbml0IGZpcm13YXJlIGFubm91bmNlbWVudCBhcyBhDQo+PiBj
b3JydXB0ZWQgcGFja2V0LCB0cmlnZ2VyaW5nIGFuIElTSCBzb2Z0LXJlc2V0IGFuZCBhIGZ1bGwg
SVNIVFANCj4+IHJlLWluaXRpYWxpc2F0aW9uIGN5Y2xlIG9uIGVhY2ggb2NjdXJyZW5jZSAofjEx
MDAgdGltZXMgcGVyIGRheSBvbg0KPj4gYWZmZWN0ZWQgaGFyZHdhcmUpLg0KPj4NCj4+IFNwbGl0
IHRoZSBjaGVjazogcmVqZWN0IG1lc3NhZ2VzIHdpdGggbm8gcmVzcG9uc2UgZmxhZyBhcyBiZWZv
cmUsIGJ1dA0KPj4gc2ltcGx5IGRpc2NhcmQgdmFsaWQgRU5VTV9ERVZJQ0VTIG1lc3NhZ2VzIHRo
YXQgYXJyaXZlIGFmdGVyIGluaXQgaXMNCj4+IGNvbXBsZXRlLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFdhaGlkIEtoYW4gPHdhaGlkemswMDkxQGdtYWlsLmNvbT4NCj4NCj4gICAgQWNrZWQtYnk6
IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29t
Pg0KDQpUZXN0ZWQtYnk6IFpoYW5nIExpeHUgPGxpeHUuemhhbmdAaW50ZWwuY29tPg0KDQo+DQo+
DQo+TGl4dSwgcGxlYXNlIGFkZCB5b3VyIHRlc3RlZCBieS4gSSB0aGluayB5b3UgYWxyZWFkeSB0
ZXN0ZWQgdGhpcy4NCg0KWWVzLCB0aGFua3MuDQoNCkJlc3QgcmVnYXJkcywNCkxpeHUNCg0KPg0K
PlRoYW5rcywNCj5TcmluaXZhcw0KPg0KPj4gLS0tDQo+PiB2MjogYWRkZWQgcHJvcGVyIHNpZ24g
b2ZmDQo+Pg0KPj4gwqBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRwLWhpZC1jbGllbnQu
YyB8IDUgKysrLS0NCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9p
c2h0cC1oaWQtY2xpZW50LmMNCj4+IGIvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pc2h0cC1o
aWQtY2xpZW50LmMNCj4+IGluZGV4IDZkNjQwMDhmMi4uZWM1ZThhZmU3IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pc2h0cC1oaWQtY2xpZW50LmMNCj4+ICsrKyBi
L2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXNodHAtaGlkLWNsaWVudC5jDQo+PiBAQCAtMTEz
LDggKzExMyw3IEBAIHN0YXRpYyB2b2lkIHByb2Nlc3NfcmVjdihzdHJ1Y3QgaXNodHBfY2wNCj4+
ICpoaWRfaXNodHBfY2wsIHZvaWQgKnJlY3ZfYnVmLA0KPj4NCj4+IMKgCQlzd2l0Y2ggKHJlY3Zf
bXNnLT5oZHIuY29tbWFuZCAmIENNRF9NQVNLKSB7DQo+PiDCoAkJY2FzZSBIT1NUSUZfRE1fRU5V
TV9ERVZJQ0VTOg0KPj4gLQkJCWlmICgoIShyZWN2X21zZy0+aGRyLmNvbW1hbmQgJiB+Q01EX01B
U0spIHx8DQo+PiAtCQkJCQljbGllbnRfZGF0YS0+aW5pdF9kb25lKSkgew0KPj4gKwkJCWlmICgh
KHJlY3ZfbXNnLT5oZHIuY29tbWFuZCAmIH5DTURfTUFTSykpIHsNCj4+IMKgCQkJCSsrY2xpZW50
X2RhdGEtPmJhZF9yZWN2X2NudDsNCj4+IMKgCQkJCXJlcG9ydF9iYWRfcGFja2V0KGhpZF9pc2h0
cF9jbCwNCj4+IHJlY3ZfbXNnLA0KPj4gwqAJCQkJCQnCoCBjdXJfcG9zLA0KPj4gQEAgLTEyMiw2
ICsxMjEsOCBAQCBzdGF0aWMgdm9pZCBwcm9jZXNzX3JlY3Yoc3RydWN0IGlzaHRwX2NsDQo+PiAq
aGlkX2lzaHRwX2NsLCB2b2lkICpyZWN2X2J1ZiwNCj4+IMKgCQkJCWlzaF9od19yZXNldChpc2h0
cF9nZXRfaXNodHBfZGV2aWNlKA0KPj4gaGlkX2lzaHRwX2NsKSk7DQo+PiDCoAkJCQlicmVhazsN
Cj4+IMKgCQkJfQ0KPj4gKwkJCWlmIChjbGllbnRfZGF0YS0+aW5pdF9kb25lKQ0KPj4gKwkJCQli
cmVhazsNCj4+IMKgCQkJY2xpZW50X2RhdGEtPmhpZF9kZXZfY291bnQgPSAodW5zaWduZWQgaW50
KSpwYXlsb2FkOw0KPj4gwqAJCQlpZiAoIWNsaWVudF9kYXRhLT5oaWRfZGV2aWNlcykNCj4+IMKg
CQkJCWNsaWVudF9kYXRhLT5oaWRfZGV2aWNlcyA9DQo+PiBkZXZtX2tjYWxsb2MoDQo+PiAtLQ0K
Pj4gMi41NC4wDQo=
