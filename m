Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794214358;
	b=Bp9ePKUXnyPchwMwo5SZHLgZ9KhmauOEFAW9af/tZJ1hy04qwGe987l6GPneJT93O2cb
	 VcNmGfTSyDyVYBJ5nK9SNiiH/aW5cmnBCy4O1pwAlMdMRQHcZX/c8iGIGQ8NBbb1bvUte
	 o9Kfqht6QE3/QLYMt7DcYMc5/Se36JOYzw5Z28DikhSFrdQfFN23evGpCQBw5ZBlZhiv8
	 Yt3wuLGIALzL3JMRnH+TSyZTUIsgSn7Rz5EhaRt2jkhub8VqohxUSQUuogE0XcmJ7Wvar
	 84Byg9v1yb4MY5Mr1MoX2yWVw9S+foHyBN7cLuYfHWOEpHW1afS6hq94SnpqGkJr9EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214358;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=TMLJ9zEtfUSdyNkJTUABrbUmbszq0TWdpU1CgZRCPxY=;
	b=373oyWfGS9uku0MzoeGMlfHGysDRXDgK0Ec8m1nBa40XyCQZ9rR53Fo15Szf3AV37etH
	 NRLd5VcdjfGDtZuAmSUauH1qYp4oCs1fua12QXOUertiCtHY0WNuNyLpiQ7OAklD5MPi6
	 SqAT4GbToppQAJkmLPHjZoyPXarzxZXcxN3D61jAp6sB9T95ur0LsKyDPI4gFIhZqVIIL
	 RVE+005J+1tEERabSvs708Iu6lTdxka+q3kbn/lFnf/kIeWZQFiZMFMg2l3lPX2ha7dkH
	 Taik2x/NmsRQRqa6Bpq35kUFW7DsOR5GeeSnHmGnQJWHhLdK5wwAg4+opdm0HFJ8b5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K51jjiyo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1A606A325;
	Mon,  9 Nov 2026 08:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B1A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K51jjiyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794214356; x=1825750356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TMLJ9zEtfUSdyNkJTUABrbUmbszq0TWdpU1CgZRCPxY=;
  b=K51jjiyo/9lv6m6iIQ9mKG8FSjyKtXydWOLKaPqhGgPyxe7gXWxiM5Pl
   /xqY/P1HLEN977hUb8/CgqGZVMD1g4xPVBoGoh0FJhCiIks+88KFSHO32
   u3LY3TJyg6qGsjhoi2YC/q4lQTCcmDclxqcPf93p4l/sDlNsT6Gs+xAfw
   tsJy/QmGN22/jF01VyU8JlIVUlvWepXaVJZaSdtSt2kVX6JobtnsV/ied
   qkG5bkAZWTr+Lb9FZzt8HQvTgFezuySXnpsaf5e7X5krOyYifQpvqpBee
   iYECdgzvO1Rp1T54/xbYIWfcXNKY2LO5lKeGVhqQeOHVn9eanO+I/3Z4J
   A==;
X-CSE-ConnectionGUID: BEGwABQJSD6icUWOg+cs7w==
X-CSE-MsgGUID: rK2Gu7EyT1SjpwxHt75/Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2825292"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2825292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 00:52:36 -0800
X-CSE-ConnectionGUID: zN+XnrFlT1yOmDa1pjFeQQ==
X-CSE-MsgGUID: feV2/bqAR8GUMXnML4o/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7979310"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 00:52:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 00:52:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 00:52:35 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 00:52:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v57j1uf8sZwjAe7tEqkzmqVt7oXnl82VIEZGo80yLxtwzKeA+X1nb76uhmZul6scRx+dq0iRUOJZ+/ijkJkM57fgek8n4xTScbHaZVqqIYdVUQjoUandA1YCoCnmo82BzlzAmh6OvKIB9UVTHtdLKkRyIqHzMMWBFRme2dpCLSAVdpieeiRZsaPHdXxG9mCp1PYaPyeWf9alTTfJw+/oP/Ajl+SJfABf/qKVZTIOR6Ykm5WeuFIBP4CSRE4rME3HIObhhFOg7zhgOvMDiBdEpnw6khdPXF03DaKslj3835usC6SBCXz/Lgx6LoefYwCvUrI7A6Dy9iop30uN7+tzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMLJ9zEtfUSdyNkJTUABrbUmbszq0TWdpU1CgZRCPxY=;
 b=e2ZssQFzmm9I0LucwS9TgBwJ1LNwMydCe7NkAySv2oE8TDOUL04qlkh/JWRWEjteF16uI+t6yJWRBJ58oF0GnLn7YulkTOuY7yPrN54N/bGPNsfPwBFdJeUHYKYEjI3w07F1Iwag6iSLDqBHEZKxY6hrF5VtoTuIIkUzNbfyahsYeGCunoqlNkqm6KA0cpwiGtSedJ4TQV5CVamsBegdyrR29nnecOfOVxdzpl+2y0D3jD0O9pzBjS0p3jwVQ4ayW0q9695X6aLDim0wofCmjNjtwD4qNiqWzwNiFM3plrNmlsUb3zB/83x4hDtkYdnDiaSN2YnjEyqNIWmooOHajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 08:52:33 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 08:52:32 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"simeon@maryasin.name" <simeon@maryasin.name>, "crofts@kernel.org"
	<crofts@kernel.org>
Subject: RE: [PATCH v2 0/7] HID: sensor: custom: use-after-freec after remove
Thread-Topic: [PATCH v2 0/7] HID: sensor: custom: use-after-freec after remove
Thread-Index: AQHdbJkYkGvZuZkKc0mkQyRqUEV0/7cldW9w
Date: Mon, 9 Nov 2026 08:52:32 +0000
Message-ID: <SJ0PR11MB561324CC62F3A4C9F34895E493732@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|IA1PR11MB8804:EE_
x-ms-office365-filtering-correlation-id: 387948e5-0a07-41a4-0d96-08df3e3ecaf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261028144727099003|261022105027099003|261022075727099003|10067099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|56012099006|261102123227099003|11063799006|22082099003|18002099003|261009223027099003|6133799003|3023799007|38070700021;
x-microsoft-antispam-message-info: z2MZ6qAR+fNWG3uTVw7YV1VzA9usN6sJvXuEg26JqwxDXmZ16n4p50ylNQX9OQZEg+76GPHkSvtzd4LkzX8onYSRTkDEUYhWjI4Hm3Rvu7i5MbV2Z8uO58YGxyxF3uYfXnjKSrHhyhEisMP3WEYtYsTPmCGVJSV2ej/fnkWI1Jhm28XlGJKlWWwp6jBUMJbmDNfpIrSzrMGN8ER9x1o6YYFdX2vnCTP4ghzviPC2pBO1KLb6uv6S+e02E5TYy0lePnN2gR+7PPWoexrWYkBc2d0Qzx5bq3h484lyqvLp2xHe0aPTQ0iGVRgSkBPTf2aCnCaSrM8dRoZd3gSB+yCOZLbi7uuVJpEFGFPsVXm0OIa+TORCFBVY5SpYLxdnmCm4j18Mh+uNZAaP9xz1udllRA41Cyyp72rDakK2H6xu6KZX+FxFPbY/YB9eGPkApMrX38mmh6MJrJgYdmoKTpk2adku84Rh/bfZiH6NF46AsoDFQWZp5mlhwizUgGQCCqAF/iqER0EdWlLBNDz1/lGIkreKoyfs7OGhjYNK6oGuWtMocdpkBVHExMbdhsNqL8Mf9c/zuAgJVOYxToLqBcWdJKvgDPjW+H94uuPvX7/1GDMIgDPxj8wA4LdUxCd18NJJp/KJoHx4vL2xr8cQ12AFMsJKdnSBwtXIRY5ttHhE7rycn10oTVEpCVCUgMLiDlUCQ2M1oEAlIgfTHg0/63jwTjYGYkfTZpIYh6Z5o4nsVZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(56012099006)(261102123227099003)(11063799006)(22082099003)(18002099003)(261009223027099003)(6133799003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0t0czhTRk15a0xSSm1IUzVicXo2VTJwOHcydEdteVdNQkZhd3NXVGxXNWxV?=
 =?utf-8?B?OUU3SlpUbkxCVE5iQVBkTEszMHRvVGJuVDlaR1VielA2NStVOG1nNVdvV0J4?=
 =?utf-8?B?UlJWV2V6S1VFUzExT3lqVlhtS3FMUU1Bdkd5YjBuRjBqTmlvT2tnMDBRWktz?=
 =?utf-8?B?dThoTFBuTmxXcU1DT1l6aUJRU3NlSjlHeFBMVlRTcWZ4VzNlLzNrYVE5OHhw?=
 =?utf-8?B?bmxEZlVHcm9WMkdkaDkzODFkcGtDODBnMnhzZEhiemI5ZXBrVUlYWFB3ZldQ?=
 =?utf-8?B?a3ZVdE1OeTljUDJJTDhJNGFPVGJheUpKU3hXbXRpTFBHd2pNS0VoSVdYR0NP?=
 =?utf-8?B?WUVHUG9UR1FINDQ3dHFOVDVRc3FHMDFmb01BRG81SDBoYzFGcERUMEhEUUU5?=
 =?utf-8?B?am81SHQ2TmdPRENicktZOVFlL1k0RVlBV0JxNkkxbzdtSHU5V0gyQlorSmg2?=
 =?utf-8?B?a0pEQ2dxNGtiQkxjdGpzSWhOOHhocTJST3dYd000bW9SbjBobHhtb2xlM2kv?=
 =?utf-8?B?d1JmakdZMysxVEQzNWJuSUJndEtSUXpEdEhrZXhTdzNDejZyclBuOWRhOW5a?=
 =?utf-8?B?N1paNTllNTVJLzRUWStjUGZyTWVFOWhSOVYvL3N0dlRFS1RyMWk2czFXemt0?=
 =?utf-8?B?NkRKNS9ON2pyeTJPbFJJUms3TENJd3lDWnJCMHJweWxiY0FiRlFwZlNQUXV2?=
 =?utf-8?B?UytqVjk4QzRTMU9XcTlzM1NzZER5ZnJCVjIwN3RrNGs5bWdJbHJrZXpaTExn?=
 =?utf-8?B?NVYxSGozZ0JxTDMxSkVGUU5MWllZcm1EeXNIRk9jc1g3N1ZQb0NoTUpocnpw?=
 =?utf-8?B?SmU1T0llSkRicTZYTFJ6Uy9SMzBZbFQrc1hlR3lxTzBXbFVQZ1ZQSVhvUCtU?=
 =?utf-8?B?aVRieXdGdEo0TlBYZTdnSThJSjBqczhRZ3hOYnRRKzlRUjF1SFRRZUY5bEJJ?=
 =?utf-8?B?ckJnWk1jZkppbFlxb1REcFp3Sk91NlYzV0FVYVdoRVdPaGN0UTlFVW9yOWo4?=
 =?utf-8?B?VzRSa24xNEErYmVBVkZEVzJmQUJBOHJVK1lwM3d2ZlVqY3Z4eHJTaXg1bEJj?=
 =?utf-8?B?N2tyYlF0NzlvcklpSk10T3Z3dlpYZVFST0ZueW9XTzhacThDT2o3eWRWeExE?=
 =?utf-8?B?czVVdDdOR0lGZ0RtamFGaFNLMXlMeXQxSGJqWXI2a01tWlpNUVhLa3hnVkl1?=
 =?utf-8?B?bTVCVk5xTC9lOHM1aU5IUE9YZUNmd0pja3pXaklLUDdWVHhQbFZFY1lYR2ov?=
 =?utf-8?B?amE4OUkyMmhUOXdFdlpPTU9iSVJjei8xQ2pjVXFYenI2Y0NXN21zbWZOUm5h?=
 =?utf-8?B?amVtZUhZellhc3BEaUx5V2VrM0g4dURTLzJEeTgrV3pVTGVzM3V4ekozcVox?=
 =?utf-8?B?VVo2NktaSGFDanRnbWRQN1FtemVnN2RxQ3UzamRYOCtyY3ovekpKcWVTQTBr?=
 =?utf-8?B?bGZ0K1IxL29QSy8rTEkzM3RIN3hEU3dSSWVGT1ROQ1I5UitDZnhPZHh1dHdq?=
 =?utf-8?B?bUhTWDZzYk1ScWltQW5XK0lPY0cyNVJPUnlVV3EreVJjcG43SzFwWHBZUHo4?=
 =?utf-8?B?NjJKbXNMSzRrMXNVVG9GdUVSY3pTWW1YbWhiQityWHhILzJMS0hoV0tZVjF0?=
 =?utf-8?B?NHc4TTBQR3lLUmtTVEtyb3Mxc3JCcGgvdERVMVFnNWpGT1oyM0FPYjMwYXl0?=
 =?utf-8?B?b1Iyb1loTlZ1V3VaNjBEdEFPVHlqWUtmajgzSUxqaDF6b0lhL0IzNUI5SHRs?=
 =?utf-8?B?M1lLUHZWTENORDI2dno2ZmVSS3JJSWs0NWdlamROL29ESUxTZXJsOXZjdGcx?=
 =?utf-8?B?WWlzeHlXUERFTnNoUngrdXZydkxja3hTcVdhZlhwckJ3V2pWMnRnSjdHTVlw?=
 =?utf-8?B?bllhQ0x4UE5sSmFkcG9SdFlBYktQTXBraWpyZTRrZllMcmkzMEE0NXVTZzRM?=
 =?utf-8?B?SXZsVExQY2w4cFJDSHFzODVNQTBLRHpPOHhWZEROZlUxMEpIRCtIaHRPd0Y1?=
 =?utf-8?B?cThwRjA5Szl5Tmd6eFBxcDRqeDgvbGFPRG94TzF2NXNrWU9oOThTdm1YbG5O?=
 =?utf-8?B?VW9SRmhTcW9aaW5YRy9aNUszUWQ2MlAxamlwSElwWnlWTXdmR1lWQ2MzdmlV?=
 =?utf-8?B?N3J5VFg1M21DQThYcWc5K2xjWXJ2ZitCQ0kvUzJKMWxGckpVK2c0YmVzMWFH?=
 =?utf-8?B?TnBjZnNrQWdhdGtodXlFSFZJUDRKQS8xb2hEdSttZlRnRTMyOSsxRjJmcnVi?=
 =?utf-8?B?cUs3Z2prdmhhb3ErbWRwdGYwMVozeGM0VENmQTRNUTA3Yml4emgwSVp0Lysv?=
 =?utf-8?Q?MsSk7/gOPjum/nEV20?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RQ4te5Hyh+do9wELs6/E3T086IP5bQSF/uXh0nWe4Gc8wTJC+eTyP4bU72tlHrFCMqMkUErejZkoyo3lpyEfbjBfCQGQNB17GCNCZNuid8Zbz+URzkv2g4HHlzFnEqNeU5km/0qMd6yO2BMJFj+jkibUFvKraPZutN75TayWnxwwS65SzRrMiPmPtj8kB3hqJN03SSGCWmffJs5iNT8H9lr3xn86rEJdCDMYfHwWEwyfbrH+6/H5hhy5iCqAhEziuRus+dVClxr3uyKi+x9swSnHVMyQF4cDzmJoOc1ureCYeIslcNeJNM4sCevQ3x1MazyLG5l+gzS/PWlNAQV3Xg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387948e5-0a07-41a4-0d96-08df3e3ecaf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 08:52:32.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCQIg4lGMFXVKB0fhS3505wWoiW5lE86PkFIxHb5F5Km3CusykRxvQqaQnBkFgJ2+uZA4BPq4Dxv1Meua6ztxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogVGh1cnNkYXksIE5v
dmVtYmVyIDUsIDIwMjYgNDoxNCBBTQ0KPlRvOiBqaWtvc0BrZXJuZWwub3JnOyBqaWMyM0BrZXJu
ZWwub3JnOyBiZW50aXNzQGtlcm5lbC5vcmcNCj5DYzogbGludXgtaW5wdXRAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBzaW1lb25AbWFyeWFzaW4ubmFtZTsgWmhhbmcsIExpeHUNCj48bGl4dS56aGFuZ0Bp
bnRlbC5jb20+OyBjcm9mdHNAa2VybmVsLm9yZzsgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPjxzcmlu
aXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjIgMC83
XSBISUQ6IHNlbnNvcjogY3VzdG9tOiB1c2UtYWZ0ZXItZnJlZWMgYWZ0ZXIgcmVtb3ZlDQo+DQo+
VGhpcyBpcyB2MiBmb3IgcGF0Y2ggIiBbUEFUQ0hdIEhJRDogc2Vuc29yLWN1c3RvbTogU3luY2hy
b25pemUgbWlzYy1kZXZpY2UNCj50ZWFyZG93biB3aXRoIGZpbGUgbGlmZXRpbWUiLg0KPg0KPlRo
aXMgcGF0Y2ggc2VyaWVzIGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIHZlcnNpb24gdGhhdCB3YXMg
c2VudCB0byDQodC10LzRkdC9IGZvcg0KPnRlc3RpbmcuDQo+DQo+Rm9sbG93aW5nIGEgZmVlZGJh
Y2sgcmV2aWV3IGNvbmR1Y3RlZCB3aXRoIHZhcmlvdXMgQUkgbW9kZWxzLCBpdCB3YXMNCj5zdWdn
ZXN0ZWQgdG8gYnJlYWsgZWFjaCBjaGFuZ2UgaW50byBpbmRpdmlkdWFsLCBzZXBhcmF0ZSBwYXRj
aGVzLiBUaGlzIG1ha2VzDQo+cGVyZmVjdCBzZW5zZSwgd2hpY2ggaXMgd2h5IHRoaXMgc2VyaWVz
IG5vdyBjb250YWlucyBtb3JlIHBhdGNoZXMuDQo+DQo+QWRkaXRpb25hbGx5LCB0aGVzZSByZXZp
ZXdzIGlkZW50aWZpZWQgaXNzdWVzIGluIHRoZSBhZGphY2VudCBwcm9iZSBhbmQgcmVtb3ZhbA0K
PmNvZGUgd2hlbiBhY3RpdmUgc2Vuc29yIGluc3RhbmNlcyBhcmUgcHJlc2VudC4gSSBoYXZlIGFk
ZHJlc3NlZCB0aG9zZSBpc3N1ZXMgaW4NCj50aGlzIHZlcnNpb24gYXMgd2VsbC4NCg0KSGksDQoN
CkkgdGVzdGVkIHRoaXMgc2VyaWVzIG9uIGEgUGFudGhlciBMYWtlIHBsYXRmb3JtIHdpdGggSW50
ZWwgSVNILg0KDQoxLiBUaGUgcmVwb3J0ZWQgdXNlLWFmdGVyLWZyZWUgYW5kIGhhcmQtbG9ja3Vw
IGlzc3VlIGlzIG5vIGxvbmdlcg0KICAgcmVwcm9kdWNpYmxlIHdpdGggdGhpcyBzZXJpZXMgYXBw
bGllZC4NCjIuIER1cmluZyB0ZXN0aW5nLCBwYXRjaCAzICgiSElEOiBzZW5zb3I6IGN1c3RvbTog
RGlzYWJsZSBzZW5zb3IgYmVmb3JlDQogICBodWIgY2xvc2Ugb24gcmVtb3ZhbCIpIGFsc28gZXhw
b3NlZCBhIHByZS1leGlzdGluZyBidWcgaW4NCiAgIGludGVsLWlzaC1oaWQ6IGlzaHRwX2NsX2Rl
dmljZV9yZW1vdmUoKSBjbGVhcnMgZGV2aWNlLT5ldmVudF9jYg0KICAgYmVmb3JlIGNhbGxpbmcg
ZHJpdmVyLT5yZW1vdmUoKSwgY2F1c2luZyBzeW5jaHJvbm91cyBzZW5zb3INCiAgIHBvd2VyLWRv
d24gY29tbWFuZHMgZHVyaW5nIG1vZHVsZSB1bmxvYWQgdG8gaGl0IDMtc2Vjb25kICJ0aW1lb3V0
DQogICB3YWl0aW5nIGZvciByZXNwb25zZSBmcm9tIElTSFRQIGRldmljZSIgZXJyb3JzLiBJIHdp
bGwgc2VuZCBhDQogICBzZXBhcmF0ZSBwYXRjaCBmb3IgaW50ZWwtaXNoLWhpZCB0byBmaXggdGhh
dC4NCjMuIEJhc2ljIHNlbnNvciBmdW5jdGlvbmFsIHRlc3RzIGFsc28gcGFzc2VkIHdpdGggbm8g
cmVncmVzc2lvbnMgZm91bmQuDQoNCkZvciB0aGUgc2VyaWVzOg0KVGVzdGVkLWJ5OiBaaGFuZyBM
aXh1IDxsaXh1LnpoYW5nQGludGVsLmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KTGl4dQ0KDQo+DQo+
U3Jpbml2YXMgUGFuZHJ1dmFkYSAoNyk6DQo+ICBISUQ6IHNlbnNvcjogaHViOiBTeW5jaHJvbml6
ZSBjYWxsYmFjayByZW1vdmFsIHdpdGggcmF3IGV2ZW50cw0KPiAgSElEOiBzZW5zb3I6IGN1c3Rv
bTogU2V0IG93bmVyIGZvciBtaXNjIGRldmljZQ0KPiAgSElEOiBzZW5zb3I6IGN1c3RvbTogRGlz
YWJsZSBzZW5zb3IgYmVmb3JlIGh1YiBjbG9zZSBvbiByZW1vdmFsDQo+ICBISUQ6IHNlbnNvcjog
Y3VzdG9tOiBGaXggc3RhdGUgbGlmZXRpbWUgZHVyaW5nIHJlbW92YWwNCj4gIEhJRDogc2Vuc29y
OiBjdXN0b206IFNlcmlhbGl6ZSBtaXNjIGRldmljZSByZWFkcw0KPiAgSElEOiBzZW5zb3I6IGN1
c3RvbTogUmVnaXN0ZXIgZW5hYmxlIGF0dHJpYnV0ZSBhZnRlciBtaXNjIGRldmljZQ0KPiAgSElE
OiBzZW5zb3I6IGh1YjogUmVtb3ZlIGNsaWVudHMgYmVmb3JlIHN0b3BwaW5nIGhhcmR3YXJlDQo+
DQo+IGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMgfCAxMjEgKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0NCj4gZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYyAgICB8ICAy
NyArKysrKy0tDQo+IDIgZmlsZXMgY2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0
aW9ucygtKQ0KPg0KPi0tDQo+Mi41Ni4wDQoNCg==
