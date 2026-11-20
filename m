Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795142850;
	b=IxDCoJfOQX3ZMSn//7vcGoQweRGM1cbxRCEK4yFjE4cRc25XrT158TZSJkF1ViRy71EW
	 WoCpmg8V19ePzmdHYddHFbAdMMo+bMGK96+68Ta2bI6ECOopQP6sKFCak+u8tHmtEeENX
	 wTYi8QdTrRTbg62wTzmTdW4E2Uwu+McoigmA4zO0E2K9v03CyKIUoZmPT456SBWGOr8F9
	 hOg5k0o5LICnofyvw5ylzwHPRalcQ4muvI+ypcDQvLMPPJIO8KVkOfNBCaBwuhKf4pHRr
	 Kx8sAW1+P+gV4WXY359QLSt8+IW/CgJJgozr4o2QfFOmFgdzspyBWVaVTQscApAZmHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142850;
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
	bh=5FKj030d+oNmYckDCh9k3T/GGTB+8rCJ6BJuiBkF0WY=;
	b=HOMrt42o5olOwWO/WoRmJkYPwrPbOB7cmVeBmc0/A8Do4BY2jJMGjd77vrij6THi2PZO
	 vy6Ka0xxlayKAjzQTJTjHPF7ajPjfdZyG35nKew6r92DBcrQ6N7Y3R4PzbsyZmus92Tp9
	 4ODfZahGaiHY/oncKUBoZWk4iakJJ7mAfOZpAJv3OWRTPSiDD1RpYVbHizrfFcrRQCp+F
	 Ys9EPHMUDcX2r2PGgDdpqT5RFnUAVx1OuzZKPzb8MjgmRxKql9MZ6B5vDxKMTN5DlIvRl
	 kDwg/fkpsXaJ+vWjxQwc7mRsm4Qeu16Kn1/RJSb22o7zw223csugqWDlZ9E4JLdJssQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pq+U7obR;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="mSpk0C/3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8D606A325;
	Fri, 20 Nov 2026 02:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D8D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pq+U7obR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mSpk0C/3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795142850; x=1826678850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GxXZ3pZDB+OBxfbE9URwYtDbIMXsbUvQFw4YQstXZ08=;
  b=Pq+U7obRwYi7uONJ/sqS+5ZlWvdAVIodt7OZwFqPC0lfC8OILCVKPfYP
   ooN1jjrjR/kvMbEq1cuYA6/KihhUTDVsAdrKpTUQyETRnAuur56g4IEEH
   /YXZZyoCu5giuUQdRXBZf7zDgToO8kI7T7Klzd9CXhG35F6KT1UFCsSdI
   y3qRVawt45PEbdsPIzNSfsjiBcTN8KzuHdMPfotydKem0ZWDk4fbgI9c/
   RlLd/H58Sr+Y4SkIhhXSHIeugSuJrS+mhCcyCUYeKdnX2BLOWvyR/Lcq+
   sOzsR/9ac7lZHsgXFFSODdQEZkUQxvWHpljsTGlovuwIH7HGapkJGQwas
   Q==;
X-CSE-ConnectionGUID: VP8fuFPkQMSgPLBq8P2Cpw==
X-CSE-MsgGUID: WBbz6ShuTjmLZHZxtrKaEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4115728"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4115728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:47:29 -0800
X-CSE-ConnectionGUID: ZFN8M/1BSWykYKSJquGf5w==
X-CSE-MsgGUID: r+f0YL1TSBS3uEqI5jYdsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10412904"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:47:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:47:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 18:47:27 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 18:47:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkcDgKxlCDXZ6/1dEtmV5lND0l7xFleTDiW4ha7ykqB0qHFok5Gu3+7m12S7uxbk1bWC7GooJFYfD+cDuV8/BAtlpET8C67EoPXlgVoX8C4fP8UfqdLt/EhL6/3hoMWJFb3x15AagZQ3qsXPoTPz/25kD0UQt6BaEcsd2gWSxoAGxnQ2viQM/kxAJfE8yoAk5XgKS9qPISFjFCQ25RtangrG+aRgEbHMCLBFY+tj0ztYOVhRX2jkZH1j6GTXFT4CrXazJIyMWUhKoFFBwdcx4v1lz4wlXosZ7r+2ZlRJh3z6867xvgokyM+Z6x1rJDX6JUQE6P1LuCO4rKEl29DJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FKj030d+oNmYckDCh9k3T/GGTB+8rCJ6BJuiBkF0WY=;
 b=OlKF3IBhWG9mXlphpUuT+XlBw+3vrLNKNV+lOwrELqiKWJlGQJKWKxxuOg/9TfphSYQlJLMvWmfUUQ5k0I77RPdIyYuWWMk9d9ukGpk59NPEhLi2h9WF9S+UtXtkXKYTgVrnvdhwPKyuBugygDze41Xnij46wuxVC9b6PrkrB9S3YGGf+O3e+zJcA1vNjWixsvr6b4/8cTYf3NggSAH1geG7gSUcvO758W2/jiZDksfXjMdplzYaab7tHHq1VonLpWY36JL8usj+3apTSsEsvRRHD1MTHkMZpo9p0ksl5N/eax7n8FFl9kRVXSpjSX5Pzb51SZvc13XlimUaoQXz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FKj030d+oNmYckDCh9k3T/GGTB+8rCJ6BJuiBkF0WY=;
 b=mSpk0C/33v53MHlVHvPRmOSYyDDJ+Pc2WibbxYbJPBFwB1NurLwLRG+fzewRDsrrzqcuoYCCcVzUzyfISggmQB7u+X9KhwKvSZ//ydfjO3P5o/LmVF+pEHU2DQwrTNlOkFjdcYK+yk/469SH3F4QWmweRHH86N6iAIivv16UgYA=
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by DS4PPF641CF4859.namprd11.prod.outlook.com (2603:10b6:f:fc02::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 02:47:22 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 02:47:22 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Emfox Zhou <emfox@debian.org>, "Sun, Xinpeng" <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS
 ports
Thread-Topic: [PATCH v9 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS
 ports
Thread-Index: AQHdeAYclKQaiBUpbU6meysbShCEQLc2QWYA
Date: Fri, 20 Nov 2026 02:47:22 +0000
Message-ID: <SJ0PR11MB7704C0830972D20A640C57D1F4782@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261119091152.470384-1-emfox@debian.org>
In-Reply-To: <20261119091152.470384-1-emfox@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|DS4PPF641CF4859:EE_
x-ms-office365-filtering-correlation-id: f7b33a57-47e2-4058-0989-08df46b09a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|261026130827099003|5023799004|261026121527099003|261026140227099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261102130727099003|261021130227099003|261021135927099003|261009223027099003|261022113327099003|10067099003|38070700021;
x-microsoft-antispam-message-info: Y6kiDwWm6zN7LXdx5BvflaHCZTCJ5PIJQC7ITgLyF16Iglk5KWKbViOV6cbuiYtUVuDAeN0C0GbDwi1VuHgOdSb9aDASb2i2nT69Ik53jF5c1nYTlTYAPep2f+aKrT1NLdFCa3XlMsesb3awgAB4DRW51tzX+0TCj3aMXP8joJfbDBDBByLnSgejM7TpWghTxnANYPCrAV+QDnsOLGmGfYexhuESUrO2YZ8xPdvHIAE0RlMLuFgK3jLaZY8bhZXQsWz60cJ2yEoXa9wlRQfUTsF5NRCPxWN8ecUJu7MQoWCQy9tQfAU3DQ7Q3SpUbloxcJ20yxuWztZflRFlUmUW5OoNqDX6oq8IWbNm/dWwA37jDRhm4SYwLiDtRGQSXjV6km/EE0E/Dzu57KBh72QfCEtgJk932VP8fl7vz7Wg3//XXPQOflvX1bYwS0AmISekQFSl31aTlLnafKdyYK+7E1kqz1cEW9DjYhNssuSBf+CESeWDPj2aNZU+N0mBR5/I9u6K2gWgSyanmAu48KG9SdpoyJYaYaA42gcNzLZ9PMq8nmp44Z7RXdF/hM9hKp31N1GX2ZGcKXismNzmb/ZuSDJ36P/KAHhDhBPvYx6EyiIAvGqyGMk5pNQM4Jzct2cg53+UfjsT2LpI4jNbXbXW7bf7H/4sLYMW7ebpJvXXN/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261026130827099003)(5023799004)(261026121527099003)(261026140227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261102130727099003)(261021130227099003)(261021135927099003)(261009223027099003)(261022113327099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J9cEW3cFK4VgZgpVATOL/+692ILfzbE7S4lprXSaj8TV3m8ebkzSCbul4INw?=
 =?us-ascii?Q?en2hi4GWkNmTQfsw8Ou4Vzq1MlJBFYYWhpPPx6owKlmfg7AHMpqle+73IPlI?=
 =?us-ascii?Q?I1jsOunobMs63IdCpGuwLlTzD7gzOfxY/5JGzDrvPO/Idv8ZsdyRt0dHP4Bx?=
 =?us-ascii?Q?Wo0S1m4OeQz7/LHB/K6mVwE54N6e94wH08t85VZEY+C2OcJOZDjHUulZYbnV?=
 =?us-ascii?Q?q6eVxIBXmB/96dTu38UEuruU4oGGCBbI53ktnPMa42cjH57jCvfDt5gyM3e3?=
 =?us-ascii?Q?cm/T/GaUqjsc0J01C7/QkWbggh7Hr18AvrHCxxz5sCuhh/sy7/emyHqvfOXn?=
 =?us-ascii?Q?51fcDirl4qlDPsK0XLYb9JfgcYawtAbIw3Q0/Lyx6WMcCQF9EZsVRcdXtcAS?=
 =?us-ascii?Q?SH5IRr7crE3pinz/qdKPTqAjhd8Dg1WzVLvwL4c+0z8XWbGWduL32//GQz1B?=
 =?us-ascii?Q?sJC0dTU8HlmZFMUCfYGNHMOUwNIhKQUx0/jfYfPC1lUICqB1/AjqrNiLjnVt?=
 =?us-ascii?Q?OLuGmJZmvK/F3D99P944wW982mJFj+v2RrhB5XoXr5BHSo3WBymX7AndFig8?=
 =?us-ascii?Q?JIk7yHuKx1yExgkOl12Ei53UIGGfnLVJ1BZ2B6rxDlbcmQuiDsGcolCfZKMZ?=
 =?us-ascii?Q?c9ocx/lh7ADSSIWSo6RzNpyRJOOutAKPh8oOCRh2jQCHtWQeAWADjS6Ndwhk?=
 =?us-ascii?Q?goR4sgNq+juNuEqdQzM6Xxr9FKm5+VXWmyTeLchu0GlsHzBtEBKAxpvBaGme?=
 =?us-ascii?Q?s9H4hJmNcRZ/LW8aDrhYzE9/px2LRJZXCLY0WociD4ps8Eg6yCUMw2vdttzQ?=
 =?us-ascii?Q?8DUn79UPDhMbVIgJIcefvpJNzsJugo/9zes5cOc0Jxo7hGvyBknK6vA4WLL2?=
 =?us-ascii?Q?0BqG8IPrMc8MzJ52e/W6k06JbT4xKd/4JAtGsWIR/1G+8UUE22cW/5Qa0j3t?=
 =?us-ascii?Q?LqDPLFgIrl0GKbSp8aujhBuldrMq3QeMOIfUMcPOxkkybUnuA88Lh1cIRPVm?=
 =?us-ascii?Q?XzvMVTQPNh/Y6kgCSsC4+vL3f+qRm0aU5zumwepczVYRQ5XYvCb/7xTG9vp2?=
 =?us-ascii?Q?kURCkgUnVVUPuhN2oug/cCXnzOy441zS5aFRc8lmqhznlJ5pDGf0ikqODtjs?=
 =?us-ascii?Q?hVy39adUlFgCEsLo81apU9Fb9P3Jlm9R0royiNxUIZoUT4oVJZGj+7P1gIbB?=
 =?us-ascii?Q?c+dAWkfbzChon98jHXCFfPwLJlf+cK11KEvO0XGj8YyLqRW8I9uuNWm1ikSQ?=
 =?us-ascii?Q?cZM5SFaA4guzZ2A/RMa6YenM8yX9Knn1ffrK8AD7n5pYkOAkBaRlJgAS/sK0?=
 =?us-ascii?Q?PE6+0Zg7/3/WYW7tgne/NwJe+r3OA72sip7PvpMPb/qaez6L+nQfWdgW57Tb?=
 =?us-ascii?Q?/UqAu3W+yIpiqsqNV+uUug2ysWHbfLaTnL4GzG+3cp7J0oW6etojHCUdRPAy?=
 =?us-ascii?Q?QWeI+If6/8nwEG3dIEWWK7kxt98Lypu6xjU81NN3/faNmh/vaQbnw8DNVbq6?=
 =?us-ascii?Q?fydUQOX7+MHHjzZrFGPLY/kMTiUTo0peQebLtvtM3cPIuc3LmbBRAbhTjWc/?=
 =?us-ascii?Q?MlRKCUva3x/1phbqKyhDi8q6QnrjC/PV2mXEWa7JvYjOYficlSjVezAsmWrs?=
 =?us-ascii?Q?zIk35gtLaMxVLEAQZRQzmaGbKJRXs5GjVzxwoNYHdkFQWQOhoprqwt97YZ9l?=
 =?us-ascii?Q?NGWLtJo0UV90jpJhGbnWA47LgXnsb/blKO52d+ImJeuT9H6n?=
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
X-Exchange-RoutingPolicyChecked: U+lJK6+i6d6SKeLgFf+RE7CTZB8dVio19hXqhRWPX0kRd3pxMmME1u94dKNRMzP96drR7HyGVzuEDnDO3ZjBgEKKqj0kyv1Gza07qxPboN3AXXFdLn0g6/7Y/0WSAdOIIwQm00u+/SJGNO8RCmBuwuwSU+O4new+Ajua2aG3bd4JywQIVf8MfxoqD/Wad8tyAHUlmKNLy67AGGDb5iOrtCsXQYZRjcOnWI3yWMoYVkm9scRsDC9X13fg7uQPRvmPlHZZUtve4SE3NPrMODTUK4HjgDcbNUd82nyQK+OwztfDO9FxNRoznX4JddtCfAPP5sOWZegJukAQUHh/gr3Efg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b33a57-47e2-4058-0989-08df46b09a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 02:47:22.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTjKs3G5H47dk7bmLcvHnCS7s5Uhb1i2AQaAFwsvQvbKo+hK+H5n6fS/HAcaf9U9myel9HeG/3ubWSiPCSSa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF641CF4859
X-OriginatorOrg: intel.com

Hi, Emfox,=20

Good job! Thank you for your patches. This driver fills in the remaining pi=
eces of THC.

I've just reviewed v9 of the IPTS patch series and have a few suggestions:
1. Please separate the code by layer: put THC hardware-related handling in =
intel-thc, and protocol-related code in a dedicated ipts directory.
2. Please reuse existing APIs where possible. You can modify them, but plea=
se maintain compatibility. For example, the APIs related to quiescing and S=
PI frequency appear reusable. There may be others as well; these are just a=
 couple of examples.
3. Please group the header files and keep them in alphabetical order.
4. Before sending the patches, run ".checkpatch.pl --strict" on all of them=
 and fix all warnings.

One more tip:=20
You could send patch revisions less frequently. I noticed that you posted s=
everal versions within just a few days. That doesn't leave reviewers enough=
 time to review them, and it can be unclear which version they should focus=
 on. Consider leaving at least a week between revisions so reviewers have e=
nough time to review the previous version and provide feedback. You can the=
n address their comments in the next revision.

Thanks!

Best Regards,
Even Xu

> -----Original Message-----
> From: Emfox Zhou <emfox@debian.org>
> Sent: Thursday, November 19, 2026 5:12 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v9 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS =
ports
>=20
> The THC ports on Tiger Lake, Lakefield, Alder Lake and Raptor Lake run in=
 IPTS
> mode: plain SPI with a private framing instead of HIDSPI, which is all in=
tel-thc-hid
> handles today. This adds a backend for them next to intel-quickspi and in=
tel-
> quicki2c, on top of the same core.
>=20
> It is based on v7.4-rc3 with two core fix series applied, both still unde=
r review:
>=20
>   https://lore.kernel.org/r/20261118053132.253448-1-emfox@debian.org
>   https://lore.kernel.org/r/20261117105420.318995-1-emfox@debian.org
>=20
> One gives the DMA engines a lifetime, the other keeps a PRD table from
> overrunning after a reset, and the recovery path here relies on both.
> They overlap in intel-thc-dma.c: apply the first, then the second.
>=20
> Register, DMA and interrupt work goes through the exported intel-thc API,=
 except
> in four places where the core has no call for it: the reset, port-support=
ed and
> quiesce-state bits of THC_M_PRT_CONTROL are accessed directly. Nothing
> outside the new directory changes except Kconfig and Makefile.
>=20
> The hardware facts - port IDs, configuration block layout, frame codes an=
d header
> sizes - come from the ithc driver linux-surface ships, at
> https://github.com/quo/ithc-linux 6d53c9c (dual licensed GPL-2.0 / BSD-2-
> Clause); no code is taken from it. The layout, the frame format and the o=
rdering
> between quiesce, interrupt configuration and the DMA engines are the part=
s most
> likely to need scrutiny; each is argued in the commit message that relies=
 on it. All
> of it was confirmed on a Surface Pro 8 with a 045e:0c37 controller.
>=20
> The first four patches each leave a state that builds and loads: port bri=
ng-up, DMA
> and interrupts, HID registration, system sleep. The fifth documents the f=
rame
> format and the IPTS handshake.
>=20
> Link to v8: https://lore.kernel.org/r/20261118065725.673090-1-
> emfox@debian.org
>=20
> Changes in v9:
>=20
>   - The reset count a feature answer is compared with is sampled inside
>     the send, under the lock a reset must take, so only one that started
>     after the frame went out can change it.
>=20
>   - The interrupt is masked before a resume brings the port back, as prob=
e
>     already does.
>=20
>   - A failed reset no longer wakes the queue, which no waiter could act
>     on: the port stays masked until it is started again.
>=20
> Emfox Zhou (5):
>   HID: intel-thc-hid: intel-ipts: bring up the port
>   HID: intel-thc-hid: intel-ipts: receive reports
>   HID: intel-thc-hid: intel-ipts: add the HID device
>   HID: intel-thc-hid: intel-ipts: handle system sleep
>   HID: intel-thc-hid: intel-ipts: document the IPTS mode
>=20
>  Documentation/hid/intel-thc-hid.rst           | 109 +-
>  drivers/hid/intel-thc-hid/Kconfig             |  14 +
>  drivers/hid/intel-thc-hid/Makefile            |   4 +
>  drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 989 ++++++++++++++++++
>  drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 201 ++++
>  .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 201 ++++
>  6 files changed, 1517 insertions(+), 1 deletion(-)  create mode 100644
> drivers/hid/intel-thc-hid/intel-ipts/ipts.c
>  create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
>  create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
>=20
>=20
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
