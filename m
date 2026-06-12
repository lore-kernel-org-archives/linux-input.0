Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9B2874E3;
	Fri, 12 Jun 2026 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242423; cv=fail; b=urvmsTdRGC4C1KFRRcZyWxA3pecrd7Ky35OVng+UFGm1HXqYYfc6X65zM2/dFDWnez4XFVRyhwbl5iszcXCJrRjzdqUorkB2JLDOjCGA0h8gY062Nuk6e3+yfXm6dRuMbMGeRFK0fT2pAOuVbaSAvW1+pxpafjJXUwl0wXmWz04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242423; c=relaxed/simple;
	bh=6sb7EDss/RKbEv7bYa5BXZMoHLGneCNt4rSfILEHByM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nIOVCxbznDtRKAgEsFyYz4ljRiEEv+B63qUehGrcswlPbaW0oKzWVbrfo7XY3egG2YZQXbK51ZwtV9fm4JgUJsFK47GIbuYRkdKBoS1TQjXlzrU3lJ0/xRdg0X8WDVb9aR6wp7JLJKHAYySU5uIJy2o1f8/eRaLUjmuLWth+iFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkebp09q; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkebp09q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781242421; x=1812778421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6sb7EDss/RKbEv7bYa5BXZMoHLGneCNt4rSfILEHByM=;
  b=nkebp09q+ozsyKCnfUZw4txDGQtgxpDWJUzunekIDKvJJrhv9KUFGLXL
   jLZp8xebL2XJaCILAgDqcMhIa3PRTV5pQ30ItfHSQFL0Y9x4Pv1nWOSDf
   QPD2b5K7En1xlyajFO7/tbGahJrgvK6vAxdmcjGFKoO2vFo3giQeUrLcU
   2tBm1G/Sp45FRbn0JR1LxKAO/bbVpz9AyjY/QRMOWQXj0MMZesJ93Cb/h
   A3d6p3caHycQxIL5WVRIQo/GWrrD7L9H0gYH954Bvab4JGbFM0C9URGpk
   GuRZl1t+g6x/+PAQLggx8kD87fjCNRjibPg+DLYuda9RQ8Sc/kuHjX+ic
   Q==;
X-CSE-ConnectionGUID: 7maDo552QT+hNviOv+0N0Q==
X-CSE-MsgGUID: OC1MwSp0Rv6PNM4rwe3fcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82261542"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="82261542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:33:41 -0700
X-CSE-ConnectionGUID: mF7jSG0RQueVNMgyxVzIRw==
X-CSE-MsgGUID: L8qDYYN1QVywE9HD0nIeMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="250656344"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:33:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:33:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 22:33:40 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXnj1Y3HSp4MHwPN8sSyceF/lDPvyGucOnV+aiVZsH+CktMStH7SmyTQau6PUOjKVBIe/aGU5h92g7AJG2flTtYFOePDXgUdTMOmS3I59sdTWfs2JWPxs2EMB9RHN1kR+ocI1GQGDth+/biw+C6PxL0ROracyGn9qDUGCT1ljyLQ1VT/1T9Bz1tjKXjjHbeL4SzZB6R08EAV5vkJpS1pIP+AcSYV8nwS+BYpMryhbWnDDfi3aVVzHPCbcSHWfgktPHUsKU0gZLx9sUlz70ffib5HOLshdvwSYPe0r4j9C4dnmpNRtr7mhSDo1gpZ3wsBRqccFB4kurFTwXb9lQ41OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai30btIEDJWEr7TnIGJiD68wjUFjqEIugBA3e8geMRg=;
 b=T+plhzYRqgafD+Yv2QUpr9hAl/MSRBcNFYDIF5FioBCJjT4vR3ON63l9bnKFcHLREp5VRHqmOG9GtZbndzpmokySccEq5srHHULqqLsLF/OgDP0ZvybU+ddMBwEVMhzQowxrzCQu5FT8kt+OLcccWGxApUUTPWguWL6XuHZM2x5U38v87b0/W1Xhtzx/CnqmPwU0DEWxdpZfh/X3HzOnjdJBJMYf8nf1R6lV917+rQ63qMNnFTP4iHkVmKMmg8+2sMn7tSmw2hQ1BOoEfguAQwJn0fjpduNkkJYuY3KdcV6mTnLCblvr5QCR6GDnuWkQHEhJ8txpSjQCuEW+Vs4WEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by SJ5PPFF9DAC6756.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::863) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 05:33:33 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:33:33 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
	<bentiss@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Thread-Topic: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Thread-Index: AQHc+LNC6UWt8fbh9EqkhvrJgcve8rY5jwYAgADYuuA=
Date: Fri, 12 Jun 2026 05:33:32 +0000
Message-ID: <SJ0PR11MB5613EE4659912C262E950C9D93182@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
	<20260610082911.157232-3-lixu.zhang@intel.com>
 <20260611173446.14b74365@jic23-huawei>
In-Reply-To: <20260611173446.14b74365@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|SJ5PPFF9DAC6756:EE_
x-ms-office365-filtering-correlation-id: fba015f7-1dd3-498d-026f-08dec844249e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|3023799007|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: NAWqQ4oPSavrdr2AHmBMKdr+K41A6BC1l/4YpRW/+kXvEDuaSN8yQlyYYklgreKsVdkfMEUqbwuxXPbQEsLv2zOlCV1a6tDWLeQmASV9ujKhoQw3EjCmBPbvVlly0iQyKot2DPMVjpQOrcBE8cmc9tD2sgO4DnO/qT7euDmuKHEEPOMjufDb+nrluZp6YWBs2DpvYROGfXApiJtfoa+A1wX6LNa5zR3QcLCc7JbjU6fb5x9T2/YAD42PCPcauU01dU0KoPHqhSHPwqlzsaG+GsZsBn9+lcsKPu3s2dZRfWgcZ1x8FnI/sD3Xh6k84DMP9M4EosLuNsUvzSMTB+GU+mVmAcwaOKypm13MPduClArOc06IRY5FDMv4xmY9IU9TbyB8GhT/yCpjBJSGdpb03Qd768ZN2Aml4I+ehK931lYgOJjzzeyWPxdfaeEeQrZV1X0OLiLDQJ4X3Dky2swu48InsDKgKdQgB01iOC2r+e1kDwxzVfma79RZQMmsdjYJ63CoZx+sGTHgP7dFsnT8h4DWQPP5YnVdreacDJOvldl709O6uEdKOuXXZbpGL2qsRP5SuHgAXv2QNT3X681v+oqIWnnWdObF8LSD54oFL4tu5ZyX4emUrXFwh8WCvTjwpqHHj29DrrqNsPw7mRMS2Pth/GU34l/uQDHjD+EyBDwwqThdeym6J43kHx4FVC17WPH+QvdvTEY523G2ssU6uibsae0kx5CoAfTsABPi7gjCu3wQvpY/uXWaIM1o44QZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(3023799007)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ivkHZm7WteCkTVpFhlXdCUC6+Omd7F55S/FeIFeq/ZNb1/623nY9S9FZoj?=
 =?iso-8859-1?Q?rN0DeLT3cQ2ab4wNBEOCr9PxtDoddjuA9CtJTtyKIodr3bk2By+mApFymM?=
 =?iso-8859-1?Q?8LJyMbvzVhCeATGbQI4LjeN+g7kZGiVRTGmEDO92CV5uv+2C6vaxpfXcgO?=
 =?iso-8859-1?Q?gl3mpHeZS0+NdmKKrHYQh3qdnA+coxrIuQcBfLZBr6GdQM7P1SoZjypVqM?=
 =?iso-8859-1?Q?uYwCmZJvYHPmshvkyCbcn7bX+cfWVHKzKCyF4uP20Gj6xDvDlTkSTfLdSb?=
 =?iso-8859-1?Q?maq2LUmGkvV+sf2ttlkKWO/J/pdcnYkL1p2hFYujSXHm+5TEigJrLTdfbw?=
 =?iso-8859-1?Q?8QNExOKlgbjLIwiqViDxjbyesIfoiKze28o9eCePbp/aobrt12IUjsHY8g?=
 =?iso-8859-1?Q?7LT4vV0+GarFva1XNq3sj2LJz1Lqn0d7GGBFUegFSQ3O77E9KhSJthHhKY?=
 =?iso-8859-1?Q?UVXwCYU5CkuA7sxMiopLoLd5QzcmM3ZKfKHfFUUieRRe97l05fhhHY5tM6?=
 =?iso-8859-1?Q?ykEMe5TGDL72CXvDe2R3n177pkSwuAJhR724bKzFKXl5qS3RJux1HV46ly?=
 =?iso-8859-1?Q?TX8ESihTZ+Hkdv1aEJe0XL6gmv+/ogRkTKD0fNPJYPdtT9mg+8mPTRb+P7?=
 =?iso-8859-1?Q?TRaXH2aTX90yyu/1FHCmTDnMiUo9O3oLNopHUPfOQclvvwRwQwGPd036PL?=
 =?iso-8859-1?Q?ytbP3JHxM4TWTev0pUXvEFmehUYwB+GaC8TFjLS10k/u10rLIy0+CQMF27?=
 =?iso-8859-1?Q?ok89QxDUlVUOUZvtBNurz4Dk61WH/HjYdOyKJpynYmbeyybZ2nXY0HkEtv?=
 =?iso-8859-1?Q?E1wa6/OXgXZKn6CmFo7oMEY8woLDLxY2xH5V6UGWVLLH5mucYRcIvjOT8i?=
 =?iso-8859-1?Q?78ZenaE5OAj8CPDVND3THdKTHf+hiztoYEyU1wfLhJDOyDLdfPpdgYQTAr?=
 =?iso-8859-1?Q?M9UnlmBsLCgxS51ygAkVyQ3bQbTiNchCffUaXD508bDwCnTukyUJFDDAdt?=
 =?iso-8859-1?Q?9gLc+Akp9sIAEyFVoGvic833608pbwZEnqb//uEI6mwXAldDBOv8PALYW7?=
 =?iso-8859-1?Q?RObukOCXSZUJMauF7SgrcAN2Xl6judk5CeMseDUx8aYEKBoiRpGSLRh/GS?=
 =?iso-8859-1?Q?uXZ9sd4OAObIKLTCgpSk7wuo13j4j/ROaW8UvZdNtPNP1K6BLwNwtQase1?=
 =?iso-8859-1?Q?vr+ziSHRgQ4YM5OThU55ad0+RVjak/GBiRUIrMl4FpTqBic+UeXW6fKl4L?=
 =?iso-8859-1?Q?/TThyAKfOmRp/Tfzbpw3cZfZLGmlzOeC+kKAQ89aNiR3lQWHXNjXjt0e8K?=
 =?iso-8859-1?Q?aMVrSyaHh1chi0NqxjRDv4JBBjvcBrd2vPRAxOf6iXwRNriUs1LbrIi7si?=
 =?iso-8859-1?Q?8jQoHyVK+vg5KLRznR6TMjLf4H5xjX+/fHaig2WRywy9fa4rYM7eJ2PYw1?=
 =?iso-8859-1?Q?+ZbLM5N+AlvOgHgDIHn5XlyjeUe5VjU7jCdSf7hjaxO9mDsPOWdf4ROyzd?=
 =?iso-8859-1?Q?FCxF5ctBVG/5fuVgBAGSzwPu1olq22ob+QWPROaVhgO44ocFGNDcz9dX7E?=
 =?iso-8859-1?Q?Cl7WawlZuA9T0u3egZkSehK3j4vyB3HY3JeasegRgHwoGpKgivKhMxDEIZ?=
 =?iso-8859-1?Q?NG5OR8DvailgqVtLFnMxqjqFosMHSusOSyGdpIJwAfizILiRWxOhmCuHlC?=
 =?iso-8859-1?Q?2zibqMFxrZgGChTUX5N/O2H8vVqJ+vY661wevfpzyI/y63W2i0VmCFA7Bd?=
 =?iso-8859-1?Q?56RHDORSLkHDU1BJc0uljdWFHfGvsoO69nkwOoGWf+P99WqQERg2S3xMEL?=
 =?iso-8859-1?Q?QKnV/EVXRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gCN5Z5+078Y2DmKoEu1D7a7TKMEjXFXEwRZ949qB7qigs2D6Ofwmh+Um8IHOZjuOMXO4bN5HkIVUBJaHgfpdBEfoxrf97HqEl+7hWqExRlRkfXqPPpQ4ctaTEbzZLjsAygb8JzVH2mA+gPssQner3Lrld9htbuaBFnjFWKKVfGVSvSYcP9DpN5PIoDkKv59yZkX4pt0Mvg02B4QDQ3pLGtQevxfdPmheHDod0RPllWEVSIe/5Yfq3YsP+GdbC2U5Q6i3ilg9GNhNO/2H4rT8JEzlviWeZs0Pvob7PCNLa8szZJqg6T+k+Dg0YfqT5z/WeZd2z1nXUashuLY73+hXCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba015f7-1dd3-498d-026f-08dec844249e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 05:33:33.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0c9rlEag+QD8ElwftQQVh0A3LZdcj82H/1yNv/DTVlk5jLJptt0/VKRSb/U/Tu9v90EYAT+Rx6/Nwp+/++0YyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF9DAC6756
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Friday, June 12, 2026 12:35 AM
>To: Zhang, Lixu <lixu.zhang@intel.com>
>Cc: Jiri Kosina <jikos@kernel.org>; Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>; Benjamin Tissoires
><bentiss@kernel.org>; David Lechner <dlechner@baylibre.com>; Nuno S=E1
><nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-
>input@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.kernel=
.org
>Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero outpu=
t when
>reading raw values
>
>On Wed, 10 Jun 2026 16:29:10 +0800
>Zhang Lixu <lixu.zhang@intel.com> wrote:
>
>> When reading the raw quaternion attribute (in_rot_quaternion_raw), the
>> driver currently returns either all zeros (if the sensor was never
>> enabled) or stale data (if the sensor was previously enabled) because
>> it reads from the internal buffer without explicitly requesting a new
>> sample from the sensor.
>>
>> To fix this, power up the sensor, call
>> sensor_hub_input_attr_read_values()
>> to issue a synchronous GET_REPORT and receive the full quaternion data
>> directly into a local buffer, then decode the four components.
>>
>> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
>Hi Zhang,
>
>Given this is clearly a fix, can you reply to this thread with an appropri=
ate Fixes
>tag.  Otherwise looks fine to me.

Sure, here is the Fixes tag:

Fixes: fc18dddc0625 ("iio: hid-sensors: Added device rotation support")

>
>Given timing and I guess that this bug is fairly old, this will probably o=
nly go
>upstream after rc1.

That's perfectly fine. Thanks for the review!

Best regards,
Lixu

>
>Thanks,
>
>Jonathan
>

