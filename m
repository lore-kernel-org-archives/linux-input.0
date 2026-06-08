Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B1334C2E;
	Mon,  8 Jun 2026 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886801; cv=fail; b=TtUSDaRJaz4n8DsFtSYlOD2GCYi8PDz/T3TJQSuPJt0xsnDMr5wI5oW+tlO19MgQIT1kQ0wv2gt2nl3F6QI/8WgaWdNn6dFkYDRvoBAjTb+W0eyV3rgn5B6Plc7CtxoBMjK4/BSypN/KbbE/146I1d2wKkxhyJtRn87dbOpdQ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886801; c=relaxed/simple;
	bh=R6QdejsAoMJP/Pd2FOOVKLFOkUr7otCF99Yy+w6svOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsjiFf3RaHcychdkkB2x7ss6XZF+k21opcwr+nU+puU2qtIU42pahKyiuVISaV1VF0Zpp/YXqJf/8AQxdcOFB0BCkKnIiBxtRNUU5gshDQK9oAXi0ghFMUZ7JeFavkKfGfbo8eVLZf6S8jhGpUbZXlPaFKREmAhainh91kdvUyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9bzaXE0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9bzaXE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780886799; x=1812422799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R6QdejsAoMJP/Pd2FOOVKLFOkUr7otCF99Yy+w6svOY=;
  b=A9bzaXE07HhDpjj8BYi4kUuPzxbvJFnQR+bmjHLFqBfS9tAAzR7tS5AY
   AUVy08y3enyJIVea+egVa7hwriknbH8qzyrKTn3AElWYRNsvx88j2LJra
   muXvYlOzaplN/Azwms/UX586AOorbYntfrhLJG378vbqBZIZCKnWQDjW9
   58ALWVF6wmRixvj02XOfQjWlAX87AIiyrMRjj+DzDttcaX24+CHnAPL0M
   ypkovK4/AUOpxPaKnEHju4EAroM4aR2fMXq7t0R4GBbK3LivK/ECN7+Z9
   omqg1r5TBHYeTx/uVoTAyJdDs1DgiN/Z2ioYIFsaPmfddC4UsH/5+Pjc3
   w==;
X-CSE-ConnectionGUID: G4VH6ON/RcGp55PscSlSmg==
X-CSE-MsgGUID: EUP8CHgESciTlcR70VNHZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85241358"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="85241358"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:46:39 -0700
X-CSE-ConnectionGUID: TGOCCeIiRze4CJUi9dSKZQ==
X-CSE-MsgGUID: Rcm3kXijR4GZw6hWkGHb3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245466084"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:46:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:46:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 7 Jun 2026 19:46:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnk2d0XgIaCKj0LnLBBaR3+NIBAKFwhwDfDbl4EocLNxm3qMigwchyOeAWvJA6s2WWG9ieMhwtLX5+4Gcdm/WvRL5nzQV/f36T42NJqSwN6pu9RjKvEWca7QCnwaRAi5RyRbi+5vpCSQJ05sN97ppvWWDEc3Tu6yob7fDftzb7pj7TCCXg4B4m72tYedZckmpY7scmpkJyjZF7mQKJ20wwYEUpX2GMOOtyBg/voRj62lkAd4TZo70I/oImqVOEHeuy4CIfelduqK6gEEbBcFaQ5v52h86hEUYcoaMpkN04FJ0/RSmvBHBZ+NEFwkIQ+UmTjWiaCJgkDpyT19fETOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ske4fFgiCf2i6jFtPLo2DYxVhTVoimwKWS78FKn8PAM=;
 b=TnJ3UgFxmoPeXoBLb8eZ/xpYMtFhKavbyNDWok4MkQBU0xNhGwfm6yGcnrbAWPIRK/zI3BLtC2V/WBEaWqKW3Rc0J3GN4bwb/aSdpzr+DLjMliJ1n7M5C/WI93DehBDv3JrI6jl37DlfunHPZrpsaQKnZYhmJi05QzeZDrGrfX/YQq8rKwlihjZaYt0c9jNk+VgnR+sM/daN6bstt8tLQBV2vjyTHaJHLISIgrypYDLaXuiJQkqD762ktaDOdAHbEJtd7pZZ046g5JVWrfnBwOcFm1/X6oaVXa8/lwzy8YQ1cF1y7e1gkEF0NEkPbDXhdGkNZa6E2F+fueal7B+brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:46:33 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:46:33 +0000
From: "Xu, Even" <even.xu@intel.com>
To: d3z <d3z.the.dev@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"abhishektamboli9@gmail.com" <abhishektamboli9@gmail.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Index: AQHc77mrUbJCsvCWBk+2B+n2qvQl/bYpBmKggAAG/eCAAS7+AIAAuevggABu74CAAQWkIIACdp8AgAUgSoA=
Date: Mon, 8 Jun 2026 02:46:33 +0000
Message-ID: <IA1PR11MB6098EABFE876D4D6197443B6F41C2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260601213047.115271-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260602151317.27768-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60989CC8623B35747E0EFF7EF4132@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260604202647.16777-1-d3z.the.dev@gmail.com>
In-Reply-To: <20260604202647.16777-1-d3z.the.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH8PR11MB6562:EE_
x-ms-office365-filtering-correlation-id: 54c1783f-e8c5-4b63-cf0f-08dec50826d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|5023799004|11063799006|4143699003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: X1WESmtLhtBj2JX5kwjN4wieOWTsoWFZjvt7UPZdB3uJlKaI5sHc+B7tun7Ga932rykjrBv4jdUq06GHOYgecCaUoEos8PZeQ1CXjWlbIk/nQaStAn/Jfo75IH/HUbgj+rCekqVMsauK7PfaR0SgbwmxIqG9u6Q72NTeRQTwteJ0PJ7hU8cX26DneCmz/ETZZ74nlqmEZ1pHrm5zLYqxZVleWJVn/l3v/0WOrUkapxmvWFTGpFkCj2sfoMWMuDErxjLN9yvR9sVoIQM4lxdagcbDtMYwSYpX/Qppix1bpFZQQygJ6p/DREMEyroUR/Ygf0JQBzT6eBv7CSHZ9LbDOQeAPw4divVdFit7snerAXI3zAjGQzTaN6VbdhZjQszNDX7sWmiZiqhFAaegM5jzutV7VUYQ/pmxrWL92dNaC2kGuMyOWFWIGI4XyptB75EZXcO53QYtKC0ghhMJatWh0fe2y5hUzYf8sPAO2sGsZTTej6c55wEZLisr41FKnRWYwmm8PVYtws+zUOX17m7X6uYL6cI35YZj+DcSg5GkqNkUbZT6vEFzTSHsn7WEw6NUvX1RxVSbQfGaGHKdYqIegjl+paJj2kBgyXU/VtVS2+XR5OXeYtP2YDbWQzUmAbpgnS7E9B4PRvTb7Egmu6/zsNmp3M7+tj7xt3fzic04s3NY3U5QpqiZnBMonikG7kFdSW8YmAFM+7WCBzfCLFj/3NwOLMD8FAzMB/+Qh2Myzqdcw4G1fS7FC8wPqvFn/hqM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(5023799004)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mBnyhC+PZKrcN3NGJVukD/dPUBW+dUgYD++rOGJfSwawFFM2a+416AempRcI?=
 =?us-ascii?Q?OnY8TQnNR02mh/oOAjJJADt9zJdrdXCVJLDpRVQP02qPAQAQYM2aMG1q24Tw?=
 =?us-ascii?Q?9pAM7FSwZn6v5Ne8NEn4d/or0C3UgAmtgXD8sN1pmcmUTOEWldUUFguRaFQh?=
 =?us-ascii?Q?sofq0W/B3swhaL6PNyUkzMoRO3GH6rgEPzcOva/tzzBx4AvG5SlyncrhGPvj?=
 =?us-ascii?Q?73cFkbJA1kUDxxCHwzDJGtSjkeh6yRHeV+VJCS3V8QDpvpUrY42/1LwGPFkf?=
 =?us-ascii?Q?mW6p/B/9PJg3RDZ2C3b1PjscsP4ZrX/y/lmHAH4RcDsLdAtoGWui527MvzAv?=
 =?us-ascii?Q?MsqkKUG6p1B3nfEOt42LiQR2TWK7iNeG/ewowkIi5Wmh7Hjlidt9yab8HYGx?=
 =?us-ascii?Q?nhrFLtnI8CldSrsa4KgO6r5Ap7A6yeDBqvqAIBRllelNRndFYlWa1F5yfuvi?=
 =?us-ascii?Q?nJvVgZ4rnK8fWxfQxYubaHAicRguTLF2f6b8mezP7dp9fhPCUZZwa6soSsFY?=
 =?us-ascii?Q?SgGhs5IdYt8t9qqXSbsrTOIjzCZ8icnjCX6GIfNklhjKrGCOH8U6eHcWNYAk?=
 =?us-ascii?Q?foC9dgITs7WvoIIb7qyS8dH3f6yRkg2oyYBIP/CVE2tKCcuJ5kJh63zZGcZv?=
 =?us-ascii?Q?ZpKQRbPcGp5IL7HLR9vgRQLBmvkd/hJrbjbtlt/PKMp5COScwJPxM/g0MlBu?=
 =?us-ascii?Q?BYxGESiAKNtc7MWrmQ3ztBc0r05f6l+BPDNRg6uXexyXknfe9nxLUKNPMjjY?=
 =?us-ascii?Q?umdnazO17nv5kpzFAqR527PF29X+/2mbXae3pGZ54fXu0pym42gB8EoDoZX/?=
 =?us-ascii?Q?fcefoSgRhnr3qnxHPVTd8K/ufaC2N1EsXilMbimEPI/AdIGBumM7LLcISZNJ?=
 =?us-ascii?Q?a7Sn2EsVVJmVeRDkPxmYvWZEZ4r7ax6szL99+KZINYyVnlVNBWNtsv+TkbNE?=
 =?us-ascii?Q?uWxztZpnYVqSmUPMR246I06X+CXIBHvAqELNLvTXMHvdApf3r5a9hOrecp3s?=
 =?us-ascii?Q?AA5ot2r9p+W+tJ62Ko2lxGoorL5IGAem+93+knbEv8yOsToYiYLuhLPChhB4?=
 =?us-ascii?Q?DHuY5niyqhEUQGBWFlUhddtcAnTevG2nzruC/GXn1BxkzEUppJ/NyopHOmP6?=
 =?us-ascii?Q?p467k69sAUPHARh0cYvrLgzk0af2d72xzJziLmRAabNB3WI2hijb5lY8e6NI?=
 =?us-ascii?Q?gMh3Ej2ko9nsX+u/uvFqw7KSwcxTi+0tIJ4RjM8cy2z7kjZoNvUSmr4Fz0q1?=
 =?us-ascii?Q?mt3267q6taO+dFWbR7/N5OA71r1/Za9OCmmNcfeuwjMk1XHWZAYZZxgA0n2E?=
 =?us-ascii?Q?19oj6seCprSWwyxIAa+4k5FTVKpZCwvN+Qn6QZktbVgIBFXYzS9UJYfVSlWs?=
 =?us-ascii?Q?i4KPD1cXPxvjX2y4V88kqKFNC5tts2Gxg8Am3vfPAIqdHrLt21vkbIrxrJXM?=
 =?us-ascii?Q?+d2BxHUWoBCBc8FETOxVBSufmpWJpwCGEz5KOEvNkfjiRTRQkJYSMSkYqHD2?=
 =?us-ascii?Q?z/gyMJIgpPpLXOQ8All59mqsuVMviI/EUgqOAXqkwtSoxCR+fI2YfdV+1wFG?=
 =?us-ascii?Q?VHeGbGSJMI2xGqmfhouu5Te2EafGH4YgpAG5dKyk+YwQZ6Z5fJf1X0MbXNbQ?=
 =?us-ascii?Q?PqYkqN7ze+pAQz7XD04wdGkADrzjcBgB+wEVtuCi2LB6hTAk6PpG3eKbOrry?=
 =?us-ascii?Q?xL5EklGPow63STNJLCxGngVcq/UR1dLHDxCJoN7YS57gAtz5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L06thiCVGpK7ykwrLGpqD5f1+CbZl3XgjLE62VeRPdVxkmE0Y0i18FDbrJfUJSk0A3iVVW43317DbbKwVO+NHanPJwNPJtYFWGi5mlPxbQ+DlNz97f04aA/cMgylo2nKDjpmGJY3nD+ZZuB49zGrRpIH/z83f78T17+HiwfM1Ub9EHysc64gclH8sSOYP3emADiRdaVlTYD8YeYNf72RMSOHY0u9jrd0xfHIlnyN38jSYFg8rEu0Apyr163oCAiu2edJ1CdHGjSP73PSJh82B4vW6NdErpG09PCaJdPhutDhajPBXt8DHURs4aoL4qOCcWCvzzFixDJEOluvF2yCVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c1783f-e8c5-4b63-cf0f-08dec50826d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 02:46:33.5232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWzBIqyh/zkWzTys0r+Ok/ozVY7Ruk61YHtGqPVse3J0ZYGluuQjeesxm09FfnWZJDIyS0O1eR+KCDKNCJNEWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com

Hi, Danny,

Thanks for your patient to have some many tries.

According to above tests, it seems Surface Pro 10 does not only power off t=
he TIC but also the THC for suspend.
Then your patch is need for this case.
I will add my review flag for your patch, thanks for your attribution!

Best Regards,
Even Xu

> -----Original Message-----
> From: d3z <d3z.the.dev@gmail.com>
> Sent: Friday, June 5, 2026 4:27 AM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> jikos@kernel.org; bentiss@kernel.org
> Cc: Danny D . <d3z.the.dev@gmail.com>; linux-input@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; abhishektamboli9@gmail.com;
> sakari.ailus@linux.intel.com
> Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC o=
n system
> resume
>=20
> From: Danny D. <d3z.the.dev@gmail.com>
>=20
> Hi Even,
>=20
> Good catch on the missing state restore. I rebuilt with your version and =
re-ran the
> test.
>=20
> This is exactly your proposal: reset_tic() after thc_dma_configure(), the=
n qsdev-
> >state =3D QUICKSPI_ENABLED, with no thc_spi_*_config and no thc_ltr_*. I=
 built it
> as a module and swapped it into a clean linux-surface 6.19.8 on the Surfa=
ce Pro
> 10.
>=20
> It still doesn't survive s2idle - touch is fine at probe, but after one
> suspend/resume it's dead again. This time resume() fails outright instead=
 of
> coming back quietly broken:
>=20
>     intel_quickspi 0000:00:10.0: Wait DEVICE_DESCRIPTOR timeout, ret:0
>     intel_quickspi 0000:00:10.0: PM: dpm_run_callback(): pci_pm_resume re=
turns
> -110
>     intel_quickspi 0000:00:10.0: PM: failed to resume async: error -110
>=20
> So reset_tic() can't complete here. It clears the reset handshake, then t=
imes out
> in quickspi_get_device_descriptor() and the whole resume bails with -
> ETIMEDOUT. The device isn't a wake source on this box - "Can't find wake =
GPIO
> resource" - so device_may_wakeup() is false and we're on the reset path, =
as
> expected.
>=20
> And the timeout is the THC, not the touch IC: across s2idle its SPI input=
/output
> address and read/write config are gone, so reset_tic()'s descriptor excha=
nge has
> nothing valid to run against. Reprogram those first - the
> thc_spi_input_output_address_config + read_config + write_config block, s=
ame
> as quickspi_restore(), same as v2 on the no-wake path - and reset_tic() c=
ompletes
> and touch comes back. That's exactly why
> v2 reconfigures the THC instead of only resetting the IC.
>=20
> One more platform note: the SP10 never reaches S3. Firmware only offers s=
2idle -
> mem_sleep is just "[s2idle]", with no "deep" entry to select - yet the TH=
C still
> loses its context across plain s2idle. So a reset gated on S3 would never=
 fire here,
> which is why it has to run on the ordinary resume path.
>=20
> Thanks,
> Danny
