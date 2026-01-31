Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03952D3A6A;
	Sat, 31 Jan 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842311; cv=fail; b=IlEI922QD/FSiH3NBznoxlA1+gMF+bMVn1pOn9n3A34+lRBlxzEh/vNk1sXeYsqPqvrF9mfcLhse8ePnMYATTh6lWTvBMhedrfL+RttwgdCFfTGXvarBoI73MgRYKCPQDS92J+2xsgS8yDNIn1AgusZZkLTyW8lp7Zj/XPpuF3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842311; c=relaxed/simple;
	bh=EPDPEDKSzP3Rnh4Dk5DDglDakZhsy1s0W3ieJXHgT7w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxVhmUiQ4AjpHhykPrGka+vTbo2GckrH7prbjm35hbCtogFMiEgn5DbyCxw396GSMAMMrVaGnMecx1ycBdz6n7PaTJlhTQ4J27pdI0LpSMlIjF5qC3pixTICR1S0YuEkBBTDy8/4nsVsAgLlEgf1jRuB+wiCtTSHIaIPnrMZP0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3tjuSSO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3tjuSSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769842309; x=1801378309;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EPDPEDKSzP3Rnh4Dk5DDglDakZhsy1s0W3ieJXHgT7w=;
  b=m3tjuSSOPCpt5MTP6AwiT2Tm8h0xHvBIShtsL/usb6FL0ssQ4w0l8+ES
   4OXj1tipV7osltSbPOAkimfs70qdCDlTbcDoQd47qOf4xhVEFp+i9xOO3
   bj4l8R0wmgIbuaQdX3bi4MP/DMTcugL8JfDTPWzyPbTFMSV/MK+dQ5Br6
   H75gUQYj2DOqusXbGc8C0IkjXuTE8i3K34CzXey5oEjTZCdwNP4tKcJjb
   721N3qYcALuQc/NgCanvxaT9hPjJbQS22VGAu3uDaxwDWq87qhUFy9eqg
   PbohdPGMWEjxCwxt4/iQEL7z0YwkQVH6MPYk0uFJi0ozZZDJtf3u1CfXx
   A==;
X-CSE-ConnectionGUID: tz96iC33RHuJALoBR+5yTQ==
X-CSE-MsgGUID: ElAOJVpqQO+5s3pVp7Q86w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="73688731"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="73688731"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:51:47 -0800
X-CSE-ConnectionGUID: BHOpQvqkQniAw+rm3u+JRg==
X-CSE-MsgGUID: Dl+WTbNoQ1i4zy2DbQfyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208613751"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:51:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:51:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 22:51:48 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:51:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7Ps1Tq7MaDhCP9Qe2vkXj0B3wC3Ne9LrrLefietYfsjlyNiHCCnYfUZWy/k0ZvQBMswaaHWiaG0zMARRqzR/a3ilRBA0bNPNV/xa3ZT/MrO3If+FrOSJzYJ/XUJAoNvyknuiUPqhsITp6HmTCNtY8LigI9pIlGkvNsXqBWwWDy/MVLcW7/Yl1izHlJB75eHVq9GfaA0yzQT7e65lQLjGeLBRjcOLPpxGDZfSXEKV+N9IHNzhrQYSuK0YgBmzIfooMJLuIB8iCx90eMFF7GyV4kxMwSWvia41uQJFAqS93Mt71RrJs3CxWfM1VjvgDsTryr63+Q8SxZuRfPvISaDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPDPEDKSzP3Rnh4Dk5DDglDakZhsy1s0W3ieJXHgT7w=;
 b=eulcOFZ39IW9ZqcC5JDSlJzOc38+6jtu9FVsBuVnjnaEIcYFg9om/oe5sD0qUmM+QtWTSzLkIvjqhMiwcELsUuZaS4w+5sAMISoo4F/J2qbZsv1kJM7BGI3NQ3QkjJm/DSyeF1VgPLjTDG+4rjD0gp3ZfhBgY3kZfy7G2S8SHmu1HrnrGdSPNbXe6hw/0i2z1oVcJQaSR/P3cbAj334p8uWUBgt5dV477wjHK2xyfoP6AtFyR5ld2BJYUberXO/YrKxo/401Edct7FWT0rDWbIZ2o1738w36X1UwFKJd6Nsg0g+3vUc3nJhIPKPw2rI2Av9jIzlIMvcHZkz4uiwhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 06:51:40 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%7]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 06:51:40 +0000
From: "Lin, Ryan" <ryan.lin@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-drivers-review@eclists.intel.com"
	<linux-drivers-review@eclists.intel.com>, "Zhang, Lixu"
	<lixu.zhang@intel.com>, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina
	<jikos@kernel.org>
Subject: RE: [linux-drivers-review] [PATCH] HID: intel-ish-hid: fix
 NULL-ptr-deref in ishtp_bus_remove_all_clients
Thread-Topic: [linux-drivers-review] [PATCH] HID: intel-ish-hid: fix
 NULL-ptr-deref in ishtp_bus_remove_all_clients
Thread-Index: AQHckajxSfVCvDu/XkOCEUm7/KDce7Vrf30AgABX+rA=
Date: Sat, 31 Jan 2026 06:51:40 +0000
Message-ID: <PH0PR11MB7493505F52C66521250376A58E9CA@PH0PR11MB7493.namprd11.prod.outlook.com>
References: <20260130052544.4784-1-ryan.lin@intel.com>
 <381d44f303b9dd51e0d5063a805868eb601145f2.camel@linux.intel.com>
In-Reply-To: <381d44f303b9dd51e0d5063a805868eb601145f2.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SJ1PR11MB6276:EE_
x-ms-office365-filtering-correlation-id: d41c1cbe-f21c-4aef-8d4a-08de60953010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RkxOS1ViWVBLaThxekE0RzJzYTIxS05HVjRPaDVxQ1JpcGVmZmo3RUI0OHBW?=
 =?utf-8?B?OHhuMkJYN0tDUlhSRU9Gd3p3Nm5uV2M0S3dhVHVRbVFsQmdQQ21zYWZWbzdy?=
 =?utf-8?B?dnc2U0loT2NQVVU2Y1gwV3kza0drdGVlSTZITHRXT25xZE80bWMvck4ya1dh?=
 =?utf-8?B?L1hYWEhtNlJMM2xFVkFTK1lBSzF4NDRXS3lSaVNLUEtqM0g0WEoyeC9NbnI3?=
 =?utf-8?B?UWltT0dmVXZONisrZ0czYy81WWRyelB3WERBZHVOR1FIcGpFb1dSZi92cWhR?=
 =?utf-8?B?WFdhVkFsUDhIcDVQb1pwMG9mQ0IxNFQwdDYydzhoWkpLQVZ0aEplZFEvbW9G?=
 =?utf-8?B?bGJ6T2JpQlBnbjV4Wk8xcVoyOW42V0tscFRQbmdKc0h2NWhzMzcwQXMvM0lm?=
 =?utf-8?B?UENyckNqUStsamRaMHZZZE1UR0Vic1piVFRGMEozSWs3VDJORFFJd2ozbjJK?=
 =?utf-8?B?WFRtRDdpaWN1b043ZzFocHZIdDZlYURsSElFOXBTb0M5ZHFzZU0wMTRZbTVF?=
 =?utf-8?B?UzdSZnpvQ0hsNlRlQ29DbzAwb0JXenJwWjMxb3o0R0ZlTjcvY01pYUJNNFRH?=
 =?utf-8?B?ZTRWVjNPWUF4elNEbEtvL1ZKSS9ZSG9Db1VoMjZ4VXlXSXIyV1hLeUJsNTFz?=
 =?utf-8?B?dnRyZDBvY3BqQXZvRDQxTXlESEtqOU56N3RFQUk5OHppUURhbWRaRmF2VWNv?=
 =?utf-8?B?aXFzR3BNU3RMWXo4VG85bnNwckZLaXIwanFic3hldldUL05DK2xMSjQ2VUJQ?=
 =?utf-8?B?TzMvbXNGcmxkeFpETnUrR3g2M0dTZDFDUHRZMHd4OVVqNnQ2dzhxK05BNjhm?=
 =?utf-8?B?dUg5NWtuY2lqQngxMWdHR2Y3SHcwSG5CcHJqUXZPWDFObVNPSFhIZ1FNUVFK?=
 =?utf-8?B?RXlFd0E1R1k3WUIyVFphNFh5MWFHbGZ1di8zQkNETGRaRGJ3UDEvNzc2WDVh?=
 =?utf-8?B?aCtKZUdvK25uZ1Y1ckFDbW1vTEVRYVBoTStXL0lpL000QkNyK2hLeVZUWEZh?=
 =?utf-8?B?MVlOckxwSXlwbW5tQkNNSUlEOGdtK2VFeTZqNlo5NE1JTWVTQStVTlp1SGx1?=
 =?utf-8?B?OEkrcWFQOUcxWTBySThjcVFIc1F6QURlSGkzNjJQT3VKTUFWSmErakVCa2po?=
 =?utf-8?B?cG1aajZFTW1HOFhPSGpDMlpIdTZTNE8yb1NNZ0lsaTIwczNzQW1Hcy9pcUJZ?=
 =?utf-8?B?SjB5WW5oS0hTNDdvMnBxMFM3NkFXL2dVcjQ1ZVV0eVV3bU5mK05wamFQMDJB?=
 =?utf-8?B?M1M2MmJ6ZW1relFkeUVUYTlTQWFUZWt6b01DQXZrM2w3UTMzMmQ3S1BEQVEr?=
 =?utf-8?B?M1ZHU0p0cTFMU01zckpMcjRxTUpjU1Q1NzRkUUN1eUdJZ3B1TkZOQU9TdmNF?=
 =?utf-8?B?R1EvdnNwd2pYdTlDQ0N3QnY4V0xmaWhKb2liZ25PcldPYit0dVVqaFpkUGpy?=
 =?utf-8?B?bGhXWlcyWWczWmpjNkFKTnhjcmhhUDBiVVRvL3hGOHE5QVY4bVhtcllIRkFn?=
 =?utf-8?B?M3RCdWU2dUlFbEcvaDhpQ0Y4S25IWktMTGhPM05ENXFIWmhNSGNuTCt0SWcw?=
 =?utf-8?B?aVJyU0RxRG1yZE5wQXBXYlcrU2M3RUpLalIyNElOek9KUDlxNHNpMlZQaEc3?=
 =?utf-8?B?YktaNzgxb3RwdlNHamxwWmVQYkxuMjVqSDFRbjJYQm9NaW0wSWVvd1ptbXk3?=
 =?utf-8?B?MVFROUpJbnAwU05PK2Z3SVhraldOYUVpUk9kTk5PQVRCY256R3dMRllWaTBa?=
 =?utf-8?B?c2plSUVSNGZNMm82WFlkQjVUdWV3TlB1VmxIUTBSMXNMYzhQYUFaS2lsb28x?=
 =?utf-8?B?Z3h0a3l0OTQvVktqZ1ZIRURzYjRvSUVRN0xFVGU0K1BsUmtNVE4vVDJoL3pX?=
 =?utf-8?B?UStURWo0K1pUcGw2dFVQY2ZlOTNoU1BIRDFGRG5mVzdzUGRVbVk0d2RRUWIz?=
 =?utf-8?B?c2E0Vng2Ry9yb0d3VFhLTFdmTHo4UnZVQlB2dHpVbkFvR2RkVEplSHhuM05i?=
 =?utf-8?B?ZTgvR2tXbTJMOHBLdi92YXlVa2FEckltcWNWd0k5ZEZNUTFvaThLdUYyUW9Y?=
 =?utf-8?B?YnVxdXpFb2JtdXY2Y09mbUhpWllmUU9zNm5tdDFLdFUxZ3Jnc0lGMmVWRFl4?=
 =?utf-8?B?eUdnZ2pyL0xCYXZqU2V5YkMwZnQzY2R5c1F1ZS8xQ1AwZjR3OE9rOThXQXBi?=
 =?utf-8?Q?6BTpo6MDHgZNcICNJsYE6fQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3BUbnVNNk1WN0hYc1YreEhVOEt6b3g2eURyeFIvalArZzAraVpwK3NIT0dR?=
 =?utf-8?B?WmtJeXgydDk3TkdFZzFPT0dYODJpc2s3RDRCS2NaVUtZMCtTWUdZY2hQaUZv?=
 =?utf-8?B?Uk81UVB0cXlKWkttcDhGSEZYeXZ2Ulg4a2hKb2pMUW1YMllYVS9WN0tHK2Vu?=
 =?utf-8?B?ZmtIelkwQm5KZ0E1dnFlK1BKWk1OVnhZekR2TGFJM2R6V0lQREFmR1VmWXNy?=
 =?utf-8?B?eXF1TFQ4Rm9MVW1tbC9QYWN3SjBxQkxzbWhIcENUVllzelJwbmNFVVdCNkxR?=
 =?utf-8?B?ekVRWEVDYzNuUWpnSGZrMHNwc0pvN2NsVzh6d2hxNlVFaWw4M3ZzTitJKzM1?=
 =?utf-8?B?NHlCR25KSnU4OFNnZ1MzL0YraDh6QlRXVTU5Q3VZN0VqZ0ZkVFZxWXhQK3di?=
 =?utf-8?B?QjRNYW43bUlZQjNkNWFPZkxjeVdUdnhKSEFzV1VDZVBRZlRpWmtmQW1QKzAw?=
 =?utf-8?B?SUxoQ0ozY1owRWtGck1XWFJlVmMxdVpndEIxL0F1anVJeEwvRWpRSzhsVHIx?=
 =?utf-8?B?K0lOVFQ2R0tPRDhSRGMxUlpLRUhiRVVIVzZqWllUNFRVRkFZdzlnSFFoNzlX?=
 =?utf-8?B?RE9TcXYwakx6anJOeURWc3kzcXRjNU0zUzN3WW9GWDNxN2FDRUxHbGZtOUw1?=
 =?utf-8?B?b3k3UkpFV1ZjUXVNNUVNc052OFpERXozbmYvVzlKMGM5U2JQdDRLenkydEZB?=
 =?utf-8?B?dUQ1QWtRM0Z1cEdRTTIyaG03QkF2N3NIVGIvQVNLMTNPSCtlM1JoYVVOYTNh?=
 =?utf-8?B?Wnh2RGFqTFIremJXMUdQdDlHb3MyQTFZS3lKZzRNVEE3eGtJZDFWRmtOdGd0?=
 =?utf-8?B?amRuY2NFc0RmdlZKQkxZSklsL00rWkpRTHhoSFlJSGlEanZORnZIUzVtemo5?=
 =?utf-8?B?NWpwMDdQeGUwQUFMdEFJS294YXJrVVNhU0wvaVdTZnRYVkF0QTlqWFk0NkpI?=
 =?utf-8?B?NUxLcFYzdzgyV1VSbldZNThpV3pxazZCcFF1V1NHY1pOaGRkbU5YcGxkSzJi?=
 =?utf-8?B?QXRSeWp5T0F5MXprRGpnbXZvM3Y5TDZBbDVEc09HQkdQSDhEZVJGcHpOc3Bi?=
 =?utf-8?B?VmhNZDJOWERtWDZJeGtyT0lMUVpIREs1SHV5TGI4V2ZWOWRYUklwcUJMUHZW?=
 =?utf-8?B?WktyQUFVZ2RKNTBIc1MvazJKd3k0d1pZajY3Y3VBb2cyRzdRNzI4dkx4RnhV?=
 =?utf-8?B?d2FocUZTa0hucWVlb2VwWjRFbXBWTmI1MXZmV2pYcFgzWXBNR1lqZjNXeVFM?=
 =?utf-8?B?dUF4K2k1S05rSEkyS0UyYVR2UWd1VXd4cXV6NG9HRUtxT1RBQkRzd1dxZUI2?=
 =?utf-8?B?N0tZK2c3K0luOTkyM2ZkM1Npc2NHNUx6TkhwWkxjVDhuN1duZk5IRFIzcjJw?=
 =?utf-8?B?aks3U3c4cE1IeXNjNTJWckZqaHAzbXVaVEpWdktwM3Z1Q3lYdSsvWVpxWXZz?=
 =?utf-8?B?YUlyQkYzVWRQckE1RTBsQy96bXBHWHVhRnRoSzNFL1F2cU1Ua1dSOS9QR3RT?=
 =?utf-8?B?QVdyN0QwUjl3WWlRS2V2b3ZNNEM4TUZDRXJqT3RwVVBRVGZWN2NVSkFLWmQ2?=
 =?utf-8?B?U3pJTkJOTE9nc09ZN1VvSkprWENkY25JdjZJTFk3Q0VnckJOOEp2TDgxMDZN?=
 =?utf-8?B?NkRTeWl5TjJ4bmtNa0NkVFV0VDc5OWQrdXdmOENZVzUzc1Z5bjF5RUdGU0dY?=
 =?utf-8?B?TVAxdlFHd3haejh3N1dFMmN4QnVuVHFlSW42RWl1dEpVR0dSaEsySEZtMjFs?=
 =?utf-8?B?dlR5SmhLQTMxNFhYeVpkenRyRVRlSzVnQzlCSlplOC80ZXAvRnQwRWJ3L2Vl?=
 =?utf-8?B?WUlFTFlLRUxqb21QU3F6N1B4Wk1IaVdXNjJmRkRzT3VMOVNrdklCM1BraTZM?=
 =?utf-8?B?enNjLzZneXkvT2IrbDN0Qzh4RlY4NVp5OEdXc01pWS9pc2pwZUJHRFRVRG1Q?=
 =?utf-8?B?aEliaU4rVFZEZGNGS01hd3B6dnNGYXdBdk1zNVRTdytBd2IySk44SS9nbnVy?=
 =?utf-8?B?a2l0ZTNwQk1BQnczZS9Zb1h6YzVrRSs0VmJhcXQ3NVliaE96TkxmcHNVd2tx?=
 =?utf-8?B?T1hIUlRydGNleGxRdUl6czVRWHloQ2h0cXAvRXlyQkNnZC9MbW85cWtYYzBr?=
 =?utf-8?B?YXFVQ0VLK0hBYnZlRWRzUUJoZENYV2lXL2hBUGpZdUdITGRNRFJjekVJL3BG?=
 =?utf-8?B?eGluY0hXZGU1bGpGaGdaYUV4TGR2VEYwVjhXR0NPVllEbGw2VjhXKy81VkFL?=
 =?utf-8?B?cHo2QXA1ak15akVSajAvTDRmRmNXL2JXUUV4WnJSWTJPVXBCQ0Y5Y2ltSFdH?=
 =?utf-8?Q?SsCtL8ljCFlS39hQCO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c1cbe-f21c-4aef-8d4a-08de60953010
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2026 06:51:40.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhfhzntcjGU929I46MnCxJfK9R3hhap+lX8vg+mRALvZMVUWe07DqbjenETY7+sKrondJGbaejXkO5hVaZ4UhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc3Jpbml2YXMgcGFuZHJ1
dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVy
ZGF5LCBKYW51YXJ5IDMxLCAyMDI2IDk6MzIgQU0NCj4gVG86IExpbiwgUnlhbiA8cnlhbi5saW5A
aW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGlucHV0
QHZnZXIua2VybmVsLm9yZzsgbGludXgtZHJpdmVycy1yZXZpZXdAZWNsaXN0cy5pbnRlbC5jb207
IFpoYW5nLCBMaXh1DQo+IDxsaXh1LnpoYW5nQGludGVsLmNvbT47IEJlbmphbWluIFRpc3NvaXJl
cyA8YmVudGlzc0BrZXJuZWwub3JnPjsgSmlyaSBLb3NpbmENCj4gPGppa29zQGtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbbGludXgtZHJpdmVycy1yZXZpZXddIFtQQVRDSF0gSElEOiBpbnRl
bC1pc2gtaGlkOiBmaXggTlVMTC1wdHItZGVyZWYNCj4gaW4gaXNodHBfYnVzX3JlbW92ZV9hbGxf
Y2xpZW50cw0KPiANCj4gT24gRnJpLCAyMDI2LTAxLTMwIGF0IDEzOjI1ICswODAwLCBSeWFuIExp
biB3cm90ZToNCj4gPiBEdXJpbmcgYSB3YXJtIHJlc2V0IGZsb3csIHRoZSBjbC0+ZGV2aWNlIHBv
aW50ZXIgbWF5IGJlIE5VTEwgaWYgdGhlDQo+ID4gcmVzZXQgb2NjdXJzIHdoaWxlIGNsaWVudHMg
YXJlIHN0aWxsIGJlaW5nIGVudW1lcmF0ZWQuIEFjY2Vzc2luZw0KPiA+IGNsLT5kZXZpY2UtPnJl
ZmVyZW5jZV9jb3VudCB3aXRob3V0IGEgTlVMTCBjaGVjayBsZWFkcyB0byBhIGtlcm5lbA0KPiA+
IHBhbmljLg0KPiA+DQo+ID4gVGhpcyBpc3N1ZSB3YXMgaWRlbnRpZmllZCBkdXJpbmcgbXVsdGkt
dW5pdCB3YXJtIHJlYm9vdCBzdHJlc3MNCj4gPiBjbHljbGVzLg0KPiA+IEFkZCBhIGRlZmVuc2l2
ZSBOVUxMIGNoZWNrIGZvciBjbC0+ZGV2aWNlIHRvIGVuc3VyZSBzdGFiaWxpdHkgdW5kZXINCj4g
PiBzdWNoIGludGVuc2l2ZSB0ZXN0aW5nIGNvbmRpdGlvbnMuDQo+ID4NCj4gPiBLQVNBTjogbnVs
bC1wdHItZGVyZWYgaW4gcmFuZ2UgWzAwMDAwMDAwMDAwMDAwMDAtMDAwMDAwMDAwMDAwMDAwN10N
Cj4gPiBXb3JrcXVldWU6IGlzaF9md191cGRhdGVfd3EgZndfcmVzZXRfd29ya19mbg0KPiA+DQo+
ID4gQ2FsbCBUcmFjZToNCj4gPiDCoGlzaHRwX2J1c19yZW1vdmVfYWxsX2NsaWVudHMrMHhiZS8w
eDEzMCBbaW50ZWxfaXNodHBdDQo+ID4gwqBpc2h0cF9yZXNldF9oYW5kbGVyKzB4ODUvMHgxYTAg
W2ludGVsX2lzaHRwXQ0KPiA+IMKgZndfcmVzZXRfd29ya19mbisweDhhLzB4YzAgW2ludGVsX2lz
aF9pcGNdDQo+ID4NCj4gPiBGaXhlczogMzcwM2Y1M2I5OWU0YSAoIkhJRDogaW50ZWxfaXNoLWhp
ZDogSVNIIFRyYW5zcG9ydCBsYXllciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBMaW4gPHJ5
YW4ubGluQGludGVsLmNvbT4NCj4gDQo+IFlvdSBuZWVkIHRvIHVzZSBnZXRfbWFpbnRhaW5lci5w
bCB0byBnZXQgYWxsIFRPIGFuZCBDQyBsaXN0Lg0KPiANCj4gWW91IG1pc3NlZA0KPiBKaXJpIEtv
c2luYSA8amlrb3NAa2VybmVsLm9yZz4NCj4gQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtl
cm5lbC5vcmc+DQoNClRoYW5rcywgU3Jpbml2YXMuIEkndmUgbG9vcGVkIEppcmkgYW5kIEJlbmph
bWluIGluIHRoZSB2MiB0aHJlYWQuIEFwcHJlY2lhdGUgdGhlIGhlYWRzLXVwLg0KDQpSZWdhcmRz
LA0KUnlhbg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlk
L2lzaHRwL2J1cy5jIHwgMiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaW50ZWwt
aXNoLWhpZC9pc2h0cC9idXMuYw0KPiA+IGIvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pc2h0
cC9idXMuYw0KPiA+IGluZGV4IGMzOTE1ZjNhMDYwZS4uYjg5MGZiZjk3YTc1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXNodHAvYnVzLmMNCj4gPiArKysgYi9k
cml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRwL2J1cy5jDQo+ID4gQEAgLTczMCw3ICs3MzAs
NyBAQCB2b2lkIGlzaHRwX2J1c19yZW1vdmVfYWxsX2NsaWVudHMoc3RydWN0DQo+ID4gaXNodHBf
ZGV2aWNlICppc2h0cF9kZXYsDQo+ID4gwqAJc3Bpbl9sb2NrX2lycXNhdmUoJmlzaHRwX2Rldi0+
Y2xfbGlzdF9sb2NrLCBmbGFncyk7DQo+ID4gwqAJbGlzdF9mb3JfZWFjaF9lbnRyeShjbCwgJmlz
aHRwX2Rldi0+Y2xfbGlzdCwgbGluaykgew0KPiA+IMKgCQljbC0+c3RhdGUgPSBJU0hUUF9DTF9E
SVNDT05ORUNURUQ7DQo+ID4gLQkJaWYgKHdhcm1fcmVzZXQgJiYgY2wtPmRldmljZS0+cmVmZXJl
bmNlX2NvdW50KQ0KPiA+ICsJCWlmICh3YXJtX3Jlc2V0ICYmIGNsLT5kZXZpY2UgJiYgY2wtPmRl
dmljZS0NCj4gPiA+cmVmZXJlbmNlX2NvdW50KQ0KPiA+IMKgCQkJY29udGludWU7DQo+ID4NCj4g
PiDCoAkJLyoNCg==
