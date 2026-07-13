Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F72314B9A
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913146; cv=fail; b=LycSLUypXa2z8K/ezkowZWCZOpaDmMBaCp+wE83H5+8cnSYfWV2xZQLKtTzrNVYE/12EJBqt+bIVZU3gDHb01R9BzpR7Uv/pXQj1+Gffp8EqciF39pFlAHW2Sn7pl5/YH71tILgXQofFKOCgxvbRtaOrAdNbt9uMNETQBlWeN7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913146; c=relaxed/simple;
	bh=pqPTh1mcPMNDZa8Y8AU03Xe3zwO7qfyUBSFYp6DGsig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChLqsJ64yAsmebmdsmGS6YXb9XlubOnqv4z84qyVjDgd9mKSfxWPDRM7BN/pMXjq+2FQJ74kV/Rkks7y/sNWxCNtHOtgu9hV5znO/VQIQ8UgRXyrEzIqdKF6jc4cyWekXQYQBuW4UPRrUWEePTx9z3YDBTAtKiFi0CfuFQoOrTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOfyMC0t; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOfyMC0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783913144; x=1815449144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pqPTh1mcPMNDZa8Y8AU03Xe3zwO7qfyUBSFYp6DGsig=;
  b=dOfyMC0tuR29/GauAiTkCDNc0oPrljSkMeXI/ox5RIYO44HrBIzibFZc
   K+2myQzTZB288tXkyQTDGhYEuP+Ls9d/LlDdDcvuAvO9110lnHFLAta3j
   wtmcl807XyMOONwBRIv3ljbwPti1GuFlqbi8YYPWmqHnPApi+KIFFuXjl
   0lZInYQQSrh8+scVLg5xHRyRdijPzEHQ4JiEUXJu7aON9suFkeBjFGSbn
   fr/4GjNgKTY66/JFNn2CNIjJHtZHy1qI8MNOPOInyusORFW2FkBl6celk
   2OV1EsFxAsZAzjmYNGwQBKpxDNdqwXfiJdLal6X2T6e6iueIQp2hqFT/G
   A==;
X-CSE-ConnectionGUID: 6r5SRIGQSTyuXb3pWbbeWw==
X-CSE-MsgGUID: Z1JJUeUdRfGsQMYOEWGRhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83635156"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83635156"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:25:43 -0700
X-CSE-ConnectionGUID: dfMEgtNzQserIbDHWiVBLQ==
X-CSE-MsgGUID: 12SQyspuRBOwEoIRdemPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="257374596"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 20:25:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 20:25:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 20:25:43 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 20:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7BYZX1V9SuM3CmHY+VMnEK6AlTYq+XG1ngrCeBJCdEmbulwv/kQT32qemBPaHuSRqujksv1ehRNiaQj7VjoFYwuy1AozLbIF1idbrcT8cP50hBP1rdxnrArl2WvPaAysQOYrVSZbCdZaaBwohaORI1cGC6StUgnaMd5MK2So0cc2rnY3qBlUzAwM2KmXQR+H+majnvQmnTrZ9LaNIK3Y0kEarT8X6PAEMH3hoKR6gTxY6vplaPWhra2bxNCGgWmvtSjGKfudnnTq3XWqnq6XxX4gaRhaJ4xQ+diXcx/2PlTZ7Hjms/0eyw3db/ZeIG56GB51a9NsaVU8tppRJEiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqPTh1mcPMNDZa8Y8AU03Xe3zwO7qfyUBSFYp6DGsig=;
 b=xgA2dM9c9gw3qI6nDE7vKCH+y/j54Yx2Hsv2pdbnBf0k336iCKVGjR4/vP+gu6mZo9CtAQ43Wf+/mh2pDI04a+VcsRRAhHUk10LuwNKQxuOioqtRfThCbYQeNVLKFvL8MlK48QSSuZijK2Rv2CCIvOecfZ3/9W/LC0sZkeuOloUrzCLeyj64a6TXNWEmXPBiiepRmSETbGYhamF/DusIir4Z/VhgvE8Dfvb8T4NR2TBaLTOm3oXRXVrKWa07//ZYc0LoprRb0QW8c1z9pAsh1x+mkjrwBXMo/gO43JmzAkbOJO8oPzIlNMTcpsifb+et1Cc2fwTPO+mNCIK681ZhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DM3PPFC3B7BD011.namprd11.prod.outlook.com (2603:10b6:f:fc00::f49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 03:25:41 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:25:41 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: RE: [PATCH v3 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Thread-Topic: [PATCH v3 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Thread-Index: AQHdEnQ86BuScCVsqE+dfncEWZKhyrZqx3MAgAABKTA=
Date: Mon, 13 Jul 2026 03:25:41 +0000
Message-ID: <IA1PR11MB6098EC7BEF945BA6B49D51DBF4FA2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260713030412.2531933-1-even.xu@intel.com>
 <20260713030412.2531933-2-even.xu@intel.com>
 <20260713031749.2DC211F000E9@smtp.kernel.org>
In-Reply-To: <20260713031749.2DC211F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DM3PPFC3B7BD011:EE_
x-ms-office365-filtering-correlation-id: 27c4ddc7-e2ac-4d30-8f37-08dee08e6abe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: uGYgPciHH+IPVKdobMv80/RsRs/8Bg0Lx+N1WvVxYZX+xW7i2i232veFI1XtDqmFRIIkkNYa0l5M76/4PGpwOci3xoxt19jGXpk3k/qdK9q3nBPNjr1cFKcuArq8lcYt4AqU2st9BRj2dfiaQO2BRrphJehjCe3z0eZS/ScW4CRkAmA8omRJ5pqX0k9/RynyFpoqhFTU0DE/xSHjXm+l6KUHWS4mQgx29DXWTmi9bmGfOmsQfF++V0c/BerLfX1wG7pv/NWoRBIMgFmNMaAQ0SX+aytg4R82Ux8FHsgLSpQQ6gh6uRuMJdBl4m82YrXSYt1ZtBMQvovCP0N4n1QHtXrbGM5MT5n+RnMF95GbDjlfV1uVBktcLV5o3PFtQtdkdHM7HAqNM5s1HsaxKcJqMIRZpkxlRLC/6naIAJhspNr9Kju1DGCb8vcnfvHHp5lazgxMpicszfDwUPJCW7Q+x2lhcuUWBQuxr75U4+QBBnIxRwUQ6z+hye86Yh/ZFCXWBvMLvUUDxef9402bjNVj3ibDCVDjVDu/HFirSo14bhXSEwn35mdHFiXP8dytSk5JMOIxq6pvAeGPfpL+RxnOPFZoj1uF7MFUEuUSwqg023IPsp5JxjOMmT7m2j0gBQkggKfCt1TW3zcfKP3q5EnOofeumxzfnbSqpiB1BzfUFK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRjSUgrVVU0T25pdkhRak52NlU2SmlIVXNmSjJHbklFVWhDNUZJSVdxb3g1?=
 =?utf-8?B?MmhXeTN0amhNc1VHY3hjbENPSUJIVVlKL1VrUzNPMUp5NVVxeThZYUQrc1FG?=
 =?utf-8?B?TTJXYmdibXQzdTlrbDZyTHV6Wi9qOVUybGdCU3lXbVRicmpoTTZweXhrM2xj?=
 =?utf-8?B?NEFhZlRtWGl4SzBNMmFpRFMyWW52eE80dGhzSlcwM01wY29CQ2czcjYrdXdW?=
 =?utf-8?B?S1ZYNFIvZE4zaEZoNzNOUzNTRW9QMERZd3NFY2RVaWdMZWRkT3NvWDRKMlZ2?=
 =?utf-8?B?NVRJY1owcXpsZGJtNGgxWisxdkd4TitYYnR5dWJobWs0YmZNQ0ZIZU92MFcz?=
 =?utf-8?B?RUZPSEM2Y2JJWDRFcXJ5ajZDZmJ2Y0dJUEx1N0Y0alRZWlRuSjYzbHVoTklQ?=
 =?utf-8?B?azRKdGFtQktwMjBveWR6MzM4YVk5TjZYaWg0aDRBN3pibStiZXNxNXBTQ2Fj?=
 =?utf-8?B?RW1jUHR1TUR3T2YreVRjc0xDTWdWdmU2b2gxQjRFbDVaUTRYZEVFL0hob2RF?=
 =?utf-8?B?MHJydXJTb2lIaXNFSGJ4bXVUNEkwMFFCdE9ZY054dlhGcWlwSzZOTnZXTE5u?=
 =?utf-8?B?QnNiTi9NUDRNWGpCZk43eXNGK1ZUblNrajRrdGQxVUxBZm1sT09PbUl0cDVW?=
 =?utf-8?B?SUdEdWJ6eHplU3F0ZGJXOVE0bERqYTFIeHpyRGYzK0ZPdXNWeHlzSk5LQ2ZH?=
 =?utf-8?B?SVR4THRIenpLMUdiKzdJNHY0NUExYWlTN1poYnZOOHVlVWpxSDZMM3B3eFcr?=
 =?utf-8?B?RGxwVmNVa2VXR0VRalJoMmhnRlhGak4vRWY2QTBNNVU3Yk5Db3NkMG1mMkR5?=
 =?utf-8?B?Si83S25HMGRLT1BYNmFDRDFiMnIyNG9qZTFyd205OWppM3ljNEhmNUNwbFZS?=
 =?utf-8?B?MDZWRS9OVElRRklKNzAwaDFCa2p3ZUttYWZLUFUyK2s4QmRoVG1BVVNmdi83?=
 =?utf-8?B?MU5lSU9CSnFlQ1ZrN05PVTdhYmN0Q0tYVzRmSkgwcFF1cWxMQk9jd3VXUE1q?=
 =?utf-8?B?S01PcDcrQk91QWF3VFVONUNtSTJLcjBueFZVVHBTdjVxRnJWMm1HYkQzamNI?=
 =?utf-8?B?aHNKa3NEdVpUQXQxZFAxSXVzOTJqNElxVHJxZ2gyUG1mWUFESUl1dGdrMDVo?=
 =?utf-8?B?ck1kWDdDNjVXUElJNWNKL0NwTEZrMkplaVJHWXdpeHRrQ0hNTE03MmJZR3Vv?=
 =?utf-8?B?RDJNL1g4eVFUcTRHNWtha0hrRVR3ZEs2Y3BmQlRZWWZGRHhlVkpONlczbS9v?=
 =?utf-8?B?a1BMbE9GaThvVmRDVFBBemQybGtxL0wrcU84Q29WU01ILzhQVko5QU1mNXBE?=
 =?utf-8?B?UUNFLzJaVlBaM1JjVEFuRk5LYzF4a2dKNEpQNUVaSGQrdGlacVZrT2wwbFBy?=
 =?utf-8?B?R1A3Unkyc09aUUxIeTZySkJhSVNtajFqOE1yUUFYTXZveDlVbmg1SzdST1R3?=
 =?utf-8?B?QjIzY3RIdDlGN2d0b2xHcW1BTkZPaG54aUZpbTdMUVdUdFpxMGp3VDYvVHB6?=
 =?utf-8?B?YmpGTmdTdVc5ZWpHNmVpTGI4cm4zN0JPTDIvL2dITjRwblQwQXlMa1RHQTdZ?=
 =?utf-8?B?aXdCcUhrNk1RMDh5YUVnQytzam03bDRUZnZ3VE9BNkowMktjSDV5a3g5alZG?=
 =?utf-8?B?dy9hTlpDVFZDblJvblM4RGxrVGhCTVcyUlFhenRPUWkwMFV0MHcxMHBWbFBk?=
 =?utf-8?B?TmhBOVhMRTR2YjUwQzZHdTA0cFBDbU5PVlBxQTJQUmJEWGxzcWFTejZmc05j?=
 =?utf-8?B?emZGSW5EWkZpQm9UYXRxeXVWL0duajFPWklkMlVSN3d2WUFmdG5iamNmVytG?=
 =?utf-8?B?b0NPMWJ2ZDZjUmpBQTZ2Nm1hTWpxL01iVExlVUk4WUJacEFGeDZ2SmdScDl3?=
 =?utf-8?B?NUxTMU5sVkhOZlA1bG9idHBJWDhpYTNEOVZnU0JVRy9ydnd4L0plUitpN2FT?=
 =?utf-8?B?T1FZaDRKWFBVWUFZN05SRnJKWStEMDFQWUt4bkQ1N3RiN2JiVTB4emhWNjNl?=
 =?utf-8?B?d2hVTnFvRTFLQWorMi9yajFlSm5jdGZyMXdYVUkvUGRSYllrMVFtOTAzdmtm?=
 =?utf-8?B?UjFyT1p0RWdyV1B0eDlIOFNsRHRGWUVqTXZ3YjdpTVhHR1VSWHBad0NMRi9Y?=
 =?utf-8?B?MnRHTDJBNHRpZE5HNk1iNXRITXFPd3ZWdVRXMi9RS044R2pjVVhwRHlrSEZm?=
 =?utf-8?B?LzJCYUVxbFNCcFUxY0hVcVJYUXVIWFlDU3Y3WEZ3d3pwUWx2dW1haEpKeVFq?=
 =?utf-8?B?akYxSVN0Y1NLdC9xUCtJWHhTQlRTL1duekUzRXZPLytvS0JNTDdHR09FcXZk?=
 =?utf-8?Q?JRE7S6bNHjcfOrsxQB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iwDkc5OClT+tzsAvfMp6L9peON1QKQuZw4Ne702aVZl1KhouleV5aC5Sk6Xeu6bE6as96wrScZXFrtczfu6Ce5W1+EpVEDKdnY9Jg5u+FX8qcbR+a/5vGsfST4wbaYrHTWI7U+QQYm47J+YjozC+rvXeUL0Wxnh9HQWxCj3aTNz+ZnTcadCXFRJSeDkQ/p8EwYhb5qHJU8q1upDjTToGzRtSXuIE4PZ52v91CvTbeynKyOnniGux2Sm15ZN9R070tVFuaGc8YFl8wz8VuuVR82WZ3imSKmCH9JfOrCZqiaoq1JmPcv+Yd+pzePzgnyVs1sZUGi+h67ZS002YAnuWAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c4ddc7-e2ac-4d30-8f37-08dee08e6abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:25:41.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaqwxejufOCOQhgNtOMZOU/DDZoZ9UnriBXCL+PivhcAjitvj+7j7JSBfajWeyR3aJ8n+xwLSGwQ/1A3jx0Teg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC3B7BD011
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDEz
LCAyMDI2IDExOjE4IEFNDQo+IFRvOiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+DQo+IENj
OiBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIEhJRDogSW50ZWwtdGhjLWhpZDogSW50ZWwt
dGhjOiBBZGQgQVBJIHRvIHJlc2V0IHJlYWQNCj4gRE1BDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlv
dXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAyIHBvdGVudGlhbCBpc3N1
ZShzKSB0bw0KPiBjb25zaWRlcjoNCj4gLSBbQ3JpdGljYWxdIGB0aGNfcnhkbWFfcmVzZXRgIGlt
cHJvcGVybHkgY2xlYXJzIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGZvciBhbGwgRE1BDQo+IGNoYW5u
ZWxzIHdpdGhvdXQgcGF1c2luZyB0aGVtIGZpcnN0LCBwb3RlbnRpYWxseSBjYXVzaW5nIGFjdGl2
ZSBUWC9TVyBETUEgdG8NCj4gYWNjZXNzIHBoeXNpY2FsIGFkZHJlc3MgMC4NCj4gLSBbSGlnaF0g
RXJyb3IgcGF0aHMgaW4gYHRoY19yeGRtYV9yZXNldGAgZmFpbCB0byByZXN0b3JlIHRoZSBpbnRl
cnJ1cHQgcXVpZXNjZQ0KPiBzdGF0ZSwgcGVybWFuZW50bHkgZGlzYWJsaW5nIGRldmljZSBpbnRl
cnJ1cHRzLg0KPiAtLQ0KPiANCj4gLS0tIFBhdGNoIFsxXTogW1BBVENIIHYzIDEvM10gSElEOiBJ
bnRlbC10aGMtaGlkOiBJbnRlbC10aGM6IEFkZCBBUEkgdG8gcmVzZXQgcmVhZA0KPiBETUEgLS0t
IGNvbW1pdCA2NGIyMmMwZDg4Mjc1MWE2N2I3MDkzNTFkMmMyZTNkYWYyMTFiYjUyDQo+IEF1dGhv
cjogRXZlbiBYdSA8ZXZlbi54dUBpbnRlbC5jb20+DQo+IA0KPiBISUQ6IEludGVsLXRoYy1oaWQ6
IEludGVsLXRoYzogQWRkIEFQSSB0byByZXNldCByZWFkIERNQQ0KPiANCj4gVGhpcyBjb21taXQg
YWRkcyBhIG5ldyBoZWxwZXIgZnVuY3Rpb24gdGhjX3J4ZG1hX3Jlc2V0KCkgdG8gcGVyZm9ybSBh
IHJlYWQNCj4gRE1BIHJlc2V0LiBJdCBpcyBpbnRlbmRlZCB0byBiZSBjYWxsZWQgZm9yIFJ4RE1B
IHJlY292ZXJ5IHdoZW4gZmF0YWwgRE1BIGVycm9ycw0KPiBvY2N1ci4NCj4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLXRoYy1oaWQvaW50ZWwtdGhjL2ludGVsLXRoYy1kbWEu
Yw0KPiA+IGIvZHJpdmVycy9oaWQvaW50ZWwtdGhjLWhpZC9pbnRlbC10aGMvaW50ZWwtdGhjLWRt
YS5jDQo+ID4gaW5kZXggNmVlNjc1ZTBhNzM4NC4uN2NlYjhhZWVjY2QzNyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXRoYy9pbnRlbC10aGMtZG1hLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2hpZC9pbnRlbC10aGMtaGlkL2ludGVsLXRoYy9pbnRlbC10aGMt
ZG1hLmMNCj4gWyAuLi4gXQ0KPiA+ICtpbnQgdGhjX3J4ZG1hX3Jlc2V0KHN0cnVjdCB0aGNfZGV2
aWNlICpkZXYpIHsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKG11dGV4X2xvY2tf
aW50ZXJydXB0aWJsZSgmZGV2LT50aGNfYnVzX2xvY2spKQ0KPiA+ICsJCXJldHVybiAtRUlOVFI7
DQo+ID4gKw0KPiA+ICsJcmV0ID0gdGhjX2ludGVycnVwdF9xdWllc2NlKGRldiwgdHJ1ZSk7DQo+
ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkZXYtPmRldiwgIlF1aWVzY2UgaW50ZXJy
dXB0IGZhaWxlZCBkdXJpbmcgUnhETUENCj4gcmVzZXRcbiIpOw0KPiA+ICsJCWdvdG8gZW5kOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IHRoY193YWl0X2Zvcl9kbWFfcGF1c2UoZGV2LCBU
SENfUlhETUExKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldi0+ZGV2LCAi
V2FpdCBmb3IgUnhETUExIHBhdXNlIGZhaWxlZCBkdXJpbmcgUnhETUENCj4gcmVzZXRcbiIpOw0K
PiA+ICsJCWdvdG8gZW5kOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgc2tp
cCB1bnF1aWVzY2luZyB0aGUgaW50ZXJydXB0cz8gIElmIHRoY193YWl0X2Zvcl9kbWFfcGF1c2Uo
KSBmYWlscywgd2UNCj4ganVtcCB0byB0aGUgZW5kIGxhYmVsIGFuZCByZXR1cm4gd2l0aG91dCBj
YWxsaW5nIHRoY19pbnRlcnJ1cHRfcXVpZXNjZShkZXYsIGZhbHNlKS4NCj4gV2lsbCB0aGlzIGxl
YXZlIGRldmljZSBpbnRlcnJ1cHRzIHBlcm1hbmVudGx5IGRpc2FibGVkPw0KPiANCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwlyZXQgPSB0aGNfd2FpdF9mb3JfZG1hX3BhdXNlKGRldiwgVEhDX1JYRE1B
Mik7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkZXYtPmRldiwgIldhaXQgZm9y
IFJ4RE1BMiBwYXVzZSBmYWlsZWQgZHVyaW5nIFJ4RE1BDQo+IHJlc2V0XG4iKTsNCj4gPiArCQln
b3RvIGVuZDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwl0aGNfZG1hX3VuY29uZmlndXJlKGRldik7
DQo+IA0KDQpUaGlzIGlzIGV4cGVjdGVkLCB0aGNfcnhkbWFfcmVzZXQoKSBpcyBkZXNpZ25lZCBv
bmx5IGJlIGNhbGxlZCBpbiBmYXRhbCBETUEgZXJyb3IuIEluIHRoaXMgY2FzZSwgaWYgcGF1c2Ug
UnhETUEgZmFpbGVkLCBpdCBtZWFucyBETUEgZW5naW5lIGNhbm5vdCBiZSByZWNvdmVyZWQuDQoN
Cj4gW1NldmVyaXR5OiBDcml0aWNhbF0NCj4gQ2FuIHRoaXMgY2F1c2UgYWN0aXZlIFRYIG9yIFNX
IERNQSBlbmdpbmVzIHRvIGFjY2VzcyBwaHlzaWNhbCBhZGRyZXNzIDA/DQo+IA0KPiB0aGNfcnhk
bWFfcmVzZXQoKSBwYXVzZXMgVEhDX1JYRE1BMSBhbmQgVEhDX1JYRE1BMiwgYnV0DQo+IHRoY19k
bWFfdW5jb25maWd1cmUoKSB1bmNvbmRpdGlvbmFsbHkgaXRlcmF0ZXMgb3ZlciBNQVhfVEhDX0RN
QV9DSEFOTkVMDQo+IGFuZCBzZXRzIHRoZSBQUkQgYmFzZSBhZGRyZXNzIHRvIDAgZm9yIGFsbCBj
aGFubmVscywgaW5jbHVkaW5nIFRIQ19UWERNQSBhbmQNCj4gVEhDX1NXRE1BOg0KPiANCj4gdm9p
ZCB0aGNfZG1hX3VuY29uZmlndXJlKHN0cnVjdCB0aGNfZGV2aWNlICpkZXYpIHsNCj4gCWludCBj
aGFuOw0KPiANCj4gCWZvciAoY2hhbiA9IDA7IGNoYW4gPCBNQVhfVEhDX0RNQV9DSEFOTkVMOyBj
aGFuKyspIHsNCj4gCQlkbWFfc2V0X3ByZF9iYXNlX2FkZHIoZGV2LCAwLCAmZGV2LT5kbWFfY3R4
LQ0KPiA+ZG1hX2NvbmZpZ1tjaGFuXSk7DQo+IAkJZG1hX2NsZWFyX3ByZF9jb250cm9sKGRldiwg
JmRldi0+ZG1hX2N0eC0NCj4gPmRtYV9jb25maWdbY2hhbl0pOw0KPiAJfQ0KPiAgICAgICAgIC4u
Lg0KPiB9DQo+IA0KPiBJZiBhIHByZXZpb3VzIHRoY19kbWFfd3JpdGUoKSBvciB0aGNfc3dkbWFf
cmVhZCgpIHRpbWVkIG91dCwgaXQgdW5sb2Nrcw0KPiB0aGNfYnVzX2xvY2sgYnV0IGxlYXZlcyB0
aGUgVFgvU1cgRE1BIGVuZ2luZSBydW5uaW5nIGluIGhhcmR3YXJlLiBPdmVyd3JpdGluZw0KPiB0
aGUgUFJEIGJhc2UgYWRkcmVzcyB0byAwIHdoaWxlIHRoZSBlbmdpbmUgaXMgYWN0aXZlIGNvdWxk
IHJlc3VsdCBpbiBtZW1vcnkNCj4gY29ycnVwdGlvbiBvciBhbiBJT01NVSBmYXVsdC4NCg0KVGhp
cyBpcyBub3QgYSBwcm9ibGVtLCBBbGwgRE1BIG9wZXJhdGlvbnMgd2VyZSBwcm90ZWN0ZWQgYnkg
VEhDIGJ1cyBtdXRleCBsb2NrLg0KVGhlcmUgaXMgbm8gVHgvU1cgRE1BIG9wZXJhdGlvbiB3aGVu
IGNhbGxzIGludG8gdGhpcyB0aGNfcnhkbWFfcmVzZXQoKS4NCg0KPiANCj4gPiArDQo+ID4gKwly
ZXQgPSB0aGNfZG1hX2NvbmZpZ3VyZShkZXYpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRl
dl9lcnIoZGV2LT5kZXYsICJSZS1jb25maWcgRE1BIGZhaWxlZCBkdXJpbmcgUnhETUENCj4gcmVz
ZXRcbiIpOw0KPiA+ICsJCWdvdG8gZW5kOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXRoY19pbnRl
cnJ1cHRfcXVpZXNjZShkZXYsIGZhbHNlKTsNCj4gPiArDQo+ID4gK2VuZDoNCj4gPiArCW11dGV4
X3VubG9jaygmZGV2LT50aGNfYnVzX2xvY2spOw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0K
PiANCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3Bh
dGNoc2V0LzIwMjYwNzEzMDMwNDEyLjI1MzE5MzMtMS0NCj4gZXZlbi54dUBpbnRlbC5jb20/cGFy
dD0xDQo=
