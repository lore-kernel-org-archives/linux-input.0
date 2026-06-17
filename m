Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D393391842;
	Wed, 17 Jun 2026 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725850; cv=fail; b=qRtEyjgIey8+UGxuPQXhbpdUjlbQ0RArr3DC/6GCWNDrbLPXfWDpZw8wESCzKjaaK6ABco/0PY8LX6r76fOJ0oNaMTBI8HH05MJeFgIazdNt6t6bRmza0sokWSdXbl3hteTL/NdSy8LtBZFzubk8vVBwDdNSAKFnwK4cERk1OoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725850; c=relaxed/simple;
	bh=K+s8etBVkXjalFglEgV8gh3IzhlvwMi+nYrSculqqlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiI87Hhkf4qv7MzK+HjTuFqx+8MEXsdBIxDSwRMKoXJ+1xpIBuaqZusoV+kq6/MdZlEjk4CZSayOseq3yK6/R/T0wuO9CL0pufbn2bevqKvg0QGbVvXmbM/PTAjCiQsS66HxfW755HACWmVbUGZxtaBCkEB2t51nzsQCOagU5yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv2Uwy3m; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv2Uwy3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781725844; x=1813261844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K+s8etBVkXjalFglEgV8gh3IzhlvwMi+nYrSculqqlg=;
  b=Xv2Uwy3mKN8nxwHuHtbxCgtElSeRmx5MJfbIlySj9vCdawaYJ/RSIDyq
   viihuZf9+J93pjWB3C+UPHryqulPlEhZcD3VGJzBXFx5ehfS95LcMxULb
   E7NFOKxGZjSBQ8Dh6leziEr+u5h5u9ito54zd5nKjgrOlmdBc2uqLEv+v
   ObjGFH/YOKkIF1J2NpcrE6GjGpDpDY7Hi13BZ15AGvH3zrelg/E0Ektc9
   vAZvC6gMW15GxBsYWQ1j2GGobtFGJMxjpCVciAQGTCQ5gMV8B8FIyreY9
   ngMPT+ce7tv9WWij2czRydzmORpKzwjXQfwCraWNRq3Bky4VH0Ivt7zpW
   Q==;
X-CSE-ConnectionGUID: xUlB1ACbQ12tUb7H+MhWWg==
X-CSE-MsgGUID: iTt9n8RVQcKV50DaFM3Ltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82421190"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82421190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 12:50:43 -0700
X-CSE-ConnectionGUID: goRj9BW0SY2CmsuV3ApAHQ==
X-CSE-MsgGUID: uqlm44TgT/ix6ElvhyopBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="247017595"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 12:50:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 12:50:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 12:50:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 12:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B79HgOFad/UQ5wYMcGCnjUhxJKMmAtrzUIF15nmxzZRYWnk6qkxw9IvoQo8bmWNTij6YOrg2yMK0TPSplD3ONc5ebfaSv804tDjeLoLOFsDEQCq6Jpj9q1SFD+cdkppvy2Po2QYx7EXXqYYp9qJkg88cUcaafWGukVyj76DFt176KmmRBk+JbyJ3M12WzjhRCtUYgM1fxDsbx/NF/TNpMe+JDuUrxWCgBLfppyhDTB8lrfgNkISkrB4cmquwy2V0T28bX4PgbHzwmlAhv2GY95/pUusVmRuYnNhp3YelAtKebVZr9+9E/hnO+/FujOLVWegJ2f7E3f47ezHIf4USDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+s8etBVkXjalFglEgV8gh3IzhlvwMi+nYrSculqqlg=;
 b=ueobKBkYyp1zbtB6xa96u70uPjRLz0LvzikdNkMsgD60i/VqLVbGZAS0vx2f5koAkklnVV7P1naHC7sOxe4HfDV3NWKgFhXehpc4j1I9T8zO1Hr+VRrmLVRzdHrRGNl7EWLPIS7CKQ0RWMNPV1PMPNGccFdJsp8vtcMrVB+pX1r9uyDpfHSQFXufSi6F/n3rgewPyQZM+YDrDoSKuio/jZzWLMJCldqNfPUEjxRNn143a58gsooAPq+zP8WlTE4Sq+PYsRaX8jIPrPFum6paqDYKKKY5af1dhpvptRuN0CTsZDxhkq5jB3rXINUsNq/u9yvSMTmJkQtslcBSEvOxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 19:50:39 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::4fe4:767e:7ec8:6fd9%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 19:50:35 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "sanjayembeddedse@gmail.com"
	<sanjayembeddedse@gmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
	"hongyan.song@intel.com" <hongyan.song@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Topic: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Thread-Index: AQHc9ajtv0GfRdo5hEKCZI1S5o93iLY0zScAgAmdqQCAAUHeAIADeMAAgAAUXwA=
Date: Wed, 17 Jun 2026 19:50:35 +0000
Message-ID: <de3c6136ec40c8dd6ab8a2e586393a677b159c5b.camel@intel.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
		 <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
		 <b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com>
		 <20260614192442.6eaa1a54@jic23-huawei>
		 <50ce20dec63080dde13336c6af41c0bf4de43426.camel@intel.com>
	 <3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmail.com>
In-Reply-To: <3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH7PR11MB6497:EE_
x-ms-office365-filtering-correlation-id: 2c8fe6fe-d995-4878-4ba4-08decca9b2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|38070700021|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
x-microsoft-antispam-message-info: O15GH65T0s4TRjspm5XhqlSF94+kQdZWEQral+NY9LKO/XBjjdRpNKVBWeAuxQ+qgatvjoGy0ItBWFY4e7MuVHuT2EpIGHw6X7pFcUgPiBhmgIbB2AGeJEzL8FoKE/2Lhu3R72tnzDfxbtKpCEZRvAvddr/f+yD79rc2YN9uuYqRb8t39adECGbwCBY4NpIYmLphmTVyo8kC46SGCeKjwwO2WOWOex+dLfQ/frenchjuIOSFmAMzNBBcjH0/KdREzanO74H6FtpgwRmMds8+xb8qE9e5Np74VTpphuzOU2GoG9TTOD/dEkpy4dqvPqL/juFXnEoezat+Gyk4e2YUTvh0C+FEYzlbvZDOkhGlh7ff9mY2rkzWs2iJ1UVcx1NLJe56kj0QRaVi/BBHZV1r7YFC44qiE+DLeNQo7igBfrGKyksUOgZAQDMyqZSi2EcEOmTmtWysBJFeYTQ8fOduMeAP9QV/Eu7Nz32xp8MGcrLt6joX3uNLVsNdZ8xQaYp8sshnU5l4fThlfpO8aeF9Fp43Iq4gMQZrcusFjR99yvQu/hIieuOwlb5CD57Xj+OgaiI/117rA4jPFGJj8CMfwUBJxbINA8AT6AlmXmU0SFewGLEDKlxHnuDpbk9TvC+SSI0lUGFjQkTZrNR24QSoKw+z6FSnZjAO9hizODKdG63aSGB0jCteGmGaqTBliqwkI1U5jHnjjGNGGtMYBxPXoWlOy480Fx5yEReZFY2kIsVFN3LtQNhWq6yxr8sFs9Mh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXlrajJmMEg2K0Z2UWxjY1psODdZOXNnT1ZDQnhBTjBNM1hUVStDNUgxU3dS?=
 =?utf-8?B?bDJuUmFpREFEdlNxNldFUFg1OWZzbXYvTnFTa2pMV2FIeklxOU40Z2VtWFFG?=
 =?utf-8?B?MnRKMDFScGVFbXZISEcwQnZiQ0NvU1F0OWNraEc1K29iWjBVdHk4RzJvQ0VB?=
 =?utf-8?B?WlQ1Q3FUUkxvendEWDhEc2E3cWNlWmQzTGNHSTQ1K1RQL09rTE96YUNzcm92?=
 =?utf-8?B?RUREcjc5MHNsODAxcUx2cVQwNWNwZ1VFcERiZTc1VVhaeDZiOVZSbEh6TzJO?=
 =?utf-8?B?SnRDYng4SG1CV0hZTFlDWE1acVRLWGh5UGtVUUhwVjhqSnpXZk9YdG90b2N1?=
 =?utf-8?B?S0FxQWtpV2lhcTIvRElnWEIwZ21PWkUzdmd3OXNEQUdTSXlYdWEra1RDemFJ?=
 =?utf-8?B?aUd4WjFoQ09pWWxMaGswVU8vd21Ic0JKb3I3VDRPVGRvWGFCTFFzN09jZHRS?=
 =?utf-8?B?WlNnMExYREQ5eXR4NjFOUDkwak83ci9WQUxWMHhORkpITnBqUXJGVVpyMzF5?=
 =?utf-8?B?UWtyVXJRNmU5R1hDcXZBYUtOd1YzUEhRMlZnSUNwWVZERmRWUFdRcXZIWGpC?=
 =?utf-8?B?WVFocDZhSkJMZDkxcE9ESGRxbmplV21ES1d1VUJHNEdCVktPQlFhZXZMdDQ0?=
 =?utf-8?B?SVBFdWpLdFVTeFF5SHdibG9kSkxvQlBSRlpaRE9nV25nV0dSY0tUeGVOT01W?=
 =?utf-8?B?SkswdmhRNlF1Zm9NUnFNOGZJNXN4bEYwZHg3eVFxMjc3QndRSDFZZ2RVUnIw?=
 =?utf-8?B?TExXcllSbkdOL0JVTG0xSXlRcmZhdXRSbktIdHJuMWdaaDJEemxrUzFnTUdm?=
 =?utf-8?B?ZnE2cHc0S0xoc01vNEYvSUxVZk8yZFYrVE5WZlcxK3MzUGFnSjNnT3Vmdzk3?=
 =?utf-8?B?VHBSTHluUFlwL2ZpQnBoY29ud3lMbmdsb2FXYWJmVFh6aUVoTGJHRHdGR1Ev?=
 =?utf-8?B?OUxIcG51M3BScm5IRjh4VXM3ZGJJYnNHTXJkdGh1M0dkdkZWV2g0STdrOGRU?=
 =?utf-8?B?bitua0xJeXptWkxuOUltdjh6WDZUUTVOaHlEUWh3U0RwWmpLZ1pjTERvSDht?=
 =?utf-8?B?cnUyTEoraGh2QkJNcFVJZWNZY1VnZzhoZUZQY0hTUmdZQTI3S3Vjb3A0eU5E?=
 =?utf-8?B?aHRlMWpMajFlcG5NaGlzM0V3NnRTZXg1UWV4VGQyczlTV29pSzF1V0laY0ls?=
 =?utf-8?B?bGJJVU5UbUt2Z1NJWDJ0UWcxdG5NQnVEUXNNcDJNWlpNcUh1MVBSZ1VUN0s5?=
 =?utf-8?B?MEpwbG9wWWh0bXA3SVU0RDRJRTZ0cCt5dDV2bzVab3FzcFlVNnZCbTViSWtt?=
 =?utf-8?B?clRuakF1UmhrSGRsMnMzYzR4NklMZXlEcVQ4RzQzVjM2YTZvcDQzOHNldWIv?=
 =?utf-8?B?eXU5TGg2cFR3Y0VGdU9oWGhhWGtWcTBOankrRXlWN1pGTW03clR2K3A3akQ4?=
 =?utf-8?B?SnVBMXhtQnIrK0hwYzVTV1kwVHRWdDlZZVpQYVNJYkwrNlJUZW1udFR0QVVv?=
 =?utf-8?B?RThQb3Zod0VySnA3UHhFZ0VWNVZqNlJjdXdxbTNDR3pyaXNQemY0UHF1ZUtI?=
 =?utf-8?B?bXFTTG9WMjhjV2t4QUNQUFJGZmYvYzIybVJOV1NyNUpzTmVEaWxidEowZURE?=
 =?utf-8?B?Q3ZKOVlkcHU2dmkwVEgvaHJJTzdVVjBqaVZlY0E4ekhtb1hmWnpaY2llNURm?=
 =?utf-8?B?cityeWVVSmFtUnpBempGanV4bENLQlQ0Ui9WQUc0Wk9URHZhcGxDUjhlSmRo?=
 =?utf-8?B?UTJiOUZ0eEgrTjFhalA1U1lyTmpOT2dhWEpMdnJ0U2owdU5XTmNOOHZpQ3RJ?=
 =?utf-8?B?MVB6Rm1MRnRMdy9lTGY2bmMyb0FFd1QxNTFVOVFoeWtpVlMwbEtsQmwzbnc3?=
 =?utf-8?B?SzlyZzZxWldGK2ZZNWxqWk9lejJpTk81dXJrZnR1emc2Y2R3QlM0dFg4YVZa?=
 =?utf-8?B?YW5Fd1dORkozVlVZZ1Q3eUV4VStoOGxjaHNITjcvUWxTS2xsd0xiYzgxeEQw?=
 =?utf-8?B?OGRtSXVYelBoYlpCUFNyZkNHYzJWaG4rR0FUM0NxOXhMdWlMLzBKaGMveDEw?=
 =?utf-8?B?WTZIdkdIaEE0T1JBbmh1YVd6c0RNcmdLMVRxQ2FJQXJVak5Ncm5HTHBZRHI3?=
 =?utf-8?B?dE9VRVRXVEt6WWptdGhWK0J6TjlrUUFNVUVHcFRaYThPalNQeHhyT2h6SUpN?=
 =?utf-8?B?aXJtVWNHSWdGSUJ5MDJPd3RUT1M3WVpuclJaVXpabElXbFVTa3ZtQS9ablNR?=
 =?utf-8?B?Q3JrakNpNEY2NGlPTnp0anNOYU9Fcm1MYkdTa21yRXdidVlaU2dLQWFGWTZm?=
 =?utf-8?B?eDlqZUxrdDM1cXZwQitCc1pZT0NKZU1tWnNsajNDTXBuTkpZUUkxR2o3Wm1r?=
 =?utf-8?Q?uNHMepEolMAmB2F9dd5UVcvO8g076P/f23HDH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9DC65F2D4DAD4DA07165B995130701@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: psQqDkhleHHUvg0udDOo6f4v0lox+tzzlv6C7gUSTQS7AoVJ4JXjOhGBek4IiRTz892uXOWesVsOYmcUPgEYVF1lDJrxxa3Mr8gAINZGhh727dHgM3H2Zc/bTU3SkefxM7L1MVYVZPXIPNOAEgdAfqnBF+u/PaF8CzARc+t23iC/0dafMW42bEjc2SCEHUr7YrjlKWV+n4jdXx5QodcOhQ6G3FRmGxklgjT+zK7HDYA1I7DFhSWPCnwbtpDgPN6wmOQHq6gKh0zAxG4cNd0VUPldOwT/MjPjP7jF9hcSPkdOXjd34oHLgFdh4vyEYQBpx3iSI4geEBJyOxk+Wjplaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8fe6fe-d995-4878-4ba4-08decca9b2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 19:50:35.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA3MU0sW3kGKPrbRNIjwe91qxB9m/lJBeyshYdvE6ubF/mT/qW9xuZfxVggK1TvCeuPIDvqsOMsTszs/B5BLwe+S9BaKjxkoJQED/3B/l4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDAwOjA3ICswNTMwLCBTYW5qYXkgQ2hpdHJvZGEgd3JvdGU6
DQo+IA0KPiANCj4gT24gMTUgSnVuZSAyMDI2IDc6MDY6NDPigK9wbSBJU1QsICJQYW5kcnV2YWRh
LCBTcmluaXZhcyINCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4g
PiBPbiBTdW4sIDIwMjYtMDYtMTQgYXQgMTk6MjQgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3Jv
dGU6DQo+ID4gPiBPbiBNb24sIDggSnVuIDIwMjYgMTU6MzQ6MDUgKzAwMDANCj4gPiA+ICJQYW5k
cnV2YWRhLCBTcmluaXZhcyIgPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gPiBPbiBTYXQsIDIwMjYtMDYtMDYgYXQgMTc6MDcgKzA1MzAsIFNhbmph
eSBDaGl0cm9kYSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBTYW5qYXkgQ2hpdHJvZGEgPHNhbmph
eWVtYmVkZGVkc2VAZ21haWwuY29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBkcml2ZXIg
cmVnaXN0ZXJzIHRoZSBJSU8gZGV2aWNlIGJlZm9yZSBjb21wbGV0aW5nIHNlbnNvcg0KPiA+ID4g
PiA+IGh1Yg0KPiA+ID4gPiA+IGNhbGxiYWNrIHJlZ2lzdHJhdGlvbiBhbmQgdW5yZWdpc3RlcnMg
Y2FsbGJhY2tzIHdoaWxlIHRoZSBJSU8NCj4gPiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gPiBpcyBz
dGlsbCBleHBvc2VkIGR1cmluZyB0ZWFyZG93bi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlz
IGNyZWF0ZXMgcmFjZSB3aW5kb3dzIGluIGJvdGggcHJvYmUgYW5kIHJlbW92ZSBwYXRocywNCj4g
PiA+ID4gPiB3aGljaA0KPiA+ID4gPiA+IGNhbg0KPiA+ID4gPiA+IGxlYWQgdG8gTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlcyBvciB1c2UtYWZ0ZXItZnJlZS7CoCANCj4gPiA+ID4gDQo+ID4gPiA+
IFJlb3JkZXJpbmcgaXMgZmluZSwgYnV0IGNhbiB5b3Ugc2hvdyBob3cgdGhpcyB1c2UgYWZ0ZXIg
ZnJlZSBpcw0KPiA+ID4gPiBwb3NzaWJsZT8NCj4gPiA+IEFncmVlZCAtIEknbSBub3Qgc2VlaW5n
IGEgZGVmaW5pdGUgaXNzdWUgc28gbW9yZSBpbmZvIG5lZWRlZC4NCj4gPiA+IEZvciBub3cgSSdt
IGdvaW5nIHRvIG1hcmsgdGhpcyBjaGFuZ2VzLXJlcXVlc3RlZCBpbiBwYXRjaHdvcmsuDQo+ID4g
PiANCj4gPiA+IEl0IG1pZ2h0IGJlIGEgdG91Y2ggc2xvdyBpZiBzb21lb25lIG1hbmFnZXMgdG8g
Z2V0IGJ1ZmZlcmVkDQo+ID4gPiBjYXB0dXJlDQo+ID4gPiB1cCBiZWZvcmUgdGhlIGNhbGxiYWNr
cyBhcmUgYXZhaWxhYmxlLCBidXQgSSB0aGluayB0aGF0IGp1c3QNCj4gPiA+IG1lYW5zDQo+ID4g
PiBkcm9wcGluZyBhIGZldyBzYW1wbGVzPw0KPiA+IA0KPiA+IA0KPiA+IENvcnJlY3QuDQo+ID4g
DQo+ID4gVGhhbmtzLA0KPiA+IFNyaW5pdmFzDQo+IA0KPiBIaSBKb25hdGhhbiBhbmQgU3Jpbml2
YXMsDQo+IA0KSGkgU2FuamF5LA0KDQoNCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBmb3Ig
cG9pbnRpbmcgdGhpcyBvdXQuDQo+IA0KPiBBZnRlciBhbmFseXppbmcgYW5kIGludmVzdGlnYXRp
bmcgdGhlIGludGVyYWN0aW9uIGJldHdlZW4gY2FsbGJhY2sNCj4gcmVnaXN0cmF0aW9uIGFuZCBp
aW9fZGV2aWNlX3JlZ2lzdGVyKCkuDQo+IA0KPiBGb3VuZCB0aGF0IHJlYWRfcmF3KCkgKG9uLWRl
bWFuZCBhY2Nlc3MpIGFuZCBidWZmZXJlZCBJSU8gKHN0cmVhbWluZykNCj4gb3BlcmF0ZSB2aWEg
ZGlmZmVyZW50IHBhdGhzLiBUaGUgcHJpbWFyeSBpbXBhY3QgaXMgbG9zcy9zdGFibGUNCj4gc2Ft
cGxlcyByYXRoZXIgdGhhbiBkYXRhIGNvcnJ1cHRpb24gb3Igc3lzdGVtIGluc3RhYmlsaXR5Lg0K
PiANCj4gR2l2ZW4gdGhpcywgSSBiZWxpZXZlIHRoZSBjaGFuZ2UgZG9lcyBub3Qgc3RyaWN0bHkg
cXVhbGlmeSBhcyBhICJmaXgiDQo+IGZvciBhIHVzZXItdmlzaWJsZSByZWdyZXNzaW9uLCBidXQg
cmF0aGVyIGFzIGFuIGltcHJvdmVtZW50IHRvDQo+IHRpZ2h0ZW4gb3JkZXJpbmcgYW5kIGF2b2lk
IGEgcG90ZW50aWFsIHJhY2Ugd2luZG93Lg0KPiANCj4gVHJlYXRpbmcgdGhpcyBhcyBhIGltcHJv
dmVtZW50IHBhdGNoIHJhdGhlciB0aGFuIGEgYnVnIGZpeCB3aXRoDQo+IHBvdGVudGlhbCBmb2xs
b3dpbmcgY29tbWl0IG1lc3NhZ2UgaW4gdjIuDQo+IA0KPiAuLi4uLi4uLi4uLi4uDQo+IA0KPiBp
aW86IG9yaWVudGF0aW9uOiBoaWQtc2Vuc29yLWluY2wtM2Q6IEF2b2lkIHJhY2UgYmV0d2VlbiBj
YWxsYmFjaw0KPiBzZXR1cCBhbmQgZGV2aWNlIGV4cG9zdXJlDQo+IA0KPiBUaGUgZHJpdmVyIGN1
cnJlbnRseSBleHBvc2VzIHRoZSBJSU8gZGV2aWNlIHRvIHVzZXJzcGFjZSBiZWZvcmUNCj4gY29t
cGxldGluZyBzZW5zb3IgaHViIGNhbGxiYWNrIHJlZ2lzdHJhdGlvbiwgYW5kIHNpbWlsYXJseSBy
ZW1vdmVzDQo+IGNhbGxiYWNrcyB3aGlsZSB0aGUgZGV2aWNlIGNhbiBzdGlsbCBiZSBhY2Nlc3Nl
ZCBkdXJpbmcgdGVhcmRvd24uDQo+IA0KPiBUaGlzIGNyZWF0ZXMgYSB0aW1pbmcgd2luZG93IHdo
ZXJlIHVzZXJzcGFjZSBtYXkgZW5hYmxlIHRoZSBidWZmZXINCj4gYmVmb3JlIGNhbGxiYWNrcyBh
cmUgYXZhaWxhYmxlLiBJbiBzdWNoIGNhc2VzOg0KPiAtIHNhbXBsZXMgY2FuIGJlIGRyb3BwZWQs
DQo+IC0gYnVmZmVyZWQgcmVhZHMgbWF5IG9ic2VydmUgc3RhbGUgb3Igbm8gZGF0YS4NCj4gDQo+
IFJlb3JkZXIgcHJvYmUgYW5kIHJlbW92ZSBwYXRocyB0byBlbnN1cmUgY2FsbGJhY2tzIGFyZSBh
Y3RpdmUgYmVmb3JlDQo+IGRldmljZSBleHBvc3VyZSBhbmQgYXJlIHJlbW92ZWQgYWZ0ZXIgZGV2
aWNlIGlzIG5vIGxvbmdlciBhY2Nlc3NpYmxlLg0KPiANCj4gVGhpcyBhdm9pZHMgYSByYWNlIHdp
bmRvdyBsZWFkaW5nIHRvIGRhdGEgbG9zcy4NCj4gDQoNCkxvb2tzIGdvb2QuDQoNClRoYW5rcywN
ClNyaW5pdmFzDQoNCg0KPiAuLi4uLi4uLi4uLi4uDQo+IA0KPiBXZWxjb21lIHlvdXIgZmVlZGJh
Y2sgYW5kIHZhbHVhYmxlIGlucHV0IGZvciB2Mi4NCj4gDQo+IFRoYW5rcywgU2FuamF5DQo+IA0K
PiA+IA0KPiA+ID4gDQo+ID4gPiBKb25hdGhhbg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBU
aGFua3MsDQo+ID4gPiA+IFNyaW5pdmFzDQo+ID4gPiANCg==
