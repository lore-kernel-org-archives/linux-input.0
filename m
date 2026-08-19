Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9A3A7848;
	Wed, 19 Aug 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787099573; cv=fail; b=tCO3b7hpHFRVtC9osFG2m52tcso3B6RpfiAMFAKpipGtqTsBbYIILJ8Bq36ryb7nEE2NY2G6wqRB/oQIYQD/LwLmeZIMQI47kikFibepSBANOfqryRyfMyPjEXyM85gQ27GF+yN9V9mPnQFAchjM6JoIi0Q+f0h9MtUfSGindUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787099573; c=relaxed/simple;
	bh=cD4yoFG9A/xC3yhjWIU9JtDbSsFUtR2/pc/wo/pgWzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKi0iJA13DdFCcIDRIoS+ryfgQ0tveq4rxhzbMlAnR4m47vTkqTiy4K3MdirYokmUTPBoLyNidemC0KfL37LedMXtn8zzD16WSTVExqZ9W9CiN/73sjvMkKBvcW1VQ9tWW0Ql+q4QF1J4zU4pCVDC6YTikK1jxVEhGEqlhRexug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeYA2EZI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeYA2EZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787099568; x=1818635568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cD4yoFG9A/xC3yhjWIU9JtDbSsFUtR2/pc/wo/pgWzo=;
  b=EeYA2EZIWeLYsSF6Q3Arx7uX5Vbi/k3hEUQbIU5f7gV9jN1xWhxObr8c
   I51rYpdIRrP7VTv560OWMp5hPuehVQeewf3CCisfZdGziM6TeD18zEd/e
   f7wFKJrYm6yEVjVenF0v+xLPfH7loI2u2fZpkqzjs1iFmt0XXJAHKN5fG
   G/OhZho56c0Qp1Y0enDAGSSnyG4ZsykDroMgc0cu7nk0/vgkn8L/NMyZ7
   gajX0yQ0U8bIhGFRKTubGiSm8F/XNwvhNxx3bJVRdtqvGlq/td7Cq6s88
   owopfj/73kDKxnQU5me6VrN+YvvtNvfhvRxcPHn6Ub96DnA1qPU/9edxS
   A==;
X-CSE-ConnectionGUID: zt/NtQH8RAuvcXrAx4fCag==
X-CSE-MsgGUID: +GJmSXBlTdOZcssohnb7tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87808297"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87808297"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:32:46 -0700
X-CSE-ConnectionGUID: tFqe/murTsaBQfdhYKa2fQ==
X-CSE-MsgGUID: rB2rBiddQSiQ3/jIHSU5RQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:32:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 17:32:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 17:32:45 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 17:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTcLLZAAzzaoA7ExrIJgQuSVYTFioPRZb+tcdc1QZc8bHvVcB5rLy5YQHifPvqIfVHvNP2NfDfyAW9TGvvifpqxaYx9PYxcH+X/xnSNc+1bRRIRsNgMRaP2n0Cve6+TnKekJWl56Jy9ayZBPTgiXOLspxapnk0nBvFVTM33DjLc32eCgrP6nKg1p4Fy/IvR3Oon8PnA8XWzowMFDgl0WL9mFB3+zLOazJkC++4czrUFv66HD2/1FMWfgwHvxmaszSdxJkeZX8/0i+UbjNkK+jc4dwVLlAFxy4fvjhv+jttJMa1ln2xocAL3bGH3EfvfL/JFeQrlrZn0lH59KlfRfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD4yoFG9A/xC3yhjWIU9JtDbSsFUtR2/pc/wo/pgWzo=;
 b=zDLDlpslQ9tfgXo8ohZG76wETaVl0DSWOmfi2GTwFotXoRqMO55zhrBIFdGOwaUVPW/KKvYsoRcRINowrLOubmmrPKnRZDbwwd6SlZVp7UpAE4qabPCQ/ZPvRtbdXoWVYarV9vsIAqdzzoKLoq6ja/q6hnXjJquBJ+OEBU+rjHHidGODF7P5Uqf8t3A6m4LT8cf/N13zntWobj0K0H+iZ3SpNFUwhWbI5Vxm2kPrVmbaVEHc/jpCuQIZaIm8LJE+q5GCwjNBG4Y9y8IFkH1sfOaEFabS2HV/P+hZWPMt59YLUCnupAexJmSAGqhRiP+d64uorLRCtFDFlKYetC1AsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) by
 IA4PR11MB9011.namprd11.prod.outlook.com (2603:10b6:208:56b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 00:32:36 +0000
Received: from DM4PR11MB6119.namprd11.prod.outlook.com
 ([fe80::fda9:b532:7332:45f3]) by DM4PR11MB6119.namprd11.prod.outlook.com
 ([fe80::fda9:b532:7332:45f3%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 00:32:35 +0000
From: "Xu, Even" <even.xu@intel.com>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Sun,
 Xinpeng" <xinpeng.sun@intel.com>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: reject oversized QuickSPI GET_REPORT
 responses
Thread-Topic: [PATCH] HID: intel-thc-hid: reject oversized QuickSPI GET_REPORT
 responses
Thread-Index: AQHdLxpr8u3LG51txEyK3m/MYoE3NLakhftw
Date: Wed, 19 Aug 2026 00:32:35 +0000
Message-ID: <DM4PR11MB61198899A6594C4B6DDC9699F4A52@DM4PR11MB6119.namprd11.prod.outlook.com>
References: <20260818140245.1903804-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260818140245.1903804-2-Jeremy.Jean@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6119:EE_|IA4PR11MB9011:EE_
x-ms-office365-filtering-correlation-id: 830797f0-3805-4032-94d5-08defd895dad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 13gQtUuVJ7TB5qRhdyeD3IgaPsAqyJFXRu5scHNi/x8yWkkbLz5nIRF0x5KUxR/zDN0GFx2ZObt+kifqyih/k0v2eYL7lH5rp1k7ye+Z/Dd4pfDzvc8vTDTklgk2PH2Tw6wLcKMYCDspqQch67gBj26+AWDedDhSrl/BsKchRZFi02X3xKVWDIVHZ0/Z+hAHsZ9b0jB1hIkaXrWHT3IBSUPXf1YXZQd/NFGQGkTSrbeisDDPu06SfpqpZ6PVwzUKJ0+otudRJfV+RnEUrQT2UHP8S5BOg0tjEIwRwmDEz7oKco+f1FldDlY+xHKU/cD4XNB9ChnRqcPWUkn/t3sSCjcW1/bI3eYJzGSwtrpyqhPsWm+h+hjtuZQK0DurAdgnqegUaAwO0oO3t5PA2URVNIYOkmR5ZrwP3fIwRT+eueGFMA+hL7Aw5pm0TDQxjRtOEuTWgvQlZzv1ZahOD8xcX4CQ0IEZ+MLF2BbVaRM5CnHDNx+Dvt1w4T0tPJDIW9lmpvR7nWLsz3Ae9+jAeunA+7jrM/kpf9ZxSFk0mWJAupHIbKC5JS13tS7uifSCMea6XMm5XF+z6oV6DoB2FawrFFVy/WT+fC9ANQBsPCeniZWjrws1EKH/XxN+d74YngGahKalP81u2zgZLo3aTGJzrY2gJ8nRj8Wv7LwN0H4w3j+7LZwqJxRqqirem83lsujFosISsru4YB0F3CP6D8asVWedCpcH4KBixfh0CbL3hvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6119.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW45MHlMaW5qZUllczdXcWQ3UzNjRTcwUkVxWWVES0VBczhkd0JSM1VzSFRB?=
 =?utf-8?B?b0g4bmRPUGkxVjJJMVF5NHIxY1ViWml0UDlpMnFXZXR0OWlha3RiSTZkYjFW?=
 =?utf-8?B?Vkptam4ydTRGdmdiaElYcHpOWDZUTTEvbGhMb1BtdHg0WmJ6dEVpenJWU2VY?=
 =?utf-8?B?RTlTV29VcFNNRm1KanRiSGJ0SzRxSkROU3pRU3loRU9oK3M5R2NoZUY3U1hM?=
 =?utf-8?B?Qm9yY2ZleUtjdlB6aGdTRU9kMHF4d0JxZ3kvdGpKamRzcVRWNEY2WWEwOEVu?=
 =?utf-8?B?SjV3aytySmtMeEZHS0pzVXJQTS9KbmdVYi9SRjFKZ0tlZk52OHRZSmlFNU5m?=
 =?utf-8?B?RlFzdzZMVFUycW1zT1MzMVhLbzV1TW1CUEZnRHZoT3ltaEdzdVNmc0NKajI3?=
 =?utf-8?B?a203UWorUENhSitkTVk3VnNlelVtd1hza3RJbVcrc2kyaVEzMTB1cTBGVFNP?=
 =?utf-8?B?bURBVnZ5aWFpRXlaelpZcldydE1tR21pWVZsdEpJRDA3aGFoS2I5UHgvWElz?=
 =?utf-8?B?anhLR3h0NTRYQjhwUG5kWjY2N3NOTGhzN2hIT3duMVprelBydlJHMk9qSXpM?=
 =?utf-8?B?TDJYWHdJdlprWmJyWUp2RS9LNjluL3NQWjE0OStoVVJ5RGpxUHVibGhCUGU4?=
 =?utf-8?B?S0ZMY1R3WUdPd2wrT3k5MlhXUnZONHZRSmlVcktSZHR5RUxvQXMyaHNGbGdk?=
 =?utf-8?B?RXU3d3UvRzF5aVFUc1M4cm1MYTVjZnBxN1RLOXRxeGFZeHFOekFCSGdnTWVG?=
 =?utf-8?B?WEpHRzZyd2xJdmJsYS8yMlhrKzRkc0dEQ3pDMTAyRzdyV3NLa0RlUFYveExJ?=
 =?utf-8?B?SVpDZmlZaUlHTHlIdjVlTEFyZlFwS21FdWJybCs2TlBiVTh1M0RjT3lFcjc2?=
 =?utf-8?B?Unh5VlBETWdpdWxZQXRNdjE4OC9WVVBJRDExbXdhOEtBSWM3OG9mZ0huR1RD?=
 =?utf-8?B?eUVPbGF6MlE0enBFU09TcENuRXR5eEpHVDcyTGRKbjhLci8wTHlJSXBLUm11?=
 =?utf-8?B?eDkzaGE2bFdHUU9PZGhwOUpSY1VJN3Rzd08rbVlsQjhPQnYwWkprczREcERY?=
 =?utf-8?B?a3IvblpDeld1WjFhQ0VrVUJ6WnVEbUtxRkFyZXlJeE52eWFzMzR6VGhwRVdW?=
 =?utf-8?B?enpCOVkyM3dQdStWZFlQOHJGNWFFNmtwSmVZZm8vblgxY1J6bnFJbng4VmZT?=
 =?utf-8?B?WWxpNDl0RUk3V0NXcXVOQSt6bG9DTGJlZ1psQUZWY1p0OVJXMytYOWJEYzB3?=
 =?utf-8?B?U1NOOEJqMm5nc2xoWlRXdzBQRkZCQWo1VElzaUxtY0UvS3FsaFJGMlVoNVdv?=
 =?utf-8?B?MlVweGVWa2dGVEFSMW5DNWV0VkIwdFBMdE1ac1RjQjhBQWNVWUk1L2gvRDBl?=
 =?utf-8?B?MTFnb2V6emUxcFExZ0dMWTNnOTl0L3A2ekthc1pzdlZYUFRWWC9vVlVVbGpa?=
 =?utf-8?B?Q1RQYVZQSDVyb3VJa1RyZG5WOVFzd3d4T2o5cE50ZGJRUVdJNWtFUVRNYVgw?=
 =?utf-8?B?R21heWc0SzQ2ejhnT0lFeVdrSDFFdU1iOHdRWmUvV1BQcFZqby9NWms2MWhw?=
 =?utf-8?B?ZzVFNE5td2NOMFlYSytyRktoZU9ROU5TMTBwM0VvR1c0YlkxWi9MTGRnSW56?=
 =?utf-8?B?YWx1ZHVLUExuM3BpTEh6bStxcDgyM2IvV3Y2clVpbUtzSk43SUZkVmpuTk9n?=
 =?utf-8?B?ei81T2wyQ1lUYzNQckdNWGFzNG9ueWJOOUpTbmErckFZWElES0VWVVB6VWpE?=
 =?utf-8?B?MWtEZGhWTGlWTjhZdUZLZGsvcE13THBMSnBWTzFWbExXMHRGelFEWThPcHB4?=
 =?utf-8?B?RDRnK3dsL0orbW9icmZtS0daazNXc3dKLzI5ZWNYZjhOMjFtaFg3d2Uxdy9U?=
 =?utf-8?B?KzBXSGM0ZjErNk1ITkh2aHBXZ0NVbkh1NnBGaktIa0lGdzdtMmF1TXVXa0Ru?=
 =?utf-8?B?US9XMURnc0FVVFJIa2ZQOXZ1UnlKYmx4cXh2dzNYNlhoZ3dsOEdtOVhNbjZq?=
 =?utf-8?B?V29DdUxURGU0Q3dBQ1dKY1Q1SVNTYzVNd09HeTVncnBZdXNJVklwdUUzeEtx?=
 =?utf-8?B?WUNIcm9PeTdPME8rZFFBN2U4Z3dlNjMxTytzMTJyWitnSjNSaytraUFkZTdr?=
 =?utf-8?B?Nlc4SUFLOXpHanZRdXY4WGtXUnRUYjhjOUxIdmpBL3l6WXJkMWxQYnRwWkU1?=
 =?utf-8?B?UjUwMitwcUV0Ykc1RVJFU00yS3pmRER1Tzh5cEhvc21nbnF5dnRLTU5FZGlH?=
 =?utf-8?B?Q21oQkVGcUV5OVBKN0M5M2RQaHMxTDBLQVZxYlRhRWZ3ZlN0QkVpWGFWMUgw?=
 =?utf-8?Q?HmR7cIrDI86QCnau4i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cgh9Vs0jyqKbiTnrrioEYwfznMtJXUR1K1ry4EILrgFTxVU9ivwOV1oL63z/LPAyqQgl5hK6rQPxPOvdpv1zvDNpglNjbeUmB9Tz/U773LePOcVquboVyL/UK04khpbM10DCtTx1vDCz+pNMPuEahN+BptJReh6odH2uYpM9gkDv5nQ2SszJd1sojKn2VbxlLaYNuh1DIlYpG79K8VFqK5/BCRJz+reKbWCU865iF7m+OaHASF2DlRqkMW0RzRg/aXn/01AGCD8/2j9v+h+0oqyR1a05A6Rjk2Dkc4ZPf6f8YUKAkFrvtF4Te3IJlZ1TNBMf+mxmoUvEg9UGSv/93w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6119.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830797f0-3805-4032-94d5-08defd895dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 00:32:35.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEu23ues87/mSi+OFQN5xE/HTemeyhCBdJc93yk+KO7aGBeL/C/7uZSAeip83q5635x7sRDxo4wldyTA9iu/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9011
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSsOpcsOpbXkgSmVhbiA8
SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAx
OCwgMjAyNiAxMDowMyBQTQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPjsgU3Vu
LCBYaW5wZW5nIDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+DQo+IENjOiBKaXJpIEtvc2luYSA8amlr
b3NAa2VybmVsLm9yZz47IEJlbmphbWluIFRpc3NvaXJlcyA8YmVudGlzc0BrZXJuZWwub3JnPjsN
Cj4gbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBKw6lyw6lteSBKZWFuDQo+IDxKZXJlbXkuSmVhbkBvc3MuY3liZXIuZ291di5mcj4NCj4g
U3ViamVjdDogW1BBVENIXSBISUQ6IGludGVsLXRoYy1oaWQ6IHJlamVjdCBvdmVyc2l6ZWQgUXVp
Y2tTUEkgR0VUX1JFUE9SVA0KPiByZXNwb25zZXMNCj4gDQo+IFRocmVhZCB0aGUgSElEIGNvcmUg
Y2FsbGVyIGxlbmd0aCBpbnRvIHF1aWNrc3BpX2dldF9yZXBvcnQoKSBhbmQgcmVqZWN0IHJlc3Bv
bnNlcw0KPiB0aGF0IGV4Y2VlZCB0aGUgY2FsbGVyLXByb3ZpZGVkIGJ1ZmZlciBiZWZvcmUgdGhl
IGZpbmFsIGNvcHkuDQo+IFNuYXBzaG90IHRoZSBjb21wbGV0ZWQgcmVzcG9uc2UgbGVuZ3RoIG9u
Y2Ugc28gdGhlIGJvdW5kIGNoZWNrLCBjb3B5LCBhbmQNCj4gcmV0dXJuZWQgYnl0ZSBjb3VudCBh
bGwgdXNlIHRoZSBzYW1lIHZhbHVlLg0KPiANCj4gRml4ZXM6IDlkOGQ1MTczNWEzYSAoIkhJRDog
aW50ZWwtdGhjLWhpZDogaW50ZWwtcXVpY2tzcGk6IEFkZCBISURTUEkgcHJvdG9jb2wNCj4gaW1w
bGVtZW50YXRpb24iKQ0KPiBBc3Npc3RlZC1ieTogQ29kZXg6Z3B0LTUNCj4gU2lnbmVkLW9mZi1i
eTogSsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+DQo+IC0tLQ0K
PiAgLi4uL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktaGlkLmMgICB8ICAy
ICstDQo+ICAuLi4vaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktcHJvdG9jb2wuYyAgICAgICAgICAg
IHwgMTUgKysrKysrKysrKysrLS0tDQo+ICAuLi4vaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktcHJv
dG9jb2wuaCAgICAgICAgICAgIHwgIDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9p
bnRlbC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3F1aWNrc3BpLWhpZC5jDQo+IGIvZHJpdmVycy9o
aWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1oaWQuYw0KPiBpbmRleCA5
MWQ1ODA3YjRhODMuLmE2MGEwYTdmMTZhYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9oaWQvaW50
ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1oaWQuYw0KPiArKysgYi9kcml2ZXJz
L2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3F1aWNrc3BpLWhpZC5jDQo+IEBAIC02
MSw3ICs2MSw3IEBAIHN0YXRpYyBpbnQgcXVpY2tzcGlfaGlkX3Jhd19yZXF1ZXN0KHN0cnVjdCBo
aWRfZGV2aWNlICpoaWQsDQo+IA0KPiAgCXN3aXRjaCAocmVxdHlwZSkgew0KPiAgCWNhc2UgSElE
X1JFUV9HRVRfUkVQT1JUOg0KPiAtCQlyZXQgPSBxdWlja3NwaV9nZXRfcmVwb3J0KHFzZGV2LCBy
dHlwZSwgcmVwb3J0bnVtLCBidWYpOw0KPiArCQlyZXQgPSBxdWlja3NwaV9nZXRfcmVwb3J0KHFz
ZGV2LCBydHlwZSwgcmVwb3J0bnVtLCBidWYsIGxlbik7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2Ug
SElEX1JFUV9TRVRfUkVQT1JUOg0KPiAgCQlyZXQgPSBxdWlja3NwaV9zZXRfcmVwb3J0KHFzZGV2
LCBydHlwZSwgcmVwb3J0bnVtLCBidWYsIGxlbik7IGRpZmYgLQ0KPiAtZ2l0IGEvZHJpdmVycy9o
aWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1wcm90b2NvbC5jDQo+IGIv
ZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1wcm90b2Nv
bC5jDQo+IGluZGV4IGNiMTkwNTdmMTE5MS4uYWNjOWQ2N2M1M2NhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3F1aWNrc3BpLXByb3RvY29s
LmMNCj4gKysrIGIvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlj
a3NwaS1wcm90b2NvbC5jDQo+IEBAIC0zNDIsMTAgKzM0MiwxMiBAQCBpbnQgcmVzZXRfdGljKHN0
cnVjdCBxdWlja3NwaV9kZXZpY2UgKnFzZGV2KSAgfQ0KPiANCj4gIGludCBxdWlja3NwaV9nZXRf
cmVwb3J0KHN0cnVjdCBxdWlja3NwaV9kZXZpY2UgKnFzZGV2LA0KPiAtCQkJdTggcmVwb3J0X3R5
cGUsIHVuc2lnbmVkIGludCByZXBvcnRfaWQsIHZvaWQgKmJ1ZikNCj4gKwkJCXU4IHJlcG9ydF90
eXBlLCB1bnNpZ25lZCBpbnQgcmVwb3J0X2lkLA0KPiArCQkJdm9pZCAqYnVmLCBzaXplX3QgYnVm
X2xlbikNCj4gIHsNCj4gIAlpbnQgcmVwX3R5cGU7DQo+ICAJaW50IHJldDsNCj4gKwl1MzIgcmVw
b3J0X2xlbjsNCj4gDQo+ICAJaWYgKHJlcG9ydF90eXBlID09IEhJRF9JTlBVVF9SRVBPUlQpIHsN
Cj4gIAkJcmVwX3R5cGUgPSBHRVRfSU5QVVRfUkVQT1JUOw0KPiBAQCAtMzcxLDEwICszNzMsMTcg
QEAgaW50IHF1aWNrc3BpX2dldF9yZXBvcnQoc3RydWN0IHF1aWNrc3BpX2RldmljZSAqcXNkZXYs
DQo+ICAJCXJldHVybiAtRVRJTUVET1VUOw0KPiAgCX0NCj4gIAlxc2Rldi0+Z2V0X3JlcG9ydF9j
bXBsID0gZmFsc2U7DQo+ICsJcmVwb3J0X2xlbiA9IFJFQURfT05DRShxc2Rldi0+cmVwb3J0X2xl
bik7DQo+ICsNCj4gKwlpZiAocmVwb3J0X2xlbiA+IGJ1Zl9sZW4pIHsNCj4gKwkJZGV2X2Vycl9v
bmNlKHFzZGV2LT5kZXYsICJHZXQgcmVwb3J0IHJlc3BvbnNlIHRvbyBsYXJnZTogJXUNCj4gdnMg
JXp1XG4iLA0KPiArCQkJICAgICByZXBvcnRfbGVuLCBidWZfbGVuKTsNCj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ICsJfQ0KPiANCj4gLQltZW1jcHkoYnVmLCBxc2Rldi0+cmVwb3J0X2J1ZiwgcXNk
ZXYtPnJlcG9ydF9sZW4pOw0KPiArCW1lbWNweShidWYsIHFzZGV2LT5yZXBvcnRfYnVmLCByZXBv
cnRfbGVuKTsNCj4gDQo+IC0JcmV0dXJuIHFzZGV2LT5yZXBvcnRfbGVuOw0KPiArCXJldHVybiBy
ZXBvcnRfbGVuOw0KPiAgfQ0KPiANCj4gIGludCBxdWlja3NwaV9zZXRfcmVwb3J0KHN0cnVjdCBx
dWlja3NwaV9kZXZpY2UgKnFzZGV2LCBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9oaWQvaW50ZWwt
dGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1wcm90b2NvbC5oIGIvZHJpdmVycy9oaWQv
aW50ZWwtDQo+IHRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktcHJvdG9jb2wuaA0KPiBp
bmRleCA3NzVlMjljMWVkMTMuLmFhMmM5MzVkYWZlOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9o
aWQvaW50ZWwtdGhjLWhpZC9pbnRlbC1xdWlja3NwaS9xdWlja3NwaS1wcm90b2NvbC5oDQo+ICsr
KyBiL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcXVpY2tzcGktcHJv
dG9jb2wuaA0KPiBAQCAtMTIsNyArMTIsNyBAQCBzdHJ1Y3QgcXVpY2tzcGlfZGV2aWNlOw0KPiAN
Cj4gIHZvaWQgcXVpY2tzcGlfaGFuZGxlX2lucHV0X2RhdGEoc3RydWN0IHF1aWNrc3BpX2Rldmlj
ZSAqcXNkZXYsIHUzMiBidWZfbGVuKTsNCj4gaW50IHF1aWNrc3BpX2dldF9yZXBvcnQoc3RydWN0
IHF1aWNrc3BpX2RldmljZSAqcXNkZXYsIHU4IHJlcG9ydF90eXBlLA0KPiAtCQkJdW5zaWduZWQg
aW50IHJlcG9ydF9pZCwgdm9pZCAqYnVmKTsNCj4gKwkJCXVuc2lnbmVkIGludCByZXBvcnRfaWQs
IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4pOw0KDQpUaGUgc2FtZSBwYXRjaCB3YXMgYWxyZWFk
eSBzdWJtaXR0ZWQgaGVyZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW5wdXQvSUEx
UFIxMU1CNjA5OEM2QUFEMjNBQzMzMjgxRkZENkQ2RjRERTJASUExUFIxMU1CNjA5OC5uYW1wcmQx
MS5wcm9kLm91dGxvb2suY29tLw0KDQo+ICBpbnQgcXVpY2tzcGlfc2V0X3JlcG9ydChzdHJ1Y3Qg
cXVpY2tzcGlfZGV2aWNlICpxc2RldiwgdTggcmVwb3J0X3R5cGUsDQo+ICAJCQl1bnNpZ25lZCBp
bnQgcmVwb3J0X2lkLCB2b2lkICpidWYsIHUzMiBidWZfbGVuKTsgIGludA0KPiBxdWlja3NwaV9n
ZXRfcmVwb3J0X2Rlc2NyaXB0b3Ioc3RydWN0IHF1aWNrc3BpX2RldmljZSAqcXNkZXYpOw0KPiAt
LQ0KPiAyLjQ3LjMNCg0K
