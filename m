Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801E2135AD;
	Mon,  8 Jun 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932851; cv=fail; b=D4xTVifpNlxIzjRYidifrU0lnnEla40quAYSZJEcsMUH8Vz5H+zl3orwEVZI47tjKbADocJQzg5ERTPl82NHCm/e7dr6LvS8ta84VxHJMN5NzGuAiCsPkQ5DvXbEFJwIhD555kO36Uo2JI8H8mIiHH33XUeVyyME97QenPFhNTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932851; c=relaxed/simple;
	bh=lCnpw7uUqYn3jzFDPgJzXi3ljLnmH+o38UbFBstQbks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1r7b0KxWZlfxrrsZIH3EgCGKRV2qnPtf3tmOmbbzYy3e5Yic9TxEfCWQQs9FugDUIJ5PpdSeL3kIYL+JGX6U4AF8xuUccz3zf1B6dS9sQHfBh03crhz0GPI8J7KVmjxHjEpvk9Vgu5plp6XtS+BRVoq3FQp50m5R3ai9adZ9f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzCfIfEb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzCfIfEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780932850; x=1812468850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lCnpw7uUqYn3jzFDPgJzXi3ljLnmH+o38UbFBstQbks=;
  b=BzCfIfEbuuU09PYZGK+1W5Y6tqcvd11Dr/MGB1NBjfXamq8zO1aLABzV
   OogL6spPomv+vT1qYgjDJFRKC23JQevi2PKQFW0EfZwkbpmd1ZBgHoz7/
   ot1o+n4CjqFSME39hg5Nm+wVYVcTViyxKpHn0ZfiybaNhI7wZeaOFHt7C
   HEZ9FmP4+oKhTc4Wxtgr992mG2fhVigzWvV4bIq6FX996z3vlRdZy7vAp
   Yq3oIo/VSbIYBvOJdvVXPzScXbBRGmymFkrcT+pzCJUvo07cIc8xISwlX
   6cznvycgEDH/jaMuCVySlNXVrHK8YUy7ftTSrZH6LrsCSCx2f8emRVcMz
   w==;
X-CSE-ConnectionGUID: +IcYaxfNRfiQ/Ys1/BCN3Q==
X-CSE-MsgGUID: 13wGGE7tTsWDmF0dlbNAnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85296970"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85296970"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:34:10 -0700
X-CSE-ConnectionGUID: JaexlNmkQKirL4+o94JxJA==
X-CSE-MsgGUID: 7ro+QtVdSTa1spjxt6gyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249874987"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:34:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:34:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 08:34:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:34:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknst9y/PsgqIkbjzW+ep+TCoUIEg8qOYLtJBu/cWBujFPP4N6vRFrlInEV/9aO5qEk0vJUZ/qQRG+WvWenp2vF5wp6jedZgu/Mi3Ey8/HdeMuA8aG5o1KCHDlo3K876j5r0miIDjhNakQ21g6Zldoa+2tbudEH8FarxRZRmvzUW9MTcRMHnHcIagGU1uTyyaepz4QEnoFWuuXrQLi1HV9cCblpbUO67G82GHydr3Ohl/B7MHY9xPmjluz4GF8B285t8H5yxdm4lS6vRSbwLkbcRjR4ekKI8Sse79CpgvRMBXE8SttiOd2pG8YSAOm5cvYe3qC7tg4Gw9eIyBDMAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCnpw7uUqYn3jzFDPgJzXi3ljLnmH+o38UbFBstQbks=;
 b=WzVymVdcMGOEDEpuLVGs6QUm/AUiDaYor5bOrTuGP6OW05qHSKC4c0NNQ1Q8o2rtuZryfTUHg7lS8fj+ohVPGoe01Ppy9nILnPbDhNYyy4ylnZkYZUm7eApi+Y/8SFWrrdyRgZMLFifDw10nf/pBOLfnv7I5lGEZkSZFy1orI+yi2c41ilJkqDrRowut0lIgAT/BFIiYO38gMbEhvCXcrltpPDsz/Xixz/SDVeJGFNTf2B3tFXQVrAoeoKN6pyTiW8t2MKmf2JAyPt6d2ry8qM3tW9w7hpUm06PvNmaIVdllVFlqXYXCD2HTkFnJ1x+eKiJf6PWRCTOAkf1udhT3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:34:05 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:34:05 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
	"hongyan.song@intel.com" <hongyan.song@intel.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"sanjayembeddedse@gmail.com" <sanjayembeddedse@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Topic: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Index: AQHc9ajtv0GfRdo5hEKCZI1S5o93iLY0zScA
Date: Mon, 8 Jun 2026 15:34:05 +0000
Message-ID: <b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
	 <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (3.60.1-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MW6PR11MB8392:EE_
x-ms-office365-filtering-correlation-id: 10987180-75d4-4c98-b3d1-08dec5735fc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: z+V8slLFSw6evZIJpAuNvz/nXGRa5FslABxmxS4BJt4afTdAxMTvCTbGXXIqCO1Ls2I5ehGITdiImhJOixRYb9U47l6Dw7Y9gks6Z1wnsyyCWpBiA+nNLSvLq6TBYcJ9u9Mo0na3j8TPNcFt0hY1NmIQg5MIiHj+LfvyJTX9vqH0jEscaZgJNHjc2N+gnCfNhNlSbswZMg1nZ+w9p0pLu4ONo6Dmohl9dLVmCuE2lumQQAaVSwVzTZxEX6R6SVpE9wLMUFlrFMtzrrSko4SShoZ+bh28lOQ+d/ZuvuYLiYKPlI1pNsSkscTUfEqjAUr5apTLyVlQ0lmXFim9kgpIhrcUa8avRgo99NS8j9HZJ8tKGuI2aEJ75K2tpQDyJTkuzWQ6eQMNv99cNcXgXuVCyAFXZzFREkRAF5Z9rRot4RcLpFqn5LALdyPVZfgxaEpNW0tGmg5UsxMLEnM77Qcge2kckztHdVdFcwnOx5/Fvcx5es9Za5A2b6m4AhREA2GoDw0/YV1jpLQfkmz1bcsuQzFC2dgSw1qginF/HnN9dQZHPGzMaUywR8a8RZJ9kgXF9sNVn+IRqSiVb2nXw/beq1H9JQeD5lO5+suLg7QXBmkSzUlV4pdD5xgM/ZImO7BUVprnRGGsjMxpzS4R4O8P6IarF8sODEZcns6yXvI4xkN4jbRaFkb0+tuTLcOpol9xchWCMm1L0BAJXT1bOYcmVmEF17z5DFJwCnKOtFwXEH8Mw2ttg+G8nJflYlH1FOQd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azFKUWFSRUxkZTVXNm5jcG1MMEJOVUZySEEwN0VzWVZxRmJIZkRmbWUyWkFV?=
 =?utf-8?B?T21BNU5Ma2NxOWdGZzRkcVQwNit4SEU1bEl1bU5ySmRMS1RvdnBOMzhqYjg3?=
 =?utf-8?B?NmFWdHNiUVozbHBwOFhxdjlNcG1PaGcyb1lzVVRVNnNRcVR3OXVHdXpkOGUw?=
 =?utf-8?B?L04vQ0pibjZtampSVlVIZFQ5dlUzVXZha2syUXArRlVQRmgvUm9ud2tnS1hs?=
 =?utf-8?B?dWthSGtQTEQ4R05UQm1VQys3NUMxNDVneExpM3VFZjZ2WVVWQ0Zob2ppOTdn?=
 =?utf-8?B?d21ISkMwWit4M0FQcmduUTRmdGJBcmlvbGxZN1U3ZmJQZGNuL0lpZ3k5T2VE?=
 =?utf-8?B?NUtyOEpZZDBRbUxsd0lkS21XckVJUUhqc2Q1V2kyVlBRMGlqeXpmczMyU3BN?=
 =?utf-8?B?UkFmYkExWnpPYUU5eGFZYnBVaGphdENzbEtTSnU3RkJHSDVxSndVaFAwb0xS?=
 =?utf-8?B?eTNIUnV6c20rdjBDam1XbDhUMUxmUmVGeHhoUHEzZVlSMGQ0ZUVTancwRXlY?=
 =?utf-8?B?b0x5Q3crUnhqSDRCZ3g0MGlvNG1WZk01bTdOSWlwdm1pdjduV2p1d2ZCOUtH?=
 =?utf-8?B?Z1VlQk5NOGxtMEhwZUl3VnBpdGl1MkJVU01NcTJLL1dNUmlTRjVRSHFWcGlQ?=
 =?utf-8?B?elRuVno2eDV5c1lUTkczZDd1bWk5aVJPRVc0TlNTL091eGh6d2c1Z2d3ZXpC?=
 =?utf-8?B?d2l3MkVLTUVETHJmcUVZL0RYUUVqOGV3NTlXbk1SbzZXR05FRWJKbi9Wc1d4?=
 =?utf-8?B?Q3V0aUFqZzlVOHE2dlNjNlFjcVVHSExLazBKcWNnTVBiSk5SeWxYMmVFVVVD?=
 =?utf-8?B?TWljbXZJZ0MwZ092Q3ZpRzJQeE9VZGdiQ21YbTZWWlR3dEw3Qkl1ay9Ibjhh?=
 =?utf-8?B?bW0xMDBxU0poT1N5dTZyUWtwdEpTUnVrWWNRdUtMK2c4dm5lOFpmUHc2dENx?=
 =?utf-8?B?N1g4TzdnaHUrdW10cU9JT2tlWUtCTkdaNG82N0tFZmQ5U1NwNWJDdlIrcHI5?=
 =?utf-8?B?VWhjOUhYSWxzejE0eFozK3FHbHpMNUpPRzk4cXBLSFR0ZVRsUHdaaHI0UFFX?=
 =?utf-8?B?R3ZpT3J5elhXTXFvS3BPTUN3ZkM5VDk3enBRRXR5cUVMWm02V0FNYXhHM1JN?=
 =?utf-8?B?bmNHSVppS2N1OXhGb3ZMSmRMcCtzNEt4djlxejhEMjlEZmkyS1FYa0RPNWFt?=
 =?utf-8?B?Z3V5SUNpRGdGUlFWL1NuV3N0aE5BWCtma2hPN056R09nLzdxT3pieUUwTnlD?=
 =?utf-8?B?OFdKV3RjcUkwRUtNc0I2aitKTTNPYnNVRzFpcU9BK0hyVGFRK0tSb0RQWHJh?=
 =?utf-8?B?YzhuZTBsUUVaVTErd2c0UFdaUkEyRHVEQkc1NWdvZkpHcWZZM2lkS3k3MHc3?=
 =?utf-8?B?d1FVR0ZnbGV3WTJhMXdXeXdtd2Z4ekpZOFI4TDZTN0FGL2FSUGx2dGdmZHVO?=
 =?utf-8?B?dEVPVzdtMmNBZjNKWHdKNE1vSVA4ZnZLc2pndElBNmtxVXlaZnZ3TWZSdDJk?=
 =?utf-8?B?Zkp3QjVlVlg0aFNtRktEY21aMUQwS0lNaVY3RUI2TEhpQnRtRmQyV1Q0a0hm?=
 =?utf-8?B?RmNFR3QyM1FGdmQ5cmxaR2E5RDYzTXAxUzF2R3RISmdDMW1TNGZ4SG1rTlpO?=
 =?utf-8?B?UE90ZFhiNnZXeVZRRGRoNU04TGxQcjlOT1dNODhVTXUxaWdpQmE5ZGQzR2Fk?=
 =?utf-8?B?QmZxdWhhUXVVRHFVbVJpWlpHeHN6UVhJZGlrZlRnM0VtR0k2S3NmQWp4aWJa?=
 =?utf-8?B?bk9zVEk2WUh1aW9ScFI2b3dJbjkzUVFncjkxSWcveFFNU2NMY05wYnNHemlk?=
 =?utf-8?B?RGRkMmhHaVVqamVPNk42UUdXMUR5K0JVOVpjeFFUaURGY0x6c1RMNEd2TWdl?=
 =?utf-8?B?WDN1YzY2QkswZlVOMFNQbkNvSU5FNmtxdkJnT3o2cXNVeVoram1tYUlMblZj?=
 =?utf-8?B?TmtNTW5UWjRSQ0RhS0VyVGZuV3N0dTEyWEZpVlR0cTM5L0c1MXpaVmN2S21n?=
 =?utf-8?B?WjdINmNvWkZqWmc4TWNKUlR0dVdheXdrdTRUZEtLbStYdkJpTVFsYU1LbDBB?=
 =?utf-8?B?ZzVLdGpRL0U4ZFNEOEZaVCt2b241UjVtU0pxdFkwR2ptSWVTV25NazltU3I4?=
 =?utf-8?B?Ty9qeUxZeE5yRzdocWlOcXRLTjN6Y2dIUkU0dlFFZm9LNyt4OVMxMGpLNUpu?=
 =?utf-8?B?Zm55akFyazVqdEhKaHpsOVVtS1Jya3FvL2lsZEVtRlJpZHN6TVZzbFVwL0dY?=
 =?utf-8?B?NjE1NHRDaGxrOGlXZDNhWG42bVFqMEI0SHVFVlkzb3Ruc2lRODJmZFFTRlBu?=
 =?utf-8?B?TkxvczZxYlVNSkxBTWp5UFNnL3hzK0hNTHJJbWV1T2dWRHJsWEU0ZXBwY3Js?=
 =?utf-8?Q?MEDNXWSokdEfg4Pm6Bugfy8iOwfXuyYGeNAyy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <333217B2F9550D4182709C3D955A1FEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: he0pzhz51JuRi5JCwvvp0YPzA33MqgsITuKf+hZYUWdaHDBqDhmJpYNe1fXwc7v3wQuYPdi431TG2u3Hr1aSuYICiDh8xsEkw+llKDG8+5tofGW6rGOHecHPDnMw5A6a00FSsRHJOzA4nUoqZZhJ/VC5MUJmj/r7kGpnzqoSVJEQR3W9w8WhB1cnZV5PVbV9cwi3MrfYOJ2uWgVGWEv8G5sVneeQn166ZjKZG1Nwly5SJ1Xe7vrogXDYWowXbfD57RuixAj9VIPboTqKE9QnTTZIbU/flVVqKgt5yO00T8G2pCAydZz52hadd1/OlgGL70ERPdvRKt1zRch0C71s+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10987180-75d4-4c98-b3d1-08dec5735fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 15:34:05.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrYVLAu7b7wVjVy76tgZNfObmsJF4QAlydY1F1r5Wk/2kFEsQSP+Ch+KUHeZazq3vPJmr5niRn87xQN/oSer56IGKpuQzpHqJZWBoei8BbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA2LTA2IGF0IDE3OjA3ICswNTMwLCBTYW5qYXkgQ2hpdHJvZGEgd3JvdGU6
DQo+IEZyb206IFNhbmpheSBDaGl0cm9kYSA8c2FuamF5ZW1iZWRkZWRzZUBnbWFpbC5jb20+DQo+
IA0KPiBUaGUgZHJpdmVyIHJlZ2lzdGVycyB0aGUgSUlPIGRldmljZSBiZWZvcmUgY29tcGxldGlu
ZyBzZW5zb3IgaHViDQo+IGNhbGxiYWNrIHJlZ2lzdHJhdGlvbiBhbmQgdW5yZWdpc3RlcnMgY2Fs
bGJhY2tzIHdoaWxlIHRoZSBJSU8gZGV2aWNlDQo+IGlzIHN0aWxsIGV4cG9zZWQgZHVyaW5nIHRl
YXJkb3duLg0KPiANCj4gVGhpcyBjcmVhdGVzIHJhY2Ugd2luZG93cyBpbiBib3RoIHByb2JlIGFu
ZCByZW1vdmUgcGF0aHMsIHdoaWNoIGNhbg0KPiBsZWFkIHRvIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZXMgb3IgdXNlLWFmdGVyLWZyZWUuDQoNClJlb3JkZXJpbmcgaXMgZmluZSwgYnV0IGNhbiB5
b3Ugc2hvdyBob3cgdGhpcyB1c2UgYWZ0ZXIgZnJlZSBpcw0KcG9zc2libGU/DQoNClRoYW5rcywN
ClNyaW5pdmFzDQoNCj4gDQo+IEZpeCB0aGlzIGJ5IGNvcnJlY3Qgb3JkZXJpbmcgb2YgY2FsbGJh
Y2sgcmVnaXN0cmF0aW9uIGFuZA0KPiBJSU8gZGV2aWNlIHJlZ2lzdHJhdGlvbiBpbiBwcm9iZSBh
bmQgcmVtb3ZlIHBhdGhzLg0KPiANCj4gRml4ZXM6IDA5OGQzYmVjY2ZiNiAoImlpbzogaGlkLXNl
bnNvcnM6IEFkZGVkIEluY2xpbm9tZXRlciAzRCIpDQo+IFNpZ25lZC1vZmYtYnk6IFNhbmpheSBD
aGl0cm9kYSA8c2FuamF5ZW1iZWRkZWRzZUBnbWFpbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMv
aWlvL29yaWVudGF0aW9uL2hpZC1zZW5zb3ItaW5jbC0zZC5jIHwgMjAgKysrKysrKysrKy0tLS0t
LS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL29yaWVudGF0aW9uL2hpZC1z
ZW5zb3ItaW5jbC0zZC5jDQo+IGIvZHJpdmVycy9paW8vb3JpZW50YXRpb24vaGlkLXNlbnNvci1p
bmNsLTNkLmMNCj4gaW5kZXggNGUyM2E1OThhM2ZiLi41ZTNkMmJiOWI1YmYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaWlvL29yaWVudGF0aW9uL2hpZC1zZW5zb3ItaW5jbC0zZC5jDQo+ICsrKyBi
L2RyaXZlcnMvaWlvL29yaWVudGF0aW9uL2hpZC1zZW5zb3ItaW5jbC0zZC5jDQo+IEBAIC0zNTYs
MTIgKzM1Niw2IEBAIHN0YXRpYyBpbnQgaGlkX2luY2xfM2RfcHJvYmUoc3RydWN0DQo+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gwqAJCXJldHVybiByZXQ7DQo+IMKgCX0NCj4gwqANCj4gLQly
ZXQgPSBpaW9fZGV2aWNlX3JlZ2lzdGVyKGluZGlvX2Rldik7DQo+IC0JaWYgKHJldCkgew0KPiAt
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJkZXZpY2UgcmVnaXN0ZXIgZmFpbGVkXG4iKTsNCj4gLQkJ
Z290byBlcnJvcl9yZW1vdmVfdHJpZ2dlcjsNCj4gLQl9DQo+IC0NCj4gwqAJaW5jbF9zdGF0ZS0+
Y2FsbGJhY2tzLnNlbmRfZXZlbnQgPSBpbmNsXzNkX3Byb2NfZXZlbnQ7DQo+IMKgCWluY2xfc3Rh
dGUtPmNhbGxiYWNrcy5jYXB0dXJlX3NhbXBsZSA9DQo+IGluY2xfM2RfY2FwdHVyZV9zYW1wbGU7
DQo+IMKgCWluY2xfc3RhdGUtPmNhbGxiYWNrcy5wZGV2ID0gcGRldjsNCj4gQEAgLTM3MCwxMyAr
MzY0LDE5IEBAIHN0YXRpYyBpbnQgaGlkX2luY2xfM2RfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gwqAJCQkJCSZpbmNsX3N0YXRlLT5jYWxsYmFja3MpOw0KPiDCoAlp
ZiAocmV0KSB7DQo+IMKgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjYWxsYmFjayByZWcgZmFpbGVk
XG4iKTsNCj4gLQkJZ290byBlcnJvcl9paW9fdW5yZWc7DQo+ICsJCWdvdG8gZXJyb3JfcmVtb3Zl
X3RyaWdnZXI7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gaWlvX2RldmljZV9yZWdpc3RlcihpbmRp
b19kZXYpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZGV2aWNl
IHJlZ2lzdGVyIGZhaWxlZFxuIik7DQo+ICsJCWdvdG8gZXJyb3JfcmVtb3ZlX2NhbGxiYWNrOw0K
PiDCoAl9DQo+IMKgDQo+IMKgCXJldHVybiAwOw0KPiDCoA0KPiAtZXJyb3JfaWlvX3VucmVnOg0K
PiAtCWlpb19kZXZpY2VfdW5yZWdpc3RlcihpbmRpb19kZXYpOw0KPiArZXJyb3JfcmVtb3ZlX2Nh
bGxiYWNrOg0KPiArCXNlbnNvcl9odWJfcmVtb3ZlX2NhbGxiYWNrKGhzZGV2LA0KPiBISURfVVNB
R0VfU0VOU09SX0lOQ0xJTk9NRVRFUl8zRCk7DQo+IMKgZXJyb3JfcmVtb3ZlX3RyaWdnZXI6DQo+
IMKgCWhpZF9zZW5zb3JfcmVtb3ZlX3RyaWdnZXIoaW5kaW9fZGV2LCAmaW5jbF9zdGF0ZS0NCj4g
PmNvbW1vbl9hdHRyaWJ1dGVzKTsNCj4gwqAJcmV0dXJuIHJldDsNCj4gQEAgLTM4OSw4ICszODks
OCBAQCBzdGF0aWMgdm9pZCBoaWRfaW5jbF8zZF9yZW1vdmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gwqAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOw0KPiDCoAlzdHJ1Y3QgaW5jbF8zZF9zdGF0ZSAqaW5jbF9zdGF0ZSA9
IGlpb19wcml2KGluZGlvX2Rldik7DQo+IMKgDQo+IC0Jc2Vuc29yX2h1Yl9yZW1vdmVfY2FsbGJh
Y2soaHNkZXYsDQo+IEhJRF9VU0FHRV9TRU5TT1JfSU5DTElOT01FVEVSXzNEKTsNCj4gwqAJaWlv
X2RldmljZV91bnJlZ2lzdGVyKGluZGlvX2Rldik7DQo+ICsJc2Vuc29yX2h1Yl9yZW1vdmVfY2Fs
bGJhY2soaHNkZXYsDQo+IEhJRF9VU0FHRV9TRU5TT1JfSU5DTElOT01FVEVSXzNEKTsNCj4gwqAJ
aGlkX3NlbnNvcl9yZW1vdmVfdHJpZ2dlcihpbmRpb19kZXYsICZpbmNsX3N0YXRlLQ0KPiA+Y29t
bW9uX2F0dHJpYnV0ZXMpOw0KPiDCoH0NCj4gwqANCg==
