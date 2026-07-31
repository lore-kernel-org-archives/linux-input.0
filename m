Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB633403E3;
	Fri, 31 Jul 2026 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480435; cv=fail; b=bITYYWKTseUUyUzu4cUTM+AZTtX1O0v2l92KdLUCOkIEMoutfq1eFWWCbUQd8sgVrOBvcUU0KqZEgnnVGxFywOM8qD/w7RTzETwZTZoiNU6RtNWQfbrugsE4yKvlawrrhXCvssr0AqnpDvwmiodrSeodxVec3ufcVQFuYZPql8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480435; c=relaxed/simple;
	bh=+rx4wegYg+dbNhzUfo0+SOr79aS2R+UO9/v1rTtmCLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eEsjATiy+Np+M6cXGcuPXkKKz0kN8ffMJSinOc7++DcUSV2cORRgVwaxityYZ4kU78wwRjcGPURSpB2SaqW2DBZOAcIHTo8gD73sYVan64LZPK7CDXyAV17WnTXreMAlElUBeRnGBqsN7h7X4ZGw+zUjnJzGsyvxKga/HcSb/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5MZQliC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5MZQliC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785480434; x=1817016434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+rx4wegYg+dbNhzUfo0+SOr79aS2R+UO9/v1rTtmCLU=;
  b=M5MZQliC938CiEJ5Va0av/n3xQNFEszvBneVNlAaoYFtFXoNOTVK3bo+
   akbj1odBwcLyD7tYMHnxqUo+7UcYQz+NW/k3+GtiW/WLSrklWa4kXUNOH
   Y32bG/7oP1FAd4CzO01dEV3pjs2zQm/pc2zaQhp1S/u3r6qj0xxSbaDl/
   TCvA91XmeIITPR4VbtzXra4UTrt3/NhmOpSybpDeWI5B4cV3H1qep1x2A
   tpnO96PWh5qfMNuj9TzxuGy/+TWw7lGeW6o1ZW5upkeGFoMyYyv/XxrCR
   MrRfHOPFeuY3M0b9T6X2JDU9okMxnYXx7sdkY3d9qZIFhsj+ym0VVC0Hs
   Q==;
X-CSE-ConnectionGUID: IAOOCsTTTSa8Zp96l92qww==
X-CSE-MsgGUID: 0YSW5MZyQOq2lejMmWGkuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96691012"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="96691012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 23:47:13 -0700
X-CSE-ConnectionGUID: HlTXarI2S2C1g7m3jJKoIQ==
X-CSE-MsgGUID: RZbL409SQoGMpXqvvFFqSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="259265289"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 23:47:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 23:47:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 23:47:11 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 23:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGGv/lX5pc2uvjrPx6Zv1TX5OL2VajZpb4rpWJXYQ9jVfVJfhf+et1iClLnVn2E9ywJYwCsSzwFKrUa6De1TTvvQ2EOX4aEQcD1ZAY5CmOUZ4Ol/OSA+EUxoWnE4FoVauebteW6FES9a+rXe828e1WmEBYhQQqSIPr0swrd3aIM8aRuUoATiMe29l21dzPC/KXrXCwEvQdoSCHc7EWb9iPByqzAmUpIsO8HyySp4ec9qaV3fy7+8u0xeW9kP9gTA1pzLiWBjEgvzmisPuaHneC/wjrapcJ4K3maZYlIjZThz3whpibkylepEUN7MKIvPhidMS+S637wEaBRFJyqQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rx4wegYg+dbNhzUfo0+SOr79aS2R+UO9/v1rTtmCLU=;
 b=y1l6R6+WbJHZ2pHIUbEaXwm82So/ZzuC7I6cAwh9O/c8HjXeybioKJ0PIB7NCrIdi1cGrP6RSPxfPABhFCf7keD1n7CTNb5agx/HyVnB8H3bakpH3L1jIOO5dYb/RxLn0dGXvD7DH5RYnG2uuCVNSjqEoPu7dmnyczWPTvFxVq1K9lrcBSMUJJC9/07R8UvAP5n1g8E/5GtkeO1BDzRyjXjqZgaoehz5WvAczmN2chaWrPlaW6yfyMV3IcXArMz7X21mIZvTVcCzNJb9+kLO1PhumxjAWR3EetMXUrxJxRTA87g0OZnax1U1KnFeVqdGyh0ohvHEMibbI1FrakTDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 06:47:08 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:47:08 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Shen Yongchao
	<grayhat@foxmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator
 pointer arithmetic
Thread-Topic: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator
 pointer arithmetic
Thread-Index: AQHdIE6A0RyN5mmRDE26iJxckmD2CbaHHGRQ
Date: Fri, 31 Jul 2026 06:47:08 +0000
Message-ID: <SJ0PR11MB5613452585B3355965CBB4A793C82@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
 <8836d77de5c2de98876f49a866a7f149c49fff89.camel@linux.intel.com>
In-Reply-To: <8836d77de5c2de98876f49a866a7f149c49fff89.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|CY5PR11MB6233:EE_
x-ms-office365-filtering-correlation-id: 4afebd63-b3f2-4011-c956-08deeecf8a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|20052099010|22082099003|18002099003;
x-microsoft-antispam-message-info: GZB7KloV3ZUgLUD57KjpwitDr9mpfAZ+mCwN/qQGTndpXNpjZwljuyxPNKT8BcIEecisib8os8k/T6nR88IziI4ywEjRiTsSmgZx385KQGvBpcmo8+OS8J5IohYNzhaNVeDT+dljBhnx4ZOHPC0/ZCY9uP2B8Mp6e6hM7nvxI3cgXUselUlbMreyJqKByvmw52MknFiP1kbpciFcih2hjq50p6vz9Dt7mw1vmB8S6na3AuCF2esBG4DdVU772pt+sx1S9ybuganKsoohELepDm/Uuo2ybcC+eyBF0LCH3lAhC84pC6WaZlJLKpNR5t1eShV3VixlZuLNor5YGI+MN6GiJCsG2WZXhg30CLAOMp6QOkmjb4+bnjeGi26fzmvryTVLOgTYjowY6WPbdHbSFLMd5jOh6j7yNeXcGivOZ2DxtKfMp0jkeiqpqUjnB7XCyizGCdX00j/Bv3K3tAfWIzADoYyKaN+5ICsGrne4LhLi/cacNaMRWMWl6V5UpfhdlrfkrrNisCmOFbfQlqL5gGBa2ElVs/cHdWtllUSGfN4S8igTooKCx+MVu5r0r6UPfSKCb8zt4YKjv7y/pbDcui/W0KPuBB+nhOFEHtmoBoFn/GWo6SgJVCKaNrMBKDWBJPhbsjsg2Wfozq0l2dz5NkLaNF9pwXYb94And2qzI6rNfasQqDQCEcK3ajICfZPnX0msYH/k2kgVXc69CT2l7ZlIij8lLtkrT1E9OfV41tg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(20052099010)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0dhTGVUS2pTRlhsbkg4NXBWdHA4OU0wTWg1dktSMWVLL2E5RkVFdmZ1TU1X?=
 =?utf-8?B?bnZkSWQyZW9nSWdCYmxjN1M4ektjSUEvTXY2ZitnUWtzMTZKeVkzbVlVbE52?=
 =?utf-8?B?Sk9OTkVMUzd2YUJYZ1ZTdkY4aTgrVXpwWWM3SndCQUsyV1hEaWxwdVhLY2Vm?=
 =?utf-8?B?NzVXT0h6dVk5M2pJWWp0SUsrN2FSaXVJaVE0Q29BeTVRampReExJUTlhZXJm?=
 =?utf-8?B?UGpna0lGMmg3QWh1Z2tXb0ppWTllZUJsTTRjOVRraUxYVk1FRnBYR3Qyazho?=
 =?utf-8?B?Q0NYV0JyTjNJMDhhcHNkWWJSZ2Z6U2JQMXhCNUxPSk1Xa3ZiZHVMVVFGdGhH?=
 =?utf-8?B?c3hReFBEeU5jamh6YTJhVTlOSTR2RlFUTVRDMmpRWlI1SGl6T1ZhZ1dkMkNo?=
 =?utf-8?B?bnNhd1RUUFlOWmVyaFh2NE41aG5uTis2YVdjbEVzUXBPMlZYTjljL2RGQjRs?=
 =?utf-8?B?ckoyTWRpYnpEY1g4Z3RiQ1ZQM05jUjR4QmRGM1lnc00wMFFUQUQxd1VESlU3?=
 =?utf-8?B?YUtzSktuMEwwdlllSHZVR2VCU1EwbWQxclZackwxQkpkNU1VQWNFT0ozRmdo?=
 =?utf-8?B?K1IxOHk3b0VBNkJsbHQzSmpISUJpYS9NdlJRT0oyWDdHdHh3enlXZEhqb1kr?=
 =?utf-8?B?SXBLOTNUbVptamtKdThFOHJHTEdNejlmRkhhamM5Q3RNM3R6dHppQ1FiM0pp?=
 =?utf-8?B?Zk9XVnRxalA1U0tOZFlxaDF0UGc3UkJ6WkRIMTJFakxxQmRVU1pUM3JxVlY5?=
 =?utf-8?B?czYrRWhOSWQ0dVFuVEZ3UXJhck05WlZXalk5cnN6UHhYZXg3RlJLZ1BuMUFi?=
 =?utf-8?B?ak52TzFoaU84VzQ1K3NBTWM5UE1leTJFR1ppdHBCbjJjT09HM0MyWmRPNnMv?=
 =?utf-8?B?TS9PYnluckdYMkJkNU04MFBFenVhWndJcDNYUEZXL0hmR0NYUUVQM2U0dW5l?=
 =?utf-8?B?ay9DV3ZwV2R3a3JWSkpDTThPL0dEckQ2MEtzRDg5Wk5wcHRBeUVjbFUxZFRr?=
 =?utf-8?B?OXB1RkZoS3R2OHFBbjhWbmNqdk9KQ0JrQUZoUFUzSXpESXQwYkJvcmszcml2?=
 =?utf-8?B?YkE1Skp1ZGs0cEcyRDJTeHRzcUxXQjRBdGEwaklVNCswOTdjUGtkYit2TVln?=
 =?utf-8?B?UkMxT0phcSthNG83TzI3K29UeFl0enQ4aUhuckJFWDN6MHlZWE9wOUlld0FU?=
 =?utf-8?B?dC9NT3VsU1VHTTNxNm9rOXF2VDAwWFVtT0E0Rm5LOElsRUtWNWVjSHBUdnlZ?=
 =?utf-8?B?aW1hc0YzMEJraFdoVExpYkl4STZISHZoRzVJdytYK1ZnSHhDRTNpakxadTBO?=
 =?utf-8?B?K3ZFUTZuOSs5Q1NlSysxUkpTUnVEU3Jsc0pMQ0pMYzM2Yzhqc0drZTNoeVZv?=
 =?utf-8?B?bVVrNDh4VmxyOUdSSGJyNjZubWJxU09JZUZGTzhjSjdhbW12THRWSlZiaHp0?=
 =?utf-8?B?S2d3ajhZWCtRbE4wdzFBOXA1OEdScXMrWjh0SWNIQkVrK1hHZitiTkthcjc3?=
 =?utf-8?B?c09rT21JNGp6L0xFWGJMenFVTGRYalpGSFVIclVESEd1VkhiN21BM2dicDVH?=
 =?utf-8?B?Z29hTFhlZ2x1M2lSOER0TmlJTGwvaWtvdUx5K1gyQ3p0UVRwOHc3bm9WUmVr?=
 =?utf-8?B?bW5qWUdKUGNrMkdQRUh1WWVUT3czS29EUzhleHdReWtUK0hETjkvYkIyYlBE?=
 =?utf-8?B?QTFHUkxQdjhDTWFLL3BqdFZxQVVuT1M3K2hGMWg2YWNqckFCdUMyWXd6WWgr?=
 =?utf-8?B?OUlaOU91TTlORWVINTNFVU5DOHNZQTc5cFZVaUEyOW1PYitlYzR5VVpjUlFD?=
 =?utf-8?B?eWhFSFMwOGFvTGFOdTdwbjhzTGZIdHFITTErZEpvREYrL1o5VUxIbUJubVZJ?=
 =?utf-8?B?Z1ZJcHRiYmg4eWkvaTZMSVpDNGFsQ01HZGlXeWZ3UjFYMnRYS2tPeWM5YkFt?=
 =?utf-8?B?UGNTRCtSREIvUHZFWlNCUUNFOEFrc096T0hwSkhsZVJjV2IxUzh1MGZwdGYy?=
 =?utf-8?B?U280QWpvWGpDVjg1bWhDSldlbnNIUTgxRFVtcDk3NUFzTnVnbE5qQUdOTkdt?=
 =?utf-8?B?bSs2M3VEWHRoT0N1Q0VGdms5QVNiY2NmZ1NSWlRlUklzTGpvYWRSRjg2MDI2?=
 =?utf-8?B?YkFLbVUzanRsbDNjak4zOGpocUZoZ1RLYzJTL3l6MDJWTTN6c3hyODhMQmRB?=
 =?utf-8?B?T041aUVVV2VYd1h4ZFFySEpaZ2VmZUFKU0lNVkswNW54U29wM0YrSDF1Qyt6?=
 =?utf-8?B?NFpCdW9ONDkxSm5WK3dLYnU2eWZSeXlKbGVRTi9Xb3JReDZZUEVGcElkVkRv?=
 =?utf-8?Q?SvfcyACa52ZNr4uCDg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lbq9yd4y03c9xJFrGlnFqRuBoK/80wGKyYINOnY1GHQp/Wb2j5wVPFDiQCQ8gCqKTzULtmZjrnvKMOsKO1Wb20wlBcnz8x8r6XWZFFf7lkDsqfzytnsvGaX1x/o0XDFa58kTNo2KtG3wfQ3Tnpim2x3Tq6A0ZtkWdPmaxjxATEHx4mA1EdahkrfqAstZ4iouqlWQgrITe0aqegoppYL7BtOFXYqFjjX5jw+rf2lQacXPfTAVPsO2nLJxWw25+Fevquy9fDzSps9CZlMdZvibbZNEalQ6ULajnhpJEI7S0BJPc+nTCVdKtdZPONlfj6XG9uTqC9JfaIEhuVZz4WiyLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afebd63-b3f2-4011-c956-08deeecf8a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 06:47:08.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfIcafTsWTIb5bG2CSA6EgxfnCDOEXyFzBmGerUGHxC+HOdT3BseQgeKUeVZpRVPh78Ekni3KgaLNA6RizZ6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBKdWx5
IDMxLCAyMDI2IDI6MDkgQU0NCj5UbzogU2hlbiBZb25nY2hhbyA8Z3JheWhhdEBmb3htYWlsLmNv
bT47IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsNCj5aaGFuZywgTGl4dSA8bGl4dS56aGFu
Z0BpbnRlbC5jb20+DQo+Q2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBKaXJpIEtvc2luYQ0KPjxqaWtvc0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlz
c29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+OyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzRdIEhJRDogaW50ZWwtaXNoLWhpZDogZml4
IHJlcG9ydF9saXN0IGl0ZXJhdG9yIHBvaW50ZXINCj5hcml0aG1ldGljDQo+DQo+K0xpeHUNCj4N
Cj5PbiBUaHUsIDIwMjYtMDctMzAgYXQgMjA6NTIgKzA4MDAsIFNoZW4gWW9uZ2NoYW8gd3JvdGU6
DQo+PiBTaW5jZSBjb21taXQgNjNjYWZhZjQ3YTgzICgiSElEOiBpc2h0cC1oaWQtY2xpZW50OiBy
ZXBsYWNlIGZha2UtZmxleA0KPj4gYXJyYXlzIHdpdGggZmxleC1hcnJheSBtZW1iZXJzIiwgdjYu
MTMpLCB0aGUNCj4+IEhPU1RJRl9QVUJMSVNIX0lOUFVUX1JFUE9SVF9MSVNUIGhhbmRsZXIgaXRl
cmF0ZXMgb3ZlciBzdWItcmVwb3J0cw0KPj4gdXNpbmcgYSBzdHJ1Y3QgcmVwb3J0ICogcG9pbnRl
cjoNCj4+DQo+PiAJcmVwb3J0ICs9IHNpemVvZigqcmVwb3J0KSArIHBheWxvYWRfbGVuOw0KPj4N
Cj4+IEJlY2F1c2UgcmVwb3J0IGlzIGEgc3RydWN0IHJlcG9ydCAqIChub3QgYSBjaGFyICopLCB0
aGUgY29tcGlsZXINCj4+IG11bHRpcGxpZXMgdGhlIGFkdmFuY2UgYnkgc2l6ZW9mKHN0cnVjdCBy
ZXBvcnQpID0gOCwgbWFraW5nIHRoZSBhY3R1YWwNCj4+IHN0cmlkZSAoOCArIHBheWxvYWRfbGVu
KSAqIDggYnl0ZXMgaW5zdGVhZCBvZiB0aGUgaW50ZW5kZWQNCj4+IDggKyBwYXlsb2FkX2xlbiBi
eXRlcy7CoCBPbiB2Ni4xMysgYSBsZWdpdGltYXRlIGFnZ3JlZ2F0ZWQgbGlzdCB3aXRoDQo+PiBu
dW1fb2ZfcmVwb3J0cyA+PSAyIGRyaXZlcyB0aGUgc2Vjb25kIGl0ZXJhdGlvbiBmYXIgb3V0c2lk
ZSB0aGUNCj4+IG1lc3NhZ2UgYnVmZmVyLg0KPj4NCj4+IFJlcGxhY2UgdGhlIHN0cnVjdCByZXBv
cnQgKiBpdGVyYXRvciB3aXRoIGEgYnl0ZS1ncmFudWxhciB1OCAqcG9zIHNvDQo+PiB0aGUgYWR2
YW5jZSBpcyBjb21wdXRlZCBpbiBieXRlcy4NCj4+DQo+Pg0KPj4gQXNzaXN0ZWQtYnk6IExMTQ0K
Pg0KPk5lZWQgdG8gZm9sbG93Og0KPg0KPmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3Mv
Y29kaW5nLWFzc2lzdGFudHMuaHRtbA0KPg0KPkFzc2lzdGVkLWJ5OiBBR0VOVF9OQU1FOk1PREVM
X1ZFUlNJT04gW1RPT0wxXSBbVE9PTDJdDQo+DQo+TGl4dSwNCj5QbGVhc2UgZ2l2ZSBhIHRlc3Qg
b24gZmV3IGRldmljZXMuIE5vdCBzdXJlIGlmIHdlIGhhdmUgc3VjaCBkZXZpY2UuDQoNCkkgY2hl
Y2tlZCB0aGUgZmlybXdhcmUgc2lkZSBhbmQgaXQgZG9lcyBub3QgYXBwZWFyIHRvIHNlbmQNCkhP
U1RJRl9QVUJMSVNIX0lOUFVUX1JFUE9SVF9MSVNULCBpdCBiYXRjaGVzIHJlcG9ydHMgYXMgbXVs
dGlwbGUgcmVndWxhcg0KSE9TVElGX1BVQkxJU0hfSU5QVVRfUkVQT1JUIG1lc3NhZ2VzIGluIG9u
ZSBJU0hUUCBidWZmZXIgaW5zdGVhZC4NCg0KU28gSSBjYW5ub3QgcmVhbGx5IGV4ZXJjaXNlIHRo
aXMgc3BlY2lmaWMgY29kZSBwYXRoLiBJIG9ubHkgcmFuIHNvbWUgYmFzaWMgc2FuaXR5DQp0ZXN0
aW5nIG9uIHRoZSBub3JtYWwgSElEIHJlcG9ydCBwYXRoIGFuZCBkaWQgbm90IG9ic2VydmUgYW55
IHJlZ3Jlc3Npb24uDQoNCkNvZGUtd2lzZSwgdGhlIGNoYW5nZXMgbG9vayBnb29kIHRvIG1lLg0K
DQpUZXN0ZWQtYnk6IFpoYW5nIExpeHUgPGxpeHUuemhhbmdAaW50ZWwuY29tPg0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KVGhhbmtzLA0KTGl4dQ0KDQo+DQo+
VGhhbmtzLA0KPlNyaW5pdmFzDQo+DQoNCg==
