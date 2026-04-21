Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BC30BF5C;
	Tue, 21 Apr 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.72.220.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754889; cv=fail; b=pQAShun11lw/k8Sod6fegQtWbyCVPip5aaJpMH4S4or78BvlXOwDLkxiTYrJBq+sQ1g/PRuU/YQcRsCCJ5HAZ21kdC2EUwh5KzT//jtzRVo2bvG4ClKhC2Ikt6KvRYUsm5WupIX368ULPpH6/SjvTxENpehlgc70nZIDzwVQntY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754889; c=relaxed/simple;
	bh=TqKkFN8FNaY80otxnssULB67U2sY8bMJQzekh+ygwDo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZQQgC7OkMmIk9ARsygGpJtipEztgrYiyiWUwzYH9IUp2c4vUPAaqQw6aSgjdAZWgpk7DGu4cGDvhF83GrGWmXV32BzyQLY6N2S6jJchFWcjJR9fVdRVSdwBUgIVhvB5MRvVKwwD/USWMyFJbFjrbQN8nH+ifdu/S4nxwSyg6eqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw; spf=pass smtp.mailfrom=emc.com.tw; dkim=pass (2048-bit key) header.d=emc.com.tw header.i=@emc.com.tw header.b=Yequehjc; dkim=pass (1024-bit key) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.b=Jil2nsY6; arc=fail smtp.client-ip=192.72.220.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emc.com.tw header.i=@emc.com.tw header.b="Yequehjc";
	dkim=pass (1024-bit key) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.b="Jil2nsY6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com.tw; i=@emc.com.tw; q=dns/txt; s=emcselector;
  t=1776754885; x=1808290885;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TqKkFN8FNaY80otxnssULB67U2sY8bMJQzekh+ygwDo=;
  b=Yequehjc0uyjI5X4MtBOG/ZPTmd8ZQLNLavzRMeVMhyoQSm2e03OZzC0
   MdQO4BoNeX+ZVLRAHy3+9GqbGz0jnBOP3opt86M4AlJGTeXvu9CojlEd7
   T2UbFH+xkxxGJi04TkzXP7DoyTfmcWqBdr9i250HTF3bzjUodm5Ad2SiL
   ZKZH86UwrLR4Rd/FIg8L6e3yFqTeRQ11ASvAhlCwx16tOTxfnre5fhFqy
   sm09kOyv9KCVhP4GNCGMSmvqb9tfvJAir1gU7katinjsjkJ16DvstUp4y
   sOpp3mCu8zXqR7+Ow8Ww+ZA6er7PQDzA1lEpzrsrH4MiWa9JK4Xe5BuUP
   A==;
X-CSE-ConnectionGUID: NBarMJK3SzCk3Vn288eL+g==
X-CSE-MsgGUID: 6YEVkfPBQseziMvLQ73InQ==
X-IronPort-AV: E=Sophos;i="6.23,191,1770566400"; 
   d="scan'208";a="13177335"
Received: from unknown (HELO ELAN-EXMBX01.elan.corp) ([192.168.10.67])
  by emcscan.emc.com.tw with ESMTP; 21 Apr 2026 15:00:13 +0800
Received: from ELAN-EXMBX01.elan.corp (192.168.10.67) by
 ELAN-EXMBX01.elan.corp (192.168.10.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 21 Apr 2026 15:00:13 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (40.93.129.120) by
 ELAN-EXMBX01.elan.corp (192.168.10.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33 via Frontend Transport; Tue, 21 Apr 2026 15:00:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiihP6v8Rs1WRRH4PU5zmLBoks33hkIKIS5hb9p2xKatX4jxFChgafa/I1rqltHNrgKBNBzHlgU04cbBjBaiC1CxNgabqFuniR8S2Tew5BhkGMoELFZ52d5vi8rPYDECQQ1Y43bRc3xK3KEPUKCOI2jaXOCr8Ax4uM39aV5SkN0byCii/qDZtlSM+fj29WyRWrgUiEZzlDIu5jlSb3jPxd8X5hmDTZNGnnV78flmxnc0L9/6k3TBualRU8IIaWBZkYNL3ENs8GhFMeDVU2RyRXbdnGWITq/kFclSvdTBzSLhIZ9N1Tk7AfxL8LgyJ4I2bcgPw+64Ys70/vwgQz3a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqKkFN8FNaY80otxnssULB67U2sY8bMJQzekh+ygwDo=;
 b=Z+LSLaVTdwOzEXDRcvzi27XiZ7za8n+Ocu23CRL3DThIT5wVF18SSFBIQQJZM+H1yzQhpQdhnVA7Qkk8zPDrF38hU0YczjvjgYXbLJZXwGI45NHOIfvuaQ7HyJ/aALxzVgDbK7gx3c+tsegOl0li6B5rZdNmtoRHTPryTgH5DTWGp0n5zYJ8T5zhWYFBDMiHlZW+Fl9RJ+5AN188U7otOa0N319X8GzxwG8/m1dk3Vvf/jvhdxUqHhGbpyYAGpZaBjmlx4oDuF6WMTrH/zxdIbN1B604pCsyrY5b62CD/qxAwAqYnyWl1a/ZQE0YrDQvlVUtgQvFDFEe2j/CfPDcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emc.com.tw; dmarc=pass action=none header.from=emc.com.tw;
 dkim=pass header.d=emc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emccomtw.onmicrosoft.com; s=selector1-emccomtw-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqKkFN8FNaY80otxnssULB67U2sY8bMJQzekh+ygwDo=;
 b=Jil2nsY6CROnmgHqPHFd2c5u1ajPdD0KYPXxAsxXE3Fv5YbNvq9BSqZlMYKubOog8Bv60X9mPMGeb8tnmUw9OChGb9JaSnuE6q5QOn6fR8r2BhXESkUHNk13sOf1DoqiuouPlQOJAODVRFD2MXbYtNUQ3PtPE6l0S4n/r7stqAY=
Received: from KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 (2603:1096:820:dd::14) by SI2PR01MB4499.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:00:10 +0000
Received: from KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 ([fe80::dccb:b51b:bbd3:1bfc]) by KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 ([fe80::dccb:b51b:bbd3:1bfc%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:00:10 +0000
From: =?big5?B?SmluZ2xlIFd1IKdkqvew6g==?= <jingle.wu@emc.com.tw>
To: "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>,
	"Linux-input@vger.kernel.org" <Linux-input@vger.kernel.org>,
	"Dmitry.torokhov@gmail.com" <Dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - Add ic type 0x19
Thread-Topic: [PATCH] Input: elan_i2c - Add ic type 0x19
Thread-Index: AdzRXB4aUV5k1HjqTxCxwRD0rny77A==
Date: Tue, 21 Apr 2026 07:00:10 +0000
Message-ID: <KL1PR01MB511699853D1B66D137C06806DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR01MB5116:EE_|SI2PR01MB4499:EE_
x-ms-office365-filtering-correlation-id: 17069b46-f6e5-4aa8-17a7-08de9f73a11c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: S8+MaNQT1ZjNKa2el7KkHLFWgmiaZy9q1Abt0cuxPp0ixCw5iaF9BFoskT9rodhOhP1TIgJsTyhtIU7c188cYsd5zKdkJFRRsSeKVEpE2PjwDppqQmAfn+2mFd+eHgQUH/6I6QGNLwn7EzYOxMGyt5LAScDw5M45HhzvCaXDcBcutQ/QlaLDUJ5rnd/AoFBRdSFkt2Cx/04FC7aowP9S1F7+wdyniMey7NI9OrOzVMPFNNOHdH9blnZ++0kQYjFtyKym23FW33hRxZCSd0oiSowSpddl162ZpOMCNnzxKHwmHEc0Vi2lPOKWS1ib6QSpGrGAnlGh6zGgmGyQf2N7HigVjeZnwWDUeEClD4bAIo+3tviKky7XUauS9xw/82Nv08528fgEPZOaM+lmT0SNGllqWHU6bnaZWv+hCWhZqVaO8TvwAB9cYnN0pfV5CMGW8zW4LdCuKIGQR9XEBf7R9RHj/NQ0GwicShNLo0c6HPeOMUA/QDm4USWocTRqp2PQQbYP2dp8++O+6lh0v+N6+Uvx4gr6Zij+9KjlZnxSop7eg6ay23Wqv/ToNpXKuZwMbQp/Icv3lX98OyYA6A9fIhrfoMzqDY33e7OAsJgNb8M1zaMrxan5+pYdt+ef9voKzC5EHLjz7TDZH5uiyJq7BApIkwmz5pxRZNN/qUO4iJYSaBYdYA7/NjZ5qf5V2d9pHTaQVfnjPBu3oNSXuCsaWc58kYqeXj+d6Z0bypQOBnaBQ2GLajhTWz7phqnnJ/D0/7Nb0lkusxOfQ20hrpVIhs1NR7SxFdvOelTTC6pstQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR01MB5116.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?NnRDdU1TS1E1L210UWRKWUtETW55aU5QbExIVFFnZHRYUEFEZzNpZStUbjMzbkYw?=
 =?big5?B?ZXVIUVloQisxWkU4RnduK2pwY3gvOXQ4R3RPN2RaUTFWVEZlZllrRWo4RXBxQWpi?=
 =?big5?B?TkJLNFlPWEZ6ZkVTU3lEWk1Gd0pTS0U4RGRONU1pOE5yYitNQnduWnhiZmpuUXM0?=
 =?big5?B?NEZZVXlmLzBGMExqMS9Lem5NOW5ZeEY3R1M3cW1RY040M29MSjR1MkRoWnhubnI5?=
 =?big5?B?WEk0UnpSeDFlZlFJOWNQRDV5YXZXTnhpNHI4TFdHelNsQmdId2JGUTBSbVVORG0z?=
 =?big5?B?UUdsVlJILzRyaENuRldITzRXaGdZcjVjQkcvSGh3UHFab1Yrd1ZMWEpOaFl3bXVV?=
 =?big5?B?Qks5cnZhVi9MQWJ3YWMzdzl2dm1zTkMzMmpuWTY5ODFxTDhqMHZ6SDVZUStESXBD?=
 =?big5?B?ZjVmR010YXhBOUh0MlU5N3pMYi9hYWt6cmJiVWNmSE4weWl6bXJVWjRQOXdPbjZy?=
 =?big5?B?OFBCVE8xcTRnc0VhWnA5V0srcWRESnF3dUNXWXhWTXN0TzRyNmRmZTJCQ2ZlSmla?=
 =?big5?B?V1NZKzVUbWdxOVhZVDh5UDdCOGY3VmpnT2hUblNhV1ViRHR2S2xkcHhrUHFHOWVm?=
 =?big5?B?WWFmWGJaTUFJOC9MYTdoVFd5OVdmUFFNbjU5WVF6RUJ1MTJzNHMybTBTT2MvK2ht?=
 =?big5?B?aG8wMUcwSzI0bURhbjc1RllxeTFzMjIzSm04V0x4NEJscUs4UG9RSEd1cVRLanl4?=
 =?big5?B?SGY5Z3pybzdrbE9FaVlPaVI2cFlYZGtUdFdHeWpRM2VjazFzK0VWdEo0bUNzOENM?=
 =?big5?B?ZGVBRy9wcTgvTUI2dzBPSzBGRHJ0RWlXamg2LytIcHhSV2t4bUhveGJtQzc1bzN1?=
 =?big5?B?UWI5Z2ErdGdZYmhRM0lkVThPM21OSkNNSmFpdjJ1TlJ5NkhhcXU5M3Q3MlQ2UHhL?=
 =?big5?B?RDJOb2poc3NnYm45QVFRalBaN1ZaeTJyTFlUMENZNDdsQWNseitKZTJuWFRZekhr?=
 =?big5?B?a3FqOCtOaDRRZFdLdlU4SVc5Y21WeFhUNnBCRDhDbVVpK1E5VldWQ2dqWjZsczdC?=
 =?big5?B?NHpMY3gvVXZaSDNkS0xVODBLQnZXbFN0dlcxaHJKSU1WMVY2MExwV2xLK1MrSnpr?=
 =?big5?B?bzVuTHhUdUhuQWVZSGpXdzBRekcwaDV3cklaZzl4V3RjTnRwVWVVSDdlOUE3enBF?=
 =?big5?B?c1ZoQnNxaG91WjlCcVlqcEJFcWxLeDhvbTV2V0hKeWZiL25sMzgrZWVveWxYc2Fk?=
 =?big5?B?UkJVUjRNSlUvbVE5NTNDYzVLelM1ZVRhdmxDZWpweXZNdXMzSkpEUXRibi9kcmpO?=
 =?big5?B?VTA1TWhhU3pQL0Jad3F1TFpOVW5qTHRtOVRyL3g0ME5DcHd0Q25uVEV3UURySXN2?=
 =?big5?B?TU9MOEIrNGNOS2R6V1BSdVZUSks4M1N0cWgvVWw2SGx1MFVoWE94YVQ4dzg2K29R?=
 =?big5?B?SkMxU2NuTmhxTlg4VzFQSEYwYTg0WHZSQjVaa1puUUt6S0k3UDNiQ2pRUERPUzFN?=
 =?big5?B?OW0rdVhtRWQrbTlOQzh3bXVUenJHbEpLcmxYRjdJcm1Qb3JZWGNZbGZ1SnpQcnRx?=
 =?big5?B?RW9mZURzdnp1TXJmUFI3ZTlGSUNGQ1NROFVYY0tLNThzeE9TYnh0SWVDVS9BL1pE?=
 =?big5?B?QnlzQWhTSC94dkEzdlZydjZPS3Y0U1lHdlg1dk45NlNOdUZDcTM4anRVeGdXdzht?=
 =?big5?B?UVV3dU9jWEI3TkhGaUd0MHdSZGFSamhIMDQ2RHlCZ25BSXBiWENoWjBZbHdTQlE1?=
 =?big5?B?NUZpeVAwM0FXU2JlaWhWaG1lSjROaXpwS2R5NVYzU0JuYzUyOGVJazF4Kzk1NDVM?=
 =?big5?B?RnBaTndNajdoc1k3ZFVseUhERGRHMlBiL0ZzNkp6ZHZDN1FhbFNCYzRXei92bUtD?=
 =?big5?B?UXg2enl5amJCSytxay9Jd2NRL1V3VWRndlRiU1JaaTVRWHB6MnRoWG5uMEVQdjNT?=
 =?big5?B?dmdIcGp4ZTJIRkd6M0Z2VTg2UjUzeHRPalFlSE5nWG91SysreEdrZy9yaEJvb2FU?=
 =?big5?B?MFJpNUJzVENHZnFUN0F2c0tCYWJxOEtjNE1wVjBkQkhHdHgrUWdpNTdMUjMzcWNx?=
 =?big5?B?TFZrZlA4VzVYM0hDYmRMc0xkNHlTZFg2ZGR4dnhBcHZaTzNWbjVKWEk5bGJsaGh1?=
 =?big5?B?YWRwTkNadmhQSFp2QmEvUm1VQmw4anNkL2xoZE1OcTZvK2RDZXZCelZad2FSUXE3?=
 =?big5?B?L0tQVXZMMWQvYkVseW9pUG9kTVI3cEhBUjRrK3dOQm5IdTZKaUpjcXJxMG5ZWjFh?=
 =?big5?B?QXFybHR6dGhjRkJCdm1jdm9weXpJUT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eLzlALPvGMshm9SJaJEXyg9d390Iuej4I+oimypPp4hhQHh0VguHtyNCNAVeViqdYbo1hMABMHZZazQ9k5q5ntWcSEMkS0lxAeKqFoA+YE+7BMpqhDFPKcwRoUiyOeuxk8MODKRyL+OfUwDm8rbNKchonBkukihY8NP2C68WPC4ll3VcPyMVEK301cbGWwO5/ylpsU7jYdyNSEV599MOfm4hJj6dEIgN3TnjeHW0F8W6U2y/j3dWICAbApHTMrh3WYf6dN1cGQ6Q4YCpku5oz/azgGui8cqn2U3FvVJDSemS/fkDYqeuo11jtdDLO7mp/pJC4nfNwvsf2fQPjz4cGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5116.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17069b46-f6e5-4aa8-17a7-08de9f73a11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 07:00:10.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXADlfBdOgcOkUmgUJxFOqin2cgBBskNz5exaKJ3U/SBD9CVs8S0fRC5YeczypSWYQEOs5RCMZo4/kNWbCYapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4499
X-OriginatorOrg: emc.com.tw

VGhlIDB4MTkgaXMgdmFsaWQgMzAwMCBzZXJpYWwgaWMgdHlwZSB0b28uDQoNClNpZ25lZC1vZmYt
Ynk6IEppbmdsZSBXdSA8amluZ2xlLnd1QGVtYy5jb20udHc+DQotLS0NCiBkcml2ZXJzL2lucHV0
L21vdXNlL2VsYW5faTJjX2NvcmUuYyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9tb3VzZS9lbGFuX2kyY19jb3Jl
LmMgYi9kcml2ZXJzL2lucHV0L21vdXNlL2VsYW5faTJjX2NvcmUuYw0KaW5kZXggZmVlMTc5NmRh
M2QwLi43NDc1ODAzYzZjZTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lucHV0L21vdXNlL2VsYW5f
aTJjX2NvcmUuYw0KKysrIGIvZHJpdmVycy9pbnB1dC9tb3VzZS9lbGFuX2kyY19jb3JlLmMNCkBA
IC0xNjIsNiArMTYyLDkgQEAgc3RhdGljIGludCBlbGFuX2dldF9md2luZm8odTE2IGljX3R5cGUs
IHU4IGlhcF92ZXJzaW9uLCB1MTYgKnZhbGlkcGFnZV9jb3VudCwNCiAJY2FzZSAweDE1Og0KIAkJ
KnZhbGlkcGFnZV9jb3VudCA9IDEwMjQ7DQogCQlicmVhazsNCisJY2FzZSAweDE5Og0KKwkJKnZh
bGlkcGFnZV9jb3VudCA9IDIwMzI7DQorCQlicmVhazsNCiAJZGVmYXVsdDoNCiAJCS8qIHVua25v
d24gaWMgdHlwZSBjbGVhciB2YWx1ZSAqLw0KIAkJKnZhbGlkcGFnZV9jb3VudCA9IDA7DQotLSAN
CjIuMzQuMQ0K
