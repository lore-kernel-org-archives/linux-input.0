Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CE233927;
	Sun, 26 Jul 2026 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.246.77.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785040050; cv=fail; b=GO9nhdStvZCYf3Beu7Et/53zZrwUnu3INRL/oZV10fXbbQTWH04vxSsGf7ImnBIwlj50CyGx713iAHaKxcg91P/vu2CKMZsTv8Jq16MZhOJ9xsr74/nU5KiCpErpkHGuTLhox8Lc78JzpiIEq4YhN+WdcQclfVB1mMbVQOQBcWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785040050; c=relaxed/simple;
	bh=O1Wi7lHMvZo+/uJgxMw4cinypJFJSr8CNk+qM8iMXso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQrPDHD6lnPE9G2vIFyaMo0Xlqp2bSAPnW3smJxR+hhqox/WPclB3HSaZ2wsTDZQLprSo3LYEoQpflLfvBA+oIrUA+LWEZ5rOUAX4yHBPxYaFiO47IbxcgKxFpG8OGx68qzp55mTvd24AofddlC1zJH2aS2o6Okb/wDQzl3NBE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mlcTu6XC; arc=fail smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mlcTu6XC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785040049; x=1816576049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O1Wi7lHMvZo+/uJgxMw4cinypJFJSr8CNk+qM8iMXso=;
  b=mlcTu6XCHEpwhcYdReQs9DK50DinFYtxiqF+r0q2gjMUM965KFv/GCHS
   9s7fgCRT8lovxwG693oY2QTyIbOw+r40p0RIXu/CUyUHxy7015Q1NVWdV
   hOQntj4vi8r+1fCD/1MNViKv0QadSVv/yvJhOsvIPkn6sR++AXbxQ3VcA
   /cChfTwdBXCQ0cq7OqaaEozfsuoMomlTrb3NtYpME1gmKwt4n3BgBTs6m
   HJO/GUC8C7lqIliW2dV5o4v4RUrkcRcSaeugIKFwSTA7M9rLVY+XOQtKX
   Yb7rfJxTzrYjnWiCChfhM9xZLJO5KHhTRqGps19sH2pqcDYncxbDh8ucp
   g==;
X-CSE-ConnectionGUID: 8MIRiTs1Rlu5YtCjBfPtnw==
X-CSE-MsgGUID: LCz9aqzRSLmch82lDVafJg==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24354927"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:27:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:26423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.230:2525] with esmtp (Farcaster)
 id c3d6c07f-ad59-4548-880c-fabe29e5f0cf; Sun, 26 Jul 2026 04:27:26 +0000 (UTC)
X-Farcaster-Flow-ID: c3d6c07f-ad59-4548-880c-fabe29e5f0cf
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:27:26 +0000
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:27:25 +0000
Received: from CO1PR07CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Sun, 26 Jul 2026 04:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDIuI7FEQq+kewr2U3Esznge+JjrYFgm8sYNFRXkBqZujIpgQcSdjTfTLUkWQJrdRXGU/1yIo+c2QMpKKAE3lw6bz7Tj68kccD7hY4vJYy+ZD+L5EW1geI2e/xxotklUKs5BgZxI5TlbKn21PsNDwppAzzJLGEOpgtJqRarEu1/gUdsZCfHZ8aRH1YFaclgA3tSWwtfX3BC0T2g2Wx4qsYUNQYGZajmTeAQgUi2ihchlhdL8dZttY/2KHScGhAufjw5k1BiL2ov/JD3NUVj60BulXJBngUh4sdzp/68+SBOdV/XEmzKhLftKpi2fGVhn+o7rsUZshDPrdja3lcC+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1Wi7lHMvZo+/uJgxMw4cinypJFJSr8CNk+qM8iMXso=;
 b=MKPtW2Pco3OHVmHc21Fg3vG2eSIwyGxRvOhWuKxTjsFgqthZw2DHwyquJnMAUynw/UGMNN5hj/ySqEF3M1A17B0+Hfq++f2SQA9CNGMIo413AQck72w40DN4QwbpPEu5vcfA/lTciAm8m4ZhGtzummERZuckHCueyJIJ5pizOUHCkyZg0GAPB3Imt7/97kjSW181/h+2Eig8DZk0SPUJdaiEhZXUFps9AY0rpUqkfn2XMg2fzGX4yznTQuTCvoalhFFYWvhVuVX/2Zw1ofaB5lLWNvaPk536aTwxwpl6XlYeDO0Ofl7XHl5LIZH5EVR85f7t1BZV5wOJWFHt8oOMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from CH0PR18MB5433.namprd18.prod.outlook.com (2603:10b6:610:181::16)
 by IA2PR18MB5887.namprd18.prod.outlook.com (2603:10b6:208:4b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 04:27:21 +0000
Received: from CH0PR18MB5433.namprd18.prod.outlook.com
 ([fe80::db:2f3d:fbda:8905]) by CH0PR18MB5433.namprd18.prod.outlook.com
 ([fe80::db:2f3d:fbda:8905%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 04:27:21 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Bartosz Golaszewski <brgl@kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"orsonzhai@gmail.com" <orsonzhai@gmail.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "zhang.lyra@gmail.com"
	<zhang.lyra@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hansg@kernel.org"
	<hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>,
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
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Farber, Eliav" <farbere@amazon.com>
Subject: RE: [PATCH 01/12] notifier: add device-managed registration APIs
Thread-Topic: [PATCH 01/12] notifier: add device-managed registration APIs
Thread-Index: AQHdHLcMxnkOQgeInkWqz+EuAXrD+w==
Date: Sun, 26 Jul 2026 04:27:20 +0000
Message-ID: <CH0PR18MB5433C53E35AB3D02D256CD5EC6CD2@CH0PR18MB5433.namprd18.prod.outlook.com>
References: <20260723175325.37397-1-farbere@amazon.com>
 <20260723175325.37397-2-farbere@amazon.com>
 <CAMRc=MeE_FdDMpXzzBB2dwH18DWmmT9B=CeouoaG1tV=y6-fXQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeE_FdDMpXzzBB2dwH18DWmmT9B=CeouoaG1tV=y6-fXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB5433:EE_|IA2PR18MB5887:EE_
x-ms-office365-filtering-correlation-id: 3329178e-1666-4969-8fa2-08deeace2f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: IXCv6QpCT33eB9D8BS5eTZmREqmUOx9NQoXmLeP/+MwvQEeqN1jvKZO666v7k+GPKEFHNZMGQRuvrEPeFWP4MPDlgusfYMCWA/J12svltnRmexVSLTUwB6VlpYLgu/CBnCWt00dDC1kOfw4+9ZiCL2uEPU36BaLwymlCyUTVrKPQCc7tX/9uy0rtmHEbxoVTl/B3BjPcTJDWaMrzDVyz1d37ZgJjsIS79jXPbDXLkq7894p/mwk7/hjFPghO7CiAqVAsGrRnVqmyGqKNyoWeDGTQKFLou0feIx/od9lotV4kbNbVZ0n5M1cZXs+69Qx4T84vBbi6CIoAahvOHuwhvthZRbuiWeJOYrX0CoHqn+Iv4CfPDbwucWrEX/f6KMtnLxcrelQqZY0TKQj5sS03MBXKMaqrbnubPKVtVLFsDYGBH8Tgmz2DJPKhnQQYKwXuEbr1RRX84AXRcrcXjpgaPsOIgq7OIVfz8SS99Cgx7eCI/9+nZte5XEIhLfi+FCosiWboUeFIibtgO09PIrORii/Av6in3eBgPf668OJup0WgI5nKQFF0jr0iPU6PTc5dbEq8Szowv68XjV7Ti+LSSHZLA4VnZgXirzx7u3X400Fc3CcX1BkIc9eI5st61xKvWygXE87wiDQ+zJ+dc3syukGeSr/0zqHzTHshQpqU3DYeOb58ixt0SNMXFJb6Yq1USs1sdWc6e2wYximnu4yQ3uo798oQFr8UA4k+gq6EUK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB5433.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUFoSStGak5iY0QydzJHL2F2WVJOa2VoazBOYUtrR3BSejE3WVBnbGJ3YmxJ?=
 =?utf-8?B?TGlJSzQ4UGFYak1pZ3lEV05ZalBqTE9kaFcvNFJEdkh2T0FSeDRxQXFIaFd2?=
 =?utf-8?B?OFFsTjlGQTh0ZFFFMzVZTkdZUHdwSDlQWUc5aG85dG5DM3VUR0I0RForc1Bp?=
 =?utf-8?B?NmpVSE5ML2xhYktiRVo2eENSWVoydWtkTkdQZThLWVI3ZFBlMGJYaC9qdmpY?=
 =?utf-8?B?TTFvRDA4WVFhdHBFYjBBVUJXQXhaWDEybFh1bEJkKzBadHBhQkEyd2hCckFx?=
 =?utf-8?B?azNKQnNCVlF1eHBBUTg3QWVtV3FWaTVmS3pZcG5XY3FndVhmaVZ4VUlaL3BU?=
 =?utf-8?B?SWNMNFJYT2lmcG96UVdrU0wwZGIxTjNQNWo2c280TTdabXE0SkxzUkh6TnBw?=
 =?utf-8?B?ZTRVWFJZM3YyUHk1bFVHdXBPRXZ1Vi9lT3BNQ1NsSmg1d1JsYWlvUXdpdUNz?=
 =?utf-8?B?K2liKzFTWmxyaytUT1Z5VzRvc0FsbEZrKzU3WHFIY0NaVG1vRkg0MlFMY2hB?=
 =?utf-8?B?bUh0RTNpZjhaUG9JeVJ2QVBSdys3aExqQjQ1WnhZSnAzUnpUaDRGQ0ZobnV2?=
 =?utf-8?B?cGRKV1NqbG9LQkpXd3lVemNsRm9vdEJvTThWeXlNb2czQk9ERzl4TlRWVFd4?=
 =?utf-8?B?TngwVmtMN3JDa0s0aGs3a3hKaXJ3N1dvYkp6WkJZeVF5Vnc1UnJkRlFCYzBP?=
 =?utf-8?B?VXQzNGR1NVJydTM2d2hnVnJxdEg4UDl3ZlViemJsVGdaWmpLNmREdDhPZEN5?=
 =?utf-8?B?cThnSGd4eWxnTTRyWkkyQ3VlWndVSy9zczl2czVoRS92NlJjWnJYOURkODg1?=
 =?utf-8?B?VDlVVjVlcVBkRHlSdlF3MXlYenF5Qm5MVTB0SzQ2RXB0SVBVVUF0Tzc5dUhy?=
 =?utf-8?B?RmFZSkQ1VitJN2dBV3VrZVIyblpRb3VFSWM4eW1TamE2eWtacDN0aXZReGVh?=
 =?utf-8?B?K3E0SzJoVjk0R29MRm5OanBOdTdRVEpMay9iTjJrc2NBdVdsTXRUSUJKaHVE?=
 =?utf-8?B?QUxVMnFSVnBvSlYxbllEUmhGMkM5T3E4OGRYWU0yOHM5S3ROZTF5QjFTQk9o?=
 =?utf-8?B?dUJBVkY5NXIvMFhLOWI4MFE5bXdlMXFOa3dCNGhaNU5WbnlpSmhWeVpnN2Jz?=
 =?utf-8?B?NVh4L1ZtTFlibTkzYTduM0Q4QjA0NkFUeFB6ZEdtQ0drTUxYUDVRNzltS2FG?=
 =?utf-8?B?UTJxTzh1UG0ybDFxVGZXNy95QUFiYVk1a0tWYU1MN0kvMnZucW1FZFgzaWJE?=
 =?utf-8?B?bHc4Zm1OUFJUWFlCRjRSRncwR1ROZWFhM2xTT2swMjBrK3BhUUhCT0ppVXkx?=
 =?utf-8?B?VDhjRDVNdFhCeHQyelBsZlpWNmNnY3Z3YXV4RUpZLzlBbXIrUHRrRi9YQkp1?=
 =?utf-8?B?NVBvUWdVM2czRE5sVDZnMSttOVlTK29oSkRFSHJVakk1dGlGSVd1ZFhiSEVt?=
 =?utf-8?B?cU5wMHovR2tzQ1hlUCtwS2RXdzVYeU9DNmt2bWxiVTJmblNIN01WT3hrNU95?=
 =?utf-8?B?cmtMbVlkTkNlZmE5dnlJRlV3eU84THJGM0RWamNTREZxcVdxWHJSRkdHNkZy?=
 =?utf-8?B?aDBoaUZNZU9raVRGMDg4dytJQTFJQW9ZNjEzcXNuMFVFM292ZDdoRXI5Y3V2?=
 =?utf-8?B?bWFZY2NMaDg4d25ZOVFKUjh6VytrV1lQVDd2cHNUMTgxaHNjUzYzUm81dHRz?=
 =?utf-8?B?c25aVnVNc1hOdk9mMXNXMCsyOVNtOXdHQXdGc2I2ajB0S0liWmtDc2ZpRzlX?=
 =?utf-8?B?YlFHVW5GVVNEQ1YwTnIwSWlNeHhHbjYvYWora1JCSGI4QnNGMUUrajdWU2Y3?=
 =?utf-8?B?R2NBdklVSlRvZDZzZXNhd2psNkNOcDMxNGh5eGVHMzF1ZDF4VzB5dFNWMWNW?=
 =?utf-8?B?SHNsNXB3YTFNZlAzRXlhYm5SVXVvLzhydzZidXk4WDZYRGtFL1J2amdwSTVF?=
 =?utf-8?B?NmVobUd2U1N1d2RoWTJKbmJOeHRFN1ptTTQ1d2FpNG1zbWVrR2o5QkxuSy96?=
 =?utf-8?B?N25nRm50Yzk1NGtwY0lyMXFWQ0RvemZpdjhvdUQwbTRrZC94ejQ2QWlIcnYz?=
 =?utf-8?B?ekF5K3JhY1R5MURFRHg1VVptWTAycXZtK0JRVE5LMXNFQVdDQndMMDh1NGFs?=
 =?utf-8?B?cHk2RENYanlkaEd0d0lFZVhSUW1tTFJYMERlYWxYdjFNWXNqc1MvRUU1cFhZ?=
 =?utf-8?B?QllhSHpYM3VncEpWTWQydDZiUFNXWGRsM1NiQkg0blcrYUlkbUhFN0RzS2xH?=
 =?utf-8?B?eWVDeERnYjBIS1h4QXUza1R5VzRqMmJGa3JzZWRlMGd4MitpMzZWZnBKRWo5?=
 =?utf-8?Q?rk/QbZ4EY3aZZ+UbOX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: euAaJalr54MqC7nf4TvBg+iuKi1vNA3Rdv0OFF8HcgAzudqElaBG1mQ+IcqyB1zFsad5JiEP3nOaPT4Q77bzRiHaRQU1lmFEIxPIOfRWPAsoErOQoybHc3Ny5jJQ7K/Hj1zJ6ZN+9TCaHVC/hnZRoJFmghygko2Hm4q/RBhQuJXkKchLipuocH0KCrG2wzHcgF65ABR3c2rQd80mT7wc6jUNkMTU4PvElaPIlUTI3T+b32LOVfA67r9gmYKxLEAPFvSpWwC5z/+LauMELEYMKnpRrvNBTCCKbzZqFRLT3auOWzvnhdwUUVS2MQIzqLNQin1+B3L4y39+u8kVs4SR8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB5433.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3329178e-1666-4969-8fa2-08deeace2f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2026 04:27:20.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuMFkJux5KiCiXFenu2jW+6jF4SfwI5urEFjeuHx/UFLsImuUyUOqWljW/jMex146oneRCoe8csvnalflxjjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5887
X-OriginatorOrg: amazon.com

PiA+ICtzdHJ1Y3QgZGV2aWNlOw0KPiA+ICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2s7DQo+ID4NCj4g
PiAgdHlwZWRlZiAgICAgIGludCAoKm5vdGlmaWVyX2ZuX3QpKHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIsDQo+ID4gQEAgLTE0NSwxMCArMTQ2LDE5IEBAIGV4dGVybiB2b2lkIHNyY3VfaW5pdF9u
b3RpZmllcl9oZWFkKHN0cnVjdCANCj4gPiBzcmN1X25vdGlmaWVyX2hlYWQgKm5oKTsNCj4gPg0K
PiA+ICBleHRlcm4gaW50IGF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcihzdHJ1Y3QgYXRv
bWljX25vdGlmaWVyX2hlYWQgKm5oLA0KPiA+ICAgICAgICAgICAgICAgc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYik7DQo+ID4gK2V4dGVybiBpbnQgZGV2bV9hdG9taWNfbm90aWZpZXJfY2hhaW5f
cmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgc3RydWN0IGF0
b21pY19ub3RpZmllcl9oZWFkICpuaCwNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCBub3RpZmll
cl9ibG9jayAqbmIpOw0KPg0KPiBQbGVhc2UgZG9uJ3QgdXNlIGV4dGVybiB3aXRoIGZ1bmN0aW9u
IHByb3RvdHlwZXMgaW4gbmV3IGNvZGUuDQoNCkZpeGVkIGluIHYyDQoNCg0KPiA+ICsvKioNCj4g
PiArICogICBkZXZtX2F0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3RlciAtIERldmljZS1tYW5h
Z2VkIGF0b21pYyBub3RpZmllciByZWdpc3RyYXRpb24NCj4gPiArICogICBAZGV2OiBEZXZpY2Ug
dG8gdGllIHRoZSBub3RpZmllciBsaWZldGltZSB0bw0KPiA+ICsgKiAgIEBuaDogUG9pbnRlciB0
byBoZWFkIG9mIHRoZSBhdG9taWMgbm90aWZpZXIgY2hhaW4NCj4gPiArICogICBAbjogTmV3IGVu
dHJ5IGluIG5vdGlmaWVyIGNoYWluDQo+ID4gKyAqDQo+ID4gKyAqICAgQWRkcyBhIG5vdGlmaWVy
IHRvIGFuIGF0b21pYyBub3RpZmllciBjaGFpbiBhbmQgcmVnaXN0ZXJzIGEgY2xlYW51cA0KPiA+
ICsgKiAgIGFjdGlvbiB0byBhdXRvbWF0aWNhbGx5IHVucmVnaXN0ZXIgaXQgd2hlbiBAZGV2IGlz
IHVuYm91bmQuDQo+ID4gKyAqDQo+ID4gKyAqICAgUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5lZ2F0
aXZlIGVycm5vIG9uIGVycm9yLg0KPg0KPiBTaG91bGQgYmU6DQo+DQo+IFJldHVybnM6DQo+IDAg
b24gc3VjY2Vzcy4uLg0KDQpGaXhlZCBpbiB2Mg0KDQpUaGFua3MsIEVsaWF2DQo=
