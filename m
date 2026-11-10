Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794288530;
	b=KrSch48S4cOhadPU5YmHfRrLCiFug/p0Znsv6z+KZ/Dl22B7V1z8Tlwwyth7yGxWhFYy
	 dw0NdGt+Q0nooEKhfL9vn1N4PXt406HPz8TWbNjBIlRN0FIB8+ogN07IsgQtmnNzrNnCz
	 F5gzaAoQ6PT2v4wTGNFFMlELYrbHcQB9PaC+uKXJA2cGYNyzVi+kT9SAZnbtAdQyCeUig
	 Cw8IzkuArESzGY+GDDTDlB+bRqsToaPsFwArnvXhBG3gXbqrnkQxKA0e5DJpNsZ6WcEwi
	 zYSO7vu50fStGslKHQY06ju58oRJ9T+WLps00JdKu1UCiUn/Z1DdsfWTkwz4r98EMAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288530;
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
	bh=YoYHsxnap6QEFCv8BcI/LioH6Q1pUJHAXaVK0CR2h9s=;
	b=Q9EEWebODapyMHCIfFOF5b8WspnNmV3l+PAI5H1XpSjuryi6AE7+EFjRdATn1IBr1CGP
	 nNbss2i85gzxhL908NSzzIKILK2GzOZ5c8AylvEp2qDptdr3NnWDiY7ZLwG0vY7MDN0C1
	 pp974UvtxRTiYvH97aTs9RCRHVa1heD1OYJ5nY3dWGpKMjaqgWxYreUsgQJbtInzeRqH9
	 +pPzhC9ULFo4mOTmAcM+eiPV12iv33DsOmpN+H6PKeZQYBxHmjE6c44F8N5xs8fAVQUKk
	 r0+FRC+Evc03byGYYpwsQGkDC2kWHw+0fuXiqFXel5RKFDHKr7o5rJJexGcD81ZqnBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C5+CbUun;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85E606A321;
	Tue, 10 Nov 2026 05:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B85E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C5+CbUun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794288529; x=1825824529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YoYHsxnap6QEFCv8BcI/LioH6Q1pUJHAXaVK0CR2h9s=;
  b=C5+CbUunLsuILe0uiMSEc+4DM9VVdq7uWYPxmTcqKwB2CfR97WwZ80E7
   cB8cn0o3ppydOZvRo9b74VM3ElVZ22ZLB3gqdlwdfSa0j+ViDrE8V+fYo
   fUU9N81IVa8rxytpm+E8F8bu2herfbc1v8xci0KFCix42WJLr5uxdql0b
   FtW9YA1EyxkEQtVYd3JJIP9RTqgSSYIve8r/mtHvpFbsiYCLmsEIcVT1N
   vv7csZyB/qmrbXK2GLOJzSBrq8haTJ2WhDmGQ2WpNNv9lVwI2+n4gAacR
   FoyI7YHAEUyfCPPwjDIv1D9PUMrHtupFEkxaYJye51UBY4JQFO6B73+F3
   A==;
X-CSE-ConnectionGUID: veYnl2rlTOyYPb3upjdEaA==
X-CSE-MsgGUID: PJY/ZI7ZTJ6RO4Jct93b2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2924355"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2924355"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:28:48 -0800
X-CSE-ConnectionGUID: hgu2jGqwRz2cg8rvZPRtyg==
X-CSE-MsgGUID: 72/V/3COQgiHfSQE0Yr56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8196720"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:28:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 21:28:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 21:28:47 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 21:28:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NG5bO4gIdv6nD6e8Mq7eVGN8XN6HjPWdGOKFSIHmONtutMDVBXz75pyl5LuF7sBUjE0NqJFRmxTItenRrfgxqZpKkGBkxqkY8rL2viEzKnajg+rxmojkry2iot1b941pnlV810/XKuTppRCnlO0TDUEHC3D5qTjTBH++GF59I7CcOGkM3m/6F13y0fjwUl7k1d3+zUS7pelZhvBNVWeadPvimBfDiZ2DePX3NZH4aT19Shdc6l1iDU7XVVMzpd2UWFAOAVNoGEswxARbz8wv/jUyOu5TaD0BVSkV7AC4xn6J+jvGAZZ5qiZIhBFFstt5yrh8Pa3F5fRV9X4upo1fXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoYHsxnap6QEFCv8BcI/LioH6Q1pUJHAXaVK0CR2h9s=;
 b=C4HjiwmujA4Re9ANBZCdLQ5PLU+a0VbZTj0y+hpSxgKH9gCSkDxnauZsLpkKntAbjW4ytdqUURNTkLN7LCr8u8FIgOdHKt0JEZ9x9tTrO8BQDX8KzJ7Xttkaszcps14vZ2TKZYtrg7ngdXF6g62+go5SfdhNx5WH74SMC+w/cXWIol4OsY3T/1bxhALWrCKyJfz5OOA9s+BAxtT3uSIJlKdLkQtgQEBohzqbTfAH/Jx8q+b+U993/R/5rVpjJDvvP2d1XFiqxW850lV9kVRxs3CPPfodeKP9qQMNxNi5aVCqsoK61VlfJMkUlgErcmgY8fYFYuoDICykAFBl1YgAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 05:28:43 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 05:28:43 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Topic: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Thread-Index: AQHdWcy4vOmMlsQh90ux6EsTDq93ibb6pUzggAMhZQCAABUAUIAS3vmwgBYtyoCAAAx7YA==
Date: Tue, 10 Nov 2026 05:28:43 +0000
Message-ID: <SJ0PR11MB7704928D8217712A1BE45CF6F4722@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-2-mhun512@gmail.com>
 <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
 <CAGEsz8H4z7cpJQkmFGcqnCT+H56OuUHQDch6kh13TiOo0b-TFA@mail.gmail.com>
 <SJ0PR11MB7704B813C9011D9478BA2BF4F49C2@SJ0PR11MB7704.namprd11.prod.outlook.com>
 <SJ0PR11MB77049F097D7061D769DE08A5F4602@SJ0PR11MB7704.namprd11.prod.outlook.com>
 <CAGEsz8HNs-bqB8we8+J8dHci9okethftp3tLbOv-b6Pu_FivuA@mail.gmail.com>
In-Reply-To: <CAGEsz8HNs-bqB8we8+J8dHci9okethftp3tLbOv-b6Pu_FivuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|SA2PR11MB5050:EE_
x-ms-office365-filtering-correlation-id: 7783b55f-32a5-481e-1888-08df3eeb7c29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: CD3QdiIp5a0u2dWtnVS1BjUvoZq1vXKXqW8PH6N3D8ZM40SS5h8TvVxS0hbWuWVDYFgKeCT6FrBZw0FjiAI8NeyLu0rnNYEPuzKvtrjfScWtKf8pcM6yd++lMzJnRCFGfGqewfHk25zPl+GwZF2BVazIejrxxeXtuwiDpF4+oUAaRVLW/s6ZlslNR+zBvFKC+fR68bmJTre3W8lk4GC/X2jQU5aLquj1uImkCTUNnvGi0jkRM6AWI6k9rnbbCWWJkW4esGfNrZ0liUqVtE6oJU/XliA4sXPX3N37O7GuIBlAUHvpkMShQzshWORWtr5HG+YYiNtbbdyPfv9/Pga3c/pxZN1U9AIrSdRPWF596fMPLh/TmBGboi6uXbhVCJhAlY0JP4Q4QxLKJ5DVsv3bPfm1aIIXu/HNq9F5KrhwCpgKOZ2ur6FSPX4W0hOx6Zk8sHaiSf1TPVhT+VklhUsfzfnNhU442imPXEsIX3uP7kq5dmHtpMjYbRev2dSDHF9U3Xd6VAOZOoJA+/p8ahKD1JNun+ari6NV6qGqMmsddJ5ElBbyjEk9R8uNI1w3dqSiAGvAPK8FA6i24q3fXWBIse9+3knPu+f8IlfMVWG76GhIxjOEQO7stUwA176dw77h2W9LJoVmXTFi6WJDjHEdQS6UfIOwdCY9n+v/h5iEkoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDJiSS8zR2pndXh5RkcrNGQrZm1rTUxjaVJHUkdEcENNazVHUkQzb0tvd3Vq?=
 =?utf-8?B?dzNsS2h3SFdGMWE3OGVrWWZxVGRuZkI0NStjUEE4b2N6K2xCMUVGQndBYWtH?=
 =?utf-8?B?anVyMjh6ZUpxQWhjWFRrSkZsUTVrWU5tQUZJaFJFNVVwOUNpdkRlNDZrV2Z3?=
 =?utf-8?B?TzhjL0N1b2lvTk1PNFlZbkJqcUpCaHJJTVNUcm41ZmxzZUg2dDNENWRDMHBs?=
 =?utf-8?B?M0U0UVdMUnA1ZXV6UVY4N2FDSnV2dDRkclJKaVF0b1RtUWhEQ3BkbVJaMEVZ?=
 =?utf-8?B?QlVUWUJwU2N4SnJGNm9IWlhnTWV6WU9VZDdhZ1R6blhzeGtlZmg5SHZ6ZnBO?=
 =?utf-8?B?WkZUYnBVTWpNSCs2Vk1zU0tkckZPYWs1cjU2eUlHNjQ2em43bDFBa3ozWUJR?=
 =?utf-8?B?VlIvNitkbzdWQzY3SUhVK2lsTTYvdHpOMVBtWE9SMVkxYmh6YmZtM3JpQml5?=
 =?utf-8?B?MTZWVUh0V05mUTZJaVlRaUZDSUpRa3BwbCs4M2pNcE1FOWhBQ3ZyUmhvQzE2?=
 =?utf-8?B?clRETkdrQnI0UXFvelcxZDRaMTVUazNLY2c2WHU0ajlQdlBDZlBtblE0OGZ2?=
 =?utf-8?B?NnlLQjNvZWllaE02MWVNM1pNTUNIWlBBcFZWeHNJSW9BbjR4NGJybGhhQWlu?=
 =?utf-8?B?VXJzL25YYXJXVmw4MGtHZktoSHk5M3N0bW8xdkJvWEJ5RzZuZVB1ODRCWnk5?=
 =?utf-8?B?eUErdzhEaGZXR0IyNGxQd2QvMU5ydVNiWG9nTFltVXRnRkhhMlNNcUZrS1Vw?=
 =?utf-8?B?K0tMQURNNDZnNDFxdkxaZUpKWkdpclBjNTBHZE1XY2RPSVVXS05zUjRUamFv?=
 =?utf-8?B?Q29xTVBBWlpoSVh6NWlTZGJIMHJWY1JWRXNiM2ZRRHFhUXdpYkxhZzlUUVow?=
 =?utf-8?B?RVhOY3llUUEreTc5S0EvZXNBdjNWWjRPNjJtQmc0VjBJbXk3b3BwSzZVOWpC?=
 =?utf-8?B?V3laS3FVZUF5UmJZdjNIcVcwNlZxR2NaWnlUcXFJbWFxYmJrSC84VHI1ZjFM?=
 =?utf-8?B?czVBL3FZeXpqRnJQNUdaUVlhdFlXVFhVNGlaQ0o0MWpFREhsZFRnR2hxV2oy?=
 =?utf-8?B?bzFqMFB4VXZlei81ZkNSZ3pQdlR0bFE3aUcxdFFUa0hVRzJLWlRkVXc2SU4z?=
 =?utf-8?B?R1Z4MElGOTR6aGxmTFZJUC9qSW5maC9VKzl4YjJmeVJvTVBqZkFFQWFMQi94?=
 =?utf-8?B?THVRd0N1ZWI3anNyZk13L211WEZYN1ZWZXppSnBuNXlWbE5LYlVBYnlHWS9w?=
 =?utf-8?B?Si84NEM5N2ZZTmhrTERpZkpEc3BzNkRIbSt6ZGd4OFJJT0pNVDN6Tk45WlhX?=
 =?utf-8?B?RlYzZ1c1SG5QcnRUWGJtNmVPSlY4d2JLcm5JbDZsZlJqS1R0YVFHRnljZUdH?=
 =?utf-8?B?Z2VVUHZ5TmMralhSOGlmNWc5ejBVZjhjVEtSQjF5OUZLcTlybXAza2l2NTdW?=
 =?utf-8?B?cmhqcGVURWcvbEdXTWtvWXhhRXFqVFRMT0s4c0xGMzF6SXh4bkM2K1RoM3BC?=
 =?utf-8?B?OEgrOXoxbEFmU2JTb1lwdXBic2ZZKzUrZFdkclRiSEFUU1kvbDVaeXd2TE91?=
 =?utf-8?B?Mjh6K05zWnZmY3drREU3dzVxNkEycjZsdXNvRWp3V3hweVErZ3VPVUYxQ09J?=
 =?utf-8?B?MEZWK2VqZ20vVXNCQ1ZsSzlIbWVDeUJlVy9MTCtHdGdJS1NFNnRHdjE2dmNE?=
 =?utf-8?B?cG5ONlRzbi9KT1dZdEJaOFp3U3huSlRGbDY5c1lHajVSL056TFpBZmJzR2JT?=
 =?utf-8?B?cW5oVFlpOGx3YmlQWUdTdkJJZ0dRcURDaWxRS0lIMGNFSmJ0MWt1MWJaSDVa?=
 =?utf-8?B?MTFBWVdjRFNRYVU2R3c4Q0ZtcUpPemFNeGxoa2xOcVlIa1o0VW1GU3FjOEtm?=
 =?utf-8?B?aTZPZXhtWWp3dkRuVk5XRmlsMVZTVURhdW1SUjQrQ2hEeGhIV1FENnBOaEN4?=
 =?utf-8?B?Q3dYZVNFWUpyTXdNK1BRN05CWWFSVjJlV3RJZ1hPa1EzVXg5RkxmaFRHTmlT?=
 =?utf-8?B?enRoZTlFSGZHNjZ2KzBPaHFNNmM2ZlJxZ1k5V0NVZklZZURJSS9VYkZSR1hV?=
 =?utf-8?B?RlBUSFplUXdkRThWN2VLUzVXZ1QvKzRLZUdDRHF1WDc1ckg5a1JSZmNyZzBp?=
 =?utf-8?B?Q0QvQkNUM0F4NGRaeTBrT2RTYVB3MTd1TzhMMFpOV1BKNXhXYVYzYjFMdXZu?=
 =?utf-8?B?V0dGYU1MNEhtWXlvYXJPRGdSVlJvbmlBb0RHWFEvTTFsV0FaaWZ0MnlpL2Er?=
 =?utf-8?B?ZVhKZkxBak11Y3hQOGh4NFVHRXdORHRjOHo5VFpreGFETVRjenA1MVZlNXh3?=
 =?utf-8?Q?2XgzLCA6x34S1Vi1rr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z2fIGvhIB+dPDDv7PPuyx0RMwluTPzGEUsfaJTlEnqvmvgOrACHc4N1+ewPQbfxX+h23zO6Fy7oYW0EwNDucBfqjpksGyJnhnyfTbcwdmw4+trtC+QwrKXS2mSFOskSRIqIWBOi/uvYwyos8TlqoaZBnFiEFKK8lz0+3OdnPltd7fZJLDCI2djXRzQqLggKsDpwhMCfbXB9jQklBwkl5MqGqQYggSwQWf+iyyGFMZwrMCXzOJMxTVub8NMVabUEsbG0jyKdAO17PK0VjWWy72v6zlYtDUxs/rrsmPKdNRFEOUd4Y3dsg8yhjN3R4tMWkv1G8+gIc9shsNDYAf3P+MQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7783b55f-32a5-481e-1888-08df3eeb7c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 05:28:43.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJGtr5FM5+of+8weoVMDNQsJA+CFSUa4Y1LH1/uwtJ88UDMDmnTZM9WoLIB5gttSoAy1FCsrMusKB5BYkmO55w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com

SGksIE15ZW9uZ2h1biwNCg0KR290IGl0LCB3aWxsIHJldmlldyB5b3VyIG5ldyBwYXRjaGVzIGFu
ZCBmZWVkYmFjayENCg0KQmVzdCBSZWdhcmRzLA0KRXZlbiBYdQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwuY29tPg0K
PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyNiAxMjo0MyBQTQ0KPiBUbzogWHUsIEV2
ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBDYzogU3VuLCBYaW5wZW5nIDx4aW5wZW5nLnN1bkBp
bnRlbC5jb20+OyBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47DQo+IEJlbmphbWluIFRp
c3NvaXJlcyA8YmVudGlzc0BrZXJuZWwub3JnPjsgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPiA8c3Jp
bml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+OyBNYXJrIFBlYXJzb24gPG1wZWFyc29u
LQ0KPiBsZW5vdm9Ac3F1ZWJiLmNhPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBJamFlIEtpbSA8YWU4NzgwMDBAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gSElEOiBpbnRlbC10aGMtaGlkOiBxdWlja3Nw
aTogcXVpZXNjZSBJUlFzIGR1cmluZw0KPiB0ZWFyZG93bg0KPiANCj4gSGkgRXZlbiwNCj4gDQo+
IFRoYW5rcyBmb3IgdGVzdGluZy4gSSd2ZSByZWJhc2VkIGJvdGggcGF0Y2hlcyBvbnRvIHRoZSBs
YXRlc3QgbWFpbmxpbmUgd2l0aCBubw0KPiBvdGhlciBjb2RlIGNoYW5nZXMuDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IE15ZW9uZ2h1bg0KPiANCj4gMjAyNuuFhCAxMOyblCAyNuydvCAo7JuUKSDs
mKTtm4QgMTA6MDUsIFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNvbT7ri5jsnbQg7J6R7ISxOg0K
PiA+DQo+ID4gSGksIE15ZW9uZ2h1biwNCj4gPg0KPiA+IFZhbGlkYXRpb24gcGFzc2VkLCBidXQg
SSBzdXBwb3NlIHlvdSBuZWVkIHJlYmFzZSB5b3VyIHBhdGNoZXMgb24gdG9wIG9mIGxhdGVzdA0K
PiBtYWlubGluZSBrZXJuZWwuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gRXZlbiBYdQ0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogWHUsIEV2
ZW4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE1LCAyMDI2IDk6NTMgQU0NCj4gPiA+
IFRvOiAnTXllb25naHVuIFBhaycgPG1odW41MTJAZ21haWwuY29tPg0KPiA+ID4gQ2M6IFN1biwg
WGlucGVuZyA8WGlucGVuZy5TdW5AaW50ZWwuY29tPjsgSmlyaSBLb3NpbmENCj4gPiA+IDxqaWtv
c0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+Ow0K
PiA+ID4gU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRl
bC5jb20+OyBNYXJrDQo+ID4gPiBQZWFyc29uIDxtcGVhcnNvbi0gbGVub3ZvQHNxdWViYi5jYT47
IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
RTogW1BBVENIIDEvMl0gSElEOiBpbnRlbC10aGMtaGlkOiBxdWlja3NwaTogcXVpZXNjZSBJUlFz
DQo+ID4gPiBkdXJpbmcgdGVhcmRvd24NCj4gPiA+DQo+ID4gPiBIaSwgTXllb25naHVuLA0KPiA+
ID4NCj4gPiA+IFRoZW4gbGV0IG1lIHRlc3QgaXQsIGl0IG1heSB0YWtlIHNldmVyYWwgZGF5cy4N
Cj4gPiA+IFdpbGwgZmVlZGJhY2sgb25jZSB0ZXN0IGZpbmlzaGVkLg0KPiA+ID4NCj4gPiA+IEJl
c3QgUmVnYXJkcywNCj4gPiA+IEV2ZW4gWHUNCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwu
Y29tPg0KPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNSwgMjAyNiA4OjM2IEFNDQo+
ID4gPiA+IFRvOiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+DQo+ID4gPiA+IENjOiBTdW4s
IFhpbnBlbmcgPHhpbnBlbmcuc3VuQGludGVsLmNvbT47IEppcmkgS29zaW5hDQo+ID4gPiA+IDxq
aWtvc0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzIDxiZW50aXNzQGtlcm5lbC5vcmc+
Ow0KPiA+ID4gPiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT47IE1hcmsNCj4gPiA+ID4gUGVhcnNvbg0KPiA+ID4gPiA8bXBlYXJzb24tIGxl
bm92b0BzcXVlYmIuY2E+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+
DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBISUQ6IGludGVsLXRoYy1oaWQ6IHF1
aWNrc3BpOiBxdWllc2NlDQo+ID4gPiA+IElSUXMgZHVyaW5nIHRlYXJkb3duDQo+ID4gPiA+DQo+
ID4gPiA+IEhpIEV2ZW4sDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBmb3IgcmV2aWV3aW5nIHRo
ZSBwYXRjaC4NCj4gPiA+ID4NCj4gPiA+ID4gTm8sIEkgaGF2ZW4ndCB0ZXN0ZWQgaXQgb24gYWN0
dWFsIGhhcmR3YXJlLiBJIGhhdmUgb25seQ0KPiA+ID4gPiBjb21waWxlLXRlc3RlZCBpdCB3aXRo
IEdDQyBhbmQgVz0xIG9uIHg4Nl82NC4NCj4gPiA+ID4NCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0K
PiA+ID4gPiBNeWVvbmdodW4NCj4gPiA+ID4NCj4gPiA+ID4gMjAyNuuFhCAxMOyblCAxMuydvCAo
7JuUKSDsmKTtm4QgODo1MiwgWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPuuLmOydtA0KPiDs
npHshLE6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiA+IEZyb206IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21h
aWwuY29tPg0KPiA+ID4gPiA+ID4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDEyLCAyMDI2IDY6MDYg
QU0NCj4gPiA+ID4gPiA+IFRvOiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+OyBTdW4sIFhp
bnBlbmcNCj4gPiA+ID4gPiA+IDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+OyBKaXJpIEtvc2luYSA8
amlrb3NAa2VybmVsLm9yZz47DQo+ID4gPiA+ID4gPiBCZW5qYW1pbiBUaXNzb2lyZXMgPGJlbnRp
c3NAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmlu
aXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT47DQo+ID4gPiA+ID4gPiBNYXJrIFBlYXJz
b24gPG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+Ow0KPiA+ID4gPiA+ID4gbGludXgtaW5wdXRA
dmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4gbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+DQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBb
UEFUQ0ggMS8yXSBISUQ6IGludGVsLXRoYy1oaWQ6IHF1aWNrc3BpOiBxdWllc2NlDQo+ID4gPiA+
ID4gPiBJUlFzIGR1cmluZyB0ZWFyZG93bg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBt
YW5hZ2VkIElSUSBjYW4gYWNjZXNzIEhJRC9ETUEgYnVmZmVycyBvciBxdWV1ZSByZWNvdmVyeQ0K
PiA+ID4gPiA+ID4gd29yayB3aGlsZSByZW1vdmUgb3IgcHJvYmUgdW53aW5kIHRlYXJzIGRvd24g
dGhvc2UgcmVzb3VyY2VzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IERpc2FibGUgYW5kIHN5
bmNocm9uaXplIHRoZSBJUlEsIGRyYWluIHJlY292ZXJ5IHdvcmssIHRoZW4NCj4gPiA+ID4gPiA+
IG1hc2sgVEhDIGludGVycnVwdHMgYmVmb3JlIGZyZWVpbmcgdGhlIElSUSBhbmQgcmVsZWFzaW5n
IEhJRC9ETUENCj4gcmVzb3VyY2VzLg0KPiA+ID4gPiA+ID4gVHJhY2sgSVJRL0RNQSBpbml0aWFs
aXphdGlvbiBmb3IgY29uZGl0aW9uYWwgcHJvYmUgY2xlYW51cC4NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBEaXNhYmxlIHRoZSBJUlEgYmVmb3JlIHNodXRkb3duIGRlaW5pdCBhcyB3ZWxsLiBL
ZWVwIElSUQ0KPiA+ID4gPiA+ID4gZGlzYWJsaW5nIGFuZCByZWxlYXNlIG91dHNpZGUgdGhlIHNo
YXJlZCBoaWJlcm5hdGlvbiBoZWxwZXIuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBp
c3N1ZSB3YXMgZm91bmQgYnkgc3RhdGljIGFuYWx5c2lzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSB0aGluayB0aGlz
IHBhdGNoIGlzIHN0aWxsIG5lY2Vzc2FyeS4gSXQgY2FuIHByZXZlbnQgc29tZQ0KPiA+ID4gPiA+
IGV4dHJlbWVseSB1bmxpa2VseSBidXQNCj4gPiA+ID4gcHJvYmxlbWF0aWMgY2FzZXMsIHN1Y2gg
YXMgYW4gaW50ZXJydXB0IGFscmVhZHkgYmVpbmcgcXVldWVkIGluDQo+ID4gPiA+IHRoZSB0aHJl
YWQgYmVmb3JlIHRoZSBUSEMgaW50ZXJydXB0IGlzIGRpc2FibGVkLiBIYXZlIHlvdSB0ZXN0ZWQN
Cj4gPiA+ID4gdGhpcyBjb2RlIG9uIGFjdHVhbA0KPiA+ID4gaGFyZHdhcmU/DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gPiA+ID4gRXZlbiBYdQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRml4ZXM6IDQxMzhmMjExMTVhZSAoIkhJRDogaW50ZWwt
dGhjLWhpZDogaW50ZWwtcXVpY2tzcGk6DQo+ID4gPiA+ID4gPiBDb21wbGV0ZSBUSEMgUXVpY2tT
UEkNCj4gPiA+ID4gPiA+IGRyaXZlciIpDQo+ID4gPiA+ID4gPiBBc3Npc3RlZC1ieTogTExNDQo+
ID4gPiA+ID4gPiBDby1kZXZlbG9wZWQtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+
DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBJamFlIEtpbSA8YWU4NzgwMDBAZ21haWwuY29t
Pg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTXllb25naHVuIFBhayA8bWh1bjUxMkBnbWFp
bC5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IENvbXBpbGUtdGVzdGVkIHdpdGgg
R0NDLCBXPTEgKHg4Nl82NCkuIE5vIHJ1bnRpbWUgdGVzdGluZy4NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBSZWxhdGVkIHJlY292ZXJ5LXdvcmsgcmV2aWV3IGFuZCBzZXJpZXM6DQo+ID4gPiA+
ID4gPiBodHRwczovL2xvcmUta2VybmVsLmdudXdlZWIub3JnL2xpbnV4LWlucHV0LzIwMjYwNzE3
MDM1NjA5LjM4Nw0KPiA+ID4gPiA+ID4gNDAxNQ0KPiA+ID4gPiA+ID4gLTENCj4gPiA+ID4gPiA+
IC0NCj4gPiA+ID4gPiA+IGV2ZW4ueHVAaW50ZWwuY29tL1QvDQo+ID4gPiA+ID4gPiBodHRwczov
L3BhdGNoZXcub3JnL2xpbnV4LzIwMjYwNzI5MDUwMTQ1LjIyNzI1OTctMS1ldmVuLnh1QGludA0K
PiA+ID4gPiA+ID4gZWwuYw0KPiA+ID4gPiA+ID4gb20NCj4gPiA+ID4gPiA+IC8NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiAgLi4uL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jICAgICAg
ICAgICAgIHwgMjggKysrKysrKysrKysrKysrLS0tLQ0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+IGEvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhp
ZC9pbnRlbC1xdWlja3NwaS9wY2ktcXVpY2tzcGkuYw0KPiA+ID4gPiA+ID4gYi9kcml2ZXJzL2hp
ZC9pbnRlbC10aGMtaGlkL2ludGVsLXF1aWNrc3BpL3BjaS1xdWlja3NwaS5jDQo+ID4gPiA+ID4g
PiBpbmRleCA4OTIyNmY1Y2U0NWUuLjBiZDIyZjI4NWM3OCAxMDA2NDQNCj4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVpY2tzcGkvcGNpLXF1aWNrc3Bp
LmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtcXVp
Y2tzcGkvcGNpLXF1aWNrc3BpLmMNCj4gPiA+ID4gPiA+IEBAIC01OTcsNiArNTk3LDggQEAgc3Rh
dGljIGludCBxdWlja3NwaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkg
IHsNCj4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBxdWlja3NwaV9kZXZpY2UgKnFzZGV2Ow0KPiA+
ID4gPiA+ID4gKyAgICAgYm9vbCBkbWFfaW5pdGlhbGl6ZWQgPSBmYWxzZTsNCj4gPiA+ID4gPiA+
ICsgICAgIGJvb2wgaXJxX3JlcXVlc3RlZCA9IGZhbHNlOw0KPiA+ID4gPiA+ID4gICAgICAgdm9p
ZCBfX2lvbWVtICptZW1fYWRkcjsNCj4gPiA+ID4gPiA+ICAgICAgIGludCByZXQ7DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gQEAgLTY0OSw2ICs2NTEsNyBAQCBzdGF0aWMgaW50IHF1aWNrc3Bp
X3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBxc2Rldik7DQo+ID4gPiA+ID4gPiAgICAgICBpZiAocmV0
KQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBnb3RvIGRldl9kZWluaXQ7DQo+ID4gPiA+ID4g
PiArICAgICBpcnFfcmVxdWVzdGVkID0gdHJ1ZTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAg
ICAgICByZXQgPSByZXNldF90aWMocXNkZXYpOw0KPiA+ID4gPiA+ID4gICAgICAgaWYgKHJldCkg
ew0KPiA+ID4gPiA+ID4gQEAgLTY2NywxNyArNjcwLDE4IEBAIHN0YXRpYyBpbnQgcXVpY2tzcGlf
cHJvYmUoc3RydWN0IHBjaV9kZXYNCj4gKnBkZXYsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
IGRldl9lcnIoJnBkZXYtPmRldiwgIlNldHVwIFRIQyBETUEgZmFpbGVkLCByZXQ9ICVkXG4iLCBy
ZXQpOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBnb3RvIGRldl9kZWluaXQ7DQo+ID4gPiA+
ID4gPiAgICAgICB9DQo+ID4gPiA+ID4gPiArICAgICBkbWFfaW5pdGlhbGl6ZWQgPSB0cnVlOw0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgIHJldCA9IHF1aWNrc3BpX2dldF9yZXBvcnRf
ZGVzY3JpcHRvcihxc2Rldik7DQo+ID4gPiA+ID4gPiAgICAgICBpZiAocmV0KSB7DQo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkdldCByZXBvcnQgZGVzY3Jp
cHRvcg0KPiA+ID4gPiA+ID4gZmFpbGVkLCByZXQgPSAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gPiA+
IC0gICAgICAgICAgICAgZ290byBkbWFfZGVpbml0Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAg
ICBnb3RvIGRldl9kZWluaXQ7DQo+ID4gPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gICAgICAgcmV0ID0gcXVpY2tzcGlfaGlkX3Byb2JlKHFzZGV2KTsNCj4gPiA+ID4g
PiA+ICAgICAgIGlmIChyZXQpIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgZGV2X2Vycigm
cGRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIEhJRA0KPiA+ID4gPiA+ID4gZGV2aWNlLCBy
ZXQgPSAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gPiA+IC0gICAgICAgICAgICAgZ290byBkbWFfZGVp
bml0Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBnb3RvIGRldl9kZWluaXQ7DQo+ID4gPiA+
ID4gPiAgICAgICB9DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgcXNkZXYtPnN0YXRl
ID0gUVVJQ0tTUElfRU5BQkxFRDsgQEAgLTY5MiwxMCArNjk2LDE2IEBADQo+ID4gPiA+ID4gPiBz
dGF0aWMgaW50IHF1aWNrc3BpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IC1kbWFfZGVpbml0Og0KPiA+ID4gPiA+ID4gLSAgICAgcXVpY2tzcGlfZG1hX2RlaW5pdChxc2Rl
dik7DQo+ID4gPiA+ID4gPiAgZGV2X2RlaW5pdDoNCj4gPiA+ID4gPiA+ICsgICAgIGlmIChpcnFf
cmVxdWVzdGVkKSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgIFdSSVRFX09OQ0UocXNkZXYt
PnJlY292ZXJ5X2Rpc2FibGVkLCB0cnVlKTsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgZGlz
YWJsZV9pcnEocGRldi0+aXJxKTsNCj4gPiA+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gPiA+ICAg
ICAgIHF1aWNrc3BpX2Rldl9kZWluaXQocXNkZXYpOw0KPiA+ID4gPiA+ID4gKyAgICAgaWYgKGly
cV9yZXF1ZXN0ZWQpDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGRldm1fZnJlZV9pcnEoJnBk
ZXYtPmRldiwgcGRldi0+aXJxLCBxc2Rldik7DQo+ID4gPiA+ID4gPiArICAgICBpZiAoZG1hX2lu
aXRpYWxpemVkKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBxdWlja3NwaV9kbWFfZGVpbml0
KHFzZGV2KTsNCj4gPiA+ID4gPiA+ICBkaXNhYmxlX3BjaV9kZXZpY2U6DQo+ID4gPiA+ID4gPiAg
ICAgICBwY2lfY2xlYXJfbWFzdGVyKHBkZXYpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEBA
IC03MTgsOSArNzI4LDEyIEBAIHN0YXRpYyB2b2lkIHF1aWNrc3BpX3JlbW92ZShzdHJ1Y3QgcGNp
X2Rldg0KPiAqcGRldikNCj4gPiA+ID4gPiA+ICAgICAgIGlmICghcXNkZXYpDQo+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtICAgICBx
dWlja3NwaV9oaWRfcmVtb3ZlKHFzZGV2KTsNCj4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+ICsg
ICAgIFdSSVRFX09OQ0UocXNkZXYtPnJlY292ZXJ5X2Rpc2FibGVkLCB0cnVlKTsNCj4gPiA+ID4g
PiA+ICsgICAgIGRpc2FibGVfaXJxKHBkZXYtPmlycSk7DQo+ID4gPiA+ID4gPiAgICAgICBxdWlj
a3NwaV9kZXZfZGVpbml0KHFzZGV2KTsNCj4gPiA+ID4gPiA+ICsgICAgIGRldm1fZnJlZV9pcnEo
JnBkZXYtPmRldiwgcGRldi0+aXJxLCBxc2Rldik7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiArICAgICBxdWlja3NwaV9oaWRfcmVtb3ZlKHFzZGV2KTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAgICAgICBxdWlja3NwaV9kbWFfZGVpbml0KHFzZGV2KTsNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBAQCAtNzQ3LDYgKzc2MCw5IEBAIHN0YXRpYyB2b2lkIHF1aWNrc3BpX3NodXRkb3du
KHN0cnVjdA0KPiA+ID4gPiA+ID4gcGNpX2Rldg0KPiA+ID4gKnBkZXYpDQo+ID4gPiA+ID4gPiAg
ICAgICBpZiAoIXFzZGV2KQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gKyAgICAgV1JJVEVfT05DRShxc2Rldi0+cmVjb3ZlcnlfZGlz
YWJsZWQsIHRydWUpOw0KPiA+ID4gPiA+ID4gKyAgICAgZGlzYWJsZV9pcnEocGRldi0+aXJxKTsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgIHF1aWNrc3BpX2Rldl9kZWluaXQocXNk
ZXYpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgIC8qIE11c3Qgc3RvcCBETUEgYmVm
b3JlIHJlYm9vdCB0byBhdm9pZCBETUEgZW50ZXJpbmcNCj4gPiA+ID4gPiA+IGludG8gdW5rbm93
biBzdGF0ZSAqLw0K
