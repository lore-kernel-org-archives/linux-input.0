Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133541;
	b=F7iMdnNSY9nWeAj9umBVbOQDDKgRiZPfgogBTdYqgICrWJ31OnPxK/DOZycgjcQTglQD
	 ZsPhk1Y/Zvqsyt/36d1Yp+41+1zyhAydN/5FI5v+5vWRCkdPOvTr3TaZDU5muI+1LNbfl
	 OSDWuCJ987jKNOTUZajdPOfrYUITXAgPjdxWWpczWKua/0PmjHefM/jQci6C5cos/SJwf
	 JNolEaqs3ruf5b0Naae9bcYH++/jY21vtYIevpc6xREy3az2fcqosNuIhuJh1DWEqPopK
	 k+jVhj8uwNQhzmPGHDUKPd8Fj8kTFk1z7rZCEAa7fHQEYD8hEq8OLQ7qc7VBCK9X3Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133541;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=NvQJPDRTtIE/YL+kooujCzxV/jmLvfG7cEykJKdYzVg=;
	b=hc+HF5u6I/xOEyTQfTI5oHNhSnkmSXkTf0NyYKjBjxG5nN2u7RJavz8+ioHwbfhqsD4s
	 PlU4EZ7g/u7S6I9NAtFpoBxMR8MPxbEvjjGE4DJKGWdXDeL5ZGOUqHdBz7cCW1A7br3IB
	 SfK99Fh74BfppMXoCEfbtVp86E4VryO7vFVs+iWoCcHzs9HeZ3rGEOgvXUfU2OwZ5hKzp
	 KHqsRm1cgBJOb0HwQoQ7EFzZfWBIvanIYwaOEWFgeBCxM8Xxz7jT2gCiaMy5xmlrj2R/A
	 0/ygzKg2tKYJ7sG/vk9XSrO5P6Qok8iR0XWhAHXXGmm28waM02mmamcjmAH5C06cZeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fKLfv4Oc;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AvKX4Axg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AF606A320;
	Fri, 20 Nov 2026 00:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825AF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fKLfv4Oc;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AvKX4Axg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795133536; x=1826669536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u6pGMKvRpuX3P0NJOifo6vxNEq8reUSLAUrQ0hs8pso=;
  b=fKLfv4Oc1v7DI3NUjVYm+MdEJNOyp8aHdRrGiOjcA4PwcfeXb972TJr7
   mdhcB/mxuwN2sbSrk8DX2pIZCJmjtvKqsKxjqYgQsNsVDCaD4pJNmuE9Y
   HWzx9RF5HmzrX5ThUQLDkxSLFYJeZ8GDcXZTTEJSx7u2NoSuSUSfEIkYF
   dm3PxVHyMTAnwV7A4+aIfL6xU2BQ5VokV/uZIebXrWTn//Bw1uIb1A3vt
   LLRJb0DnVCSrhXa2gGEcVPmNrJCR9HpKOEXL3+iwjJZRGyae/UT2fmURw
   73Ff8y49xPO3sSKW9dk/akKl2+61WGq7VwY3jym2U6ipQzCAzXthfulVn
   g==;
X-CSE-ConnectionGUID: 9/0WjD3MRvul+HHzjppiiA==
X-CSE-MsgGUID: nKA5gWpzRxa3BXt5jxqd4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3888005"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3888005"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:12:16 -0800
X-CSE-ConnectionGUID: D83sO+zwTt+7jBV9zocYxQ==
X-CSE-MsgGUID: I3ZOMGaqTj6fAXee4gRImA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12550803"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:12:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:12:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 16:12:13 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 16:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJkGrJG6s9OZqU8LcW5xV24pG+PwHlXlqDa4UWuSQXkJsMtynJj8Xf2/W7ND6uKapZqih0raU0yuE077cSx3m98qNQ8xHEkEYw3hh4L3Ekr2yTiujkIaY/4xeM4Hs685H8WUca0jKipDOuf/9sdcOUZALxbwQzt1YNJvZ0vVIpsq4O4QI6WjFhpyZrifJwm6YJBqhJWcRPTglimkIXFsDf3KcYVn691jf6+iQ7VrW3mYX1j5cvFttu+LRu3RDQn5SknpRtANb15/fM0+5Q069+4/A6kcGs3WSGt7sji1VQQwOZZ4f2mGSj2KEJVisafYwLWu/d99v3cd6t4blTRrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvQJPDRTtIE/YL+kooujCzxV/jmLvfG7cEykJKdYzVg=;
 b=CXlxzXidXjgvEYoS+JsA2ZbJVzf9v1kzQQmUiqCcy7p82EczrUX4IvdpXypaOVy9+HtUdrNbeVce6mUVMnuXFhf6o2XAbEOfDjyeei5bxQCencib78kpHX2BdoxMRiYHVQ3z2Z0h84RDWzVDO8twV1Tj1yblCs+sZ6vjOjR62y2hz7WDghO/qyaL4xfORlPnLWq3XI/WJNxsjTQoHelGWRDx70FGX1F9DQqiNkvVV0qxVsTVUd7hCOykwu6L75OntTGQdyydFx91xw7zaDPNfahrkDEtkaqv5EmZKBRmcmMJlyRTalji+86QDmLIBNfh7xnoUc8RJJpLnQP3pu77hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvQJPDRTtIE/YL+kooujCzxV/jmLvfG7cEykJKdYzVg=;
 b=AvKX4AxgJQSSUDFhxX+dXPVsKyDzDgMfF//IYzwjILCtSZeut/EZbuwK0pUgIl3L7JTBXbkZ9YyWNQ32FLRjrWSCwImuREjRk1lWc7C47IpgwRpKwComVrlaCweW4vOJz2vF+Z8rdgZ+cb1P4R4tueW0ZPXVrHJ+xA8K3LY9EQE=
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 00:12:06 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:12:04 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Emfox Zhou <emfox@debian.org>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for
 registers
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for
 registers
Thread-Index: AQHddyoT3I/MGaUlD0KHoqaVIRUlMrc2GQSA
Date: Fri, 20 Nov 2026 00:12:04 +0000
Message-ID: <SJ0PR11MB7704039892CE43EB35D13192F4782@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261118065704.672557-1-emfox@debian.org>
In-Reply-To: <20261118065704.672557-1-emfox@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH0PR11MB7472:EE_
x-ms-office365-filtering-correlation-id: ebfb79eb-d604-4d43-ea90-08df469ae870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|261102123227099003|10067099003|5023799004|11063799006|56012099006|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261022105027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mUVkX9wFAuiFwmz8tzhBkV33aZSapPz3qcAHIoic7DgJI+qbqkNqMkcMMWflM2OKma2urEhpB3woyYdGYFnt87FX7D6jPE9x8x763kydsIf4gQiAUXSeHiOKLVzc/nHVt4xedipiAFjVZ5O+qFzX8qRy5adQT4JgojHS7rr+gURpDZ05njrwE76gHxIuO48/Ccn/8y1LC8APZ6Nwdns4lMFNre8QzZZyWWAWfDPFXbcMjlGavfg6RgdG5lSaX9yf6nQP/980WOg3upkq/5VXoXrT0+F0MQSQkSDfDP/GqM98fKpoxhzglVDCke8ZYF5M+0CIG9fTBX0Wl9Vc5E+vfhYFj20BNQyBkNmR6Prt5I0LlgLEraRvL6SUHP9shvqaP29ikh31jBiddquqAtDZalEJfDhs2XToTbHDyTZr8jvy3yAH9BqbEXRKww32ZCIezZsioaiQzl+QDs955j+mLpi9lrVDcCnA//y829VrrxxJGR5Kc/VlCufl/ePn0VL0W9QXSgxbW365vRX4feDRybHUACYBFT09uJt1ZMmqarF5RPa5efiYz/94mB6WXoXGpeM1H2xdFn8fugrFGY7TBpb+hAwrm1Mq6Qqy4EqNIVyehsrDxlMeqfy461aMhxMY3+mNO+wM7AdgHXEKlnjpigh5gIaNaC4piQOIP8U93BClZJ1PLoZDSOudM2FZkKV7UPaH0HDnsNzMq4m9XW9Fo3XlstcvGLsq8OvlFi/BAJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(261102123227099003)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261022105027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wHPaSY4i+ss1ObLiZCP4l16KvZWsjJ4F4MS//wrvZutuQIRh2wqlsBOjKL5B?=
 =?us-ascii?Q?0Lgk2qtMjwv7e2Y1XODkGN1jpkg+fXc9Yjnzsu8DBgce4QSlCkpPgc/D+4hq?=
 =?us-ascii?Q?wTJKOP9o8xZ1HnEuRuvpsWSp47O5LxtGCc4TQh08EK+Jw1eY8S4A9/uAGvEd?=
 =?us-ascii?Q?ZftSKLyCQP7ypfwYo6XEf3gpF095+e/S5mgo+a9GHltI6keErY+fy0GOwile?=
 =?us-ascii?Q?MwYhFN5mcIZJxQtboL8qemhctgmQeq3SBvQ3r0naR/MmYIJzYOvbgAcn4HHW?=
 =?us-ascii?Q?l2vze6OXmOm47sgDVJ50sxW85h8dAigy0N9zKehpARWpXWhJf32+lSKby0X3?=
 =?us-ascii?Q?QvJmkCmPs7eXgPmfj6F7BZ0yXCeoeOiLvE66xEwwbNiiNflY4aIRqT8kir2c?=
 =?us-ascii?Q?B6U1kZEsmvPDjibu7A8zSOnOP2IpHfBbNC/iBuuBf1uhyAUo23Afso8JhYcx?=
 =?us-ascii?Q?64OUMuPCAyraVJTBC4lC8KZuKHjaBNGIqUeVzkdmMt059V4mK6PFfItnoNUO?=
 =?us-ascii?Q?YvluFU5h5l/HQ7BiByYpntY5tPr7BwhwUFRfWYDPrsHyBeGq29y+UIrZGVr0?=
 =?us-ascii?Q?3T8wc/OIqttabj32bPoK7nBqfkRRm4dOWkUdS5XTt3HB/LR3NPpc8fTfyzfd?=
 =?us-ascii?Q?86nw+2I+Uk3Rm0d4pTjTkEuIpnAHplPGjRT0iKBkFa3YzkoBfjod9r9GleAh?=
 =?us-ascii?Q?JK5yRikcMFN/MME/vnle20pHEwuqQQ3HiGeX61y+IQOyICMa5L0/vxR3qYPt?=
 =?us-ascii?Q?lT5xk+zM0C+rHO2U/+yZs3eR48hKMTp1Y/rMjtC+vrsl/wbr9Wy6O82aR3ZJ?=
 =?us-ascii?Q?dTeI7rXAuZk0qSXgyqoGPw1qVKgGWYM3lY/uuYh31wwBLDjGFGMaZlBD5/+7?=
 =?us-ascii?Q?oBui+bHlrHHjLm5QDJ5mqzdJr7zUBI1ldNf5tthsltfPK19Lh04B1VCInQXi?=
 =?us-ascii?Q?h42ILDH+MaHvQyeVAP/y+hMm1yD+QDsu9l0peV1UlUBJWNhRzpB6gRngE34P?=
 =?us-ascii?Q?unRd+4SAkAyYYrG2k3tOMxecNn2KcOvV1pmkncng929V5y1bmSKns8o6P3CS?=
 =?us-ascii?Q?62w09fpNLk6HnqNk7Uxhn7NZ0K6sa/EN6IB/m+7+I8dclnJr5KhDgyzCQht1?=
 =?us-ascii?Q?UMgtWojGg2iAPUW66+yBX5099snc/YfPFZrmyleHh2PzTMzibwuUTWtosoPG?=
 =?us-ascii?Q?u4K8vXgBRZWFcX3mHPXG3prgEdOLMFlY2cFd7Ryzi4Wv0evNQMG82l5zNq4g?=
 =?us-ascii?Q?Gyw38TTwurd0yCJQ5jr9ffhERFx4JCNmxCoRgroUueGh3mrO/sehHe783W7Q?=
 =?us-ascii?Q?Ngs0I9r9vkJ80avkMQ4sOdNBFC9WypKfH8eeE7eM6LXkwtTSZJNGhrY3H2oN?=
 =?us-ascii?Q?tKpzx2tubtfiqUwRpY5AzZaLBzLmYQ8Pm96EUMJ3TlhllibqbRke20a5/JGJ?=
 =?us-ascii?Q?rrUabJLtCxsN44ON59d7D3PZI2je2sVruM0oJDn7MyBEbJR5skWjKB4RKbPj?=
 =?us-ascii?Q?3311JDuPUhGZipaecDPE9aefyVBcJcNTCd73hHN6Ckqp1yUxiBo2JXRa5yus?=
 =?us-ascii?Q?7k0g0kzkJ1+OZp7XcH/sls4DIhObLmo4NzwbepcLoFylDGNLNkfIKPZCMkuL?=
 =?us-ascii?Q?hdIxcpUA3Zk66rFV9qQtTnHe7ifwS05/Qko66FlLpwQEowubGD297/gCMQg8?=
 =?us-ascii?Q?wa/96O/B1cXZRiJ90tnH+o+6Db8CBaPTC61yBcfynEgJjYuP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C1PE/MH3EkZK1sl6uI455gGGA89Nb15+CY156MLUFtBf33Y2Nns+w7GbgMhCQW1LW76v1O84g3c2Bjgwdp8w8emxtvpN3pGr3BBkWSm9Rs4ANfmb56HWurv9mHuZtu1YUEnusux2mXusQEhynZXOq2HVi0ezoFrL5X7nU0mQzK6hbS/+BiXK8GPJs8kPwc/RxcAHayfQY2EvB4z3EmqlHUjhU6SpGnwZ30YaGz4mgiO/mDsUFRYUR5MeZidtLMzK89k2ptMlpl194TW4216abtJzyJ6UO53qTUXhODHsTnD08hoAAsJA7yretzymeaEt7iYkBoav90YSZQ6I+IG4lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb79eb-d604-4d43-ea90-08df469ae870
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:12:04.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkSX6PSPaTr9GKIRiDbNAlX0rMdt6aBGUG/Qv9S4fO4uriBRlSIje5qkkNyiqpgHjxXswiViKFC4i46WNNUmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Emfox Zhou <emfox@debian.org>
> Sent: Wednesday, November 18, 2026 2:57 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for registe=
rs
>=20
> The primary interrupt handlers of intel-quickspi, intel-quicki2c and inte=
l-ipts reach
> the registers from hardirq context. The map is a fast_io one, so its lock=
 is a
> spinlock_t, which on PREEMPT_RT is a sleeping lock:
> taking it there is an invalid wait context.
>=20
> Ask for a raw spinlock instead. The accessors only touch MMIO, and the ma=
p is
> fast_io precisely because it is used where sleeping is not possible, so n=
othing else
> changes.

Make sense.
Thanks for the patch!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
> Signed-off-by: Emfox Zhou <emfox@debian.org>
> ---
>  drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/driver=
s/hid/intel-
> thc-hid/intel-thc/intel-thc-dev.c
> index 7feda4160..e318f26ad 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> @@ -49,6 +49,7 @@ static const struct regmap_config thc_regmap_cfg =3D {
>  	.reg_write =3D thc_regmap_write,
>  	.cache_type =3D REGCACHE_NONE,
>  	.fast_io =3D true,
> +	.use_raw_spinlock =3D true,
>  	.rd_table =3D &thc_rw_table,
>  	.wr_table =3D &thc_rw_table,
>  	.volatile_table	=3D &thc_rw_table,
>=20
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
