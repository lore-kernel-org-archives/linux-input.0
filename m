Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6878F2F;
	Wed, 22 Apr 2026 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820131; cv=fail; b=gH+Q7K3zp60TP0QhTXymD7tyP0wg60Lcr34zL0TgyPtmGG457mpTEqA6DzJ4CoxvA+83OcaNGo2qmq9IZHns++4wmQ3JHILK6c4mV3rkJGTvCDc9/qZT0QuOKdpxKMgj0U0qtuNZmr0BFv2cNEJZA3ombfK2Bhb22c0jJnCW9bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820131; c=relaxed/simple;
	bh=kcY8X5ss+eCEei7nNULKvXCE0MJo3PO3RqkO3F+9qxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BktteJSPp3FZCWwpP/08PWVrBg8z8Jkm2pL9X773MO+PcwlqboKM1LEnl5oPXRPylhrWbhpFLXy+xxin96LSNAJRQW4Seam+/A5I8AJz+72L5gRnXETK1no3wEH51itpVHETRQRB5STSeLbGChOS+SFuvBu5Hlf7OqNxCD08k/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcKmIocf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcKmIocf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776820130; x=1808356130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kcY8X5ss+eCEei7nNULKvXCE0MJo3PO3RqkO3F+9qxk=;
  b=gcKmIocfyhP2DHRqL5kfaqlBzWWiHxrGMPRhZfJqy1uBSQfi4fxgf/kU
   45t2w92beVpuQ8bJ5lBZwZYSnS2ORLE8PKhF9BHo+71k35hDTsufKojuO
   7hgbt4dBy4mFAO6U9IlqjXd+zANEiCoFZVLynsMIEk9uxctHFtz4zO+8k
   nsX0WDMB/CA+cjQ7g2sqwhTG4ZrVQNWCbb0EsdK6WgG7uWkd49mnOWTqT
   h2cb9NCIaK08oGkLxX7Gj3LFQZowlBnCidZNsUC4aphe9/xztTjFTIFmi
   FIxwgc81csSp+k8ZDwNOpJmBjPU4Afp5RguSnQ3ADPFa6OlHRr+6Tx/VG
   g==;
X-CSE-ConnectionGUID: zpaCuvW9QTquIucfC8GJ7w==
X-CSE-MsgGUID: u9niQ4fkSA66cU5x8me43w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89237070"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89237070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:08:49 -0700
X-CSE-ConnectionGUID: 8vz5yL7sQFibyJ41hJXg4Q==
X-CSE-MsgGUID: hOA8RvOART++pTYk4fgGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231157170"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:08:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:08:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 18:08:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFdn7ZpzDFLR+2Wt4Px9ip2moDEhbsl4Q+Yr8J8d2ESTiQrc58Y5+XWmS+K9ZkoeSHjRYXL5bn4VkAVlR1prrih5VhJu8coeZ62qn8b6QJZvgpUqIkxzDYBdqM7KloDP2JZ+4jg8M2S+OmSSoaXHqdhxWSoVGKdxz7coF138dQF8pdUABLEYOGCAcYUuaaR7Ruceq8EPjCNKukWLchxQlqZNCoIcqKi3yY2lyBXUXsc4oAO0RaCR6r4qaUX2j8PQLuGa0pPCmE8BqGNorKtQODeye06MtueNmAEIfVE7PDe+t74hnQsKg0gtbTad1Pxbhg99TMkYCbJ9wkN+ncycuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcY8X5ss+eCEei7nNULKvXCE0MJo3PO3RqkO3F+9qxk=;
 b=lx2Y55yOrtrikVPWwkmWLN7BMJPmV+Fcnd3yhAmCU8NTnnwFZVRO4Q38nrUI6S2I4J8lHGN0m+m2hFjRDYduh/gG0vYTcSYkH16xtRBUekZVDJYvEaVq4e2cBfPqUJmeAzX1WfKQ3f9m0NdFvfGyhXorrSiyzgeR2fAIwQ5PDZVU+WH08eZMY0jfVXaaxI9iQdNmSuLRpSbPXmhzT1ow/dibwkcSde+zfZaPZxGjLmmu0Tx6BVCdv8aNv5nF/hHqImOcOKJR3SxXugivNto/d/6JZ5gMEEFrI30IJcbx9/nXPM9Sk/wcaOt6AZFJ68EbYc4dOfKJE0ZygvpSO0BHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 01:08:41 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:08:41 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Lechner, David" <dlechner@baylibre.com>
CC: Jiri Kosina <jikos@kernel.org>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
Thread-Topic: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
Thread-Index: AQHc0NzU7xLOk1vmgUGNEc1BXghflbXqRPwQ
Date: Wed, 22 Apr 2026 01:08:41 +0000
Message-ID: <SJ0PR11MB5613E80D200F4CA75183D43E932D2@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
	 <20260412152643.68c8f065@jic23-huawei>
 <ff6d54f76139c43642f15ef21da6997145bca8e3.camel@linux.intel.com>
In-Reply-To: <ff6d54f76139c43642f15ef21da6997145bca8e3.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|IA1PR11MB7175:EE_
x-ms-office365-filtering-correlation-id: b1c55f17-0d1c-475e-01ef-08dea00bb194
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ff2T0+arebcUF73kJ7g47/t5KMOD9pRtzwrVnkj5AQIoyThy2e4Cwfte4LxzFIUSTuuMrw7/QNChwm+1+ImyFD4x64NL6BJXCkDnLSomrSmVXgTIrP3FOh3qHuSX9+flM6usqj5Sk0T+z43MGkaMJB0VPoQG0HgX6oiztKKYconKiLiWz4CMgLG1UfJVYUExMc6380XNysc2z0weAS6JyYDOIStOI9iIywGQ8EsmzOErLouEujy7xioH2m7EhR/aMfAn9XwQP0786XN7Ww5hw09+Ev2ECecZSSAm2qkAQg5a+U7KlKzYW0LhQapMXDxQIG5JzHRut2RRFifPrLTqW4t3woo0wSHPLs/+RRGsJuzUOn08Jgp96IxCLcwt0dyYvx31OIHA2RgUIXWLXilpNltHJWq54XXTB2bbyTohThrD1xxCt0LZ32mpbiqH1Dxl5TJ8iJbwgQ21sD1pokVogPGnGc6a0U9ARUNkLA8UzI7Rqqr7YHLiYBBaYxvnn3cvMkeYhQTAAIczp3Ek0oEreylrXEJ79g9vKP0ar6NimJh1NANqb/KOTV3QSIpwaNNANlTRCxbFiEjhT6c4BTY4GFeTcs2CEhN+SnVA321Opdx7l9p2qhzUQUGXl+3oImXgWmlF5du9J7XT0LDZsfn/q4WejRm2CdRsK2wm2xSmormyTshbJUv1AMICpPw77JuUARDn/KF4XdItKDPhDp1fS0A6xHlqyjYv7VnAk21jK+paDTy6pnAyuhlZoSk242uLtCOh7JMtNAhvTT8c+u8PbzNXeYaBvIKfp3ebMMegvCI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUFmWE9RaVR0WUpObGhsbk90bDFseXBJVWsvUmFtWXZVMTRyUnpCbU1hUWtN?=
 =?utf-8?B?ajdOZzVyZElyejFMVXN2WUJGcEtCa1VZNVpKOXhma2h0VklsYXpyTFNxZ3Jh?=
 =?utf-8?B?QThNa2E5YzBlSlgzYUdvRXBZdm4yZWdtWk11eTdlL1JsdDg1UnZZc05WL00z?=
 =?utf-8?B?L29yUFJUMXZhSzJUN0tOaTdxOHRxWmNGakFoWVJueG92UE54TG9XZEF2RC9a?=
 =?utf-8?B?TG5ZWHpTbGxLeXlLSXlCOWFrNERjWG1UZmJnSXFqSHk0Q3k1S1A2TE9EK1hl?=
 =?utf-8?B?YTNNS3Z2aEtmWWJaTFdkc0paY0h6L3ZyNndpZXZpNU5vSHN3YUhweUJQNk1o?=
 =?utf-8?B?OU5zV2ZXVUxNMW8rVDJiVUdwVGFxdnJFTklldjB2cW1FakMrWFl4dmxNUkY0?=
 =?utf-8?B?S0xxdHdpK2dNU2syb3E3OENveTV6cnZBQzk2dVhhTUkxdUV5eXV4bmpYbUpR?=
 =?utf-8?B?RWFkYTBJV3hGejhPU0ZBelkzaWdxU3FlblNPMHR6L0hvRVZWMG9IL0FQZlVo?=
 =?utf-8?B?c1BBczA0ZTc0Qzh0Vkd1Qm9ldktOZzFyVjdSN05DTEVKRnZkUjFyd2ZuOEQ1?=
 =?utf-8?B?RTVyOGhTMmhubmlXanJ0UGVlbnFoM1Y3aGt0MjViUG40ZitsTWNJTXZQbXFj?=
 =?utf-8?B?QjZSZ0FDRys0Nm52VEdFSHBGUkI2OUhnRjZBUDVYKzAxRi9SZklhVWtheEdh?=
 =?utf-8?B?K1I4cTUrdUJMcnhHNmFTZVN2OStJQnUvWlB5eVhrS0w4a1Ztc2NHZUhPRkVX?=
 =?utf-8?B?WmwvSmtkVHV1VEJDRzBIMDQ1T2ZoUjE0cDBpTlcxLzJxQUdzRXRTOEF1WlRY?=
 =?utf-8?B?RzlGMjJUbjdLejRjYjZTSGJ3R2s4WTZuNW9hYUxIOU9kR1ordHJRVmNIUnlZ?=
 =?utf-8?B?UzJuV3FFd252dzltWFhjYnlFMU9WUFBGOGRPYTVjSVI0K0I0MVByam04ZlJo?=
 =?utf-8?B?ZlQvcEhiQitHK2czSFlmK2p5M05aTHRIQmFSN2g5eGZ6d3VrcWU0NGxGN1Qv?=
 =?utf-8?B?T1l6K1dUTTg4QjQ4cjV4VWJPK3NSR0JPcjJuQW5qZkJnSCtTcFRUdElnRXBZ?=
 =?utf-8?B?QldrMWJFaHoxVExhNUpHUlVHSUZqNDZZaDNCWmRCTXFiRTVlZWJDaXBkNnNj?=
 =?utf-8?B?RHBKbkZwUjJCMWVJejRucDl6a2FzdFNIZDJINWI4WS90K0o2UjRjSVpjVFFn?=
 =?utf-8?B?QTMwTDVTQ2plSzNGMjdZalcyQjV3TG5jWFBIdnVNZE1xOHY5NGplSFl4cTVQ?=
 =?utf-8?B?c1Roc3FQVUZvNGJTL1RiVFBDZjFrZnlPbVMzYVB5ZTUyRzZXRWlVNk1YaWxH?=
 =?utf-8?B?b3JjWUo4aFBuQVI5OXhaNTlMZ2RsVnh0V2dTVDc2RHVWUTcwbVpXUHFrNTZB?=
 =?utf-8?B?MUhrOHVGWWRNSmNJUHhkaHYyWXdVc3doelhZYXVyUTBXQndRWGFNUVo5bVBr?=
 =?utf-8?B?SVhraHNXS3pBSmNRa2RWRGdxZk1PQjhLb2JyaXhpQzFWSDMwNEZSYW1OWGxU?=
 =?utf-8?B?MjBTS09mbEU4MGUrOGtBSDJ0Y0J4cXRvOTNmeFNEcE5zczVvWGszRWo4bzlo?=
 =?utf-8?B?dUdDRkRkNHB2eHNOOHZ6bSsyYXNER0xUYjBmOGp2QmYzMUtsTzUwMHNUM1V5?=
 =?utf-8?B?a29YeVI4K3JaamFvNW5ha1VTdUp5YitZSkhZWlJmY2ZhVTU5T0pzZ3B0ODFH?=
 =?utf-8?B?dnpDUUhadUdIdkxCNzlhTUw0RjA0WUdvTzJ4TG1TaEFhK0JhU0xGTldIT0xq?=
 =?utf-8?B?NEd5YytVWUVrbXRNNllpandaamE1N29zK0tJYjluMnJCbHdYM1ZPR3dBeSsz?=
 =?utf-8?B?cTRGYXVJSmpQbHBzcXBqSnBkUlh2cjJ1YVVzc2sxY0VDR0JrY1dkWFBscW9r?=
 =?utf-8?B?SVlldmlnMm91NDdGOEY2ZmFQaldGVlNGeWtTZ0Y2b0ZycDVLcEY1M21XMzFO?=
 =?utf-8?B?RWVaU1dTaVU3WG1jeERtSzBIdC8wVXB3ZDk5d00zamVjU2RPWkxOVHNkWW90?=
 =?utf-8?B?UW9Nd0IvMjErb2N2KytGS08rSmZzS0FVSU1uV00vdlhYQWpXdnJyNXluUUYy?=
 =?utf-8?B?SG1pRG5RS3kvOXJYdmhTN044ZmRZZklReXZGd2J6MTRid1pSc212NVdhaWha?=
 =?utf-8?B?MWZQT0FSSWNTeDNTSTBLNHlHeDlIclgyQk15czNWWE53OS9WcGFjVjhNaHoy?=
 =?utf-8?B?SWFvQnc4bjdpSGhnZmdEQzFxKzFmSzdyMmRHeWZETWJrRkdPZ1FXK0UzZGkv?=
 =?utf-8?B?TzVnQWx0NlpjYnU1eEFualRKa1JDS1BHYUc0eThOT05DdTFDUmxxZ2Q4Y0hm?=
 =?utf-8?Q?PoBzrekOFblE9vaV86?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GnNPEl08/mkgKbyXbvXNRdq0Y79BmnmbsN8NhxaXo79zZAUKYRoplyKReZMHoqmr9L9uSUhvsul6puOxsy8nhK8jSW8HeN0PZWT+uBTEmTbGfkq/vd47oRlS9R8G/1W+DBlRRV50FSPoGEZSTfAFegcl07hO+s6Tpd1j//FaA8bmA3cAooD9tcgho6ov4u3Lo1HW3GLyGZGJyhsRVm/4JNc/Fa4vTpNWUhCGLgpaBeZuxqPFMiIX9bx8AkugQLiWA1c1pGppUN6Ir0BMAuuDB6LFtksFPqtfkd3MkAQPHkJGgCuxTCvLfLzrhUVU2wJMk5aRH6WGf7IJLZmT3UZJCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c55f17-0d1c-475e-01ef-08dea00bb194
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:08:41.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARmzateYuQejsXmpZ86HsCPZXYZ5YUdMFlZNhhWs2VttZUpjXiG53R2nPUH8BTDOuUW5lKFnfhq2F+s06MbKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-OriginatorOrg: intel.com

VGVzdGVkLWJ5OiBMaXh1IFpoYW5nIDxsaXh1LnpoYW5nQGludGVsLmNvbT4NCg0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogTW9uZGF5LCBBcHJpbCAyMCwgMjAy
NiAxMTo0NiBQTQ0KPlRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGVj
aG5lciwgRGF2aWQNCj48ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgWmhhbmcsIExpeHUgPGxpeHUu
emhhbmdAaW50ZWwuY29tPg0KPkNjOiBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IE51
bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5DQo+U2hldmNoZW5rbyA8YW5keUBrZXJu
ZWwub3JnPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5paW9Admdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gaWlvOiBvcmllbnRhdGlvbjogaGlkLXNlbnNvci1yb3RhdGlvbjogdXNlIGV4dF9z
Y2FuX3R5cGUNCj4NCj4rTGl4dQ0KPg0KPk9uIFN1biwgMjAyNi0wNC0xMiBhdCAxNToyNiArMDEw
MCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+IE9uIFN1biwgMDEgTWFyIDIwMjYgMTc6NDY6
NDggLTA2MDANCj4+IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gPiBNYWtlIHVzZSBvZiBleHRfc2Nhbl90eXBlIHRvIGhhbmRsZSB0aGUgZHluYW1p
YyByZWFsYml0cyBzaXplIG9mIHRoZQ0KPj4gPiBxdWF0ZXJuaW9uIGRhdGEuIFRoaXMgbGV0cyB1
cyBpbXBsZW1lbnQgaXQgdXNpbmcgc3RhdGljIGRhdGEgcmF0aGVyDQo+PiA+IHRoYW4gaGF2aW5n
IHRvIGR1cGxpY2F0ZSB0aGUgY2hhbm5lbCBpbmZvIGZvciBlYWNoIGRyaXZlciBpbnN0YW5jZS4N
Cj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGli
cmUuY29tPg0KPj4gPiAtLS0NCj4+IEknbSBnb2luZyB0byBhcHBseSB0aGlzIG5vdywgYnV0IHdv
dWxkIHdlbGNvbWUgYW55IGFkZGl0aW9uYWwgZmVlZGJhY2sNCj4+IGZyb20gU3Jpbml2YXMgb3Ig
b3RoZXJzLg0KPj4NCj4+IE5vdGUsIGdpdmVuIHRoaXMgaXMgbmV4dCBjeWNsZSBtYXRlcmlhbCBu
b3cgSSdsbCBvbmx5IHB1c2ggdGhlIHRyZWUNCj4+IG91dCBhcyB0ZXN0aW5nIHVudGlsIEkgY2Fu
IHJlYmFzZSBvbiByYzEuDQo+Pg0KPg0KPkluIHJlYWwgd29ybGQgSSB0aGluayByZXBvcnQgc2l6
ZSBpcyBhbHdheXMgMTYgY29weWluZyBmcm9tIHNwZWMuDQoNClllcywgaXQncyBhbHdheXMgMTYg
Zm9yIEludGVsIElTSC4NCg0KVGhhbmtzLA0KTGl4dQ0KDQo+DQo+ICAgIEFja2VkLWJ5OiBTcmlu
aXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4N
Cj5UaGFua3MsDQo+U3Jpbml2YXMNCj4NCj4NCj4+IFRoYW5rcywNCj4+DQo+PiBKb25hdGhhbg0K
Pj4NCg0K
