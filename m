Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32942386C18
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182316; cv=fail; b=p0ezIELup/N9NC8TqlW3XucE2FLm52Jt2ti+RQRdjVnLwroauuQqAKvI46kQ2aC+yak9KodRH9y6/Lj6qmYbRhcw/rhr/JQBQllJnMmPCdZ8fxNTsAKH6lQXmE2eaSFxglCcrfyjmOYdg1gErqZynhw7iThT5BAkzOFoMTUoL3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182316; c=relaxed/simple;
	bh=FECHZiO3hRrszBY/TUioql0dIYPZXMrHK1z5OiyNhsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=sb6AbsdmLgAiU1W1gMrgFqbzhbWJXVKVJE7a4ianPbFs5p1JVjp86in/qqtw1JVhqOctL6DIiOmymRoxRThroSzMT0e3tyy/w//q7bUHfai8JCOS+jCtuVh+UihjZKDnN6I8s83CvZbvwr3H0FLZagtGRwS10BZ6btWaMKiWgQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alrGjo3F; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alrGjo3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784182315; x=1815718315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FECHZiO3hRrszBY/TUioql0dIYPZXMrHK1z5OiyNhsk=;
  b=alrGjo3FRvq5v3Sg8OGZI6UQLMyKfGEXt8Rc+Wn4BhKSf83SdgeX8fel
   m+TxMvsVQkimX7m1370ib/67TkKTJPZRojnccEUiWhU+kCWOC8ZfqTu0C
   N+6ICQ/+FdD1TZprJbp58ugOrANErZrI1OZg9Uz27ANHQNwJtxuiu65vj
   s2xTUNFVMAdjqA8Ti20dqYDeExBka/32VFujG77rEdFh5Tn5eJ9PdcFX5
   tyqWpp1QbNgnGA6u16m0WkYuxotuZwjE8PDg/uLFULpf3KIlw89SncR6H
   18QNTKTPPNdVGrlpZl2QF5MM8hw7cFg9uuMOH2TQQxXBEPzz3NSJw8o/L
   A==;
X-CSE-ConnectionGUID: Eg4LuR2DS5GlfV4FzSdGQw==
X-CSE-MsgGUID: 2joDZ4XuS0GArOqLwrCluw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96198394"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="96198394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 23:11:53 -0700
X-CSE-ConnectionGUID: VeteQ+f6SCiSaKVBpaEL3w==
X-CSE-MsgGUID: VDlVbX2DQj6lmEggVMZrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="253005081"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 23:11:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 23:11:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 23:11:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 23:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuW+OaxB5/J1YJX8hiHa16QWBLpiYY2rOcsJYAj7254a7K3VUvlj4PWsEk+AnzESgmeJ0CDQn/Z9zZ1fo46Eo2pZflAdZJPivlg+u7+iz2nM2Tu5cBuVahh8Br206CMwNhY7vgcStzicajNUJVuraOMM0AHWsc9xxIc2D1uLcO7Ff2xTO62dH875/XUdJOVCmhfMP/h38M2BOGpErPusuIkgx+Cv2+ZSr0k6+1T8zbWpAXfuoC10I75bblMkT7pk+5mqDwjsxd9gEeoA+nNsQf2mlyeGTKPLZfuJyVOLvD+mo85vwNLnCCoHG23lluramghtMO3iHT2dNuCACs6fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FECHZiO3hRrszBY/TUioql0dIYPZXMrHK1z5OiyNhsk=;
 b=cV/RsmyaIjT8npx8a4gbINDOpGbydRBWXe1nfCvN3/AWIkk/qu9UbEIh0r4Sv+77dPjr2Snqa/4rZ5gdmInc5effeptpDLW3ylwzrFpsNFh+XZeRfrK/HtUAFh6PzMnG9pEss3LsM/LY7I56CSLODfaBamXU586a2nyVcW/YiITyyjYXQtgrLRXCezddoBThyPpAXt/qdKjAMSiZgm9HCoOvCEgJFZPjhJPe7CFiAzwDAbOwciZLVFmEJZmX4HrYUF/juk02kY4P8avwTLCF6H3Irogwnc8mBpoIupiMlO23dKFc8J52vu2Z3tbgU4lXJxnWCn25ri6qBkEol0/jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 06:11:49 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 06:11:49 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Wahid7852 <wahidzk0091@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>, srinivas pandruvada
	<srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Thread-Topic: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Thread-Index: AQHdB+26rQb8+1w6z0SU0SoTRDAPYrZX/71ggBfAKvA=
Date: Thu, 16 Jul 2026 06:11:48 +0000
Message-ID: <SJ0PR11MB56131C376FAB7EE09B32EB5993C72@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
 <dd9ced1905adb4805916b173847282ff168a66b9.camel@linux.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|DS0PR11MB8135:EE_
x-ms-office365-filtering-correlation-id: 055dd41d-3f0b-4244-0b96-08dee3011f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003;
x-microsoft-antispam-message-info: TIk7WrbVcIgKjIhlahhAmN2MaZjHPTrTtVQZAzrnusichu4fCDHKFY3yIPzQchgsSY4r0Z5IFGIiT0Tr20lfPI/HJtgBUa8MATQbcaIzpzzFQAcitMctSM3aTnmE39XYYpOJz3djxyewH8tav8hS3l/b2PCm6P13RKHIyAMmizuZ54XSgp+vmTv+ye9wg3cBGFehxTZoJkIQhzpOgPqjqxh5P9VR0UWr/35n1NfcKDwfDoxIHgSwAD/U3MKxVqh72DTBwRzk0YNcD+gl7SYbJjafATTQ5rJDr4P2KB2n9+GNzv+gjJVJ86DuciNdw3E/aLAV8989yEhKPgYKm14flYoZ/ufV8vO70cJqJ1mVKTw6HekHF37XKhjGB588xZe1Wlz5AtuGLtPFGBbBmeb1dvId12lbhU28g7lAJYUUjrhSCS6D3rW1raR59dLxX4uud2SVpJt+o2O6rpC3bwgQcFx/kDwPfQzYhWRd7qGnC3SAqAuaKp2JFQP39R9FoEqcULxLtk69DUmjAG9Qna7uTxHuG4cgIg5YY2eJqI0sgUbxFQWI86X+tbQmvtOoEwKn4lbP+YK4a8/iHbK2cxhOb7fTkLH/aPc4ip4Z8WQNHXru83LrUukA1Z9eExfsLif0SUcGcaxxulA3TFM7IPqN/o1xYGLQS69g7PWPqih0sVRu6dqFHl6KNX8ucSn02jqjHIrGKhRsLFVA0vGueAzHwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRyNEVVZ3BzTUhSR3Z2d1Yvd1RJblBBbmcvT0VjYko2ZUZQRXgxL2dwN1E1?=
 =?utf-8?B?MDlHb1RPNnJWeHJDeFVQTE1JR2NzZUltTjF3MjN6SEpKMStJY040ZTkrd3M0?=
 =?utf-8?B?YzE0UWFySHl4TXVYT09oUkhqdkRzdkh0Qy9uRGcwRmF1UE9iZ2xpb0ZjcVNF?=
 =?utf-8?B?cmhhcFFjbjN0UmRVZ3hOZW5nL2FXSmNjcHZqbExOVXZVK2RWaU5FVmgvU05Z?=
 =?utf-8?B?dFpkbjJzbS82aXdtY2NQcjNqQno1M08xY0ppME1EVGlDRzhZdDJoVUlMZm1N?=
 =?utf-8?B?OFB6cW5kQmZaYU1RVlJzeGlnd1FxcHF5ZkFUbHE2NllGSFQ2d0NQSjU1SEdq?=
 =?utf-8?B?Kzlsa3hsTUJqNThzMEw2bGIzc2c4TjByVHRzUUhEVmttVXh5SFgxVWdBTUdQ?=
 =?utf-8?B?a0tjLy9sYW1yTTV4a1Y1bmRPZ2FoSGxHUVF4bGZ1RG1MVUZzT0owK2hBR1ZD?=
 =?utf-8?B?WlFzcDZLSUcrMDZmRmdvWDJKdVlRM0hqTHhBcG1MeEZkaG9ZYy84TGZUQ1d4?=
 =?utf-8?B?VUR5dldZcnMrRlZ0UXVnWXV2OVVkYzMxSlBEV2VXTHkva2dmcWZERUZWWmZL?=
 =?utf-8?B?c0YxVGtnSXZuNUJYYkg2aXMwL2ViY21CYWVlNzUxN2pnVlBFRnBFTWxNazJw?=
 =?utf-8?B?ZnpZQkFvbnJ0RkdtbkJibXlLYi9naW05d0ZvK0dCdzNNL3IyanlWSVBPNERq?=
 =?utf-8?B?M0tzRmlkcXA4MlphcGMvUzByL0ROdjd6L1hxeWVhZTA0bS9meWJ5T3Q2R3I2?=
 =?utf-8?B?MlpkOU50dU9WNnRaaEtsWS93c2NyUGVYL21SMkpKNVMzSU1raWtVNUdWQ1Zs?=
 =?utf-8?B?TEQ2SGdxS2QyYXYxY05CcjdmNTNCOVRwTm0vUFMvclZNNXgwODVKMGY5bkdY?=
 =?utf-8?B?d09zVDh2d0RLNWowejZ4b1MzR0ZsSUZwTFhNZjd2Zmp4a0hQZy9kYmlGY3Er?=
 =?utf-8?B?TTVpbUFsVHpHMnFWUVJxWVN5Rnh0cDZJQmMzSU5HcHZoV0oraUxXMTZxdDZq?=
 =?utf-8?B?N3kzYW5iU2JsdnloNCtvSWVPTmh4MVNQOTd4WnRJZGlkY0xSTjVnVWxJajVC?=
 =?utf-8?B?T2NBM3UvV2Z3WGliREwwU2ZIMGdNVm9QbU5MR0gxMlZSK3NybGFpWDZkc3JK?=
 =?utf-8?B?OVZidDIzbHNPTk52R2NOUmZsdkdDeWVqTGNibGg2d0xjdzh3MDR1RjkzTEJN?=
 =?utf-8?B?YmZicnIxSE5jeWJBTGVtaTQ4MjNBcXJrb0hHSzloTXVXZXViY1ZKNFhjOUt4?=
 =?utf-8?B?aVZ3NENhQmNCQ2VTejk2L0puZjh5dFU4c1RJL3dLblUwamdMRDBOQ3BXNlVV?=
 =?utf-8?B?SFBKQnNuSzJFU0x6cjBvcHFpSy9jNWpXWEZpMlBMVlBOcnJRa3hRS1FJdTBs?=
 =?utf-8?B?aThyNG81TEhUY2FTUWtvbUNCOURWQzJpWHlGK3FQYS9qTGRSVjlUTFZSRTJE?=
 =?utf-8?B?NTVvNitCTldYQ1dieG82Z08vOXdadXJQWU1JSmVDanJqbzdqUTFvdDVzQmFM?=
 =?utf-8?B?eWo1dWR2dEVzQjJpcUlRZ21GbmM2OTFDVFFXT0pWQ2tnbWtCMzYyVjljeFBB?=
 =?utf-8?B?Yng2a3A3czUvNnBoTC9Mb1RDWHptN1lHbVYxSUxxRlJVUmc5TUszZGtLMVE5?=
 =?utf-8?B?YVJWUERqS2lSUDNmcGNnSjhJaGJSUmJtQU1TQzR6dkQzdUQ2WnJuODV0RUNW?=
 =?utf-8?B?YUhNUnF6bS94bEdYZXBqdFZvU3ZIakwvTjA1VnZQbHAyQm1NTHhmR3cvdERN?=
 =?utf-8?B?NzJQZHhCRWswZm9Lc3JhdjBQZjI3S3hWanV5bytPV1g4WDU4UmV4WHd4U3pn?=
 =?utf-8?B?OTROd2MzOFlEOThoZzc3Wnp5UkJSSnFYWGIzbWpiQTBQTTdJYmQ2akhxaGVV?=
 =?utf-8?B?NjBDWE0wZm5hWmFxdFM1VUMvWXlXR3pxWTIrcW1RZWVDZ0I3c1RBalBDOFBw?=
 =?utf-8?B?OHRjaWdxbUhZVi9kbkt3amNCbnhVa1R6MThzd3NJUnNMSDVocWFQd2JEQTlz?=
 =?utf-8?B?UmJFQ0dROWI4Y05KSzBwd0dpWTBRRjRMV1RNS05oSFF0RUw4R01QSnBidVlM?=
 =?utf-8?B?clBNdEcwcFBUa0hZREcxL1lIdWJJbnA1R2RndlVHRXlRN0xRdkFtZnRWdUE1?=
 =?utf-8?B?VUZFa0RYa3ozVzIvU3Q4dlVZYVI2UHdwZ0MrQjZGcVZnMWQwaytsQzNaU2pH?=
 =?utf-8?B?dVRmSTRCL3pSdDN3ZW9qV1huSlBGMGNzbk5jVTF0NEtQQ2FBMTdWQ3FaSmM2?=
 =?utf-8?B?N0dHVXAwdGo4UEVTRUw3TFlycnk5dG1yOUNqRFFVK0dqd1dTRWVsQWtURW9I?=
 =?utf-8?Q?oGqN3pvYDmiQynQrqZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gjIYMf0kcuNqIBsrfiDoYqaz7MOK13zK8CaXBgMwkrtnKKRUWfO2qkLsGKMnRFlWKPi/2YYQWIN+PrAILeSv/MC4q/6rTteR1hqqYlW84Qa3DluZFn+89wBetEyzuEBrj5ysHM+BJcLnC4DIDPUKPykmeEx2XS+vl6eyY6AxEOMlvY9IckEgYGETHWEPDfcFVoetWGRN7GRS/U+A70rCyB3t0xl9Tgx+5n0a8tZ3ZT9I160i5oo1PrUa4rbOvHlourS5Ma3RTF5WzN85DgJPjI0n94tOL7lknAG11XZQbNTgE01nZiItk/frINVlhPs3tJ/O/p9E0rY2Y339xSLOrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055dd41d-3f0b-4244-0b96-08dee3011f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 06:11:48.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKSWgdIiJoU9xJAqnhzfoCh+OZfNs390YodKWvQdTlKW/ku80xOxkga2bDsSfSlfcW68IXZZJwB/tx05y208kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogWmhhbmcsIExpeHUNCj5TZW50OiBX
ZWRuZXNkYXksIEp1bHkgMSwgMjAyNiAxMToyMCBBTQ0KPlRvOiBzcmluaXZhcyBwYW5kcnV2YWRh
IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT47IFdhaGlkNzg1Mg0KPjx3YWhp
ZHprMDA5MUBnbWFpbC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmcNCj5DYzogamlr
b3NAa2VybmVsLm9yZw0KPlN1YmplY3Q6IFJFOiBbUEFUQ0hdIEhJRDogaW50ZWwtaXNoLWhpZDog
aWdub3JlIHBvc3QtaW5pdCBFTlVNX0RFVklDRVMgZnJvbQ0KPmZpcm13YXJlDQo+DQo+Pi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IHNyaW5pdmFzIHBhbmRydXZhZGEgPHNyaW5p
dmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPj5TZW50OiBUdWVzZGF5LCBKdW5lIDMw
LCAyMDI2IDE6MzUgQU0NCj4+VG86IFdhaGlkNzg1MiA8d2FoaWR6azAwOTFAZ21haWwuY29tPjsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOw0KPj5aaGFuZywgTGl4dSA8bGl4dS56aGFuZ0Bp
bnRlbC5jb20+DQo+PkNjOiBqaWtvc0BrZXJuZWwub3JnDQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0hd
IEhJRDogaW50ZWwtaXNoLWhpZDogaWdub3JlIHBvc3QtaW5pdCBFTlVNX0RFVklDRVMNCj4+ZnJv
bSBmaXJtd2FyZQ0KPj4NCj4+K0xpeHUNCj4NCj5UaGFua3MgZm9yIHlvdXIgcGF0Y2guIEknbGwg
ZG8gc29tZSBwb3dlciBjeWNsZSB0ZXN0cyBhbmQgcHJvdmlkZSBmZWVkYmFjaw0KPndoZW4gSSBo
YXZlIHNvbWUgZnJlZSB0aW1lLg0KDQpIaSBXYWhpZCwNCg0KSSBjb21wbGV0ZWQgcG93ZXItY3lj
bGUgdGVzdGluZyBvbiBBUkwgYW5kIE5WTCBwbGF0Zm9ybXMgYW5kIGZvdW5kIG5vIHJlZ3Jlc3Np
b25zLiBQbGVhc2UgZ28gYWhlYWQgYW5kIHNlbmQgdjIuDQoNCkJlc3QgcmVnYXJkLA0KTGl4dQ0K
DQo+DQo+QmVzdCByZWdhcmRzLA0KPkxpeHUNCj4NCg0K
