Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473544;
	b=W07zyklgVB8twSNpWYFCEcYmiS9IZtEcasNr1Z59WWCoCRMQKFfUITtZJ+BaVGWzkDgY
	 12PzCGIe9arq0dg58ikrxVRiPIQiJ6kn6b2phXCj3Y/kzA2ZDV+b+w+xRy8LCNwQ/auax
	 96qs7hyZxcq4g9i6fF77xEeC/uMN29NriXJ16M3atiAyvMvvxIyCYi4Scf4F7MwpG+Ilg
	 cC3M40YVteojGYQu3Q7azv9535KaAHbQOB7qvx60vmY9Lc4q3szSByVIjxmp9FCMf3W43
	 Ekq9Au+yGb8+QvgPHyqqCqqX9gp7VWJFR4gbsLUWQgEebPAtNAfoTFYxmV4hiy8mBxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473544;
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
	bh=3A+UvFEjXEV3i5K3lt6oM7DKfvE5XVy6w/UnuLIC2EM=;
	b=fAU76TIVhSn1lhfeMCqFOW8cLEdwbI8Ki8KyB8X0JJ7Mh4WP8rJ3vYWSCK9oxbfgRspq
	 CHMbXp0/tmv1EbfxznD2kHq4v6nApKpDe77CDaw00DEDr/zEdCI7p+9UoDAjKXP9SHUwx
	 Ks1CLOS/s+kGSsnNPW2q76eIOKOCYQVN6noqLHy9/jdgrPl1SH9y0U+0KytM0UHYqFWJi
	 HHxbhRxvFZryRYMPph3tHqZg2r6fydoGl1SL7scUtPconAx1rF3f53mF7DBnR1Akq8pBG
	 /IgY4GyZhi77NtnScjFBKvoxDANCwnYMBUdfgUrZ0BCPf8qiMei+4AwffoYfFFxPvdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a9U3rKnF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49695606A330;
	Thu, 12 Nov 2026 08:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49695606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a9U3rKnF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794473544; x=1826009544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pbxyOz4oT9cdDbooRVmF12Je5rLVZVsayMSzckGFIh8=;
  b=a9U3rKnFmTm75nanHiIhoKYqM1MCp0n80AAb7BuddNIZySV4k5pWz8cJ
   N5NecBluQwfHaKgktf38TxdtIy6mA5TFTNtGxzvHZoHYy90fD4e3il4I5
   dlcOPvcx4xDLjKHFCNzTcKadbVS49yMKsJ4sXy/SbJssPBFF15gfPLBfo
   U+jxCiC5D4WDGGe0RJfZRtHiCBUuLKoE1Gm9nG3TmPcYidmpDbmqshC2C
   wTnU6EXu/FygJWT36VOGetkowvp4BcI0kv0oEt1ZFVrjh2tTtOAkRMj+V
   OtHA2+v7XCRvsYl8RwXkIUT7Xh0T800uy1+l4UA3/iKQxUd+gG4EGoXrk
   g==;
X-CSE-ConnectionGUID: sP7U+ojCRWiVBhOB7Vv1jg==
X-CSE-MsgGUID: Qcc4ZOliRsiuSUM2SSoPbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3133891"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3133891"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:52:24 -0800
X-CSE-ConnectionGUID: du6OOWbTQ5OiEJA7fjV/+A==
X-CSE-MsgGUID: yDmfseOqTZOHEprsAv8wUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9177389"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:52:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:52:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 00:52:23 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 00:52:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poQSVXxsg6bgK19KOqVb7+6oUWUgmVZz9KetuMgtglWyovvPJoArS5ksRMlwPvXbkbFo6Cp4ID91dL5SpAC3n4MS6pd5edTVZEcgUvAy+n9HlCoZvhpPPKq+2IiGph5Krh3dB778p2kuB8I2ouTh4bqiWkxD3aQBVnEcTVCFSjzj7U25LDQb6u7ieJsZkJjTwnLuj3ZQsJALF/OGeIdwMXzp5gspMUd40zx9LLMooHcquIxwUYQxNwu2nVxeGkkKPP9adE9EWf8YAnlGCRzEYn40RZWeiBs04lw5ja8fvyqTyC0wynv+EciNv9HYBGBEhWgXJQ7+Os9bx64OwIFqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A+UvFEjXEV3i5K3lt6oM7DKfvE5XVy6w/UnuLIC2EM=;
 b=SiSjXUvsfc1yHx7bovs9SBupJCrHiWzCEZo7zszOThUO/u9Fy+eXersAtrNFahypCJGtCTvGJIKXEF9YiedJK3QUNFDxJvfkx1gecEf0t3g403QEcWQsbi7beGd0te2DbI1lB2MP5EvINzORgxrcIOSVtpM5BjTWMlgYG4sqp6fOJIy7rrIql5MYN2qKR6TD+uqNgbwq6kPBT4v9Fo/2MxTf7lXcdoMU+zPVjbwR9Y5vV801SaQ0qmGKUr+mxiiJHKD3xhXwqZVEJjxexvOBtYFyqQZb4JT3Qdk0Zvq76egt/wHtEtcXOiKFV21Wj+UQAyRRCRLxVTxjet6cPvHa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 08:52:14 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 08:52:14 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ae878000@gmail.com" <ae878000@gmail.com>
Subject: RE: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdcnBhBcaG2v39x0ODHvfva55BZbcqITKA
Date: Thu, 12 Nov 2026 08:52:14 +0000
Message-ID: <SJ0PR11MB77043B77FF18AA4AED242D61F4702@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
 <20261112T063704Z-thc-v3-1-mhun512@gmail.com>
In-Reply-To: <20261112T063704Z-thc-v3-1-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH7PR11MB6403:EE_
x-ms-office365-filtering-correlation-id: bcdacd66-12c5-4b75-3999-08df409a3f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|38070700021|10067099003|56012099006|4143699003|261028144727099003|11063799006|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003;
x-microsoft-antispam-message-info: n0qBFl9g1PFYzvyVf5WyVcjSAfvj0uNPslDvqWLhdtvcY6mvQGoKuneqtnlO0c6b9XSRU8g87hLOYS2a+seyS6xGp3iQAVHyzDftvx41SzqeNCXxkzrcoJF70KHxu1hkxwGlTSBioGGxX91TTOd6tWtE9WYc9Jtr+yG8rFdNAGkMEp/uP0eXdbZPtUbeBWhwVxcIhFpfL0Fufyo9S5Vk4XVonusOnz8t9hqsjKyyrTYsSPFv8B9bYS60afRRxtEcmzczkimO2LjYVEOdu95uDA0kMs1huXpWNkX3IsHqoxF5uSHV9qWgQlE8yF5r8BwVM4EcJmZkE0EkNRFmmugk0T5sfp4B/l2PVTtPIwQBIHmCJjAtLH04/M0pOXfyEPDs0BbeahN2aCUMaPL51jx1lXKGow8ZhfSv3bdSf+Ol4VRTmObn0K76JUQbbRR5uj81AnvV3zuGZA0nOd+w9rRaB7wpLgaV9DxOuFmk+d12cdhFOxdD5oJ6FrkVODmem/u14Uxnj1jJu8DsU1Lfl4RDFjCvelENJyMKdSdVWT2OXu++vuFFTk/7oGqxuYTpcvn/Gsn9uDCRqz/gct0pyNP2NV+lo9mzweTKr5xs6Wh8vwM8eoWVjsCK4heBZXoTNP9Dly8n9xZsbty5XwvzdHorF9GLIOX+4/NK+vGMNQH70A9kehp0yuH+heoWJc1XiGsrIj1HidBzVWX+kq+vOvijV9ygLjkydRJtjrf3mk8h/tA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(38070700021)(10067099003)(56012099006)(4143699003)(261028144727099003)(11063799006)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HJv02TmK9BSs+QKby9nlBzyLnmG3k4lKwhJ1F6zvXVVVqEL5Rx+gsSSQtq15?=
 =?us-ascii?Q?oJriwGDGNRVM0vi0fqoTmUmce7XHwI1Nh6adwWX3MJkZDpPtvO/7tRi0Z7Q9?=
 =?us-ascii?Q?11S4D31mVu+ZyEVeAT3IS0m8z2vgQOqCeKv6GtDG2Po1pdHRIGLMudLGVBrg?=
 =?us-ascii?Q?fP6KVtCj73b5hlknk/Ri3Jc90+ZHuUXkQbpzS7vrQG3jmVQbPm8dsNQDF36z?=
 =?us-ascii?Q?byJ54SJBGH39vd6ebCbfXSRCb3FWaNAXiTGJXc94y4mg4R4MCuLq7aojFjU4?=
 =?us-ascii?Q?1w5j9RzRXLCcyuYlx5c0nOjKBJKok+AYff0vuGYym4OZB7y/b/WeO2wvuLB4?=
 =?us-ascii?Q?Ip4hj0LY9AT17U1nVQwGmIRUJ/aJ1hHgPaubBzrz+A8+ybkYZQViElwQbp0V?=
 =?us-ascii?Q?VJsUUHgTk2Wb5xIRaFvTrmdX/WTCLRSXZfbXUZpFY7hzVdEAQ8n06eqvTe1S?=
 =?us-ascii?Q?jximxpIUcrT9HqxqcV4b2g1TAPvrvpmoPdPO5n44OMaxRKCky0xIgYTHydrZ?=
 =?us-ascii?Q?VQtIoe50RuTQnDBrmFDVTlsH00e/xRhZDFOCN3qqB+P9qkk0WWfOKO3dOg+t?=
 =?us-ascii?Q?c4TEsKxuAdTdwPN6yW/I2MmFmnoD87BDe6/Lz146804m/wMTkg/B3yQwXW7y?=
 =?us-ascii?Q?PU7ILANSADBX+zEK7yH38Uo7a3lC3oRcyicugA9sYBZ1WE0D9TZ1oB2X8F0p?=
 =?us-ascii?Q?ybGCh/FrVdepLUSNAe5EpIRP83OpecPhYW61LMam3FJq2qK7VlEkQT/Me1F0?=
 =?us-ascii?Q?7IropWBlkhW9vYhYiHBNf9Ooqqqklx2OkLRIQ4Ve1AUsgBZwtuIkoNAmcfdy?=
 =?us-ascii?Q?di9TesM+y7GW9KgC1JeSc3abl6lGv4qV/VULp0cgHAhPfUy/+jsbl8XwmxWa?=
 =?us-ascii?Q?TlH428xL0RRdiMsROCpZgH6ATNMYtOVp1cOAnshV3bnbKKB8wBt/jIGZXvdE?=
 =?us-ascii?Q?yuZv8477yrLNKW4Uu44clBENSTaN5SxgDB6FKRtFDKGfCXalNRr2N9Z3NhUM?=
 =?us-ascii?Q?WiDqTsjsGcywje4I+KjpwiOgf6hN0Qm7DV/nDHFT017OT64xE5Bxd9bkWhnU?=
 =?us-ascii?Q?50PIH3NS4ENUtpFeKoyr/5Ph+5Sq5n7u/4/jqXjezqQe0G4hkO4VqdA4K2Zd?=
 =?us-ascii?Q?Ruwv5i1kmHHSKqqf+VO6XYn55dktGX2LOKSVcOxxUIuRZfqxnlNpgkOh+EMO?=
 =?us-ascii?Q?IBnQHv/QVNZiMH17/2rQnOiD4FZcBohFSZe63VJDO+3VfiXnv40vg0hKfhPC?=
 =?us-ascii?Q?9nzZgl473i0/jDJQX7topc1JADQPljEfJvGPruOKoNJQolTX5HURZl18/Cd+?=
 =?us-ascii?Q?0JrQTLQ6eDL/+6S35ZR/lKxTFgAYqVHz58noqcoG4asmEdg1ntu9jewNDavh?=
 =?us-ascii?Q?QWjlfdd3/OuGd3KJskukxXi4nd1g5sHeLyGLhOFOlOs2C5uAwzpnqynPWDuP?=
 =?us-ascii?Q?MktR24h7dRcQax+8ys9cP10kPOy1q3VPIhJ35N60AdYWvWdygxj6uqR8N5gn?=
 =?us-ascii?Q?lJ/TqU1drs4XiaQkxE4Mzl/iTt00HDhu3dPX/jTgM0iBH22YtOr7f8HvYq5I?=
 =?us-ascii?Q?D29zCU87NPC7lX2OP6KB3C25Jwg37d0CvJ0SMWksJx0cvnb1olv9/8F0msqW?=
 =?us-ascii?Q?1ls8RusZGENRcx+bbIrOlOc4M/S8CVL0iMW5mJ+xWrHvD8s/bAZd6RdyUn5n?=
 =?us-ascii?Q?BV3dNFJi+TZkMLTxuqW/n5+TPNM+SnV0kUoFBKiIV+r5v/e+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gfMx7epm13NTXMVwgoVZhai/w84yJKTAFEKqqZPB/Wi9r4gk9Ss4B1Edw8XAaoKgJP/TiVqki9UWK7S5jmW5V7aPDfKD7k34pRFZ2fPJRK8bPn3XYWhMb2xEIxR5VYQlORRiuObm5isfaTKyAPaZ7YEJd5nXYEUHEIrUtfSbax6zvHxf7PpNvymgMq1XPt0U1qvP5t9xwrsXT8g5l9+G4vCH4PGM21lD2TiMcn5do8ZLIdbkYCUGxETX17mRaQobjUU+fhVnCcbPXN8mbUUhCs14eu6/I8HQb++lZFbpdq94hwej2YjDQFHIQwFZOw6dobeOSPK39tNd11zaMpyUxw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdacd66-12c5-4b75-3999-08df409a3f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 08:52:14.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3CsO64K5wuIctuq7neH6ng3aYQkQf1rb82o91Q7uDjPF3ppTty1qwc88lCpj9VT/EHweaelr8OzLnW+pTQc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Myeonghun Pak <mhun512@gmail.com>
> Sent: Thursday, November 12, 2026 2:38 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> jikos@kernel.org; bentiss@kernel.org
> Cc: srinivas.pandruvada@linux.intel.com; mpearson-lenovo@squebb.ca; linux=
-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; ae878000@gmail.com
> Subject: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
> teardown
>=20
> The managed IRQ can access HID/DMA buffers or queue recovery work while
> remove or probe unwind tears down those resources.
>=20
> Disable and synchronize the IRQ, drain recovery work, then mask THC inter=
rupts
> before freeing the IRQ and releasing HID/DMA resources.
> Track IRQ/DMA initialization for conditional probe cleanup.
>=20
> Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and re=
lease
> outside the shared hibernation helper.
>=20
> Found by a static analysis tool under development.
>=20
> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI
> driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>=20
> Changes in v3:
> - Add blank lines in the probe error path (Even).
>=20
>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 32
> ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index bf49d8ce5f07..3aa0ae81053e 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -600,6 +600,8 @@
>  			  const struct pci_device_id *id)
>  {
>  	struct quickspi_device *qsdev;
> +	bool dma_initialized =3D false;
> +	bool irq_requested =3D false;
>  	void __iomem *mem_addr;
>  	int ret;
>=20
> @@ -652,6 +654,7 @@
>  					qsdev);
>  	if (ret)
>  		goto dev_deinit;
> +	irq_requested =3D true;
>=20
>  	ret =3D reset_tic(qsdev);
>  	if (ret) {
> @@ -670,17 +673,18 @@
>  		dev_err(&pdev->dev, "Setup THC DMA failed, ret=3D %d\n", ret);
>  		goto dev_deinit;
>  	}
> +	dma_initialized =3D true;
>=20
>  	ret =3D quickspi_get_report_descriptor(qsdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Get report descriptor failed, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	ret =3D quickspi_hid_probe(qsdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register HID device, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	qsdev->state =3D QUICKSPI_ENABLED;
> @@ -695,10 +699,20 @@
>=20
>  	return 0;
>=20
> -dma_deinit:
> -	quickspi_dma_deinit(qsdev);
>  dev_deinit:
> +	if (irq_requested) {
> +		WRITE_ONCE(qsdev->recovery_disabled, true);
> +		disable_irq(pdev->irq);
> +	}
> +
>  	quickspi_dev_deinit(qsdev);
> +
> +	if (irq_requested)
> +		devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> +
> +	if (dma_initialized)
> +		quickspi_dma_deinit(qsdev);
> +
>  disable_pci_device:
>  	pci_clear_master(pdev);
>=20
> @@ -721,9 +735,12 @@
>  	if (!qsdev)
>  		return;
>=20
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
> +	quickspi_dev_deinit(qsdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> +
>  	quickspi_hid_remove(qsdev);
> -
> -	quickspi_dev_deinit(qsdev);
>=20
>  	quickspi_dma_deinit(qsdev);
>=20
> @@ -749,6 +766,9 @@
>  	qsdev =3D pci_get_drvdata(pdev);
>  	if (!qsdev)
>  		return;
> +
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>=20
>  	quickspi_dev_deinit(qsdev);

Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
>=20
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> --
> 2.53.0
