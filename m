Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7D168BD;
	Sun, 16 Aug 2026 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.246.1.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786858804; cv=fail; b=f25sX9Ha9l/PC8KanCP75GCBHsX4WG5UOdocUOAzyMIJQLq6A3fMjT/zjta+bursPImOdfF9bumN+qAH4VNibuHRwPmvwtZJg4OhwzxRLeEg6bCn8yWNG8AHghLQWeIn63FtOrJq69wl1RpwvtGSRgWx9ea9TVOuEfDQtaP+8WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786858804; c=relaxed/simple;
	bh=oCleOuInrS6xP0g2lI1GAe4nv1KzG15OxadW41fl35s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gDNqNHts2DObtmSnjWuZX4Xp4aoGXd/B3YMgDWA2peH8ROpxuw7SG/IZpjJZY1FxjpNJRj6zS8hUC6AB33JItBpk6U2t0yce7mud4eD19hZhHptpqGLem7i+dwCS8W6c/Lq75zmWIA5imu6dCNQfvKQd1GWOL44FGotT2tfO6qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DpDCdKZA; arc=fail smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DpDCdKZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786858802; x=1818394802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ntL0/2AFcSm9VpGz7YCj//yQtpTftJYmo/sYeiuK7eM=;
  b=DpDCdKZALkP1ugrcstb8pyUqn6LB+AsmyduXPbFkmcvZU50rBrWVaY5U
   gQgPgBdQi/igLqD0ceXj6O3xutu0Hmmd2o7hN/3xUxeLjo3iRmJ0OH2TL
   CjdTTVrgcJqZQeqbH6pYBu5EJ1nnAErGkmp6Pwlp6h+IN4EUzO3FvrBeb
   5sSMUayDQnZBEcQ3n9nAshMM1SDtwHsjHkiM6CaWXu1T8aokSao9Q2q7c
   gpRVZDahzhl3IPbKTeIkyKdnV9kaDwpgSYpmN7qSw12CrVIXON3JZ3d9A
   UMSCx4m+xeGYNRyMvFjB1qzAwqXOXRr7LZMK3o1d4jMkFDbfzrC2iDJn0
   A==;
X-CSE-ConnectionGUID: s9G0c/AWRDyUMl66E4GREQ==
X-CSE-MsgGUID: n8K0+SOGSfK1Hqz2M8gjGg==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="26080831"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 05:39:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6768]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 0417b06a-f1cf-4747-b8b1-4371f07e04cb; Sun, 16 Aug 2026 05:39:59 +0000 (UTC)
X-Farcaster-Flow-ID: 0417b06a-f1cf-4747-b8b1-4371f07e04cb
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 05:39:58 +0000
Received: from CO1PR07CU001.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Sun, 16 Aug 2026 05:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypUJPQ2Ay8Ke9imBjKLosGgu4e3vwCKmJzsMYJ3BaxJt5V/tFspw9aTqjiHACwVDkBhZAAqyvaJ/Qm0BEisklSQwWGZlJJHtO8T1QpcG9w2I58Hc7f+za+SjMiQ29IBaSW9iWZdKmRMPWTmYnyUct59V/5P3oHQfCNHCTYc39REHzrF6Xli/zy0/940VS84f0MMtNJDZx71gSnkfe5FukIFo6Xf5RJPgEjtBp4X+RZHwD8JMU9fd8J/KZWD5pboywC+0/07oG97mfh4AJCVlNJgpai48sceB//SFHaK66TY1BI3CbLgY3JO3zkKmEIKPn7s7gSIFRNHHkbg8VVyYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntL0/2AFcSm9VpGz7YCj//yQtpTftJYmo/sYeiuK7eM=;
 b=FWY9eN2Q9uSjOdl5JjP8Nc8svArcb+GuxJoriPjg8pCYpyenZsOl8Qy4PFStDQAO6eMW7hz4lUZb4J5CcVP3y32S7ssUl1xkHpKLw2I+LtnzxH/3nry5wo/lUj+yY9BDJoGqlc47OeVOVb5iRi7NODNRINVN8lhYmI6POrd/zABaS0iIHpM+rKzF6cH6RH3+5GQOXdasPfCOzDKNRPmwVK/riahO6u8x9ro1U7TycYBSiBfdQ1zFzQ/CQk4BzHL4FhBDi0Dmn+guW0tPbfF2ibrze9A+MPQDA1n73u42iL720kWFA8ZsninsseFPna53rOAYAPkxdPNeEkhdGP5adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN0PR18MB5870.namprd18.prod.outlook.com (2603:10b6:208:4c5::8)
 by DM8PR18MB4405.namprd18.prod.outlook.com (2603:10b6:8:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 05:39:47 +0000
Received: from MN0PR18MB5870.namprd18.prod.outlook.com
 ([fe80::76f6:dc78:9f3a:442e]) by MN0PR18MB5870.namprd18.prod.outlook.com
 ([fe80::76f6:dc78:9f3a:442e%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 05:39:47 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>, "orsonzhai@gmail.com"
	<orsonzhai@gmail.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "zhang.lyra@gmail.com"
	<zhang.lyra@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hansg@kernel.org"
	<hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"fabio.m.de.francesco@linux.intel.com"
	<fabio.m.de.francesco@linux.intel.com>, "kaihengf@nvidia.com"
	<kaihengf@nvidia.com>, "ankita@nvidia.com" <ankita@nvidia.com>,
	"leitao@debian.org" <leitao@debian.org>, "pedro.pbg@usp.br"
	<pedro.pbg@usp.br>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
Thread-Topic: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
Thread-Index: AQHdLUGlCUtys0N6J0i4iAa6xFoo5w==
Date: Sun, 16 Aug 2026 05:39:47 +0000
Message-ID: <MN0PR18MB5870444BD9375EF4F7131851C6D82@MN0PR18MB5870.namprd18.prod.outlook.com>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-11-farbere@amazon.com> <anlSAqWxS7boyJBT@monoceros>
In-Reply-To: <anlSAqWxS7boyJBT@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5870:EE_|DM8PR18MB4405:EE_
x-ms-office365-filtering-correlation-id: 38df63e9-00b2-4579-4b9a-08defb58c876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|23010399003|38070700021|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: YdM+g8yfvMMMb4wZqskPycr1VE9ywVBZEjlRCk2Kp5ApNNs1ksFKs81oGnoxVaTR3Nlta8hmNAxBdHmLLDbiLS5dG0Niv7NYttJR/4z+A2u4Asg/9Zr1CHeFwXlAOWJHVRMQIzeldBcI0ynFGoKqeuZVKb5SZII92RHC/aaHS1L5zKUlWC8TiXi0dg25eHZVTIcwgiPfEUgcl/X2UV6rdntj16aaOMhoZOFX84UWbvtPns8qPYE3bMcKGo45k+rqE0+BGp5ROskFUdWW0NalcRkn07w/ZJNvgzSHmbbDhgYgmN4y+6OdPEwGDQACCn2EW5H0feUr+tZy/F6tPMOpayveauD21hxx0u/JFxY7Uls1RLQtABwIzGeys+iTFT/esDqoU4iaG6CffJyNCdEW9RCq1gqCGmRKN1QEwKwCwl5L+KLijZLuxYaDd/ZoPlCV8ULH8IcnbtVIfRr4l/7Ag5aO9Jw5kHloJzgAWQqfUqFeXVV5Rru+IBUyOTgL/HPcJf6Ccc46Dhtq7vVuaWaLHoPyi8pS7zzTXA57+ThHwhJsw5Q1a1/S9BzBHDOKbqsJitsjGlPSOFDyu/hPqGDKFSm4um5A0Ad4SFpdjALZTafdpp0EckdQ1qArspNSbod1gEOJ65Nna50dYrKGd/Kb3tjxFHLxHWFZfHiIMHBH2vha+lfs+tVzmNQufNjKOpp4laG0wTbFGlRuQObFFz3F1Jtf4fcz0J0zCJ3ALhGmFq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5870.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(23010399003)(38070700021)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gzgHj7B9mwDtoCAdy0JkOkG5c+otX0/RM6pf6ivbwvQGEC8OdJl8Z8z3du?=
 =?iso-8859-1?Q?TbU1dZKBVI+oYhx1LyGmeT2rTNz5gWM1rsmWCafPmXoRsuKojbUBOXNJJS?=
 =?iso-8859-1?Q?2kcvUiuA8l/rkq5iqzJ68vU8hXV8+r3jQGlRQLa/LhO/he1T6C570luWL2?=
 =?iso-8859-1?Q?SImhmgeaNPlFRP/aOQ+pofDFqyT+AMgi5dxm+kfsQjFwWb/fIUCJyI2U3g?=
 =?iso-8859-1?Q?r/Q4IzIEnqv8lzsxVzQQB+5s6cwi7OoGtg+H9lg0ZRB2mTV5FWTeZELwzQ?=
 =?iso-8859-1?Q?Lml9pPjD7J0Z8CblMD/x4lSdJYa8CKXj9VZ04Cxuc4uFsHqQIB+4n1hiC/?=
 =?iso-8859-1?Q?6WoId78lstXqnm/T3Ve7tJ7oD/Byh9OJht3YOOfMktXoDTAlPa25eVhuWT?=
 =?iso-8859-1?Q?NA5Pwogz3+xa3z0d20g4gjYAi9tZK96/s2gzo+FmJnV7Iz1RfdrFqHATVy?=
 =?iso-8859-1?Q?G3y3L8Ru8v3N4x8P+qQ8ZU1y/UWXVKXPBZ8K1mHjJ7HeT//+APFGxkJ9BJ?=
 =?iso-8859-1?Q?+V0/9nUOnWFiFjTof/gxaAMBGplewK1WHsfHSi1Rr7nYo+s7FUsS6iYiSR?=
 =?iso-8859-1?Q?fA187IVPpL7D5Q3p8BmpRaLU5IuMxd9fpamJn2J+JJRbLrVe+nDCXuUjU1?=
 =?iso-8859-1?Q?q4WOAbszRDv9D9eHXeGsMHUyF+xFjkJ1tDOKMMnsm0/6aMzCgYBbfA24Vw?=
 =?iso-8859-1?Q?7kTZprYxq+ONX+R0MXvMtCQfoomhV+fIGD3GcHQ/bQKUHOkTn8Y0C4EmVz?=
 =?iso-8859-1?Q?jDAB0rCI2rPDL30PQ5Bpi/kJZBoNHTLz5NATdRZweosu9h2cXzcWcQkxWz?=
 =?iso-8859-1?Q?FOnZ/X9WcjJjWwLFWYp1dGSog8TeuHLiItKolqiyDyWp6p737hoXiXR8O/?=
 =?iso-8859-1?Q?zQQZy8N7e+Ua5EsaZPFqxMviE4E8do3HcT8Ci/TpF8Nh6Vh31cpoVdmFKG?=
 =?iso-8859-1?Q?pUeyyfYlCyfLd+iSIkr77Kewl5+OoSjObdTxe+u+AWJuKPzQXs3l10KNTB?=
 =?iso-8859-1?Q?8q1UMu34AQBgwVXPd/ChnPipJ3TMu9R8VLUBoa+VjLkZU9QjdLVkRUNqpH?=
 =?iso-8859-1?Q?PlZ/OMaM/cMNNQUxs4j0XL1gYISmK+pucfA9RmxCjzj5oD7EwQ4AiB9sTZ?=
 =?iso-8859-1?Q?NxYqkY7VYpwRXP2beFflcbIfOXK7ZIxOcNTVW+or4SlWUc+gsdJ449AL25?=
 =?iso-8859-1?Q?Hm3/5g4tN0zjKcv1bGlxgqxJoE4fA9eacXL1JcpfBrN/U4YX8keOj+VwMu?=
 =?iso-8859-1?Q?Vjv8ZbFpAzI6f9e1REWAlv4AkzdSjqWwuBdccA9CCifQupBgJ3VnRRSvMI?=
 =?iso-8859-1?Q?3362hx1sCiMmt2oysi7et3W4O2bwplx722PuUFYZmfCMHDZnhhPu+iwpx0?=
 =?iso-8859-1?Q?UPryLR7Ni4Qio69o7fwSGlmoRPOazQz7T6GDoqGSaGSWvIMZ68KOQlLwyi?=
 =?iso-8859-1?Q?DhCy43u9ysKgybbkNhXwxWB9fMfpjne3Ba3Pt5l7Qc2SDoJaQE/rsKCZPC?=
 =?iso-8859-1?Q?Q+bPJjQG25/FhHzPX1NbxmBMb9/Aor7sjDkYBdmQWWG6maYW7G/EjGJslG?=
 =?iso-8859-1?Q?497Z0atgcNvPN4aqo0FKc6Ylsu/siqTL9a5DMyr2NDph4DMjbysmwZrmHl?=
 =?iso-8859-1?Q?HV3EJLYGIaWFSmZtIu3aYew8NKtYU1FGoKiW5W1ji0aoxmsUk4Cg/e28/j?=
 =?iso-8859-1?Q?b0C+m3sItVEE7mP4SxPZZVMqYywfA0zPGwntjBZZ3LMyA9gFe5XcdkKxI/?=
 =?iso-8859-1?Q?XjsWAApFlgqye2IA8WMHWV5TZ2o49YooY/YK1m8Ff2A61rZ7SQlEY7L722?=
 =?iso-8859-1?Q?7x08nxUkTrIebkXvfxVHRDE0cmf7XI1n1+224P7gcpX2GN8efRxs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Eqs3wAd121NRUE3NyusDTH6fJPHN6QDrUd2YiXm+JkMS0CTcyyM9l/d9m32ppThQPwObea1QCT3n8cp6uf1ZbTVt6pech0DBKGh1OC3MSQ7GTl5pxmXnCt5NuqdPDFIhLi7U3aJAMlnfi3D0/Sf8WIKW7qP8mgodGQAnJ41NEh+QcBg47Ec7EaGVJPitY4noVxvdmq+6kn0HMKaVhwUO+Kx/XF5ldvLkec3RJmM3EyYBxOSTgJYLZ+i4h0IPZyLERJniFbhB0vuKISL/lefCNiZm8UbBWtWeG/r6Rn6MtGuX9KEpFSI67NKZk1Y0Yhzo1SZVRO1NyNz+JAS99QX/sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5870.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38df63e9-00b2-4579-4b9a-08defb58c876
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2026 05:39:47.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrACAKKkvqlIUt9BbUINlOu1SZ27C89Y0njYPTJrPyr2LjrlovTuLoeFRgCljuSp+RE8CTZSZZO84koXm+8m4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4405
X-OriginatorOrg: amazon.com

> On Sun, Jul 26, 2026 at 10:17:36AM +0000, Eliav Farber wrote:
> >  int devm_uniwill_wmi_register_notifier(struct device *dev, struct=20
> > notifier_block *nb)  {
> > -	int ret;
> > -
> > -	ret =3D blocking_notifier_chain_register(&uniwill_wmi_chain_head, nb)=
;
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_noti=
fier, nb);
> > +	return devm_blocking_notifier_chain_register(dev,
> > +						     &uniwill_wmi_chain_head,
> > +						     nb);
> >  }
>
> I'd remove this function and replace calls to it directly by devm_blockin=
g_notifier_chain_register().

uniwill_wmi_chain_head is static in uniwill-wmi.c and the caller is in
uniwill-acpi.c. The wrapper encapsulates access to this module-private
notifier head - removing it would require exposing the variable through
the header, which breaks the current abstraction.

I'd prefer to keep the wrapper as-is.

Best regards
Eliav
