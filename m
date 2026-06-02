Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987284039;
	Tue,  2 Jun 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390038; cv=fail; b=jA9zXkrCapCkO1fLtzh7j2ry/Tk0bjM82lQTOuoiHczLv2DIIVg29PraYkxRlcZOCp9gdWq2Ug6UYAeee58WKZ3bC3jdTNQXzbCe0mGMB9DD+ZXWx2lGr2kY3hxNvoZyZLAORiKh5PCZzwNUCarbnUc/CwCspyYLxoe2OiXGCaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390038; c=relaxed/simple;
	bh=ABxcvk7HWHh11UHObHPYf/nnMpLO+dx9RKPrkGiLM0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkOmr8Vz1RgUx7iIOu3qCI90UqA4OCHNqmmupX3sYGH3A4ETeBqr2KQak/0ifzw1LTMT+eGPItCtIHYtK1Zd1uHs8qkcTyR1EuMBkeyL7TZxSMlZY3Sc3CDlhFGD8qyhaHLQJ6CK5OMivKdrVIfo9YR6HvEYmSigfNcJ10pESaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVjoYkSf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVjoYkSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780390037; x=1811926037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ABxcvk7HWHh11UHObHPYf/nnMpLO+dx9RKPrkGiLM0w=;
  b=DVjoYkSf2mfY9Mbsf0/za6Xp2ApUlaq1nGMmYuy8a4nW8SO19WhbnIRL
   LRSZ2vb/+hbQuZaG6dRPSojzkvhER07cHO7ZdwF8lrk/vjr2NcivabWcO
   iwindQQ9chm1C1xjySDg7YabaHziuCrbUZwb2VFlQSKmmg298hr7eFMaQ
   tS+bqQyIPhD1Afo9DnwWxQisGt6PNqQhBNWcIEEtSAjlXpDNa3iCqtMcC
   qAWgoAWN8ldT1nm10n5CAV61ttL68/tRftwkYx8s0t6f0thvL/FgnnJ48
   Sqm6+avRYxc0m/rtg4lmBjhuaDPLmn3r/9LHMtCOwW6HYrSbvcjDVkNQI
   g==;
X-CSE-ConnectionGUID: bfO6cOd+RGq5HODamqBU5g==
X-CSE-MsgGUID: dyuk6zWFRjebKTUWaWrCsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81138350"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81138350"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:47:16 -0700
X-CSE-ConnectionGUID: egvsYT/SR4G1KWQf4OzsRQ==
X-CSE-MsgGUID: 8lDbOrFYT3umLFcu+IaMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248768939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:47:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 01:47:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 01:47:15 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 01:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAHyZLYyVjh3aTWTps8EcjZkS6xyzAyJtlGOQEl2OZC5OHiIF1oi2qBSdMYxOZdreiuyZf6D/rC3di2SfQFTV3spL9u7po9B6cqF1pz8AUQe72jPG3i/V1eqG/JLS0U+UXJ4q8T5QAdYYMab9F2tm5+lC84/BJL2K2DeWjwzv7Ev4J4zz+WxFdInVM+JrWba0l3iEHOSICS46U6yBx4TMhk5N2pduYkrXJpwxqRa8NFwyck2Bzuc6lQn2JF5cBJpaYnkXjMcdK9QApRqYpuQejXWcBbHd958GBhXKkAIexefdvuQurGj97k/F68UDjRhMYMWsB5UHVsPerzPf3LPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqVZdbcOcB3u+1GTkrHIX7VLUgulh3MhBXeGhkMWmXk=;
 b=lQcdRlC/8Rw+oueWVgLY9xwNKKQ6puOeCJYPdKYTzKo+blT0p0gbk5c6KWpFN0XTPd0cCfzrSzF/2hvhaLfiVHNt3yijZezP9Sigf17Z9rkZkqV4KNtXnjcXUMNL4bma5/ymPY36x6hODnj6vknsJPcS+9XmM9N2h56trLac3xXFleLwjcQtIaN6P0/nTwkbOisXluCGlFk2oQJ6Fn4k02DWGZFCIx1FZuwJmH/t5u0FhyUPJDZVpseuFEYggxjk/jnlArcsKmM935iFjykJaukDBgCszY6HqmD8tlEM8AvnbP4EZML2q/ijXI1QiZqvHcWXB3Cc14fqEBVqb69UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 08:47:07 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 08:47:07 +0000
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
Thread-Index: AQHc77mrUbJCsvCWBk+2B+n2qvQl/bYpBmKggAAG/eCAAS7+AIAAuevg
Date: Tue, 2 Jun 2026 08:47:07 +0000
Message-ID: <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
 <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
 <20260601213047.115271-1-d3z.the.dev@gmail.com>
In-Reply-To: <20260601213047.115271-1-d3z.the.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DM6PR11MB4724:EE_
x-ms-office365-filtering-correlation-id: 640a6c69-6ce6-447c-a34b-08dec083875b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cRhJ4+KUFxZSkzrGDmYMDH1T5Wm+OgN29C4yfEB7OdkDkl2iiB/ezvVk4xd0I9iRuE65PMT1D7UfT0fi8l8+XSpRm91poQzsSv9O/x0nUi2dvAGzC7qhB5h80cDSTpeR655E/GNNMBxsPo5YwUg+sP49fqfnRabAYU9ur5A55LZka4mPIdFzK6NXphNhBTQQ+EinrOhVheak9QQF/WSRgNnyxBZT3q0O3HXRXXomipoEG+jlyrrD8N38GimOqvapPunlCVuZQmCaX1jM+ydCG/ullH8pT7Cgqo0tlSkanNryWlSKCiVzneJ10xTEudlnOdf6wKKyaFyc7iOojfPZuHHj4xfzAzXLAIpruIj+uncrUHtMJ9nkGGvWKtSwpoTB8iSV28HwKoDrdqMtrpmeMpqwBOj2UDQfWCXTT8sBn0tk/1xINYz3myLWqcc4rKaS8tj1milx5Ksm7pBlnJj513b4U/51B2AfDRJGb3Ig1jXwQObozJTkW8HAiARymdt8INYr39fuX+M18fDnEXnnR0KELVVAl7TJKEDUdSCBPmIdrDFMLPBB04oBbTnk97ceWoZfzjgNIV914bRcuojFA4ascrYkythWlIr/M/jrn3Pv0j+2+p8dhjcWeb+vigWh/ivy28kV3SAIhlNMz6crvjvbhGj8CQTSPG8cMJ/tk5CHeZf7h8PwOs0LO+Oc3xpvjDdkddTR2CBmuDl7U/KJghQS55IJDzo/6C8qYdNU0zndHvtJed5/d7MCkzNms3Cb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4IX2pVZNJUYZzfwE24BCeLnuxB/YHmfBQ0DLbeXEYoc8EX5qUr1e/BjF10Js?=
 =?us-ascii?Q?pjPb7Xk7kep0z1O8P4pAyPTR1wANoHEQHQLb4GcLXEMNQ+jaW+xCH2Lrm5UY?=
 =?us-ascii?Q?fXP4JsT58l4si83A2yge5HyDy4lVOptVNKmQswunKE14nGyK8M+r/mRm2fSg?=
 =?us-ascii?Q?wqofUpouLJCL5oHkxieY0D1KDoYYHdpGuvSqhnM0KpBQj2kCKzRV9prpGxrR?=
 =?us-ascii?Q?ccGGg/peHfe5eekBJxweLqpepxqlg3EMiuuoKRIwuHKLauXzunQona0NZmLD?=
 =?us-ascii?Q?3NN7zImfcNLWd6cdXDuEZI+zhVit9w2mfQt7RfPOjSrID/+fJkqOjp3BqxNK?=
 =?us-ascii?Q?9+wwOJQA05rV2sADUe7sSnmNRpWY8o/BiZRHvYSjLM+RqXS4kseyeLB/ick5?=
 =?us-ascii?Q?PjzApDBTQV5zhOMjaUyWTbo6jPvmzV0L6Kb6/VKocx3f+E4n46TG+bkaVaoC?=
 =?us-ascii?Q?CWPmhCRLW8sHxdW6mwQ6CnwZ7+nUz7Il6Mw4fGAGNkln1z8wL7ibrM6XQ9fp?=
 =?us-ascii?Q?dCx8hu5yJKk9ibj/mBNmiZpaKFI50S89Ul3JLVUNx/2ncaZZlIkOJq+l4+uC?=
 =?us-ascii?Q?ACECfrG26jBWq8q3PSfLKxHtJaq1ktL0cFAStm25WLKEA2CQFD+3pQ2qclm5?=
 =?us-ascii?Q?4FuVnOMqqffCZqCWsHNxAjg50XPPbqvcKJ56T7dwfmSgqC7TJbOYWkne6kBm?=
 =?us-ascii?Q?vjdEsyoW0d9I+lUxWrMYE3Vv6ViddoJhS6EAKdTm9ew6EleJWpCz/kb623BE?=
 =?us-ascii?Q?sshKeG9m4w/HWFielV2I0zgG4PA+UJ9T3s2RPFg8rUO0y80X+ciPztSVbDoq?=
 =?us-ascii?Q?88kuVvcByOvBQH84ee5cYuX8DTMv1UaAMAlqfeCWAfCAEnQILCS2ssnMguSf?=
 =?us-ascii?Q?tDwiqbH2J8a2lBB5cvGcDa6RiPFpqkRoZmSrXpNAUuLf6Pe+fRxBd+O6aP+k?=
 =?us-ascii?Q?Lv+Onxe/alDzBs/iW3+ZvSgWlq00rMAeZvzS6GQ+WNkJ6ieIcwtgjowXb3a8?=
 =?us-ascii?Q?+xp+2LE3wz/UU0E0noTcuUJj6+BeoxInRfT4I8v9NAHz7YGt2ZfA+hBDzUFk?=
 =?us-ascii?Q?/sZvhcbr85g8gRGVsIzfKylR97Rr/jPoY857611aTCsBPIDQHrBITSXAMvOj?=
 =?us-ascii?Q?NIfV1vq5Nqey7HQzDSR4UrO4fiT8b60/U9J6T6mjEFQ3CcrV44G5clcwfdbD?=
 =?us-ascii?Q?q1J23M4Zk2XKlNjxB1pG3FZx1Ex2t+l3SXuCyMOl/sPQUm6z6XZ4hLNkGglH?=
 =?us-ascii?Q?PAthO4SIhal5qoaE/UYFdsXm6FhOvu1g1wCw4DFIb3GlD15osK/J7tl4NCj+?=
 =?us-ascii?Q?4/1eRzagNCs2FQKJ43bM7EuoEQh00wz7oO9cbXXapibuFEYrC6qg58vA1ifj?=
 =?us-ascii?Q?uhW8aXddQvVd0zu84NAgl6/pl2eK8haoz4a8yxiY6wBr5LKjtemsWLkDA0bq?=
 =?us-ascii?Q?+7H5eKAsy1Dj17ensMGATk6CfnyWstOQiTjxLwM9lTQOORVpbQP3F4myW8JM?=
 =?us-ascii?Q?pkouZk/LfJlHrOSVrsvMNKamEpPvoJ6qMoQ4wVJMeLufFfpiYYy45z/rt/pb?=
 =?us-ascii?Q?yZ4S8Nc5OAmBxhbevxqzMeyGDYu+uGTYAomizsJ5qHj6KgfCLh+dv0IuIopd?=
 =?us-ascii?Q?IsM8uSFRKcqG2+zAk/kk4VdABp1ZOmEQEgToslAb5oRaM8ZcD73rf6n9lWfI?=
 =?us-ascii?Q?NymfiLlrDmTPNurgF3KIjE8EB4zphbD0ZuNKZZNX48qIWzEb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JDkehY5pgmRkcLKkByPPI/uWqbdqaGlGMluZdzJjl52SnBv40fvSs8qZsitDsQlfVteAARvVIclVNulhm48dIIgYWyEwOL5avhOXd01xOBbNtYkcnDXLIbNyCpJTwI0S77Xf0LHWVv3orvkmNYR9mFYJMAKvXE4vjpHoWFdI4jp9mkUbrrLpxDqWs4BbdoCRYpd0/oxvRt7ijgleUKuZ1ggUdJ1XijEmiQulTNt4GIj0ZreAJZUZmtbTTlQTXOMUdHRW+6sHcM9pohbPx8LTgM10SApMdSuF8JN4n7SG7rT4353lFgAlQNJIELkMAO+vxFUzA7ZplJmNqxfkDOe1yg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640a6c69-6ce6-447c-a34b-08dec083875b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:47:07.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwSwrQs0XrqUEb2rUOUxpcjAWi/h90bvpvKTCXY8FaAyN5HOvz5t6qyR8AR2RyjbiY/QEfaSf+4nFI9EW2JNlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

Hi, Danny,

Nice to meet you!
Thank you very much for your testing and description detail.

According to current situation you described on Surface Pro 10, there are t=
wo issues we need to identify separately:
1. Touch IC was powered off
   According to your description, Touch IC power off can be confirmed.=20
   In this case, only reset_tic() call is needed for touch IC recovery.

2. THC was power gated
   THC power gated is another story, generally speaking, if device doesn't =
go into PM_SUSPEND_MEM, THC shouldn't be power gated. If so, other API call=
s to recovery THC state maybe unnecessary.
   We need to identify this case.

So can you help do a test: just only add reset_tic(), to check if touch dev=
ice can recovery during suspend/resume.
Then we can identify if THC was power gated.

Thanks!

Best Regards,
Even Xu

> -----Original Message-----
> From: d3z <d3z.the.dev@gmail.com>
> Sent: Tuesday, June 2, 2026 5:31 AM
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
> Thanks for the quick reply and for sharing your patch.
>=20
> First, the missing piece from your mail: my name is Danny D.
> (d3z.the.dev@gmail.com) - please use it for any Signed-off-by/Reported-
> by/Tested-by.
>=20
> One note on the starting assumption, though: in its current configuration=
 this
> Surface Pro 10 doesn't go to S3 at all. /sys/power/mem_sleep only offers =
s2idle:
>=20
>     $ cat /sys/power/mem_sleep
>     [s2idle]
>=20
> There's no "deep" entry to select here, so every suspend goes through s2i=
dle and
> never reaches PM_SUSPEND_MEM. The touch IC still loses power across that
> s2idle suspend - the same as over hibernation - which is what gives the "=
recv
> failed: -11" on resume.
>=20
> That's the catch with the attached patch: it gates the THC reconfigure on
>=20
>     if (last_suspend_state =3D=3D PM_SUSPEND_MEM)
>=20
> i.e. S3 only. On this machine that branch never runs, so it wouldn't brin=
g the
> touchscreen back here. Happy to apply it and confirm on the device, but f=
rom the
> code path alone it can't help while we're s2idle-only.
>=20
> What I did instead was key off whether the device actually kept power rat=
her
> than the suspend type: run the full reset only when the device isn't a wa=
ke source
> (device_may_wakeup() =3D=3D false), mirroring quickspi_restore().
> A wake-enabled device stays on the light path so wake-on-touch is preserv=
ed;
> one that lost power goes through reset_tic() re-enumeration. That fires o=
n both
> s2idle and S3, which is what makes it work on the SP10.
>=20
> I've tested this on the Surface Pro 10 across many s2idle suspend/resume =
cycles -
> touch and pen both keep working - and just posted a v2 that adds the
> device_may_wakeup() gate.
>=20
> Could we converge on the wakeup-based condition? I'm glad to test any rev=
ision
> of your patch on the hardware, and equally glad for you to carry the fix =
with my
> Signed-off-by/Tested-by once it handles the s2idle case.
>=20
> Thanks,
> Danny
