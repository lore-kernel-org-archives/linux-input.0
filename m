Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CF1E1DE5;
	Tue, 21 Apr 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.72.220.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754960; cv=fail; b=fpiU16dWS7c41b5Fve5sd4EVm+BfbCBJau9QgFzqEAHCs/aEf+/mRg/TjPnjA516t/EV+brl6UmKV22HfnEYxKxTS7fXVknbpgBVzR/vyxC7gTjwspuQ2WRSbkWPDXD+NsqlUZciLUcDFH5jBEbCLXXnxpuogAyMZuKVfV5lVhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754960; c=relaxed/simple;
	bh=WCwQUvPfwuDAPg+AeEh5mKqDiTW2tHqSppDleBBYpb4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBA/f7dfdaiCwdrAOKBaHprpiLGQweHfNqZhUd01DyjGF3pFZWm6O6Avi01BrvVnNYLU8Ojn3AAWPUE3Az5FUTTX292jhquuTBXcb/kbuPeu8Q7WrTNQYEwlk9w9xecL5ulySwN1B7lAmiQcEj5319p3woftAVbkvD9u0HlaSJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw; spf=pass smtp.mailfrom=emc.com.tw; dkim=pass (2048-bit key) header.d=emc.com.tw header.i=@emc.com.tw header.b=jAu6OMIc; dkim=pass (1024-bit key) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.b=L2eGbjBy; arc=fail smtp.client-ip=192.72.220.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emc.com.tw header.i=@emc.com.tw header.b="jAu6OMIc";
	dkim=pass (1024-bit key) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.b="L2eGbjBy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com.tw; i=@emc.com.tw; q=dns/txt; s=emcselector;
  t=1776754957; x=1808290957;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=WCwQUvPfwuDAPg+AeEh5mKqDiTW2tHqSppDleBBYpb4=;
  b=jAu6OMIc40asTRnnhvmSeJjene2Oe6NGKAuncK1E4w1mDiZ71TkuLnpx
   RZrDhsAFZBmOkNEoZH0GpmHRJ4oY+NXJaMkmYGIIzG/nX/pcUqsUNp6/H
   8byCJ/ycSzdOPmq9KsYWCFxcIFLFb59Til/gyU+8hBNAx6ugGeJypDizG
   cmROrArew5PXydl+PlLN/7qGhnspftHc+9o0JFqe3FtLOdmCQQn70oY3B
   4PMG6zubV6jzRVwrAAbDnt2NBA+d2aOYumvhjwPR3dNvYjxUcD+M5TYnl
   oCLv83rLnc2FJz4v6sJr/3RlLVoTEICmBvWZqJMcqkQiVX7ctLvlH54TF
   Q==;
X-CSE-ConnectionGUID: 30YlbQczQyCPmvMf3qD/iQ==
X-CSE-MsgGUID: WrMe3u3UTwq4dxjXQzousQ==
X-IronPort-AV: E=Sophos;i="6.23,191,1770566400"; 
   d="scan'208";a="13177369"
Received: from unknown (HELO ELAN-EXMBX02.elan.corp) ([192.168.10.68])
  by emcscan.emc.com.tw with ESMTP; 21 Apr 2026 15:02:35 +0800
Received: from ELAN-EXMBX01.elan.corp (192.168.10.67) by
 ELAN-EXMBX02.elan.corp (192.168.10.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 21 Apr 2026 15:02:35 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (40.93.129.123) by
 ELAN-EXMBX01.elan.corp (192.168.10.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33 via Frontend Transport; Tue, 21 Apr 2026 15:02:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFuwH0vnmzNjVGhoQZWy7rmoYXKq0ikydzx7xmArGD8ZKKk798Ydtp0zcqrDQ7HLewL4rgXT8wW4i/gkScLS8e44zM+nvB0yn8P5ZIaK6zv86MfDzxPfDGutCYe+ewI8OZoz7n/bRNAYFM9TTTykJBMzXrzAP3NBDJrEHEOruJbUCnDJwiWui8kXZcgrXfMj945kkuzp9rIsakfg7NiE8hVHXKsLloJD7pDOGalcIZWzEXlRVde6GEiyXAZfB7RH+nFMtA+ISvDVkmHV9Ykhwe6OsMzwWa06v6BMIDNPb/2mrJuqJ3ry4UusxXu0DpwuRL5LjzNok48oMoj5efrTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCwQUvPfwuDAPg+AeEh5mKqDiTW2tHqSppDleBBYpb4=;
 b=MuMoMpK4aKjZ95s9yEixySnDIdB+0EkhLuO/IrYLaunoLd+SgrrOcOOfzJQXX8F9iDpViUAZBMlP5MkRtSfaGaZCKVEqKc++spU6mlhDC4DCShcUgyRr+Cy6A7K9kYiQaedKCcHFkgQNyn7X6kHMOyvBOcTRRaxB9DPnQ+z+C9JrLNyC+aSBftIY9qOcTbypdQqdcZHf+A1v0og38t6RtQXqWbH1Qk0uhWrKwY5sNdyoBp4Fw7RmFoGVi/dnaLSqxL8tGUQmnA54nz602bjub+yNUR5hrNtR+kDqncBpRHFJ/Es3rhViWYPMYv3D5txOll5izHITD7uNKUFgXIs/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emc.com.tw; dmarc=pass action=none header.from=emc.com.tw;
 dkim=pass header.d=emc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emccomtw.onmicrosoft.com; s=selector1-emccomtw-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCwQUvPfwuDAPg+AeEh5mKqDiTW2tHqSppDleBBYpb4=;
 b=L2eGbjByvg5ahs1O5ZZUFrYi061N7FHrc1NIriKJGZdaB1vZn/hYKjcxMQjmNMlw2vbROKmS3KvlVVjYoaaBA1SHzZAt6Cx9i7AMNWkxTng1QKVCnKXX04fjZgEV/5y2TQ2krrHyXhPAj0pVP0YQuguM8I6k55SR3oe7E+3FSpA=
Received: from KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 (2603:1096:820:dd::14) by SI2PR01MB4499.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:02:33 +0000
Received: from KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 ([fe80::dccb:b51b:bbd3:1bfc]) by KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 ([fe80::dccb:b51b:bbd3:1bfc%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:02:33 +0000
From: =?big5?B?SmluZ2xlIFd1IKdkqvew6g==?= <jingle.wu@emc.com.tw>
To: "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>,
	"Linux-input@vger.kernel.org" <Linux-input@vger.kernel.org>,
	"Dmitry.torokhov@gmail.com" <Dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - increase device reset wait timeout after
 update FW
Thread-Topic: [PATCH] Input: elan_i2c - increase device reset wait timeout
 after update FW
Thread-Index: AQHc0VzTJuhnP45xlUSUYxGcUdWZeg==
Date: Tue, 21 Apr 2026 07:02:33 +0000
Message-ID: <KL1PR01MB5116031986614B3214EF2F30DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
References: <KL1PR01MB511699853D1B66D137C06806DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB511699853D1B66D137C06806DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR01MB5116:EE_|SI2PR01MB4499:EE_
x-ms-office365-filtering-correlation-id: 7b6f9c30-4173-4288-5905-08de9f73f60a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Pwns/6CnQxrDXGx/8lq5hpq7OV2w26p/zFip7r65qnUCf9qbG0uomqUertPSPRFMAM+nfJdQiktnnmNq8BXipWzztQqu3pgnYKThIT1mvaHx8AmOzbocwWjsFHeLzPS0MM5UfhhVU3ts8Zpm1/kugu0PUGZc3NEKiGdcRDjTSpdWCja9tcydIMUEmoBcA6Z3QkI8+d/ysHXASvAhrXT6dD7qaA0vcIFDYDbOw7rC+eLPvw03nBR5gzIzWFeE7g8OnvNKX7rbpO1KD1mvn+pxz1kag7G3JALqsjEc8F0RoctuMRWg8PrGtBSotqT1OFqX5qG5ZfhI3kpDLoEqAtbwLl7kp2OveXVDr5NXMVp1Buedgy7xzYbylI2F+p8WvV+n/N0CmI28/I0B9M3e3NN1zOWcl0PZoP/ligWelXemLYgMITfLVfRgWE/JmkVv6Rht5VrlmoFYLsnY2dLIk0Lvx62IES9agSarQcS6N+bCFo8bGvFPEJejGGoIz9q//LXWsQi5JM9R5/Z87DeRw/QnMtDxKAfd2+Vj43mWkgYR8zY8Evu5d0qUS07AUQEIVYuNSZnxSFC6+iQLJXSThpn0RDQ1aoUU6Gw8SmINdfrRgQC7jRNIIpr0OkQJEM0YrLByAdBSaduk6ZuUzZxBIC0NomL+Uwg/padjZ74QGe6y2oH+aKVg1BYnJDUo27zOa2nEjrPESGpYPSes4YTQmcg1fap2nxqWmIpenSAuyNgU9N/GmloCDVqhwddP+4df7uQu+ZLXnSg/udziwJ36k5lHoT2wc/+fvzRtSvA0olUYB64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR01MB5116.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?VnFJWXhnVzlwUy9xdXY2MStuN2VuN3JwT2JrTUthQjMxSk5RZ3AxajFLR1VmZWxs?=
 =?big5?B?M2cyVFRmNnRmMkJkSUFnSXAwVE1aSDJqSmZ5VGd2Z2NHQVFGYWhhL3gzWmR0OU1Z?=
 =?big5?B?LzJsQTFWUXc0VlMvSWFLQW1JMTZTeVQzRHpuS08wdFZ6dUZKbHFCRnB4VWF5ZkVS?=
 =?big5?B?dSt4SzhXQ0s3VFpRMm5PNWR0S1lnaTM2YXJVQVBZY2UrM2tlVUp0cUtSZkR1ZE5w?=
 =?big5?B?NWk2VEYxRk44dEIyYWhhSnhXeFdGRFY4TEJMYTZRMEkveHpLNmlpWU9vZkdRM0Np?=
 =?big5?B?THZQb1JDRlUwMkZzU21XVHcvSW95M0dwVmpFY1BrcnJKeEVlU3N0ckZkTk12MGpJ?=
 =?big5?B?ZTF4YnBmM0xsTTRrb1pxWmVieWorUFg5NndpdjdQWXdnbjRCSG9RbitoMXorcWdm?=
 =?big5?B?MnJOUUhBUkp3ajVCSVFnbXQ1RzE4bzRVRExOT0ltOXMzYjJmc2Vzd2RsME1XRVlp?=
 =?big5?B?QlZpUGxOclBTUmhZMDFEVFc2VGYrQW5IRnhiRFoxR2o1azBrMjZmd3F1WWMwZUdw?=
 =?big5?B?aFY4RWpUdHYwOTdCaDBmOGpacnFCbkJrQmViM0xQT3JhNlZZalFQMEwwaVlpcXZI?=
 =?big5?B?ODduQlEyT2F6UHIyMVNWYkZEajdrZWV3LzNXNEVXeURMdFU3SWxMazJZSUFpV211?=
 =?big5?B?cUhnOE5YN1pJVm1XdVRYdWtNNHRJM1g1ZmxlN25iZVBlUitIREROVUlqUnZTUitq?=
 =?big5?B?VVhia3c2ZXlCOGg3L21IOGhZellkRXRERXFPeFBGdC96UWRqRFlkczdkVmNqSUg2?=
 =?big5?B?ZzNPM3E3RWNvenhDZWw1U3BmUjdVVlB4bHp3ME41Q0NMMW5CaWtDZlhITXVYc0Vo?=
 =?big5?B?NmhDTVNzdjBrZW8zR3FJMk5mQjlwQ3FzZ3VGUHZ6TW92MHBpRW9Jc1RoazBScFVT?=
 =?big5?B?RnFha0ZxU01sbVVLQ2FhM2ZyRmFnNVh6dUVGQWtGRkJyUnpSQ0ZqaGV0VjNXakNt?=
 =?big5?B?WGNpeWs1NzhpUjhlNDQwWlFJVExSOURTN0cvOE9DTW8vZlZROXNwc2ZYS051M0Vv?=
 =?big5?B?K1MwcHJaTUV4eERZeUY2cjhYSVhKUjU2WXVKU25IVlAxbWhRbzZhREtPL202dkl4?=
 =?big5?B?cEx4TzYwNnRBQzRrdms2R01CUVdMRmRtODdlU2tFUXZmZUxIKzJ0MENrY0lHM0Ux?=
 =?big5?B?cVJWcFJ3dzRHNlZhV2FTUjlrNmFUbUZhcU1neEFobnF0WGhubzdmNEV6djhwbG9R?=
 =?big5?B?MlJmeHZVa3o1aUxlVzRua2lyZVl0NTIySGpiandTTCtOV2JRRVE1dDVDZmx2RnU5?=
 =?big5?B?aFMvVjcya3hWUGRKZ2paQkJTU1YyU0pGbXRPbmc5SFBTSkFUTmVkZmIvUFA4YlBx?=
 =?big5?B?enB3QWQzb0lWenF4cHhnZEI5K0hKZHlaejZyemVtcUxRMUMyS3ZlMGNJQU5hemlq?=
 =?big5?B?VXlhK2xhMVFJWUQwK1RGVkpzOVd3VTlPbTJ3WG5qNmJCL0JKeHJTMFNBWmQySnlK?=
 =?big5?B?QUJWTGVMRFQxVk94UGZQZWVwRjczQnR4Z1czZm1MNUlTYVh3bWlWVitjYTN2THlw?=
 =?big5?B?c2JneWI3RXFuenR4WUdSSndFdHhOVmFaZHBNdkVUWVUyak9URkVrUHNmay9zZTZl?=
 =?big5?B?Njd0M1E3bGg0bEg2SlIxMGtqdXl3djl1OE9VMWNvV0ZWMUNvYnFoK1RRVmRHY3Qr?=
 =?big5?B?bzkwM2lBSU5scVl1Q25NSElKZnhvWnFwZVA0MEdLOFFiYnlLN3BBQm5HTUZCQWNJ?=
 =?big5?B?Y2dqKzVNSFNaNjlUZmM5RkV6eHRHcGhkZnFnWGh5bnRGQWszTkZETWRSUkkvUTlO?=
 =?big5?B?TVdMaHZ6d29RMXRxVEVrbWxDWDBOb0pwTk5Va0k3azF0RU50S3Y5RHZlM2VBdHZr?=
 =?big5?B?TWUxSm9YR2JRNWJkZDlkQzVvbEt3K3k1YmVXMUx5VzNTQVRDQ3B5a01odFJPUy90?=
 =?big5?B?aGFQSi82cHJVb1JES0w0dFltakc2YUZnazZCMUFRYzFBUHRUQ3U4dys5OG5peWVz?=
 =?big5?B?Rm9vTjBaajRYMmVXWWZBcVZVMEYrYWt1TXY0NFlCaVRNOCt2UzJzZW1TYUVWRm83?=
 =?big5?B?bnN4dVlNa2JPWFV5OXZNUWlENFlFbWFsRnE1UUFPQnUwU0V0dEFmRk1BZEdYRkRn?=
 =?big5?B?N2pkNVJVTWNDcDFOREdLTjNCclpvL2kzZWp1NWxvUlAwR28wZHdjNDFRWXVXbkF4?=
 =?big5?B?aXljazVuVDVCamx0NU1xVGppNXlXZXFJUE9tYnlDYUlTU016b1FXN09GNjg1N3Y4?=
 =?big5?B?d0JBbDdJU1QzY0NxaHAyQTN0cnpMdz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jb+Jkx7I2Sg2MYoNMyka+Ud3fSIX8RMiXdfefvrjTucdWApPkQJarD/FRwvcNfwUtwKfuD5MnOQxeIZyiNFLsQ1dhvdGI2yCI9s9K3QGIqqYUyITeEvOSwraH1YCzlsCvHeGQUxEMefgXmgZLH6xxb5lxoD2w+LMxETDbmpEcjFjURbJfMv6jPicxgHsp3U5ePHQJV0I0JOVOWMp3WM7/O25bcEq1VyCe9HORcM1m8BMVZgNZp3hlZ1V0Jbqx47HRZUv4neo1ukBDd7uTt9lX2KDGt4HWNOtbM1YC2bUNZejmzp+Cr0tWWykckvoPe69rwZ6P/tSWPpiYmG1TQTXyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5116.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6f9c30-4173-4288-5905-08de9f73f60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 07:02:33.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrBCPwcBc9CSYpOAWtvEwkyZrsfWUZYjW6s22Ao+0QFwCccivT9V5HuBbEe6RNzRsSuW+RP1wLifXRRf3HgJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4499
X-OriginatorOrg: emc.com.tw

RXh0ZW5kIHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCBmcm9tIDMwMG1zIHRvIDcwMG1zIHRv
IGVuc3VyZQ0Kc3VmZmljaWVudCB0aW1lIGZvciBkZXZpY2UgcmVzZXQgYWZ0ZXIgZmlybXdhcmUg
dXBkYXRlLiANCg0KU2lnbmVkLW9mZi1ieTogSmluZ2xlIFd1IDxqaW5nbGUud3VAZW1jLmNvbS50
dz4NCi0tLQ0KIGRyaXZlcnMvaW5wdXQvbW91c2UvZWxhbl9pMmNfaTJjLmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lucHV0L21vdXNlL2VsYW5faTJjX2kyYy5jIGIvZHJpdmVycy9pbnB1dC9tb3Vz
ZS9lbGFuX2kyY19pMmMuYw0KaW5kZXggYTkwNTdkMTI0YTg4Li44OGQ0MDcwZDRiNDQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lucHV0L21vdXNlL2VsYW5faTJjX2kyYy5jDQorKysgYi9kcml2ZXJz
L2lucHV0L21vdXNlL2VsYW5faTJjX2kyYy5jDQpAQCAtNjkwLDcgKzY5MCw3IEBAIHN0YXRpYyBp
bnQgZWxhbl9pMmNfZmluaXNoX2Z3X3VwZGF0ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0K
IAlpZiAoZXJyb3IpIHsNCiAJCWRldl9lcnIoZGV2LCAiZGV2aWNlIHJlc2V0IGZhaWxlZDogJWRc
biIsIGVycm9yKTsNCiAJfSBlbHNlIGlmICghd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KGNv
bXBsZXRpb24sDQotCQkJCQkJbXNlY3NfdG9famlmZmllcygzMDApKSkgew0KKwkJCQkJCW1zZWNz
X3RvX2ppZmZpZXMoNzAwKSkpIHsNCiAJCWRldl9lcnIoZGV2LCAidGltZW91dCB3YWl0aW5nIGZv
ciBkZXZpY2UgcmVzZXRcbiIpOw0KIAkJZXJyb3IgPSAtRVRJTUVET1VUOw0KIAl9DQotLSANCjIu
MzQuMQ0K
