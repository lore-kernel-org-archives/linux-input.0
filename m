Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150F2D3ED1;
	Thu, 15 Oct 2026 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029172; cv=fail; b=aytfsP7YFzVjY4SioTKQ5zqolnE+0qo0V3UuioygKO/XOUXuWHI/X7PLWyQxpp9BosbR/DnUbbt+syTbeqDHpuO6tYRPxJjGDKCA9TBDtKbtV4v1loarZCJhoBhZa0kY5jO4nuqHAuuDgGWrS4F40KUuD4dfNddmiu3iyB5eMkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029172; c=relaxed/simple;
	bh=HMweOU22HVDFsVTT5cOdOxEAYDOsx4kotJyevsncvOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAVK1u7RsRuwOB2BVaxtJAPRisZbaNGDRUtopHZj6NoH64wLkb5iJ30SfJn2BoN14SvVvgiHOZ+XyTfUSYB+w5MU5k9Z3xUjraERR99H6/yaa4CHbFOb/IkQxhdTyCXfu6z5rokor7CXuzUkV+kXx6iWJcsvG7YzJmXC0lAK+lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YW2ijth7; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YW2ijth7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792029169; x=1823565169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HMweOU22HVDFsVTT5cOdOxEAYDOsx4kotJyevsncvOE=;
  b=YW2ijth7uvMGHIqhtIYOi+m1wj/fYinLoJGT0Bxl+GBULcsYl4P7pb32
   EDwv6MiZ/lONj325ffKL/HlRtFaf8Rz5McTVkNwYHsd/CLvIYySwYBJD0
   DNdrabRWtTyl37NQvKtqC9HnBfHbdMBF22IOFce7k0Zlyr8beuUj7sxDz
   ea++3I5UbAovG5s014YCFCxYWneyGLGVNVFII7jWa5DBvn/OShP529CBD
   8lSy9+/srwfZVw78rm5+CJ8azGFqDXJabQFTZ8IIRZpA5m19yrCF75n8y
   q4RgE5cFRDt770Jtj2NqRgorjOg56aEofsEFhRI3wEAm/EdSc/x8GvmKg
   g==;
X-CSE-ConnectionGUID: +I/NAr/LQIqhZj2G0DPH1w==
X-CSE-MsgGUID: Gk6V8g3qQ4WlAU5og5OMEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="685048"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="685048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:52:48 -0700
X-CSE-ConnectionGUID: tvVUeT+jRnCw80bBEayAiA==
X-CSE-MsgGUID: lmqeVVcNSpy3GAOOqltqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1886573"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:52:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 18:52:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 18:52:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 18:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSD1clatXRGdMOfqcwgjBP3UVFIcLhVLJ6ZVuCzrKRuiogq6uqTCH6YAFH6cW6vX/8LlqpVwG5jN/tEhUUhvZM1d+Go9eqX5jV6LIvCneAMb9wY0akwKRUN//uF9s+2efzU9G4flayj/rUoZndmFV0zbR4w8OXhDuWQ3oxT/4I7+Bgm3j39cgeS4qvLIouLTTxT/DGU3B5IioT054DQ+c8XyUAd8aRZ57f1eBvAR2dgI1TRZ3IQtY6pL8jzYpfDA0NIH7kPkRU5EI4sx61VzU/y6Q/DdPhB832DX3697f4b8gLVryDeLw2+SY15v8m9/xehkXFwC9FGeY9yKPL3JiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMweOU22HVDFsVTT5cOdOxEAYDOsx4kotJyevsncvOE=;
 b=jeKgLFUNhuxTuvyQr869rL8ltnXiwGbnc7WaiwKYjDfm1mQVDzbzAryUzoyOxqNaGsMXyzS7Cm0pAiQUSSiOmQvhOcHBdhL2NtMLzvYJwgKFuPcfJS3+/dueXhE9INw/+hNvvoUl0bQQIT1zr5YXXPYyaaqbhfHeAQNX4LH6er0tSIIxI+10Q1FlFbwUFO+7n0WUtrXC7IEjLLcJ79ZavhN9x2lRUWmVrRMNsYUiicq+9JfewvNoftAidOwKW4b3zS/J8g6voPFeuU8DuYx7ZnawaE6enlyryy4iRdukPuaOXpbvoXtLG0VDqzw4rUww9v25mptL/0cb6/cBtQoK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 01:52:36 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 01:52:36 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdWcy4vOmMlsQh90ux6EsTDq93ibb6pUzggAMhZQCAABUAUA==
Date: Thu, 15 Oct 2026 01:52:36 +0000
Message-ID: <SJ0PR11MB7704B813C9011D9478BA2BF4F49C2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-2-mhun512@gmail.com>
 <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
 <CAGEsz8H4z7cpJQkmFGcqnCT+H56OuUHQDch6kh13TiOo0b-TFA@mail.gmail.com>
In-Reply-To: <CAGEsz8H4z7cpJQkmFGcqnCT+H56OuUHQDch6kh13TiOo0b-TFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|SA1PR11MB8328:EE_
x-ms-office365-filtering-correlation-id: 829a7538-ee2a-4611-5c08-08df2a5efc84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: l+9sAKBNJsP3iyVQ6Dp6/tzpMYXS8LWmvtPeDCcp7YY9wukg4XdgXJRxMacU+mZ8tPSYs4L2lM+Qyu0CcX5/O6huDQ2YTEGBWOldMhipVtw9SMFJzfQR+pHw0Ha/Q1ZwX6kHSvYCJS0t4vg20VxhHtcCg06pMvRYzfet6U5k2R41/AnwfN3VGdq1A8I+dtyNw8pdxl7b8lXF3BObBE4MGiNDxcn0cjWP/PbdiED7tQTvJIERt0fM5J1/fUokchEcZdS8z3b5cqA+d6mlR8/jQTIGxAd8RxKm2RXIg5Oj9wT33M0N+0K0D8zYipsb7jka6vQ5rp/mi6XJE1MQbhxJKDnj0dfacESKfx1XoAIljYVtm8QArzXSpRiSApvFGspVTAnhqxgt/MfQEC4Ookr4AZ7brvniV59LymBy00Lqkv7SCr6ZcyxRQSQt8PUz6PDgQs50jGbI1MGuk0w0Eusa/qiXZ561dQ+/SW+vh9FQxuXo32erypgOiA4myYA5jp5EIzkLBiWfNsVzHAAx5YMdwtOoRzhVyI/kUs0/AXmV3azbMAxT9SB3xdjfW/ungewyzWCvWyuXJTjAsfClAEMaUGkprL/JtU9S7INen+6FkQgF93xW9lijnQbAZSOKId7VAPUgMYl8TWkPRwW+arKNMZ8nO++jUoom/bKs2mbBRNQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGVLM21kMzM2QTBEb0VHUHhBM0pjZkkxL21DN3NtcjhJZVJJRG5uUkdPNTV1?=
 =?utf-8?B?OUZxU05Odi91Yk9LZGg0MkFDd3pJQzlXMUlYVFRQQjRSUFlYRWJFY1Noc2RX?=
 =?utf-8?B?cXZ2TzJGcGI4bkE4eEs2UU1zVGNSN29qODllMDlScTNwY1FmYTdWMkxvSElO?=
 =?utf-8?B?T3JTenhuRGgzamR4LzQ1cTVOOWh0RGtiRFFIUHNXQnFIZ3VXT29sTjdUWmtn?=
 =?utf-8?B?MlpKbUYrZGdwK0lVK0lyQWxrM2xPZEV2dWJxL3cvaDlodGFtQ050d1FPbHl6?=
 =?utf-8?B?NE9icmJLYmJrNHdPKzE2SHVGWFRiL3E0dEZENTl2c004RkhWdUZzTnQwbENt?=
 =?utf-8?B?UzdHdDVwL29RZEp1aU1oNk9LTVZhOHFKNFBpc3F3T0h1aTMxOEV2ODNQWkQ2?=
 =?utf-8?B?dndPNVZpLzNqR1JzQUVPekwvOFQyL2NhaU5SUDdjVy9iYVplOGRJUm5HWE5I?=
 =?utf-8?B?L1F2dVBjYmIwQnJabGwvR1VkYUZXZXNUUExta1BwWjErYzBkNUFVU2JmZCs0?=
 =?utf-8?B?bW1tWkNNYnNRUHArOTlwYm9Bb1hucUZKZXgyWnNmS25HSU5uVHY2THFsMHR3?=
 =?utf-8?B?SUd3ZmJINFk5RldlSWdETXgwamFOcTBvb2ZsTVFoMmJYR3VkYWZWemYwdUtN?=
 =?utf-8?B?L3RodUNMc2IxaDZRdjFkUG5ob1RKWWhNMTRUNUhUc3R4bWw5a0gxRndrSFhV?=
 =?utf-8?B?Q0ZIWk5xV3V4UWtVVytjbm93Qzd4Y05Gd1AwNFdySTFlZkNEczNoWTcza0d4?=
 =?utf-8?B?eFNiVXNSVW5QWkR0aGRMRGNCTzkzdjc3NUhzMGlsZEdxL04vUG1lNVZnYWpE?=
 =?utf-8?B?bVl6YTBaV2VZSzdCeS9sNmdOYXJGelZyN1JnWkxGMnl6NFdGb3BqRlBNdVNV?=
 =?utf-8?B?aHk1ZUFvSzBjeHU3S3BJR0dKR3JLUXN4YnRiWTUyV21jV2IyV0lISzk5S2tj?=
 =?utf-8?B?Y2NwTU9MbXYxSllUb05DZytkSUhMVGRjdS9LUHZabzZvckk0K0ViQmJEN2Q1?=
 =?utf-8?B?aUJBRzlBdzdLTXJYOVlMbytrY0dyK0dIQnFYaFI1TUFYejlVM0grZXFIM29V?=
 =?utf-8?B?RHdYb3ZKVDk2REdGNyt4dHlpajJCeFJsOThGZ1IvV2d4K1JidVFQVUlobFRr?=
 =?utf-8?B?enpoQmlDL1ZicnAxeG5USDNWQ2ZSZmJER0UrL0xlY0JUckZZZzYzenpYOSs4?=
 =?utf-8?B?ajQ3am04Z1NVODZhb2s3UlR0OXNqdGZobDF5c2h0WElNVFhwdW40RjBWcXQ5?=
 =?utf-8?B?d016eXBpRTM0MHhub0VLZHl3bVFnUlFBR3JCeTZNQThtdG1tMThkYVFHVTN1?=
 =?utf-8?B?UXRqRkNka0d2RzBFSi8yWC9jV1luWEhHbUU4SDB4dlpJMmhKdi9nblU1MEVm?=
 =?utf-8?B?M2lWT2pJSVlabmUxVVNuR0VhVzRDS3FFL040cFVGTlh5VXUrRi94cU5RR3Fn?=
 =?utf-8?B?NTNQNXU3S1BCbzQxUzJKL2xpWUpoK3VtTzVmTitmK3lGK3FNL3QzNzhFVnZR?=
 =?utf-8?B?NzVxYU8waDU5Tm1UNWVMblR2U1Y3bGpaMXRaSzVEcTZKOFkwb1podXRtcWxa?=
 =?utf-8?B?bDl6TkFUdWlOMnI5RlRsMkN2QmZqMmk5bDI0MCs1dktXV2U4dWJzNkVzQkNQ?=
 =?utf-8?B?V0NacEFBNnFTSGlMTnBVLzZHMWFRUWFpUEFjTlFuNW8zUTJxZmUwMzhRZWM1?=
 =?utf-8?B?bzhiekgxZDlEUU5QcUZlOURBaXRNamJKT1VHYk95L0FXU0ljQTBIdjMwcEhX?=
 =?utf-8?B?MzFPalJRMXdobzEwak1SamdVUVBYaGFONktsWjM2d2IrY1VUYnVjQm1EZUND?=
 =?utf-8?B?RXQ3c2xpeTkzS3FNOG1JeVJSVlJuaHBuMXBiVTdFZ1h6cGNjQ0o4VUpzcVox?=
 =?utf-8?B?L296d2N0SHcwUGQ2eU5IbUFXREpEdDQxVldYWnIwYXA0OS9SdVBNVGlIVWtN?=
 =?utf-8?B?OTB5bk5jV0NvYXdlN1NHa1dlSFZBa2xJN2JGcW9xODQ3cWVoTFo3N1ZmRTc0?=
 =?utf-8?B?d3JDNlhKMnFHbEhuY3dBVlhKbDh4MWNodENFYy9jT0V4QjZnTnlxK2FoNDhO?=
 =?utf-8?B?Zi9uVEhwMG9XRTVSa0hGV3hxK1hjN0N4bVl4TlNlQ1QycVpIV3hFYVZKd2VY?=
 =?utf-8?B?bHJWai9iRlcva210R2ZkclhDZEpCZlMyZU9sS1ZkTXU1MzBEanlNV0VHdTVi?=
 =?utf-8?B?RUo5QWlLVW1jTVB2MmNqNG5kVzljbmt0aWhLeXpFLzZPYzFVVTlYeFFJTlFa?=
 =?utf-8?B?OWFIalZOSjB5QnpvMEhYRytJdW5VYTlYNURJdkQveTFLYXJIMG5kVTczWUVN?=
 =?utf-8?Q?TfXaPlZ+XrHXUXxHJg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qVRvbaPqxFExVI5f+SpAWgflLe/7sJhz3+GYPgQJM1GOReRgNhg+Z7IemXt0CKVxHpN1EKSLonTIiMWzkM7DSHYnKX/9zhllVl6I7MjapVJOjpeIqNWoRViQERnHMTaczP6KTz2Ao74OJDeBe21znUGoYIkJFeljs73D9HEygtreM7t9TnfHaEBq1l12M1ANlh3R27UZkiXtm7/F6kRQo+sQkMXn7HmFkH6pqT/tnP6RdKq7fx3lOyxiOuA7ZKblMpnnSl3uS9Yg/oVdZBnEatKf8vPKjGlXoApAXZt+yBQIBs74ZakKWQJwewR/ZV+PgkxW1ll0ZhR7erGYgviPxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829a7538-ee2a-4611-5c08-08df2a5efc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 01:52:36.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rQWNrh7lbbs+8Iu/Ln9XpphmBxjxB3O/Oyh1nOVY0IT6Mw0u+6IBCbVCyJ10wmOJCNtYHT7dqFIqPuLy4Zb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

SGksIE15ZW9uZ2h1biwNCg0KVGhlbiBsZXQgbWUgdGVzdCBpdCwgaXQgbWF5IHRha2Ugc2V2ZXJh
bCBkYXlzLg0KV2lsbCBmZWVkYmFjayBvbmNlIHRlc3QgZmluaXNoZWQuDQoNCkJlc3QgUmVnYXJk
cywNCkV2ZW4gWHUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNeWVv
bmdodW4gUGFrIDxtaHVuNTEyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MTUsIDIwMjYgODozNiBBTQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBD
YzogU3VuLCBYaW5wZW5nIDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+OyBKaXJpIEtvc2luYSA8amlr
b3NAa2VybmVsLm9yZz47DQo+IEJlbmphbWluIFRpc3NvaXJlcyA8YmVudGlzc0BrZXJuZWwub3Jn
PjsgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRl
bC5jb20+OyBNYXJrIFBlYXJzb24gPG1wZWFyc29uLQ0KPiBsZW5vdm9Ac3F1ZWJiLmNhPjsgbGlu
dXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBJamFlIEtpbSA8YWU4NzgwMDBAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gSElEOiBpbnRlbC10aGMtaGlkOiBxdWlja3NwaTogcXVpZXNjZSBJUlFzIGR1cmluZw0KPiB0
ZWFyZG93bg0KPiANCj4gSGkgRXZlbiwNCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBw
YXRjaC4NCj4gDQo+IE5vLCBJIGhhdmVuJ3QgdGVzdGVkIGl0IG9uIGFjdHVhbCBoYXJkd2FyZS4g
SSBoYXZlIG9ubHkgY29tcGlsZS10ZXN0ZWQgaXQgd2l0aCBHQ0MNCj4gYW5kIFc9MSBvbiB4ODZf
NjQuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IE15ZW9uZ2h1bg0KPiANCj4gMjAyNuuFhCAxMOyb
lCAxMuydvCAo7JuUKSDsmKTtm4QgODo1MiwgWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPuuL
mOydtCDsnpHshLE6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwuY29tPg0KPiA+ID4gU2Vu
dDogTW9uZGF5LCBPY3RvYmVyIDEyLCAyMDI2IDY6MDYgQU0NCj4gPiA+IFRvOiBYdSwgRXZlbiA8
ZXZlbi54dUBpbnRlbC5jb20+OyBTdW4sIFhpbnBlbmcNCj4gPiA+IDx4aW5wZW5nLnN1bkBpbnRl
bC5jb20+OyBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IEJlbmphbWluDQo+ID4gPiBU
aXNzb2lyZXMgPGJlbnRpc3NAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2
YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT47IE1hcmsNCj4gPiA+IFBl
YXJzb24gPG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4gPiBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgSWphZSBLaW0gPGFl
ODc4MDAwQGdtYWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIEhJRDogaW50ZWwt
dGhjLWhpZDogcXVpY2tzcGk6IHF1aWVzY2UgSVJRcw0KPiA+ID4gZHVyaW5nIHRlYXJkb3duDQo+
ID4gPg0KPiA+ID4gVGhlIG1hbmFnZWQgSVJRIGNhbiBhY2Nlc3MgSElEL0RNQSBidWZmZXJzIG9y
IHF1ZXVlIHJlY292ZXJ5IHdvcmsNCj4gPiA+IHdoaWxlIHJlbW92ZSBvciBwcm9iZSB1bndpbmQg
dGVhcnMgZG93biB0aG9zZSByZXNvdXJjZXMuDQo+ID4gPg0KPiA+ID4gRGlzYWJsZSBhbmQgc3lu
Y2hyb25pemUgdGhlIElSUSwgZHJhaW4gcmVjb3Zlcnkgd29yaywgdGhlbiBtYXNrIFRIQw0KPiA+
ID4gaW50ZXJydXB0cyBiZWZvcmUgZnJlZWluZyB0aGUgSVJRIGFuZCByZWxlYXNpbmcgSElEL0RN
QSByZXNvdXJjZXMuDQo+ID4gPiBUcmFjayBJUlEvRE1BIGluaXRpYWxpemF0aW9uIGZvciBjb25k
aXRpb25hbCBwcm9iZSBjbGVhbnVwLg0KPiA+ID4NCj4gPiA+IERpc2FibGUgdGhlIElSUSBiZWZv
cmUgc2h1dGRvd24gZGVpbml0IGFzIHdlbGwuIEtlZXAgSVJRIGRpc2FibGluZw0KPiA+ID4gYW5k
IHJlbGVhc2Ugb3V0c2lkZSB0aGUgc2hhcmVkIGhpYmVybmF0aW9uIGhlbHBlci4NCj4gPiA+DQo+
ID4gPiBUaGlzIGlzc3VlIHdhcyBmb3VuZCBieSBzdGF0aWMgYW5hbHlzaXMuDQo+ID4NCj4gPiBU
aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4NCj4gPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgc3Rp
bGwgbmVjZXNzYXJ5LiBJdCBjYW4gcHJldmVudCBzb21lIGV4dHJlbWVseSB1bmxpa2VseSBidXQN
Cj4gcHJvYmxlbWF0aWMgY2FzZXMsIHN1Y2ggYXMgYW4gaW50ZXJydXB0IGFscmVhZHkgYmVpbmcg
cXVldWVkIGluIHRoZSB0aHJlYWQgYmVmb3JlDQo+IHRoZSBUSEMgaW50ZXJydXB0IGlzIGRpc2Fi
bGVkLiBIYXZlIHlvdSB0ZXN0ZWQgdGhpcyBjb2RlIG9uIGFjdHVhbCBoYXJkd2FyZT8NCj4gPg0K
PiA+IEJlc3QgUmVnYXJkcywNCj4gPiBFdmVuIFh1DQo+ID4NCj4gPiA+DQo+ID4gPiBGaXhlczog
NDEzOGYyMTExNWFlICgiSElEOiBpbnRlbC10aGMtaGlkOiBpbnRlbC1xdWlja3NwaTogQ29tcGxl
dGUNCj4gPiA+IFRIQyBRdWlja1NQSQ0KPiA+ID4gZHJpdmVyIikNCj4gPiA+IEFzc2lzdGVkLWJ5
OiBMTE0NCj4gPiA+IENvLWRldmVsb3BlZC1ieTogSWphZSBLaW0gPGFlODc4MDAwQGdtYWlsLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBNeWVvbmdodW4gUGFrIDxtaHVuNTEyQGdtYWlsLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gQ29tcGlsZS10ZXN0ZWQgd2l0aCBHQ0MsIFc9MSAoeDg2XzY0KS4gTm8g
cnVudGltZSB0ZXN0aW5nLg0KPiA+ID4NCj4gPiA+IFJlbGF0ZWQgcmVjb3Zlcnktd29yayByZXZp
ZXcgYW5kIHNlcmllczoNCj4gPiA+IGh0dHBzOi8vbG9yZS1rZXJuZWwuZ251d2VlYi5vcmcvbGlu
dXgtaW5wdXQvMjAyNjA3MTcwMzU2MDkuMzg3NDAxNS0xDQo+ID4gPiAtDQo+ID4gPiBldmVuLnh1
QGludGVsLmNvbS9ULw0KPiA+ID4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9saW51eC8yMDI2MDcyOTA1
MDE0NS4yMjcyNTk3LTEtZXZlbi54dUBpbnRlbC5jb20NCj4gPiA+IC8NCj4gPiA+DQo+ID4gPiAg
Li4uL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jICAgICAgICAgICAgIHwgMjggKysrKysr
KysrKysrKysrLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9pbnRl
bC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jDQo+ID4gPiBiL2RyaXZlcnMv
aGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcGNpLXF1aWNrc3BpLmMNCj4gPiA+IGlu
ZGV4IDg5MjI2ZjVjZTQ1ZS4uMGJkMjJmMjg1Yzc4IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9wY2ktcXVpY2tzcGkuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9wY2ktcXVpY2tz
cGkuYw0KPiA+ID4gQEAgLTU5Nyw2ICs1OTcsOCBAQCBzdGF0aWMgaW50IHF1aWNrc3BpX3Byb2Jl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKSAgew0KPiA+ID4gICAgICAgc3RydWN0IHF1aWNr
c3BpX2RldmljZSAqcXNkZXY7DQo+ID4gPiArICAgICBib29sIGRtYV9pbml0aWFsaXplZCA9IGZh
bHNlOw0KPiA+ID4gKyAgICAgYm9vbCBpcnFfcmVxdWVzdGVkID0gZmFsc2U7DQo+ID4gPiAgICAg
ICB2b2lkIF9faW9tZW0gKm1lbV9hZGRyOw0KPiA+ID4gICAgICAgaW50IHJldDsNCj4gPiA+DQo+
ID4gPiBAQCAtNjQ5LDYgKzY1MSw3IEBAIHN0YXRpYyBpbnQgcXVpY2tzcGlfcHJvYmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHFzZGV2KTsNCj4gPiA+ICAgICAgIGlmIChyZXQpDQo+ID4gPiAgICAgICAgICAgICAgIGdv
dG8gZGV2X2RlaW5pdDsNCj4gPiA+ICsgICAgIGlycV9yZXF1ZXN0ZWQgPSB0cnVlOw0KPiA+ID4N
Cj4gPiA+ICAgICAgIHJldCA9IHJlc2V0X3RpYyhxc2Rldik7DQo+ID4gPiAgICAgICBpZiAocmV0
KSB7DQo+ID4gPiBAQCAtNjY3LDE3ICs2NzAsMTggQEAgc3RhdGljIGludCBxdWlja3NwaV9wcm9i
ZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+ICAgICAgICAgICAgICAgZGV2X2VycigmcGRl
di0+ZGV2LCAiU2V0dXAgVEhDIERNQSBmYWlsZWQsIHJldD0gJWRcbiIsIHJldCk7DQo+ID4gPiAg
ICAgICAgICAgICAgIGdvdG8gZGV2X2RlaW5pdDsNCj4gPiA+ICAgICAgIH0NCj4gPiA+ICsgICAg
IGRtYV9pbml0aWFsaXplZCA9IHRydWU7DQo+ID4gPg0KPiA+ID4gICAgICAgcmV0ID0gcXVpY2tz
cGlfZ2V0X3JlcG9ydF9kZXNjcmlwdG9yKHFzZGV2KTsNCj4gPiA+ICAgICAgIGlmIChyZXQpIHsN
Cj4gPiA+ICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiR2V0IHJlcG9ydCBkZXNj
cmlwdG9yIGZhaWxlZCwgcmV0DQo+ID4gPiA9ICVkXG4iLCByZXQpOw0KPiA+ID4gLSAgICAgICAg
ICAgICBnb3RvIGRtYV9kZWluaXQ7DQo+ID4gPiArICAgICAgICAgICAgIGdvdG8gZGV2X2RlaW5p
dDsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICByZXQgPSBxdWlja3NwaV9oaWRf
cHJvYmUocXNkZXYpOw0KPiA+ID4gICAgICAgaWYgKHJldCkgew0KPiA+ID4gICAgICAgICAgICAg
ICBkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgSElEIGRldmljZSwNCj4g
PiA+IHJldCA9ICVkXG4iLCByZXQpOw0KPiA+ID4gLSAgICAgICAgICAgICBnb3RvIGRtYV9kZWlu
aXQ7DQo+ID4gPiArICAgICAgICAgICAgIGdvdG8gZGV2X2RlaW5pdDsNCj4gPiA+ICAgICAgIH0N
Cj4gPiA+DQo+ID4gPiAgICAgICBxc2Rldi0+c3RhdGUgPSBRVUlDS1NQSV9FTkFCTEVEOyBAQCAt
NjkyLDEwICs2OTYsMTYgQEAgc3RhdGljDQo+ID4gPiBpbnQgcXVpY2tzcGlfcHJvYmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYsDQo+ID4gPg0KPiA+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gPg0KPiA+
ID4gLWRtYV9kZWluaXQ6DQo+ID4gPiAtICAgICBxdWlja3NwaV9kbWFfZGVpbml0KHFzZGV2KTsN
Cj4gPiA+ICBkZXZfZGVpbml0Og0KPiA+ID4gKyAgICAgaWYgKGlycV9yZXF1ZXN0ZWQpIHsNCj4g
PiA+ICsgICAgICAgICAgICAgV1JJVEVfT05DRShxc2Rldi0+cmVjb3ZlcnlfZGlzYWJsZWQsIHRy
dWUpOw0KPiA+ID4gKyAgICAgICAgICAgICBkaXNhYmxlX2lycShwZGV2LT5pcnEpOw0KPiA+ID4g
KyAgICAgfQ0KPiA+ID4gICAgICAgcXVpY2tzcGlfZGV2X2RlaW5pdChxc2Rldik7DQo+ID4gPiAr
ICAgICBpZiAoaXJxX3JlcXVlc3RlZCkNCj4gPiA+ICsgICAgICAgICAgICAgZGV2bV9mcmVlX2ly
cSgmcGRldi0+ZGV2LCBwZGV2LT5pcnEsIHFzZGV2KTsNCj4gPiA+ICsgICAgIGlmIChkbWFfaW5p
dGlhbGl6ZWQpDQo+ID4gPiArICAgICAgICAgICAgIHF1aWNrc3BpX2RtYV9kZWluaXQocXNkZXYp
Ow0KPiA+ID4gIGRpc2FibGVfcGNpX2RldmljZToNCj4gPiA+ICAgICAgIHBjaV9jbGVhcl9tYXN0
ZXIocGRldik7DQo+ID4gPg0KPiA+ID4gQEAgLTcxOCw5ICs3MjgsMTIgQEAgc3RhdGljIHZvaWQg
cXVpY2tzcGlfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ID4gICAgICAgaWYgKCFx
c2RldikNCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4NCj4gPiA+IC0gICAgIHF1
aWNrc3BpX2hpZF9yZW1vdmUocXNkZXYpOw0KPiA+ID4gLQ0KPiA+ID4gKyAgICAgV1JJVEVfT05D
RShxc2Rldi0+cmVjb3ZlcnlfZGlzYWJsZWQsIHRydWUpOw0KPiA+ID4gKyAgICAgZGlzYWJsZV9p
cnEocGRldi0+aXJxKTsNCj4gPiA+ICAgICAgIHF1aWNrc3BpX2Rldl9kZWluaXQocXNkZXYpOw0K
PiA+ID4gKyAgICAgZGV2bV9mcmVlX2lycSgmcGRldi0+ZGV2LCBwZGV2LT5pcnEsIHFzZGV2KTsN
Cj4gPiA+ICsNCj4gPiA+ICsgICAgIHF1aWNrc3BpX2hpZF9yZW1vdmUocXNkZXYpOw0KPiA+ID4N
Cj4gPiA+ICAgICAgIHF1aWNrc3BpX2RtYV9kZWluaXQocXNkZXYpOw0KPiA+ID4NCj4gPiA+IEBA
IC03NDcsNiArNzYwLDkgQEAgc3RhdGljIHZvaWQgcXVpY2tzcGlfc2h1dGRvd24oc3RydWN0IHBj
aV9kZXYgKnBkZXYpDQo+ID4gPiAgICAgICBpZiAoIXFzZGV2KQ0KPiA+ID4gICAgICAgICAgICAg
ICByZXR1cm47DQo+ID4gPg0KPiA+ID4gKyAgICAgV1JJVEVfT05DRShxc2Rldi0+cmVjb3Zlcnlf
ZGlzYWJsZWQsIHRydWUpOw0KPiA+ID4gKyAgICAgZGlzYWJsZV9pcnEocGRldi0+aXJxKTsNCj4g
PiA+ICsNCj4gPiA+ICAgICAgIHF1aWNrc3BpX2Rldl9kZWluaXQocXNkZXYpOw0KPiA+ID4NCj4g
PiA+ICAgICAgIC8qIE11c3Qgc3RvcCBETUEgYmVmb3JlIHJlYm9vdCB0byBhdm9pZCBETUEgZW50
ZXJpbmcgaW50bw0KPiA+ID4gdW5rbm93biBzdGF0ZSAqLw0K
