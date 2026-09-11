Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E933AB5DC;
	Fri, 11 Sep 2026 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103822; cv=fail; b=YxDSgAPe8xnJzJ58X3M3lSRFvfG13W342pJcqIS5JfEnkP1g9R9pM4DTL+Vps+D+w1T7wdXUsNiPD8Fvgf/XmCEkyMU3loF9qgGJKcZG8gJsDal2/HR7KdXfcLGTvk7KnzgQzfD4fPc4hZGAJWZUKjgt40t8Epgm31LyAESyea0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103822; c=relaxed/simple;
	bh=UiGGqNK2mmGt0dBQUnqKPQzLPl0wMlz2E7m4GdW0F5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BXwgi1q60ud5AMOi6j0lxJFYQ+PM0HJihIEuxxjjtoOeEvznbKFLTUg05AJN7k4qu3rVk06QdybGpxMZL6V9D7OJCZUPR0DIaJDktOi6x33KpMkP7XJvifqyppyddFiWNf0dZBSIm7sxIxYXVF/YdQwHifuDmtRntesWwFtmLXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5gx6A6E; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5gx6A6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789103818; x=1820639818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UiGGqNK2mmGt0dBQUnqKPQzLPl0wMlz2E7m4GdW0F5E=;
  b=O5gx6A6EVUhRN5BJXVxdCJKF0LFb0RnVrPxL874Gk2F+NKUCd/B8Zwhr
   iwozXNsOU64f2p8VKd9qhPJGDXB50PEfZzO5bTElJbkwuTuKT3LOk7H68
   //0eknRtm4x+cT4+U7OUT6VnAd6xBBy1p+IxXE4lX0yksq0LRjJV8mYBr
   Fhacr9iS2px0mOhJio/qIrCANs6IVFdTAHWRQuJlPCyCKzILOCa1EZArc
   42snvV0v7P3FlY6C7Q3Gx9ZX0mGfnkWtHTXI7WNfEKB46z82HRHe125q1
   g33BdMpalrXtSQfgX1ulls1bbfeu2e2TmMJ9RUW+LW4p9wXwe0/wYirCH
   w==;
X-CSE-ConnectionGUID: RzYDU3dkSQ6ZfaFWQKQ0iw==
X-CSE-MsgGUID: 96begN0pTF+CwaFdsJtX8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="92076249"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="92076249"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 22:16:58 -0700
X-CSE-ConnectionGUID: y8f/xdGqTGyXzI+qmnNrXw==
X-CSE-MsgGUID: aA8N9vqEQkK/2Mdq/KObBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="310084432"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 22:16:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 22:16:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 22:16:57 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 22:16:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGPEihlAzQceatWBqysz+cPGCJS231Kcl1sJx0FroU4XuEK89x0jocWMuwih+N9jluXeGLvz6skzeexZvarRLbiJjTBKT4FBTCWzULVOiXKVj78otQXDyBMeuNRGyiw4Qd83ywKNpDEHfv/HCGVcCkAUiTXTS3PzirIRxdpq6NJHyhEpPzOpReOYtI6Moeoe3EpJRlqUw5u5xelNrXeseKUCyS7iycednkBSehs4rvhAdnTsx1lFZveYih2XGevxq0Ad26ZfSek8HEWc7kx/PpUTiZ/ojKQ2qftjMf+/VtXpYu2ExD4Pcn3TR9Eb4AbJiDoFNuX7nTTo1+SAzTjM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiGGqNK2mmGt0dBQUnqKPQzLPl0wMlz2E7m4GdW0F5E=;
 b=KKNqfSWmmT5clV1jGeoDwCMoEPC4ymWmtUn2YQXyLkmv3Gv3CopJK5JKD/SoAH+iOZQra0QU12h2fItFPvLqu/VgxA469AMcMke9NbAkZrUSW/ES12qktMIHVx31qvAHt/fPHY2IdL7S/OJsInfp6d4bYVVqDxnrM1xkRsemylYSjf5mQcnrk7cpS4q8jkfUHyDvCeQ4lpK08gZNIjEPgDxfuk/Bhaks95MQh82XGzQ25U6DUf2wSIAPWziObegxAqSV/3YTYok86TYmaimTFfFllEMKZSQPzC0+5aXbsXMY9qvVBY2Fvn/HCC45fhRsKw2HwOongNWdOrEhzQK1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:16:54 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:16:54 +0000
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
Thread-Index: AQHdQRbiDoQ1eJbHwUCBE8kPfdnpmrbIIi8AgAC0LgA=
Date: Fri, 11 Sep 2026 05:16:54 +0000
Message-ID: <SJ0PR11MB56131DFAEEAFC2E670341B2593BE2@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
 <9ae8e6b44ffaf5affb7324f802a3626c581ac461.camel@linux.intel.com>
In-Reply-To: <9ae8e6b44ffaf5affb7324f802a3626c581ac461.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: a95743ed-9023-4dea-f016-08df0fc3e4bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 7r6HBox2Fz7Ke+LU5OLKtm5h00S2RXKpTXcYefxwDKYpnNgZ4PKaE3G0lCvrB/qMvL61gR57eeTpiJUvNSEDXn2WEqitgYdq2EjDJX2Reb0xEXTq88ZZDvvWFXr7QASQv0VW1xLXmyzQVhxXsS9prlUPAnPngMPulM2qEwBNzE8OeNwGN5kAn4rb+W0nFeB4vve80iUwg/rWeKn5zlLgf5BJeVZJ71GoaM9AAuCB6BcwVWwVVPvIIifzT3cT0BmoFHw0SUqis9jE7t9ovMfsNm8iuRsY7Wwp6xZp4gaAJjU45OsQvXQ3Z7pIVoKc0G7AxGKzqpwErBKW94qzhJMPGH6y14MWXcd7puIbt6CxAdBFfIYa+KyqScQdqzGDYahOybCdW3nfX/SRqfRQU+cKVbIYEcj8ZofYkZzoy8XSP7m52TwNCU4eEkcUcwuXCG7W8983jYaisMZRgM1oiGntenAafspJp2gxK9ekv/WIlbUwZFkc+OQKv1M775KjpraMkkC9O0W7h9KKedvVPXP0M1I9lQXG82mvNC2SI75iyKGipxWf9sXTlKTUddfxxg7bOMC5s0FkN6y02l98BrBoKT4c/qrFA7WMbDlXFjgWgRUnTNjcMrx1irM2MDrMdBWNDSssTOUyvtmlclwMGiuwAOrCTYNKH4P3zK/97ZORQSfq3Dde1RH8izrIxJwdemLKrsuTBHTAumPHoDzPrfzIDUupdoKwll6wd4nmW6XtjUE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVOV1E4VW9WSHh0V3M1bGNhdktsMFlZdGVOaFRxSWFVK1cyQUFEd1hkK2hE?=
 =?utf-8?B?SzJPUXFrTVoyQVdrNFlVWXpDQU5XZ3V6cFhPQ2tlZW5rbC9UVFRVQysvVE5r?=
 =?utf-8?B?U05NT3VtT1B3dm9FejZVdE10cHRxWVJTRmo1bDV4ajVONENONTdjQ0lESlg5?=
 =?utf-8?B?bTRWbEhrMWNXY1lITjRRSC9nbkFEUkpkNlRBaGRxK3ZzNjVZOHQ0RDczV25P?=
 =?utf-8?B?aE4vMWtJMlRyd1pNaVFSZHFqbW1HZjI2WmtlTk5lWkdKQVVHYnZlaW5ZSmJl?=
 =?utf-8?B?VVFObmljY2t5UTc5anFRc2dLZXNveFRDUGsyVzJGekc1anJVeUJITG11dWJT?=
 =?utf-8?B?WnFHYzB1cEh1UFFrK1d5TWRESzdPdEpjamZmaVd3cVdtS0liS1R2R2Mra3pI?=
 =?utf-8?B?MW1FekowTzlDSlQ1NVdZN29VaWVpZytaNUJrN0grRm1iMGhkVkhGZTVHa3k5?=
 =?utf-8?B?YjRtSnBaSHRFWlEvb3Rva0hKY3MrdTBkcGVrOHVQS1pjNHh4UVpwTHg3ZTNY?=
 =?utf-8?B?dDBlbWs1M2NWeEZ6bG9MeDluMk5EUytKZ1VTa1c1a1M0S2NjQ3BoZmdiaEFD?=
 =?utf-8?B?ZGRmNExwWmtxVzRuaFlmSnAyc1lmVTZ3OS80TFBUTlRrcHZoWmMrNC9XN0xQ?=
 =?utf-8?B?bjlOTUFUMXU5cVI0ckwxUndYVlhsZFJod2p2R3JUWlVQRXVIUUNLMkhxMElk?=
 =?utf-8?B?SGhaaXIrcm1udmFWd0U3SGlGTS9YRTVZTGlRakxSK0NQVmVjWW96L2t2VEJI?=
 =?utf-8?B?YXUzWkt0Nzh1VmNjL2tmaDBUV2h2VjVXSzdYOFNVNkp1WEdxaXd3dXR3RmZW?=
 =?utf-8?B?KzA4MlV1RkFFNXZROG9iY00rbnlIa2JsT0s1VEFUZkN3MjJWVWh2Z1JsVTVl?=
 =?utf-8?B?V1cwNmpMTzdTSkQySUYyT01kVng2QnlNSTNXOUVHZ3VneDZ0b1RpUzhWSzNk?=
 =?utf-8?B?K3hONDNCSERXam1QTHB0NXRLSzhWM2wzajM0dDFWSmxCVU85c2xENEVXdm9H?=
 =?utf-8?B?dHpSRk53dzRnQmUzbGlpOEZQLzgveFlRaDJsam5BNWxzcm1CbHR0eXdDcW1U?=
 =?utf-8?B?NDU4T2p4c1NwcENaY09BK2V1L21rTnZIbzY4VTJ6V21nZS84ZENTM0Z0Qk1N?=
 =?utf-8?B?T0s3dFROSitKazlsa1RmbjZVZUZZSjBLdkpnQTNPaDdFZUhvNEkxdHJrVnh4?=
 =?utf-8?B?ejkwZVZlMGpnVERkcEM5Y3dnUFJXajFUcTI5K3Ywa21RNlJBMnRUVEZkWEla?=
 =?utf-8?B?VDhudWc3LzlGOXQ3NEs1a3J0OWxOU0haN0p2S2MzK2kwQndBNFlIRk5TZHNS?=
 =?utf-8?B?NmdXT2ZNYVRPYnBSVXdFbElRRW1NdFV4SE50MzJGNHJ2bkF4K292RFRCQ2dM?=
 =?utf-8?B?ajBVaFZpZytXemRqTFl0aFVYbHMwMTJDVzVEV09LVTBGQjEzL24vMWdlZUF5?=
 =?utf-8?B?b2lFSHAzV3JCNGNSUXBLY3lUM1BqQW9ZREN3eERUMktIOFBuTFlUMU9adHdw?=
 =?utf-8?B?SktWSkRQZ1hhRXBleUxQaDkyV2MyNkJEUDI4WXN4VG8wVnJTUTJmcWlqTElC?=
 =?utf-8?B?TVYrek12VmZUWUpjcUZmdDNieGhia3ZsM3dhSkJ6UmJCcGRJTlZmOUp3YzAr?=
 =?utf-8?B?Ykk1V05NQUFVZ1dVSHZrRE5Yd3ljNFd1aGZMeXM2Z3V4eFZEc1NQTTFUTE0z?=
 =?utf-8?B?VzB2SVkzdnZiaVVkTnZjSzN0aW5vNjAvVjUzSGhYRHRTY3hEZlV3OWxhZ0tH?=
 =?utf-8?B?UGVsNEw3THpxTXNGcFIxMjJHZEhJU256a3h4amlSTXhhRUFOR0swdFFyMS9u?=
 =?utf-8?B?ZmR0QmtNb1E0eVdTYldkb0l4M0VmRnBsc3hRVDlWbGlxUmRWNHlWY3JPVUNT?=
 =?utf-8?B?akVZbGJ6NTA3NExSa1lNYnpOTE5FSUMrYVZDMXh3VXJCZmVTd3RMUnQxTWVB?=
 =?utf-8?B?Wmx2N2Qxa0pNL2RjM2thYVNueEJQZVM4ck5jTUhNSmFCay96SjRXb0tic2F1?=
 =?utf-8?B?aU5heG9ueWxJbmFMaEFFQnZOSEVVb0x3QStXbkNQQk9SYmZFdHMrVVJVK2xD?=
 =?utf-8?B?ekIyY2U1Vzd1ajBHY3BCTEpzYmFtRUN0di8wTHZYSFA5M0xVWEcwYjNLdUN5?=
 =?utf-8?B?a1BsaVJTZy9TRncwNGl1YTIydHNMNWNQeVgzNUhsZFAwaExWbkdvdUtZK3R6?=
 =?utf-8?B?ZVZmRmRxY2dVQjFYckZVZkJKRzg4VTk2NVdIcEdHenBRVGZnd21IT1IxdVlT?=
 =?utf-8?B?TGFySWlFMGF0Wm1BckV0bnd6c2dMNkxaQ1dhRkxDTnpsMVZnalZkZ2JOTStU?=
 =?utf-8?Q?RUSMjGZeJnRlWlmFM6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O7Jnrr6sQwFJ+gTmYnKSAA2DOHHS+iW1HmZlsUGsDwAF32bwK0bxPC/iO5lGQ7trLVJ/VP0yfSibmwETVTzNgNJZxE2q+kdcYpG3wv8tiNnkxVT5Z/M+wKMuMrIzvhVUl8l48xIVzJMqP5ZcBOm8K8NqNxPS1ikGSj18SohN/RCqM1GeuupKNQved812RMQr8nF5RDCVdJ3Y9wI45B9vjBVU6xxB3i85AGI2qBdGJBn+7gi69HsUWf+Ke3FKYh8TjizwFbJFS0SoUj5M4KRjWAAxTnrffa/l8amhaMkGsJYrHlb9jHMwKsmvnMDqKNvmEUe9TAdGSgxwxNLNgpRJ4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95743ed-9023-4dea-f016-08df0fc3e4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 05:16:54.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wft8qy8ufhtUBU6i91cPKSDd7gouO10mNxZDe7AksXJHDhjvOZ9frDPkse/QPYrSwc+FKFkBMmCwnHsnYyZaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMTEsIDIwMjYgMjoyOSBBTQ0KPlRvOiBZaWJvIFRhbiA8bGhmZmZAdGp1LmVkdS5jbj47
IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPjsgSm9uYXRoYW4NCj5DYW1lcm9uIDxqaWMy
M0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+DQo+
Q2M6IFpoYW5nLCBMaXh1IDxsaXh1LnpoYW5nQGludGVsLmNvbT47IFNoZXZjaGVua28sIEFuZHJp
eQ0KPjxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPmlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxXSBISUQ6IHNlbnNvci1odWI6IHN5bmNo
cm9uaXplIG11bHRpLXZhbHVlIHJlYWQNCj5jYW5jZWxsYXRpb24NCj4NCj5PbiBUaHUsIDIwMjYt
MDktMTAgYXQgMTk6MjMgKzA4MDAsIFlpYm8gVGFuIHdyb3RlOg0KPj4gc2Vuc29yX2h1Yl9pbnB1
dF9hdHRyX3JlYWRfdmFsdWVzKCkgcHVibGlzaGVzIGEgY2FsbGVyLW93bmVkIGJ1ZmZlciB0bw0K
Pj4gdGhlIHJhdy1ldmVudCBwYXRoLiBJZiBpdHMgaW50ZXJydXB0aWJsZSB3YWl0IHRpbWVzIG91
dCBvciBpcw0KPj4gaW50ZXJydXB0ZWQsIGl0IGNsZWFycyBwZW5kaW5nLnN0YXR1cyB3aXRob3V0
IHRha2luZyBkYXRhLT5sb2NrIGFuZA0KPj4gcmV0dXJucy4NCj4+DQo+DQo+SGkgTGl4dSwNCj4N
Cj5QbGVhc2UgZ2l2ZSBtZSBxdWljayB0ZXN0LiBDaGFuZ2UgaXRzZWxmIGxvb2tzIGdvb2QsIG5v
dCBzdXJlIGlmIHdlIG5lZWQNCj5zb21ldGhpbmcgbW9yZS4NCkhpIFNyaW5pdmFzLA0KDQpUaGUg
bWFjaGluZSBpcyBjdXJyZW50bHkgcnVubmluZyBvdGhlciB0ZXN0cy4gT25jZSB0aGV5IGFyZSBk
b25lIG5leHQgd2VlaywgSSB3aWxsIHJ1biBhIHF1aWNrIHRlc3Qgb24gdGhpcyBjaGFuZ2UgYW5k
IGdldCBiYWNrIHRvIHlvdSB3aXRoIGZlZWRiYWNrLg0KDQpUaGFua3MsDQpMaXh1DQoNCj4NCj5U
aGFua3MsDQo+U3Jpbml2YXMNCg0KDQo=
