Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A41494A8;
	Mon, 15 Jun 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530610; cv=fail; b=jP4BK41rNtq3nrhV9vKIBRkKgxkHku962EppBQg/eoKM7sK+anphJ9hidRiGxusULAU/GFNmaLEC4tX4MboVtmaq7nej2wiN8sqpB3YoWQTPRbyO2pcOEg/EnK1hegnCMJgR+lZ58wy7Ek611m3Ktn9oFc3gRLUlVwVvB7OfByw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530610; c=relaxed/simple;
	bh=GCf+yENDP6grLfQ6PzDrcyQoI8wOxz6tPxM8doPW3jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jCNsOiQ675oqbcurkcclLXg520deDIYV4hMdm8wlOF1QSvEAbsKTU0nB+ICgiQy52KgJkpL0qwd5we6W3LXxb5ZYqBt6X4LCbJFBoPoGRAj+LdW2R8M33kiM3a8AIpOdedSIxIL2YmRtCMnrB6qTAYL+pTK87fKdZF4ALYygRis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlyRWHcN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlyRWHcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781530609; x=1813066609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GCf+yENDP6grLfQ6PzDrcyQoI8wOxz6tPxM8doPW3jY=;
  b=mlyRWHcNMNKesL8H8nnfsUUSmXnjEHDWVOzRt4SIKefBN820nLhmdSBv
   abZEHSw71EBxlsAREyokdefhfDd3VPAlkdamsjPTgkmg9AFpoBGDZr7Ku
   1eDIX6+M9G7fxRP/xJhNdO8HKe6W+hog25oNLnZvJAPWhzEFTnyHevQjE
   nl5ylnqStaI2dz4LnbOq3QVpe6IlahXe4hfrzm9Xk+AyBZq/ggID83xr+
   CchAkh4PGGl4U2i/RoU512JS95d87FQkzCP5HubE759u2GYEGWVLI4nFf
   SKlzvyR/JFEmyowLTiIq3DbH0h42oyMhutJmY1J8CH4maKIAzijt09t/S
   Q==;
X-CSE-ConnectionGUID: F0l5GfAVTmeRGN+Oho2Ibw==
X-CSE-MsgGUID: M2gUIeuARDSuSYVWuWRxgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92941273"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92941273"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:36:48 -0700
X-CSE-ConnectionGUID: 2/U8I0fyRpy9U2XG6Irmbg==
X-CSE-MsgGUID: pZRSvtfeQrWFOn/kV2g0gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251394988"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:36:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:36:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 06:36:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcG9Ubclvs+APJYSkiJek1Vs1b7kRorPOYo8N1/Fddjuysi5Xxqp2r1icOVBNVERR6Uqbmi3LiA9SoZJTX+AJQJb/QXcuoDITrx5ODmGYa35/OuNFlhNMB4gnL5A/S3dbXPi8QAmrZWsdFlkx7MNRFbz86wPtXDtKuQ9wDVmodkEqfHkgjBXJzHsVAlv15GAwq6vi5mnmxMOW6uMEzpuLb/lx0wSHzJUlKFSqP37hlsnVQi79PnM6dZMfJCcnxzcfI08PqgKzeaLhvPDRgfKpYlSHwmANMukhEwRx3/Vyb9TkUElYUF+zGsvCIHepuYNuEWmc4/GPpEnD3RRIJQjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCf+yENDP6grLfQ6PzDrcyQoI8wOxz6tPxM8doPW3jY=;
 b=ZrVQ8dlD6D8N4FZ9AYOz/bC1Eh1kkEx4NCiBk5+Cy8QE40ftIcobeePG8fWcNT5ia/+9hbYy4PJwCgZeTabjF3BsKx2cQ9V4KxiJqniYX/gzRp04pVMO0jm/2hwhXfTgtEjAuViIAVHTpixZVx1gb2E8DU5UceUQKyzqfGb9wmNz9+d6tg0qbHMFDyg9g+ANtFBtqHxOmEPoRYbdRBZxbLIQ3OqDWy+bTTPiaLTyBwNx0FZ0LC6AACXtAIF9bl41FngP+NkoAS+e3CtiYyV5JIrL1U/+yF90wVt/CdIDPEfUxzDQGRXcKbqB//K0ICWmpiFs7EpTG+rRBgZek0Zvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA0PR11MB7751.namprd11.prod.outlook.com (2603:10b6:208:43a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 13:36:43 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:36:43 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
	"hongyan.song@intel.com" <hongyan.song@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "sanjayembeddedse@gmail.com"
	<sanjayembeddedse@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Topic: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Index: AQHc9ajtv0GfRdo5hEKCZI1S5o93iLY0zScAgAmdqQCAAUHeAA==
Date: Mon, 15 Jun 2026 13:36:43 +0000
Message-ID: <50ce20dec63080dde13336c6af41c0bf4de43426.camel@intel.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
		<20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
		<b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com>
	 <20260614192442.6eaa1a54@jic23-huawei>
In-Reply-To: <20260614192442.6eaa1a54@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA0PR11MB7751:EE_
x-ms-office365-filtering-correlation-id: e4bc3651-9ac3-4d82-bf06-08decae32388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|38070700021|22082099003|18002099003|4143699003|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: cvjTW7MJnbMZe/QQTejbfaum3LXUzYRNXbkqLigN0eGakD7fueMmd70gzAIJmOVP6LEy0LaoUoL2cQZUjfk1rGAsQ0odWz0pOSRXq7FSmOe1cMSQJAgnmxj+/kw+xhBrm+CYo8EA1X+mWcrtyq/mvkmarjilO7odNXK3yjrtpMwnXC49GcjeXCc1i7xPGwOh2oVhx5+FrzCNHSGQqlpZP4DL/oYv/amyZEHur4aS6TSsEvxdrr8/Ten9nva2rIGEunwTntRvI+LN6kC0L6I5x6eiAGAxohqVqy6ILt9iGLZJQwLUKw2Ff7FEcoyPDIxH87odPfDZzgdWyUrFwd4Rbtr4Ii7watsGT8ShWCNbtf7ZS3HGgyDKKNSGByvNBNAsNbvKddybI3KrpNB0w/dIJw2qpfy+4o4QhoFHVeAuXvnZGlP2+EXwbZeyLV+A7RxPx86sraZq6KsgHCGH6zJY04B2RaLQ1kpKK38chRaIrsUw7GefCHrKQOjHy84HrwMwAAgyFzEvW3XhOMZl0RTlYIfXtuG+fEoHwER/DMgoFtDkqNEa6FZYIdHIOu38TMxwNd9Zq2AI8d4ZfXpTvZolfP/dNY+kMS8A87BHk5ox5jIbb/WhZAHb2U0+W4RFJwZf9i6jIXpDXjU8UnYl8xmUPMGj+FotjqG9mi+bO+eOIEvE34QzrqARALaiDUnF2MLzGDKPpAOxDcg/rmSOirqLexpuHU+xemjE1wA86TeIy5UWbBZsRhskyKRQ4g5IWheY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlaSEhpRFFDRVNONk9aY1IrOTRCL1dPV0VXME5TdTdVZFZibG1Nd1Bib2RD?=
 =?utf-8?B?MWYvZGtnclUyK3ZzNTQrMGJzYXFIQSt0Z1h3bXRNL0xJeW1NUXI5UDNxeGto?=
 =?utf-8?B?dGtvVlFNSkIwaUxNTDdURW1FWjZVSXdDazM5ZmJHekhBOUE4THZ5KzRnRFBi?=
 =?utf-8?B?cFExbXIzYjJndGRKOE81MUlnUHhTUDlSSlVSRUlUYVJhRmNLRjBicWJTejVr?=
 =?utf-8?B?cEgvajl1MDVNVjcyOUFkUkd0L2RaM0lUUXB6UzM3ejdvSjdoV05TQlFRaWJ6?=
 =?utf-8?B?Y21yWUpaRXdScnNzQ1B6eEt6djl5SHVOWTd1SFVqSUN2eSszMW9DcFM2cHVQ?=
 =?utf-8?B?YXF4Q0FZTTBvVXZ5UEEwYUZ3aURVdTBsMDFSRkJ6cmMwdXJVd1NCdnpJMUhX?=
 =?utf-8?B?OWtHYXpRc2hDSXNWL0YrOEZmOThyeEQzYWM1dWR4ckQ4VGtTQ0VXeHh3MFFT?=
 =?utf-8?B?NFU0dmxzcFFKeXg5SktPSTRyY3h0RlN2VjdlTGZrb29lczh3cWpZdytCdFIy?=
 =?utf-8?B?NjR2MExkcWxkS2NIdTNsSEFPWG96U0FvRE9pNWtLRTRhNE9rRG5lUjFaMXIz?=
 =?utf-8?B?eHhKNStlc1VHTUk0dmd1cHJuaHRDUUVmMHU4R3RlMnRKb0ZhMDlJZW52cjZL?=
 =?utf-8?B?QlJQTERiamVyVlp2dytjSm5CaVZIUVVwNG10UmtBajExUm9ZcFVCcHpkNU5T?=
 =?utf-8?B?MlBIQ0tWU2w1Uml3TTVDeVptOGozOUR3NXdLaDhUbUg0ZEs2Q0ZqQU9SeW93?=
 =?utf-8?B?cmdXWmw1MW91S0VzRFhSS2xjWVo1cUtEUFFEZTNnaTlJNklsVWRSL2ppTERw?=
 =?utf-8?B?V3FGYSs4OTQxQ3NpTi9jN2ZseFg1WENHaGV0SjhOUjlXcmlZaWlYOUoxbFBW?=
 =?utf-8?B?QlA5ZGlKUXB5SjRhZG5MUDMzTnovN1RaVldERC9LVmR0VWMzaEQwSkpLNXdG?=
 =?utf-8?B?VW9INm84bTMxaEdmb2FVY2NlNVdQMUxURHJSQzN5VnlnekFITUVScmE2RGNS?=
 =?utf-8?B?QndrbUFubW04R1lVUkNqZzBVa3BGZkloU2lnZlhWWWJsM2hmVjBOMXBqRUtT?=
 =?utf-8?B?ZndjWjI0ZE9kd1d0U09QQndpRHpWZ2U0OGtNN1pjNzd6MHlLek9LaTM4bkhC?=
 =?utf-8?B?Tmk3SUY0RGlpMTRrOXBtWGJKdFBDcUxWUmNySEJrak9PcjV1aE8wQ20zeFNt?=
 =?utf-8?B?TkU5eCt6YVVtQm05eEVlN1hmRThxZGVWWExjU2d2b2JNM2E1YmY2Y2lRdmtN?=
 =?utf-8?B?ZXZtNEEyOFBwZEZPL3ZReml0SU8yaGlTV3Awb0hicFJia01ZN2RFd25MRnZP?=
 =?utf-8?B?NHNDSUpubitwRDMzM05SQ1EzeU1HazUrS1E4dGl1eUh4SDJMQ1NDaEppdTl5?=
 =?utf-8?B?REMwZ2k4T05zcitOK0ZJcUt6Q3dLWFg4RG85VHQ3QVV3akRGNW94TU1Taml1?=
 =?utf-8?B?N3dMNlcwSWhUeWlOOTNBbDEzNUpiMFJpaVJLVkRDaUxzbGx6Nkx1REloZTQ4?=
 =?utf-8?B?aG5McHZJaEozNWx4VExDdE5kZkthSS9aODZER1Zod2JaMzFhVjhESitpd3M2?=
 =?utf-8?B?Tm9qN0tyY1hIZkozbHp2elJaSFdzMVlxWHpIM0JIVGZWUnB6QWJhYTM5R0hT?=
 =?utf-8?B?TFlZa29IV2g5czVqdWZTbWtOVjZISy8weG9GOExmK1dIOUI4Vnk4c2pBV0VE?=
 =?utf-8?B?TldZQUlEODFYZzhkMmY5Qzd3TmxacWppVDk4dGhqY2JreitUdmJVNHh6b3do?=
 =?utf-8?B?dG0xUXc4MnBiU0RVWEttZW52Q3BoOGRoR3QrVWt1WGh5RnVrMEFrTEJoSFJK?=
 =?utf-8?B?Rjc1MTJEbUo4L3BoRlRvSWcvV2tkZGNBcXdDdHRoTnZPa0JYZkYyaWlBaXI4?=
 =?utf-8?B?VjNLL0hWTytLS1RHcUo4Q2lLeFlPWmRySVBBNWVhWDF6dHo0OThSMkRiN21G?=
 =?utf-8?B?WlIrd3dTbmVvKzlrN0l0VTVkTVpxNmdSWWF6cmdSSTVFZlF3MEVVd01SbDVp?=
 =?utf-8?B?UzN6alJQQUl4ZW5FcFk3RmR1aytuaUJEOWxEamgvQmtFTURNOG0xNHMvdFhU?=
 =?utf-8?B?OXpMdTExMkxBbUl1Q2N5SUdpak02dGlwTlUybU9CRTJkRTVPc0FFaVNTSmph?=
 =?utf-8?B?UUFQczBEV3V5ZUhUMGdNbVN6SG1TV2pSYVNucGFPbVVQcnFGRWdkblZTemdG?=
 =?utf-8?B?amcycDJUNXpIeHdHQTgvbC94aFZtYUN5ZlBObVlQSE5xN25TU1lqUjQ0V0t5?=
 =?utf-8?B?a3p5RXY3OVRid01rQ0Q4TlFTdVZDUDl1bGVpUGo5WWkvNkozcDNPOHhjRVQ3?=
 =?utf-8?B?a1BvOHk2Y1VPVmxKY1B4eTArU0pCMUpPQUlIMy9Sc05OVUgvbWM4R1VOMUU5?=
 =?utf-8?Q?EKK5BscHT6sRMDO7hjwpks5Xm1hpD8EIk7G54?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1F85C65171826479050C3834208E451@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W9C4z+gXA3P6sbn9NlcOTELO93+UnWic2IBqwFlkK4OFrit2SkkMTzkPW2oFdJIPWxVx8HM409KncE9ageiZQojfDmRp3Uzq1vnD8T3Fg6lCV0+JEC28vCDpcnY9iMTYT+9p0+0jjuiGYpMR+5m+MjkhiELMgmJxPm6K49HEyK0NculEOK2iXtGR6Nxp3JuKcQM3PFZig4UMgNqNaHLOlWu5xFNiXNBCDYDSnVB4sEbgLnSGCKYyeymzLhzcBj16dsj1vibdqsL+QwxBwdV1lpY8msJEiOLZEk2cRWe9w3vW7v7pH4d4LwT0t+CH7AhJeSyyDhE6pIzB3zMXfhUYbg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc3651-9ac3-4d82-bf06-08decae32388
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 13:36:43.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqQOwbPpXAiWad0fJ1fmO0xZAOzxfiemIMZCDLif8FyvqQlfcVqmx0s+picPv7yS5AVesdlW2GmXsd3G7C4mx+iQq5CMJKToEHeKHvtsSmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7751
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA2LTE0IGF0IDE5OjI0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDggSnVuIDIwMjYgMTU6MzQ6MDUgKzAwMDANCj4gIlBhbmRydXZhZGEsIFNy
aW5pdmFzIiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBTYXQsIDIwMjYtMDYtMDYgYXQgMTc6MDcgKzA1MzAsIFNhbmpheSBDaGl0cm9kYSB3cm90ZToN
Cj4gPiA+IEZyb206IFNhbmpheSBDaGl0cm9kYSA8c2FuamF5ZW1iZWRkZWRzZUBnbWFpbC5jb20+
DQo+ID4gPiANCj4gPiA+IFRoZSBkcml2ZXIgcmVnaXN0ZXJzIHRoZSBJSU8gZGV2aWNlIGJlZm9y
ZSBjb21wbGV0aW5nIHNlbnNvciBodWINCj4gPiA+IGNhbGxiYWNrIHJlZ2lzdHJhdGlvbiBhbmQg
dW5yZWdpc3RlcnMgY2FsbGJhY2tzIHdoaWxlIHRoZSBJSU8NCj4gPiA+IGRldmljZQ0KPiA+ID4g
aXMgc3RpbGwgZXhwb3NlZCBkdXJpbmcgdGVhcmRvd24uDQo+ID4gPiANCj4gPiA+IFRoaXMgY3Jl
YXRlcyByYWNlIHdpbmRvd3MgaW4gYm90aCBwcm9iZSBhbmQgcmVtb3ZlIHBhdGhzLCB3aGljaA0K
PiA+ID4gY2FuDQo+ID4gPiBsZWFkIHRvIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZXMgb3IgdXNl
LWFmdGVyLWZyZWUuwqAgDQo+ID4gDQo+ID4gUmVvcmRlcmluZyBpcyBmaW5lLCBidXQgY2FuIHlv
dSBzaG93IGhvdyB0aGlzIHVzZSBhZnRlciBmcmVlIGlzDQo+ID4gcG9zc2libGU/DQo+IEFncmVl
ZCAtIEknbSBub3Qgc2VlaW5nIGEgZGVmaW5pdGUgaXNzdWUgc28gbW9yZSBpbmZvIG5lZWRlZC4N
Cj4gRm9yIG5vdyBJJ20gZ29pbmcgdG8gbWFyayB0aGlzIGNoYW5nZXMtcmVxdWVzdGVkIGluIHBh
dGNod29yay4NCj4gDQo+IEl0IG1pZ2h0IGJlIGEgdG91Y2ggc2xvdyBpZiBzb21lb25lIG1hbmFn
ZXMgdG8gZ2V0IGJ1ZmZlcmVkIGNhcHR1cmUNCj4gdXAgYmVmb3JlIHRoZSBjYWxsYmFja3MgYXJl
IGF2YWlsYWJsZSwgYnV0IEkgdGhpbmsgdGhhdCBqdXN0IG1lYW5zDQo+IGRyb3BwaW5nIGEgZmV3
IHNhbXBsZXM/DQoNCg0KQ29ycmVjdC4NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KPiANCj4gSm9u
YXRoYW4NCj4gDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFNyaW5pdmFzDQo+IA0K
