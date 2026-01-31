Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3619DF8D;
	Sat, 31 Jan 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842019; cv=fail; b=gcf/lrt03GMtWdtdZuLviD8Gfk7BH2gg3wPxfuI9DqnH67TazVTwRuolZnmyWYliGlUksLnK/NcCL0RhWRwsRjLYgGJGA8dE410QzxVvTdpif3McA3haGQukFW+vs4K8mk/x+ZKfFgIwfcIHhivCJAaxUU9Nw+AlLo9ko79bEbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842019; c=relaxed/simple;
	bh=SlD1Nnp05y91nco5oOMsZl41SGR1DJHc8E4oN+hV5EM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgK3m6yiZ2wycOGmxMohdQ2UwhsHCJ+yAkAX4VL1dMtCsDs1SFFhsqS4iMUUzbTN9W9WFgGd9xF6T9C0XZolCAcPqumlvNLuWSQ9xfl6StGECk1/oShgUM3iX7u/8d37Tq9KlZhc4V0v42bhHxiANAXn19YdREitOIpbtIHI6zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtUzc/3C; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtUzc/3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769842017; x=1801378017;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SlD1Nnp05y91nco5oOMsZl41SGR1DJHc8E4oN+hV5EM=;
  b=OtUzc/3C0TkyjUTx0Ic956AUxBv1LZjYqRTOIg8JTRx/mNRxTZR67Ylv
   qTCvncseAFnVsfbVMiOAzqY669+XXicWLbD18/jbE6vBtmNANok93VDwS
   5mwhSGHYQN4rtQuix/3cpeAiujz4vQB/CWn41dTB24LGrqX7BlaWok22B
   Z8eTZ/wc+mecjRyEdM6A0JBgzEHqXHaXrcZ4IOOf/Zstr1/QDxd+9zG01
   cPEakALdiXAl0ouw7nYZyFweK+T6HxJVFWFluXpW+Pu2CQiOyz3WtiKnH
   AO93JiWgGWi7Z9Qs4/W8AsbSsqvWjuKdBPxF1d+kzCEojiBxRhi0Qkzme
   w==;
X-CSE-ConnectionGUID: GNkHnDz6SgC5DEaQvkmxHA==
X-CSE-MsgGUID: 2XUtKp6gQ++25IV5N3eKcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="93741483"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="93741483"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:46:56 -0800
X-CSE-ConnectionGUID: T09c6cPUTyiKfNUE6Ps9Tg==
X-CSE-MsgGUID: C6QkcqU6Th+tFRhwuWuYdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208829449"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:46:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:46:56 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 22:46:56 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:46:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTIx9x2owQphxqEewUANDE/hT9KaUWHZBRmUC9JGSH4QY6UiswfFzI8LX6JrFNDm1gcF/Kf24BWUrqGyCoK9UibcsSM34AhevU7QB25471Cr/wsCdOyDfCkeqL1FBz4DNSTbnN/cnNxXPP601dFNVXNraCjRySHLHu9mGWMueE3sizJiznIv6a67/2G+iVk5CsUfDecWC/9CDPf3XISWT/IB8P+7dQbf9kbWvMeLpnS87bFDBODoxHvDLT+v2YZIE95EUaF/gj4a5D3U6KjGskvb7qtWurhWR/gpCzr5fb0HKt7ZVFzewcrOg3I/NhY3KxoimoDxr1mAshUUe6S6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqPc5yqOeHd5mU+6QCv/KRK0GIDFm4xuSzt8naZXUHI=;
 b=F9Jb3GvyLY2BOSqVkio3zv9QGlWSPtqOp52O509vASLuwfKhtcc3Jz6CG+nbBmodlxy3gpjUbR8tAwC3evVXhtlM0WWWvQdPGE2OC1N6djY4Olu0nmp8vbygPLPXby4qLSNS1YAEeZVt6pZfmSLyNUz6fMev9D6IFRT/bxK8j9gxt7iHyGVKpalTvlYRAdovn++RkIZImtPqLDn+6xp0zJobYgWOSJ1Nd2x/K22jQ6jhtdCWQisk5Ec7Yjk6Ku8Na5NN4nP20nNGX5w1UXBPsxo11uh4BgHIdb5azlyGzCmSE5VcUooyOXxBr+DUdDlONWlYdx+oJHG/MN1IFxYy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Sat, 31 Jan
 2026 06:46:53 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%7]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 06:46:53 +0000
From: "Lin, Ryan" <ryan.lin@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"Zhang, Lixu" <lixu.zhang@intel.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>
Subject: RE: [PATCH v2] HID: intel-ish-hid: fix NULL-ptr-deref in
 ishtp_bus_remove_all_clients
Thread-Topic: [PATCH v2] HID: intel-ish-hid: fix NULL-ptr-deref in
 ishtp_bus_remove_all_clients
Thread-Index: AQHckao8e3AARCXUT0KlBs2nma+W57Vr08dA
Date: Sat, 31 Jan 2026 06:46:53 +0000
Message-ID: <PH0PR11MB749313441EEE2608C86E43818E9CA@PH0PR11MB7493.namprd11.prod.outlook.com>
References: <20260130053456.4971-1-ryan.lin@intel.com>
In-Reply-To: <20260130053456.4971-1-ryan.lin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: ebd26326-a24a-49a5-de6f-08de60948514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PeFt3x6qhXvLVKhbeRGiRMhBsP24uvnBz7XHUhvatHXjfPcbjUnFQDqpacyF?=
 =?us-ascii?Q?799bOzhcZsv+3zUaMlW7xij2Y0yL9EZbo15hVdtgzFBnZTuIbEhrLfZS4dex?=
 =?us-ascii?Q?bGEmPMcoEkauuuVV/ECCZqnMCDHqJ1ycxgipysv1k0tH+XN3O3EXVXy1aAXZ?=
 =?us-ascii?Q?nSqG7AonIYBMhcVYPJ6OIB+e87maDqyNIUIZXBvzRW44fxQklr204OIivdi3?=
 =?us-ascii?Q?Ad5CinEyJl+QgDRQmFLL+hZ1VcNnqNaS2gFKRLb68a1NRfHgr8xgjVeMvbR2?=
 =?us-ascii?Q?BHGu1DtP62KE6LwUdtKWUtVqOBKLuGJskHGaN26yZrnnHIMmpUupxXCFkPH5?=
 =?us-ascii?Q?DOEYhTjSLLa5cMq30SJ5ix5IA1fGX043xPeKKG2S5TziAyI7+31JjtKKuzk9?=
 =?us-ascii?Q?feAF4xhopMH7WeNFaqgdYQmME4jHGP5LaUH7esq1cIYXTzgg8mdHn0jDFXsy?=
 =?us-ascii?Q?yXLKCyHmH1fhbd5BmXfQNr1ot7jhEeOnYUQHAVPJFJWt4NrJOP8SJk/pAX0O?=
 =?us-ascii?Q?pj9aBaOvyHEUuG39HHW0/X82vlgQSZDPEMhZJ7UzzjHbLF5a3S8uzWVVJtXy?=
 =?us-ascii?Q?WVSCxE7hiUWadbII7S3ECyqgQqYBf6Dpg9oZVGlXI/NdbDhpz74Ca1z8M5GM?=
 =?us-ascii?Q?7dY2ny7IYkcl/CVLH+XJVDn0v/ztphsGX5Nr+WvDFjHCbQrtdwGZX9VUlmHw?=
 =?us-ascii?Q?tzatmRxFypWHncdjJ8rZXT8H/EVB4MArV5CrOog4lLVnf+/hBFaeIsUWZVyX?=
 =?us-ascii?Q?ucYy+EtqgooooZnb94vz7vewZshHLLEUXvrIEl7C/Jwi45HXaXF2q4u4IdeT?=
 =?us-ascii?Q?53mn1I7Qcc6co7JUTMY0ndtdUm2cZj4s3MAAkyKjGAy0ECkm3usfmZbkJYRc?=
 =?us-ascii?Q?OeazDJJ5019QbgzRnXvUzCnnJvNDwAS6XqNaathGU0oJs+fqMoJuHDA9PiLu?=
 =?us-ascii?Q?h/uy3o1/nd0s/NsThJL0eaXUb5/AGn0GCvpoPyhtCdo1zbI35QPLQLplbwoa?=
 =?us-ascii?Q?wdHVgpO5FBAkLit0FMv/21hGpVr06DHFp7vQcbI0c6YDwIspv/n+lHcbtKEh?=
 =?us-ascii?Q?xburoshh2o2ImIg9LdYxx6PtrNMGZW8TH/hNRRb6ohpN6TESMG78MgvPScX7?=
 =?us-ascii?Q?Z7RpQJ2QLkRHZwY30k9SVIGWR2KWeAv0CHLMir3G8vu99cJWbsGdJx+zCrVO?=
 =?us-ascii?Q?g5zIm83zNXtyOmBMCQVU3FXRgBguX3kCgaIjq+NXpMjBfEK6KGGeuC+ywi0D?=
 =?us-ascii?Q?m8UqYcJKfXtRYago1OW3X/LHWCtK92frRgHFpEeAz7H/dUPCAotxRsf5oxQk?=
 =?us-ascii?Q?N0HLhyH4Vs7OSj80CfUWBbaFTx/C/YNH5nKzLbfjXksCcdj+FLWMN6UwNARW?=
 =?us-ascii?Q?yNXBDQ6lDDECNTL859gUm9KmMytt7yAuxR4lwz56kZqUrheLqCAYtOa5ZZV5?=
 =?us-ascii?Q?5WJwRhGwisNZc9g8S306j2TqpRUgz/d12bzCATc9qpfk/t/91vzEJLzMoJr/?=
 =?us-ascii?Q?m7nrr8NniPVbZcPSawowFFRuL+dImfLgsaqtNux+TedErvZC+J5UztQXA2IE?=
 =?us-ascii?Q?Ali+vQWVuZjhlXSn/r3MgzuIIwjGdS/x4l15n+Xb4SzIZ+6Ie83++P7uRPj3?=
 =?us-ascii?Q?FP0Djx4LVh9yQDsD9YSyPuo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J59IVPY9y29wmUL2LwLxsFyY1l1obrAdSInP6eb57+oZ876tyrYQyS69w3Ua?=
 =?us-ascii?Q?SW3zlFxUZWkISjUkVNgAzEG9ZetcFGzQxs0+6OVbst9hzTFkLAKpVulLb9uM?=
 =?us-ascii?Q?rd6DpnoodC/Ch4rLCICXvDQvVac1Uwl82+SYVBTTexLuhSC8VWer2TKS+KzA?=
 =?us-ascii?Q?kPTNWHMNMsTkzdjCuSSgEs3lPVLDt0z2oZOePZnz3s4oh4fcQVH21N7NqLnF?=
 =?us-ascii?Q?JP9pY/k8Vexghoe2wTJAJrLU/7gT5v5gKC9drW76DxeccL+upVly5rkA0IG2?=
 =?us-ascii?Q?hGpfEsF1FjuOO06KVgR977Cq8+tAtxVTwppMHxz81/7POxeQYL8ljih0OUqp?=
 =?us-ascii?Q?eexc0GrTrHqEWf4SRGLDP13TrSRqg8Iompf6IUPHU3HKjHKaPGHETE8/kjyu?=
 =?us-ascii?Q?qrjecDWnobRXFGxOVwUJI3zJwbg5eZelfwTVRyar535Dm2Xy3Ek/MEBzD9Jn?=
 =?us-ascii?Q?c3cMFTY7Zbjsju54JzLw8UXYKyZ/wWcHKV5pBMVOyyOT4uJlQRxdVPUIn9/r?=
 =?us-ascii?Q?ldaBXQvS2HoRlAxf9CBQr8jgqpqo9u/8hVBe7tKEaXPPtgb86dk0JreJjsk1?=
 =?us-ascii?Q?psCp6xcXR6JsPN1MT7OGhkNsBqWEPsfDPb7kxWjrJhpG4ohlr2jM1SGtYsoW?=
 =?us-ascii?Q?CgdnL3jQdU/DKFdU3w3CTBn/glTbu3v708AC9P8vtw2+xW2x04OKAOBJ9PLu?=
 =?us-ascii?Q?pycJmCdr8IuipKBmzxWSIIsOA0shijlTvS3FDRJl/cGLFRZDBdgu0/XQzRD4?=
 =?us-ascii?Q?jTDkYKtDIEtknYnrqLruwbZuQKrf+35OaFXksPv9bvu8TjeZLl6RSjp9RDQh?=
 =?us-ascii?Q?7muWw0GfdvKkgyEA4RGzeOFIZPtYWl8QU3FAp8sTkqB4ezJ+1FN9jzW9Xcwc?=
 =?us-ascii?Q?KlpRn9e30GoC34JDhETOkNsYTzSUyeuil60tDF1GCBRBEhedFxS3Y7MNS6oo?=
 =?us-ascii?Q?NogUGJHydjYY+jBs0LlRnuQ8cIQbp5dAVjdvvKcPpEad06uVlOGnHlJM5ckB?=
 =?us-ascii?Q?zqwYxU/9vZVBFkFp0R3LmclpFJRMar/m7AcEewIjr65d8kziKu+tfCxJLxFc?=
 =?us-ascii?Q?rXc5bQ2V4jmKa51vpElXBONaxM1JV+jHgzK24LYTq/2n2bu9mgRaCXnEysbj?=
 =?us-ascii?Q?mcM52gMcWTJtz2qX60gm/NU3ppiMEw0og2MtiRarH/hNw3fD5KHIbe9z7a2h?=
 =?us-ascii?Q?78gK6vr7qy7QGPvpccFAcd4kKEW0cTyujJ9avkQSGeikEd4qvRmKQqWgpimA?=
 =?us-ascii?Q?lv4TUmSSAf7WsMFvzOXWgYjX2O2D3eO6RGPLcPy55XcbRfyn3ovdNReCIUCn?=
 =?us-ascii?Q?5Vt/+GG64l0NNUHIjO5dLSfvxnOvKCD93LH/gugjn1MDwPawqqy1+7XDENGO?=
 =?us-ascii?Q?SAOSW9BRMj6tRTacylIBKU4EK1BuDCBL8MyQtrDSr/6pJQlI2r/8SBAjqyfx?=
 =?us-ascii?Q?coNS/ab9phOxuq0sgUjnzkIl9uaqA9Izp3PJZlkVcEuXHuTKuiz6jHAnMzbU?=
 =?us-ascii?Q?3aNrlaLzCeHtYI7Q2/cUCkB1e/mEmLTjQWod4J0o3ul7vVchTxCB7snGt0VV?=
 =?us-ascii?Q?LjLWf9pQwjdPaXc4J21nlXYBvSd8341v1dP6/ieaoWAQ01yyhHkmP4ldRKD/?=
 =?us-ascii?Q?mO0RlncsttPyfjGxj7ObvAxI2DcAjfojEgNfKncSDs5n23thSZxDUdIAovZV?=
 =?us-ascii?Q?DX0lntyICpK2Rr7f06Qh8t2umaua4zXbkq/TSGEuu40YPPqz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd26326-a24a-49a5-de6f-08de60948514
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2026 06:46:53.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9g6eeorXDFZ2Hga050PoHeiy4OHcRqRuk9ZkXxtVxYRC714LVyow0z+FsCOuM/Jmi5Sa8+n8X3a5VDz8Yx0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

Hi Jiri and Benjamin,

Looping you in for this v2. Apologies for the oversight in the To list.

Thanks,
Ryan
> -----Original Message-----
> From: Lin, Ryan <ryan.lin@intel.com>
> Sent: Friday, January 30, 2026 1:35 PM
> To: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
> srinivas.pandruvada@linux.intel.com; Zhang, Lixu <lixu.zhang@intel.com>
> Cc: Lin, Ryan <ryan.lin@intel.com>
> Subject: [PATCH v2] HID: intel-ish-hid: fix NULL-ptr-deref in
> ishtp_bus_remove_all_clients
>=20
> During a warm reset flow, the cl->device pointer may be NULL if the reset=
 occurs
> while clients are still being enumerated. Accessing
> cl->device->reference_count without a NULL check leads to a kernel panic.
>=20
> This issue was identified during multi-unit warm reboot stress clycles.
> Add a defensive NULL check for cl->device to ensure stability under such
> intensive testing conditions.
>=20
> KASAN: null-ptr-deref in range [0000000000000000-0000000000000007]
> Workqueue: ish_fw_update_wq fw_reset_work_fn
>=20
> Call Trace:
>  ishtp_bus_remove_all_clients+0xbe/0x130 [intel_ishtp]
>  ishtp_reset_handler+0x85/0x1a0 [intel_ishtp]
>  fw_reset_work_fn+0x8a/0xc0 [intel_ish_ipc]
>=20
> Fixes: 3703f53b99e4a ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Ryan Lin <ryan.lin@intel.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-is=
h-
> hid/ishtp/bus.c
> index c3915f3a060e..b890fbf97a75 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -730,7 +730,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device
> *ishtp_dev,
>  	spin_lock_irqsave(&ishtp_dev->cl_list_lock, flags);
>  	list_for_each_entry(cl, &ishtp_dev->cl_list, link) {
>  		cl->state =3D ISHTP_CL_DISCONNECTED;
> -		if (warm_reset && cl->device->reference_count)
> +		if (warm_reset && cl->device && cl->device->reference_count)
>  			continue;
>=20
>  		/*
> --
> 2.34.1

