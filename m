Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAA3451CD;
	Fri, 31 Jul 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480422; cv=fail; b=T8lErOFSAB4AwX0gepBUkA42djKYDqZ+4iQMmXsXV+gcWSjnMnjnpDlsYbmWHPlKbSKDWnjb6a8+o8Ecst+lw+tc2kWb4XtwCn7NYdIKthh6neUXoKtEKA4hRnSbf7lCxFrOREu1hqHtHcRMwTsXXAkByucoZVXWT+m2lZRRNVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480422; c=relaxed/simple;
	bh=VpVqkf7OdFfcwB4T+2RCtSmt6c5V6gmi57iyPvf+7v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WG1houS5g+z1ORvPt5FxaY8y4Ts+0aJF0W2ri8DXR8mrbofcvvZ4z73sdtLVrrVJdRpOSAgGzhxallFU70SkIXO5kyDNVy+wLBw3TT6nSb/YRcHuJRLSasXRL1uCLK8UvfLHps95+Wr9HMOHvnRA3Lgb5YNl9UfydevH3EIRKeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwhtSjA7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwhtSjA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785480421; x=1817016421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VpVqkf7OdFfcwB4T+2RCtSmt6c5V6gmi57iyPvf+7v0=;
  b=lwhtSjA7Ha/np6z7rCxcUJRdcS1tCO9VYICG0DzjF/okIBDqQbEubLBM
   C9liZrofrecg8dEYNXn74J/x898eEef6dvhZTlY5srhTpu7HJmoRW9PL0
   kBFl8/h6VT3wZI1i9BFR9nat39LgpH25fD25xSzqT+kXeHr7m4RQUP8Gj
   1Su6spzuRR8vJBtc2BWmBaqqhUHxjmx2TFBqzVvJB/eAoc6gwm0Ldqdr8
   g39DqvsaavWbezJ5ZAPAqVJYVEme6bj6DUU2mnqRXV3qOKMQDafpq2jmq
   GudYJIvYFiswHyCSXSPcNPYaE6yHnQuxbXUY1dVypvbn2xwEynhkZOHQG
   w==;
X-CSE-ConnectionGUID: Z31nwsjhTRON3MelmBsd0w==
X-CSE-MsgGUID: L91//8C7Ttms+4OLsOj+bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="88637203"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="88637203"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 23:47:00 -0700
X-CSE-ConnectionGUID: 8qwPAs1zTDy+yiGrh9Mb3Q==
X-CSE-MsgGUID: nzgoGI2tSwmoUil47yxP0A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 23:47:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 23:46:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 23:46:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 23:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H559fYnK6zV3GfAi8xSLpHGfAD1mT9wFJugBh1151fNylKh+UWkLdXqRsR16RAKYndKq+a6VrAarNAqEOGT40mvnhurzZZA8LYncrFGejmR+OfOpqBnWLn3syQ0mx1PGratD0sfYXj8BavwWL/whl8JEuOYWpT9GDDgwFpegQg9xZHLr/KjEExnOVhGh543vsvff2GRV9YaoUgdIZ2eNC3/euu50tFl1L8+KiwT74jfD/of3DiPcsrZ9c+WlZAMl4W+22cBOYP/t7Ch3NFPsbDtNWG0cluwKl0zdXeBrxMusiETejpbhwat5/WDNWoFujdlAQw9a+loufLYJnlGzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpVqkf7OdFfcwB4T+2RCtSmt6c5V6gmi57iyPvf+7v0=;
 b=WqA+3y5hdtTXgFzkcFSSLkW/raddcu8UGNHVeka5s1+3d+jmr9d95muLyqCgm62qWxRiLG0tgjgIOAF6u+H7KqrXWUA3p97rrBAm6sxaIfm3w7Vl38bjSBNDS5MqSfJ/SCvC6k9xyFJWiytQ0SVpw3YNMER2iWxIgps6wQttIkoI/ZnOd5JmW6tvxTFPq4X5DqmqT49TVkdp3g2f1EoSsKP+OreA0nG6wAJWDTNRncSIO7D4UldhJpbn41AVpDpT8aLnUhDUWhROAvZ97yo4225YSfuwlqGo/5WLc+0+ABUJX/mH+eIU4GoxlCOcFKAdUBQAjhjepkEH3xbwFfqlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 06:46:56 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:46:56 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Shen Yongchao
	<grayhat@foxmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Thread-Topic: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Thread-Index: AQHdIE7TrbMdt3iF2EuzaLMCAtwFq7aHIHEw
Date: Fri, 31 Jul 2026 06:46:56 +0000
Message-ID: <SJ0PR11MB5613DA4C6E57F1BB3706BC0593C82@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
 <e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
In-Reply-To: <e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|CY5PR11MB6233:EE_
x-ms-office365-filtering-correlation-id: c17dfc97-c219-4b9f-0856-08deeecf8369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|20052099010|22082099003|18002099003;
x-microsoft-antispam-message-info: VUJHnqyva4udLPJOykGphe3mLxlXcOcVw5wuwXl6U5RqGBxr0C3ZH3nye96QhZ878yjOjctk19cK/S66qoUKPZ6feEijma4TeUyGXvICO8CF7+1hoKaPXwkc3N3Vw0/8QN/SFp9IgkeWHppRGmOxMjB0qu57JznF8dZxNzKe71ihvGSAUoCk5d40vxkqgfxLAhmHmyvVRX7JEdI2A4NHM0JIpou+xgWjPxpsKpiC4wJ3Yy4bje4WrG0S94mlLAEwG9hfpiHXVgyu0v7TXTFT7v369Kqk2iksT4O6d1Amr0M6uBBrVEPekt+u9hmjquRqk00Xq7pIYE4WF1K4kfzXiVHiIkyuLIXsHLE12OOaxSaelcNk+P9X/DW6SNBFt7QHPMIGoblJ/6gs4LcofPU2vYaPcZWWABEve0HuZiv/ijo6e/YMTqqP2XZhR09kWduWvacBZGgGXrVBMwsKN3iYe92ZKS4wUoQhAAkdHiKk9aNmaQ1vgcU0UuDlQC/QU1DuKuYM0SV+F2aOwCEawEst9ZSd4AW0hTtFW1zCb+spZ7QBPF2UbILEyY5gu0LWGq6UK8Vuh5cNxn29kU3eTd8e7WTrrOg2nHsgYgE9T5dIJBgAJyUOyVoGlaJrc9WAVFfafRpokG0jArAF7jylZqB8yZIV8lqpEpep2YN7CCLU8SbskCg0rFzQBbsod12w2xotOQjl7l1Z74nTzm74y3jQ+SPOTZnFH/0EM70dqLl5/j8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(20052099010)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHY4WTFyd01ueThjNlFKSGkwYndTRjVqUGVJcFNFMjZVcENqcTJ0U1U4WmRn?=
 =?utf-8?B?VVRIYUJlNzhRNXQ0SHZ3c21kTG92TnRkWldnV20xV3JPeGdaRWpyenRNV0NK?=
 =?utf-8?B?SlE5UkRVWG1iMUxhTGZBNFhoTnROYlh5RHZlV2doMWplYWRUeTVFb2VlWUMx?=
 =?utf-8?B?ZG13M1EwK3NsbG5Na0lPd29qMEdFUkIwMjdXM3phUVUrdkM4QUlaU3VicDkw?=
 =?utf-8?B?RWhvSSsvY2hueVhsalFzYzVqWE9EeDVrME1XTzZkdFBSUWg5aFhzeXJ2R2Fm?=
 =?utf-8?B?dXlTaUppRnNYcjl4OXVEYUhwZFc5ZTQ4aG91Nk9Oc2JSY2dmS1RpUHpDSXVw?=
 =?utf-8?B?eG9lc2JmelpRS1JZRm9ZUDFWb3RqODVCUittc3ZDd1R1MmRCQUN3WndLOVYr?=
 =?utf-8?B?QVgvajhKMWZzL2pGSkNFZnV6Y2ZHa24waEFNQXdGbGhTZTlnTVlHMmk3L1Jm?=
 =?utf-8?B?enUrZEJLalV4c2tkdlZ2TFRDSDkvVzMxZ1JGaEJvcUlCcUZKR2dsVE9idkdS?=
 =?utf-8?B?UncwRzUxTjIxRmRqYWNiWm9qVGpRWktzL3MvZHQwMG8va216dG8vbUtHUFNN?=
 =?utf-8?B?d3RlTVU0K3Q5dTA2TksvUW5VUml6UUlsVG0xd3hzWUdNdE9RYXFieW9QSGxE?=
 =?utf-8?B?ZGhyaWdxNzY5V25nZ2Z1SWwzWDVRYUlyd21icUJiMGVJa3k0b3ZXamNZQTNH?=
 =?utf-8?B?MWtDd1JGZ1ZhclllRlY0KytucUc2S0o0Z2VFK1A4cmUyVVBHengvd2FaTERt?=
 =?utf-8?B?dEMvSFdSbWhBUXYwWmQ3S3hacEtwYnhHQ2RHR2pSdlZKR083K3ZJYitqYWd4?=
 =?utf-8?B?dWI1aXowTno4VnV2WkcveXRzU2JzZWFmUy9jSHlhZnhDKzJZNloxczJnOWZB?=
 =?utf-8?B?Z3hxUkxiRnRPSkFUY2hTa3d6dVJnbjREUVNnRmNwSDR5Y0taaGtWRDZiSHA0?=
 =?utf-8?B?R1Ezb2dvd1crc2xFcmwva2Y3Z2NvM0ZReTRGT3J6czhENGUvZWFQZ3BYM2xZ?=
 =?utf-8?B?OFBnVGV1bFZZQkZCRHkwRzRKQ1plRURIMWNZL0R5aGFQU0hjMzEwM0xnVzlN?=
 =?utf-8?B?YXBVZ1h5bzR5djRkS0tSK09rUDJEOThaZlp0US93OVVLSi9HaTRHTE1uNlV0?=
 =?utf-8?B?Z1BmaWMwL0ZNNmZBeU5icmVyRk1FYUN4Z2NxNW9iWlRTSzJTT1BEeEhGZjVG?=
 =?utf-8?B?bFRNS0RFcTRncE04bmJtUjZ1a2dIVjBUb05Zek1WRXpjcVE1SUduL1VoQzRS?=
 =?utf-8?B?MGZHRnM0Y045c1V5SlVLQnlOblJxZ3VCaW9LendpU1lVeEdOR3VwWVlMY2FX?=
 =?utf-8?B?NDJLZ0x0elN5SjFaSS85UVJldDNhMC9rSTl2TG1WMUN6ZkxLcTk5MzJLS1U2?=
 =?utf-8?B?QnY1aUNDYTRaWU5tdEJnNzBISS95L09TQnAvWVVBb3VTa2tjZkJOazlwZ2FP?=
 =?utf-8?B?TU1XMTNscnE5Y2VEUFBWT1BCTDlEbDFaWHQ0VWhOcm9rZjRZU3N1L3FjYk1q?=
 =?utf-8?B?TUw5MHl3V1FnL2RhQ0M0TGNrN2Z0QllRZVZiMWVpc0dZeHU2RU9qWUNXZnc0?=
 =?utf-8?B?WHZqNzg5NmJpVE1NZFlwSjdjcncrSCtFZzluWmhqUnJZcldzS2ZuenlMNjVG?=
 =?utf-8?B?TnBOVXFjaTMzL2hzR3o3TlZjRlVLQjlQdkxOUkFtQWhWYmRtNk4wakVaeVdm?=
 =?utf-8?B?ZytlaDlkS2RYY2VDUmhOYmQrRiswbGR2T1dBeDQvMlNxYjdOWTkzWDhZbFZv?=
 =?utf-8?B?T09pY2xjRUpnMXlMS08xVjI5aDNibEdiUEwvT1FacDFDU3RTSFl4REJPcWJH?=
 =?utf-8?B?bnpsUFlFanZVNTdxRXNXN1JXZ29OZGU2Q2diTkRNOVk5SHg1V1dqcEJUK25K?=
 =?utf-8?B?OURVNmdqeXNzeWFUMHRKNnJUeDJXa2twUUsxV2Zpd1BuMUcwbkJDdk5rOFBz?=
 =?utf-8?B?NnppdWM1RHBOOU01RUFJdUtvNHFnVlpVbVZwV3ZyZTVNSUdPUU4zR20ydlBK?=
 =?utf-8?B?bVhQSzNZZnJJUGNEdHRSdXFya2NQQnFBK0tBZGtnaWhpMDNZUXpWL1ExQTA1?=
 =?utf-8?B?T0ZRYVNmOUp6R213SlZiUGZiNGxzUXhXbmdQQ3dvQjlFNG5KcDB6Y3pXb2Mz?=
 =?utf-8?B?OGw3SHU5ZjZNUjg1TC9yekVRMndpemZNT1lnQUMxOCs3eDlwZ2w3anZaUGZV?=
 =?utf-8?B?Zm42dHBOemFFSDF1cXVnbndWbEljaVJyZThTR016RFk3Y2djb3IxNklDNUk4?=
 =?utf-8?B?QmFueXp4OUd5NDFmdWRWS2ZRNVorS2JMeVpzS1VQU3V6ZmxpcGpYYXBxd2tS?=
 =?utf-8?Q?yrOWuovhiENy7bg4MX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PDpjqGzo2aaDmmowHVgYDA+mqUo4PkujUjc3NMvOt2y/eK422KoLEWz/LefzP84BkW6ZjE7Mgp5sIlWMet9MrNnEcS2rl8vl8ICv8L5VfwOHeXZiksqkcY8sccaGUN/wnMrmnBYny2cvzNpfYF1G4kFAACAtAaqYXUUy0N16Fdvbk+TDF7iHE//eyyryi0UTleXdo7hu96fa9JVXGh3p55sqUBQ8mSa23jkDcRqJVAfyzEYpkomwtIV6wNuX0Bwd7KWLsZXoNGVzokM2SpKX205HsMesQFU0QN5+ms2W4B/0dVfa73iYXS7DcJiGXosJaT5B106ZWqUdzJXfDQ7IUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17dfc97-c219-4b9f-0856-08deeecf8369
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 06:46:56.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ln+0tfdipoZqyrTRNvp4VaaivMXJsDXf/T5BcItkfzP5HCwnJN5nWHuSXEVIOm2qeZ/nAhU10WnrND+bo5xQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBKdWx5
IDMxLCAyMDI2IDI6MTEgQU0NCj5UbzogU2hlbiBZb25nY2hhbyA8Z3JheWhhdEBmb3htYWlsLmNv
bT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFpo
YW5nLCBMaXh1IDxsaXh1LnpoYW5nQGludGVsLmNvbT4NCj5DYzogSmlyaSBLb3NpbmEgPGppa29z
QGtlcm5lbC5vcmc+OyBCZW5qYW1pbiBUaXNzb2lyZXMgPGJlbnRpc3NAa2VybmVsLm9yZz47DQo+
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gSElEOiBpbnRlbC1pc2gtaGlkOiBjbGFtcCBISUQg
ZGV2aWNlIGNvdW50IHRvDQo+TUFYX0hJRF9ERVZJQ0VTDQo+DQo+K0xpeHUNCg0KQ29kZS13aXNl
LCB0aGUgY2hhbmdlcyBsb29rIGdvb2QgdG8gbWUuDQoNClRlc3RlZC1ieTogWmhhbmcgTGl4dSA8
bGl4dS56aGFuZ0BpbnRlbC5jb20+DQoNClRoYW5rcywNCkxpeHUNCg0KPg0KPk9uIFRodSwgMjAy
Ni0wNy0zMCBhdCAyMDoyNSArMDgwMCwgU2hlbiBZb25nY2hhbyB3cm90ZToNCj4+IFRoZSBIT1NU
SUZfRE1fRU5VTV9ERVZJQ0VTIHJlc3BvbnNlIGhhbmRsZXIgdGFrZXMgdGhlIEhJRCBkZXZpY2UN
Cj5jb3VudA0KPj4gZnJvbSB0aGUgZmlyc3QgcGF5bG9hZCBieXRlIG9mIHRoZSBJU0ggZmlybXdh
cmUgcmVzcG9uc2UgKG1heCAyNTUpIGFuZA0KPj4gc3RvcmVzIGl0IGluIGhpZF9kZXZfY291bnQg
d2l0aG91dCBhbnkgYm91bmRzIGNoZWNrLsKgIFRoaXMgdmFsdWUNCj4+IHByb3BhZ2F0ZXMgdG8g
bnVtX2hpZF9kZXZpY2VzIGFuZCBpcyB1c2VkIHRvIGluZGV4IGZpdmUgZml4ZWQtc2l6ZQ0KPj4g
YXJyYXlzIGluIHN0cnVjdCBpc2h0cF9jbF9kYXRhIChNQVhfSElEX0RFVklDRVMgPSAzMik6IHJl
cG9ydF9kZXNjcltdLA0KPj4gcmVwb3J0X2Rlc2NyX3NpemVbXSwgaGlkX3NlbnNvcl9odWJzW10s
IGhpZF9kZXNjcltdLCBhbmQNCj4+IGhpZF9kZXNjcl9zaXplW10uDQo+Pg0KPj4gSWYgdGhlIGZp
cm13YXJlIHJlcG9ydHMgbW9yZSB0aGFuIDMyIGRldmljZXMsIGhpZF9pc2h0cF9jbF9pbml0KCkN
Cj4+IHdyaXRlcyBwYXN0IGFsbCBmaXZlIGFycmF5cywgY29ycnVwdGluZyBzdWJzZXF1ZW50IHN0
cnVjdCBmaWVsZHMNCj4+IChpbmNsdWRpbmcgd29ya19zdHJ1Y3QgbWVtYmVycyB3aXRoIGVtYmVk
ZGVkIGZ1bmN0aW9uIHBvaW50ZXJzKSBhbmQNCj4+IHBvdGVudGlhbGx5IGFkamFjZW50IGhlYXAg
b2JqZWN0cy4NCj4+DQo+PiBDbGFtcCBoaWRfZGV2X2NvdW50IHRvIE1BWF9ISURfREVWSUNFUyBh
dCB0aGUgc2luZ2xlIHBvaW50IHdoZXJlIGl0DQo+PiBlbnRlcnMgdGhlIGRyaXZlciAocHJvY2Vz
c19yZWN2LCBFTlVNX0RFVklDRVMgYnJhbmNoKSwgd2hpY2ggY292ZXJzDQo+PiBib3RoIHRoZSBw
cm9iZSBhbmQgdGhlIHJlc2V0IHBhdGhzLg0KPj4NCj4+IFRoaXMgaXMgYSBkYXRhLXZhbGlkYXRp
b24gaGFyZGVuaW5nIGZpeDogdGhlIElTSCBmaXJtd2FyZSBpcyB3aXRoaW4NCj4+IHRoZSBwbGF0
Zm9ybSB0cnVzdCBib3VuZGFyeSAobG9hZGVkIHZpYSBDU01FKS4NCj4+DQo+PiBUaGlzIHBhdGNo
IHdhcyBkcmFmdGVkIHdpdGggQUkgYXNzaXN0YW5jZTsgdGhlIHZ1bG5lcmFiaWxpdHkgYW5hbHlz
aXMNCj4+IGFuZCBzb3VyY2UtbGV2ZWwgdmVyaWZpY2F0aW9uIHdlcmUgZG9uZSBtYW51YWxseS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGVuIFlvbmdjaGFvIDxncmF5aGF0QGZveG1haWwuY29t
Pg0KPj4gRml4ZXM6IDBiMjhjYjRiY2IxNyAoIkhJRDogaW50ZWwtaXNoLWhpZDogSVNIIEhJRCBj
bGllbnQgZHJpdmVyIikNCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+DQo+TWlzc2lu
Zw0KPg0KPkFzc2lzdGVkLWJ5OiBBR0VOVF9OQU1FOk1PREVMX1ZFUlNJT04gW1RPT0wxXSBbVE9P
TDJdDQo+DQo+DQo+VGhhbmtzLA0KPlNyaW5pdmFzDQo+DQoNCg==
