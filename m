Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D851F5842;
	Thu, 14 May 2026 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726881; cv=fail; b=X8hLhF9ZIyaEovUpwg9lM/5k6AApRYvuYzXgJo9kudmjxAu47cRtnSu1O3ddza/t6chMtbHaH4g/Sd45gqKI8qNoeDf+Q18AG4atXSFEBWwW4WYXhyPqk3gDmyVvvcwK3i5ggIFtizWsrq9MxnWzoBYBhgpemMaJrtikMxA7AeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726881; c=relaxed/simple;
	bh=Nmz3nBa63aTPNXHpPqi+qYv/ldNHQtHMxCfB7TQKfTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfIUrHH51PEm3A0XHJikCQNgJNjbxWa1MTmfmz8LDckiCOp0SlUv87fiLHGGv/pHDVJnJylRtpv3MQyMW9l+MrFAyBDq8ziMNwBpQN3bMSgl+9HNpjkXtSd+YmA1+EoF4t6tMBdzv6KMhp84VoQg+OljYxNeWWBKtghzOc02viA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENuLebZk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENuLebZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778726880; x=1810262880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nmz3nBa63aTPNXHpPqi+qYv/ldNHQtHMxCfB7TQKfTY=;
  b=ENuLebZkN1BgQIAHwewbzux893YJKtRVougmTItIWqDiyTymzzAuLEIu
   aaxjtOfzWjbSgqripi0Tx6M12i8bQCeiRVbi5XSLTGDoMo0cal7mUvQH+
   rcDN/DOSS8byjNcb35kKNqzRp676QwOL8Y/XoM30d+nueg1EGJa3oIbAh
   eaEgrgi2EzgiL+DbnFUAOij9Jdt09EG0KI/T2MGabv8MQneujoydnqFWo
   yPvJzVTpdnNjB9T/zV3P86l1W0/K41anGeeccs+8KXXcQzjb1eeeaG2Oz
   poFxCeIZyguviWpcqJnwqtB3eDFhhCMJ6LecoPxdcYYlXJ73LOvhorpPr
   g==;
X-CSE-ConnectionGUID: NHBoQ/oeTqmz0C1uN/hiRA==
X-CSE-MsgGUID: 04a3R5/AQgieDDWNsI/o2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="97091793"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="97091793"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:47:58 -0700
X-CSE-ConnectionGUID: PM7VZlGOQ2yikxN2Mf9JAA==
X-CSE-MsgGUID: 8bhdUg6GSFKWqP8raE962w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="268617627"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:47:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:47:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 19:47:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZir17dF9pM6pipZGmWN+UI6HSf7r6nQVyJViiiqPuv72efpV1Ui3s3WM5A5wPYLBqGb7WTaZoh8f4bvxLWdyNGnnwussd3D7YER36FoYLMkFvdwF7cbtxestlB0Y25sxkWDpa66FKtd86yFS89mUvUfhkCDGfSUlU2rw9jWegieObtALFQEKoUDVsYC+ZVqRkeh1PwwF14FR3VIgaW80+lsvIvzNXtuJ1vJ9dGdnrKAzUd+ihkrpIoGIq3etvInG9fNXJkkon7u3eH8ebHMtWfMb4DyPPU0OyYj2yAmdEU+xEnw3pft3B5ExDmH0hSuGn3+wrz8acKcVZtdm+7Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7shPQdQV8RBrHa14QlNvb52ynQW4yvBK21crenlD5UE=;
 b=GhzlUxPEjMhKeAtnLhtNp5cad21Ota1b/jEHAizjib8Pp0g/btxUm0T6GLkWzRMVyPKeFOpjYq2n39ipiciLNetN+tTMgqgnXIdjAGdeD2KesHdqwstnZfvVCmngJHSTPo0apP6T0QYIiaXZ2eANcf3S4yOPOKJO82iyi9eWodhHTD39RblRUUGX/sgOXTsqmwlMU7zAh0w6qkhkGUjHj+WpcSmbVXmpYaiEMKEZ+frD9Otke710xOIcLPA+XkRUeuw5QC3r/YfskZcVGKszNOA/CaNgjLWNU8Npt8Mc1tPJ4oDCs9+CWx2lhRgcQvws94yMAd4tTtqL2a9aEovAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 02:47:52 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:47:52 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, "jikos@kernel.org"
	<jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>
CC: "Lechner, David" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Topic: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
Thread-Index: AQHc35wsrw3sHMeT8kKWXH7AkG49XLYM2M3A
Date: Thu, 14 May 2026 02:47:52 +0000
Message-ID: <SJ0PR11MB5613D4ECB8081985C3F2D82293072@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|MW3PR11MB4524:EE_
x-ms-office365-filtering-correlation-id: e24a8a53-a38d-43fd-9270-08deb163316b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 3m2yiSvK2hNNT+7vh9shb6jYthCiZ464AIR0X2G8V15D3firRG7mmqV3goZ/S0luVlorlzZa9NmphQm3rwnuZrrZdLOlgxTDB6WQ/BOwwUpd3ROSPaiDInsmIIbIZSxC2jZ3vItp6cWcA6t5li4rwm87/tT/rrYC5CDgn14zZHdtBFh6iWvXPPoBFE6LMh4tWocOrStioyD3K30NPqUuhGL66N4w3yqovhWsv6ZKGK+D4Jbu2ueKJsiKY7jrGMrcskJLn2SnpCBrVDiSnwB1tmZHTfc9wYw+ZhUGmeFjGhRIS0Bd8cdtTK3rHJodI5YvEv7FK5W5KWrGadGFeUmRWTBGQHpd5p8j7NzHgqK4oGdjLUespy0BFAHmAoJnBWcmhFLXooIX2nYm/E7rqbdAb4tNypCGplxo6iMkr3m5heg5578QP+hYGD7J1nVBCEoH7GeqKkkbgjtLO1shp5lWCSpnTjZIOD4qSBZMHDtGyhA6Bo6yMfqqn9shddwq6lUpUaeM3csyj83j2hVDQnNPgmsm3mVPKlqaf42LQQwNdyutS/538A7MScqYb2tAQZU20KjXuc2+KPw+j3f5DXs7GnDd7hpiCnA6tc0X/MGklEB8QD5Ujz8ePL0DYpGRYy8NccP7G84R3bbQrzbpY+rfwaFB1T/nyCUbcs997GKPY6yBzFFsTqrAKJsh8CjpkJYN563STXj3eQ96GWoDdQox3e/RfT3tJz1l1l8AoSTVDDmSKJF9JrtssOpTNmyFqhwI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hWYXFTAuvkJVcZ1NWGVRdVVtrtguMKa28021XIP88qbaVLMUA15mgkfmmz1X?=
 =?us-ascii?Q?FuR/g5k3KIpevPXYTXyme74H+MLEN0dtX92YgMTDer3Xcv0vtGoRvhpRsqJO?=
 =?us-ascii?Q?CT129/bBzYinAt+NEyIJvmOWhg/Fldny1wKuUV8HCHL51cm8aqcw2SDzmNN2?=
 =?us-ascii?Q?+ZB9P2eCZXRxr0xD1+VPQHBDiyOOMZMioDPDBS0+YVShhGEUn2WatB5SWb0R?=
 =?us-ascii?Q?BdzCIED+d+bKcD5PLQZxna75FKdaRdXFIN336+8e2FB3lAxMeYjkqUOnI+ZT?=
 =?us-ascii?Q?bh1bmHIjA2bWwd+5+9TtZp7CqIPTFEe4DAz+fCJh2GrZfvTsKumCH7Vq/6Fd?=
 =?us-ascii?Q?nZ83UWK56+PXtTLdjHF5f5FDPayFHefrVehM3tyCljKoOU0NsH4e88rgWnKY?=
 =?us-ascii?Q?dy9hPE5n7rZtuqLZtRae3FKPrUfeBrl5e8Eh4G/yBBd96phIqsVA3WRrJi4v?=
 =?us-ascii?Q?ZL1Th1XWksI/vQSqFKoMnzXXc81I0leEmelK5c13qiPurkSbI8DvZA/MwXO5?=
 =?us-ascii?Q?kitNUQ6SVkdd2cO8q48/OWq9bsEoR7gjW24TE008Kfd1lc9HaYs/x6RESxbt?=
 =?us-ascii?Q?2su6KozvcJAhyqLOSZIKgPTdJCdagu9wYuCWS4xP/Y2mCEZKWNHF/VWVJSVV?=
 =?us-ascii?Q?cXIAc9duNdoUlqKkwAwJtfTC3Bfy2oUfybM7Ioe0OMmLFqvPy6abiA173NYR?=
 =?us-ascii?Q?ouVinp5vmCYi/Qk9ygMTZDrCIuf7/bN5rqenR3l/N6P8qjKGvwiJvMVTJPEx?=
 =?us-ascii?Q?A2chI//Hgbq+Y7u3JsFREAitecg7PrvHDE+/Janx7rhWIWF+Nm311QFxhy6G?=
 =?us-ascii?Q?gA+qLEsZHO3UDxVbp7ihMZimaJCOtFFqZhDWgLY1iECuE2I1DaiRtDtVSRVW?=
 =?us-ascii?Q?xEz1+Nn/LpKMQ4yo6Dp39/JMz32nnK+hsfCvwUTY5/sWX4nS/Sivxzux43UT?=
 =?us-ascii?Q?9In5cTWNMmK6HYZ8SkNIqWOwfBFHty6uq38M3Tyw1nkbYO2CNEd9bbL52D/A?=
 =?us-ascii?Q?jbbheE1b9kQESCqPb2wrGogchaAg2hiRSPxxzOHJDrYscm6LyBCm7JtULI84?=
 =?us-ascii?Q?M+WWL6XE89EnnHta0EqljZH+gaorsr0t8lqfX5P93Xjsw+OrEsBjAlVPehZa?=
 =?us-ascii?Q?B11aDOW2ot7r4g1v942f3eVCupU0bQiy6X1FsvBek+JC73b/tY1JC9MVvc+r?=
 =?us-ascii?Q?lS1r5lUDotgE+JxAcbMZn13lzyAMMfw7CG8/hKXryDGNYTNoRmGkxqD9a1h9?=
 =?us-ascii?Q?sOlgt2kPP2Zu7ofeyY8D07+ygSoY+Cs1UU1GLHYbfCWUef7jUM53JsjyUrNA?=
 =?us-ascii?Q?8UlBi5gqlMkBVJmnWheF28Wkk0KAHJDNyJHqXz2FWWkYdI/BbVQPWhmD1Y+w?=
 =?us-ascii?Q?2MwfpY4YCN05wBW5oBqBslx85Ei8xOGzhW2uaH2RAyQ2HSK51DLyaBHTVrmh?=
 =?us-ascii?Q?dB7D9pkuYwPvOcr5jqrnutZfFWTCCIAZwkduueEbc0E8k4tGl5Y6NrCgKLNn?=
 =?us-ascii?Q?+Kpk4XzK55J7Yha76uD0dwGZw/TQoTKdtKWE/Vq4b+Zcs0HmzbEK2HyqbXOE?=
 =?us-ascii?Q?pDSkm0jYSItDWAVtWk/SHsBy28O8uRreZLKo5RbiaxyBiLePGemZhE2eZiCU?=
 =?us-ascii?Q?zb2top5Gg8RIp48LI69ppWu+yAcbu3Gj20GfLIv76Dp421DoTh3e/egtZhfh?=
 =?us-ascii?Q?WI/vGLeSJ8WBJkXn+pmA6xIt3I1rRmniCSWGtEi2mMgLzHqm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YpcZBfTMEmIVuHMKDJk5AoL5ru0Y8rnCDKdl1rdktUBfB/IfasAuGXB6tP8+JX/An6zIP2P8RKC/wxuS/76N8dOR7G2WStM93tSSlsASwBt398SXBQ2SR5Rjgp1BChXMIVDTQrQiGMFtOn7l3wK3s2fAlEBGmT4P1AcMSUpplwUpLeb6IE/ZDMzzRtimPpS9tOMUmTOmTuqVvl3iq9DlvrIeE0sp5PPTnMWw9GhwUp4XsNN59ropYWd0L3ayyfIe311QrKVXr8sIa9xsNrPpP6zDbRRgQkwnXU2fzXJb7uHjMWhEPLSSZmKFvay2PmqXzvvNX8LgeaV3jrgqCyCuhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24a8a53-a38d-43fd-9270-08deb163316b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:47:52.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb3T+Kis/ZwhFechwAVJeAUjCgVvTA94mnUHKufKXtGLclCqFT7Qnp/M2tV3MAvTAGItt2qbpO1XuOxhMITFRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com

Tested-by: Zhang Lixu <lixu.zhang@intel.com>

>-----Original Message-----
>From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>Sent: Saturday, May 9, 2026 6:11 PM
>To: jikos@kernel.org; jic23@kernel.org; srinivas.pandruvada@linux.intel.co=
m
>Cc: Lechner, David <dlechner@baylibre.com>; nuno.sa@analog.com;
>andy@kernel.org; sanjayembeddedse@gmail.com;
>sakari.ailus@linux.intel.com; linux-input@vger.kernel.org; linux-
>iio@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
>cleanup
>
>From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
>Key highlights:
>- Prepare change as pre-requisite for devm conversion for HID IIO
>  drivers by removing redundant argument
>- Add devm API to setup trigger and clenaup resource using
>  devm_add_action_or_reset()
>- few cleanup and prepratory changes before updating driver for devm_
>- few sample driver update using devm conversion to auto release resource
>
>changes in v3:
>- Added cleanup and prepratory changes before adding devm_ API
>  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
>- Address andy's review comment on commit message and coding style
>- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-
>sanjayembedded@gmail.com/
>changes in v2:
>- Following input from Jonathan and Andy, squash initial patch v1
>  series in single change as individual change should not break anything
>- Add devm API support and two driver using the same
>- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-
>sanjayembedded@gmail.com/
>
>Testing:
>  - Compiled with W=3D1
>  - Build-tested on QEMU x86_64
>
>Based on further feedback and reviews, I would extend this series to conve=
rt all
>HID IIO driver to use devm_* API.
>
>Thanks,
>Sanjay Chitroda
>
>
>Sanjay Chitroda (9):
>  iio: hid-sensors: drop redundant iio_dev argument
>  iio: hid-sensors: cleanup codestyle warning
>  iio: hid-sensors: introduce device managed API
>  iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
>  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
>    devm API
>  iio: humidity: hid-sensor-humidity: cleanup codestyle check
>  iio: humidity: hid-sensor-humidity: use common device for devres
>  iio: humidity: hid-sensor-humidity: use local struct device
>  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
>    using devm API
>
> drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
> .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
> .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
> drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
> drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
> drivers/iio/light/hid-sensor-als.c            |  4 +-
> drivers/iio/light/hid-sensor-prox.c           |  4 +-
> drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
>drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-  drivers/iio/orienta=
tion/hid-
>sensor-rotation.c |  4 +-  .../position/hid-sensor-custom-intel-hinge.c  |=
  4 +-
> drivers/iio/pressure/hid-sensor-press.c       |  4 +-
> .../iio/temperature/hid-sensor-temperature.c  |  4 +-
> 13 files changed, 78 insertions(+), 64 deletions(-)
>
>
>base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
>--
>2.34.1
>

