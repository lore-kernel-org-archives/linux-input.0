Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681E224AF7;
	Thu, 14 May 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726655; cv=fail; b=r45rJH0B2jFTAznd3AF1rGqccVZFC9w8egZaxLcD1FjEdpXbQ3KmoipoWz0CvQkzZCYWfNOioHLWNyMNRSI4XWbFQz094t+1XqDFtOnHrpmaugdoP1U6yIpLnHhJYkeQb03xduY2jBhLm6iyuVX6BtPXfVuKiO86Skqt9w+MY4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726655; c=relaxed/simple;
	bh=KDHQ8vrihN2LyEAu8InRvasDiP8g1w0684xVNiGrOiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=cV0iDgBHpU0zgH5k9UH2Hsv76M5dsHc5otg6u0yPnVIlGJUNtQ/a/3ltWXqQrnJ1v0YV37J5v2dd0+C4D5tnveYs3Y0HrzklOc2+nNHgFXKzOCTMZAyQTg90HQsUvM6UQJXUXNPHnadGfD44jc6fWvbT3r2cGdc6Ma8rB8h1AIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMqT8p4z; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMqT8p4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778726653; x=1810262653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KDHQ8vrihN2LyEAu8InRvasDiP8g1w0684xVNiGrOiU=;
  b=QMqT8p4zf5pU5UboGmE6OVFKQCLH1HxyNaBb/zJeI6uVxH+5LNlfrTaX
   JeChD4iHQ50n3Oa+LgMz38q4wNZdo+maulF6op39w4B+JK8htsI4JTqta
   ZLxdmk8jz2+aUnEvBsP9TkgDmPriIsOZLbCnPE4puF+smh8PS1UTc5EJs
   qWlaEcO/7FCpxLkTPhN+jqOokgnWW2SSDCkzi/eckr9OiiidWiiKxGGhl
   g6EHYBjK0VseHMTeKIT/0cSjTpRjwf/SE3qPlq+nq9HKpehCVFRg+QAxa
   ErO2+HVNjiUqj4DH5c2g/79Bg7izZJ2bfckNw41tRKM5mNIk1NwLDbXwZ
   A==;
X-CSE-ConnectionGUID: j+zbbJ3MS7GKcW+9joo8Ag==
X-CSE-MsgGUID: fg2ZVvDZTJSeOWy6VeeOaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90239953"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90239953"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:44:12 -0700
X-CSE-ConnectionGUID: CRwNeDGmRsmHBkCQxTdzAg==
X-CSE-MsgGUID: x3Kzusw8TW+tcMQZb2tLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="233986870"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 19:44:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:44:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 19:44:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 19:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOamkozggbTSScOYFYOlZ0jD0bfx3aTlsQFG6SmTS5sr9q69GpbcoqlvY9+0LOaKLaC/NZCCRqhVI523bpbYHtb8GVlfuZSQe0bhvW2soRRbdxiWQEV5dTiDkm8cquMqvIns3d2994j8KPOXrxoaAjOiZ0Aa5tqADQJ40RsQmGGjHW8+yiKX3vGQeRnNXjA20b8Dgm4hJRRLMBOAz9lJRIlBfrYhZLX/fT//aEgkN5RMXQXt1xDSRVbD5H2+S26QSYUqARwxThFdYVFrO8PJ+1k9dSQTtc82qOkT0NO6u1rmE08lebIbZc9QdGugXmOZRj0Cf8Yu2XOV12EmEi/44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDHQ8vrihN2LyEAu8InRvasDiP8g1w0684xVNiGrOiU=;
 b=Dr1jvxRU4zwJZrnbm6ZtLODlF1kwyuPSlJb/uP4TSt6Y3kIOffc/SqtG6SLRA3FGmq6RG+wWRT5IP/XtL+gQoDRZKrctpR4DcPqY/NARUN8ze32L54r6iD6xNewSm1EC0XZ9Da3clqbL/x9lwhiggouyq/o69Li8o7iPNim3m6uYJqr7KZMQ8fXseeih/0AizcGvjr1jv5P8aoZPd8vbcfKeJoLgYYOFHZNVy2AUB/ci9TE1UQtC6lZf/MzEXJv7MXJrdWgkTFaAuheVW7MOnDL7W8iWeCJS8IjWD8kogvGmNDD8A1VA2I2KrHomMuy3wGeNibZmrSBWZKharPZHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 02:44:07 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::a7ca:db6b:7913:d6ae%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:44:06 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	=?utf-8?B?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
CC: "andy@kernel.org" <andy@kernel.org>, "Lechner, David"
	<dlechner@baylibre.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Thread-Topic: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Thread-Index: AQHc4a35jFWNDiPfx0atDa64awI2DLYKeYuAgADS7mCAAYAnMA==
Date: Thu, 14 May 2026 02:44:06 +0000
Message-ID: <SJ0PR11MB56132AE6EEC77BBDCECB6D6293072@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
 <20260512154853.10aa2902@jic23-huawei> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5613:EE_|BL1PR11MB5320:EE_
x-ms-office365-filtering-correlation-id: 535427dc-6b2d-42d0-314f-08deb162aaf7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|11063799003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: IU+MhyU1LmWRn8/GxAdXRcNgmYqYuOlxMZEdeoV03PO+lJ0miqz0scVrrFFP3dO+/qN/N86RgoRrRuB18SgLS7CW2A9ZwdD4t/Rq2R7QAtMSsFExU+azSofLdyOZLw++L8ycfuTpTG4lFJjQfB6aSQvhuCLunAKK7f88LYOhkuMruM4OZeauwNEFbHb/pEr215o3UedpYy54aNo66cYbrnIT4nBzBiLvaMsn/Y9uyJKJ2weqgqs1VyhIYM2qlv2gFRB7Cydd1UPIwqbRxSbdqAtYIqlNNmaEao3ZDZozIOuq2bEne25KdSwYdvhgw5KpvmfVRnuuhFPetWRSgnlC30O9HapA8XwSV0DEHd3W9Vy1isOrf2AI4NJ3r4TRzeoD1mqCxhXs5aB1YFw0dAb1hGTspn6Ht10+Fl4VU5uzVXxxBjHze8Q8hRmufsr1TimeTRUDZEuDQgAar0k7lEvKWOVnoevPu42OSTq1iv7+rXyywsQVmeBXAF5Batl5DGwlov0mDG8ckyKPggwTuUeEylTf42NGd2b2/ElANk5aguK2XkPa+ITNNQ9BJTzK8cOXwyv/fXa/1SPfiNLM3ajgBupPCYhVKLpwC+2OB8Htl27QI/Wz4d6c1gHDTzUjVSBw0uYUvluPMuC5Tx1mqOlee103gSibky88VvkKRsO7wG7hHix96HPA+bBBFNR631RZQ/slMjBgpKot0Eb70bv1t3NS5yMaPfNKRZsxrcRIbclTblB22+kHPqS/aOieG8QG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjlkR1gwaWNvYVp4aFJYQ3BWcXorc2JUQXQ5Z2VSeUtYSHk0YkNjQ3J3cCsy?=
 =?utf-8?B?cDlBWDdBQURYdU03bjVkdS96NzVSdDRLVnZ2aDh5dUhXWXFYWkorNzI1M3pn?=
 =?utf-8?B?TWxUSUFrVVh6OHR4UHhMMlB2enN4NEFNMFMzd2ZsV044N2xjQVloOUhIMkVV?=
 =?utf-8?B?TjdtQ1RKSklRSDJhRnRkQjh6ZE8waXN1UHhPRkJFZGpuQUZLR1BueG9Iakkw?=
 =?utf-8?B?YXQ1dXQrcUt4VHZENE1ldFVJS29QT3RqYWVWejNFVGt4enpTSWFVdGZzM0oy?=
 =?utf-8?B?WGhzVmtPeGtScGxBVkxaWitYb3ZYRXFMUXBZL0p4SlJ2WFRDRUlpbDJLWTVY?=
 =?utf-8?B?cE8xMlRCSGpNRDlCWW5WUUpZRkMyVmZ6cG5FUGFWUmp1ODBIdEk0Q2RaQXpu?=
 =?utf-8?B?QzdxNWxMQ3g0RFZVZlVyY0txQUhHUFdnU0xFckMrY1ZBM3AzUmFnTEl0Z1hR?=
 =?utf-8?B?T1VYczN5ZGduL3A4YVFoVC9FdEpma0N3azU0TmE4WUVJZjBVK2M3WmtOdlNV?=
 =?utf-8?B?Z2xhS2hFR2lsdkd0NjEwem9EaFY1Zit6bXJvVXE0RHovZERZbVpLbnBLYUdR?=
 =?utf-8?B?cjM2YUxocmk2ajZhRi9UTk92YTVaOEl6VlRrL0cvdzdjdm1MVGNMV0xNdmhj?=
 =?utf-8?B?dnoxS3VVUGQrL1pqNXhwYkV2czEvSDZDOWtFNWl2Y2xSdlplYUR2TU0wNFk3?=
 =?utf-8?B?aUNWb0FxenFZNzVJNitQUjNBWUg0UE9XR2RxZlRTOVNoRExvb3orVmRhZUV3?=
 =?utf-8?B?Uk9rTUpTSW1Xd1NoRUZiTWhTK2pRQXUxMXA0OEF5Y3p5ME9pYVpETkgxZnNm?=
 =?utf-8?B?ck1vWStuQmRkQkZqaFp1eUhHNHZUSmNwMFdScFhkNktmZ2toWldKNis2UEJo?=
 =?utf-8?B?YmhMMnhUenNlMC9VV3A0Q1Z6YXorZVJ4aDdYdG1WcnpLWUsyWmp6SGx3ZGdL?=
 =?utf-8?B?MVB5QS9CUU4ySmxMcWVoUk9vUXJMaE5GRHJ2Um1aTWVrQ2pEc3hEQzZ1S2JT?=
 =?utf-8?B?WCsxL212SnFTM0Q5MGFvTXJnUE83eXc0YnNPbUVOVEdLMVk2ajU3cjdvL0pJ?=
 =?utf-8?B?TStrRzJmWVdJZWlvVVR2dEhub093eVFHNFZKOG5oWldjUHNJVWdEWFZRM2dO?=
 =?utf-8?B?d1g1dnQ2R0F0ZGtOUEdoV1VhUkdBeGcrTVVOQjRWNXFOZFVmZENkZC9MSm1E?=
 =?utf-8?B?cEJwZUk1UWFOa3VKclpVRTlpbWNSUk5sQms3ZUpFWWpTMUpBTFpnUHdKaDVr?=
 =?utf-8?B?OGNRenBGbkRFYkVVR2gxRmk2bWhUemhDTS93TCt4dG5nMVhPRmpKMHlkZkpL?=
 =?utf-8?B?WWQyOVJmTDJaMWM1TkxwRkZic3E4Y211QmEwMFd5NFdTcEw4VVV5bTl3ZnNu?=
 =?utf-8?B?SEo1ZERwRTFiZCtqaFhRbWlsRTcxTG9CM0kxRXNsNkw1OWJqd2V3UlZ5ZEJt?=
 =?utf-8?B?cFE2amx5SlBXSEJjRE1tSEw4UXdLNVV4VDV5S3lxeFgvb3JRUVdvZXhsQkpa?=
 =?utf-8?B?V0liY3gwQkpQZkJGeGVLbGZBNGtGRkdSeGFVb2JrQTdLbmp2YUdNZU1TbUhx?=
 =?utf-8?B?WHJEZnY3bmRtWGlpVmpoOUEzelNSM2cyTlQ1ZVlDUEZsbllBSFkwUktrSUpq?=
 =?utf-8?B?clhSRjRBbmdMbDE0M3hFVVhQK2VqWU1BcVhwM21xenhRMWxyczlaU1pQemJt?=
 =?utf-8?B?NFNXK1lEQWpQWlowZHFBSWVwYVMrRWc0eHVVNEYxMHVpZTcyL3k5aWNsYURZ?=
 =?utf-8?B?K0gyWjFZamFrdWJCSm40MFhjMEpucldlSWpQWjRBZE9hdkxXU2RHbWlEQVlt?=
 =?utf-8?B?aHYyUEVXZ2xVT2lrOVlPekVFc2p1dEt6Q1R4dUlhTTBUbmphOFptZEdpSmJ0?=
 =?utf-8?B?bkxWSkU2c1hNMGUvbDN5V0NCT055RnhEZXNmT2pzYzEvKzdwd1R5dnplNlN1?=
 =?utf-8?B?SkJiZW5EaFJMSGd6UVFoc0diakZCWDRtVjRmM2NTdGNtZnNYOFhnNHFONVh2?=
 =?utf-8?B?QjRwV1BlaDJ1c0FmT2xmUUtZTFM5UUViRHMvQVlEWng4OEFNL3lsMlNBUkNv?=
 =?utf-8?B?bjdGQW94S2hNQWpxbGgzRWNKVmViNDRNTDVmMjBFVHRpbzJ6WWxBZDM1TDY2?=
 =?utf-8?B?U0JZQTdtd0dpOU9WRDlHZk91TVdjeFFZMjdRMEY4c2IyQ0p4Rk5JSUlwS3lV?=
 =?utf-8?B?c0dxT0hENC9qUnZ6SS9uZDhtaFY5ZEQrUFFEWTRQbStQYVphZmxKQlkzL0VM?=
 =?utf-8?B?MTZwUnh1K1NLMkQ3ZnM2RTJVUWdmTGZiN2RYOEN0U1V3Z1NmRFQxWVlEdnM0?=
 =?utf-8?B?a3phY045R2ZpblVkRUpKMmVMMU94ZzJnSjVRUXdodFMrSmFmZGxRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ITgGXemEP333y8v+A9IRUkwd8mANSusAtgAuETQ5BZAs+QmZJa73uNBx71vfoBw4fhwKAZx7tIktdzH2OwW63TktcJy7fT2tIo3YKJLD9PvBKpn3j/Lt7X+F2BGH6VLayfL7B6pBXVeoHkGlagwjJy4a42fLbiKPzr8ptjvuJIqmIqQ1zbO+u8IciL4uJ8KaZUgdtvhlnbizwtOmZHh/XqYjbXSnRTwgoNueq3nJJwiGHvvMqb90X0jXNcGeSZyUpXvIvn8dsqqvKCEp6h4nLOwnWyTZX+mp7OlIkere/mF7ZoOGteWEdXCcrOjtBm2J3rLRIU19ihVTqNu64zWUJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535427dc-6b2d-42d0-314f-08deb162aaf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:44:06.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BTMiX9EjJ50xYWf3WJ2mhkg1xumC2EryMmDcrTW2kUabVLYxKWXuGvJ3YPHW3H+/uClH9fia3i3V3tYoRzQug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogWmhhbmcsIExpeHUNCj5TZW50OiBX
ZWRuZXNkYXksIE1heSAxMywgMjAyNiAxMToyNyBBTQ0KPlRvOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPjsgTmF0w6FsaWEgU2FsdmlubyBBbmRyw6kNCj48bmF0YWxpYS5hbmRy
ZUBpbWUudXNwLmJyPg0KPkNjOiBhbmR5QGtlcm5lbC5vcmc7IExlY2huZXIsIERhdmlkIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+Ow0KPmppa29zQGtlcm5lbC5vcmc7IG51bm8uc2FAYW5hbG9nLmNv
bTsgc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207DQo+bGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUkU6IFtQ
QVRDSCB2MyAwLzZdIGlpbzogaGlkLXNlbnNvcjogc3RhbmRhcmRpemUgc2Nhbl90eXBlIGluaXRp
YWxpemF0aW9uDQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IEpvbmF0
aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+PlNlbnQ6IFR1ZXNkYXksIE1heSAxMiwg
MjAyNiAxMDo0OSBQTQ0KPj5UbzogTmF0w6FsaWEgU2FsdmlubyBBbmRyw6kgPG5hdGFsaWEuYW5k
cmVAaW1lLnVzcC5icj4NCj4+Q2M6IGFuZHlAa2VybmVsLm9yZzsgTGVjaG5lciwgRGF2aWQgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT47DQo+Pmppa29zQGtlcm5lbC5vcmc7IG51bm8uc2FAYW5hbG9n
LmNvbTsNCj4+c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207DQo+PmxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIExp
eHUNCj4+PGxpeHUuemhhbmdAaW50ZWwuY29tPg0KPj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAv
Nl0gaWlvOiBoaWQtc2Vuc29yOiBzdGFuZGFyZGl6ZSBzY2FuX3R5cGUNCj4+aW5pdGlhbGl6YXRp
b24NCj4+DQo+Pk9uIE1vbiwgMTEgTWF5IDIwMjYgMjI6MTY6MTYgLTAzMDANCj4+TmF0w6FsaWEg
U2FsdmlubyBBbmRyw6kgPG5hdGFsaWEuYW5kcmVAaW1lLnVzcC5icj4gd3JvdGU6DQo+Pg0KPj4+
IFRoaXMgc2VyaWVzIHJlZmFjdG9ycyB0aGUgSElEIHNlbnNvciBkcml2ZXJzIHRvIHN0YW5kYXJk
aXplIHRoZQ0KPj4+IGluaXRpYWxpemF0aW9uIG9mIHRoZSBpaW9fY2hhbl9zcGVjIHNjYW5fdHlw
ZSBzdHJ1Y3R1cmUuDQo+Pj4gRGlyZWN0IGluaXRpYWxpemF0aW9uIHVzaW5nIGNvbXBvdW5kIGxp
dGVyYWxzIHdhcyB1c2VkLg0KPj4+DQo+Pj4gVGhpcyBjaGFuZ2UgaW1wcm92ZXMgY29kZSByZWFk
YWJpbGl0eSBhbmQgZW5zdXJlcyB0aGF0IGFsbCBmaWVsZHMgb2YNCj4+PiB0aGUgc2Nhbl90eXBl
IHN0cnVjdHVyZSBhcmUgcHJvcGVybHkgemVyby1pbml0aWFsaXplZC4NCj4+PiBBZGRpdGlvbmFs
bHksIGZvciB0aGUgaGlkLXNlbnNvci1hY2NlbC0zZCBkcml2ZXIsIHRoZSBjaGFubmVsDQo+Pj4g
aW5pdGlhbGl6YXRpb24gbG9vcCB3YXMgcmVmYWN0b3JlZCB0byBpdGVyYXRlIGRpcmVjdGx5IG92
ZXIgdGhlIHNjYW4NCj4+PiBpbmRpY2VzLCBlbGltaW5hdGluZyByZWR1bmRhbnQgbG9naWMuDQo+
Pg0KPj5TZXJpZXMgbG9va3MgZ29vZCB0byBtZSBidXQgSSdsbCBsZWF2ZSBpdCBvbiB0aGUgbGlz
dCBhIHdoaWxlIHRvIGJvdGgNCj4+bGV0IHNhc2hpa28gY2F0Y2ggdXAgYW5kIGFueW9uZSBlbHNl
IHdobyB3YW50cyB0byBjYW4gaGF2ZSB0aW1lIHRvDQo+Pmxvb2suICBBbHNvIGlkZWFsbHkgZ2V0
IHNvbWUgdGVzdGluZy4NCj4+DQo+PkxpeHUsIGlmIHlvdSBkb24ndCBtaW5kLCBwbGVhc2UgY2Fu
IHlvdSBnaXZlIHRoaXMgYSB0ZXN0IG9uIHRvcCBvZiB0aGUNCj4+bW9yZSByYWRpY2FsIHJlZmFj
dG9yIHBhdGNoZXM/DQo+DQo+U3VyZSwgSSdsbCB0ZXN0IHRoaXMgc2VyaWVzIG9uIHRvcCBvZiB0
aGUgcmVmYWN0b3IgcGF0Y2hlcyB3aGVuIEkgaGF2ZSBzb21lIHRpbWUuDQoNCkhpIEpvbmF0aGFu
LA0KDQpJJ3ZlIGRvbmUgc29tZSBiYXNpYyB0ZXN0aW5nIG9uIHRoaXMgc2VyaWVzLiBIZXJlIGFy
ZSB0aGUgcmVzdWx0czoNCjEuIE5vIGlzc3VlcyBzZWVuIGZvciBoaWQtc2Vuc29yLWd5cm8tM2Qs
IGhpZC1zZW5zb3ItYWxzLCBoaWQtc2Vuc29yLXByb3gsIGhpZC1zZW5zb3ItbWFnbi0zZC4NCjIu
IERpZG4ndCB0ZXN0IGhpZC1zZW5zb3ItcHJlc3MgYXMgSSBjb3VsZG4ndCBmaW5kIGEgcGxhdGZv
cm0gd2l0aCB0aGUgY29ycmVzcG9uZGluZyBkZXZpY2UuDQozLiBUaGVyZSdzIGFuIGlzc3VlIHdp
dGggaGlkLXNlbnNvci1hY2NlbC0zZC4gU2FzaGlrbyBBSSByZXZpZXcgaGFzIGFscmVhZHkgaWRl
bnRpZmllZCB0aGUgcHJvYmxlbSBhbmQgcHJvdmlkZWQgcmV2aWV3IGNvbW1lbnRzLg0KDQpUaGFu
a3MsDQpMaXh1DQo=
