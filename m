Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794461220;
	b=hhiyJCy5c0JdyPvFPi11FQZCrRi98ahEV7R+yMNw5Iobg3trW95XfGTZLrouRcCv1qV8
	 PzmwwFj6z6fO11uytlvXJnwARDOZDDos7hLBBTAUU5hW/tAkFkd0GXT400o9RInR9m8tl
	 dbCwQ2DUCklj3h8kzaGdgw2tq5dYwMPcm8L8jHHMx3ig41B0RxjXifb8y3kAXLuwOT05G
	 sDhefMB8G10sfJeOhcI0V7lk5yH7ZnW0c562olnwgGTH8QZTctpd5o0Q7/SWGcZg1gsyB
	 LJVV24WnWVAU8SupCq+9cjgsjn1kl5UlvxxJahsHe6JqbQHfFvjQwjde50DHRFViDXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:Received:DKIM-Signature:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-dg-rorf:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	bh=AzqBptsHOq8fJX7NHO2PgwHVush6I2S2TPV2VVfw4xk=;
	b=YYkgSkph4mo2pKLrnh30XuO1NSuXJOtrRXZmfCm6oyyYsF+Q+fJb9uadWJlSf1Brh6us
	 IlDb1HUS9ee6CgLx6G3v3oA21bldQB8tIkg+hHWK1r4tCCnRHL+bw49PWWcshtMzhjFW/
	 ZOdf1u8n18MC/jvwqgxzKjAv39hrPHlhzmNu6WgvBl6hGfYc1vCo3YQ6tjqMbuoX6Zjo8
	 3BYqw6LV6HD8p93ipnDmMBUGR/F8Q5K6tkhBPqTvGIjTIO7It1QQE71ZjKnTBQDyN/+Dq
	 cTcVpQ9Ouw9zweN+e31wzBI8JLCtyrR1yo4YIGBcCyi7Re2035YstNe+N62ELIaa09Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=emc.com.tw;
	spf=pass smtp.mailfrom=emc.com.tw;
	dkim=pass header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b=hGmuK9C5;
	dkim=pass header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=FMQGS2dh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A0606A32D;
	Thu, 12 Nov 2026 05:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8A0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b=hGmuK9C5;
	dkim=pass (1024-bit key, unprotected) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=FMQGS2dh
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com.tw; i=@emc.com.tw; q=dns/txt; s=emcselector;
  t=1794461226; x=1825997226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AzqBptsHOq8fJX7NHO2PgwHVush6I2S2TPV2VVfw4xk=;
  b=hGmuK9C5lkYIgM3yOs6T6Gdj5VJDMuCNB7YlTP1Pt9UzW6uW1yvyzmB/
   ojS5SsQC8zyCnS6hRVLnw+Z4FtfE1P1vI6cGhf5qxi3eqAs29kASiGCc9
   MsGVFntosc5brMJ+PWZjURumak++P8fxjhlbF/IHWoCjJdsnLM5vQ5tQv
   KdkNV1WjBY7leU1twzby30GCTDGU1Qfk1wmmiMSRqw1FYoFIiriCjAsXT
   2NfFln4VyLCnyfn98LaWCIstbPklonLB3533tTcn2emNj5pImapuHrwls
   1RAysyBw0sxli4Lxv1aT6lC812+A9TLR/KwfYhtNLpeV/v0M+H2RUeYSU
   Q==;
X-CSE-ConnectionGUID: AwLCd7i5RQiL33Qn9nDVRw==
X-CSE-MsgGUID: pXLWtrIgSoOEwMfITOiW5Q==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; 
   d="scan'208";a="14854699"
Received: from unknown (HELO ELAN-EX02.elan.corp) ([192.168.10.68])
  by emcscan.emc.com.tw with ESMTP; 12 Nov 2026 13:26:57 +0800
Received: from ELAN-EX02.elan.corp (192.168.10.68) by ELAN-EX02.elan.corp
 (192.168.10.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 13:26:49 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (40.93.129.52) by
 ELAN-EX02.elan.corp (192.168.10.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 12 Nov 2026 13:26:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmBpD4p9wyjuWue44Z83760PbNxosFzdk3WwIDWZc09S0B75VHrBHggadED3qFfjOmjPWwdXORLD5obwHWzbUItS1iBJBLM1O8ZHPtRrL2tuZD3CcVphNKk/0NyvbjKtVBf0MUo1vyMjzzaCqptS3EGZjWwrC4Z4W6sz9B2estZoPL9c6R9l/RRxY+e/SselG30IC0WwiNEQqWyxlObd9WWzIWVRkaVjnC2P7EFApSDzKiroAto3Q4dxCCm8OUjkifj31vWB0M65JCkZ32Y9IP7pJxoeErmyxJ/7TkeRFXVLrQcX9iCnDhKKqO3cyaDLY6Q0sOrTcY1OS//syu9arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzqBptsHOq8fJX7NHO2PgwHVush6I2S2TPV2VVfw4xk=;
 b=KC2NkpTeEtfPWItudKJfKPxxwvHGvPQ23qe8jugf12GG/efdejmWc5ymdBE6csXb2xrn6rgyWdGQevjDg33BWv2me+DJw0AKlB2cLCNG76bDQAYOxtGh/KAUHGwhBba3CCCq4HH5/Uz7NAzQqRObjau/n4GuNC+8omxfocuxdC9Rnv7Ycbr46Fck3VDqBCi++pu+TQiaWmgLaAHUzeVbe13xIJUzil8kBhNo5J0HNml0dRg3lRJnnSbQUMuKs6IGVloKOKnz8y7s6JhYfAG8IYak+N3+nWLw6U0hWOuZAxoDB3Y0qa85VkyVfibVEHhM47Ae+W8ddP+NHldOCLGpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emc.com.tw; dmarc=pass action=none header.from=emc.com.tw;
 dkim=pass header.d=emc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emccomtw.onmicrosoft.com; s=selector1-emccomtw-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzqBptsHOq8fJX7NHO2PgwHVush6I2S2TPV2VVfw4xk=;
 b=FMQGS2dhUiY/4tiTkPMh0J3VzXbivKV2PcWmmQuAHl3WDJax14E4MQU7Q7qcWniBuDcnD7wfOyqlY/m8j5loa9AZxGGlhDBW8tzAf1GV7yKG/gXQC0ovF+P2JkHRx6/fUB2rWGX5vTc+GJKouPluIrPCDxmEyGchz3KEJS581iI=
Received: from TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::8) by PUZPR01MB5070.apcprd01.prod.exchangelabs.com
 (2603:1096:301:117::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 05:26:47 +0000
Received: from TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 ([fe80::5e11:25f3:7e0c:ad3f]) by
 TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 ([fe80::5e11:25f3:7e0c:ad3f%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 05:26:47 +0000
From: =?utf-8?B?SmluZ2xlIFd1IOWQs+mHkeWciw==?= <jingle.wu@emc.com.tw>
To: Yao Yuan <yaoyuan0329os@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Vishnu
 Sankar" <vishnuocv@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?UGhvZW5peCBIdWFuZyDpu4PkuJbptaw=?=
	<phoenix@emc.com.tw>, =?utf-8?B?U3RhbmxleSBDaGVuIOmZs+W7uue2rQ==?=
	<stanley.chen@emc.com.tw>
Subject: RE: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Topic: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Index: AQHdcLxNHDP5k3yfMUe0H4sA60xFjrcmxlaggACMhQCAAOLloIAAtAuAgADEwWA=
Date: Thu, 12 Nov 2026 05:26:46 +0000
Message-ID: <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
 <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza>
In-Reply-To: <avRttU9N0EZeq8nY@sapienza>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4786:EE_|PUZPR01MB5070:EE_
x-ms-office365-filtering-correlation-id: 742ada8c-306b-4d92-339f-08df407d8bd4
x-ld-processed: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|38070700021|10067099003|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: YxQ21SfVQLWJaqnMXFEtgEE4dFHi2YnHm/l2LRSzz5xk0GKgBqipbG+zeOsQ2R2EjwGWgEvN0zAlzVhigyaPFoCtSCBzhREN/uvDVTe+5UrECjrGEpOswRa11kiwUEllRwDUt16yF9UfJY93l5LjaXjUKFqi/GdI8aNjf7bv7o2U3b3OJFrX4QBMjqxms0iJuGt7bkRn2plA0QlwilTRaA57SuKPkNubeE2va6cL5d2LWoi4I6uj0EiF/4u5j5EUf+7VkPpEe/xH7/9ktJA+alkFIANPpTh+AD83BCPc3mkHIk503/0hVwa1+ygcwlniUfq+cIPA8H9+q7EhEMH1oHffPFSbxoN3w26AUPRmChTG3YkTXMGWBr/+08G5GtPdhSLwuwJYWElRDe1DCqDCYi8WtApPCeU7c+yZEvwxjKOkH/EqEcF1ItgAMm90QZkvQPYvMj357nuW9kJbKP1vuKz8jHJVWmOLRZs2vx7DcA68NT243m2IsrPjzRFFiyRVGPyOGc6fTxllhU73je2guympnaKxuJYYwEMCpi2wR3QrnYTQWYKE/Foae0Fv1FIw/e4wzDtkAggLswyRFJq0CoFiflBZQ4GY6IheKCKI2dKniIEadhsFIzSPf3LHykputgDuOaE74KrBYf/insmHCygnFUCo13qskmZhdBKJQSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4786.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(38070700021)(10067099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFlZb2pDK09WdHJDaktVVjNaVkU1TW8wRjFpVWFLMnZFWGNwV3dwNU1lcWlR?=
 =?utf-8?B?aU1MSkRzOFcxQ2x1TUlIU085T3FJaGhGMWQzWFVLMWZmTVUxQ3NTTllGNitU?=
 =?utf-8?B?Rnk1emY5YjBFVUdMenhINWR1NkRKMVhRU3hnU0dmVGNIRDM3Smp0R3BFckUr?=
 =?utf-8?B?TldydERIUldTS0xHdlhEM3FXT3pSYU1FdkxaQjRVdmpDY3N0TE5RRTg1RmYv?=
 =?utf-8?B?RUJjOTc1T1FNUnBMbFcvd3ZpUE1LZ2xwRVQvN3kybUJCR2hVVlh4QkhzazRL?=
 =?utf-8?B?Zi81bWpiWWFITW94czE0dm5pVGl3YnZQdklvTFp1dUlSY3pQaXBOeTZjSnNz?=
 =?utf-8?B?VVZaaDVjeGNjWXhnYjJGOW01N2ZoTzhYWldLeUh5WFBJZWFaeW5lV0J6SExK?=
 =?utf-8?B?QjNvOEdKNzltaEd3ZFlHdjZZS3U2YzhkMU9WSzUzT3h0a09WdklWc3M5RjFC?=
 =?utf-8?B?eGRjdFltQ3VqVDU2ald1YzhhZU1JM1R6SUNUeDRmS25TQnFDUldzNjRqZlFC?=
 =?utf-8?B?eVd6OU9yWkVUR2FwL3EzZzlubHdlQk9QeDR4OEMxM1dLS2hiay9adWdaNWYz?=
 =?utf-8?B?b2VQQlEzVnFuUS9OSUZ4Sk9ObGp5elBVVldKKzFYYTRLT3JwZzJodHdKMllC?=
 =?utf-8?B?THh1MVlNZ2ZNMVRNZzZ4d2FJRi9FMHoxc1duWEhLSzBZZVo0S3BVYVlmRTBp?=
 =?utf-8?B?MklBMExyZmo4VTMzK3NqUERMU1h0S2R4bzZJaTlNaHNCUjR6R0NseGMrMHY1?=
 =?utf-8?B?Yjd2SGs5bURBeFYzSjJFQmYzeHc4am9hNjFSNUF1ZVRMVEpLNWxVRFN3Vnl6?=
 =?utf-8?B?U3lvUERYaXZQazViS0NNSkdmb3p0WnRvMllQa09EZ3VUVHZWbHR4RE1DYUR4?=
 =?utf-8?B?bVV3b3lBWGVUSnFCSng0YWRmaXcvWnMvMnVySDZLNHZjL0RsSk1JbnptZGRk?=
 =?utf-8?B?SjRpVHdZekx6R3hkbkhMR3A3RlBjSGhub3ZJSHlNck9oWHBnaExyclNvMlBv?=
 =?utf-8?B?Z0xGYXVyQlprUFN6bzZvWHFKWE4vV3EzSUVqaHdWVTNPeWh2V09jM09qTTNC?=
 =?utf-8?B?ajJqTElucmhDakE5MGpKTjk4WDFjZGpxdEdmb1JUZ1Z0bWJrVUgvRDU1QWY1?=
 =?utf-8?B?SEx4Qit4MS80WUtiRllmTkVjYzg3K2VDQ2k2aFZWQ1VkRlpOT3BlaklhdFFS?=
 =?utf-8?B?VTUzL2ttMGptUDJaeFYzVHdhOHdqZlpqYzl6TEZUU010RGdWblBXbkJ0STFR?=
 =?utf-8?B?UmJyRVdxeDVramkwQmpOeXU4VFI1YWE0d205UGc3R0FBVjZTRWNhQ1RSOVRU?=
 =?utf-8?B?Yk5NdUVIMi9Ka2hVcGhPbzNUOS85clhhNThBSzc0RzVVNVlsYUdJYzVJV2ZI?=
 =?utf-8?B?Z2pZdDREbk93emx1WmltaUs3Z2YwSThjOWh6ZnkvWlE2Y2xCSFVpNmVUNE41?=
 =?utf-8?B?bk8wd0oyYmlqL2F0VlNkZmRUZUlMSnNlVmJ0a01iYU1YTWs0c3U5WmJwYmtl?=
 =?utf-8?B?ckNPRjJXZFBNYTdQZE1nMjlvK1ppYzFYa04wUHJhVXkxWk43ZHJYSUlwa0t5?=
 =?utf-8?B?RFdDbnFhMEdHRmlQckRLMm9wblAvTE9jbXRhZG52ZDJiampOU3NqTGVHUHJJ?=
 =?utf-8?B?R2l5VUdhVHhDTlBHcDhIT08rQ2NzQ3pRZFBGMU1MTU1ZZzBHVEN2dDNiWmxB?=
 =?utf-8?B?VUh4MUtwcXJ3anQ5SStrd0xwajJYVGNBQ0g1SHY1WllkNWliTVpPZDAvNzZE?=
 =?utf-8?B?cHdQTFIvUUczUjE2aXJseG9HeXBRT09iek8wVGY2bS9lQTFBWmlJUm9yNUZB?=
 =?utf-8?B?TlMyM2JnSnhUdDFhS3B2aHR5WGQzcEMvZElxd1VpR28yUU4xVkR6T1RPa0gv?=
 =?utf-8?B?Y2hNcUp2TW5uQ01YM1A1QkJ2b1JPVDI1Mi83YXkzYk9pbTBhS0N0YUd0Y0My?=
 =?utf-8?B?ZFdNVVJBd0IxL0FUaFFoYmk5dU9LTEM0VVgybzBHdE9FVWFnWkRvWUZITURR?=
 =?utf-8?B?QzNWVFNrdFdjQWc5K1VXMExWUUVnajRWNEV4b1AyMSs4RFVZTE5SenJMbTln?=
 =?utf-8?B?Vjl4ODV2YUhjNVNpUTd4OE5PdVhyS2huMEY0RHk3dWlWNTdJT2Ric0hDa25j?=
 =?utf-8?B?RGFMRU1oRE14TUpzQ0Y1RzJVeEE3amI1NXd4UEFPK2g5MHJ6NUlwU3ZXdjc0?=
 =?utf-8?B?enVJTStzL1JRUnRIVWdMM3B0ejdzeWRhNEJ4aTFBNktxWjRRdXhNdkU0ODRs?=
 =?utf-8?B?bUJyUkdSMVJYeEE3TlFFT0dNbVZOT044ajFNS2ZSa3BwMWFhaWxFNm4xRU1T?=
 =?utf-8?B?Tm9iMytXVG42Y2RJcWl1amY0RE1Ob2FpNkFBRXNKQTQvU1NqUlVNdz09?=
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
X-Exchange-RoutingPolicyChecked: tX1TrEuqA/pV5qZM8uPsaZfZc+gaNdM0dr7WRsNJamaScDJtrxiPw2XX3kAE34eZww/Iqr7u9ZiKSbMryKC2MfpUYRJz64CSm6oOR2xo0MC4VC2nfMwSWi6zxvf7yTJm54s0EFdOaf1HM1Qw22QyoywrpzfqmU8dXbE9W1DNTPJ4Q+EM8U4RQK6kOcfcemU7K/eLwqNu15lYX9uN0KsNGBQaaEq6KN5rCM4XrIPke43leG392ajaETBpWHw09Cjzqj97m87u6kNWnjV9hPWrT4RzVuYasoIY4/Da3gCStOpY5WhqDFWCzzMrIiR6QY2HMlim+5dupoMI5PUpp9rIoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742ada8c-306b-4d92-339f-08df407d8bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:26:47.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piuH5KVEOGCWRFI4jJKzRRAVnG+XZSkg5TmBr4R6IoANY+EXl4ZVns7fG+cHj9yZln+5RAqU24Y1sOVVzm87sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5070
X-OriginatorOrg: emc.com.tw

SGkgWWFvOg0KDQpVcG9uIGlucXVpcnksIGl0IHdhcyBjb25maXJtZWQgdGhhdCBhIGJsYWNrIFRy
YWNrUG9pbnQgc3RpY2sgKDB4MDcpIHVuZGVybmVhdGggdGhlIHJlZCBUcmFja1BvaW50IGNhcCBj
b3JyZXNwb25kcyB0byBhIHZlbmRvciB0aGF0IGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgV2luZG93
cyBFTEFOIGRyaXZlci4NCg0KVEhBTktTDQpKSU5HTEUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFlhbyBZdWFuIDx5YW95dWFuMDMyOW9zQGdtYWlsLmNvbT4gDQpTZW50OiBX
ZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDEwOjA1IFBNDQpUbzogSmluZ2xlIFd1IOWQs+mH
keWciyA8amluZ2xlLnd1QGVtYy5jb20udHc+DQpDYzogRG1pdHJ5IFRvcm9raG92IDxkbWl0cnku
dG9yb2tob3ZAZ21haWwuY29tPjsgSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXgu
aW50ZWwuY29tPjsgVmlzaG51IFNhbmthciA8dmlzaG51b2N2QGdtYWlsLmNvbT47IGxpbnV4LWlu
cHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGhvZW5p
eCBIdWFuZyDpu4PkuJbptawgPHBob2VuaXhAZW1jLmNvbS50dz47IFN0YW5sZXkgQ2hlbiDpmbPl
u7rntq0gPHN0YW5sZXkuY2hlbkBlbWMuY29tLnR3Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzFd
IElucHV0OiB0cmFja3BvaW50IC0gQWRkIG5ldyBFTEFOIHRyYWNrcG9pbnQgZGV2aWNlIHZhcmlh
bnQgaWQgNw0KDQrimqAgRXh0ZXJuYWwgRW1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgdGhlIG9yZ2FuaXphdGlvbi4gUGxlYXNlIHVzZSBjYXV0aW9uIHdoZW4gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cy4NCuKaoCDlpJbpg6jpg7Xku7bvvJog5q2k6YO15Lu25L6G
6Ieq5YWs5Y+45aSW6YOo77yM6KuL6Ky55oWO6ZaL5ZWf6YCj57WQ5oiW6ZmE5Lu244CCDQoNCk9u
IFdlZCwgTm92IDExLCAyMDI2IGF0IDA1OjI2OjM2QU0gKzAwMDAsIEppbmdsZSBXdSDlkLPph5Hl
nIsgd3JvdGU6DQo+IEhpIFlhbzoNCj4NCj4gQ291bGQgeW91IGhlbHAgdmVyaWZ5IHdoZXRoZXIg
dGhlIGNvbG9yIG9mIHRoZSBUcmFja1BvaW50IHN0aWNrIHVuZGVybmVhdGggdGhlIHJlZCBjYXAg
Y2FuIGJlIHVzZWQgdG8gaWRlbnRpZnkgdGhlIHZlbmRvcj8NCj4NCj4gV2hpdGU6IEVMQU4NCj4g
T3RoZXIgY29sb3JzOiBPdGhlciB2ZW5kb3JzDQoNCkhpIFd1LA0KDQpUaGUgdGhpbiBzdGljayB1
bmRlciB0aGUgcmVkIGNhcCBpcyBibGFjay4NCg0KQWxzbyBJIHZpc2l0ZWQgdGhlIGxlbm92bydz
IHN1cHBvcnRpbmcgd2Vic2l0ZSwgdGhlcmUncyBvbmx5DQoxIEVMQU4gZGlydmVyIGZvciB0aGlz
IHRoaW5rcGFkIFgxNCBnZW4xIG1vZGVsJ3MgdHJhY2twb2ludDoNCg0KaHR0cHM6Ly9uZXd0aGlu
ay5sZW5vdm8uY29tLmNuL2RyaXZlTGlzdC5odG1sP3NlbG5hbWU9VGhpbmtQYWQlMjBYMTQlMjBH
ZW4xDQoNClRoZSBsYXB0b3AgbW9kZWwgSSdtIHVzaW5nIGlzIDIxWE0sIHRoZSBkcml2ZXIgd29y
a3Mgd2VsbCBpbiB3aW5kb3dzIDExLg0KDQpOb3cgSSdtIGNvbmZ1c2VkIG9uIHdobyBpcyB0aGUg
cmVhbCB2ZW5kb3Igb2YgdGhpcyB0cmFja3BvaW50IGRldmljZS4gSSBtYXkgYXNrIGhlbHAgb24g
TGVub3ZvJ3Mgc3VwcG9ydGluZyB3ZWJzaXRlIHlldC4gV3UsIGlzIHRoYXQgb2sgdG8gcmVmZXIg
dGhpcyBtYWlsIHRoZXJlID8NCg0KPg0KPiBUaGFua3MNCj4gSklOR0xFDQo+DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlhbyBZdWFuIDx5YW95dWFuMDMyOW9zQGdtYWls
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTAsIDIwMjYgOTo0OCBQTQ0KPiBUbzog
SmluZ2xlIFd1IOWQs+mHkeWciyA8amluZ2xlLnd1QGVtYy5jb20udHc+DQo+IENjOiBEbWl0cnkg
VG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+OyBJbHBvIErDpHJ2aW5lbiANCj4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPjsgVmlzaG51IFNhbmthciA8dmlzaG51b2N2
QGdtYWlsLmNvbT47IA0KPiBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFBob2VuaXggDQo+IEh1YW5nIOm7g+S4lum1rCA8cGhvZW5peEBl
bWMuY29tLnR3PjsgU3RhbmxleSBDaGVuIOmZs+W7uue2rSANCj4gPHN0YW5sZXkuY2hlbkBlbWMu
Y29tLnR3Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gSW5wdXQ6IHRyYWNrcG9pbnQgLSBB
ZGQgbmV3IEVMQU4gdHJhY2twb2ludCANCj4gZGV2aWNlIHZhcmlhbnQgaWQgNw0KPg0KPiDimqAg
RXh0ZXJuYWwgRW1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9y
Z2FuaXphdGlvbi4gUGxlYXNlIHVzZSBjYXV0aW9uIHdoZW4gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cy4NCj4g4pqgIOWklumDqOmDteS7tu+8miDmraTpg7Xku7bkvoboh6rlhazlj7jlpJbp
g6jvvIzoq4vorLnmhY7plovllZ/pgKPntZDmiJbpmYTku7bjgIINCj4NCj4gT24gVHVlLCBOb3Yg
MTAsIDIwMjYgYXQgMDU6MjY6MjFBTSArMDAwMCwgSmluZ2xlIFd1IOWQs+mHkeWciyB3cm90ZToN
Cj4NCj4gSGkgV3UsDQo+DQo+ID4gSGkgRG1pdHJ5L1l1YW46DQo+ID4NCj4gPiBXZSBoYXZlIGNv
bmZpcm1lZCB0aGF0IEZXIEExIHdhcyBuZXZlciByZWxlYXNlZCBieSBFbGFuLiBUaGUgRWxhbiBW
YXJpYW50IElEIGhhcyBhbHdheXMgYmVlbiAzLg0KPg0KPiBUaGFua3MgZm9yIHlvdXIgaW5mb3Jt
YXRpb24sIExldCBtZSBzaGFyZSBtb3JlIGRldGFpbHM6DQo+DQo+IFRoZSB0cmFja3BvaW50IGhh
cyBkcml2ZXIgZnJvbSAiRUxBTg0KPiBNaWNyb2VsZWN0cm9uaWNzIENvcnAuIiBpbiB3aW5kb3dz
IDExIG9uIHNhbWUgZGV2aWNlLg0KPg0KPiBJbiBMaW51eCBJIGZvdW5kIHRoZSBkZXZpY2UgaXMg
cHJvYmVkIGFzIGdlbmVyaWMgbW91c2UgZGV2aWNlIGJ1dCBub3QgDQo+IHRyYWNrcG9pbnQgZGV2
aWNlLCBpdCdzIGhhcmQgdG8gdXNlIGR1ZSB0byBubyBzZW5zaXRpdml0eSBzZXR0aW5nIGZyb20g
DQo+IHN5c2ZzLiBJIGZvdW5kIHRoZSByZXBvcnRlZCBpZA0KPiAweDcgaXMgbm90IGluIGRyaXZl
cnMvaW5wdXQvbW91c2UvdHJhY2twb2ludC5jJ3MNCj4gdHJhY2twb2ludF9zdGFydF9wcm90b2Nv
bCgpIGFmdGVyIGRlYnVnZ2luZywgdGhlIHRyYWNrcG9pbnQgaXMgcHJvYmVkIGFuZCB3b3JrcyB3
ZWxsIGFmdGVyIGFkZCB0aGUgaWQgMHg3IHRoZXJlLg0KPg0KPiBTbyBJIHRob3VnaHQgdGhpcyBz
aG91bGQgYmUgYSBFTEFOIGRldmljZSB3LyBJRCAweDcgYW5kIGNvb2tlZCB0aGlzIHBhdGNoLg0K
Pg0KPg0KPiA+DQo+ID4gVEhBTktTDQo+ID4gSklOR0xFDQo+ID4NCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92
QGdtYWlsLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyNiAxMDozNiBB
TQ0KPiA+IFRvOiBZdWFuIFlhbyA8eWFveXVhbjAzMjlvc0BnbWFpbC5jb20+OyBKaW5nbGUgV3Ug
5ZCz6YeR5ZyLDQo+ID4gPGppbmdsZS53dUBlbWMuY29tLnR3Pg0KPiA+IENjOiBJbHBvIErDpHJ2
aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+OyBWaXNobnUgU2Fua2FyIA0KPiA+
IDx2aXNobnVvY3ZAZ21haWwuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyANCj4g
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQaG9lbml4IEh1YW5nIOm7g+S4lum1rCAN
Cj4gPiA8cGhvZW5peEBlbWMuY29tLnR3PjsgU3RhbmxleSBDaGVuIOmZs+W7uue2rSA8c3Rhbmxl
eS5jaGVuQGVtYy5jb20udHc+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIElucHV0OiB0
cmFja3BvaW50IC0gQWRkIG5ldyBFTEFOIHRyYWNrcG9pbnQgDQo+ID4gZGV2aWNlIHZhcmlhbnQg
aWQgNw0KPiA+DQo+ID4g4pqgIEV4dGVybmFsIEVtYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIFBsZWFzZSB1c2UgY2F1dGlvbiB3aGVuIG9w
ZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMuDQo+ID4g4pqgIOWklumDqOmDteS7tu+8miDmraTp
g7Xku7bkvoboh6rlhazlj7jlpJbpg6jvvIzoq4vorLnmhY7plovllZ/pgKPntZDmiJbpmYTku7bj
gIINCj4gPg0KPiA+IEhpIFl1YW4sDQo+ID4NCj4gPiBPbiBNb24sIE5vdiAwMiwgMjAyNiBhdCAw
OTowODozNlBNICswODAwLCBZdWFuIFlhbyB3cm90ZToNCj4gPiA+IFRoZSBuZXcgRUxBTiB0cmFj
a3BvaW50IHZhcmlhbnQgaWQgNyBpcyBmb3VuZCBvbiB0aGlua3BhZA0KPiA+ID4gWDE0IEdlbjEg
bGFwdG9wKFByb2R1Y3QgTmFtZTogMjFYTUEwMDZDRCksIGl0J3Mgbm93IGluY29ycmVjdGx5IA0K
PiA+ID4gcHJvYmVkIGFzIEdlbmVyaWMgb3IgTG9naXRlY2ggUFMvMiBtb3VzZS4NCj4gPiA+DQo+
ID4gPiBBZGQgRUxBTiB2YXJpYW50IGlkIDcgdG8gbWF0Y2ggdGhlIFRQX1JFQURfSUQgY29tbWFu
ZCByZXR1cm4gDQo+ID4gPiB2YWx1ZSwgcHJvYmUgdGhlIGRldmljZSBhcyB0cmFja3BvaW50IGNv
cnJlY3RseS4NCj4gPiA+DQo+ID4gPiBCRUZPUkU6DQo+ID4gPiBpbnB1dDogUFMvMiBHZW5lcmlj
IE1vdXNlIGFzDQo+ID4gPiAvZGV2aWNlcy9wbGF0Zm9ybS9pODA0Mi9zZXJpbzEvaW5wdXQvaW5w
dXQ2Mw0KPiA+ID4NCj4gPiA+IEFGVEVSOg0KPiA+ID4gcHNtb3VzZSBzZXJpbzE6IHRyYWNrcG9p
bnQ6IEVsYW5fdmFyaWFudDcgVHJhY2tQb2ludCBmaXJtd2FyZTogDQo+ID4gPiAweGExLA0KPiA+
ID4gYnV0dG9uczogMy8zDQo+ID4gPiBpbnB1dDogVFBQUy8yIEVsYW5fdmFyaWFudDcgVHJhY2tQ
b2ludCBhcw0KPiA+ID4gL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8xL2lucHV0L2lucHV0
NjUNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFuIFlhbyA8eWFveXVhbjAzMjlvc0Bn
bWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9p
bnQuYyB8IDIgKysgDQo+ID4gPiBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuaCB8IDEg
Kw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbW91c2UvdHJhY2twb2ludC5jDQo+ID4gPiBiL2Ry
aXZlcnMvaW5wdXQvbW91c2UvdHJhY2twb2ludC5jDQo+ID4gPiBpbmRleCAzYmQ4ZmRmNTZjZDMu
LmY0NmZjMTY2NWM5NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaW5wdXQvbW91c2UvdHJh
Y2twb2ludC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuYw0K
PiA+ID4gQEAgLTI1LDYgKzI1LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB0cmFja3Bv
aW50X3ZhcmlhbnRzW10gPSB7DQo+ID4gPiAgICAgICBbVFBfVkFSSUFOVF9OWFBdICAgICAgICAg
ICAgICAgID0gIk5YUCIsDQo+ID4gPiAgICAgICBbVFBfVkFSSUFOVF9KWVRfU1lOQVBUSUNTXSAg
ICAgID0gIkpZVF9TeW5hcHRpY3MiLA0KPiA+ID4gICAgICAgW1RQX1ZBUklBTlRfU1lOQVBUSUNT
XSAgICAgICAgICA9ICJTeW5hcHRpY3MiLA0KPiA+ID4gKyAgICAgW1RQX1ZBUklBTlRfRUxBTl9J
RF83XSAgICAgICAgICA9ICJFbGFuX3ZhcmlhbnQ3Ig0KPiA+DQo+ID4gSSB3b25kZXIgaWYgd2Ug
cmVhbGx5IG5lZWQgdG8gc2F5ICJFbGFuX3ZhcmlhbnQ3IiBvciBpZiB3ZSBzaG91bGQgc2ltcGx5
IHNheSAiRWxhbiIgaGVyZSBhcyB3ZWxsLg0KPiA+DQo+ID4gSmluZ2xlLCBpcyB0aGlzIHlvdXIg
cGFydD8gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBmcm9tIEVsYW4gdHJhY2twb2ludCByZXBvcnRp
bmcgMHgwMyBhcyBpdHMgdmFyaWFudD8NCj4gPg0KPiA+IFRoYW5rcy4NCj4gPg0KPiA+IC0tDQo+
ID4gRG1pdHJ5DQo=
