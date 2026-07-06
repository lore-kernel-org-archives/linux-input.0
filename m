Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084E37F724
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305011; cv=fail; b=LQA5Jd8OkED5pARDpksa4YZBueEdy8gisO/5i9L5tVUuRF0pkfLGD/0bqfI4b6etQNffJztROEwLgVisZnLe2g8J1tpfAb/mjlCxv4ZGonbys5ICVVY1d05kicay+bMti1MpHLuJ0VIzJJy0H1vI5ex8wkE8XZkmQdTZtUBNtvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305011; c=relaxed/simple;
	bh=6f+NFSBy+NszkTsKaLId3i8RgILIrLwqtbVrTkh1/no=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAMJgWuQ0rnRVPxPVptLeoP8+FgtH1FDpk+gMhulTRTgKdo5yKqYaZfDWhMysQO51ECoLiOVA0+ylD7BK1c2khMDK9Ng+UfMAQVlUQuITS1MJkcdEhWgK2PPGpO4klljbCSQ0epscOg/L4wHPxq/c38EYGDQOYiTQM6fy0MJr6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kklSYI5S; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kklSYI5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305008; x=1814841008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6f+NFSBy+NszkTsKaLId3i8RgILIrLwqtbVrTkh1/no=;
  b=kklSYI5Saa+yDncGzjUM/ylBsvj+AVpVdU66BwEDXPWN+dhuQm4QF5NA
   9AHcyOk3erWpBBrtXKQilWJBvGxm//aDmh4VNKlPhopm2aqpZd1Smusi6
   vkqUdlLbZDLGgbGC9CMlIcYMeWLdfLc9MHSVZMjzbbJ51gZn+lv3G7/WI
   TQLndTrMiq6kpHe+iUkCg2kJhmWqcyIKebH8grU6q/EcjOqheWLnxtsR3
   l/iP/y/fcTQH09Ys9b78geGjjUogrEXVYgAJSFQqnKPhFmjN3FT0NEbe9
   h0zbGUDMUGwXxk3OuvHHKfdjFD7WEEf4rZbEmjbyWn5OIV6P/QbdjmBpY
   g==;
X-CSE-ConnectionGUID: E9K/509hR3G0VOLle9kCmw==
X-CSE-MsgGUID: p7wo3kPoROiGVv2m0Q5qrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83802487"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83802487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:30:08 -0700
X-CSE-ConnectionGUID: 8M4PXdu4Q6+y4bcxwyHifw==
X-CSE-MsgGUID: y950LLv+T4CZBpvjMXPmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="255526640"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:30:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 19:30:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 19:30:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 19:30:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqk6vMWJQody9Wuo004zjj6WvHwFS3XjGKKEnR0b/7zfn9sERqq6s57AwP2SEcBObjPGaGZNnoSmFT5/bt62R4PGq0LIRWrPZQ3h94gCNkNlRDj8pR8QLnWU9HyIo53pxEK7g4g00r95oJ6M650uaArK2L0IGFLHtvrLDBx1KgAu5R7eFClDglYNV8vnkTWM2o/c2P+iPf3KcjoAaqrZbe3w5kaCJl1gtCQNi/YGbfXJ1wnqeTBYmo0Xs5LL0TU2EqJtmuYFOc/1k58fl2+Dkf+ehb2CiM+vXuJk3voHfDIrvPBY6jXDkMPwRVy9UYtgLUNaG6ah/JZg+kzO3baEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f+NFSBy+NszkTsKaLId3i8RgILIrLwqtbVrTkh1/no=;
 b=P/lMC3Km0CcuSqbPWrOIv5ovguyUe+HOdQ/FbBvtQgXuDy2ko1orh6fdPbMWy8tgRlSfxaEIFdFoFOMvqjnLR2OAkWtecQ46QP1TEgSWHHJdL4TuGPBmQ3LE6q9LsbApDaT6bWly1lN3gVamHBcZ8spAFDI1FFvHN4MtJ31iIrqecz2n7iFRaWYCK8+JU0yu8TjYfBKmFBs9oK9amftOPSgm1mngDg5vP3qlNFACcAtvwt4NC2u2kMOASSCHIMYoxmojHCvfhzueDGpMlsjiJbIQgHAPMxC3fcr98aH7vuKNLx7xuonFusmFzhUE4eKfBaExrJ4yWguXcrhskpqYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 02:30:05 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 02:30:04 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover
 callback
Thread-Topic: [PATCH v2 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine
 recover callback
Thread-Index: AQHdCsHIretbT2B6uE29RkzqQIvSmbZbcWwAgARVswA=
Date: Mon, 6 Jul 2026 02:30:04 +0000
Message-ID: <IA1PR11MB6098AE55BF6200B9E0F35055F4F12@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
 <20260703075858.2780398-3-even.xu@intel.com>
 <20260703081055.101CA1F00A3A@smtp.kernel.org>
In-Reply-To: <20260703081055.101CA1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|LV1PR11MB8850:EE_
x-ms-office365-filtering-correlation-id: 3485ba37-ecf9-4f1e-fecb-08dedb067d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|5023799004|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: l000sAgfj66zuotSsx5Xq80wdcCoKrDbTGXVyEbo5Xzn360lzAhyWZQUCr4EB/6mzKbU09SKHIbp3iWDCzf8bNDUvQ6MjYc2eNX0ygD6oK2fEYJZwuZdZA0G+nAg4XhhJlC+JJA18zlZHzOF2Svh4EBukfCwG5W3mVxxy8WxIs3ZCBoBIfoaijKjiCgn1st/T0HMGESSJz7i/P/wUf7DC6pkpdUqSZWzLxU3oeSHefl2h3aNNSzB5uwjqrFBKkLhLLJteStYRKnJwIVQq8pYB3oyFDWfRoQ/7RP2pkk9FiynspbsCE/NelLEQ190wRGYujYKyFleYhipIWG1Q+h/7nFSrPEwpczv9avcI/Ij7x7pnMpPnZEcPe43DYn45JNWdsnVZYK7KcP+17QTu0wYHHdvq3vjWl0M4bgFozRdG6qfuFP912CDLXVqPGMj/WGURNoNJPe+iezixVnAiHkqvzsG9twenyzQ32B27e1Yese4tPT+unoH4vshhGLbB3MRAfsdQa/6ElKOrxJ34pn+jO6XcDNnrM1ulVk8dUnnp8qQkH7wugbYlaDE5jWH7gOh6lljr7iZZPxD6i+Jom/bN1PSe/BRYDS558Ofz7npr16keiSnErA+Zfzw6oV1C6BdcPe0D9R1vQzGtEN/hVWpr/nWdcdTc+b0lDSHVvObLZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NitDejlFbGFoaElUblh0bnFHVHFQM1JaZ0lLRWJweVNteU5oTlVka3JEK2hP?=
 =?utf-8?B?TkhzN1pYejcybENmcW9XMzFiZ2hmWnVTd1ZBT1IrUTJzTHZTMDYrc1RybTli?=
 =?utf-8?B?U2RNUW5XTS9kRjBCZm1nMVpjQllzd0UyNTNIOXZ4SExJL20ySU95czNNOHVj?=
 =?utf-8?B?emEyQjR3bjVzNGhHV2MyWmo1aVhBbzRRV3J2NHo1TmFqT1Jnd1BxbzBBL21Z?=
 =?utf-8?B?eURTUjNPTkJVMXZOdWhhUDM4eXdadDhXQmFMcXl2UkZFRDRyc1k2QUw3MmxH?=
 =?utf-8?B?Q3hiSkp6VGl6TXFBdTVjblZLV3BKaVd6cmZIZ2V6cEtROWtKbjU1cFNZU3Bs?=
 =?utf-8?B?cjZZcHBrTk41M3ErQzV4b1c1ZytPVldDeDQ0WU1VMVdvL3VtbUxER3BzbTFH?=
 =?utf-8?B?MzZBNHlSQktJQzJpU0NCK3BJT0ZjV3hRQ0R0dVlhaFRocEg1bUt5WVl5dm94?=
 =?utf-8?B?UUxpbEFyRVJzMklXZ1Vwc3ZIbFZkWGVrTzBJRUJMd3grY05LeWNmRnMrNUR5?=
 =?utf-8?B?Smg1b1hzeHpva0c2eWxtV29ZU1V5OWR3OHY4MDh1aFdqZm8xd0gwb05UYS8v?=
 =?utf-8?B?ZnJHM1N3c3grNlNFS0tIUm9xUVlJVExyZjQ5ZmpEc1BLYktnZHdSQjdaTUVT?=
 =?utf-8?B?dU5QNlNkRktQZi9jRGZ3UHhWdDZrZHNxWmNFSHF3L0VjeWhzWXpPL1lkS1RH?=
 =?utf-8?B?eHRvNkpaK1J1ZFRMenVDaXhMdUpyUXdNS2FFeVJmbHhVWm1oVkpPNmJkaFdz?=
 =?utf-8?B?NmNvVXdXYkhlSFFHckdhS0lyeXJ6S2l1OEh1RTNhaDhuemNhaUFwN1NUS0ZI?=
 =?utf-8?B?WnIwNGhUUnJjWm82QmVKR0ozZHhTUmd1VGJOT0lJYmZuWVVRQldFdEZuUS9Z?=
 =?utf-8?B?bGNtQS8rYnFIVkdzQ3Y2dVE4eERXWHBtSzFuN0NMZUU1RHE3OWpsT2FBb2JR?=
 =?utf-8?B?QlY1ZjZBNkN0WXdTK2RKYnFmYU5lZlB1a3JjM0xSTERLL1kxTlF0NTFHSlI5?=
 =?utf-8?B?ak04RWVEUEtuZUIxVGpEdktVb2FDaEkzNloyTTFFK2xRbnZJNjZqa3lYNlNp?=
 =?utf-8?B?amRoTzFGTGxvNURCMENVZXZJWkNQUFFjbExRTUZiYzFGMGROZmhWRmJ2bndV?=
 =?utf-8?B?VVFYWE05TWwzT3VKTlJIYjVjU3FGcWZJOGliYVpSMldSN1ljUUtVRVJ4MXc0?=
 =?utf-8?B?dmFpMXdkRWgxU0EvNWtQbnhrbVkwdlZ5MG9LZWZhNytRTnFLMXA0bSsvUklP?=
 =?utf-8?B?VS9CZnhpaFpqc0ZHOVVMTFZqRmpjaWUwaEFNZTdzN0dmNHJXNlBWVWI5Mmhy?=
 =?utf-8?B?RVpJR21VZExyNGR1ZTV5QW43aFJGZ2NMNS9lTG1yOU5GNzljYnh5VEhLYmFD?=
 =?utf-8?B?ZGJqSGVUbE9qeTQ3ZVgvNkhNOTQyVmpqUGpGNzVELzdCV1J0MFRxYm54Tno4?=
 =?utf-8?B?RkpWdTR4RzNsSFdUTDRvNE9sYzFnRDUwMHZBTWF3NTYyWGowcW5wY2Y5aS9o?=
 =?utf-8?B?eXdGcWF4UXBnK0dhc0RDUmNyVGxZZUFuek1ZVDBYYzBUZXNWaEp1TC83YXdJ?=
 =?utf-8?B?eXc4SUhqQW1nWThVSUNVdVUwN1ZuNThrZUYrSUNIN3A0NTJ3MGs1TVp4Z24v?=
 =?utf-8?B?ZXd0alZaaFA1MkhYYXZ4cU4yZ28wZ2srVm9VTVh3Z1JGYkNaS1pyQm1xQUNB?=
 =?utf-8?B?Q0tZdld0Z1NGSGNuVXAvdExpVmJiQzNSTkhhQlBDRlpFRnkyeklmZy9RZEZX?=
 =?utf-8?B?Tm03MXFydERwd2g0R0lXM1VOTmNTb2kzOHJGazZLVVpuLzlFaHQ2R1dMZDZB?=
 =?utf-8?B?b2l0aWQ3bER0VEpXMzV6M1dVa28zY2F4aXJFaE80WFJKaEtpNjRYVm1YMmFr?=
 =?utf-8?B?dU5nSFRMaXhGWFdpMEZJdzRDaHhqNWIwSW5xZjdlOTV2YWU4cXhUOXVRUUhO?=
 =?utf-8?B?N3hBeEJ2Kzd6azAySWVsbVlabzFMUHZUcjhwZHAva0dQaERwVHM3WTl1QVo5?=
 =?utf-8?B?UGFRMk9sN1E1SjA4K1ZNQlpIVzNFK2pzamhBcVY0a1Z4MnZHZTNMWklsdjdj?=
 =?utf-8?B?cEV5Ui84cVdMRzZOSlNBYjVTYXFKQldvYjhMVW5Od0MvU0hGL2J5V2dzMm8y?=
 =?utf-8?B?MWxKbi9DK3FyeGRSM3QvdFJWZk9wZVNVRlE4RENCMitMUUJOYXpmZHpJVmFI?=
 =?utf-8?B?a3lIYWl4S3pFVmdwTVh6TVpkRTZRRE1iU05vbjFpdGNWYldITzZaTHJlSWJ6?=
 =?utf-8?B?MXQwSzR4TkQ3ZllIbTNFTmpVQnl2aXB4ZHVqc0xDbGp6Z3AxSENwOG1WQU56?=
 =?utf-8?Q?MxihFGs9dG+fYSSzeg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G44/haPaL+uL5/fpNUCQNyjDKkDavl8gC4PYVYfOLqpUnzia/l/P6CBlXmM3ZHPCv+P0FTzF5IbvHguqQmLiiEjr0aPdNnZ8d7+VosS3nC3jvmVercFFeVw2ljZx0o0QDxsBA2ph9cCc6whqmEsmegvqDmPeogxLWK5OVpq6wCGuxQbQrBBOHVYHddzNhPVHdpWqsN4juIcNKG9eYPrEpsN0PQpyK1c0pVH/AfAWvH2lfq+ZryY+lQJEWWEvtTamDJtlI9HhTEpXlBX3F3b6B9CgLDKOJ5grEoJucGQeFBsbuojinHw11dTFjhfw+O4wvWy7lXXW7R6crOmgYp8FVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485ba37-ecf9-4f1e-fecb-08dedb067d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 02:30:04.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDBN8E3mSOvxGob2rkgiRp6sIPVgixf7D6dulnfXyyhMDpsQsUZYfCU8WRKcfYHzNbeLugFvwY4tqN2WV5nYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDMs
IDIwMjYgNDoxMSBQTQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBDYzog
ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBISUQ6IEludGVsLXRoYy1oaWQ6IEludGVsLXF1
aWNraTJjOiBSZWZpbmUgcmVjb3Zlcg0KPiBjYWxsYmFjaw0KPiANCj4gVGhhbmsgeW91IGZvciB5
b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMyBwb3RlbnRpYWwgaXNz
dWUocykgdG8NCj4gY29uc2lkZXI6DQo+IA0KPiBOZXcgaXNzdWVzOg0KPiAtIFtIaWdoXSBVc2Ut
QWZ0ZXItRnJlZSBkdWUgdG8gcHJlbWF0dXJlIGBjYW5jZWxfd29ya19zeW5jYCBkdXJpbmcgZGV2
aWNlDQo+IHJlbW92YWwgYW5kIHNodXRkb3duLg0KPiANCj4gUHJlLWV4aXN0aW5nIGlzc3VlczoN
Cj4gLSBbSGlnaF0gTWlzc2luZyBgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMoKWAgaW4gcHJvYmUgZXJy
b3IgcGF0aHMgYW5kIGRldmljZSByZW1vdmFsDQo+IGxlYWtzIElSUSByZXNvdXJjZXMuDQo+IC0g
W0hpZ2hdIFRoZSBoYXJkIElSUSBoYW5kbGVyIGFjY2Vzc2VzIGhhcmR3YXJlIHJlZ2lzdGVycyB1
bmNvbmRpdGlvbmFsbHksDQo+IHZpb2xhdGluZyBQTSBzdWJzeXN0ZW0gZ3VpZGVsaW5lcy4NCj4g
LS0NCj4gDQo+IGNvbW1pdCBlODhkYTlkNDA1NjJmNWQwYmU3NTU1NjhhZTYwMDEwYTdiYTkyNWRm
DQo+IEF1dGhvcjogRXZlbiBYdSA8ZXZlbi54dUBpbnRlbC5jb20+DQo+IA0KPiBISUQ6IEludGVs
LXRoYy1oaWQ6IEludGVsLXF1aWNraTJjOiBSZWZpbmUgcmVjb3ZlciBjYWxsYmFjaw0KPiANCj4g
VGhpcyBjb21taXQgcmVmaW5lcyB0aGUgcmVjb3ZlciBmbG93IGJ5IG9mZmxvYWRpbmcgaXQgdG8g
YSB3b3JrcXVldWUgaW5zdGVhZCBvZg0KPiBwcm9jZXNzaW5nIGl0IHdpdGhpbiB0aGUgSVJRIGhh
bmRsZXIuIEl0IHNpbXBsaWZpZXMgdGhlIG9wZXJhdGlvbiB3aXRoIGEgcmVzZXQgQVBJDQo+IGFu
ZCBlbnN1cmVzIGludGVycnVwdHMgYXJlIGRpc2FibGVkIGR1cmluZyB0aGUgcmVjb3ZlcnkgcHJv
Y2Vzcy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50
ZWwtcXVpY2tpMmMvcGNpLXF1aWNraTJjLmMNCj4gPiBiL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1o
aWQvaW50ZWwtcXVpY2tpMmMvcGNpLXF1aWNraTJjLmMNCj4gPiBpbmRleCA0NmQzZTlhMDE5OTk1
Li4xMWUwZTEyOWI0NGMzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1o
aWQvaW50ZWwtcXVpY2tpMmMvcGNpLXF1aWNraTJjLmMNCj4gPiArKysgYi9kcml2ZXJzL2hpZC9p
bnRlbC10aGMtaGlkL2ludGVsLXF1aWNraTJjL3BjaS1xdWlja2kyYy5jDQo+ID4gQEAgLTI0NSwy
OCArMjQ1LDI4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdA0KPiA+IHF1aWNraTJjX2lycV9xdWlja19o
YW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkgIH0NCj4gDQo+IFtTZXZlcml0eTogSGlnaF0N
Cj4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGRvZXMgcXVpY2tpMmNfaXJxX3F1
aWNrX2hhbmRsZXIoKSBhY2Nlc3MNCj4gaGFyZHdhcmUgcmVnaXN0ZXJzIHVuY29uZGl0aW9uYWxs
eT8NCj4gDQo+IElmIHRoaXMgZGV2aWNlIHNoYXJlcyBhbiBJTlR4IGludGVycnVwdCBsaW5lLCBh
IHNwdXJpb3VzIGludGVycnVwdCBmcm9tIGFub3RoZXINCj4gZGV2aWNlIGNvdWxkIGNhdXNlIHF1
aWNraTJjX2lycV9xdWlja19oYW5kbGVyKCkgdG8gZXhlY3V0ZS4gSXQgdGhlbiBjYWxscw0KPiB0
aGNfaW50ZXJydXB0X2VuYWJsZSgpIHdoaWNoIHdyaXRlcyB0byBtZW1vcnktbWFwcGVkIHJlZ2lz
dGVycy4gSWYgdGhlIGRldmljZSBpcw0KPiBpbiBhIGxvdy1wb3dlciBzdGF0ZSwgdGhpcyBoYXJk
d2FyZSBhY2Nlc3MgY2FuIHRyaWdnZXIgYSBidXMgZmF1bHQuDQo+IA0KPiBTaG91bGQgcG1fcnVu
dGltZV9nZXRfaWZfYWN0aXZlKCkgYmUgdXNlZCB0byBjaGVjayBpZiB0aGUgZGV2aWNlIGlzIGFj
dGl2ZSBiZWZvcmUNCj4gdG91Y2hpbmcgdGhlIGhhcmR3YXJlIHJlZ2lzdGVycz8NCj4gDQo+IFsg
Li4uIF0NCj4gDQo+ID4gQEAgLTc3MSw2ICs3NzEsOCBAQCBzdGF0aWMgdm9pZCBxdWlja2kyY19y
ZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gIAlpZiAoIXFjZGV2KQ0KPiA+ICAJCXJl
dHVybjsNCj4gPg0KPiA+ICsJY2FuY2VsX3dvcmtfc3luYygmcWNkZXYtPnJlY292ZXJfd29yayk7
DQo+IA0KDQpUSEMgcnVudGltZSBwbSBkb2Vzbid0IHB1dCBUSEMgaW50byBEMywgVEhDIHJlZ2lz
dGVycyBjYW4gYmUgYWNjZXNzZWQgYWxsIHRoZSB0aW1lLg0KDQo+IFtTZXZlcml0eTogSGlnaF0N
Cj4gQ2FuIHRoaXMgc2VxdWVuY2UgbGVhZCB0byBhIHVzZS1hZnRlci1mcmVlPw0KPiANCj4gY2Fu
Y2VsX3dvcmtfc3luYygpIGlzIGNhbGxlZCBoZXJlLCBidXQgaGFyZHdhcmUgaW50ZXJydXB0cyBh
cmUgbm90IHlldCBxdWllc2NlZCwNCj4gYW5kIHRoZSBzdGF0ZSBpcyBzdGlsbCBhY3RpdmUuIElm
IGFuIGludGVycnVwdCBmaXJlcyBpbW1lZGlhdGVseSBhZnRlcg0KPiBjYW5jZWxfd29ya19zeW5j
KCksIHF1aWNraTJjX2lycV90aHJlYWRfaGFuZGxlcigpIGNhbiBleGVjdXRlIGFuZCBjYWxsOg0K
PiANCj4gICAgIHNjaGVkdWxlX3dvcmsoJnFjZGV2LT5yZWNvdmVyX3dvcmspOw0KPiANCj4gVGhp
cyByZS1lbnF1ZXVlcyB0aGUgd29yayBpdGVtLiBBZnRlciBxdWlja2kyY19yZW1vdmUoKSByZXR1
cm5zLCBkZXZyZXMgZnJlZXMNCj4gdGhlIHFjZGV2IHN0cnVjdHVyZS4gV2hlbiB0aGUgc2NoZWR1
bGVkIHdvcmsgbGF0ZXIgZXhlY3V0ZXMsIGl0IHdpbGwgZGVyZWZlcmVuY2UNCj4gdGhlIGZyZWVk
IHFjZGV2IHBvaW50ZXIuDQo+IA0KPiBTaG91bGQgdGhlIHdvcmsgYmUgY2FuY2VsbGVkIGFmdGVy
IGludGVycnVwdHMgYXJlIGRpc2FibGVkIGFuZCB0aGUgZGV2aWNlIHN0YXRlIGlzDQo+IHNldCB0
byBRVUlDS0kyQ19ESVNBQkxFRD8NCj4gDQo+ID4gIAlxdWlja2kyY19oaWRfcmVtb3ZlKHFjZGV2
KTsNCj4gPiAgCXF1aWNraTJjX2RtYV9kZWluaXQocWNkZXYpOw0KPiA+DQo+ID4gIAlwbV9ydW50
aW1lX2dldF9ub3Jlc3VtZShxY2Rldi0+ZGV2KTsNCj4gPg0KPiA+ICAJcXVpY2tpMmNfZGV2X2Rl
aW5pdChxY2Rldik7DQo+ID4NCj4gPiAgCXBjaV9jbGVhcl9tYXN0ZXIocGRldik7DQo+ID4gIH0N
Cj4gDQoNCkdvb2QgZmluZGluZyENCkluIGZhY3QsIEkgaGF2ZSBhbm90aGVyIHBhdGNoIGZvciBy
ZW1vdmUoKSBhbmQgc2h1dGRvd24oKSwgaWYgc28sIGxldCBtZSBjb21iaW5lIHRoZW0gaW50byB0
aGlzIHBhdGNoLg0KDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpcyBhIHByZS1leGlzdGlu
ZyBpc3N1ZSwgYnV0IGRvZXMgcXVpY2tpMmNfcmVtb3ZlKCkgbGVhayBJUlEgcmVzb3VyY2VzPw0K
PiANCj4gVGhlIHJlbW92ZSBwYXRoIHVuYmluZHMgdGhlIGRldmljZSBidXQgZG9lc24ndCBhcHBl
YXIgdG8gY2FsbA0KPiBwY2lfZnJlZV9pcnFfdmVjdG9ycygpLiBTaW1pbGFybHksIGlmIHF1aWNr
aTJjX3Byb2JlKCkgZmFpbHMgYWZ0ZXINCj4gcGNpX2FsbG9jX2lycV92ZWN0b3JzKCksIHRoZSBl
cnJvciBwYXRoIChkaXNhYmxlX3BjaV9kZXZpY2UpIGRvZXMgbm90IGZyZWUgdGhlDQo+IHZlY3Rv
cnMuDQo+IA0KPiBSZXBlYXRlZCB1bmJpbmQvYmluZCBvcGVyYXRpb25zIG9yIHByb2JlIGRlZmVy
cmFscyB3aWxsIGNvbnRpbnVhbGx5IGxlYWsgdGhlc2UNCj4gdmVjdG9ycywgd2hpY2ggY2FuIGV2
ZW50dWFsbHkgZXhoYXVzdCBzeXN0ZW0gSVJRIGNhcGFjaXR5Lg0KPiANClRoaXMgc2FtZSBhcyBh
Ym92ZS4NCg0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2
LyMvcGF0Y2hzZXQvMjAyNjA3MDMwNzU4NTguMjc4MDM5OC0xLQ0KPiBldmVuLnh1QGludGVsLmNv
bT9wYXJ0PTINCg==
