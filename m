Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA2155A5D
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875992; cv=fail; b=elaRPbcYjaeL5CqN5lzQZCnNEVSOnVrsitKFvWwqvKqm4Lc0ovEuELe0S3hiwMZWb6syD6sjmkBWqUmRL9D6bp3HjI0n7NX8irjkwYqr98XiDcecEGFZgB30XMqAyAdxWS76KNK3J+ihmE16Fri63rJM7XVEUAy9PcZWr0NzoJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875992; c=relaxed/simple;
	bh=FaUHozM5yiQOoKWYpCFYluYyaBxYG4EE7PR1XlZCczE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2GmUPrLNXJuuxWBgaxevr1DDu27Jn0wXADPjx8S10OH45RKHI7MiSw9wDI6xVGMoyubVzOCsPrEPvwPdFzNScrz0ZUcMOnhmZFoJMKR9IUQC51hGFw9850uVYViiWJYxHhsz43ZjfHfd9Mpquuv3bhcBzbry8I8DwyGfJSz6jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7pGHblw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7pGHblw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782875990; x=1814411990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FaUHozM5yiQOoKWYpCFYluYyaBxYG4EE7PR1XlZCczE=;
  b=h7pGHblwcK5TsSAO2Pliz8WBb8mvHp3ANCXC5XGmcBMdGv0RBOiVAArR
   QziT/Y1hjdMECUrnzFGPX1k1Z+RCS1kkTDKwY8pjSLgUlEBDMU+kQig7r
   XwkRuC28afsAW8mcZK3D+msCaNFodqkzycEd4dzfG4/9ISvWuy953+hxB
   9EtGhxz9DDa/RuNxXqoD2ijdwrdpIO2HsXpaiN1hcCtaNl0ojbo9M+B6b
   m23FuRYq6bduuFVWdX6RmBjWhnueW76DoeTTXx0IBuj/QbGu7L9SC053N
   jUMLBzwJctbUtEQH8k4GN8gHtLccUkawpLv858/hiZH7zZ0NAljB5bjE2
   g==;
X-CSE-ConnectionGUID: +pRC+lV2S9a4WrJV4uPx5g==
X-CSE-MsgGUID: WgKLmZWNToijA0IWYRB3dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83629107"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="83629107"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 20:19:49 -0700
X-CSE-ConnectionGUID: d7PdMYPJQBikjjCQ4bAQtw==
X-CSE-MsgGUID: A37w5ir3Q2OH73zD7jys8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="248458071"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 20:19:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 20:19:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 20:19:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 20:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ztn1XqyCW1Emrwco+Mp1b05D/J2JTrHNPLBpq9FCxFWCe81rG07sULAkDiFbNS+2q1Qlcx90LjkuyB7BYeUzyHluOVGc//KRJcepnvbrKYfutmJwxi77ERPOB1Q+ve4n+TKds39a9P+7l3XSLyN6a6oJv55hd98a1CM6lvhdNaQd043Q4hS/VuAzyXEvMD0koP5T3Ib1Wrk4TeADFfeQN4n4Ttz6csrQl2uibiPqlC9+/eq7dJoXs1QbAn/Y7mYNz5Rjls3x7reJBbcmbNv5O2q1ecc1s1h0RGHN/z4Rn+7+HXBh5Ew5h4y/wSMcEU6egp42vXWSgAXx4sq/BCdxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaUHozM5yiQOoKWYpCFYluYyaBxYG4EE7PR1XlZCczE=;
 b=lQze2ryVgqCvnnVpMy/v3hNNI+D5YWMqEsMg6LD19Dnw+xOLT09rBmuSipsy0umX3FLm+Rii6ptBy2Q7l+5iL/KnTU15yMkorDKi+oxmPZMMMxEXc5LU5E52B7g5Rgcgk4oCHN5KEIOUVaYqBuJkb027kPbagKpABVic85TxCEr+0GOtw5SBunm5x6AfY5D6H/SsHv7wcQco6wcXubIPR3vs52AJg0+lvMYCaxPW8BnBk+U1kJYNUbFxGUeuCjrLVmgmqqsZkTLawmgSaL541mqnVvUXbKea83kUlVvfna9nWknpZiWHvo5L+LFyjoWEAt6p5XW9XPJD58ayvE+xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:19:46 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:19:46 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Wahid7852
	<wahidzk0091@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>
Subject: RE: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Thread-Topic: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Thread-Index: AQHdB+26rQb8+1w6z0SU0SoTRDAPYrZX/71g
Date: Wed, 1 Jul 2026 03:19:46 +0000
Message-ID: <SJ0PR11MB56138ACB56009B7CB4804B9D93F62@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
 <dd9ced1905adb4805916b173847282ff168a66b9.camel@linux.intel.com>
In-Reply-To: <dd9ced1905adb4805916b173847282ff168a66b9.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|DM6PR11MB4675:EE_
x-ms-office365-filtering-correlation-id: 3812fbcd-c04d-4b77-c270-08ded71f9a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: tBPCu7B1Q1HVXK5V+pnw4+rG2ZNBNG5IQjVtHd64te783PmlgPsXmpE9k263shHtSAKAEaTOQTfu0UnDPvQ7OBhDxjSGuEUSYqrrJeJ4ufTU68fGUuLjD97TZnvU2zjfXin+GBJMW0aRax2MhYqPQ+oI9zjDal5ZVI/pGVuNPpjLlHSyE5hySXysGEZj+dC4U7nl6gzxgseDczSWDPk/WbfRM90E443x9YAeK61/vMY/8A4tz5o7JisH0ZsVdRApXg7Cm1UKAkohX8IxpasPnpjvQuMBFPz08gLJK0LBJYHpo43asQUPNrOtuwRoJW/Elb/bUEi7wqBw2/LZHREAJkwXHoLqAX4Uzx3nNcjNUFKzVDfHxJwgZAyb+U93eT8S4UP+oF4DnTWR5vne7GB/GJfE5r8M7owXqIJCDeMnPLgzpX/3mrxFtgYaOzbfwkl85IOjxSXi7EXGNltCeDWq7bFgnhu3uYbEceICGoeXDguPMgpGlTr9wgdMGYKSvshDDEyu/rQcwu4KdzJzxAH03c+3k8qLcKbYx7nLX+aT8Ya5Au4QtE3tIRtTBJ8ZjGSaWyc4qcZDFrmUPBqwRPgY/5IdBqWv6176bRkouSipj5bKD9I2XYo1mO0f+3zVXwWKBMca0JoqrNuZJxEIMDp8dB8UcbxK4VcEPfV6cYQztUO6LBC9O8GmZLBPJDRMor1CM1qbr+e/NOk6KH2rpiyM5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5sTjc0S3A3NFFZYlJNQWVOOE42bm9ES3B4bXlJVHhJZnNTb2tIbitrZjYr?=
 =?utf-8?B?bCs2OW9IdWhweFRaUEovOWhPUFlIS2M3UUhPc09OVERPYlFKeUx6Y2Q4MnFt?=
 =?utf-8?B?ZXF4dlBjTEFOUXNTbzhyVnFvMFU3dFk3eWlYOFZxNmcrcm50Rm1tU0UySnFj?=
 =?utf-8?B?K1ZGMEtiWlBEeFBmQ21XSmRVMWZaNEYyclJpU2hKbDZMYi9RZU04QTk5R2VL?=
 =?utf-8?B?b1MrcEZybG9JUUtJdGF6TU9razAwTDB3MktoZVRXWTV4cDdhMzZJQ1RZWGRB?=
 =?utf-8?B?R2hDa3RvVFExOEdnQkMzVU5JRTh3d01JR3dhYlZmVGcwT3FMbU8zbUhDM25u?=
 =?utf-8?B?bUZlTDdiZWI2WVlLR1hhamJTcWN5bU5LSlVFYlRQb2dnR2NkWkF5NnUvYzFH?=
 =?utf-8?B?c01SQVZGSmp2V2dQRmZSSjVqSjRNUFl5MndrWFd4azlQQzM5L3RZYUtZaHpW?=
 =?utf-8?B?UkhNanFmc2FPTnZ5QStqSlYrZ2VWRHVLYzVQdHRScVlaT2NCKzVKWkFoUG1G?=
 =?utf-8?B?a09ER1ZGdlNyR3lDeE1FVkx2NW54WlFKeGEwOTBEekJQSU1iR25QT1NDVnh1?=
 =?utf-8?B?ZWNUSmI0RXdaZnlnTVE2Y1RuenVzS1pid21lTzlKSzArN25Zc3JMcU5icmxa?=
 =?utf-8?B?MEIycVFseVhMcVBVZGhxUmZ1K3NxL2FvMlgvZUJOTUtQTEdMeGNqL0NMejJN?=
 =?utf-8?B?WW5mWHRkbmVDckhxVVdFdXExTGM5a29wUDJpQk80ODBIeHlpVGdsajljTlYv?=
 =?utf-8?B?bWVpQ2tjYVF3LzA4cUNpcWlMZUtWWUg2c3d0Z09nbDAxOUxMSnZPSE9ESGhH?=
 =?utf-8?B?OWVwaE5TY3BHMHJzdHZIbG04ZCtlRkc5cC81YWxUSmJrbWx1dTRyVFdQTmlQ?=
 =?utf-8?B?czFXejhtWVhiUlBVVkhzd1FWOGdFSHdLMFpYVHZFWGlTWlRBYU1oMWZoOWo0?=
 =?utf-8?B?cWdGYVIweG5PRy9xZkJONDRUOHMrZklqNjZoWm5xcVBRQ01nMjd5aE1vQ1lz?=
 =?utf-8?B?b0FDYlhaZWEyVjBMZ3d2dnhlK25UQ0lPSHdKR21XV1NEOWhnb0QwRzEvcVJL?=
 =?utf-8?B?TGhDY09IME1iWnNrWEtCYWF3Yi9UMm0wTU5FTnpmWDErS0tEMzRrUjJybjky?=
 =?utf-8?B?K1RYaXZwNkpSQjk2Vk9yc2pXeFBrRTUweGNxRjNjaXpUbXgzRFMxT045Nll0?=
 =?utf-8?B?b1JTcDF2dFI3UTdSMUd6WWlubTZjeklpRysvWUp0eisvb2RuUHBkTnBiSnpw?=
 =?utf-8?B?R3orMUFsVUVvZ2xrd1JYcTJBa2hKYzZOMFRmYTJuZnIydENsN0Q4SG0wVU5I?=
 =?utf-8?B?cGlyNk9EU0c0N0tmZzNvL25CR2V1TXg2VTEzdTl5THBVeVBWSmRTdUpZK3d6?=
 =?utf-8?B?QWxMT1hyek5QVXgzeFFpMWFTNkJUM0ZyQ1VyZVhyUEdiVUVhcS9PaHlOZDBQ?=
 =?utf-8?B?RnRjaEJvZG9nS09RSWJxNjBFcU1RNGgyc1JnYXIySTY3RFNrRlp3Sk53SmNu?=
 =?utf-8?B?bVhBcEZTdlN3RmVRVlFORDJxNlNGRUFNM01Tc211cGt0bXJYcjJHMjZBM0Fj?=
 =?utf-8?B?a21LWlM4WEdZTVVKN3NMSzhCRGoyT2ZaaFRDa3VuQUxaQTZLWEtYcm5IdXRG?=
 =?utf-8?B?NUNLRGtpR2sybGk2MUFoOEhnZFExdWtCZXBYUmxGdVQ2RzQ3V3lrdytQa2cv?=
 =?utf-8?B?VnRRRTBKSFlvUEIwbzZHVDNIbzBzMk9GTlVUNy9MdEo1S0xzN3E0b3dPSjZH?=
 =?utf-8?B?MFkyRC9obEcxeGEzNjNUVmFYcXJ4aUlmUlVRTmw5cHJROHNycmJOeXBsblFl?=
 =?utf-8?B?MlFKc2VtTjJ3RFYwOTRtWHpEY0pLYVZKNW52L0d0eEQ4aWY4eERzczdTeDlJ?=
 =?utf-8?B?OC92QTBtQU13NW1nWEJwWDg3Z3Y0TUhUN3VIaVR1bmZVa3ltNXpnbUJRdWZP?=
 =?utf-8?B?Z01FdWN1SEJ2bHVlTm1seVBMaHNJSEw3MHJWUzk3bXl6M0xtSXZyMkljN3RI?=
 =?utf-8?B?ZmoyazZDNkorNXQrZnU5WHBKOEpzTk5UNVJRUFN2dW9QZG9acXVzSmlxSGJv?=
 =?utf-8?B?QzI1bDMvdkNXRjhiV1JMYWh5U3k2OEsyWms5UDcyWWcrNzZHRlJpeFo3NUVJ?=
 =?utf-8?B?WEJ5ZFFrN0g4Q0E0eTd5eEw5QlNqRmRXRG1NOFM1c1dzbTduY0pvS0FLbXNk?=
 =?utf-8?B?TFFJSDdXcEwvUG1UTWx4MnlLQmN0ZW9ZeFVUTElNc2s5ckRxS09pcURyLy9j?=
 =?utf-8?B?WUNRZEVLdEJYVENxZVBUY1hRaUVoS3k2cVh6ZnhrUlhySHU3ekVMd1VQb0g2?=
 =?utf-8?Q?ZNt+I5p5Ze9k+xZulq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E0yL9pZysz4Hu698b4K+pS/PC3nG14mxulPzfsFrpK8FBay5+NgPCO2Gxndr3Z/ZmSHdKCWLpfnm5dHznMLewdzwcnj26ufWMTqqX11EIvxwChSNzfzmOpJxjUqfcbau2ginrV5TMLYPzhlT7WADwSgWKigeMjLr9z8StB6AT688IkNUdUb7+/dOg5tJzZKEt08NTtWmy4BJY9FqLbuZjicI8jeZgWJ5SLFjxM+QR0uosRDHZTD2/0c4clrdAyHIPIPkJY1JuyLj2SP3tKVQ+mgIgxWlN2xl5dgWJ5Q0xflEls7H1InIxRTJIzRgBF9bLfjTqRl1a6lkeqPhGPx2Rg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3812fbcd-c04d-4b77-c270-08ded71f9a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 03:19:46.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTAzD0wGwe56UcQ+T3QRZDWxqOKsilrKJXvZ7R22Yg4DzKYr2ga9UQnha2Sq+hSmqDbbo1srelwkNbuNhA6j+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc3Jpbml2YXMgcGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogVHVlc2RheSwgSnVu
ZSAzMCwgMjAyNiAxOjM1IEFNDQo+VG86IFdhaGlkNzg1MiA8d2FoaWR6azAwOTFAZ21haWwuY29t
PjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBaaGFuZywNCj5MaXh1IDxsaXh1LnpoYW5n
QGludGVsLmNvbT4NCj5DYzogamlrb3NAa2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hd
IEhJRDogaW50ZWwtaXNoLWhpZDogaWdub3JlIHBvc3QtaW5pdCBFTlVNX0RFVklDRVMgZnJvbQ0K
PmZpcm13YXJlDQo+DQo+K0xpeHUNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLiBJJ2xsIGRvIHNv
bWUgcG93ZXIgY3ljbGUgdGVzdHMgYW5kIHByb3ZpZGUgZmVlZGJhY2sgd2hlbiBJIGhhdmUgc29t
ZSBmcmVlIHRpbWUuDQoNCkJlc3QgcmVnYXJkcywNCkxpeHUNCg0KDQo=
