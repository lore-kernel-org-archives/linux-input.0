Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0427453;
	Tue,  3 Feb 2026 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078898; cv=fail; b=MJCaNkQBqMmpEGGnM9d1/cPba3aXh52o9gGwgrOB7DBu+UA/rWo2NnQTRtRItNm/hnYPUrKryZ4T5W7hcGM12t3VuKVdVW3wQkcdxBrB0mhXeP8DeT39b77yV7II8cBWo7JijuGJLUcrDR2ezyzbJYksr4NxTpKBbzlW9sVIbYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078898; c=relaxed/simple;
	bh=CL/vdiXIhMUIREeDayDFq0LfXZMGmyDKQxxGa3dIwXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGbfXOnutTLK3p+oMb2jZwvAL6anQqbTSuOzuQq+9Li1fcFJcMJ8dp+Jq6bmvhfBXF5+Td0ApOZIASoZpw0Sbw6bpLwRTwJta1rxEOo6D5xdswgSCKFiR2SUw+k4uH+kZm88T0TGK2nJ7k8UCu54e06KvVP3r5uAkjYqQJM/yKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+cWOo8k; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+cWOo8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770078897; x=1801614897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CL/vdiXIhMUIREeDayDFq0LfXZMGmyDKQxxGa3dIwXw=;
  b=K+cWOo8kVPmu4h1yAUYZhreRzPiIcwbFU+vp2fesZEChMnz7QcpMpWI5
   uZr+/oEv5HbAn5+r57YcMmUzc3SVoJZye2DPSe4sz/n1YTzGb05oev9aD
   89eVB6GenNFX55Rp3StzfwHuNrYt6WFXRfdgFTShVDJtBTO77fgvSnEBv
   rr3NvhMr+ffeatYlxkm/VKPkHQJLRxdtLhFd3ivW6UpPZKe0mVuTtDjY4
   bGsJQ8lMhE96tnODpnw4AUyCXkSZyZOu+2YTmWuGk+TcoRLHQQh07HLg5
   NqT7yL+m/va7iRNRUj14i6IJW4mYzSHqXtoa47E6+0OCCHLRr1LDtzv6W
   w==;
X-CSE-ConnectionGUID: CvVqabhjSAGvnXb2XAXwtg==
X-CSE-MsgGUID: DYHjHShvRGmgNpnDdQ/TZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="81983020"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="81983020"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:34:57 -0800
X-CSE-ConnectionGUID: yWUNdMJcSUWECgUBICvSpA==
X-CSE-MsgGUID: 0+c+/dXhRB62MmocjSaOMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="240729632"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:34:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:34:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 16:34:56 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:34:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYr2EjqhNv5DnMYDE8V7DBQrrHzxFwzBszn/F3ZH2vKOfjOz8GE0NvwzMvUTLpxzJZFeyPCfC1UOVTe8kKTA2dinxoex2mmK3LtsCqi0Gd+horcxczbTXlAHXAfhJQlYA7IKeYtg0+BQsHh+R4anQAA1bQCUEJh3oimnDjbEQmmB4E8qJzF301iE1Rjczcf4sTUeUEGlTrKy0N0j7dpGd09b2dG81sY8Lj4du22e+BEU5Fw3Zde6BEheA4nZTeMpD8Q13iMTxFh3V0dk2h+HXiqc+p+OOZ88SEmJwVrlX/lNuwzdAI7FVgZoCdy2SArMxJfTC37yHAYUFEkYqVwR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL/vdiXIhMUIREeDayDFq0LfXZMGmyDKQxxGa3dIwXw=;
 b=bYBj70LO71C/MyiwGzUbpRbVFvQWr4NSKIb2D9IAr91Fxt2F9vY5YeypLpVmLmEvxqWjxANa+9/B4FKv7/1c0+zs5+1PefdNpkI0BV8wt5sr+FfXzo7GTUArqP5x8Mbixf3HFet1VJPsHNIiau4Q5FiuiClDKCSkJegV6Hf5r4E93qBmYeubhfkBDPfTQu/OjIs03aXYl8/p1DfJj8M/AGvHEcaKCpZBWj9aiwAIVWMbzB/BC3sXR9eNqY2NjRU3xm1/vA7Vi0ZuwgnzgHbOAiXBsIkqIdsUCtHCREmUnG7DwW+rit2O0igLKsytqLjG82pQ2DkToR1i1RUpsCoyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:34:46 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 00:34:46 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>
CC: "bentiss@kernel.org" <bentiss@kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>
Subject: RE: [PATCH] HID: Intel-thc-hid: Intel-thc: Fix wrong register fields
 updating
Thread-Topic: [PATCH] HID: Intel-thc-hid: Intel-thc: Fix wrong register fields
 updating
Thread-Index: AQHck/AdfgrhSayHxESIAG9lvTwmFbVvawEAgAC23CA=
Date: Tue, 3 Feb 2026 00:34:46 +0000
Message-ID: <IA1PR11MB6098927A6E0C1DD16C720E92F49BA@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260202030144.967964-1-even.xu@intel.com>
 <2rs0n4rs-8821-69qo-7485-50nr37on2ns4@xreary.bet>
In-Reply-To: <2rs0n4rs-8821-69qo-7485-50nr37on2ns4@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|SJ0PR11MB6718:EE_
x-ms-office365-filtering-correlation-id: 3d92cf4e-6c8d-48f8-ebf9-08de62bc086c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qfwDlNZLiyfNbqQbDIc2SB1RICN3BCRWUM2UPkxf/ieJ70y9pqfsnxOVEcwq?=
 =?us-ascii?Q?SOMrcXMA6q7tXNhB86QM+dbukmDmOVdFX+MjzkfdYOcHK6W9AopsV2IdWrRu?=
 =?us-ascii?Q?0DgKi9ok8kfnEjpi6y5wooSsfKZpzykEBfnUxWwLsg077wcQgh+lRiJurxXq?=
 =?us-ascii?Q?Z0YpI7M/j2VkqfuQDduTDQsiNvzueUXPzAPiPZYO2idJX/OaSqBkwcfh3MBI?=
 =?us-ascii?Q?HXm2WLEhB9j8Ge25pn7bOk9BamOWpTc1TfBNgoJ+uTPvJDmyMf2+gq5CTwtE?=
 =?us-ascii?Q?DbJ1I5SSKNa9tXCeqdwbLGSXFlYtdeLJgmxJYxcR9G0yw9oiamizBmWXTfvi?=
 =?us-ascii?Q?HzeTkxZhe9SFJJVUZ2EiNKolPMZz0O3ryjNwCqMU8vK/u55rrVpV58FjH0Fn?=
 =?us-ascii?Q?NyMbmqrU1EoZTYtgM4DJiEn3sEHrvwiSqmuQw78XX3TkshU7ZMi34jR44pH+?=
 =?us-ascii?Q?ugv2X6j1ELp0aaFUdQrHsPgxRDz7QVqXL7uk4AQUOvwLfjXZYfbfM8StXMha?=
 =?us-ascii?Q?6iS6ovJdv8fmyYYJU7F5Tw2d/hrSLN4kr4fvkznEK1lQboHkxkUdjPB9Jy0t?=
 =?us-ascii?Q?TWex33+uzof4+zbqZHOTKykxc8qLzlpmVUB5g0xAqQXPc5XdJCVTRxT3uMiE?=
 =?us-ascii?Q?QYnwYC7ZQUaRa9PecPo40q0XuB5vrw5ekLvQzSKwoWmCgo5bEJo3h7qjt3CM?=
 =?us-ascii?Q?Mkx6JfQQXD8v8B4aOxXe/Qv6tfHFrGVqMpA+4TeUddIji2tsgir/dVkFdn8B?=
 =?us-ascii?Q?1pg4jJuOuz0qHZXMHrya4S7tIHGaFddKeAia/Jh16MZuEa++1f8URcj/tW8+?=
 =?us-ascii?Q?ln5PKVv+sAvyDm2IEFmEY/IRBcUIgMrEfx5uAHk1hwgzw+wvFtnyx42uLWhf?=
 =?us-ascii?Q?7RxEE9gYQrHQHEUbjmg3Fu9kE/3gK9JU5C+ow9UQ9lL2+zxgn6fj+2wghnJo?=
 =?us-ascii?Q?KzQRzIEN+pERykIi5jbqOBywgXfcwastLucoThiulySNDBM0jLczZHpf8o7F?=
 =?us-ascii?Q?ZYwUxfU1zrcRH+7O3bZXdjAPCBkhx4+crA7RZUQe2mWzzbB/DB9G4qioD48P?=
 =?us-ascii?Q?f0h7w+7vDe6iaw8InarvbQvLWi895Rt7B/fEcreZLYSoWUdicV9aMXRa1dTc?=
 =?us-ascii?Q?4dfiB2YWN6Grk8hIilihR7IFuTGLqZua0FviFK22qad9eDzT3gWpzy5FhSMt?=
 =?us-ascii?Q?L1aD6Uw/4ZGPLgWXEwg6n4KFtcg/W2tYqnn8ulDiOoa8opfFvmBIqhcX6KK4?=
 =?us-ascii?Q?F7MHHtqrVgyhdYBqQgF2/+y7StcODV2dkXYk7HrZdd6zqaH/XyRYmew0Eotr?=
 =?us-ascii?Q?In0N5A16HBowtCgZbpFX1zzZSnwWUiaAydg+ydbLfGyqnxSqp7ul/WvvClOU?=
 =?us-ascii?Q?58tYvPoC/PPPkMHZVXZ8bDvzOU1YD8kjcL9ao9Ayj4RKr6ZYy+cANOBqupqc?=
 =?us-ascii?Q?M53c3Y9jmVGg6pjf/QiWvfM9fuJzjFHKStHj58ZdHHM7H0MhpzIVkK8/sLGK?=
 =?us-ascii?Q?a5ZTl5Pf1FCA0pZBs4nshzVxthXzosCPeooNRQ126cyBCMCz3B3E5dcQvFsK?=
 =?us-ascii?Q?6UwkzE4Q3uD1iX9RBPvqUjcH3JAj2y+jA2TxeWSVnN+XBATY+yeu2JKA+QrJ?=
 =?us-ascii?Q?e5/iADkBCQXOE4Uv7EN6olw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BEO7cQ0FqoxfNNqv8KrX4Ukg1J0i2UYa6Rmp/XPXX4Pvztq4yqNysk0IOa3A?=
 =?us-ascii?Q?2GMBj8ubQOgpg4YtfKvpskRJL60GgvVCR4dbc6HsVl17ueaHNSS5N8AIArSG?=
 =?us-ascii?Q?ntr0MPQmv1TyYqc07SDKWKk9T+spPNTfJclBHUfKuCm1jIu/fQYrV2DIMJOs?=
 =?us-ascii?Q?zW0pA5JYqS7T9gSayrwqEB0gI7LQxiQggx7mexStJC/+y9/waa1JUNhGqlXj?=
 =?us-ascii?Q?zovYiG+1FA5uZquEmDQ3pV2hYRgVr31sHbr+hDkalNHQz9qJZFoPHtpCIurg?=
 =?us-ascii?Q?U42tzfI1n0b4BdiS1uozxIashb0sbbrmS66T5RTuHUnawLk+aUg5aJe2XziU?=
 =?us-ascii?Q?c7eW1I+NWgITo3EryIcCaJ2s3TruLDcr2P7stVXhLqXe995JodSDR6XkFDSQ?=
 =?us-ascii?Q?+vrLJwkp0T+xtDUISMGZGKzMspeGXgoY4VSyteluzOA1ntVzgwoGl5NsUBB3?=
 =?us-ascii?Q?u1ccUU5JEYSBIoxOEQiDLWNSCacS4vrqRSMjUVzl+xSy0Rhw6HvJvS1+AFe9?=
 =?us-ascii?Q?7kSnrh3Uot0X5rGKh1NXEeRhiiGZne1Wh3nJkfodb8kzXkDLbqXoGLCKw9fN?=
 =?us-ascii?Q?K+t/SHyyI87DSenG+H0SzBJqkAGlaxSwGk5sc0lJyJKb+VQSpnYLQuy9dNvW?=
 =?us-ascii?Q?qSK2zNki5P2Tvo5DnYPcfc8HehH4L5sq8M5MeFtTZA+7qu84ZZnt7h9njYcm?=
 =?us-ascii?Q?IFH0Lay8j51mj4aszugcPFjyY/Ubc5qsOacPCCw7gIGVBt75OK9ek3mVr+OU?=
 =?us-ascii?Q?vlD1X1/mP7YK5dI0Pxe7bbJW1eNIXGJ4Zp0HfBOhGf/iEW0aQpkuwCh6FKfG?=
 =?us-ascii?Q?/HdXkCfe35r4Zn8Uz0E/WODt7TCMZqV1wokLNdYgd6itcSzuS99hBiNPKVLr?=
 =?us-ascii?Q?kGMLJ2BVBpN6qmPqFX1hN24lRJZqGAO+PYLDHQWCQLsfXRKIsRFOiGtVRHQz?=
 =?us-ascii?Q?qleK/6G41Wq40/n/008R/ldZr7o5ofh68MM5bWYZApBTAiWWIJ8CNQGHj2fd?=
 =?us-ascii?Q?jImFOa2bLCdPp9gFupgvBBFdj5huLRjM8lDhIRm1kL78anoSAEMYkG3CqQ0s?=
 =?us-ascii?Q?lC4KwbyiqPgSacziVP9YzemJtuA6AZhloNkycbehb3ZP59wuDY1WCOJB4Wiu?=
 =?us-ascii?Q?mA7CFaSHsVafcx8MNtU40pC+/FHqd4Q4V6dW5qaidwIgYWmY9BZ3l9r9k9Tf?=
 =?us-ascii?Q?cX3FTOzWVmCOJ8rFzyxRH1z6x1ge+WRaycmILgWcDfVDWkcDMqZhB2QTXAzj?=
 =?us-ascii?Q?2gwtlTrXwpbzb8oQP81ogGpFuQhizWkojkidOkOKCmcRo0qrj+QMIdGVf+9C?=
 =?us-ascii?Q?6x8E6gAoP8HLUkUt/+7Ae95Oigif7F6KTm6ew4ljpyhYkonfgYOl7Mif9DcC?=
 =?us-ascii?Q?Ubm+eY27Sw+Wy57tvyC/n/J/DevD8UAd5oC1u07CfWpEGdlDVDZFygyagN0n?=
 =?us-ascii?Q?TPD0v57LucLBE0qb3JdzrKIXzxUSjfJp+apuBursWKmu5TFnGfMUleR/wyWm?=
 =?us-ascii?Q?xrzu+XTzp+wHogRnnpqHb1zUfxPQe7wdXho+A14H2+g+a4wcFGFMhh/tO+si?=
 =?us-ascii?Q?sLCFgFh6KwsSdHlxcA+9l34mvkEqs/rh7pqgGR00+rXiSKZC8+FYhZLKyff4?=
 =?us-ascii?Q?oVbsPgchOdbrHjP7Qb5pGT4CNG+PypHd+ZDmYauGVH996Wt2vcNMeqfE1zeU?=
 =?us-ascii?Q?JTU7IG2D+IQJ/ieIjtHAyzIP9HckFRbcaNEhRxKYchDwLSmg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d92cf4e-6c8d-48f8-ebf9-08de62bc086c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 00:34:46.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9erPGZWRo3BqTUvzFJdEL8HTaNYYWYBZS1jOqf4o8qPvI1UqLGQu1XWMA9CgM51xjg5PHbIJZFdqLjkrz3avYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
X-OriginatorOrg: intel.com

Thanks Jiri!

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Monday, February 2, 2026 9:40 PM
> To: Xu, Even <even.xu@intel.com>
> Cc: bentiss@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Rui1
> <rui1.zhang@intel.com>
> Subject: Re: [PATCH] HID: Intel-thc-hid: Intel-thc: Fix wrong register fi=
elds
> updating
>=20
> On Mon, 2 Feb 2026, Even Xu wrote:
>=20
> > Clear the target bit fields in register before setting new values.
> > This ensures proper field updates by removing any existing bits that
> > might interfere with the new configuration.
> >
> > Fixes: 22da60f0304b ("HID: Intel-thc-hid: Intel-thc: Introduce
> > interrupt delay control")
> > Fixes: 45e92a093099 ("HID: Intel-thc-hid: Intel-thc: Introduce max
> > input size control")
> > Signed-off-by: Even Xu <even.xu@intel.com>
> > Tested-by: Rui Zhang <rui1.zhang@intel.com>
>=20
> Applied, thanks.
>=20
> --
> Jiri Kosina
> SUSE Labs

