Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130720;
	b=JRpPW5JcTy5puqan9teXsZRg8Uzy/ho7yn2wjq4O3nU2+fl8qUnKwOyk+EwBVVaqIXDh
	 zG9DBK9pcajWVxSHeEWlIKyGkMp86QghWNpNzLrdld6NghuHrhnzM7mzAwi9qXX7kMQfS
	 Q1Pl7cvgJZUkdzAEArtmzG1dxD/6DDOBdre0oXQg428gLjYxemPyf5d98VbtgRZNBH+N0
	 b7Mf/cnR4nvK8yD8q8oc9G9yG1YB2qfaE/hM/Q0eGTFEMCjm4LE0C2rpAHUQhudgEl6/S
	 O+IG9inklobRrunjICmbiXQke5JpKGzv+ezdMTU4F7av+eiphqgIIz2WqkBMPaagglQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130720;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=h+lc52ziTRWMpI4Jv0fBJNpliol0HHQaRuUpaQgVWxQ=;
	b=aM+Z9JtSlqIY+K7A5bzE3vHfj+/KzXAdYGgWd/XPbjFSf/C2Jghf1XSAqdtsyuX+piVA
	 hk0yaOeEP+y3bFbPtBBUmxJHsgN1GQ0boIClrWSMEgOxayHxSzN5cyxT8RY+yiS6prmF/
	 iKwtYhPqz+lEGkDE4BII5pi2T2ZzLov6htpINnPZUvjfxuP/N8Y3C+TjKFqYsCVmOcmNc
	 1C4Lmu5V3I//xI0Iz2Bl6iHBxKRUvY7RW0nklMi6o9rJrdauaU//oynYT9OrIaNCvZAW6
	 bqARUeoAXzKo9jUjhqwDvbqFdvlabDfEIP+G/Ug+wu1AdagsAUXLppspa3NVHzEZBrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WgwpYqAs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B3606A31A
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 19:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WgwpYqAs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793130719; x=1824666719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h+lc52ziTRWMpI4Jv0fBJNpliol0HHQaRuUpaQgVWxQ=;
  b=WgwpYqAsA0BsLfA159RUbKFaTtR/OVC3PI22JKRhpLkF3Kmoh+Pkj+Ei
   TY4d0URLzq9wYFHtIhsTMwFljWdxHS6D8nYaS1q4ah7iCQUamD+67tNXh
   3vj9zVQ39VGlV2fMiKayufIDqpSbgVhiDuOA9+5Z59zqP3Aw/XJ8U+KfX
   x1oXuO8sISb9LbbwTLVQR3bVYYdNJ7BEkGq9L9H8VEcbsPqJbJ0M8H4Fe
   qUxYZm3XlRCkcwpf/DjVpcjyPXAt7tTZkLcZ+4k7R0GukkI+E1zAVgkDs
   8Ecpa5ogtlWKrP1q6YQctgeFG6dDIAeJjcVb8PZstCVw8a2AUt8CQgSAj
   g==;
X-CSE-ConnectionGUID: I2bPn78bTWGPrgo2z5uBRA==
X-CSE-MsgGUID: nmzXTKyWSqy0AfkAJsLRVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1949662"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1949662"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 12:51:58 -0700
X-CSE-ConnectionGUID: /q8uwtflThi8OAOaXRRbCQ==
X-CSE-MsgGUID: u2d6LXy6R2y+ahpcr6WCVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5033094"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 12:51:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:51:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 12:51:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbwlLS5gudxsxqHjghnfxcP7vSZBm8xeM8F2kIiXr+QHSXjJMLKHf0vyZ9kvys/6Om+Z0TZvZ8cqRVXx8pkeza99UyISPVnhvs5kCvJnmdcqDQ2ghmcQgfWrYXHUUtVW/s5zcr04ph9m6Lj1lNMwZZTZe79X4UczQnZWWfxrdWyI7HnuQQ1hs61fww4PLLvSZLf09T4n0Q2Djm41tidIVlAtT2mrx22xBbPBKj6oSbXYS5M0VXcecERXIfS0ZqQive1TX0GBvuwad9niPNVJJT7jd2DKLvRwyW1+EK5JCbH0sDe7vXh+kWjWnGxq8jU4mOow2oskBIn6CHusBwYn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+lc52ziTRWMpI4Jv0fBJNpliol0HHQaRuUpaQgVWxQ=;
 b=iL4jwW2cXKZSU/FZnulmsZbvN3S1L3yiHqRoXmXEuvL0bbkosbPxg2CtDlIUdG69qa3eThxbK7I1oCipWBImR6H+VsDNqWH0JYpKoBOVqGolp5QHwBRbY8NKtb5yCTimGExDcQ0QIOF4sgKf8twwCn8lNhz/SdndWIm6dVtXC0MlvUOiZ4LuvkQ2pJg8STHnXxtvy+Gi2PZIs2oWNZon9A+/LkV6UK5OM2MPMz0nSfQ9CtTddSGlyQXW48nPqz8mw39kkmUoRkd3GbHJPKdozc3GlefWCOgoNT5gzLv4Ck7URIV5Z1HM6Ff1ouNHwa4D4mpGzoWf/dSSuKTlNnE0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16)
 by CH3PR11MB625934.namprd11.prod.outlook.com (2603:10b6:610:362::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:51:49 +0000
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::94a5:aca9:ce90:514d]) by SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::94a5:aca9:ce90:514d%5]) with mapi id 15.21.0546.012; Tue, 27 Oct 2026
 19:51:48 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "jikos@kernel.org" <jikos@kernel.org>, "josstamy@gmail.com"
	<josstamy@gmail.com>, "Zhang, Lixu" <lixu.zhang@intel.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: intel_ish_ipc: ISH loader "cmd 2 failed 10" on HP OmniBook X Flip
 14-fm0xxx (Lunar Lake), no sensors
Thread-Topic: intel_ish_ipc: ISH loader "cmd 2 failed 10" on HP OmniBook X
 Flip 14-fm0xxx (Lunar Lake), no sensors
Thread-Index: AQHdZkya1U1SOmzB9UuQ3ZtHfSzBqg==
Date: Tue, 27 Oct 2026 19:51:48 +0000
Message-ID: <c30ab4fa39050d2c0d150cb4f1642bd8e225d8d2.camel@intel.com>
References: <20261027163400.20055-1-josstamy@gmail.com>
In-Reply-To: <20261027163400.20055-1-josstamy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_|CH3PR11MB625934:EE_
x-ms-office365-filtering-correlation-id: 6a0cc8b3-dbd9-409e-c57f-08df3463bcdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261022105027099003|261021121427099003|261022075727099003|261022115727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003|5023799004|38070700021;
x-microsoft-antispam-message-info: SPDxgubEKQU/gJm89Wq8k9kGOgINglJk2izbpSnCbX3Ds1ZAff+T/oU3mTBpWSSxenIYIZxCGCMI0aK4tNtdNSyk+Ki770oLxiwoB66yPFevZW+PeDnfpIFkCs1glbKbkFMN/gjeQ4MOzBvMzVQFkxR2vZatgcVkKTTXqukLEVT9T7oGwNcn9siGFGuRzLjCuGn/sIkCmYsmoqKciLgbBN9rrZsDsAANpMoGT83LwQKmpML5L7xUMUsv4tVY4GDoSyO681vqTMCAL0Uo9odTSOsWeZwvYIKj2INxiO9Nd2XbjRlYVrxe8h+5JaFw5/5xIa6FbL8Jh6ooU5triJ1Bgtctq9sGGH5K6DFIPdAGqOYVWvyOc7TnknxN09xRZpO9aGmOBTrICeAVTes2Bdyk3lvDbhGUbFSBFN27DfC4aZnOGXCybXkuD8AwOQiOvM3uYJsWXbL141sVK+0zeBM6Y1YvIys8VoZszu247L7wAPrnw+h39laxg8JxOBZrj7bvRpixAgaW7GyyycIVZrHOUSag7JD3iu9Mu5ORxaOtXCADFdmu/KAqKYAnJ8Z6FAa4XDXBjJB51xZG+tHbavrDOwnOfR41nd7sbGxhXS2p8DU7s40+TsJfNq8niz2iMgqK/wVidnaAc6QC6dINu42tMdi9ldiTB5HSD1Z8mIX55W3CuEkCcfqS+nHDFNlMFwI9F6+w8NSN+1VqyH14NT24HEDTQp4xG9aVAJzT0qI3iQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5600.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022115727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0w3NHlKL3pBYWtHLzYyZDk3OVlYeUs1a20wK3gzMWFNSVh1em5MZDlDVm9i?=
 =?utf-8?B?c0MxMlNzTGFYSGlKOTYrclJiVWVadkFCeVVKWTdIN0M4aFc3Q3ZPUTJVWU8x?=
 =?utf-8?B?RTlISnJWNzBGZE12bFA3VlQxYmVpeDBRcEhqOHVuazlpQ3A3NHhBOHJRMUdS?=
 =?utf-8?B?RFI3SVJxLzFxeWZKWnMvVWNXeTlzR2o2V1k2VEpMUWFnSk1IV01IZTMrZndH?=
 =?utf-8?B?cCs0bkFUZTgvcnBqNWlZZHluTmppNTJDMG9kQWtKMklZN1FrN1FPTk9RYnJD?=
 =?utf-8?B?bzBqN1FNNkdWNStjSWdkL0ErYXdoSmhsUkVtU3JtOWJvekEzaUErWkFFTVVj?=
 =?utf-8?B?RkwxcVgzMHVuMGN1WndHNmx4b3BkcUhxalNDN0VEZ3JvZVRzNWdPalMwSUtW?=
 =?utf-8?B?eWwwbzNtYzdPNy9iS2dKTUpiNVNNU2orcmVsVUN2UGovNHJycDFkVlNLU1Bl?=
 =?utf-8?B?cUdzUkt1a1g5VTBQckcrZGNnMzFwK2JXNFpub25vQWtoUXJ4VTQyYlIzQldr?=
 =?utf-8?B?aWlRQ3BBSzMvQmNjZzhYbnF0RzJsQkZ3Mzl6R0VDbCt3RmpmWDJqZ0I1anRm?=
 =?utf-8?B?Mm9aRzdnVE1jODNCcWdndUlWOTI4VDRlVGU2K2MvM3E0NTdFSDE3L20zdU1G?=
 =?utf-8?B?QzdhV3RIbE85a1hKbnVlNWhLQk53dC9FbUFmUHVRcjFvM0swQldmRVEyZ0Zp?=
 =?utf-8?B?WWRBUnB3akU2SjlBSEFoY2lZVjlzemdlN0svaG11KzRhQmFwa3VEaEpOZHJj?=
 =?utf-8?B?clVVZmo4bWNLVVhoY0RhSitPWFNQZTVIZ1Y0RThXWGFtcWJ0eGU1eHhzY1BZ?=
 =?utf-8?B?cHovNnhHOXpoSFJmMGZqMnk4Tm9DTU42Q1pJTXBJVGlyelh0STVYMHlaeEp0?=
 =?utf-8?B?ZzhYdUE0cVdmTU9VYlhBOHEybHNNYktNUzUxRWsvdDczU0gwMEFCWVFUU2Z4?=
 =?utf-8?B?aEN4Sm9zT25zOVdPcHV5UUl0S01weG1JK3R5Z1ZKK3lFQUtoMHRJNmE1V2FZ?=
 =?utf-8?B?Nm4vU0dKNjRtTWtqZzRrc1BwZFlOUndkenJFRUFEc1dYdDVQc2kyeExtMzh2?=
 =?utf-8?B?eXgrS2hkVHJOTTB0NHZDMEwzVUtxWHpUdllRamV0VE01bEIyWkJROWlYVXVL?=
 =?utf-8?B?RVVZUDUwRFphZWhaSHRjZWxYNGE4TUpxLytqQnNNV2piTFFlTkpjdHJpU0du?=
 =?utf-8?B?bmlrQWRuM0xEVHRTVmh4Tkh2ZUNwSFdya2FxV0h6N0JQMFhSaER3eDNLVG94?=
 =?utf-8?B?RDJrYWZzSXZCQ2Y5OVRVdkw0MlMvcVNvdnZPekZSWS9wcDZQM3NhVjZUMThU?=
 =?utf-8?B?UjcyVVplSEViaVZueEtWY0NUanFDMXdMeGZoUmJza1NiVTF5NzVsV3FqQnhz?=
 =?utf-8?B?eGtBVFJXVGpGU0crZFNnZzhDRSt1a1J3U1NRRGtKTnI3Si9oVTRDbTRrMHdR?=
 =?utf-8?B?V3AzYXBzeDJ0a0UrVWJjQklTVFU5Z1VQNkdnOWhjaXd2eWcyU1IvbERtU3FZ?=
 =?utf-8?B?YU5SUEk5TGhqZGxUS3c1TVBEaDVDSUpBN0E0OWpXR3poQUxBcTRFdVU3ejV6?=
 =?utf-8?B?ZjhmTVRRQWNTcjc1VXNZMGVXVFRrWGQ2Sk0rcFVjNDloTjAzQzRKcGxoS3hH?=
 =?utf-8?B?WnBqZTRzMlJKcHRCU0tId0ZyMm84RzlHWEEvMGIvYTNhVTZLZU95d3NHL21H?=
 =?utf-8?B?M0h4a1V0djVRWEE1SVorVG9pd09tYW9VWHBrM00xRzVLK3ZITHN3Y0ZuSlZr?=
 =?utf-8?B?VjArbWJLdWp0UUVXZERYZkhUalBFQzFVa2tGNlA1TzZYUmNPSzZnVHNRREVO?=
 =?utf-8?B?RzI3MElHQjB5T1hZWldHYk42aDQ4RzNOU0xnOVBWaklkT3NWMlR5cTNCaWov?=
 =?utf-8?B?V2VlRE1mNXZjT0hnTVR2MVd2d2Y5bW5EeFdTcm5yRjlHNXozY0l2WGV1MVVu?=
 =?utf-8?B?ZzhXaVlrV1hpcDRiM0gra280cnMyNkVOb0dLVUNNRElSR2hnWElDL3l4Ulhl?=
 =?utf-8?B?T2gxLzlmMzVzWFBxTUJGaFF0cVJNWkN1bk1Pa1RsRHRHUHpGRnZxejF3UC9t?=
 =?utf-8?B?ZDhWMGFTZitpM2p3bE12VDIxcW4xZW9mS2RjanRiOUwwdkpGOWx4MUpQbFlj?=
 =?utf-8?B?KzRwcmpqU2hUS3ZESUJYUU1ndzFWUXJQZHAzVUp0V1haOWpOZ2tPZlRiYjYz?=
 =?utf-8?B?MHRROGtmV2JNVERNSkoveEZIQyt2Z1hNc01wQTlOVUpJZGRLUkNDS0dra3p2?=
 =?utf-8?B?SEg5ZGs0VHk0VHJNV2ZNbG5Hb1N5M2dINnZxMWEyamxoU2FYQkhsK1BXRzBQ?=
 =?utf-8?B?SkhGRk5zT2IzeWVucjZkWW96S29BMERFcDBCUHI0WDF2WGNYK3hXYlFDOHk1?=
 =?utf-8?Q?mKd9WtwOXenBprrA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE478BFF1EF6034FBD68F7FB2BA161A1@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: 0mxdTI5tqlG21n1YwkFAUDDbEB7WhQCB7z1Mo8X65H1m442UYrBH94B0wT1wyx6D85pUGsZDC3/T5iABj9zdkBsQHFONrPHT97HTfeUOeVDZGiopN54Yj42cBzURNILkUgX8KDkLOonTlAY7P0xibSgDK9N1+0Rbj4Jtpk5AdaObduOdJ5YCIb5Cv+zVxhrwawDxz4Q7qW8o3xF3NdHh8Zj2QlNMa93r5uJNMfBGWtq+sLaL0ZaxphuAMb2DP1TKlVhcp+FZDK9JpaLkzhBgBiI4WO1AxwJADN8V9NGwMreQN82M91mG3/u7tHfvfWE7GLQfvgYb7UbNMnOK2OWohQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5600.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0cc8b3-dbd9-409e-c57f-08df3463bcdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 19:51:48.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m99H3il+Mvgia/5Z5KMGT2bMYH8Y7ku68HwSaCHrUOHXJcODm2LG6S8cwMfGhxVOJ8yi/U/S8EvEDHV/O/nGL7vsfOFxhH/wajTXp3HP4to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB625934
X-OriginatorOrg: intel.com

SGVsbG8sDQoNCk9uIFR1ZSwgMjAyNi0xMC0yNyBhdCAxMDozNCAtMDYwMCwgSm9zw6kgTWlndWVs
IENhc3RlbGxhbm9zIFZhbGxhZG9saWQNCndyb3RlOg0KPiBIZWxsbywNCj4gDQo+IE9uIGFuIEhQ
IE9tbmlCb29rIFggRmxpcCBMYXB0b3AgMTQtZm0weHh4IChMdW5hciBMYWtlLCBJU0ggODA4Njph
ODQ1KQ0KPiB0aGUgSVNIDQo+IG5ldmVyIHN0YXJ0cyB1bmRlciBMaW51eCwgc28gdGhlcmUgaXMg
bm8gYWNjZWxlcm9tZXRlciwgaGluZ2Ugc2Vuc29yDQo+IG9yDQo+IGF1dG8tcm90YXRpb24uIFRo
ZSAyLWluLTEga2V5Ym9hcmQvdG91Y2hwYWQgZGlzYWJsZSBhdCAxODAgZGVncmVlcw0KPiB3b3Jr
cywgYnV0DQo+IHRoYXQgaXMgaGFuZGxlZCBvdXRzaWRlIHRoZSBJU0guDQo+IA0KPiBLZXJuZWw6
IDcuMi4xMiAoRmVkb3JhIDQ0KSwgbGludXgtZmlybXdhcmUgMjAyNjEwMTksIEJJT1MgSW5zeWRl
IEYuMjANCj4gKDA0LzI3LzIwMjYsIGxhdGVzdCBhdmFpbGFibGUgZnJvbSB0aGUgdmVuZG9yKS4N
Cj4gDQo+IERNSToNCj4gwqAgc3lzX3ZlbmRvcsKgwqDCoMKgID0gSFANCj4gwqAgcHJvZHVjdF9u
YW1lwqDCoCA9IEhQIE9tbmlCb29rIFggRmxpcCBMYXB0b3AgMTQtZm0weHh4DQo+IMKgIHByb2R1
Y3RfZmFtaWx5ID0gMTAzQ181MzM1TTggSFAgT21uaUJvb2sgWA0KPiDCoCBwcm9kdWN0X3NrdcKg
wqDCoCA9IEI1VUoxVUEjQUJBDQo+IA0KPiBkbWVzZzoNCj4gwqAgaW50ZWxfaXNoX2lwYyAwMDAw
OjAwOjEyLjA6IElTSCBsb2FkZXI6IGxvYWQgZmlybXdhcmU6DQo+IGludGVsL2lzaC9pc2hfbG5s
bS5iaW4NCj4gwqAgaW50ZWxfaXNoX2lwYyAwMDAwOjAwOjEyLjA6IElTSCBsb2FkZXI6IGNtZCAy
IGZhaWxlZCAxMMKgwqAgKHRocmVlDQo+IHRpbWVzKQ0KPiANCg0KSXQgaXMgbGlrZWx5IHRoYXQg
dmVuZG9yIGhhcyBoaXMgb3duIGZpcm13YXJlLCB3aGljaCBuZWVkcyB0byBiZQ0KdXBsb2FkZWQg
dG8gTGludXggZmlybXdhcmUuDQpJZiB0aGF0IGlzIHRoZSBjYXNlIG9ubHkgSFAgY2FuIHVwbG9h
ZCB0byBMaW51eCBmaXJtd2FyZS4NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KPiBGcm9tIGRyaXZl
cnMvaGlkL2ludGVsLWlzaC1oaWQvaXNodHAvbG9hZGVyLmgsIGNvbW1hbmQgMiBpcw0KPiBMT0FE
RVJfQ01EX1NUQVJULA0KPiBzbyB0aGUgcXVlcnkgYW5kIGZyYWdtZW50IHRyYW5zZmVyIHN0ZXBz
IHN1Y2NlZWQgYW5kIHRoZSBib290bG9hZGVyDQo+IHJlZnVzZXMgdG8NCj4gc3RhcnQgdGhlIGlt
YWdlLiBJIGhhdmUgbm90IGJlZW4gYWJsZSB0byBjb25maXJtIHdoYXQgc3RhdHVzIDEwDQo+IG1l
YW5zLg0KPiANCj4gVGhlIHZlbmRvci1zcGVjaWZpYyBsb29rdXAgZmluZHMgbm90aGluZyBmb3Ig
dGhpcyBtYWNoaW5lLiBUaGUgQ1JDMzINCj4gdmFsdWVzDQo+IGFyZSB2ZW5kb3IoSFApPTEyMTI4
NjA2LCBmYW1pbHk9NjA0ZmM3YjQsIG5hbWU9ZTRjYzAzZTUsDQo+IHNrdT1kYzZlN2Y1ZiwgYW5k
DQo+IG5vbmUgb2YgdGhlIGlzaF9sbmxtXyogbmFtZXMgYnVpbHQgZnJvbSB0aGVtIGV4aXN0LCBz
byB0aGUgZ2VuZXJpYw0KPiBpc2hfbG5sbS5iaW4gaXMgbG9hZGVkLiBsaW51eC1maXJtd2FyZSBk
b2VzIGNhcnJ5IGFuIEhQIGZpbGUsDQo+IGludGVsL2lzaC9pc2hfbG5sbV8xMjEyODYwNl9mOTc1
MWI3MS5iaW4gKDUuOC4yMDAuNzcyMF8xMDI5KSwgYnV0IGl0cw0KPiBzZWNvbmQNCj4gQ1JDIG1h
dGNoZXMgbmVpdGhlciB0aGlzIHByb2R1Y3QgbmFtZSBub3IgdGhpcyBTS1UuDQo+IA0KPiBBIGNv
bXBsZXRlIHBvd2VyLW9mZiAobm90IGEgcmVib290KSBhbmQgYSBCSU9TIGNoZWNrIGRpZCBub3Qg
Y2hhbmdlDQo+IGFueXRoaW5nLg0KPiANCj4gUXVlc3Rpb25zOg0KPiDCoDEuIERvZXMgc3RhdHVz
IDEwIG1lYW4gdGhlIGJvb3Rsb2FkZXIgcmVqZWN0ZWQgdGhlIGltYWdlIChzaWduYXR1cmUNCj4g
b3INCj4gwqDCoMKgIHBsYXRmb3JtIG1pc21hdGNoKSwgYW5kIGlzIHRoZSBnZW5lcmljIGZpcm13
YXJlIGV4cGVjdGVkIHRvIHdvcmsNCj4gb24NCj4gwqDCoMKgIE9FTS1jdXN0b21pc2VkIElTSCBw
bGF0Zm9ybXMgYXQgYWxsPw0KPiDCoDIuIElzIHRoZXJlIGEga25vd24gSFAgZmlybXdhcmUgZm9y
IHRoaXMgU0tVL2ZhbWlseSwgb3IgaXMgSFANCj4gZXhwZWN0ZWQgdG8NCj4gwqDCoMKgIHN1Ym1p
dCBvbmUgdG8gbGludXgtZmlybXdhcmU/DQo+IA0KPiBJIGNhbiBwcm92aWRlIG1vcmUgbG9ncyBv
ciB0ZXN0IHBhdGNoZXMgb24gdGhpcyBoYXJkd2FyZS4NCj4gDQo+IFRoYW5rcywNCj4gSm9zw6kg
TWlndWVsIENhc3RlbGxhbm9zIFZhbGxhZG9saWQNCg==
