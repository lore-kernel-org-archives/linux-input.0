Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153E39DBE8;
	Wed,  3 Jun 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471229; cv=fail; b=s5q5r+XpNEmOFiQ50xYNdhJNco2HbQSKYaStcdoWVZElLjLesPnR+mGT0FuAJX/4UzkdcU03K9sJZd5PnnVglWcmsDhAg3TKV0b8puVxGMENEIektS/zmDgpKrepj5oUkvMBjxZOn7zLxIXH6+Vs6qHFd+8H/wekC3KLMoXkkQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471229; c=relaxed/simple;
	bh=XoxE2Bkxj3yNsrknjEMtFpV4ApAx+XFs564NPw4wStE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPyjJQjoQQ9AtkiZj+ZgCWPKvjDAZQJsVNIhERQDroQuIOM/7iSk4bPHPQmUDzZova3omsBifIqJp0sjCGek0dJQShj0ttNVgGh60s78Zv0vLkYP507vzrDCKM0JEhf4hH7bsKv5r6D9gUUnaKVzvAQrm8MOb5cvGTRbbopvBxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhyeE8KY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhyeE8KY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471228; x=1812007228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XoxE2Bkxj3yNsrknjEMtFpV4ApAx+XFs564NPw4wStE=;
  b=GhyeE8KYnGdAQ+t0YXg9FclHVkR+tz9q3L26j1F6C9dsPwbALJTT+hUA
   79utBpFbrLxV124ZVOP/A1/MmKCFEoVJMOOPFhz1pk5tSZYjPAwb0PpsY
   ZvNYQx9JOc/PxDGTkqcwiPt8cg+T1Pu71qTg93tco1vV4YAgvKf4n5ONn
   9Zxe5reHNm3wKa3hSL1nGLLi6mzdCwq6UoSbKPwLHJhWZm2X4uK/1PYX/
   /7/0TZWvWGTy2t2AY0n/9iPkOkKNRHhjIcJMNv/QvMR9Uxv7n3KLdZ0FH
   fCQ99hmJFd6EgHpTVjlaTgk79dlgvfolUKOsMqaOlmx5NT+e5GykZ6nLL
   Q==;
X-CSE-ConnectionGUID: GvUSDLfXSamBGkUJiCeyrw==
X-CSE-MsgGUID: QX4q5aT0QIKlF7pcw1TO9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81009635"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81009635"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:20:26 -0700
X-CSE-ConnectionGUID: F+6C9s4bTf+qomH+PDriGg==
X-CSE-MsgGUID: j+mcli32QqW7UNOYcb2+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243090187"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:20:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:20:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:20:25 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5JHCR8F5XoU/YKMIGUVjEd0NHQtTkw9Gi68wDUEi3EBaRNI0GH5xec+Qa0X6mbzD2oiF5qCV2g9mh0sEFvlSmhlSbcvygNJX5C8s5ITH1CoCN+/OMzppb19uCdxgCfpGeAyfpfkuNT+9T9n8nBuGmTB85MhpKpFogOtwxIDK0dR4lyJ6k7tqrzO6uLJvKyPvYlxTqX3XHA1snwnuJaGKMfS++BvdreOqPDKxhmcyEP6x4RYJQCvLIIpR+nVT9SYH1HPX1RX4sOYCqImI34k92bSPDZKlcrk+0ipBZDcbzmAYZADbMPg0n2Qge7FQf075vyHd9rydAKuddv913vJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HohXIMm/8X9K/5EbOqmMhQWkhfzqlmQVmjnveaGvnAM=;
 b=Ej0mq3VwgPBwho0abdrATYvmT45c6mDZCVlgVQoi1zlMRRhX1kphbFn6lDbueUiqIqb7VVLCibgj7LuFZ0Bpddrxu+5/R0AaDP6kmsSRlIK0VE00fMQbqdRs5sQAGR4ymhc2ng5034X8LiD8deUhbkv0L8BO+JmdgqFVx4dJRxZ7ql7/+Sh4MlzKuaZjp2jlBi5GxJ7iDfTKdMhdr2CyOl6HHnADqmTJvIw55Oda0FRtsJwiZ1DF0OQqD2JjGb0nfVMa4Go75lmerw1j8aeXIzlbdLBNi20tWp4WtMZYQF61avSUbcGWK03bPV9/SJ3G1XaemXp73Ei7HRh2vtD9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 07:20:20 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:20:20 +0000
From: "Xu, Even" <even.xu@intel.com>
To: d3z <d3z.the.dev@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	"jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"abhishektamboli9@gmail.com" <abhishektamboli9@gmail.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Thread-Index: AQHc77mrUbJCsvCWBk+2B+n2qvQl/bYpBmKggAAG/eCAAS7+AIAAuevggABu74CAAQWkIA==
Date: Wed, 3 Jun 2026 07:20:20 +0000
Message-ID: <IA1PR11MB60989CC8623B35747E0EFF7EF4132@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260601213047.115271-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260602151317.27768-1-d3z.the.dev@gmail.com>
In-Reply-To: <20260602151317.27768-1-d3z.the.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DS0PR11MB7681:EE_
x-ms-office365-filtering-correlation-id: 372844cc-1f14-4779-fb51-08dec1409217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: IBtHhNcLtzqIzpCSeiNVbiuLL4XWMWVd7XMqy6g8FRqVrMKXJqjGbUx/tc91++TA14YAMvtr7ZFqpfafcZ53rIdR/hvJdyKxj4ZGRyuzejK4JdI03xoGX9uRgDRPeEzyEq1oMD1q9ZAzzthQp/fklrmVFY6MjgPVKE/D3qL2hDiaXc9kX5v9VD1c4eoJhp/vgPJHWEHJVbPQ/600ZBcSG8WPoxVr83BxToVqcpmXZVjc++8xVwAf7JkHr8S0AgD5Rr26hbmtJK7gRQ9X9tUkie50Aj9zfvW3jm/0N/Uw3AfkMuQnNwob55Zjv5XkPEQGVfRm82RYWYxSes704v3ofrWqDQzUtxRSWEvmjqrodFwx4LqCahc8m+m+TGiqSVhkArNKeUVm6Kk+8dJvxRsF8q2+xTnkh+1un2+l1U5GYJudeW2ABig/DM79eDajS30NXHucymjGKrb+qfPuqfuZbpy1qKyPDHb+OrlV9TrjQ+LJg1ANqHAfRRZzxaVIgqDZ8HzQzUJ9yAa9fbU93ssGHLPEXFtxYwZiztMNuZm2JMOFAVLV5jxJs7mf3v63NM/sdz5mkcmcdSygX0LZXYRFkC+9oqJ9B/x1eS8RWh8RvqWAdTjGO2YVxV2WxvU+R+l70jzqaXtBZHG3ckwSaVWwFRGv3SMuHMRjLPQWJV2ycbqEwteUQI3N4Ra5YE72Lx5zQJt8OYEcwLxZTq5YlqC+n03woymP30qZ2b0AIqMyye1RIJa4CSPzKKnm81aCJ181
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zma2uyOQMAXmfRgIEfFK8K58RiPKzJsub7QBT7SrxvIDB9ujgcDUFSJqTD8/?=
 =?us-ascii?Q?evGbtNvAhoQEXtOxY2RaLn8ZOttAlXnZEHYV5g+A5u7Lyc/Ept89rFKr+QqZ?=
 =?us-ascii?Q?e0GZnLLkVGLBR7IxeeCjycUJWKg69ZhGOjPfaexMGQ8VydwAccjSRuxivLF4?=
 =?us-ascii?Q?0qX47aoth0Nb3EHFqcWgEG71UNSqYEEDiehQdKT1jRs803dK2f/xHRNISF99?=
 =?us-ascii?Q?4raV0zk5JKpQ2VTY0P8b5PFClviknHv2wJwFo6yWZjvoXAT090OoL7FOur31?=
 =?us-ascii?Q?cuTyM2j8uO0UNHceWzxmfDccGyC6TP1mvpB827zxEhlKgB1xcbMzEYf63dB2?=
 =?us-ascii?Q?8QxvytIIhGaV6ULYCwIPsDD8AJ0A1kvpJR617giZQQ3WZMeARigeLneJ7GH1?=
 =?us-ascii?Q?orI9LFIfYLQ8S/M5IFsYpZsZTXWB7LM1OqJQ+gicK/OBTITqNOaoLqSI/pOm?=
 =?us-ascii?Q?b4xja6vqtj1eU/RaJ2quFkEvkbIwfXJzusRrT+WQzP5FkYCW0e8fQodKLM7O?=
 =?us-ascii?Q?fIMfEXUyWaFHcd4F3gz8ZwlmHDjfgN3EptgLylivVQ5ukMbcqM1czFk8FIqh?=
 =?us-ascii?Q?l99kIeuL9D9wm9ASac5U5Jp2mAAKPKUqSLQgKNRNGcXxWHKtO65DHcnKMAiL?=
 =?us-ascii?Q?Pl266YQxTzVwrRmbzE7MRbFmfp6YpPvoBSeG0w3vS3zwEKVaQZcFVxHwIBK0?=
 =?us-ascii?Q?zQA49ItqqCfQ/vMgQSfyOMUK6U9ualX25DQwvhTVQj0A4o3mHEuUi+Y/8IFt?=
 =?us-ascii?Q?9gzM2fdE7ud99uy9eEFav8T69HayoIhQBONS/W6sPLnZAEH5rIdD838rc63q?=
 =?us-ascii?Q?83BxNhPzj5ea/TPCYJY1JVYnmwpHZr35hzwDO54JxV3n+U/HMJL+kDfj4Iek?=
 =?us-ascii?Q?uFl93JiiUABd1B3MUo6BWNXbzMO6GcZhjlnRBqSp9qQxvjHwMtTKi6NM1TYC?=
 =?us-ascii?Q?y9JcxQPGJcShXk5BX4Caf2xyBOxq3n2+yXsZV5KPG3pP3aHWP67iQSNmUiYl?=
 =?us-ascii?Q?C1cAHa9h17SQO42cbBDd8HsKgapyu746NJo6w/TQHeyrdw1F6ex6hj+Uawmh?=
 =?us-ascii?Q?NgEYTrXdpFe2jIx7X+zFa8iVdC+pqQOCPp6nLwCEvzI7HDWAZ+lTDbdT2/4T?=
 =?us-ascii?Q?iZ1TBJ0RSB6suohktQSqiGeJFlWcwhbXCSwJ7wyFCsMhcKXOUYqgD4V+9ZFR?=
 =?us-ascii?Q?iVYXS+KvDuVmyq7l/In/vLaeaN79cc0Hx9FbOHtC4qG5JtumoFxT49uqNXZw?=
 =?us-ascii?Q?0CKOI+s0Ay6ugOjbuKrcgNsVAauivTyNDMt154dvOzA+u05z8jfn6CLtCeWR?=
 =?us-ascii?Q?twSaeAnyQRM0jyOzciRxwdGFrXvPdcDL5MFRSbcW2aQDJssYERPdbzKQxHSu?=
 =?us-ascii?Q?Kq1+rcOLaMlDPcjqHKT8ZsQAb/O8dJ+jzHHNI2zBp+dJgftUKSXA5DlZVpk4?=
 =?us-ascii?Q?mEYKUkN9uYBKngWHEdfGe/ckyi23np8RTc/jWEKpp2QR8fNKcici0CNccQyo?=
 =?us-ascii?Q?7nqZYWs894VAOxjkTQEB91AZsdedAoWRDKRCmvT3+725YQfRnAxaxQmxqQd6?=
 =?us-ascii?Q?UpvLBf1Hj3T9mJCgJX9Wz30RqTFfMsBnVdV0WKy5nEu2+AkSzHurWs3toPGy?=
 =?us-ascii?Q?erXlyIhVmFUqVhDjXV5ICVIlzNE4KgSp8gO8eEPtRKCexwo0QQ/Ha/ndFJyx?=
 =?us-ascii?Q?D9Kucfh5WvI4SjNy4ss91GLIwavHzya10y5L2gOWzJZtBL2r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c61bs1JNdKDWi1vfyLyJtrhaTiJZyOU1x9Jl610cOq7EIzhHx0K+S7uAv1LUBT/goLfe5XcR9cO3E4kJFoimCAjac+gWFAlOiMZ+z3WlCyhuU62FBlmsu/PBcRyuTUenZQoxTbjCCRFYkvgmFD44QBidcqGAqX1QFZ84HX60t4i0+Cq+morLx6NtxaSh+JgwSU5MwIKHW/auWk5hQnyA/eFfwJ2ZJUkEmSEYSev7eb95DuSVyZIv+lrDIGA9hOpLjvq9K6tKbyqhdrR1hDLK8qWiuQP6+PprDKYEqDRuTORsegjyr8DZZVLZWiAmvOjusarW/Z6XPPhjxXZCFu70rw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372844cc-1f14-4779-fb51-08dec1409217
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:20:20.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyhhABQwUqbMyjR0XyNCcx2U2YInu+ZsbF1ggL2A/ZcGHAgStkedM6t4C7gXHshcC9tHpkH99BIL444wP/Y5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

Hi, Danny,

Thank you very much!
Very appreciate your testing!

I noticed one thing in your description " there's no fresh 'Wait RESET_RESP=
ONSE timeout' line this cycle ".
Generally, during reset_tic() execution, THC will send/receive data to/from=
 TIC for RESET response, device descriptor.
If there is no any error log after you only add reset_tic() in resume() cal=
lback, that means THC isn't power gated, it still keep previous setting and=
 can receive interrupt and response interrupt correctly.

Suddenly, I recognized, reset_tic() will set device state to RESETTING:
qsdev->state =3D QUICKSPI_RESETING;
So after reset_tic() call, driver must manually set device state to ENABLE:
qsdev->state =3D QUICKSPI_ENABLED;
If no this setting, THC hardware works normally, but driver will ignore all=
 input data, the phenomenon is that the touch screen still has no response.
That's my bad, I forgot this.

So would you mind try again, to add the missed line, like this:

--- i/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ w/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -822,10 +822,17 @@ static int quickspi_resume(struct device *device)
        if (ret)
                return ret;

+       /* TIC may lose power, needs go through reset flow */
+       ret =3D reset_tic(qsdev);
+       if (ret)
+               return ret;
+
        ret =3D thc_interrupt_quiesce(qsdev->thc_hw, false);
        if (ret)
                return ret;

+       qsdev->state =3D QUICKSPI_ENABLED;
+
        if (!device_may_wakeup(qsdev->dev))
                return quickspi_set_power(qsdev, HIDSPI_ON);

Thanks!

Best Regards,
Even Xu

> -----Original Message-----
> From: d3z <d3z.the.dev@gmail.com>
> Sent: Tuesday, June 2, 2026 11:13 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> jikos@kernel.org; bentiss@kernel.org
> Cc: Danny D . <d3z.the.dev@gmail.com>; linux-input@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; abhishektamboli9@gmail.com;
> sakari.ailus@linux.intel.com
> Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC o=
n system
> resume
>=20
> From: Danny D. <d3z.the.dev@gmail.com>
>=20
> Hi Even,
>=20
> Good way to split it - "touch IC off" vs "THC power-gated" - so I ran the
> reset_tic()-only test you asked for.
>=20
> I added just reset_tic() to a pristine quickspi_resume(), with none of th=
e THC
> reconfig (no thc_spi_*_config, no thc_ltr_*). On the Surface Pro 10, afte=
r an
> s2idle suspend/resume, the touchscreen does NOT come back - so
> reset_tic() alone isn't enough here.
>=20
> The interesting bit is why. The one new line on resume is:
>=20
>     intel_quickspi 0000:00:10.0: THC interrupt already unquiesce
>=20
> That's reset_tic() -> thc_interrupt_quiesce(dev, false) finding
> DEVINT_QUIESCE_EN already clear - even though quickspi_suspend() set it i=
n
> suspend. thc_regmap is REGCACHE_NONE, so that's the real register, not a
> cached value. So the THC port-control state we wrote in suspend is gone a=
fter
> resume.
>=20
> That's your second case: the THC itself loses its register context across=
 s2idle,
> without ever hitting PM_SUSPEND_MEM. reset_tic()'s SPI exchange then runs
> against a THC whose I/O address and read/write config are wiped, so the r=
eset
> never completes. Reprogramming those first (like quickspi_restore(), and =
like v2
> on the no-wake path) is what brings touch and pen back.
>=20
> So on the SP10 both are needed - reset the touch IC AND reconfigure the T=
HC -
> the full reconfigure looks necessary here.
>=20
> One note on the log: there's no fresh "Wait RESET_RESPONSE timeout" line =
this
> cycle, but that path is dev_err_once() and the box had ~12h uptime, so an=
 earlier
> cycle likely already consumed it.
>=20
> Thanks,
> Danny
