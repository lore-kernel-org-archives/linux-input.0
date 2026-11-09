Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794190048;
	b=06VI4OPFMlBo8AkopCTsR/Wn1w2JZps6Tggha1eHuxD74Vz4Io7hg5JnZAsM+DL8YVpZ
	 C3T8/vjY6O0VHeuZ4xhRMcOBks0DIKh+mOpRIbSLThzOSsMY+kATQ84jQNr0QczAVW+RM
	 fM8V6FpLL9loka+BFpB4MLiUmoQr0olYGR1vQNObnrlIkU9RXjnKOYGexWDCZNgmwv0Ti
	 5eAT/wgkUvMhEv50eeFBOkx9Jbl8uoOoUxTmU+sSKVabo15EWGLvFAid2B2KQGzcpdkAH
	 0mr52NqbR0avoSDHPyoanxkp78vRgxNLptYYFIx8xrbUxPNGS7U+786VVrXziuPSh5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190048;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=VbvaCSg+4XwsWwMkx3VSNDfsbaK5QoTzVv9IDqxNPk4=;
	b=Sfwt96m8rEt+Q7191cvkwhIpmi89f05n0Pr3ihEez5mkgfEFcX4SiTR3glygRX9SDpDd
	 Gz5hOhQ1yFiM88wl0Ei7S0D4reLgtGW1B1faIn4X8tjYjvn7kyHc6Pj4t0fJ6C80+9f2p
	 Hu4KVcjTD4uHQyoz1kKIvefCtCvN3F9oFjAE3gaiNPahRTcmyUyGkelH/onUE8XqX4b4y
	 V8WlbZ5Mm16FnKPuFBW5MUmqlLSwDv2Aw3s16QImyGeycF8RlHGQfNPb9r/g1ZEEz3MW0
	 F4aKjtVcypV9ecI8gw1N4+dXnyN7tdUWKihYi0YQsTr9M6Pfleqv8v+FYhiVYkovUQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QJc8ZcG2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94E606A336;
	Mon,  9 Nov 2026 02:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D94E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QJc8ZcG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794190043; x=1825726043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9P3iFVqafn2Ra0q6Gmddf419U/uYaGwUtKTISmNEtI=;
  b=QJc8ZcG2Fgjdbr/9/cAW3i3p8OzY3SQnNLkaTluWyCdF1GQYTDq+lhja
   mpek0hm3sqsW2coO6TA+eRiYummzEOSxN4OY4gv4pmTbeyRV3LRn7/dWG
   uDoQvUlR/9f5lA/UhodqlGAdWbdKZavBwydm65AM+6MVn5h89OksqGr8h
   Ax0SfgYWln8bRnWmAt8qv1Z52CB9RUuLEMqBpbOu9ZTaprxzUzp81bWQ7
   9xtzLV0VQWdWDkRJ2klAAbtYghawQujDtd20QmoC0GNL5LyaXyadJaEuz
   nseKHXxU9JT8oamNH+mW1Afp1Ctpiml1S2nlxdLvOfYZpKx9n+5xojjf2
   Q==;
X-CSE-ConnectionGUID: iqwz8jukTcG5CZjxZRcWmw==
X-CSE-MsgGUID: zpXggt3TRkCVoZu3peWxWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2954407"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2954407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 18:07:22 -0800
X-CSE-ConnectionGUID: WmqjdgjxTXuvNlohcoh67w==
X-CSE-MsgGUID: fJqs7slnTviIfxDfEX0PwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="8092130"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 18:07:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 18:07:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 8 Nov 2026 18:07:21 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.13)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 18:07:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzYUhFLMabibQa4F9NHjCFY/7TYzP75svYUmFb9rujFe7VEozZmsc+odC8xAMHMl+CSwiEcQf2XJ7VoZOtnHKjmo0jOKZQ+72ScKBer91pLyy2X2Tt7hdL+nuLwkSbQpn7tmKtd1nG7Ag3gmbU2RO905gwJUjBZ5sjRTFwEqREKyHwrfWaTH2v6SB3qLFskSRZZXO1kFnquSqPKRME9UCH7Nxvkii5n+CyUR9ALspdF/8cwuKbHUctv2Vxr1whV1vFAYj34pbTj2skEUf+3rnjvrU8R04UvlZODTOlq5yAvns5NPsVFVXhhbMbGm5/X+X6G+RY1QoOMU7JM20k0ZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbvaCSg+4XwsWwMkx3VSNDfsbaK5QoTzVv9IDqxNPk4=;
 b=IOjA6A37nab40RoJoQA8poWPDpNeymOZ+DtJgsV8c0t7fiNEWCp4cKB/HMNWaFiYR7qpgYGUqVyV9dBfuqZ2r/5D8AidDdUpKYZQWshFcohblvh9p5pD2jZ/nPRh9V+cUt092jZDbVH3mKODA0vFHLEN/OOUtL3ITMV0xtI0O0vUsJERkogyIE6ZZ3Cs9AAp1fjElo3NmCvzdYi9+OG58tBvXhRIFMz5FMS4nm5QSfbbnbgaXCKW34fsYXBoDNU+RpB0rPS5AxXRy+y3b93COYeZtjxQZzagRDlbY1ND4Ep3TnWSwJ6CmJ92cmmiofyvdaIay0gYvPJHYpZkS8vc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:07:18 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:07:18 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Mathias Krause <minipli@grsecurity.net>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: Intel-thc-hid: Fix REGMAP dependency
Thread-Topic: [PATCH] HID: Intel-thc-hid: Fix REGMAP dependency
Thread-Index: AQHdbUdaJbpLqvTVO0arhDuC6vxK17clA2yA
Date: Mon, 9 Nov 2026 02:07:18 +0000
Message-ID: <SJ0PR11MB7704B8C0874B0349DA543759F4732@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261105170116.3193223-1-minipli@grsecurity.net>
In-Reply-To: <20261105170116.3193223-1-minipli@grsecurity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: 86871fff-2da6-44b2-f9f6-08df3e062ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|38070700021|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003;
x-microsoft-antispam-message-info: zP1uUKCcsaIy0naek2c5Z67WSMjDdm6mdiklZRE3JPpG31bWLDUps/1ymiiqH/q5/Von5yyglYDBB2Zql9SpYkS5bqSbj4eNWNLidf9mnE9ZajojxaCMRaO+rZro1MO0gftpLiOJQf+yMqKFKmoi2L8O3h3rU8dMY9Az24DipSUsHPgPLKDpB8Dvk0OqjvyxfelPrExX7vzB4rzWeer6B45CYkIm33kcZtbMeuQ9iFzBNhKbsEtVKb/xDbHQM315wxeFMKFmKeRAM00w9Wqc0VKRQkbW0tnkkFt0SUbxtAQR+x+OWsMrbpRUX78JqvWGYJu+xlF+r+IDPT3i7dE2Rzhj+92Ku5GohZHtrybHBdkiYQVIkmv9wiriI2FO1Mv7brlpDJXeHNgZ69nk1LFIxAEuQmCaD6YvyoNrSaicyKr0C2k8oJD7+VAbkkhWz8c0KnF73/KxlFfsLnUVGs5VxART6wVjxHK19sMJT8mQVQ0A1l422JzfdO0oiGfQASpJ1qv8R3a9eGIwhgE6l8+Ror7jOvNTWtfjev69+ZqhE4ATXUdafOVtG2ZgEHWvOl6AwULxfAi3Zy49uMdj5n8e+BzIW5J96OIthHpiZk1P2iYlTK+mthQu2hsIyGhwiuvMGKA1TYFa/Z5r67rFFw+90ImbsyCQ+uFPWuCcZ2nkdW+3PdYFCrovcm6FgsC/jFahWJCKMqiChJmfI+cDOwHM8hNVFX4oX8g9MnsV7EBLpIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bGDfTSq8Me+tBUURXfG46ya9ctORmBnwDV1FPPaditW8YpY2GSSI5t/SVFcM?=
 =?us-ascii?Q?nzjymNYcIbRuy1Ixj2G0hCKHHkS0+i44LspSXsu3yI0NNG78ckrj8IzMo9va?=
 =?us-ascii?Q?mTaz9KspWgRsLIZ8KediBhdJaxG25LG9udz0VgrTfJOJGDMBAaSha5CLha2j?=
 =?us-ascii?Q?dqiu2CHhFSy60ZNfEWWEM1mhREM6xi7e/dKep0o65bgJ3Q6LOGEmLuHEH0kT?=
 =?us-ascii?Q?FTGEvzqA3cFOmeb11kffdYC0pKUT50zzThmpMPtex0hml1zDZ/WEf1U0OwuH?=
 =?us-ascii?Q?JeTCnoUn0kJTp/49qnLzV6SlOf8JpLe5zrMO0uXsbxAHOsyS0+M8hBjZ/g2z?=
 =?us-ascii?Q?KYkrlTEQ1hfFflFqIwGkWgAqiJg9bduj9JI3KaKEYcfHyEn6wU240s3X3LbB?=
 =?us-ascii?Q?qCF2QxlXs21HA+oN7965MZDKeke/PQ2UM9zI6mDFVXyMMVa+OIOhL6XviTUA?=
 =?us-ascii?Q?mqPhhu3o6/3Ol0Ow/NWvIWyB97py+BY6HQMkNKxNr6mNrsW0nANDl7QdXY8u?=
 =?us-ascii?Q?K03hALp2PCsEVZg8sGdFrVplMB2IrdSDVOkuRYzH/U2vnOOUSxKfNc36IFw5?=
 =?us-ascii?Q?mPyYox0EF9jc6lHe5XWJ4ulsfTyT65UJN5yLCLoXMzLfDprjayF9QybIiE1k?=
 =?us-ascii?Q?Qu3+MUn/Swehq5VvBTNXffPo4umYjsu/OkQSovn94dkXKMwITUyGCkco1XcI?=
 =?us-ascii?Q?kvfjuyuVuBSF05sHsfVqTH8UEVtUlZuCOyBYilsMurMkQ51/3ozynSS9JvJW?=
 =?us-ascii?Q?huQQ04cMg+nD1tV5LLC13eVs1Nag6JTMDIWBZAwBVOTDZHMIVWafGPZoZ8yp?=
 =?us-ascii?Q?+MKjPUerNKj9NxPHjclbDUwj4NIUQmv2eMowNvwwhKsA5C7uMDB/4Z2bObeL?=
 =?us-ascii?Q?rk0DVSmPtWUffHZSM2sbOSIbVln4NgRw/arsFmMHEYOdLgTaYMMjkLiD/IY/?=
 =?us-ascii?Q?xCVfqCE2U7K2Cllef2EOf0JkZBvSyp6HSGy3eDpj2QdGhbFl8UHFnh0VlCga?=
 =?us-ascii?Q?JQOHXXEf5Z5KnPmbWQqCZyVkiUXlJ+bmy04wqK4FHP1TkM6d4apyxgSV3Z3M?=
 =?us-ascii?Q?fedL2pgKWfSn5F02Jpz5SS3OVU3h8phqBMvCNn2h+KR25b7iyMSgvhWmEwtO?=
 =?us-ascii?Q?4DGc3qyA73gN4i4NOTNfQ15SYX2Rk4jS/pvHUpda6pUYNvH2QLC4a6j6dJUA?=
 =?us-ascii?Q?EceNSoxYst7K0XReFYP7ir7yekX6Qe3QnhqSA2nPBiOvefuFV2a5XQugIRNf?=
 =?us-ascii?Q?fVtna+nYOQb5VMnqv+emUXSh4DTelATuZwNKZQXzkMAk8O8jwZ/qYlfJdU2H?=
 =?us-ascii?Q?mW4N/5c6ApJuxTlVHhVb683PGiH7P6SuJfSgLuYHHHdhg7uZ9yrlKrw5VSeM?=
 =?us-ascii?Q?2tbkxQQKiOHgGynRK9dFqK/BiMT3CvRWXvpKVN6AZ4SK0XV9DbgQVnGa9rpd?=
 =?us-ascii?Q?ZYI0lSGNIkUAQPP5ep2I9m7Fs/rccKHs/1kXV82m+if7/wBNHsWx6dqT4dK/?=
 =?us-ascii?Q?ECcFLHOIS905ZVFhN0WBhe9YPVs6H1+39EekkYrm6n8j1QEoo8gfxl9hsNlb?=
 =?us-ascii?Q?kCVIuC4cQkPh7+cc64SEAyk7M98ZAi/DO1kM2n0ArYf2O6xi4UgIRt2UOEbJ?=
 =?us-ascii?Q?shs38sXO6or0cMwSWNnBFz2fYhMQssK9YKij0ZgK5m+6Qwxoi9om+4aMEG3N?=
 =?us-ascii?Q?kyxL8eavWjfV/KSfM/67TVj/gGf9qIZKAMyviIAHZxpw5Pp5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q57T0s58sr98IB/Hjs7paqVd/XA0cI8ej/WEaO0EmavQ8piU1lVRR46SmQjAx/Tc86FMr21XHGY2QFJX61mJsnv4lGsiOIWlrdF4cnMZnDp79qwFH0a3u0TKfmkFaV6OcRYBQZzT3S1FqToaZz6biZwuz6tsc5ZmNXgLAnT1vYmjRKyr+JBkgX8HRb3IXo02009OzLCUIbIpYrvO52x4/vdX5ijGo7fA6juQvEelRuh7SFHl9gc4RW7rn9BT/zgrK7/hLy7mXExvZRBp0TxD5Cgskm5cSlw/FsBMvJ/IPWIUDc1bB21PDKxH8UDx0DlE1IBV6+BT/IwFnRIZV3Aemw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86871fff-2da6-44b2-f9f6-08df3e062ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:07:18.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRYI+7vMs7PPLDDzESjZ5LeVLboKCBYfP2Wae+UAHhNRZ/msgyl2cHOtDz4bxQe3l06RyTPH2sIScHvIe3icSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Mathias Krause <minipli@grsecurity.net>
> Sent: Friday, November 6, 2026 1:01 AM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Mathias Kr=
ause
> <minipli@grsecurity.net>
> Subject: [PATCH] HID: Intel-thc-hid: Fix REGMAP dependency
>=20
> intel-thc-{dev,dma}.c make use of the regmap API and related data structu=
res,
> breaking the build if CONFIG_REGMAP isn't set.
>=20
> Fix that by forcibly enabling REGMAP when this driver gets build.
>=20
> Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  drivers/hid/intel-thc-hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hid/intel-thc-hid/Kconfig b/drivers/hid/intel-thc-hi=
d/Kconfig
> index 9d74e53b8c62..57a1e51cb512 100644
> --- a/drivers/hid/intel-thc-hid/Kconfig
> +++ b/drivers/hid/intel-thc-hid/Kconfig
> @@ -8,6 +8,7 @@ config INTEL_THC_HID
>  	tristate "Intel Touch Host Controller"
>  	depends on ACPI
>  	select SGL_ALLOC
> +	select REGMAP
>  	help
>  	  THC (Touch Host Controller) is the name of the IP block in PCH that
>  	  interfaces with Touch Devices (ex: touchscreen, touchpad etc.). It

Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

> --
> 2.47.3

