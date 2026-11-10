Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290356;
	b=YwVHKPBKlLkhp+y87r1dvdJsYVRqGI/0YxWIEKvks7IDxem9WLKzDJ+pq+mfghh80T2g
	 +wHIMcGKMH735VPBvXy1iD3CGYK/Oa4OUoAU3wSdcz6exWieUU1XBgC/N7aQVYVyU7wrT
	 U9DVnmZV+ShQZdzaf0kLpt8PhdZONEfydvn9zW92d8NbAKRNEF2bt7Ei/49PLM2tXKjDC
	 WwM2+i/Z7IKwUa81i76+ifQRCREItfnVjvEG9aGhmrGt3oDnM4y/LXxW8AoYW0UEZTuV5
	 zYi+HXW6J2byT2SqObxWH98fX2HN9M95/ttJte7IqK6LSez4ST0+AQ/t999HNPt2EIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290356;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=9MqTu3mXlRJz4zjiTgsq3aJ3+tnAP8Gzcp8RKqeVR+s=;
	b=nfSFpy1MbgNaVnVzvL9/rPMWlsjmzI+ZagQupkPb4ylCV6DSFxR9KK+d9K4TQDpGM3d4
	 dXaEYXD8TSjMiqrW6DemjV/R5dCKH3NX99E3iTbtkJkzRgSL9BKFKQWM51rZxA7zJM2gN
	 8jN9KNyHJaKJ7+MWLzdcNPb6NG7Z2wxio+pY6HBu1NrxlYDjqwFJE68un6HyfMxWjzMFZ
	 gSEYm+6IVY0C0JSdTn5Yz8vP8K88egrraB4tEzq2uKlniWbAIac+P9M+rx8J3vYck2Y3E
	 jBpvd8zEUozMFyXlpzycdL403ViawErRi/geb1GXVQUbdv1ofShT6Yz8nU3YT0KKUOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="E/ezYysf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78981606A321;
	Tue, 10 Nov 2026 05:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78981606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E/ezYysf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794290355; x=1825826355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jds5NwXCVpaL57BKEC4Y/pgBg8p4+/r29QSoRYloK4o=;
  b=E/ezYysfa1Cx/AZHZdB9w+yhN7sL+Q0IvJfxuZIUAUGz0nCrdCyY6ZFx
   no0XR0IOLmyTTatYdoj9VHE3WnMAyWVVk5Qt9NznhupeOZSYQVePQ29E7
   ZcP8WYt4XfLjX6dd1+tjplM92pKiWedTc9EwR/VKqTatMHmOVlEaM/VPk
   odsMWuTh7+x9MrhMnF5m/PJdMHhp8xg+htqyFgrJowX4Bawfi3OamsL1U
   U9ZgL+5uAa8nGUK3dKDTKTRb9WUGaQ01GgQvjU0lMC2qnZX7gZwiO+AU3
   zDHHly4NTrrrkL34dmZBMdVDp2cdggc65JsVnvyUULHonGakLV/k4vOdg
   w==;
X-CSE-ConnectionGUID: sSJdFs+MR26k0FxhqVxn/A==
X-CSE-MsgGUID: 5E1rkE4MR9Oj/cMr9FNj1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3064273"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3064273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:59:15 -0800
X-CSE-ConnectionGUID: wOpaAsvDRDOy7Stz+AldIw==
X-CSE-MsgGUID: QSTNwrQNQUikRtpvvgx+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8209473"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:59:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 21:59:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 21:59:14 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 21:59:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTk43PJIv+7te3tLfyO5i9xAb1XyNRuV149peyGtgPkrcuulGIPzj7QGwg3ckF5UfgJqHJunHAcQK5sE+JH3XT98WLgVm26CeskTAZ3aByPgRgKU4dhWviMu82JC4Dcnik+DbdytlyMRUye8CtbAqfUeFbuf3TL6BoDjwVaHxXYhFmO5ITN6QYH19gpOBLowpRRvmj5NYWT+DtNOEYuMBgL7kKPrvimuKLSP9pjGuJ2V6SxhuWeauB7fEnPvP/7HYsy+UkHvIw2jXQh4BnV/zkz/4Z5U3+mGC5h+zcM1/CiAg3vd91e5YOEEWDKmGOD2MC6MV8jz5rShFCEvOVazmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MqTu3mXlRJz4zjiTgsq3aJ3+tnAP8Gzcp8RKqeVR+s=;
 b=G4XyNzhmIfukb8K3wQuIrCr8WegJOgmBdB1s3T9/uv2AvxGChe88PHHInw2S2ldwNMmuVwa7OdmQEQnM4UiGWhqLa/NwHXq3cPR/Rj1LTR+nHQHiBdGetp2ufEa+nSUP/88n0YlJF15JjN50Jlyx7sZNaHJn6aNmcFpzm9jzthdz11kyKc528C9cBsmo71pN+Eh0ZpQIYlltkHx62DJVEG6P5uA4Xi9Ey250xEQGGEJ3PBXIi6AePAkdsg2P3UsckOgfWm7hnM38t4ufM5O3pH1BOEtGiDKoAWvZkU4eBSrjVvYJQKYurOHE5jSzUA0m7euX7TitPxU3+fMOv3+4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 05:59:06 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 05:59:06 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH v2 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH v2 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdcM6esLzBuHpur02bIHvPC9Q5k7cmzkcQ
Date: Tue, 10 Nov 2026 05:59:06 +0000
Message-ID: <SJ0PR11MB77049249BC99EBA74E3875D5F4722@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
 <20261109-thc-rebase-v2-1-mhun512@gmail.com>
In-Reply-To: <20261109-thc-rebase-v2-1-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|PH7PR11MB7025:EE_
x-ms-office365-filtering-correlation-id: 6cfabbe9-cf8c-464d-b9e2-08df3eefbabf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: mqSnZccfTAfmCmhUxetEKJPi2wUCY99fxyx93T/K1Yoj/JyFnNw2+m1TO+rFohWYtWIvKRyVKYtceWiaMhUHC3qa5VgP99K79KkwFeYByt7vDgK3wpp+PFFSro0ZEtfxasYv/DHWKAZlwiwUZRh60bXmd3ETiE5bcPtzy4G4T6OCveu56tB1/SkAx7GWFKMwXJZLPnUMciSUUfyUnszeVle97vH6nFIaRZhimfU3OcCNUd8ucm8K6bu1ne9Vtrh0iOQo5iVE5H1ARujMUqtWPd3/Yy9ZIrz2p224uugwlyLdhqckzyEIyIuJ6/al5jO0RHxbKp6hSaki9oIqijaEdNyn+mBhdjld2QSS90WxgqNr4Ve7L5pIbutaTulW0HJqMIpFZ6DvTGniJFBqzf/6wx2hb46UJDiTfax8eBA3/mVvgjP2gSJOXpJU3WN31GttYriemZPcCaJHXeg34br4NCguIpf+s1m1Oa2ZgxJZCVVIcorXZvAIvfd5irT9mrSZ8mipqRd4JZzZ8mQRwi2nHmYC2DYyp3voQAbT1Ex2o8MMt6egioZ++IzAp0/FUuNKGtb+51mOXXWKRr0HzCnADqCamMOV0Wu+Vs9yXlPJf5d7wFa0krZ1yid0IEhRN2pSLtB5eXGd8Ao07ExZ+8gMXHis7NyS/Dj/UY0ikmY+1FBK7MT+ZFXrRPlvg3+PudB/La6PxwrFJczShQdszCkuXFCCAdWyP/6YvLHH7kldX9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhyHQfEyEZpYRMClhADorkYOZe8CjqEmTVGBGEC+ZhoZLZq6QVuvum2BYfk0?=
 =?us-ascii?Q?DSm2HaTaCK2enF2T1xslkEZarZsg+u9YCk0hrc08fz7KULCTgPTBDTgargzl?=
 =?us-ascii?Q?wrQsurblIt6UmG0ss65h8nfRBha4VrEc2nv64pXLp4AZRuX8OjltpVEfyZq7?=
 =?us-ascii?Q?DC6dOxFDLJK7E5Yr9EQAModQgc3uwVBG3NGoTgX3Xzn5THWpE8HC3UQUHmHy?=
 =?us-ascii?Q?0D5awR8DwdeXHq+cpvVR+37GgbvBvfK7SOYxHedcBL4zSFnBe9mc4IFhXh2T?=
 =?us-ascii?Q?JBMFNaWDgH4AEqw6f1O7eZk0S+LRuAgz9APiEmOP03ubpu0FUBdK+OjAAMBt?=
 =?us-ascii?Q?UkzR/mKV+Hx/ny2RBhLTW8nEEkjJ4hUjwIno5saoSZIrttZiginL8kxTNUAu?=
 =?us-ascii?Q?2x29zNyhgSv5bObSdYtNoJXPy2CEb3qNfwoLQDl96xEHzizMbLXwvz3Fm05p?=
 =?us-ascii?Q?eaSvR3LU86byqT3ygxMgKPhXJymiTLxKIPwoqZ8GXX/je1OFsQiTq9V4XCl3?=
 =?us-ascii?Q?eMAE240byW7Lrr3mYMoPoRQZJbyolq6QypRmeVe9yfofH3wJAjFBMQPmjLDw?=
 =?us-ascii?Q?dKdVj5S1EcmDQEkrC52eXiAi04b/JImW+3g1JQ5EJdIluoMXG60fow4lpDA6?=
 =?us-ascii?Q?qM8zN9nIwWbtaNvxnYTyL0d2DIHLKvMX+BFL3lAk89N7gQeMFqegWGBP94cJ?=
 =?us-ascii?Q?Sf7rdwMYDgWbSLX2aE/GIMErl1tAwsQFIJEInlb6cAwSug+3FE8y0CbGfqp5?=
 =?us-ascii?Q?NRKZ8S1N+65A9/m7kq0zPqAtEXZlflaCoZXtYnnMu3/sDDXeFF2cHXT+Hj0o?=
 =?us-ascii?Q?dSp+oUbvAs4K3oAJOV7YqL8jXLh7cMJFWJ2cX+x1Fq2zubqnwGDDaOeWJ6VJ?=
 =?us-ascii?Q?lJwKfRfy1a3kTyxX0OzNKfsQNHyen5RxPKPYVbi/V8alWzOpAFJK2KGzt8f5?=
 =?us-ascii?Q?j8MaKlIJy/f8Vg71AzgzhGRFJDwdsPJ4H1o7J5iMVFBi4GMxBLegwPRNnENT?=
 =?us-ascii?Q?elH5OXjs99c5dCDJ6IyfvK/lfB0vimHEtgjCsjTMImGgZN52M6dU4/0Ce8FO?=
 =?us-ascii?Q?5hjbwbuEcvE3cINGGsn2K1Kzc7WO4+L0asNr9PjSrhozPxP2vx44ZY66rIza?=
 =?us-ascii?Q?krxyDgLGgAsvwBNJg/Du0wETPW6oFx8m4VyKtSplg6Bpbm2WpMVbriZLYcdL?=
 =?us-ascii?Q?NcS1AMQybvjy6eAmUdbVz3I1Rc9hODBR+//ubHbqLftFdRwZMptuqIo7uCED?=
 =?us-ascii?Q?qqloVKcbG7Ahj4mazF5EH3Hkk4zq5ggyjs8tV0apWCQ+KoQLd2RUyo3Wxzbj?=
 =?us-ascii?Q?NPVOcmsSiPKvwGAbCb6mdpwIytm0bBxtJz6IyYPxVifBzPPUP9gcBIPCb07Y?=
 =?us-ascii?Q?/YuHTpfXzEsfFjR8ZmhRYyZBc9P3OK9mA3wneC0mcG8PLgvm5PPtxKjp4Oaf?=
 =?us-ascii?Q?Rv9F/AIqBBShS8TLaix5G4VvzqMkjSB9jrr/xZtQrBI45BYGQOB6+6jbeU4R?=
 =?us-ascii?Q?GhKV+YGw9AJV0cXuYt5D92XyIMUITQP6pLdET1rLULuzWMiJ6Xk0Oj97pizd?=
 =?us-ascii?Q?hMlvOsGhjgs6s9clLop+rjwRO0DjS909SRPuRuapbWKN/6sR5cWxdKAZ/rQK?=
 =?us-ascii?Q?HAxjwFy2Ac51n5YtjABjlWZMhQeAk16epH7Tkapjag3N8qeZY46fERX3puMA?=
 =?us-ascii?Q?PYbgzDgMwkL3ouh+Yi/giiE4HXUhC0hcj7aGUOaIIAd7XY86?=
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
X-Exchange-RoutingPolicyChecked: wd/QxLc0R/Ylh2WtD3Z7w2rQdhvacYPZDAjA2M8ecIqb80c5n68VCXF/qkwCeeenDwcudFVhzqiKzCZcxgq45f0uifvyJXjLMDnFqkL44CScE3irHZnJsz2oUOcxfxmjq1idzcAgEnzb9kAHUN0fA2PqkAmpg2qTeCYj97sRQDXPpPbaRnFarRBZKhANcltT/l/aiVMYLbEe0lwk25UO8i8wQq1KOsWvOkhZNwZipJ2YZ8oXD3ojXDtRCAYrxkzpGeGzKuqUPYebIFwiR+SPizRzXlsrkydbwSA51R7dE+UBecAGsCdxH0yH6hLUWHefQh6H0W7J9OyjXKjRHZGN8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfabbe9-cf8c-464d-b9e2-08df3eefbabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 05:59:06.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyE2IcVVnEIxEHN6moaQHRQ3DruAU7qSrFud9+Chlb8XxtZjigXVhBtDNMLkj4sYw2P9rDUySbFKVBkbVfvibA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Myeonghun Pak <mhun512@gmail.com>
> Sent: Tuesday, November 10, 2026 12:47 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: Myeonghun Pak <mhun512@gmail.com>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; Mark Pearson <mpearson-
> lenovo@squebb.ca>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.=
org;
> Ijae Kim <ae878000@gmail.com>
> Subject: [PATCH v2 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
> teardown
>=20
> The managed IRQ can access HID/DMA buffers or queue recovery work while
> remove or probe unwind tears down those resources.
>=20
> Disable and synchronize the IRQ, drain recovery work, then mask THC inter=
rupts
> before freeing the IRQ and releasing HID/DMA resources.
> Track IRQ/DMA initialization for conditional probe cleanup.
>=20
> Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and re=
lease
> outside the shared hibernation helper.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI
> driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> No hardware testing.
>=20
> Changes in v2:
> - Rebase on mainline b3dfbde62cf1. No source changes from v1.
>=20
>  .../intel-thc-hid/intel-quickspi/pci-quickspi.c    | 28 ++++++++++++++++=
+-----
>  1 file changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index
> bf49d8ce5f07bed092339e46c444538d78cffe26..acb4d2716ea7450d2852a900c3f
> 0acc1d7570421 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -600,6 +600,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *id)
>  {
>  	struct quickspi_device *qsdev;
> +	bool dma_initialized =3D false;
> +	bool irq_requested =3D false;
>  	void __iomem *mem_addr;
>  	int ret;
>=20
> @@ -652,6 +654,7 @@ static int quickspi_probe(struct pci_dev *pdev,
>  					qsdev);
>  	if (ret)
>  		goto dev_deinit;
> +	irq_requested =3D true;
>=20
>  	ret =3D reset_tic(qsdev);
>  	if (ret) {
> @@ -670,17 +673,18 @@ static int quickspi_probe(struct pci_dev *pdev,
>  		dev_err(&pdev->dev, "Setup THC DMA failed, ret=3D %d\n", ret);
>  		goto dev_deinit;
>  	}
> +	dma_initialized =3D true;
>=20
>  	ret =3D quickspi_get_report_descriptor(qsdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Get report descriptor failed, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	ret =3D quickspi_hid_probe(qsdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register HID device, ret =3D %d\n",
> ret);
> -		goto dma_deinit;
> +		goto dev_deinit;
>  	}
>=20
>  	qsdev->state =3D QUICKSPI_ENABLED;
> @@ -695,10 +699,16 @@ static int quickspi_probe(struct pci_dev *pdev,
>=20
>  	return 0;
>=20
> -dma_deinit:
> -	quickspi_dma_deinit(qsdev);
>  dev_deinit:
> +	if (irq_requested) {
> +		WRITE_ONCE(qsdev->recovery_disabled, true);
> +		disable_irq(pdev->irq);
> +	}
Add a blank line here.

>  	quickspi_dev_deinit(qsdev);
Blank line.

> +	if (irq_requested)
> +		devm_free_irq(&pdev->dev, pdev->irq, qsdev);
Here.

> +	if (dma_initialized)
> +		quickspi_dma_deinit(qsdev);
Here too.
And do the same thing for Quickspi driver.

Thanks!

Best Regards,
Even Xu

>  disable_pci_device:
>  	pci_clear_master(pdev);
>=20
> @@ -721,9 +731,12 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
>=20
> -	quickspi_hid_remove(qsdev);
> -
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>  	quickspi_dev_deinit(qsdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> +
> +	quickspi_hid_remove(qsdev);
>=20
>  	quickspi_dma_deinit(qsdev);
>=20
> @@ -750,6 +763,9 @@ static void quickspi_shutdown(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
>=20
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
> +
>  	quickspi_dev_deinit(qsdev);
>=20
>  	/* Must stop DMA before reboot to avoid DMA entering into unknown
> state */
>=20
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> --
> 2.53.0
