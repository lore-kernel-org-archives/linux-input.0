Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58B37CD40
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304508; cv=fail; b=Wo9noTpvWrzhy1ilIg7dxXFE3/y8AdGuDNvs8GGfzoUQ6+8NffALsI1UD6IqilWhqVGK5pyjwEg/wQ7+wxYVJ53SIcfM+bn3aO/XF1VuyU+4pYoWb/RjrB776LT3XdHLtFwmQKfaU8qUlWQsuWAgVF/OWX6zs0byItNdSrLMbAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304508; c=relaxed/simple;
	bh=kglYwV8T/lUsvNnOKCzvm3M7Nuu/bu9kvpivZcdASsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oq8lpem+JnXXYrtBgOzcdF94ONmmJsnQW72s2dS5i/BOANRIRwKUDcJ1/8o5f6JMUgtJPFMFpNMjcwQN3AokMydrr+cEQIaZnWJJqJykef+l+Pn6DhhZkuNooZ0BoRpBAheQXVQNt7tQS43cN2BvKgZd632N9190T7BQlcCfg90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDp4U0RO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDp4U0RO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783304505; x=1814840505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kglYwV8T/lUsvNnOKCzvm3M7Nuu/bu9kvpivZcdASsI=;
  b=dDp4U0ROslJvYV49Sm/dYlhLhm4pw2WTm/3QKblo+ITpFLqbbjyBvwDJ
   XZX3kQNt8mjUv5VGaDGr7DF1FKcCvMzuaexELFrDcFOaGes/hP4fDW0nv
   fqXRWamBgOnkXlAJ0GBxUE467FZoMllyF3c4gTfF3cSyM9/Ox0KQWScbx
   P4q5jpIORDjbRzzo0sf6txOrmqULZtg4UzgpW0U7UzEGZgu2Zejq53c6+
   lN3LHEhHkWwsHVeAHkcqys1e+gpdgvq0zanISH8KYv54A9vpzQ4I4sJje
   APy351Tg7dwkGn5CLAxUF8RMTp/HPMrLAvkiw8G7zOj+FNPM6ryFim3oM
   g==;
X-CSE-ConnectionGUID: TI+W1oKIQ06ShcDvKNxD/A==
X-CSE-MsgGUID: yUVnmqmuS5OvyOcnmngcCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83981458"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83981458"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:21:43 -0700
X-CSE-ConnectionGUID: MAilScmuQKW2fuJoY5j5Uw==
X-CSE-MsgGUID: rkj4pcsoSMqSsSjeGWsTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="257915101"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:21:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 19:21:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 19:21:42 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 19:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+zRXK1Y2CEC3c1zcCYcov6CfrvaLmnOZU1Z0O0/O8tfbLkInulqOt+zdv2kUAvVMARNj6qRFasvd0q0LkQ38iyfzDixq2G0XRJkp9IFpLIlhRm4OuSUaNg7hru9DW2pa4W/AsYtqK4xk6xqdCfxOny+HeAxMAkNEWL03Wf55o1FV87bmcocwkeSfDDJHBGYKTfRyLJzAcVTimMQskKdiZ7BetCfTA1Q+tft2TBqmJALRz5tNNbnlRtvnGb4KylUhcKyY1Uml/OFmfzpByTz5+n9FF9Fk0kl6xDWLMmFRFmIdsHur8lvCCdrqL57M5shXg9h25SAM6MCJF6Jv36DPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglYwV8T/lUsvNnOKCzvm3M7Nuu/bu9kvpivZcdASsI=;
 b=esKA+oRUmc/oe1GYqYSTMatApMRpHRtMeKiBhL2S2SB4u57smB1U5SEHINiUrXxFtYBhf68mWIYj1pQWhFRrUFSM1Ne+HBKPAGXL+LxxvcppILVrUzBoSg0czM5XyhDoZ7QCttIttTSY6irgOHOmO7/a/2B4nAmMakTfOhs7p3+NFZZ+QXS8LjQkRYiDzeJhHQuWRKH34aK6PyM6cmNUgAZ8XfskU26BAfLeasxV9W4w6y6BKktRHGdauSqSP5IhEnxZ5CMBavGLmQNKFOY0ZaK4qMgm/GHJ5r74iD9M8qVu6Z47x6oQ6eI8a5H8Vr8lv3vfnSvqQNklkCW+gND2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 02:21:39 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 02:21:39 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: RE: [PATCH v2 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Thread-Topic: [PATCH v2 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Thread-Index: AQHdCsHCk2Wi75QxUkOncS4SkbQLCbZbceMAgARRMrA=
Date: Mon, 6 Jul 2026 02:21:39 +0000
Message-ID: <IA1PR11MB60984104D43BAFF17048C05FF4F12@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
 <20260703075858.2780398-2-even.xu@intel.com>
 <20260703081234.A85D41F00A3E@smtp.kernel.org>
In-Reply-To: <20260703081234.A85D41F00A3E@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB7513:EE_
x-ms-office365-filtering-correlation-id: 4b959ae5-4190-432a-ab4a-08dedb054fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: jl1BsoKMf7mqDW5YVrxzRl4sp7PMVXTCoO3tEsCJ0b0jmXFLR31yutyZtCKeEkUnh+3vTzGSXoKAAv54jliLunfOnSVgDdPCXE60AAsxGkw9mAmKRoH69cMHsOiniS8zJFQeoQniSec7+s5XUxR6LQrh9il8q7GvPYfMT/VBck3YQJdqkrZm7XWuwMeEevWAiWHxqszlQRPdpMMz3xCofSVmwk5LAXRecDwt3Nl2CfPYqG8rYRbK/tMMXHe1Rg5dySJAnjIC11imOSuEXbRh7V3a5Q9iR3YsiaoAyau63tuYmFsSuWYkrA31l54bwfdsN8K07ieCvE04XuvuYuJJ2w5+fN9N3OI72C7NUtGRSVAEaEF/nXlcZkagBOwYT/vG4hldOHdf2K84J1u4nN0lOUbtE30fQfmWoeLB3P52sejbD5OZBBFSnzNWWii/9kVLDneR0pGFUwHJ4Iu0GG9+3OLUibvvbYJ2gi/YRPZjxnFG22mT25T+ZP3x1atRvgpUrxoVZeB+LgPqNfYXBfUcreI8CQAzhqwNMoncnUuXpiy66GkuynBh9/v+6kqVirSQCxBRAsXyQ9sYWYJyfnzivXFrOs/bQ814YHRiSfzN4s1TqUBL4aV5wRG3VcoAkxvJ6WKsmpZjdvs3dt9f6gE7e3MLrzGNfT0Af/4ldzQBpj0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nll0YUpZRWk4TU9Rb3FzY3FESkEvM3B3WVR1K2d1bzlKcFJYWE5Bd0lBUTd6?=
 =?utf-8?B?bnZBMDdITTZGRDY1Njh5cS9nSkVuTnNwQzVlcTVBTTlqL3FPOHZhczlCWXlR?=
 =?utf-8?B?dVk1VWpDZnV2M1Q1eDlpYjFKOFNUWU5leUI3YkJiNjBoS0VPMllYU2JBVGNw?=
 =?utf-8?B?SkpOWDVtQjMzQ3VmblRWV2JDczNMWitqa0dYYU0xeE9jTVIxWWtBakluZ2VW?=
 =?utf-8?B?MjBabWt0eUZvUzdhMjRFNjUyRmpmYXpNa2tZL0FLVWJPekZKcC9ZSWFKNEJj?=
 =?utf-8?B?dGRRM29CQWFFWnljSVJOWS9iQm5WZklGb0FyYit5WHp0TkV5VmdCc2FIVWs2?=
 =?utf-8?B?aU9sNjdYMnVXT1U2RlRWa1l5bW8zNmwybkN1eWhka3c3L1RGQWhna2JwZ0ho?=
 =?utf-8?B?alg2cFpxcHFSLzg4TVBiUjA0RUZwZjNaOW51SDkrdnVpTGhQc1E1TXowZ0Zl?=
 =?utf-8?B?amI5eXU5ZTZSNThHdXBHaFU0ZVlTT3pRN1NiN3dkbnR3c3g1allTTkNmV0c3?=
 =?utf-8?B?OURzNlF0ckoxZEJISVpVZ0tsb1FMcDUxZllNVDN5UTMyREtwaE5Ha1Ywenp2?=
 =?utf-8?B?ZkI1RTBaQmFoeHZsY0x4SHlUb2xLaWE4TERkU000aVN4MmZENkQ3R1VzWFlk?=
 =?utf-8?B?QXJDb0Y3c09WK0dBOWtCVkdkN1kxaTMvQmZDYmdkMnZDcDZOSVZ1SXM1SnZk?=
 =?utf-8?B?akE5VVFJZ2thOHdBSU5tNnFjNi82RDFXTmlBZjJkejhHWFlSZkJZMWViZEZx?=
 =?utf-8?B?aGhIRFVXWk95NytudWNUeGRwYzgxSkZ2R2N3UHdqa25udDU5MlhlUkFrQWhW?=
 =?utf-8?B?YSt2SWJhM2VLM2JSUGk5eEttQW9tWWtlTHlPRVdXVTFzelZsTGFaV1JENkNy?=
 =?utf-8?B?Y05IUDAzNnRHbW4xYVpqdjNweCtFWTY0UlluZmNHcE9IT1kzSGhYd01SYkc0?=
 =?utf-8?B?QmhwQkQvRytqT2F3TzNvb2RVK20yWGUxcm5IU1ZkTU9TaGdhK2YzYTRKN3dK?=
 =?utf-8?B?RWRnZkFoVmticmR1bGVvOHNIeG1RQmFUWUtGcU96M21Fc0tvQ1I1ZU5JTk1S?=
 =?utf-8?B?TU44TDVLNXp4R2hVQjU5dFZVSmxaa0NZaTNGcHgyU1gvaVhyZ205bVVaSjdC?=
 =?utf-8?B?MWJkUlNNUUZ2U3dVTzd0clIzb28yUWdlV0Jodk9FY0o3aEVobmJKbGtzUUx0?=
 =?utf-8?B?TWNyV1lZV0wra0dvSlcvYlk5NXM3eVM2TVA5RWVGTVFubW5IVU5rSTZ1dGZQ?=
 =?utf-8?B?cTByTURWaTdzYjhVQzNEZ1N3elV2Rm94d05rOW9xWWtEWkZZWGtaL25Xbk9B?=
 =?utf-8?B?UGFNSU02bUtFdU1DckVnTjJLZGtYbGlMMjFjK0lxd0hLNlVhLytwRmJCeVJJ?=
 =?utf-8?B?dkJjT3k5OEhwdHYyQmVPNGFKcCtyRWJLNldhV24rWjNMNDQxNk9QVE9ER1pR?=
 =?utf-8?B?ZWRyQlNMSWI0K0pSNUFncXZ2ZUJtK1NtL3hOVjZVZTJnSmNLalIzSnQvaWZw?=
 =?utf-8?B?Q0s4UWtQb0NBeDQ0NmpnbkJjT01LRHdObThRM3FTdjdkY3ByclhhQnFFQTlT?=
 =?utf-8?B?T1NSM3Q4akZ1TnJ2VGZHSVJJdFFhTVp2R2JET0QxZWpHYkp1Ny9saUh5bWpQ?=
 =?utf-8?B?TmN1VFl0VUtpSmFTRUFjK3BVNVEyaXl5L0VCVFZ3STlPN29vM2RiWHd3OGgx?=
 =?utf-8?B?YjZlRTFhMnd6OXdQd0pUdUNlNUNwQUN2dnRTbGV5bzJaNHZPU1ZVZVJUbDg1?=
 =?utf-8?B?MUdwakNhODlDQXh4anZLSUwreEZZT3d6NTlXT3hkc3M5Wm0yVW5jY1JmMEpV?=
 =?utf-8?B?MkFKbWFZMXJOVGN6RnJXRU9wUEQvWEl4bUJJMnA2aXJSRW9oWS80bGhZVFVQ?=
 =?utf-8?B?aUV1cVliQXlueG9XbmZuajFpSXRuTlVydkhTUjIrUEdnK2VuMHJzbGhoL3A0?=
 =?utf-8?B?VkpEeUwvdFVMMXlMQTJobllua0hRRUNKUmNXenMyV0RJcE5sdHpHdndQQllF?=
 =?utf-8?B?dkVacXBhUHpOQk5FdmU2ZTdIanM2azJ4dSt6a2RRaWRva0JWSHJDUmUwYWsv?=
 =?utf-8?B?ejBRVmg2UXA3czYvYWR1NWs3NktMYzVGUE1pZE51R0QrR1hOaFI3STJ4QUF0?=
 =?utf-8?B?Y2N1QjJPRHpLQUk2RllBL0N0REJlV3k3ak8zd1VDU0FkdDVyUjc1UmpQWmov?=
 =?utf-8?B?V2dKWFE0T0pja3liTnlUZHp6M0ovL2tvOUlNVHVRK3c5RERBR0g1MzNOYjdU?=
 =?utf-8?B?YWFZNXM5SWFiQXFTUGZwRGdFQStVNlh5NzY4MlgwZnk1RUVsSHlaNE9lRFhD?=
 =?utf-8?Q?y3UoIJd/09Swar9wd1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FwQAhZ49rGYld6MtatvGtbGHBg20EuuxnMr7aDeDekl9wHZhZAL6QX4wxbd8vKS7tuMNaMLS6gX5+xI/p0diuel0DwUYLR5iCg1nXrF0/DwMEoUGq2ZrG03nA35n0KywQhQsMMi84q9ysDNyHJlrgdxX/t4xk+1orTHOXxqqIE1jdST6C5l2Z8/okl3iTuXRq5pM3Zmkv35D0n9pP68eFoxyBfWn7vZIsrKsdYM8f5HIZ/57F907mpc+eUODlsJ987tpHTVJbhXSIgj709gjQAja9FyaPGhqK/+daxsVJIhzhe8rFwcIUM55UJvKzJK4WThPzzwGMipSfUrco+vhbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b959ae5-4190-432a-ab4a-08dedb054fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 02:21:39.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gf2KDB7Cj5N3yJhmM9yIAn8BxvC7t1DPmBDGaWqmC1TwGXAu/jeP5mW+IAckJzn9YEI+3vePGCKR8y3Gk1r9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDMs
IDIwMjYgNDoxMyBQTQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBDYzog
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBISUQ6IEludGVsLXRoYy1oaWQ6IEludGVsLXRo
YzogQWRkIEFQSSB0byByZXNldCByZWFkDQo+IERNQQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3Vy
IGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgNCBwb3RlbnRpYWwgaXNzdWUo
cykgdG8NCj4gY29uc2lkZXI6DQo+IA0KPiBOZXcgaXNzdWVzOg0KPiAtIFtIaWdoXSB0aGNfcnhk
bWFfcmVzZXQoKSBmYWlscyB0byByZS1pbml0aWFsaXplIHRoZSBSeERNQSBQUkQgdGFibGVzLCBs
ZWFkaW5nIHRvDQo+IGhhcmR3YXJlIHJlYWRpbmcgc2hydW5rZW4gYnVmZmVyIHNpemVzIG9uIHJl
c3RhcnQuDQo+IC0gW0hpZ2hdIHRoY19yeGRtYV9yZXNldCgpIHVuc2FmZWx5IGNsZWFycyBQUkQg
YmFzZSBhZGRyZXNzZXMgZm9yIGFsbCBETUENCj4gY2hhbm5lbHMgd2hpbGUgVFggb3IgU1cgRE1B
IGVuZ2luZXMgbWF5IHN0aWxsIGJlIHJ1bm5pbmcuDQo+IC0gW01lZGl1bV0gdGhjX3J4ZG1hX3Jl
c2V0KCkgaWdub3JlcyB0aGUgcmV0dXJuIHZhbHVlIG9mDQo+IHRoY19pbnRlcnJ1cHRfcXVpZXNj
ZShkZXYsIGZhbHNlKSBvbiB0aGUgc3VjY2VzcyBwYXRoLg0KPiANCj4gUHJlLWV4aXN0aW5nIGlz
c3VlczoNCj4gLSBbSGlnaF0gSW5jb3JyZWN0IHBvbGxpbmcgY29uZGl0aW9uIGFuZCBleGVjdXRp
b24gb3JkZXIgaW4gdGhjX2ludGVycnVwdF9xdWllc2NlDQo+IGR1cmluZyB1bnF1aWVzY2UgKGlu
dF9xdWllc2NlID0gZmFsc2UpLg0KPiAtLQ0KPiANCj4gY29tbWl0IGIwYmVhZmQxYmM3YTAyZjdh
MjI3N2M1YTZkNjljMTdjNTg3MjRmMDENCj4gQXV0aG9yOiBFdmVuIFh1IDxldmVuLnh1QGludGVs
LmNvbT4NCj4gDQo+IEhJRDogSW50ZWwtdGhjLWhpZDogSW50ZWwtdGhjOiBBZGQgQVBJIHRvIHJl
c2V0IHJlYWQgRE1BDQo+IA0KPiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24gdGhjX3J4ZG1hX3Jlc2V0
KCkgdG8gZG8gcmVhZCBETUEgcmVzZXQsIGl0IGNhbiBiZSBjYWxsZWQNCj4gd2hlbiBmYXRhbCBE
TUEgZXJyb3IgaGFwcGVucy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVs
LXRoYy1oaWQvaW50ZWwtdGhjL2ludGVsLXRoYy1kbWEuYw0KPiA+IGIvZHJpdmVycy9oaWQvaW50
ZWwtdGhjLWhpZC9pbnRlbC10aGMvaW50ZWwtdGhjLWRtYS5jDQo+ID4gaW5kZXggNmVlNjc1ZTBh
NzM4NC4uN2NlYjhhZWVjY2QzNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2hpZC9pbnRlbC10
aGMtaGlkL2ludGVsLXRoYy9pbnRlbC10aGMtZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2hpZC9p
bnRlbC10aGMtaGlkL2ludGVsLXRoYy9pbnRlbC10aGMtZG1hLmMNCj4gPiBAQCAtNTYxLDYgKzU2
MSw1NyBAQCBzdGF0aWMgaW50IHRoY193YWl0X2Zvcl9kbWFfcGF1c2Uoc3RydWN0DQo+ID4gdGhj
X2RldmljZSAqZGV2LCBlbnVtIHRoY19kbWFfY2hhbm5lbCBjDQo+IFsgLi4uIF0NCj4gPiAraW50
IHRoY19yeGRtYV9yZXNldChzdHJ1Y3QgdGhjX2RldmljZSAqZGV2KSB7DQo+IFsgLi4uIF0NCj4g
PiArCXJldCA9IHRoY193YWl0X2Zvcl9kbWFfcGF1c2UoZGV2LCBUSENfUlhETUEyKTsNCj4gPiAr
CWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldi0+ZGV2LCAiV2FpdCBmb3IgUnhETUEyIHBh
dXNlIGZhaWxlZCBkdXJpbmcgUnhETUENCj4gcmVzZXRcbiIpOw0KPiA+ICsJCWdvdG8gZW5kOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXRoY19kbWFfdW5jb25maWd1cmUoZGV2KTsNCj4gDQo+IFtT
ZXZlcml0eTogSGlnaF0NCj4gQ291bGQgdGhpcyBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBvciBJ
T01NVSBmYXVsdHMgaWYgVFggb3IgU1cgRE1BIGVuZ2luZXMNCj4gYXJlIHN0aWxsIHJ1bm5pbmc/
DQo+IA0KPiB0aGNfcnhkbWFfcmVzZXQoKSBleHBsaWNpdGx5IHBhdXNlcyBSeERNQTEgYW5kIFJ4
RE1BMiBidXQgZG9lcyBub3QgcGF1c2UNCj4gVFhETUEgb3IgU1dETUEuIEl0IHRoZW4gY2FsbHMg
dGhjX2RtYV91bmNvbmZpZ3VyZSgpLCB3aGljaCBsb29wcyBvdmVyIGFsbA0KPiBETUEgY2hhbm5l
bHMgKE1BWF9USENfRE1BX0NIQU5ORUwpIGFuZCBibGluZGx5IG92ZXJ3cml0ZXMgdGhlaXIgUFJE
DQo+IGJhc2UgYWRkcmVzc2VzIHRvIDB4MC4NCj4gDQo+IElmIFRYRE1BIHdhcyBsZWZ0IHJ1bm5p
bmcgKGZvciBpbnN0YW5jZSwgaWYgYSBwcmlvciB0aGNfZG1hX3dyaXRlKCkgdGltZWQgb3V0DQo+
IHdpdGhvdXQgY2xlYXJpbmcgdGhlIFRYRE1BIHN0YXJ0IGJpdCksIHNldHRpbmcgaXRzIFBSRCBi
YXNlIGFkZHJlc3MgdG8gMCB3aGlsZSBpdCBpcw0KPiBhY3RpdmVseSBmZXRjaGluZyBjb3VsZCBj
YXVzZSB0aGUgaGFyZHdhcmUgdG8gZmV0Y2ggZGVzY3JpcHRvcnMgZnJvbSBwaHlzaWNhbA0KPiBh
ZGRyZXNzIDAuDQo+IA0KPiA+ICsNCj4gPiArCXJldCA9IHRoY19kbWFfY29uZmlndXJlKGRldik7
DQo+IA0KVGhpcyBpc24ndCBhIHByb2JsZW0sIGFsbCBETUEgb3BlcmF0aW9ucyBhcmUgcHJvdGVj
dGVkIGJ5IG11dGV4ICJ0aGNfYnVzX2xvY2siLCB0aGF0IGd1YXJhbnRlZXMgd2hlbiBkbyB0aGlz
IHJ4ZG1hX3Jlc2V0LCBUeERNQSBhbmQgU1dETUEgYXJlIG5vdCB3b3JraW5nLg0KDQo+IFtTZXZl
cml0eTogSGlnaF0NCj4gRG9lcyB0aGlzIGxlYXZlIGRpcnR5ICdsZW4nIGRlc2NyaXB0b3JzIGlu
IHRoZSBQUkQgbWVtb3J5IGxheW91dD8NCj4gDQo+IHRoY19kbWFfY29uZmlndXJlKCkgcmVzdGFy
dHMgdGhlIERNQSBlbmdpbmUgcG9pbnRlcnMgdG8gMCwgYnV0IGl0IGRvZXMgbm90IHJlLQ0KPiBp
bml0aWFsaXplIHRoZSBQUkQgbWVtb3J5IGxheW91dC4gVGhlIGhhcmR3YXJlIHVwZGF0ZXMgdGhl
ICdsZW4nIGZpZWxkIG9mIFBSRA0KPiBlbnRyaWVzIHRvIGluZGljYXRlIHRoZSBhY3R1YWwgbGVu
Z3RoIG9mIHJlY2VpdmVkIHBhY2tldHMuDQo+IA0KPiBSZXN0YXJ0aW5nIHRoZSBETUEgZnJvbSBp
bmRleCAwIHdpdGhvdXQgcmVzdG9yaW5nICdsZW4nIHRvIHRoZSBtYXhpbXVtIGJ1ZmZlcg0KPiBj
YXBhY2l0eSBjb3VsZCBjYXVzZSB0aGUgaGFyZHdhcmUgdG8gdXNlIHByZXZpb3VzbHkgcmVjZWl2
ZWQgc21hbGxlciBwYWNrZXQgc2l6ZXMNCj4gYXMgdGhlIG1heGltdW0gY2FwYWNpdHkgZm9yIG5l
dyB0cmFuc2ZlcnMsIHJlc3VsdGluZyBpbiB0cnVuY2F0ZWQgcGFja2V0cyBvcg0KPiBETUEgZXJy
b3JzLg0KPiANCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldi0+ZGV2LCAiUmUt
Y29uZmlnIERNQSBmYWlsZWQgZHVyaW5nIFJ4RE1BDQo+IHJlc2V0XG4iKTsNCj4gPiArCQlnb3Rv
IGVuZDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwl0aGNfaW50ZXJydXB0X3F1aWVzY2UoZGV2LCBm
YWxzZSk7DQo+IA0KVGhpcyBpcyBleHBlY3RlZCwgb25jZSBETUEgYnVmZmVycyB3ZXJlIGFsbG9j
YXRlZCwgaW4gb3JkZXIgdG8gYXZvaWQgbWVtb3J5IGZyYWdtZW50LCB0aGlzIERNQSBidWZmZXJz
IHdpbGwgYmUgcmV1c2VkLg0KVGhhdCBtZWFucyB0aGUgbWVtb3J5IGFkZHJlc3MgYW5kIHRoZSBt
YXggbWVtb3J5IGxlbmd0aCBhcmUgZml4ZWQuDQpOZWVkIHBheSBhdHRlbnRpb24gaXMsIHRoaXMg
bGVuZ3RoIGlzIGp1c3QgYSBtYXggbWVtb3J5IGxlbmd0aCwgdGhlIHJlYWwgbGVuZ3RoIGZvciBl
dmVyeSBETUEgZGF0YSB3aWxsIGJlIHN0b3JlZCBpbiBldmVyeSBQUkQgZW50cnkgYW5kIHRoZSBs
ZW5ndGggd2lsbCBiZSB1cGRhdGVkIGV2ZXJ5IHRpbWUgb25jZSBETUEgZmluaXNoZWQuIA0KDQo+
IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBJcyBpdCBzYWZlIHRvIGlnbm9yZSB0aGUgcmV0dXJuIHZh
bHVlIG9mIHRoY19pbnRlcnJ1cHRfcXVpZXNjZSgpIGhlcmU/DQo+IA0KPiBEaXNjYXJkaW5nIHRo
aXMgcmV0dXJuIHZhbHVlIG9uIHRoZSBzdWNjZXNzIHBhdGggY291bGQgc2lsZW50bHkgaGlkZSBh
IGhhcmR3YXJlDQo+IHRpbWVvdXQgb3IgcmVnbWFwIHJlYWQgZmFpbHVyZSwgcG90ZW50aWFsbHkg
bGVhdmluZyBpbnRlcnJ1cHRzIGRpc2FibGVkIHdoaWxlIHRoZQ0KPiBmdW5jdGlvbiByZXBvcnRz
IHN1Y2Nlc3MuDQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3Rp
bmcgaXNzdWUsIGJ1dCBpcyB0aGUgcG9sbGluZyBjb25kaXRpb24gYW5kIGV4ZWN1dGlvbiBvcmRl
ciBpbg0KPiB0aGNfaW50ZXJydXB0X3F1aWVzY2UoKSBjb3JyZWN0IHdoZW4gdW5xdWllc2Npbmc/
DQo+IA0KPiBXaGVuIHRoY19pbnRlcnJ1cHRfcXVpZXNjZSgpIGlzIGNhbGxlZCB3aXRoIGludF9x
dWllc2NlID0gZmFsc2UsIGl0IHBvbGxzIHRoZQ0KPiBIV19TVFMgYml0IGV4cGVjdGluZyBpdCB0
byBiZSAxIEJFRk9SRSBpdCBjbGVhcnMgdGhlIFFVSUVTQ0VfRU4gYml0Og0KPiANCj4gZHJpdmVy
cy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC10aGMvaW50ZWwtdGhjLWRldi5jOnRoY19pbnRlcnJ1
cHRfcXVpZXNjZSgpIHsNCj4gICAgIC4uLg0KPiAgICAgcmV0ID0gcmVnbWFwX3JlYWRfcG9sbF90
aW1lb3V0KGRldi0+dGhjX3JlZ21hcCwNCj4gVEhDX01fUFJUX0NPTlRST0xfT0ZGU0VULCBjdHJs
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0cmwgJg0KPiBUSENfTV9Q
UlRfQ09OVFJPTF9USENfREVWSU5UX1FVSUVTQ0VfSFdfU1RTLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFRIQ19SRUdNQVBfUE9MTElOR19JTlRFUlZBTF9VUywNCj4gVEhD
X1FVSUVTQ0VfRU5fVElNRU9VVF9VUyk7DQo+ICAgICAuLi4NCj4gICAgIC8qIFVucXVpZXNjZSBk
ZXZpY2UgaW50ZXJydXB0IC0gQ2xlYXIgdGhlIHF1aWVzY2UgYml0ICovDQo+ICAgICBpZiAoIWlu
dF9xdWllc2NlKQ0KPiAgICAgICAgIHJlZ21hcF93cml0ZV9iaXRzKGRldi0+dGhjX3JlZ21hcCwg
VEhDX01fUFJUX0NPTlRST0xfT0ZGU0VULA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIFRI
Q19NX1BSVF9DT05UUk9MX1RIQ19ERVZJTlRfUVVJRVNDRV9FTiwgMCk7IH0NCj4gDQo+IFNpbmNl
IHRoZSBkZXZpY2UgaXMgYWxyZWFkeSBxdWllc2NlZCwgSFdfU1RTIGlzIGFscmVhZHkgMSwgY2F1
c2luZyB0aGUgcG9sbCB0bw0KPiByZXR1cm4gaW1tZWRpYXRlbHkuIEl0IHRoZW4gY2xlYXJzIHRo
ZSBRVUlFU0NFX0VOIGJpdCBhbmQgcmV0dXJucyB3aXRob3V0IGV2ZXINCj4gd2FpdGluZyBmb3Ig
SFdfU1RTIHRvIGJlY29tZSAwIHRvIGFja25vd2xlZGdlIHRoZSB1bnF1aWVzY2UuIFRoaXMgY291
bGQgY2F1c2UNCj4gdGhlIGRyaXZlciB0byBwcm9jZWVkIGJlZm9yZSBpbnRlcnJ1cHRzIGFyZSBh
Y3R1YWxseSByZS1lbmFibGVkLg0KDQpUaGF0J3Mgd2hhdCB0aGlzIGZ1bmN0aW9uIGNhbGwgd29y
a3MuIENhbGxlZCB3aXRoIGludF9xdWllc2NlID0gZmFsc2UgbWVhbnMgcXVpZXNjZSB0aGUgaW50
ZXJydXB0LCBpZiBhbHJlYWR5IHF1aWVzY2VkLCBIV19TVFMgc2hvdWxkIGJlIDAsIHNvIGNsZWFy
IHRoaXMgYml0IGRpcmVjdGx5IGlzIGNvcnJlY3QgYmVoYXZpb3IuDQoNCj4gDQo+ID4gKw0KPiA+
ICtlbmQ6DQo+ID4gKwltdXRleF91bmxvY2soJmRldi0+dGhjX2J1c19sb2NrKTsNCj4gPiArCXJl
dHVybiByZXQ7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9OU19HUEwodGhjX3J4ZG1hX3Jl
c2V0LCAiSU5URUxfVEhDIik7DQo+IA0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRw
czovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3MDMwNzU4NTguMjc4MDM5OC0xLQ0KPiBl
dmVuLnh1QGludGVsLmNvbT9wYXJ0PTENCg==
