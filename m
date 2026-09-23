Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE836369D7D;
	Wed, 23 Sep 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207739; cv=fail; b=ZH5HldjwfoV0vmFTH2QtqvxhzNMS9vYRTFPWyBrEkAE1WYuCXR/SUfG6/ZyovG80+C7RzJl62JDBrUEMw+eM+w8AOMKtlWb0avVZ1vR9jE5OBIMIaV14+grXmFQLekwQ49Dh9zrwz3ZNHXKUGLPpn5/hjTPnE2evM/L1i/6Akz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207739; c=relaxed/simple;
	bh=9uRtC2M8Fa+BwpQExG4mShBJkzXGsUTonRuvZsxqqSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNYDOG05Inv70W4ke/eIGTr62ZEyiyceiBzo6GYinl+ta4bDIqw5ZzEwue27YlNj5XNm6rle8G92XNo5AHvgfMBatfeHpyakLb77ZpZPkCJ4f08kKenyg55svsQd+y4iD0LvbIpOMlm0GjPd3bOfxkiTS8wZuY6zMWeHpeA/7Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAAHRxX7; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAAHRxX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790207738; x=1821743738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9uRtC2M8Fa+BwpQExG4mShBJkzXGsUTonRuvZsxqqSE=;
  b=DAAHRxX7mhivn16J4lppDvlkFnhApxwS2N0nhto/MMvONG5y5ngndjaE
   nEz2lA4tFjT8tCJmSGAXjhlFX8zHpN0lmgmwk3qjG3c8KSRKMYB8YT4Kj
   21LBkIvlXiSrIAUDJskZMT7ZUxXSaWPMBqeBePArrUM9LFMd6JBS6RMNk
   UZnCzPqDIORMGh/R5YiUVjlxUFQDMGfZoP0DTFeCbPDVmhmkfhkEm6QJU
   BsixKyRZLop/T8ZbK17Ub/hXaGqhU+OPgvvCVRFGQ/3tHg783vn1SOmy4
   UlV/FbfeubkpNx5PGv7t4cxaY2vpj7/U7o+GVhfxabde9aYJNl+r6b+yw
   A==;
X-CSE-ConnectionGUID: HmFu1JexQLyjfhYoO2TGLg==
X-CSE-MsgGUID: lU+sZoYtQq26nQbki7Chvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1458554"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1458554"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 16:55:38 -0700
X-CSE-ConnectionGUID: OY5vbmEhQ5yVfhiK6g5smQ==
X-CSE-MsgGUID: UlPrNZnTQOKWrI/ylT9wog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="278565952"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 16:55:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 16:55:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 16:55:37 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 16:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8pz8GoLZN9eliqEMcLySUofUDj0UUlv7ceO/zwqt8K/RmMxDelfhSC3/0GkZ1qYNUl/4/Lg1Oa1XWFW5BClhHGfjGY2kwJfUnkCOytgFiPPT2sApGWcsQb8C0guFMbmNPDRsSpIrsAULp23VPYsovtcyN12EKlaRRAhAgIdaGKTwf8ya1B42/MNqsE63X/OiyA72pSGP6weH8ueyJxw1sqwC03tvtH0JO1+rL73WaDo02wIHCYueuqv2HWikvVYdzl69OP6so+LOsPSvkugavQSnJLO7SbLjrwJnbRFSlcA5Ngzmptky1YlWXngcobGfPmrs7p+i4graCvvwNzgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uRtC2M8Fa+BwpQExG4mShBJkzXGsUTonRuvZsxqqSE=;
 b=lyzA2xjcu8SIFfQKF9cw+bRUlU4ucYVuUWx8ooIhXc1k4OYrmodiJnNFztU+8DJHUYK1d9QkjY3xRjKlivxC/8kTjSA8CfGZdhhRUDnN8IYLpvFrXiNVraQ9900JrsaLvgiMNQDhdj2sYSTnfJ3SaggdM0RPDmsDtlwz/2dkAzCTSPKPUaWlJx/cRJo+KPlIzmm11BBgJlOBadqqzIbkVK5mFKh93pb+l1EafftKuXRjcLgouFyv+RLbPRtqH3wd34oyMlJCgjrfu62B5A98OdGsV4wEDmdQ3GXCm5yIOLsXcZd82p+ka0OyPgsncE4V87dDNGGzjhDlYoRqIWstGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 23:55:29 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 23:55:29 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] HID: Intel-thc-hid: Use hid_safe_input_report()
Thread-Topic: [PATCH 0/2] HID: Intel-thc-hid: Use hid_safe_input_report()
Thread-Index: AQHdSj2yji4goMJhd0642WhYaqF6/7bcYs6AgAB2o/A=
Date: Wed, 23 Sep 2026 23:55:29 +0000
Message-ID: <SJ0PR11MB7704C7E15F99B2AB5825F56AF4822@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20260922025437.940072-1-even.xu@intel.com>
 <8o1s43n1-spn5-oqn0-38p6-sps024p3p1o6@xreary.bet>
In-Reply-To: <8o1s43n1-spn5-oqn0-38p6-sps024p3p1o6@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|LV2PR11MB6069:EE_
x-ms-office365-filtering-correlation-id: c04ee19a-3db3-48d7-0361-08df19ce25c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: kkUqnrC3fWd6+70m9+8heFO0iqu0kAQaR+6PcbC+AwxuJJIZvuUbsTMOa6SCbdI7RU3MyUFove0tZSYPVkC17x2cjFC973J1UW/ZoE/L1VQBQUg8bGqn4yxcJ7MRk+3VzofYF5UhcUinjAfhcZ8ceQUbatcASxECe4+y6JDpmuEa+L77YZNxCKeG6fH0PwknW/R/vrBjDhWk9OgxctROID0/2zYWSOFVexSmC8A0FiX5oo6AK8LsZiq+mdrQEV9qB7Y9y3RBBQteM72Yok6VE7A73DiftTFvRGjOFaCFonapdI3/kifPPg02Alybo/r2Q6fgW8nAGOVkrpZUYa4P0T504OtUOnKjtQLncHnX0dCRRQQjqy0p/7mhMHruPtVfJv+VBqdKXaheM3VPZwzUvXsQRZ03GUmtR802iFiZ7EttXFtBmmQcfja1tNOpZQUbmodtumBLOxDNLKA9Q7T5FVCwas71yJs66tYx/Q0regylr9afD3TAvEYZ9gcrehh0p/i7DiBm9P0t12aUsn5l/qALQ6B7o8J9+lxiAP4kA8A2Su3LIb8WiIjqoPNbUtYfInGWsnyblY3wZSc3DtOcuz25HNJJNcPzqi0nuW9E9xxJIW9foWFkRquoxJj+JQevBzyk2xcWW4BsolFDwe/B5Zfp52MR+vNbHg7cA9XGgzniQSWjfShfF3yBIZnystTIXlPo+LsyvLlp6U2ePuTKJWlV6ItZSr1OwYd56jSeeQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?881f26L40hk09rU1FyrMGwwQhlii2iiKvDgqnLEJ4WFMp9S5izlltpYr7b+7?=
 =?us-ascii?Q?ilkPrVRSyFrNEiNm8QHR9JZ/uPMmKTcQUkP/BVOObLKeZNrmsfQIp335xZdR?=
 =?us-ascii?Q?aqvVw6J8SxyVGwVsdi8qCHz1CVr3fZjI4nRuZuTHkSR6j/bnvjhCLdnjWcZD?=
 =?us-ascii?Q?mSbWRz/9i15tQ5RjD6d8PRz9BceV66vK9pN5X+XGwuJ/O4MzzLv1kZKtelky?=
 =?us-ascii?Q?SnLXNl0eJ61Rb4r+gl/VY+WcmzQ3wXv82rAJjFcXAYPIzbu/NHbF4ZibbV2L?=
 =?us-ascii?Q?RyJzh47eJARUVk44cskJPrc3DnM6HTnAel6bA7y3KPxAj5fWhfSPEe4IfI9Y?=
 =?us-ascii?Q?ZLJG+dUUzmbb8fVbPhfPvZKGos7xVH7b+Pc3x56d8HiRtK5oj9M7dtHFx7LU?=
 =?us-ascii?Q?Ni3mxkyxb4ecz34tckze30h6RKAek0/RfMDqcU2wPD/zdTdCFwQJOQqpIrGt?=
 =?us-ascii?Q?M7WMJY8tTzxxfXeBeGsbXe8ARtsUjS6NdCdcUhx082wPetlJHOJFcdseSUrn?=
 =?us-ascii?Q?iD0e+p/CPgEgQynVwbJTor7RHMh1JUNBWAEhB5BXQ1oWqPUw+d0SHs6PYB3q?=
 =?us-ascii?Q?DMMr73eGcYoxN90wZ7d7gvpqJCW/BhEir47FkF/bEw+V3tgdM3pjtfDgQskp?=
 =?us-ascii?Q?RVTNCF4Xj0rYmkpC9/5q+MeGMQupjxitBmM6hzm3T4OcfA9nJL04Mi0QjvL/?=
 =?us-ascii?Q?I6KnI9733Jib27bIXCFWJWfAm+2gVmGvpPjeqka+I2tkxG7Qy1e9hyl4iu4N?=
 =?us-ascii?Q?dVZ8vBezlgy+L1BbWvMmfsJV4zqO3coMA4muY4vDsz+vwp74DFO3/fMsldV9?=
 =?us-ascii?Q?mVTq5fJf+5F23YoU/vpGd3FrFlcD+z3XoTIpapb3FwFr/TDKRaY3sJCEc91L?=
 =?us-ascii?Q?JlbvGULQnGyTNbfvpAAV+kjHEofJQefCJxEDJC8OruqJ60zK8bxSUQw9yzZw?=
 =?us-ascii?Q?eoXNn/wQsElF5KrvKgCeskwEud9fTbAQChqX3pt2+HLnUiKo6UsBfyN3ITH2?=
 =?us-ascii?Q?IhZNQVi3ppiueWM+mhuxvo2w+PWZD/NcjKxJ6cZVeE86voq8OreSL/JeNDkY?=
 =?us-ascii?Q?cEwDFOZ5grrrWSzH+17vMpHBlEZWFGiKlfCblh4Rg7aamCXdmgKWac7/YHg4?=
 =?us-ascii?Q?11oIaUdU7Ysil7G0zRgD2uaoNZbMrcJfYx3U3ioZC3r/1pj6OgZe6FB4TXdl?=
 =?us-ascii?Q?0q63sg5V1WWl3U9uM5K6hB5TU21d2okQKgDWf5ArndVPzxFJfwbZvClqrDeR?=
 =?us-ascii?Q?EAN4GNNFtfcpBgy5ShjtWqMA0LU2GFEd8I4mg9y+NnurxsguzQoQRhwcP2cu?=
 =?us-ascii?Q?HY0kkxIQ0Kc/6EGAc93dXk3IA77JplXAHHWWJdTLECImo8MiIBXlCY+LsOpO?=
 =?us-ascii?Q?XeHOhLuXtvrIVXp3vVhGeFGwUL92vs9VRYsmOL9F/nTDstBUXFSKEV0tgWSH?=
 =?us-ascii?Q?QrpOM3naDT0dk5DD/PAnnTkE2T42Y0ZJW6WiJSmIzpK9sMR9wVW4Y3L22zWZ?=
 =?us-ascii?Q?yZhtPc2lOya41C3uFyEBBfPrxgbds1TWRayEZdcnMOckWwVWGfdY+NrzB951?=
 =?us-ascii?Q?rRyu9c2DUODuqCxfewOgk2RZ5yBWVZRoc09a1RB5dG2K+w6jDEVHdPiBRKhH?=
 =?us-ascii?Q?9uzSFHHwyRhNXeKILZHkQMcwkkkDsi0CIWjxg1Tn5aMM8WepxPeIgWb8rmOv?=
 =?us-ascii?Q?poebNO7ngAFRktOFUeRc2sujq/GW2DehFrSfLfkV+xpYflqs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dIhs7MKvNSieGroML2KCfYq4QhJKSuDfR8jm/KfqNN4FMEZl3YMJjqcASvDr0lHkQJsCBNMJ2ZfUN8yq6msQScd8CaX/CkKA8PLiBhTh1utnTe4QA/8ETyaYpMs+BJRvka5LeT+1KsjG7BoWlFSVJMf1/Cp8HqA21vinT1kP00Yd39XTpOQ7LR6RzaTMxj89XAwBa2wMXqIZcSD0WgZhBB318iDpuoVlQxNxBc8VuoS1SDi4W58Vo/e7C+pj5ngSA0E98PrVz7znjWvD8m7NwfwWDSZFs28WDCWPELPQDdWKhmwxftwD03dCLZRHhlPbK3tEygtwfpe8uQZV5A5PvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ee19a-3db3-48d7-0361-08df19ce25c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 23:55:29.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC/dG8+X14TErV4MF8NsO145ZAkoYfS6GbWCqU9StgsuLszuVcPH+aSf3gfaNveTZCRs0kb2eGh271+gRs/WZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

Thanks Jiri!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Thursday, September 24, 2026 12:51 AM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] HID: Intel-thc-hid: Use hid_safe_input_report()
>=20
> On Tue, 22 Sep 2026, Even Xu wrote:
>=20
> > This patch set replace the legacy hid_input_report() with new
> > hid_safe_input_report() in quicki2c and quickspi drivers.
>=20
> Applied, thanks.
>=20
> --
> Jiri Kosina
> SUSE Labs

