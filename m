Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774FD336885;
	Fri, 17 Jul 2026 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259669; cv=fail; b=no4S6QmOhMjrCaFsgHuwoHpWpqVJJy4t1ANkspLiI7ZWuZIy0F6Jeqtkl6ZYl5o56SPxpPKXzdf0bT6o+yb0wUvUUvrmfjJnnsO9BwA2PZsA4MJX2bu3O+xTnD8mxO0Vltol77wimkCbFnSVLujke+4yYGU2CVqr63O86BSziUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259669; c=relaxed/simple;
	bh=VlyjwbmzKnn0fTqF9kD1yNTqNOvWbXYkcCDpb6NrWUU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQIj3YMWkfQWBiEkDUIvd3WSBaKFgUBhvtg91RQif/H6E+hdvyH/ckcnMLc+zdBGfdhtl+Zt3SQKA29vPRk1xrizy4HaSvmK/UXRkIIreGvXWP/d8XCt/3kJ80Q2LR3kEpMyp8pkK6v8GMhHIwomYglw4okQJDIvT1b4XYnXV80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5JVo3Ri; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5JVo3Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784259668; x=1815795668;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VlyjwbmzKnn0fTqF9kD1yNTqNOvWbXYkcCDpb6NrWUU=;
  b=Y5JVo3RiTLOAalV5FaRg98sc9dWNwEeFKct8U5pfDFzmJ3UWqnK7or9k
   ETWtmn/Seks0NfaWwXVUArQswAKslaXuPpZJn3Co5juErfh7TgxDOVv5+
   iJT0AnkT1HdiytziHUwGlz0zpprcFGOhJacb7eebVzRRcjwSlOQM3gF7w
   cD5BTryQ/e9+U0PmqWFTdzpogmcXvRHpyP0yjdW+cspyjJ/ekG7BIEqXH
   mEMIFuO44nP56+Oju6nP1vUEbWF4ctUvc5ziYbxvRhVqSNNxkwA0ummqA
   IyUPDvzgDktW9SoCYCTt8CACaH6OcGzv4jwQJ3+51+JI+X+GLh+d7tTVj
   g==;
X-CSE-ConnectionGUID: M5gSak8lS7eaxahN7LLWzg==
X-CSE-MsgGUID: d3WXecRPT5W316AvLTrEGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="87477346"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="87477346"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:41:07 -0700
X-CSE-ConnectionGUID: aKoUm/MpTOiiSZKpMsqfqg==
X-CSE-MsgGUID: +ky4MNTUQfeBBXsj+q/NNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="256125381"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:41:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 20:41:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 20:41:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 20:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDCtEDMAirwhyRTHAdj9l1I5hg7wXsex+k78urcdLDEwnZTi0/R3K5Tiyj5Pah0EqWwTtIHESr4U6BVff6onVWPcQfePzK0mf1F+EEHrScIbhIm6MCo4poespIo514Sd9OCwLyy6dqxtCEi7Hlv/IuCiwaf+iu8ywbBY/i+HsAws1e1g+lec58SMmo6YRE4MRjAN4YCqRxx7GhXdUthK/WxI7MKtlZyWT1LHldOm8rRUBN8PW6aj0zkk5MxENWLuth+zfekuf+NgOWXcGXXcDG9BGilRT4ZCZ3t8IV1e+puwivHDSS0M8SU6c/wt1A2SOLtB8wta9WNxLzVoZfzTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udj3XsoQD7xWTgDnqg3FyWtdoC7nsY7ZhBWahA3SAUo=;
 b=A3PvC0MJZcyC3PweUu+dIhcKctkRyeB3gRmsLdx7mZGuM2/77LPenBkm6EuVLyE4XrOyIO3qgQmYrLOwJjpQsUUEMenVrXp4xg+2IU+YLEgXYkp4WE5DuSVvhkOOdqG5tFlXhJqBxbyGcV6inh2nyTPgLvhreuBLzmR712CaHIhgRzBBk/cfe3D8hPIfdbJAoEFYqC2/Lj8DvHGLyedJ2Yzs67/cgR9dVI1GZ4K0+bUI6QLkHAhkZA00b3scT7tCfkAZknOGP9NqxgpuQy2V+3CfCMnp+AwPVNs+46Un8CXvSZz6mDnN1k0uqeaSbb0WKas2qV3mCaEBGweazoC14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 03:41:03 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 03:41:03 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Pan Chuang <panchuang@vivo.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Abhishek Tamboli
	<abhishektamboli9@gmail.com>, Danny D. <d3z.the.dev@gmail.com>, "open
 list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Thread-Topic: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Thread-Index: AQHdFPhNg5DdTSBNRkGLGSFZ/ON+ArZxEgUA
Date: Fri, 17 Jul 2026 03:41:03 +0000
Message-ID: <IA1PR11MB6098C904F952ECF6F085D5B7F4C62@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
 <20260716075203.593012-5-panchuang@vivo.com>
In-Reply-To: <20260716075203.593012-5-panchuang@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB8503:EE_
x-ms-office365-filtering-correlation-id: cb4d28cf-3cc7-4cec-499d-08dee3b53a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|38070700021|18002099003|22082099003|6133799003|921020;
x-microsoft-antispam-message-info: o9l5Icq3uMEb/rKHN5NbxiFB6+Ghk8PeNcD+AxunRCJxvBkH7UBq3IamA7ljLgcYwrQ1937CVSya9qejauSKuJvqmgKxlNpAjiqZkp7oOQWt7TTa9EU0Vm2Uzz3KzfXsPS+ZOAnpyMD3QgII92LD1mNyv0K7wXFZML758hKj3uog2curR/uD5trvSGYIyzspfOFyTEOCSYihZlfuKORt3ZUlpOpdWge2Q3n7V/8OBMbiqVZshpGPx+IRYTHTattWOsKIYcU/ZAO+Vnf4jFs/08POxey9oEtWMPVe6uutkONLrqqr37jR2n1A1n4zxr/9FdfOzz60Y0CciWoDqC6hh9DhXQdawSq4GNYfvTD8e+16M0G6KGHFSRinP/wUKOEbcRg7aEX97+RUktPfw9U14LqFZa9SRtCcjdjRa5ey6KwPRsUtqpYiHK9yFvRdgFUeO076T2V3G9VyINgUyrsCs2Jba+4vtZDsxe54svuZ+Pj/jPq0eDZhWe0+I+YPZEtHyAhcxE+UPXmcbVFec8P365+WB04GoDe4JDa/sCCDjWdoVD0KC71RkbHVMyJZhdDDISu4l73A2jUrj11zA3QVLj35odz9QJwzU6lKBhAIcoPcTT4lRe4F94VXn3fvKRbFyUe5e0kSqwfeiGtj/HUvDqlor8L7QzGQ0n5ztng/rAqzrQrBEivCKTIoeM7a+hf57JgnwNiS+exzA6EasxJPWTQbJvbtKInNvkmTWe6ZTdXElB3rhCwZ2b/cnRU5PuWg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(38070700021)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iUy+hYhuYUW5MAxlKhMcYpvq6otqlSN5utto0lQAfRIP6NpBZmwtPAdo58cl?=
 =?us-ascii?Q?HQlGVmRdOo5hTgQ26VV1obPY2tb4DS/pupoZJKfoPgpj5D3mUfQ93tCipQeE?=
 =?us-ascii?Q?xoLEdsRIth3KZj4MbUOysATz4t0xkkdCBAUYLRs2yQJFnmcYap+yEMrbxnN4?=
 =?us-ascii?Q?gw8gaTocbIsecVxiC1WUexWAG8cZHobDYfucKRi4R5cvgmPUrPQ6JFINd9vZ?=
 =?us-ascii?Q?1sioquSbkQZfgDD5JgBsDLfh986o4hAD1oPZBjwEcQv+io1AMJ0879z/74pn?=
 =?us-ascii?Q?0QcKvqnUSaAHjNXTSR5Cl8HMjYuWZzygWpvpD6kFwnr9ubIkcG62HDx6638l?=
 =?us-ascii?Q?R8dbF9+AcXl5Y6AyQdbPnaOtuYA2BkT0NzungzkOm9Gqrd9ibzMArqgEw1cJ?=
 =?us-ascii?Q?ISIYAsjl7YD3PPiB2jM0Ac/48YKhSUgYHe1+JG5Ob4hH/+urDp7XMVUwZRpB?=
 =?us-ascii?Q?//KJaW7QKf9kSYBsyd7nKPV1e1RyoORdgzuvqGbp3bNAIFaGOI+gGxo5XWn/?=
 =?us-ascii?Q?XFlayZxqumvZUCip8IJyB/nTgZo7ybnDVE/6i0n5NL7C6/1LEK/121zFF5KZ?=
 =?us-ascii?Q?Hhv79IgCuh/Gc1hFOTVHSqvWaHD11uLcvz8ZXWVYijKXF84r+FaboxZtC1Ob?=
 =?us-ascii?Q?m386R8tFqLGhVjr21xE/sv5LyXAJ8GV77KqcLsp4Vurns4KvMR91wWzHFIS7?=
 =?us-ascii?Q?217UXIHFSunAhyklbB+K0WG7yfQIfXIXGKxybZrh/tnIiiwf2uxFMUjER890?=
 =?us-ascii?Q?zJ8kOdH+BQNMcP5SiDYn+VMlDGwLhJONK6NfMaOCPSay6nwXE8ED0B5MiytX?=
 =?us-ascii?Q?up/JPPang2+QU4oNSeHnCYUzUUWUG/fkOy3vrTWt2NZvPdeUh1Z/2AcfX32w?=
 =?us-ascii?Q?5ANLfJNa4egHKRs+oEqTP/y/kQnV0obPQcYbqooxEQWfg81ZkrRdziM82I1O?=
 =?us-ascii?Q?mVZF5LDssz7HI33O2pqWBrKzHEeKdJwTklyrHxET0RJtzjxJR2e5p4Ol1V1a?=
 =?us-ascii?Q?uwBvFMF7/f+BchMA7tO0fr2XKT7M0E7vaoskpVB5KH3qoPGXYiJnBNVaeydv?=
 =?us-ascii?Q?hVgP1GTaj7JL24v0R49oZMjOHvNVYGE5Q6vkHfaonOaAdO6ZSvCggVJW1p9h?=
 =?us-ascii?Q?w4e0pxI6th9sewXP+/oyuoFwtoM4JqNXJS9QMvarr6YHcdi5GWZrawbltNWJ?=
 =?us-ascii?Q?ezzFjtlKa8wgqTnER+mO5svVPS9dtLgHIv2tiJUezWRPBxAbW7DIa0dsk995?=
 =?us-ascii?Q?UPEIrOCx/59RLtLbVNu1b6TYjGNfqNTu1q036gi4v/V8QaTmeAN9fMCW0HX6?=
 =?us-ascii?Q?cWyRgmr0GVLoCF6Ec+GTUSwE8MeBpBei7hx1M5U3u4tLJYQ/IHtjcMSlAk3P?=
 =?us-ascii?Q?bXjOURMptVYbsq1yciazuhQUxb+6b/efz4MQZGxHbZK6dfDrcCxba+j803SJ?=
 =?us-ascii?Q?7e6kgF1W84gd3C1jS+tDwxT0DeTCdYgit0gCjsakSBnXzU3kJRlEtLLggAb8?=
 =?us-ascii?Q?awe1wMEqJAE/oPPAXLr4vICSeS/zn7fhAErHXhDJcLm/7j99U0qZmvjst9j9?=
 =?us-ascii?Q?WtGrtIudlrYMFenB7I3hDsiX/7k7Y1Azyt0KZCYn+gN23T+f2d30F+qeB0JC?=
 =?us-ascii?Q?Ty+2WQ7qHQEIvHWk8N1Sr2Kn0TirZyBJSN2zN9tI+Sd2qmdVkMjBbPBSv28r?=
 =?us-ascii?Q?LUGpgwOQL1ieUCr3oh6GqyXtnvwxcOUOr6eBvjzqKhK0uPsN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sA8C2r+VfRjrVmCA/9P9cFcVXDkiYgoxGpL6RjWrDeZWvzCVBHNK/lb8UOBvYJH0e/vBPzKNW7uth4567SgHAmZGsB1L5IqmtLoqFWcTPAI1c46pBW/z9uFhn/Mos3VqlTtDIWFVA6rGGJRSHA+IMu7ULVQ1XsQLkvyYIwSsh2622cjrYD/faFjPpIK1QSDJSFnams8EVFpz396OVwmhdykZpuFPW55lxnwLWHG1IUPL2gJ0TCsZYoDJEUY3CTAS+E2lwe7N0XctyjLlGMNhrNp9qhw5ZfTdbun5xbxFEinO393KE0OpWI8Op3qAe5KmZSVqXBbIt9HmXrMkJwaDtg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d28cf-3cc7-4cec-499d-08dee3b53a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 03:41:03.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTnPIijKIRFnTDwn1Bcj0XDOw7QloRI3Ex1Oxb0Q5UtoFW/XbnNUewnGe0VQwLpg7Q/JKU+3hI8ULvM0+5F38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Pan Chuang <panchuang@vivo.com>
> Sent: Thursday, July 16, 2026 3:52 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Sakar=
i Ailus
> <sakari.ailus@linux.intel.com>; Pan Chuang <panchuang@vivo.com>; Abhishek
> Tamboli <abhishektamboli9@gmail.com>; Danny D. <d3z.the.dev@gmail.com>;
> open list:HID CORE LAYER <linux-input@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
>=20
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant driver-speci=
fic
> dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 5 +----  drive=
rs/hid/intel-
> thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a01999..59f500345acb 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -682,11 +682,8 @@ static int quicki2c_probe(struct pci_dev *pdev, cons=
t
> struct pci_device_id *id)
>  					quicki2c_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qcdev);
> -	if (ret) {
> -		dev_err_once(&pdev->dev,
> -			     "Failed to request threaded IRQ, irq =3D %d.\n", pdev-
> >irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}
>=20
>  	ret =3D quicki2c_get_device_descriptor(qcdev);
>  	if (ret) {
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30..504ef3c842ab 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>  					quickspi_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qsdev);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to request threaded IRQ, irq =3D %d.\n", pdev-
> >irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}

Thank you for the patches!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
>  	ret =3D reset_tic(qsdev);
>  	if (ret) {
> --
> 2.34.1

