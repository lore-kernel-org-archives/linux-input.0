Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794374810;
	b=yeBkd68Fq6R6f+9UkgQEJhrFzaulk1PHVkqA5USaLbJPJird+NGqT5JZnv+FR6M2+3ck
	 UNI2mgZyTDrRcLEaIIQPxIBoh/fhA7SJii5NYcJhla8rHdcfsk3Apir7mgyNgxYKos4/a
	 vpJZ5pc5+JZURTL/NsgDAUhN6dh5Rf2s8Jo+wTaLByHfIK52mhJvlw1Jg54fxZRxeoPoU
	 vwo/vrNEylBHEfZF2B6QsoY3uxhdhoglQkWI1COngxDAhMG1SfcnvO82BDqBz9GQVvPN4
	 qvIwQHRdATwSQkTdP0XlyPOyn5qSRlEpkC7SKZtzTqHM4w1uCDwUBZaERsQ2oefZMNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374810;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:Received:DKIM-Signature:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-dg-rorf:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	bh=NtqTjW08yOLcInLPVki49Dn37kM1KUOIPmP81ZBmiGA=;
	b=hY5URPtXFZYvXk0p1WqPoo3n0n0muQZmr1SBm/8DHWZV6rcxwjAm0Ml5HIO08ZIuM03B
	 eODYPJ77BcdKDkOSm6/T/sK/+Q6RV7gicbuonbHTMj/aL1GWJvlQYzkuUeFS/AhnX9Mps
	 FXX7mDCSJpF8wqku27H0QzBghPNiPauVXZ9WteV4nVnymRBuquJ5jPFq7qY2CguEa6GOa
	 bElocAkR+n3QTGwG0pTxNxqk/sbkUr3Ccp+M0ZAt9QOmmIq5WaThJsBjjnaMdmmvpJn6x
	 WB3f6122kdPva/le/1MwvLr1VtEFEkz1GxmI4we9kdShdqL5BW817Ou81+Emp8aOPjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=emc.com.tw;
	spf=pass smtp.mailfrom=emc.com.tw;
	dkim=pass header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b="h/UEAqsP";
	dkim=pass header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=MuO0vT3z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021B606A320;
	Wed, 11 Nov 2026 05:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8021B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b=h/UEAqsP;
	dkim=pass (1024-bit key, unprotected) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=MuO0vT3z
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com.tw; i=@emc.com.tw; q=dns/txt; s=emcselector;
  t=1794374815; x=1825910815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NtqTjW08yOLcInLPVki49Dn37kM1KUOIPmP81ZBmiGA=;
  b=h/UEAqsP1DEfqe8mldwHfAU9SWLq4Am6xtyADX6naiF3EhdLsQ3Kqy8O
   khRBpIn+mAjyA5F0u8BH4ACGzLvQbtH+MKjBlsFLm90Xbi+TUwkJw0+EF
   qnpb64VzdnVcRrN7gtj6FSL6ZN1ip1H0SgrMD1iWZlK9XgmRO+y5UvtPX
   SuftHMFfEErQxRPBZyGtripmXgBD7wKMeqVW59dipv6scK47ywDsLDd/w
   EqXZr4mUrGyCVprSxAaycwRhUvp02uP0ZBIKVowzBXKnD6fI81A/gge9c
   QXfVn5Jw7JcJHEcsQkwOl8ooRLZZGTZ/Eybdu27+OZk2U2HgDrr4FK48O
   A==;
X-CSE-ConnectionGUID: +Eti575bQbOBOpYfEDtusg==
X-CSE-MsgGUID: 0uolAK++TaGhwwag9rXlrA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="14844188"
Received: from unknown (HELO ELAN-EX01.elan.corp) ([192.168.10.67])
  by emcscan.emc.com.tw with ESMTP; 11 Nov 2026 13:26:46 +0800
Received: from ELAN-EX02.elan.corp (192.168.10.68) by ELAN-EX01.elan.corp
 (192.168.10.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 13:26:39 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (40.93.129.123) by
 ELAN-EX02.elan.corp (192.168.10.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 13:26:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6xfxcKecJLLcDOqt+xrde88V2RCngEeX+alBpWfnCxl9dK94+so/w91PIwkuNqgD2LI1yF5lPir7Fufqvatz58NKRdXsFFI7UJhOIHyWM4V3EtuHzb9J7iRwtHTQRyApG8TfbnYGjVZDqEBqhfX2NLinxf5fd50g8UYiR1B+icmZ4pkVVq7cJlGtlaUYlMD6jX1Ec63sO6hfa/M1opVXzMvkazyeuJ6e0NyKqxfwbS/AYBC8Ow9dMKWP55QnyRWouqymkLR/NNICPeHveeXiKf0FGIpVWhsK9xhEXtAqg0Mk/WSVkGOd7ECXTRvUldkvQTgj0xz7dOFlpJPJQtkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtqTjW08yOLcInLPVki49Dn37kM1KUOIPmP81ZBmiGA=;
 b=LmqHNnS/RRU84YUN0paxQ6aLK9/oKLAU0D/dKe2l67qc2iSeP/Ei1xZVP8+z5j58MneObXCWf0anuCpYBtrqVCXoEcLkUPl0SWCWTiZL39LpYSDnlPwnkcZ1u+UpDuyoyWDlQYxvveKm0jkevITxc2WFlYYyQWkiWwLxfnEL5rNQdm9uEezLq4JGm930Lb1albuQZknvP+lniKFCR3LR8bUEujbduSVskrkFn5E3E9Mlk32j63s6Pz141z7SjPY0hdI5FsW9z5SW4xEPrf+7qVY67Tya63BUJXRussJmxZTRbidsjooqKlkHbZuJLkzmN+YUr0owZ20EIDSKbsYvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emc.com.tw; dmarc=pass action=none header.from=emc.com.tw;
 dkim=pass header.d=emc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emccomtw.onmicrosoft.com; s=selector1-emccomtw-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtqTjW08yOLcInLPVki49Dn37kM1KUOIPmP81ZBmiGA=;
 b=MuO0vT3zlms2I5oPqtyN05rMG28UNr4FuTDmh3FolW5P5UCF6FNhzuayiTUCcMfMJkF8RAaWm3lRA9jvcF42dM7JH9irD4w29LZUs3OZhLlZHCSjNjv4mFa3EijpjUdRno5p2tr6R87Oz5SH+5YRxE/U5Zp0Q7Bi8r0PRzNCDcY=
Received: from PUZPR01MB4774.apcprd01.prod.exchangelabs.com
 (2603:1096:301:fe::7) by SI2PR01MB4203.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1aa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 11 Nov
 2026 05:26:36 +0000
Received: from PUZPR01MB4774.apcprd01.prod.exchangelabs.com
 ([fe80::80c:cfd7:534c:1ca9]) by PUZPR01MB4774.apcprd01.prod.exchangelabs.com
 ([fe80::80c:cfd7:534c:1ca9%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:26:36 +0000
From: =?utf-8?B?SmluZ2xlIFd1IOWQs+mHkeWciw==?= <jingle.wu@emc.com.tw>
To: Yao Yuan <yaoyuan0329os@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Vishnu
 Sankar" <vishnuocv@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?UGhvZW5peCBIdWFuZyDpu4PkuJbptaw=?=
	<phoenix@emc.com.tw>, =?utf-8?B?U3RhbmxleSBDaGVuIOmZs+W7uue2rQ==?=
	<stanley.chen@emc.com.tw>
Subject: RE: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Topic: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Index: AQHdcLxNHDP5k3yfMUe0H4sA60xFjrcmxlaggACMhQCAAOLloA==
Date: Wed, 11 Nov 2026 05:26:36 +0000
Message-ID: <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
In-Reply-To: <avMcB0q7wF9oP5X8@sapienza>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR01MB4774:EE_|SI2PR01MB4203:EE_
x-ms-office365-filtering-correlation-id: f81a323f-5ed1-4501-0f38-08df3fb45af1
x-ld-processed: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|18002099003|22082099003|3023799007|10067099003|38070700021|261028144727099003|261009223027099003|56012099006|261022105027099003|261102123227099003|4143699003|261021121427099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003;
x-microsoft-antispam-message-info: E/V9bzSDtNgnvl780tp2XXntHYQB+yqpyn3D0XVN3ULHgGCSa3Ig0g83GlJSN/tYlJwJrKvtGzhQMnd0ZT8KpNSJ4T5b5E9mNkkPfZXqltDaVq9K65skQeElh3X8/L3kRftdIkN4OvU+1he597V5WCoCoec2FgpkiI1WaS+yHmwxX3xqwQdRzmIKVMSdssCo5LODW7qOPOssnAlFuYc4DS6r/j6qemOBd9/3ZQzy6CxrnxEPXo/Sbj6YSgGkppPjJnNpPUs9xETeluLOe9c6W8rxzi5d7+3o9ApIQ3CUg7TvSxS68s4QzCoVerSxvyH+CkWfmED7jSzVTc0ET0dHllgHkno2uffiB3YKkGBAPmhL7Tlh7M6hI2k21RSafuNXcGSkoa9LTWcDWScPRE+tfpyzE55Lw7BqDX0htQQUPkb0iShwOq9VIZv2Vlt6mRN8eWf4HOL0/6MRU59uDe8SuDjCTaftiRdVNwa6I0DJ/YYVU3lc8qNxmiAuPlXtAYveVUKHh5Ra8fCwqgl/D++jH2BnxsYvqi5DOqkMoc6AGt3xoy/OWH2xYC2jGz6nquqMtZ6T/6aJCMft4ZF87tLjoDFIHkRU6jw9uqdBmn3jJKTZfBxhTqTXXVElhavFgAnjTPh8LWakuszZaWqC8pWYKFeKbTPpQD8IIPkCEhMUepcG08LYrkOyIHKMLq8FaMXPN4cEAPjgRK4bytnjeFXlkmNtAhm8PBPsiR+T99uWtes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB4774.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(38070700021)(261028144727099003)(261009223027099003)(56012099006)(261022105027099003)(261102123227099003)(4143699003)(261021121427099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3hBdVBxMFYvOVd4dCs2N3hIbEpKT0RpSDlMTWx1VTMwTURHUHdjRXBSNTdl?=
 =?utf-8?B?UVowU2FTU2tZb1FrQUhJaU0rTnhNS0xCeFdKZGhHRXdGYU5pRG5nZzVxU2E0?=
 =?utf-8?B?NndsMk9EUlJuNzhISnpDVHlQTVRNTnlkQ2NYYlJxeTd6Z3N5Zi9LUmJzRUVi?=
 =?utf-8?B?d0xqSDdFN2NQaml6aTJrYnhjUGt3bFdiUUNwWnh0eEFaWXNucnZqNkFmMHIv?=
 =?utf-8?B?QjdiTVIxRkdGNkFiNEVFT2FuYklteFYrc3IrenlnTG1pNkFGUGxNcVJDNUs2?=
 =?utf-8?B?NDRmYTFUcjJEaElYZ2hJMTNObjJDbnZwaWsrSFdYK2dRWkEwVVdyTlNBaFpH?=
 =?utf-8?B?MmNDS2E2NGpjeEpYNGxaN3paZW1BOXVENnlONUIvL0Qrb1M2K214MHU0dEY3?=
 =?utf-8?B?cWI0UUt0Z2IyME9vSjdRTG5WSTBhbUlDZ0JSZnVkSzU3aFNrRWUzVHFJNUZx?=
 =?utf-8?B?N04rVkJnK0JuVzNtWTNRdi9rZndkb3pmSWZnVlE5aXNOczQ1ejdUVmlhNjRp?=
 =?utf-8?B?ZjJ1VEdGK2o5TVE4WEtESDgrWS9YcHpZNEZCOGRJRStTbTI1Um1LdkJiN052?=
 =?utf-8?B?TGJUREd3Ri9pNmY0Z25rTzNuWkVQSndBcWZkaXlsTmorVjFPMVRsQlJLbExU?=
 =?utf-8?B?aFNvVEl3dktyc1ZsdzRxczNybkIwYk9nc3dXV1BYN01pNjJVTW5RYmJxWmNt?=
 =?utf-8?B?a1MzdFUvYWp4bEZaUWs5U0FpZ1EvaXNHK1MvbmpYeTNoOG1NRjBld1VDUUM1?=
 =?utf-8?B?QUhyeHc2ZVl3SkJmWkF0Z3RUVG93Nnk3UE8rVVVRc2JKVnVSMlUyQk01T3Zs?=
 =?utf-8?B?YTdNdjFQczRNZGl0bVZ1M25JcU96M2JrY211SHhyYWg0L3dacXVuVTJzZVNk?=
 =?utf-8?B?K2NJRGJBSkZYVHRxaHBOV1JRUzZiY3R5REFheWVMZk53c3Awdks1OVViQytB?=
 =?utf-8?B?RXMzK0lQOWdrakkxVHg2WXZLckFlRG5FUmdoU0lIOTVsVXM2YVFZVDl2S1lB?=
 =?utf-8?B?dlBESm1OZEJCSmk4bzl6b2RtVDF4QXpLRm1lOXVCYm1sSWxxZ2pUbXNtbytp?=
 =?utf-8?B?aXhaZnpXKzlxU1BZMlpUemE3OWdoTHpRdlAxSUVBUDk4dVJnbFlXUmZTTzlE?=
 =?utf-8?B?dUtTL3Nib3JoUG9JRjMrem4xb1pkUXduZis0anRCUDFueW9PRXFTQ3FiUWRV?=
 =?utf-8?B?Ynp3R0xDK0NqUnFjdmtHeXo4N2tGR3kxeFBkVmR5L1JQTW1LcEVqMEt2TUd0?=
 =?utf-8?B?V1l2cktKN1NXZ3pLMStGRU96NEtHZno0S3Qzak9qOG9NdFp6Wjdwbnk2eVZh?=
 =?utf-8?B?N0xyWDVlSDNRd1F3cnJzZGtuZUFRTUcycWNQRmk4aUlrU2MxRVRRS0kwdXcx?=
 =?utf-8?B?Zy9tYjdBLzVmeXViTnJ5RDd3eTlDUDROTWhsNkFIc1p2VWdQSEh1eWdGeTB3?=
 =?utf-8?B?MmhxTEg4a21ONWhVSVVlYnVZY3dOa09IMDIwN2dIMjJIY0hRelAwVnN6T3pu?=
 =?utf-8?B?UHVlTVFrREJDSlh1aFpScTNYbmZWbXpTUUhTT2tCMlUreVp2TGZaWDNMcyth?=
 =?utf-8?B?T21rR3FLYWdBNjBYQlVGZVFyN0x3am4yajRIM1N1NjAvdjgvcDYycUdTdlkv?=
 =?utf-8?B?UkYrbmpoQ3phclRIYTh4Y0VRcWcwSmpRc283K1pUdlk0UWVUc3JYOGpkbE5V?=
 =?utf-8?B?L01QcFNXcHg3anAvZkxRWkxFa2JDL1QxMThqY1BRZkFXem9yZlplSktQRkJM?=
 =?utf-8?B?MnJPRE1EcTN2RjhKNWdiTS9xWUFVWW1GdVA4WUMvVWZBUjBOeE1sOXg5VnVD?=
 =?utf-8?B?VmtNd3h2YUU4eVlBTGZmdU1YQzMrbitvSEJGL0cyNDJPTTNCUHE2NUlBQnRq?=
 =?utf-8?B?WURUcmlGTXJDeUVJVzJlVGdiTkdHNk4zRjEwMHdUN2VORHVIditmbmRMYmZk?=
 =?utf-8?B?aEwreHdia2lSYWtpWE5Lc2sraUtzWjNDNW1wNmsrWHpWanc3WERrNGdPejlS?=
 =?utf-8?B?Tmk2clNJNGc3eWU4eEgvN3hnTjU3R3hGdG5MSjUzZkUvTE5ST3FZWE02eWcx?=
 =?utf-8?B?YmtkT0l5cGlvaWlsbnpvR1c3MjlzWHRkRk9Yb01JeEJxWFY2aVBKcUpMQWFx?=
 =?utf-8?B?OFZLVndWdnBXbjJRVDNzbVkwbStpSm1ibTVlRjhENEd1dHgwVTlRT29kMlRr?=
 =?utf-8?B?MzhXZWN3VS84ZnNQM2NRWWZETTRFeXFTc0YzSGNKbDZYcWtwSWZlWkMraE9Y?=
 =?utf-8?B?WVlsTGpHT1Q4ZUt2c3NkMHUyZGJxeDJhbFFnOFVvM1dYcUI1UlJqMi94dFFi?=
 =?utf-8?B?NmxsSjZqV1NHWkwwZHZ4dTJRbDRqUEFnNXlCbUV3R1N1bFhhVGYzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MH10IfR8w9xNxL8kebtVSZOT9KS0G+tiaVVmcT+O4c3jGjV5ij9H0H1hh8rwMlUeFv5QpIpKGeb/OjTGTE5tsx7DozBQqlzSa8n8yC5bTZpYHFk5WLRkH7ju86lmXOiWoWsk5DjZ4tnTg02JHAsHB+PtPcaniarq6uqT8xGL6m6e4XyNbt5c68aq3IEPWivMV1HOmmlGa82i4XDYbWYk7zAU7MCWSRRa4bvdQBhcfcfoag1FS1OVejyWvO/2YSsSNSbMdfSEwGQQ9AQdj7zaFi7BVpjkgSE2umyxNBacSQP11fIMA3OK8L+O32keIWrMk1CGIMneUSg8iRUdShnKIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB4774.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81a323f-5ed1-4501-0f38-08df3fb45af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 05:26:36.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbDtFjliOnovp+esrITtW3p6mdPx7ZInQfRA9u2w/SHnQUNLIwGqxhTNd6HKDo/hTRiLoAy/WedH98iqVK9AyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4203
X-OriginatorOrg: emc.com.tw

SGkgWWFvOg0KDQpDb3VsZCB5b3UgaGVscCB2ZXJpZnkgd2hldGhlciB0aGUgY29sb3Igb2YgdGhl
IFRyYWNrUG9pbnQgc3RpY2sgdW5kZXJuZWF0aCB0aGUgcmVkIGNhcCBjYW4gYmUgdXNlZCB0byBp
ZGVudGlmeSB0aGUgdmVuZG9yPw0KDQpXaGl0ZTogRUxBTg0KT3RoZXIgY29sb3JzOiBPdGhlciB2
ZW5kb3JzDQoNClRoYW5rcw0KSklOR0xFDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBZYW8gWXVhbiA8eWFveXVhbjAzMjlvc0BnbWFpbC5jb20+IA0KU2VudDogVHVlc2RheSwg
Tm92ZW1iZXIgMTAsIDIwMjYgOTo0OCBQTQ0KVG86IEppbmdsZSBXdSDlkLPph5HlnIsgPGppbmds
ZS53dUBlbWMuY29tLnR3Pg0KQ2M6IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdt
YWlsLmNvbT47IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT47
IFZpc2hudSBTYW5rYXIgPHZpc2hudW9jdkBnbWFpbC5jb20+OyBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBob2VuaXggSHVhbmcg6buD
5LiW6bWsIDxwaG9lbml4QGVtYy5jb20udHc+OyBTdGFubGV5IENoZW4g6Zmz5bu657atIDxzdGFu
bGV5LmNoZW5AZW1jLmNvbS50dz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBJbnB1dDogdHJh
Y2twb2ludCAtIEFkZCBuZXcgRUxBTiB0cmFja3BvaW50IGRldmljZSB2YXJpYW50IGlkIDcNCg0K
4pqgIEV4dGVybmFsIEVtYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRo
ZSBvcmdhbml6YXRpb24uIFBsZWFzZSB1c2UgY2F1dGlvbiB3aGVuIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMuDQrimqAg5aSW6YOo6YO15Lu277yaIOatpOmDteS7tuS+huiHquWFrOWPuOWk
lumDqO+8jOiri+isueaFjumWi+WVn+mAo+e1kOaIlumZhOS7tuOAgg0KDQpPbiBUdWUsIE5vdiAx
MCwgMjAyNiBhdCAwNToyNjoyMUFNICswMDAwLCBKaW5nbGUgV3Ug5ZCz6YeR5ZyLIHdyb3RlOg0K
DQpIaSBXdSwNCg0KPiBIaSBEbWl0cnkvWXVhbjoNCj4NCj4gV2UgaGF2ZSBjb25maXJtZWQgdGhh
dCBGVyBBMSB3YXMgbmV2ZXIgcmVsZWFzZWQgYnkgRWxhbi4gVGhlIEVsYW4gVmFyaWFudCBJRCBo
YXMgYWx3YXlzIGJlZW4gMy4NCg0KVGhhbmtzIGZvciB5b3VyIGluZm9ybWF0aW9uLCBMZXQgbWUg
c2hhcmUgbW9yZSBkZXRhaWxzOg0KDQpUaGUgdHJhY2twb2ludCBoYXMgZHJpdmVyIGZyb20gIkVM
QU4NCk1pY3JvZWxlY3Ryb25pY3MgQ29ycC4iIGluIHdpbmRvd3MgMTEgb24gc2FtZSBkZXZpY2Uu
DQoNCkluIExpbnV4IEkgZm91bmQgdGhlIGRldmljZSBpcyBwcm9iZWQgYXMgZ2VuZXJpYyBtb3Vz
ZSBkZXZpY2UgYnV0IG5vdCB0cmFja3BvaW50IGRldmljZSwgaXQncyBoYXJkIHRvIHVzZSBkdWUg
dG8gbm8gc2Vuc2l0aXZpdHkgc2V0dGluZyBmcm9tIHN5c2ZzLiBJIGZvdW5kIHRoZSByZXBvcnRl
ZCBpZA0KMHg3IGlzIG5vdCBpbiBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuYydzDQp0
cmFja3BvaW50X3N0YXJ0X3Byb3RvY29sKCkgYWZ0ZXIgZGVidWdnaW5nLCB0aGUgdHJhY2twb2lu
dCBpcyBwcm9iZWQgYW5kIHdvcmtzIHdlbGwgYWZ0ZXIgYWRkIHRoZSBpZCAweDcgdGhlcmUuDQoN
ClNvIEkgdGhvdWdodCB0aGlzIHNob3VsZCBiZSBhIEVMQU4gZGV2aWNlIHcvIElEIDB4NyBhbmQg
Y29va2VkIHRoaXMgcGF0Y2guDQoNCg0KPg0KPiBUSEFOS1MNCj4gSklOR0xFDQo+DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRv
cm9raG92QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTAsIDIwMjYgMTA6
MzYgQU0NCj4gVG86IFl1YW4gWWFvIDx5YW95dWFuMDMyOW9zQGdtYWlsLmNvbT47IEppbmdsZSBX
dSDlkLPph5HlnIsgDQo+IDxqaW5nbGUud3VAZW1jLmNvbS50dz4NCj4gQ2M6IElscG8gSsOkcnZp
bmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT47IFZpc2hudSBTYW5rYXIgDQo+IDx2
aXNobnVvY3ZAZ21haWwuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyANCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGhvZW5peCBIdWFuZyDpu4PkuJbptawgPHBob2Vu
aXhAZW1jLmNvbS50dz47IA0KPiBTdGFubGV5IENoZW4g6Zmz5bu657atIDxzdGFubGV5LmNoZW5A
ZW1jLmNvbS50dz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIElucHV0OiB0cmFja3BvaW50
IC0gQWRkIG5ldyBFTEFOIHRyYWNrcG9pbnQgDQo+IGRldmljZSB2YXJpYW50IGlkIDcNCj4NCj4g
4pqgIEV4dGVybmFsIEVtYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRo
ZSBvcmdhbml6YXRpb24uIFBsZWFzZSB1c2UgY2F1dGlvbiB3aGVuIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMuDQo+IOKaoCDlpJbpg6jpg7Xku7bvvJog5q2k6YO15Lu25L6G6Ieq5YWs5Y+4
5aSW6YOo77yM6KuL6Ky55oWO6ZaL5ZWf6YCj57WQ5oiW6ZmE5Lu244CCDQo+DQo+IEhpIFl1YW4s
DQo+DQo+IE9uIE1vbiwgTm92IDAyLCAyMDI2IGF0IDA5OjA4OjM2UE0gKzA4MDAsIFl1YW4gWWFv
IHdyb3RlOg0KPiA+IFRoZSBuZXcgRUxBTiB0cmFja3BvaW50IHZhcmlhbnQgaWQgNyBpcyBmb3Vu
ZCBvbiB0aGlua3BhZA0KPiA+IFgxNCBHZW4xIGxhcHRvcChQcm9kdWN0IE5hbWU6IDIxWE1BMDA2
Q0QpLCBpdCdzIG5vdyBpbmNvcnJlY3RseSANCj4gPiBwcm9iZWQgYXMgR2VuZXJpYyBvciBMb2dp
dGVjaCBQUy8yIG1vdXNlLg0KPiA+DQo+ID4gQWRkIEVMQU4gdmFyaWFudCBpZCA3IHRvIG1hdGNo
IHRoZSBUUF9SRUFEX0lEIGNvbW1hbmQgcmV0dXJuIHZhbHVlLCANCj4gPiBwcm9iZSB0aGUgZGV2
aWNlIGFzIHRyYWNrcG9pbnQgY29ycmVjdGx5Lg0KPiA+DQo+ID4gQkVGT1JFOg0KPiA+IGlucHV0
OiBQUy8yIEdlbmVyaWMgTW91c2UgYXMNCj4gPiAvZGV2aWNlcy9wbGF0Zm9ybS9pODA0Mi9zZXJp
bzEvaW5wdXQvaW5wdXQ2Mw0KPiA+DQo+ID4gQUZURVI6DQo+ID4gcHNtb3VzZSBzZXJpbzE6IHRy
YWNrcG9pbnQ6IEVsYW5fdmFyaWFudDcgVHJhY2tQb2ludCBmaXJtd2FyZTogMHhhMSwNCj4gPiBi
dXR0b25zOiAzLzMNCj4gPiBpbnB1dDogVFBQUy8yIEVsYW5fdmFyaWFudDcgVHJhY2tQb2ludCBh
cw0KPiA+IC9kZXZpY2VzL3BsYXRmb3JtL2k4MDQyL3NlcmlvMS9pbnB1dC9pbnB1dDY1DQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFuIFlhbyA8eWFveXVhbjAzMjlvc0BnbWFpbC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW5wdXQvbW91c2UvdHJhY2twb2ludC5jIHwgMiArKyANCj4g
PiBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuaCB8IDEgKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5w
dXQvbW91c2UvdHJhY2twb2ludC5jDQo+ID4gYi9kcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9p
bnQuYw0KPiA+IGluZGV4IDNiZDhmZGY1NmNkMy4uZjQ2ZmMxNjY1Yzk2IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW5wdXQvbW91c2UvdHJhY2twb2ludC5jDQo+ID4gKysrIGIvZHJpdmVycy9p
bnB1dC9tb3VzZS90cmFja3BvaW50LmMNCj4gPiBAQCAtMjUsNiArMjUsNyBAQCBzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IHRyYWNrcG9pbnRfdmFyaWFudHNbXSA9IHsNCj4gPiAgICAgICBbVFBf
VkFSSUFOVF9OWFBdICAgICAgICAgICAgICAgID0gIk5YUCIsDQo+ID4gICAgICAgW1RQX1ZBUklB
TlRfSllUX1NZTkFQVElDU10gICAgICA9ICJKWVRfU3luYXB0aWNzIiwNCj4gPiAgICAgICBbVFBf
VkFSSUFOVF9TWU5BUFRJQ1NdICAgICAgICAgID0gIlN5bmFwdGljcyIsDQo+ID4gKyAgICAgW1RQ
X1ZBUklBTlRfRUxBTl9JRF83XSAgICAgICAgICA9ICJFbGFuX3ZhcmlhbnQ3Ig0KPg0KPiBJIHdv
bmRlciBpZiB3ZSByZWFsbHkgbmVlZCB0byBzYXkgIkVsYW5fdmFyaWFudDciIG9yIGlmIHdlIHNo
b3VsZCBzaW1wbHkgc2F5ICJFbGFuIiBoZXJlIGFzIHdlbGwuDQo+DQo+IEppbmdsZSwgaXMgdGhp
cyB5b3VyIHBhcnQ/IFdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgZnJvbSBFbGFuIHRyYWNrcG9pbnQg
cmVwb3J0aW5nIDB4MDMgYXMgaXRzIHZhcmlhbnQ/DQo+DQo+IFRoYW5rcy4NCj4NCj4gLS0NCj4g
RG1pdHJ5DQo=
