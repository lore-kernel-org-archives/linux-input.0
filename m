Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5E18FDBD;
	Fri,  9 Oct 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791509418; cv=fail; b=JBd41evB6JXO/34l4N9ihkO6pmBkj1iJG+KQ3ufjEK1toovIEzzW7C4KQRjnNsglQoqvNp3iIsDCc+DmmbLR1f2obIrq1QZTCZm8XEhmOV7SsiCgUWaV1Su++kL9OrK1DPPAQjmkJFS5k6T4GSy6iDNhljIKvQFj6LwY5GuqqpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791509418; c=relaxed/simple;
	bh=ldjn+DURjilVbbRgkStQy/gRhWG3oepfqq6n0HNhk4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=kxDpyglcrR49iEc5JNRQxEGDPrhvxaJfNKGrwRCiVT1QOonkd9kcp2xSesFYTcc9AV/gb6pP3LZo70G2qNH5YJolNSH6fM2HOGf+yXqHcMSP6Cs09Xlwv2gZWK1jq+M6n5yc2dOAg/xeJfYMyJsCnON/atwrnTGNfnfH3drgUSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWcsfrM1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWcsfrM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791509416; x=1823045416;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ldjn+DURjilVbbRgkStQy/gRhWG3oepfqq6n0HNhk4o=;
  b=WWcsfrM11SlZLSIMiMOsWlnFcJDAb7inZDBnXBp9q+HdubhNQaBF5Hq5
   2JJiCRdDwFDAPdo21p4U42ZUi7akkLmwS9FnLcu2AJb8SiTq0lG08+dgQ
   fqnB1D2LWOaHh0J2fidZdYOmsBR7QHqAvyMdViEnUQwVIUFIpYzzJG1QO
   qGAZkbTecZ7JS+qYf06BgXJvFjC5WJdCLYnD81d/MadklxQEvRp+YF1Qu
   nwTZrCo0ChdKtaJmuZ/ADvQJ1XPqhnxhujfdYsbS/iKD/36joaGbUE7FP
   El3OyxZJotOShQCw8g60gvt3x065ktJpPF+T37ypEOfjCzTndG7vV2jiD
   A==;
X-CSE-ConnectionGUID: EA41sfLGSxSJDRs6uLsElw==
X-CSE-MsgGUID: NQThSN97T6WNonzbXV260Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="313042"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="313042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:30:15 -0700
X-CSE-ConnectionGUID: m6zFqgAiSZiTXQpAo/xl8g==
X-CSE-MsgGUID: FvwVrIyLRQyh2/urs3F2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="513795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:30:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 18:30:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 18:30:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 18:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3kDOqdv3ALY1nIt2rLtW30CvmBWDY9+6upgn9uk2EQbP8azVAMHw+Q/JX/n+Au3+diG2Jqh4u3GmpGcPvfVvvzlQ6ySbqdSpXYF+PFDRT4MGIbWdBthcFN3m7WliaOqrFZAt3HU2gj/Xayl7KQeOxBeNyW9A45/pO7Jg5yAoFR3Zhwv+ZLjig+8DOCwI9Rf79pKCBYOmYWHcnZoCeIF/HvzrFCclplpY6Kx+vaZWwY54LqTMyXomG7PVh3jHtmo4vSiMHGMZnobYJC8TUtYoKiSV4qSd4v+f8OQVj5VVH2+8bk9BwU6Akd4t/3NA3J7d7w2I0FxkgkwKDePdI6GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldjn+DURjilVbbRgkStQy/gRhWG3oepfqq6n0HNhk4o=;
 b=eEOZaKSB7DWkBVE07ju+EjDx/LM8+GS8v4U5suB1Z4/rHcSSA4SdcFqZYv6VzpxyFDjEGL/EKbnyf1wpC9ualhnoS8MhHbKssck+sMrRiW2Qg64rqXxjix7+JqEPR8CfIM4o9W8g8ygvgmSjBuL8NQ4oz0AO+8blAV1ZRnG/NZcxsXQtzuNs6dvTqs+XRsBjWub6qN9KIRE5LvMUS+6cdnzdInwkuebF2CaIoRpIQ8Sq61vG5e+NT8uyZ839Y82XjzgNTtjQe3DudlBD51fd2QdwmJrP6/8LGZN9UoKyFwV+ueIPDaVAbozPn1SCViSS+Mj8jEo7jPwkqLz/lTDzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 01:30:12 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0451.014; Fri, 9 Oct 2026
 01:30:12 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Sanjay Chitroda via B4 Relay
	<devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: "sanjayembeddedse@gmail.com" <sanjayembeddedse@gmail.com>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
	<bentiss@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
Subject: RE: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID sensors
Thread-Topic: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID sensors
Thread-Index: AQHdSCLIz7+mn3GAhk62JH/qThPYhrbi9VqAgAIQmmCAD4Q2sA==
Date: Fri, 9 Oct 2026 01:30:12 +0000
Message-ID: <SJ0PR11MB5613120BAEB873A53A845EA593922@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
 <20260927215731.59fdb69b@jic23-hlaptop> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|MW3PR11MB4619:EE_
x-ms-office365-filtering-correlation-id: 3f94a831-f753-4da7-5745-08df25a4dd04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|18002099003|10067099003|11063799006|56012099006|38070700021|4143699003;
x-microsoft-antispam-message-info: F5JUnMFFC4wFjIYsCVTsnlDEmIXp7fTdV1ZbmlCBWesh4bCpNLJnCVWuRot39+mRRMOgx8PTVQmpmwUuKC+X5Ha4cV12g12tMeL3wFxJUZEdWsf5M8VZU/H2NIBt5osBeNr/i4AXbww12ys7q7Or0PiSGMCRjbhVviWHSfAgdXswQUJ6VkP8Oya6FxW9U8ysFoeWqSqy8fX0MsgL80YTf3UNLIzGIwLDXnE/OYiWskNJF4ZX9LtxV+SElu1PIR7aFTw1T2C+hfplXyIPvGGZS1oe6YPw06AURHj8IVHkGK7ikzSGMpsLnI8kjMVX3Dus+BBQyHOhVooVc0dbTtHj6RF/AWWIQxlHSlERSD6NJ6Tm4wVhobYbUHwHnqMXxKv7YevTdXvjDDg4rwxMQW8aGcXKKrSKTkz2U+rwXyUo7QZo07SHvvM4VnO9yOSJIckms2ppwcoxkK7IQBnMOuO1JRSdZmU76n4Qn1nSgv0LU/B29SVke8O1bY+W4QUOT9mZRvLGW9XuYfAb9VodHqD7IbBg2OvC/k3ErONBHK+FeCWFujnwQBYML5nu9UJitQTvnZ051m9ciY/95n7pW8LzLnpfx9yBIpoRvX59mZBi5h6lTpl6kF2hxIHBveRT2ZEACgLaeukQ+t5JY/8zvbdw8AhUxlAqd0upuEVUU/pcHliNzhpXu0Hd6NpaZsYtUHTeHlShT7JfVMKsQLuISW0Ejwdz/8oQ2dFT4Sosnla6dDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hJ4E9uRkRzCavyIY85CoheATgw1KFmQFLRbKNu7XnZBSLcBP5ihtkKgqMs?=
 =?iso-8859-1?Q?5GfTUmGCyIZVFYdqOReT4UD9OrpLP/HVaSLqBq2xOCcZ/uTToREyZt9i5n?=
 =?iso-8859-1?Q?HhdYAjw5G/fX24tzKMPsAY9yxokKCGhM985qRj5w9FD+Cup3miRmFJQJtR?=
 =?iso-8859-1?Q?rYnJCBIFjyz9VewrijXTyyBdADCaQQLUaRLX/i3SoaDeJl0X+3hNBdU1iY?=
 =?iso-8859-1?Q?/EG+WGbmqIC4/nO3PQKBnntihukppg4yY664r9ZxpwWQHMdAntH0UN3iow?=
 =?iso-8859-1?Q?z3Wc/u5cRGoBjpQFOMd8K+NOOruI1cL8+1hR75gGm7VXn0ze0W/Eob6cjT?=
 =?iso-8859-1?Q?rNKc9qcAxz1I/+DT+Z6IcIyMXqr0hx7xEJrOvnSOHE7w3MAs9ETsoeAdk5?=
 =?iso-8859-1?Q?r9ZqeqUOTTH4XkM99rvqz1xyrZPgKBLLNaz5sZ0c8vt+ZrNc3Vbf5kYO9K?=
 =?iso-8859-1?Q?7V+dVi15Kdntp6C3srHlC7aMSCAOzXZuVnQq4C3lM7Nu4DP5qKAI1gbow6?=
 =?iso-8859-1?Q?kpYHn+0FPYwOceIi0bQsX7OyBMG6sJQLMpn62yxs8lAxp7TbZXIVKz1lng?=
 =?iso-8859-1?Q?KgnY0vsdYhnYR6+QX2gzSN0U45To3fq/r24yG1ZOkhkNoh3nIwKUZnuQCH?=
 =?iso-8859-1?Q?ffHxnlTPZsqHHN9+R3jtex554Ic1Y/8aOSxJ3Bx9o6oswKHB3RvcYmJCGZ?=
 =?iso-8859-1?Q?37NAEZ1kW+JSyM3WQyXObEwqvPNkjHD5cDLYVPj9Rw5+XV+PUfYSvpCnWB?=
 =?iso-8859-1?Q?krrMsxO90A3zVSgQu3iiUHHqhXhfEYAeqAlIUK38+ppT+nQAJk0i4vF9vS?=
 =?iso-8859-1?Q?Z9MeEWsstB+AmriEglO4+i0ksFGrnB97EARbnNJE1WHnsIpqw01mpa3PYb?=
 =?iso-8859-1?Q?CL7SAwgAd61ZYfkyIkEGOnJM49BH9sXVypaREcS5F70kpQ83PgQFGI6Mja?=
 =?iso-8859-1?Q?zAGTuxg19gkmGCwGqLj0zLz1yv7WCSQ4n9lTKBqWLZWxHQ8EHdY+CSBbcP?=
 =?iso-8859-1?Q?/GOAYkHtZEx1dHEpiCg9oOlXmCJe1C1vdOlaxr75MBRYGdNc9/ppdUd57r?=
 =?iso-8859-1?Q?2h4UBFSkkQLk4VKyVy4y/xP9IM06Hdb+N8v4lOMWcpJVVb1uwkVT+yhU00?=
 =?iso-8859-1?Q?gBEfuACeMOFWOzCsOKHa/voqluRMvO5o+rJISA58NlNbeHCRml/UAaTadI?=
 =?iso-8859-1?Q?xqgBkRkWpOz5ekt4sdEe7wZ4fAEeYK6uKAgmta/leH8g1oi3mu/5MnHAkH?=
 =?iso-8859-1?Q?AYGKnHA0dfVjr1kZiilEUShrCHxQXySEg35Sj4GVMByLwUEEZql19/oJPO?=
 =?iso-8859-1?Q?8+q+0AWHaXoiS2+rxzEtTs4BH0k3UgRoT/asT4BtcCKbgfPG3jcNJXEdft?=
 =?iso-8859-1?Q?OmADnky8gFj/kSE3c3c9TuT7fVSsXcfZsSz7Gj17XPIriDY2Tvg1bqgWp1?=
 =?iso-8859-1?Q?IH8r9VHps9uX7wFvsbm5R4GAxDeTlcjCvxgAlxI9HGFkrme2Dx2V6xMuQc?=
 =?iso-8859-1?Q?x2+xhM1VpP+pU3fLvrXMBSur7fxsIJJatvCI7KghCLW8gRHsBYK8tAzzjv?=
 =?iso-8859-1?Q?VvrbG+WFtnj0xLLFPsCkMnvnHhsMHd30hIeQNB5CIOQ7pjUaW3/1pPo9r5?=
 =?iso-8859-1?Q?tSDw1bUQKqzlM+Sba9Oma7ztH8tcEIidv7WgTmEcjYGKkwZAgXd4znVX/V?=
 =?iso-8859-1?Q?HYPjxVNvxapfSExVwoHdjpIi9Hqgd9xxMNWNSchyuM5R3Pk3RkJ64uVSuw?=
 =?iso-8859-1?Q?EJbPWQPmSYKnjDGqvHxCUEJ2l096nP/+Rapspwuw7YWN8S?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eNXFyJr4VHCSL99tU0kdKWWGFy2I+YD1vIASwaXybkAbD7OT7ajGc64MA76prIoMYJsWzwnEu0ud9wCxMth0/GLVvte+yD7vf8LpapUz41sYGwCjXcf/6x6E1RP74FFi6a9ootW74ia2uX23UTclaCxcFXaRhiqYxOrVNf+XZF/Ka9eIllK5ivl4sYo0dy3Nfi9rWK7UwO5wnaeFcQcatXsJE6iuQqnzcQUL7M6m6ew4yiR1WwCxZs2nbTaGF0BDE9jtiNb/dIZbzIpLftS445CD9KzXyfbXc69qZ557dCz8NyJ7S/1eMli8o1FBlIhylod78SPQrzqRLyhRAGrncQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f94a831-f753-4da7-5745-08df25a4dd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 01:30:12.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMOyGfWR1tTRagEswqkLYzzHNbbCJ+LXPyHULGGDUME09q+aeTrCu4Du3zCm6Ym74bnesTOb6yXwVM82twK/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Zhang, Lixu
>Sent: Tuesday, September 29, 2026 12:31 PM
>To: Jonathan Cameron <jic23@kernel.org>; Sanjay Chitroda via B4 Relay
><devnull+sanjayembeddedse.gmail.com@kernel.org>
>Cc: sanjayembeddedse@gmail.com; David Lechner <dlechner@baylibre.com>;
>Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Jiri
>Kosina <jikos@kernel.org>; Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>; Benjamin Tissoires
><bentiss@kernel.org>; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.=
org;
>linux-input@vger.kernel.org
>Subject: RE: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID senso=
rs
>
...
>>> checkpatch reports a "suspect code indent" warning on the
>>> DEFINE_FREE() declaration, but this appears to be a false positive
>>> caused by the macro expansion. The code builds cleanly.
>>If possible, Zhang Lixu, would you mind retesting this full set?
>Hi Jonathan,
>
>I'm currently on vacation and will be off for the upcoming China National =
Day
>holiday. I'll retest the full set once I'm back!

Tested-by: Zhang Lixu <lixu.zhang@intel.com>

I did a basic function test and didn't find any regression issues.

Thanks,
Lixu

>Thanks for your patience.
>
>Thanks,
>Lixu
>
>>
