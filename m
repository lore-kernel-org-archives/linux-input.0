Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9721FF23;
	Tue, 29 Sep 2026 04:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790656289; cv=fail; b=mA1FS/xrxIXFqSUPi9OE8vyw3m6s0X+5LmtvkvfNRKe1R2xtzz36qQM4zd7TkWQXi20w213T+MRKPakqQ9S/9SktTjONFGNLKYNtc8Md83icpOUx5U2hjf0djnB/AGfL0inP8xleKQIxVVPYF3shBlxnb+rv7n9oL6vgcr9JTUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790656289; c=relaxed/simple;
	bh=sajwWxqIhUr59cC0g7uR0ZSXFJsdZMABO21yJIx9CRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lg/kibb//U+AkhPLcltZdSp6lAUhr+3cCWeJMTwdbFPuNXAlLMwdT4B1B44hf+KlJDcWimx77QpWJ5kA/8oGtHZQ2JQkk2yPxHfz/D9dc7XiQW36WceWIjm1nZkYx4N1f52seosvfaTkYPMYuoMdh66rnp/YZBMMUYEzh+JEOp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFk9NlMj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFk9NlMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790656285; x=1822192285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sajwWxqIhUr59cC0g7uR0ZSXFJsdZMABO21yJIx9CRA=;
  b=JFk9NlMjJ2V18QRs2bTBNnzZ6qUUeDGjN1O0UwQe2g8b8B5g69JZNiEE
   7wes88S8a94o7sVcEK7qwgllt8WcP7EuId8/5EXfLBlnSlCY1hyFkMXKI
   J4uRFr579zGxtFZayvmGspyWS17YXhVGrH1rU+/soBHyN1L+okRIwzzR2
   dg2bNWQOzWF86eIpwTMOaVDeNs9amuM/Ricr8bWW6hUAruTHnIgmvoZPn
   9DYHWPQW7rD9YfSbbD1SjAvucbyVrHq2xs33qpYpiUdIgphf+3XnFIwYv
   3tgoUL/e6B+4ErEkjxLUhvO6Wh0vXPOuMnPTm6EuKBQN1GnwOJcZEXLAg
   g==;
X-CSE-ConnectionGUID: nE/CIO54QJ2hyigTMkbZ3Q==
X-CSE-MsgGUID: 3SmWeLJqTd6O33bVs67htg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94079450"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="94079450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 21:31:25 -0700
X-CSE-ConnectionGUID: b7v7WaYNTxiI3vS0obxwmw==
X-CSE-MsgGUID: +rx9AlM0RzWroVNZs1uUNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283334843"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 21:31:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 21:31:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 21:31:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 21:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoBcuvD63oryksb+CFn1W0fnbPykCSGN8IwWJqcy+u+7dHgolMt1Q14GdXUVQxTQ1guGHNetVUfKHQKQ8W8v7IwmyzZ4dBTzRWMgAKkicF/phmTUpP0xymOBHH885DuqYHXY5fDjlTWgTOsRXXfdPjG+G40NaAAasYZIaTY1WHWRy5801K+ovQpXwSycaeZ4vRL2pKNwXMA+sW0pDJXbe9vw2a7lZsfih2W9rVDRhPMA637DI7WENya18uyBIT/SedGRKKvULjIR1Tq1L05XBovCkAkouVEDo3XUGqt0hEv9pTJt4fxzfymFF0nPEjI2SZ9dAn3X+WgyeTEliX2A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sajwWxqIhUr59cC0g7uR0ZSXFJsdZMABO21yJIx9CRA=;
 b=Pyw2+2LEfLQ5hNhYkcZRKAEsKUzGfFQxo0JhxY+dCEyRKNVc27q9iuVNeSqGSsjVOT1M6stbVJuFWu3yJ2gK8gGlISW/sihh1cyxMjfZ15uSxICQ8ac4PUEPcgVSIzHDiRI/QaL45d+8LxrtRqA7ffkJGBWkxy0mZWYl9vGtk1V2OW4w4DeqE2Fv3LSC+yr3+M2hfg2XkjlhrvlPGhH1gS7lnGz/DfxXKoBaeJRg7HxCaA1yYYlMTanap6H8KevW+wtgdjhVD6WVHh+u2+WHNge74vOvP3CDp0blpBIzNMDTA3xpD4zvJllWyERKgtQ2mXfjQiYSZLhwfWg5P2/ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 04:31:16 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 04:31:16 +0000
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
Thread-Index: AQHdSCLIz7+mn3GAhk62JH/qThPYhrbi9VqAgAIQmmA=
Date: Tue, 29 Sep 2026 04:31:16 +0000
Message-ID: <SJ0PR11MB5613E265B13CA359CDD40E83938C2@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
 <20260927215731.59fdb69b@jic23-hlaptop>
In-Reply-To: <20260927215731.59fdb69b@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|PH8PR11MB7048:EE_
x-ms-office365-filtering-correlation-id: 7ee445a4-61db-4a4a-ba68-08df1de2804a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|38070700021|11063799006|56012099006|6133799003|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: ZB/4dSEUnz+UsP+aSUvmO3vNTinkpQnqsNizR4EAu1soJ13PGIX6Qh3qA4vy4cglTlSpP1ghKenYdwBb8hjG97Gl5qPfvGgj7s2umz/QGWT4ERx0WPcfjtlp6/bTLckF7OLYRLuNLk0gDlRmokci2msH9tRizdVJ2md7/KusmIeprVXgC0RbwC8pWkHX64ziRYaYg5pr6R3y3LiyxfJOD09/s+KqjbNmftU3MxhOl1JLgJPBUxBgAJ1F3w9jlwaTDv5karHRTrM6UUunWGz+a+Ehkr3dEF9oJeCnf4FInJ8WkxyNPpGPJ4mE5pLNqq4DfDdy0Jm86DK9ZlJ6ItN5cF3IDJK3D0VaLORIW2pBRsR2e8YJrXSHPx2KetFRDIw2Pox0npw3gG87jbe1Ts/tig04iWTaOB+o2MUUdgRonFGr8fRlMG0y3AMpN5xw+zwmRPAexLooSvGRC9ILXcyDQxYje1GnorEClW1WvCtxm540L3cJKWA782y7ora4IqFKbfp23WroSE05HEJbYMBTt01zXGWaeGAE/dvkxuwioG3upH4r/TW8NSBk9r8WlmmK5dSQaDXKnDLBYmmEXqk/0+Rkk0SA0lHZqaHtpV0efHIbA78WSkwS7AoXbND7bdhMMtJ5Xf4GE2t5ue+s1r+APuSQYoxxR4PzW3hUw37qE5OrWWyzf0NDp+/vQFnKkk+3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(38070700021)(11063799006)(56012099006)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W/DDbfe6C3uLhqeK5W7uoTpFjR3xZGPESui2JjkYIXepqywHwW+b9DEXyG?=
 =?iso-8859-1?Q?5aq7xui3nlEd65H96xE5sI6cPy14KzbxaLxeP5PzrWK7zCPBDbZZOZ8s9y?=
 =?iso-8859-1?Q?F96Qv3eekdcuxQXrhRU2LuuTsf0Ol8erUnYE9xKnR8ziIVotJEyR4/PAA7?=
 =?iso-8859-1?Q?jhUM4x6kcFmFLbyID3krir8eySpHUQ3rprDOtu5uRcD/ymABVdJHWHiMM8?=
 =?iso-8859-1?Q?kK6e+S6zFUaf1ALyTZQp4HW1vaZKA4iXmc2TbxakT5acsLZBdx2j0KJEyy?=
 =?iso-8859-1?Q?RuzuUeuJasvSw9wPFZRHAtXywKd2SZM0i79vWoqeL80PQMEXdlkW/+wQzZ?=
 =?iso-8859-1?Q?1tzpHspaXxF6N58irePboC6IivJXzHOIMYb6NB/gYgUCUYecatdV9HOZYl?=
 =?iso-8859-1?Q?LOOP1oXvvMSl23X8rTGcErN2VwVWAsJCrZjOEFnHlm6t5EGWtsc7tAq8OA?=
 =?iso-8859-1?Q?Df8lpwUVBiTnRVa5zSFLQbU2hFclw0XPBnOKXnL2mL2zfgUaRCwjBQrFSV?=
 =?iso-8859-1?Q?WEFCM4hXoGtOYhFrXzZk5Pykp0KsCvyRA9QJ6kHW95lZFN5NBIvMrE0ozf?=
 =?iso-8859-1?Q?j6d58H56ty3PUUlbwTC3xxLZjIlC82+BpHid3nsNyYdObvqjAKtekOhMJ1?=
 =?iso-8859-1?Q?+ti3AP+tJvjdvHxRRyAuqVCaJ6jqXlkQf0U41ZrO7VtHVHtFCg/4AbDn/w?=
 =?iso-8859-1?Q?PYe5k11yqYb+Q9YVyg+omohGw+QIVTM5ubp34KquWnH/UTHIrgHqw2BSYv?=
 =?iso-8859-1?Q?Byetb86yoczu6Myu+Roz7B20j+t1dze7mlwGn3gwlBk+Av3tAyhUQiyMWZ?=
 =?iso-8859-1?Q?OK4dHR5Oc3mJN29xftRy27kjraZN9gEy1xVZaFZG33S/FZFeO+RehohZYg?=
 =?iso-8859-1?Q?mSj/NaiHmszll05rlb0T9/V6/VIqF6oSx0pLuiSFDp9UN3tnxPW648/xjl?=
 =?iso-8859-1?Q?pFRco84C/72AlQE1snAvBlfAcDTS2k1lZMqXuvLeUqEn02TxWbDlpi8QYQ?=
 =?iso-8859-1?Q?aZR5lg7n/nXaj8uGX4hlvrnfm+ROr50oUp6L3bn7piOhLfB3odlJUCGWWw?=
 =?iso-8859-1?Q?MHF7kdKLJDx5lNrniuWpjCLaocv//MvAmTV1bTcfeQoSocssRiV+ckvwxi?=
 =?iso-8859-1?Q?VbCL/RCS/0oulOscVaJhJDAdjH2Fr0lUlAts9tmFtg1x3tnqKYPOljfeCu?=
 =?iso-8859-1?Q?fDVY/9CJaK5Q4QG15JdG3ePVUUaEMDRrRR3IbsuOzrR6BzH80aAAEF4Avn?=
 =?iso-8859-1?Q?cYsEmHPFH3xs9wm53eCBKAMUVqrp7ekjuQZ1joHRkv+laSCc2+owKB+k+V?=
 =?iso-8859-1?Q?pzxBjaH2/yfFPqUK5pDKg0E+FfsdSCwRSKdDJFBYOb4SbTkLpuGq3zqMfu?=
 =?iso-8859-1?Q?ojdRxSVCqgR+WvQ0KZbZ22WEGLzOd4QpRLQQ1omMq0KrVEy+naqb0KXNPh?=
 =?iso-8859-1?Q?NWuHYAbbRthotAuvLN4zYQYSwjBwvWy7aR0YkXp4GEUqebXZwKdFhMvgbT?=
 =?iso-8859-1?Q?Q/a4luuRoFPagXAyo6qYL99n7oTxxEmJAUo90HeU1lKGQ/dxTj4mLy+10H?=
 =?iso-8859-1?Q?9c8GGBAJCdqYaLtplKr+0bDzY0q2smsj3P34DRCrmMWla1jMpuZU17zsFm?=
 =?iso-8859-1?Q?EG1VNJ7PyemvUvgjvAZBFy6WdgUCkT4PHU/+lqzCpVgc/OL08FJIbSh1lK?=
 =?iso-8859-1?Q?lnRHtXfUuz9pEe6lphbQBhwhE2s5ZgCpSaADiGnSpgQX654WeeobTZTxLu?=
 =?iso-8859-1?Q?lSHECyHZZF6p2oYMDaWA8xqQF/Yek+0/IJgHiEUe2NsKfc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DuuwOFXQlgJpn1nwLpLc/QUKo7C4qp0+bvbqmix5aKAXB3COg3B0bDs4NL9OsVLYJ3fgXBuJXFLpZcJCWPU2TRiprreM5WIECel0CdgeQayOj8t6wMEplG8PfeEjIRq7P18XI9VbgFf+nqyDdFQEaGx++4gOBkiGJbuKzjVKqNbfAAhk/VFwhSgz+qWIPvVZJpN0bWQLwzLzf4DTO2RDi+K0Wdg2W8da19/C0gW5GEML+PBu7qZFghPNeiamkMD5VEvYFkUqFNKTmO/qHgM7Lzoh60/KxSwyxH9s7tdenaSfGUPmu7daM8OQ9Ow9PIv1mTiztAsqLNEAWnrh6uCsug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee445a4-61db-4a4a-ba68-08df1de2804a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 04:31:16.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7fOTro67c+ZSDF4zco/zHA9DDKCPvYCMoF+Z05FEuWBcrR2gDc+p9+El1Vboz7JG/WZTIJkLx++LVIwt60+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Monday, September 28, 2026 4:58 AM
>To: Sanjay Chitroda via B4 Relay
><devnull+sanjayembeddedse.gmail.com@kernel.org>
>Cc: sanjayembeddedse@gmail.com; David Lechner <dlechner@baylibre.com>;
>Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Jiri
>Kosina <jikos@kernel.org>; Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>; Benjamin Tissoires
><bentiss@kernel.org>; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.=
org;
>linux-input@vger.kernel.org; Zhang, Lixu <lixu.zhang@intel.com>
>Subject: Re: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID senso=
rs
>
>On Sat, 19 Sep 2026 16:06:23 +0530
>Sanjay Chitroda via B4 Relay
><devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:
>
>> Following feedback from reviewers and Srinivas, v4 series was split
>> into two additional sub-series to perform cleanup and preparatory work
>> before adding devm support:
>> - HID: iio: warning clean up and prefer kernel coding style
>>
>> https://lore.kernel.org/all/20260707-15-jun-hid-iio-alignment-v3-0-879
>> 1574ad0fe@gmail.com/
>> - HID: iio: basic clean up for usage_id
>>
>> https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v
>> 2-0-c3c5f0720493@gmail.com/
>>
>> Both series have been merged into IIO tree. This series introduces
>> device-managed APIs and converts HID IIO sensor drivers to use the new
>> devm-managed resources.
>>
>> checkpatch reports a "suspect code indent" warning on the
>> DEFINE_FREE() declaration, but this appears to be a false positive
>> caused by the macro expansion. The code builds cleanly.
>If possible, Zhang Lixu, would you mind retesting this full set?
Hi Jonathan,

I'm currently on vacation and will be off for the upcoming China National D=
ay holiday. I'll retest the full set once I'm back!
Thanks for your patience.

Thanks,
Lixu

>
