Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789103BA244;
	Mon, 22 Jun 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142567; cv=fail; b=ZH/OkJP9iuWKqLlcU2BjQ1KZKTGhqU0cmFO6qkg0upYBBsoLmvaxEPN0ZWcrzMODw/od5EuIEB/QzNDd/KEHxxish54gcIuVGMEOf348x9C8YTPJHwrNfBv1pW6m0pWhcISuiPpC/991EoydWPLpaUpDNOeT9j0y4OC4mieUsxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142567; c=relaxed/simple;
	bh=Li+nS03TK+4YCbHO75ao8wY2ityoUgbbalVmaa0y/qM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQbIA30oHrsUWvLqmKvhuHOC7q8XZmmDo7SBnTPzjhdksJHFhrFGLej1LQuw9ZiOvKtpnNc0oN/ULy7AKj0q2o7SsBOUSYYWbVPunoFNjG1sz+0EdmHoYRoydOBEEdFJ6XybbnAwz/PjzIHGNfL8msFQ//fs6z7hcjqKMepyVPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRD9ysPt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRD9ysPt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782142566; x=1813678566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Li+nS03TK+4YCbHO75ao8wY2ityoUgbbalVmaa0y/qM=;
  b=RRD9ysPtKKoJy6M60mm+RJHqMNO4SwZy25oPMc62EFaBLEk1sDA5PVEp
   6qNnqqWqmkMsKaH8mTHdJHKFSzsD/CzLnazCs6MgmdNnCgg7/b4KJ/wy0
   rpECKRey6umEccTS66AcyuknzQhefWzya/mdPRy40aeRapqoA3KFszv2v
   aBDkjtGQhNzB8pyGA+LxmvH24ycRFb769sELSt+bpq78HKPFs96QSpwl8
   uECcNs5s4z5ixq75QtwbNJPWN54Vboroi+z69aS4xh6OQEjqZbsTMkXQp
   D/mn4Ic50V3S1/inmhL99HE7hOIPoshoiSwHteCYk+2fZU/2Mdi0eCp8j
   g==;
X-CSE-ConnectionGUID: UxZHO1pZQeaohUqAs6XEGA==
X-CSE-MsgGUID: M/E/I9kwSuW46YMn67kb4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="105670880"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="105670880"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:36:00 -0700
X-CSE-ConnectionGUID: iXyZrXplQdiQCUxpz6+WQQ==
X-CSE-MsgGUID: Lfdq39oEQ2uO4WLSyd5bJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248109550"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:36:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:35:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 08:35:59 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs4AexHHmJHxyzjQ31rLAmmH/4uKwa+b/irlTvSi5Xq1w1dKx6W2lK/nbb0yhE/aYvbuRoX62GClo1Y8hEJshWSnXdZb61dUmr2Lx19ogf222KMNb8G7cvo8Kzj9pG25pymrML+pXIYyMCidtSyx6LTEr2A3L4TVAe8mErHPI6hvTKgoclIec8LFNkbgyawSJ+a2bs7+nncY8Ouz7zg8oiIPKi4E4Xp+lGooHhBZJdcTRVKAgjSZYE4eUCR40rq2g0hU3vXZS/KHOuRzL0cKTkxjZQjtydL6rXym8Mjmt/jAsX55z9Y7tgfD763oyZr+01yA88lzy04EdwFMso/+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li+nS03TK+4YCbHO75ao8wY2ityoUgbbalVmaa0y/qM=;
 b=AGQ/nVgbQGiuGJFJ69SP/CD9kATxKyaxQAohyyoAWpqFwauZrp8la6Svd9xAFom6/PIJiwN7EsWPpmC1BCWdarBmgqhgbJ7+ukibSlEt53qFbdlN5hYI8uSKdMqO/BATyVB06MA0AEXE0zY+04c+iSA9mjD2xu79uNEEen47Rjm3rUQVSD8sliSsszwQqUcQuppQezvgZ/09ominjknq+/X0zSD1aW19zD4rTa6yCPI6wSCzzrt63h7IWlInoCRml9FFhhaXG9NJEKDirBhJApTq2DKblRpIBPlYsFaAwgWbfPJHntnTbCvO/hd2bn74kkfA2hPr1X+7DwuBXoQYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MN6PR11MB8243.namprd11.prod.outlook.com (2603:10b6:208:46e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 15:35:55 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 15:35:55 +0000
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
Subject: Re: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Thread-Topic: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Thread-Index: AQHdAghGvz5+Kv429EGKJ1+YNrVEJLZKtY8A
Date: Mon, 22 Jun 2026 15:35:55 +0000
Message-ID: <48a500f5c124b00c3ef33047d59eb18df04567d4.camel@intel.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (3.60.1-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MN6PR11MB8243:EE_
x-ms-office365-filtering-correlation-id: e8219758-0efe-4695-33be-08ded073f344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 0NLshwK+e5MHjOPb/r4zKPfqqeZhZdA2aEbCjlDNxKz8VXWIvHSVqzbzcBQ3pyS31q/3wZoyjNQL4elfrnwqo+SAsRzmmUGYhXRzxK36L4CnwE4HAt2kCPo98MA/OZ/WgcBpxsFF+5AM/nXFUyzo1KCHG8DrGFhk0ebkvCE1XSiZ6JYrM3VufAHK/gpmH130lZ4VmwSKvtZCSzVgZkk5uGohUrHZMfVhimMehoiciqIeG5w7vDfbxrs/CxIqNgSJs9dH2ubbNR1Da+nY+elBWi093RPWiRsvYqoGFGSMhODNtcSTPZfRPwo4Yp4XYE72NLrWvvs82Oen2OTH36+Ppj/0h6GINc34gHxXBghIw2z8WMcwH+qHatAv9ub7K1dVaKDxDjAgMANSpLznCSQHa8jOF2S6ws7Yu4RD3Q4OYsmr6o35Bm9OYj+rlZy1B/qM4l6iUNJgbN4X9bGEtEiHcGH5KCi1ZqU7w+SBoEfoXG4+9IGZjsMNhHSM91IybOwa31YUViWMf0kavYck8xANiN3ggt8xF0OnfC6QeWuBrScnmVVrdbyryEOEd2yyE47ue8Ym8ZchaI5UHYWEY8n5frJXVOe+IsWTiDaV1/7tonxOd/rKXLH0jnSRvM6wNlYR1t7va1AIij8Ny/s8HdT2883xEYps1+fDC2lfMKEM0mg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1psQzJtd3JJbUVvQmhHNVdneTBSOEs1QW9zcTFXWVZqNy9ZdGtRdGlPVXBq?=
 =?utf-8?B?NzU2VTNaOWRKc1dpdnB1SnBVZDEyR1dIOWpVYnRmUDB6S2NWSUIyQ1Z6aURj?=
 =?utf-8?B?aU5BU2tqbzBWczZ3Rkh0aWVPalROWmlrVkRrR21ldUpvNXZYU1RCaUxIdDFu?=
 =?utf-8?B?Q0pGTFdOWWNBejlxNTM5dmQ5QWtNaXBJTlgyYjNtbC84VXp5ODFBaWJVY3Bj?=
 =?utf-8?B?Sk9aQk1SK1ExZ2V3MlV1UEgwMEdDazdDQ2N1ZS9MWFRRWDZjMHBKWVlkSGlx?=
 =?utf-8?B?R2FpMG9ZN1lCRHNlU0s2YTZhaUhBZzArVG9WS0RLOGNHQjk1U2FFYlp5R3FV?=
 =?utf-8?B?QmMvbXljdVdsQlJPMldVUVYyY0lhaE83dEFzTUhldTdpM1IxSDcwUXkrUzZa?=
 =?utf-8?B?VnpEUWRLRDVLcThLdVViR2tUREJWSXdXbWlnM0xDS05EUjFVOWRBRlh2aUUw?=
 =?utf-8?B?c3VYWVAreVB3RmxEajIvMlBwbkhMNU84aGRIaFcvUVRzTDFsT3l0ZEtnQkY3?=
 =?utf-8?B?WWE0TXF3QnNBZWN5ZXRzVTdxeGRIVEdFWjIxTWZFTG5hWVV4S3M1eitFdmpt?=
 =?utf-8?B?eFR2Y2tmTmxlbGtPTm5JNkNOcUdCTG0xWld5RDkzTlFOeEdCTGxORUd0UUxr?=
 =?utf-8?B?eVYzRHRqK2JndE9weU5XSmExclJucEQzSERjOW1SQTBxYk94d3Q1YnlHUWpr?=
 =?utf-8?B?V0U4K2p4dEdYM29NZTcxN2NHanlMVjVhMU1zQlQ2c3Q4bUoyV1hLb3RsMnhr?=
 =?utf-8?B?aFB3WkFPRVhKcGhOZUI0azFVL1dOMGZ0ak5kS0RaQ3FadEdONGxHQXBMTFFF?=
 =?utf-8?B?NkxwTnIyVnArem1BMGZLbHYyUHhZMjUydllsMXBYVUowMVNiNkhNaXBzOWc3?=
 =?utf-8?B?WERxS0hWR2VRNUhiWVA4T1BUVFptNGl6TFhJaXdzQUZUeUpZQkcvWWVNM1Vx?=
 =?utf-8?B?WXRCdHM3VjA4cFpBblZmNXlZL05xaldpNncrUTc3aTZrNzdmdVgrT3Z6OWZL?=
 =?utf-8?B?enZFUWpNVUkwenlpNEV5a1hiVm9QQm5oMzdoamhJM3lXSjYxM3g1SmFzbnZ5?=
 =?utf-8?B?M04xTDROOW12MW5DbDVUOG5yT0hqakFKNEJTMFJPZk5oN2UvcTQ4ZWVRdE5R?=
 =?utf-8?B?NlgyZWNNQTkzM0VEZzZ5OUpPYnM3WjBYY2pOSVBxRVV3Qjh4SlR3TjJmQ2t0?=
 =?utf-8?B?bVB1ZW04UFNadXNqTldSbXFPSlUzQklKUS92RDM0MWoyQldQOXNwRWxFQUYz?=
 =?utf-8?B?Ly9oYWlvbmQyLzJvM3RFU0JsSzByN2VnL0xOcTFid0xZaXlsckF6U21OUDlG?=
 =?utf-8?B?djRxdEZjTm9oVnpkU0wyQWdTZnZsWVdOcWFlbGpucEY4OWJuU3VoMUNXcStM?=
 =?utf-8?B?R1cyTHF1Z1BBTWMrWmkyWDNxcmt6Ynd1SWVuN25POHdTclMyMFpRQTVwOG45?=
 =?utf-8?B?NVRrRE1UOTFoaTRjbkFKS08vTHU1ZTZ2dTJGQld6NXpOUVcyWHdlSWdPa3Ux?=
 =?utf-8?B?aW5mNFZHdnh6YXZUb1JtY08yeER2VC9GaHlxMHpOOXJyUU9kRGxneGVSajdp?=
 =?utf-8?B?WmErV1VQc0FraHVRZmpkOTRXZVJDa29rcDdzR0lyWXZaMHFQUEJGdlNGN2I5?=
 =?utf-8?B?WUswNk1rWFoxM1FLcXRWNG92Zy94UTJ3NzdnenlHQ2g4bUk0UFBobmQyZnda?=
 =?utf-8?B?dE40eG5xY3ZuTlQ0K3JGT2l0M3BGSEI5ZEdNSU1hTGZseUNSNzgzWVFqSWt5?=
 =?utf-8?B?RjJncXAxdFo0UngxWXdXRzUzRDZKeHdUb2xMaSt6eEtrL2htYkN1bFR6cHNU?=
 =?utf-8?B?dkw4M2QvNUNxc0tFS204OG9GU08xVlV3aFdJcS90enlPSG5ISTJOVWlhVHJw?=
 =?utf-8?B?ckZhSVczcUpaTmFReFo1Y0tpVzlCMzZSRm9hVkNyTFBBN3BBK0NoanJYUTVX?=
 =?utf-8?B?ZmtOQ2hKTStLNHEwWC83QmdYU0R2UklXcEN2S2M4SDJPbHBaRkhiaWNSb2lK?=
 =?utf-8?B?Z1l0TVY4NElHUTA5c3BzM1NvbGtTelpCMEJMQUJCMnZtL2djUXIxNER3N2dR?=
 =?utf-8?B?em5xSXU3OWs5QXV6bWErTy9zZVlORUFxamlja0dUanNqRzBqUmcvSld4eG5m?=
 =?utf-8?B?WWg1N3ZUWWRqRFhoSmdLQnJ0RjR6bnpNUnRoOWxoUmdxZ0ovSHRoY1QxTWox?=
 =?utf-8?B?UUl6ald6WnJSM2Fob2VVUmJwc25xV1Y3L0t2SHVFT1lPVTJWM0NxTzdyMW12?=
 =?utf-8?B?WDRldmk4Zi9BWDRpVlgvVGlNNnpWd0RaYUNGU2lXdnBQb3VzVmF5Q3RyZ1Q4?=
 =?utf-8?B?QUVWTlBHdnpjdkliU3NiRTRBTWpYOWZTdEpCdTlDR3dDVXAyZHZQaFA5bXEz?=
 =?utf-8?Q?2V1JJKR4AfCqQpjbKakianh3Cso1tbaF8PNlo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A13A1D4C05798B4FA54E4DFF373B31D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qp6wNVGB3A9lopax1qO3r/BSUwyYc18Pnup3trZ02Fu1UDhCLTnU3xHzOQZm9e3m8EF1vz5M8VTU9ufLiwqKkY681UHM+H4Qn9PO9XG96GrHOEnwSnF5AnkLd5AewlS9CCau8u1kG/VHgTu5Ugilg0BrU8gdrlllIl4DqgTI35b43f6Knp7e1OLlxVIvuc4e4+XCeYQ+/A0ZQ+ufc7smgH0t+dHrVK+wRptb0gRZhfTuED7R8XixDwE91zSsNJfv6Pap0KUNUjZkinLwZHbo5wmWl9MKvbIWfnqUfydxEiNHweoIGbywleON0jGlt4E22G77LTvvornZC6/uaU5VlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8219758-0efe-4695-33be-08ded073f344
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 15:35:55.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvYj8Js73fTGFrhgz8tbrZqHLkn/U3wmcqg6D0fjSeUbe2JAB3PxuO8eVQ311TDsvu6W3oLIJrlJIiU+pU3ha6wqsDxgpjPWEupl9Owfr/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8243
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA2LTIyIGF0IDEwOjU5ICswNTMwLCBTYW5qYXkgQ2hpdHJvZGEgd3JvdGU6
DQo+IEhpIGFsbCwNCj4gDQo+IFRoaXMgc2VyaWVzIGF2b2lkIGEgcmFjZSBjb25kaXRpb24gaW4g
SElEIElJTyBkcml2ZXJzIHJlbGF0ZWQgdG8gdGhlDQo+IG9yZGVyaW5nIGJldHdlZW4gY2FsbGJh
Y2sgcmVnaXN0cmF0aW9uIGFuZCBkZXZpY2UgZXhwb3N1cmUuDQo+IA0KPiBDdXJyZW50bHksIHNl
dmVyYWwgSElEIElJTyBkcml2ZXJzIHJlZ2lzdGVyIHRoZSBJSU8gZGV2aWNlIChtYWtpbmcgaXQN
Cj4gdmlzaWJsZSB0byB1c2Vyc3BhY2UgYW5kIG90aGVyIGtlcm5lbCBjb25zdW1lcnMpIGJlZm9y
ZSBhbGwgcmVxdWlyZWQNCj4gY2FsbGJhY2tzIGFuZCByZXNvdXJjZXMgYXJlIGZ1bGx5IGluaXRp
YWxpemVkLCBvciByZWx5IG9uIGRldm0tYmFzZWQNCj4gY2xlYW51cCBpbiBhIHdheSB0aGF0IGRv
ZXMgbm90IGd1YXJhbnRlZSBjb3JyZWN0IHRlYXJkb3duIG9yZGVyaW5nLg0KPiBUaGlzIGNyZWF0
ZXMgYSB3aW5kb3cgd2hlcmUgdGhlIGRldmljZSBjYW4gYmUgYWNjZXNzZWQgd2hpbGUgaXQgaXMN
Cj4gbm90IGZ1bGx5IGluaXRpYWxpemVkIG9yIGlzIGJlaW5nIHRvcm4gZG93biwgcG90ZW50aWFs
bHkgbGVhZGluZyB0bw0KPiBzYW1wbGUgZHJvcCBvciBzdGFsZS9ubyBkYXRhLg0KPiANCj4gVG8g
aGFuZGxlIHRoaXMsIHRoZSBzZXJpZXMgZW5zdXJlcyB0aGF0Og0KPiDCoCAtIEFsbCByZXF1aXJl
ZCBjYWxsYmFja3MgYW5kIHJlc291cmNlcyBhcmUgc2V0IHVwIGJlZm9yZSB0aGUgZGV2aWNlDQo+
IMKgwqDCoCBpcyByZWdpc3RlcmVkIHdpdGggdGhlIElJTyBjb3JlDQo+IMKgIC0gUmVzb3VyY2Ug
Y2xlYW51cCBpcyBwZXJmb3JtZWQgZXhwbGljaXRseSB3aGVyZSBvcmRlcmluZyBtYXR0ZXJzDQo+
IA0KPiBQUzogVGhpcyBpcyBwcmVwcmF0b3J5IHNlcmllcyB0byBjb252ZXJ0IGFsbCBISUQgSUlP
IGRyaXZlciB0byBkZXZtLg0KPiANCj4gVGVzdGluZzoNCj4gwqAgLSBDb21waWxlZCB3aXRoIFc9
MSBmb3IgZWFjaCBwYXRjaCBpbiBzZXJpZXMNCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIERyb3AgZml4ZXMgdGFnIGFuZCByZWN0aWZ5IGNvbW1pdCBtZXNzYWdlIHdpdGggcmVmZXJl
bmNlIHRvIHRoYXQNCj4gLSBMaW5rIHRvIHYxOg0KPiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsv
MjAyNjA2MDYtNS1qdW5lLWhpZC1paW8tcmFjZS1maXhlcy12MS0wLTI3YTg0OGM1NzU4ZkBnbWFp
bC5jb20NCj4gDQoNCj4gVG86IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPg0KPiBUbzog
Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gVG86IFNyaW5pdmFzIFBhbmRy
dXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPiBUbzogRGF2aWQg
TGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBUbzogTnVubyBTw6EgPG51bm8uc2FA
YW5hbG9nLmNvbT4NCj4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPg0KPiBD
YzogbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQoNCkFja2VkLWJ5OiBT
cmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4N
Cg0KPiAtLS0NCj4gU2FuamF5IENoaXRyb2RhICg4KToNCj4gwqDCoMKgwqDCoCBpaW86IG9yaWVu
dGF0aW9uOiBoaWQtc2Vuc29yLXJvdGF0aW9uOiBBdm9pZCByYWNlIGJldHdlZW4NCj4gY2FsbGJh
Y2sgc2V0dXAgYW5kIGRldmljZSBleHBvc3VyZQ0KPiDCoMKgwqDCoMKgIGlpbzogb3JpZW50YXRp
b246IGhpZC1zZW5zb3ItaW5jbC0zZDogQXZvaWQgcmFjZSBiZXR3ZWVuDQo+IGNhbGxiYWNrIHNl
dHVwIGFuZCBkZXZpY2UgZXhwb3N1cmUNCj4gwqDCoMKgwqDCoCBpaW86IGd5cm86IGhpZC1zZW5z
b3ItZ3lyby0zZDogQXZvaWQgcmFjZSBiZXR3ZWVuIGNhbGxiYWNrDQo+IHNldHVwIGFuZCBkZXZp
Y2UgZXhwb3N1cmUNCj4gwqDCoMKgwqDCoCBpaW86IHByZXNzdXJlOiBoaWQtc2Vuc29yLXByZXNz
OiBBdm9pZCByYWNlIGJldHdlZW4gY2FsbGJhY2sNCj4gc2V0dXAgYW5kIGRldmljZSBleHBvc3Vy
ZQ0KPiDCoMKgwqDCoMKgIGlpbzogbGlnaHQ6IGhpZC1zZW5zb3ItcHJveDogQXZvaWQgcmFjZSBi
ZXR3ZWVuIGNhbGxiYWNrIHNldHVwDQo+IGFuZCBkZXZpY2UgZXhwb3N1cmUNCj4gwqDCoMKgwqDC
oCBpaW86IGxpZ2h0OiBoaWQtc2Vuc29yLWFsczogQXZvaWQgcmFjZSBiZXR3ZWVuIGNhbGxiYWNr
IHNldHVwDQo+IGFuZCBkZXZpY2UgZXhwb3N1cmUNCj4gwqDCoMKgwqDCoCBpaW86IG1hZ25ldG9t
ZXRlcjogaGlkLXNlbnNvci1tYWduLTNkOiBBdm9pZCByYWNlIGJldHdlZW4NCj4gY2FsbGJhY2sg
c2V0dXAgYW5kIGRldmljZSBleHBvc3VyZQ0KPiDCoMKgwqDCoMKgIGlpbzogYWNjZWw6IGhpZC1z
ZW5zb3ItYWNjZWwtM2Q6IEF2b2lkIHJhY2UgYmV0d2VlbiBjYWxsYmFjaw0KPiBzZXR1cCBhbmQg
ZGV2aWNlIGV4cG9zdXJlDQo+IA0KPiDCoGRyaXZlcnMvaWlvL2FjY2VsL2hpZC1zZW5zb3ItYWNj
ZWwtM2QuY8KgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKystLS0tLS0tDQo+IC0tLQ0KPiDCoGRy
aXZlcnMvaWlvL2d5cm8vaGlkLXNlbnNvci1neXJvLTNkLmPCoMKgwqDCoMKgwqDCoMKgIHwgMjAg
KysrKysrKysrKy0tLS0tLS0NCj4gLS0tDQo+IMKgZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNv
ci1hbHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMCArKysrKysrKysrLS0tLS0tLQ0KPiAt
LS0NCj4gwqBkcml2ZXJzL2lpby9saWdodC9oaWQtc2Vuc29yLXByb3guY8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMjAgKysrKysrKysrKy0tLS0tLS0NCj4gLS0tDQo+IMKgZHJpdmVycy9paW8vbWFn
bmV0b21ldGVyL2hpZC1zZW5zb3ItbWFnbi0zZC5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0NCj4g
LS0tDQo+IMKgZHJpdmVycy9paW8vb3JpZW50YXRpb24vaGlkLXNlbnNvci1pbmNsLTNkLmPCoCB8
IDIwICsrKysrKysrKystLS0tLS0tDQo+IC0tLQ0KPiDCoGRyaXZlcnMvaWlvL29yaWVudGF0aW9u
L2hpZC1zZW5zb3Itcm90YXRpb24uYyB8IDIwICsrKysrKysrKystLS0tLS0tDQo+IC0tLQ0KPiDC
oGRyaXZlcnMvaWlvL3ByZXNzdXJlL2hpZC1zZW5zb3ItcHJlc3MuY8KgwqDCoMKgwqDCoCB8IDIw
ICsrKysrKysrKystLS0tLS0tDQo+IC0tLQ0KPiDCoDggZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0
aW9ucygrKSwgODAgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogY2M3NDYyOTdi
MjNlODliZDVkZjlmOTFmM2EwY2EyMDllODk5MTc2Mw0KPiBjaGFuZ2UtaWQ6IDIwMjYwNjA1LTUt
anVuZS1oaWQtaWlvLXJhY2UtZml4ZXMtZjhiOTgxZjgyYjgwDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IC0twqAgDQo+IFNhbmpheSBDaGl0cm9kYSA8c2FuamF5ZW1iZWRkZWRzZUBnbWFpbC5jb20+
DQoNCg==
