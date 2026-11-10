Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794288397;
	b=xy4VKYL57QnyoIgEbwRK6t0r5WzyibWK99RwSNSgkium+jRDJjJFdSrPB888rpGUGUk9
	 dSfZUX1YMZb/kWmYXCXQvO+lpyZj+4+XXOamkpp+744K7xrV34KWw+lShfKjv5cfG+2Hb
	 rLF4LAEcNxI9wxREsYQhn4e/A5n+uZTThQr0dABCCTaKhVBQdx0Ab0pSYlO84MQNzuGko
	 9rYq5LR9AmPKURNCPZQK5dc/JeYm3LOWYzx6kHBbWuW9h64pgxggRbeK538B7/coT/GXa
	 oUmAGTc8Tuf6FihWlBRARxcjX012Gj6vH+ImGH4RAtTq6znxIZkPudaBHQtalOG1fsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288397;
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
	bh=AmdoDXnUKp6MyswJJWX7+6euss7OA10Rw7b7vgmhZZ8=;
	b=XSYrwS5tebr0YO91M/J+SpA50hpkxk+Koru7adOaxH/tefIXvORqPF7qpuky88+ViI3s
	 PslRKSyDPDLwelHQ3VvEkLVa7rUCEdcyK7lzEQ6LBX/AvFxPsQsrYK6U7qErtndtClF3y
	 VhMcebbw/Uyko8ugRN6cnH/pG3dhLH5CyI7zV2brzm0bUx+0D4QKfxe4CB+0G4HR0ucfp
	 QpIpUIKTLZZAWyNUkTNi3vn1rx4aJZy4+nXmkzY8veiViLlMPFzZ6aOjtIttGeAXRATTT
	 nPtfZLCAnkagXX4kjM9B5+ShJ1fnUeYmNVPdV87InXmMYbV7hLgqEy4+mHxNTgHLuDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=emc.com.tw;
	spf=pass smtp.mailfrom=emc.com.tw;
	dkim=pass header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b="mmn1ZW/F";
	dkim=pass header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=aMJlcmEM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.72.220.5
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E65606A31C;
	Tue, 10 Nov 2026 05:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emc.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=emc.com.tw header.i=@emc.com.tw header.a=rsa-sha256 header.s=emcselector header.b=mmn1ZW/F;
	dkim=pass (1024-bit key, unprotected) header.d=emccomtw.onmicrosoft.com header.i=@emccomtw.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-emccomtw-onmicrosoft-com header.b=aMJlcmEM
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com.tw; i=@emc.com.tw; q=dns/txt; s=emcselector;
  t=1794288395; x=1825824395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AmdoDXnUKp6MyswJJWX7+6euss7OA10Rw7b7vgmhZZ8=;
  b=mmn1ZW/FQCQbf7b59CV8yQ9mbMuZgZ401HeI6bWbA0hjj4rKOmPNuDXm
   upS6bYjM101mGGulsEvRmG9erLOsa3gzdnl45Cag/+Th5jJtmbjFVMJfC
   G0rxhCChp4c4TgsKFWDbmDDBUddq9zgG3Nk9pbIDJ9Sx66KQhs6cQIY/p
   2Dd6sRwaZBEuFBFRGF34q7qNDtvqfNPHj8AB3riZdoYFkX2ffR9s7Np08
   wV3CraIPrvmJA+aMVPgHFmgvJ+4XZ7lc3Nkjelu6/0vkUnE/eyVz5AaLH
   papVeCwpKNdVzxV0AUaxiw85LW0KW/dngyYDgGLkPnSxvoDx+1ZznAPEg
   w==;
X-CSE-ConnectionGUID: 9V5Dy2lpROy6S0zd7fJs0w==
X-CSE-MsgGUID: /Rhz4HJIRfWhZKDRdVn8NA==
X-IronPort-AV: E=Sophos;i="6.27,205,1786982400"; 
   d="scan'208";a="14833882"
Received: from unknown (HELO ELAN-EX01.elan.corp) ([192.168.10.67])
  by emcscan.emc.com.tw with ESMTP; 10 Nov 2026 13:26:27 +0800
Received: from ELAN-EX02.elan.corp (192.168.10.68) by ELAN-EX01.elan.corp
 (192.168.10.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 13:26:26 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (40.93.129.123) by
 ELAN-EX02.elan.corp (192.168.10.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Tue, 10 Nov 2026 13:26:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6vDqtP+931HW/uxS+60VKa5OO5X89QG9T/3MM/DtNhIfkwwD2iExbtsrnvgQy5lMPMVjD1KOqs7T3G72byolSgc88iIIN4gmJNZnViUA+A6nkztCWwggXr0/fQ4fvXoFC+0gQE2vjNA9bvAufc6clZ6Qhcr8GUwU696Hlop1Ze/jmwWsvgn8NtjfyB+1RU5sNzQc/fVoJWoP8dKMY8ZuJu9NbDRWyEW4NmDQtzcXVM6TwAESanaXIdh7P4GS5QRRcJQxh+1Eka82TOzpGQmFXz4S6chkTbTwzyhbgErfaHrMbwqXtrEmuyvLpQHoPh0VgHN+U6s0+Llw7Pc5B2mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmdoDXnUKp6MyswJJWX7+6euss7OA10Rw7b7vgmhZZ8=;
 b=JGLqhgGAgktZeEKyyFWtlA175LaGtpFsUB0A4qkD07Bei+Bo3ZWpdKlYbnOxskMmQ6c/SWK30Xj9uBLdec7x6Ab4HO5le9/v6EUGW3Y1WednV5uB4wws1Vk/1NFUUiM4rjV1OfJEE11fWiT6+aZYxmTuYfHW4/PgaAwRFPjqIm8+UF+QxvLtyFOeThXyWFIj0uvTi4cTwLfwm0CI7lf1+2FWs33IoQ6kEP8ND4LmmkkfmwxbqMgQsohGoR79zuw+NfBN97DjSHoH3lGbr6XJs4r/8dPJjPE3FtC3CdZFCn/QPTHZEIZKNl8FH8VmMf1PYwY2zVTEF/tb0nvR83E4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emc.com.tw; dmarc=pass action=none header.from=emc.com.tw;
 dkim=pass header.d=emc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emccomtw.onmicrosoft.com; s=selector1-emccomtw-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmdoDXnUKp6MyswJJWX7+6euss7OA10Rw7b7vgmhZZ8=;
 b=aMJlcmEMq6ki66xAJPuvKsjtMiLksNT2rmI8fOQtgUZdBIqvBMtewvHScnJEAkyuChAQQN/VaUcIYu4Owc44WqNNiceaIRnETnMZwveLvLf7K8JvAYjCTgDNFP3+0QLMobcytX37p16wk/vpZ/IwMhXdXlXMud68ZGEncaDCDCo=
Received: from TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::8) by TY2PPF5B48BD6A9.apcprd01.prod.exchangelabs.com
 (2603:1096:408::3a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 05:26:22 +0000
Received: from TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 ([fe80::5e11:25f3:7e0c:ad3f]) by
 TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 ([fe80::5e11:25f3:7e0c:ad3f%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 05:26:21 +0000
From: =?utf-8?B?SmluZ2xlIFd1IOWQs+mHkeWciw==?= <jingle.wu@emc.com.tw>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yuan Yao
	<yaoyuan0329os@gmail.com>
CC: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Vishnu
 Sankar" <vishnuocv@gmail.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?UGhvZW5peCBIdWFuZyDpu4PkuJbptaw=?=
	<phoenix@emc.com.tw>, =?utf-8?B?U3RhbmxleSBDaGVuIOmZs+W7uue2rQ==?=
	<stanley.chen@emc.com.tw>
Subject: RE: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Topic: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Thread-Index: AQHdcLxNHDP5k3yfMUe0H4sA60xFjrcmxlag
Date: Tue, 10 Nov 2026 05:26:21 +0000
Message-ID: <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
In-Reply-To: <avKBsi-E7IeUgsSY@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4786:EE_|TY2PPF5B48BD6A9:EE_
x-ms-office365-filtering-correlation-id: d8fd909d-3a0a-445d-d8f1-08df3eeb27e3
x-ld-processed: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|38070700021|10067099003|4143699003|56012099006|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nULpHEnyV4OEU9RavuGZAdzvryuuzPV8QsQPcMhWbtA/7zvna3EF6ZswB51JFPKriaJUTkn6+QHlaqP/0UOO/ztj+IzjxgS2H4E/qj1r3Qtx/wNlCWiCXrXYPTfjLikwuN81tVOHV7Yoi6JnF7RsEKHUCv1wOnCXtum8d3j0Dn9uRHOqDGVUczlqayhreOjpcBUHhH4S4ztUB7tdcKhsDyRSP5DdjYySd6KG3JgFZMJfsjaxxkAWO3hLNf+Sq/kgx9Ml/Zwvv5NTGIlr8zcFGF6RDZd35+O92IfJ/CzkSkRIAuGK6to3MqVN2qxPiXgVPhKRqah99KR3CMt29DmeHVgT46CPncwcVIsNP5ZKT/jFrUwBsi5V3WIutm0MLYJz75jbdHG5cs/R8wyj8JuaVLezVByiNdzGxVALyK5HZxZlD2wQtCtgRCuOE5BBcMcqDyo8uavF+3ngMN0aV45KaBrFOvfK4m2P2xKUGTx1GTML0q11SDQ5QBR/KTp1Bj3nuzI8bOKw+qE7mpfRBFpWDvBOgAQ6EV4XVk8FmRvdj9vk5tURzW51LojDVIDQzzi6Rwj8xnKKQn9De2kk/GZ9hpgkBrOYPHKfDp8Fmza4a3sB3YFjdJU7tdkPAKDO+HfQGjg3YZae47hlfp7cMoEfAPt1X+bjhuihbWTPdaVys7k3E30BEI1mWviHTSSq9KH2kLlSVO4n7S+T5hIXb6xDuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4786.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(38070700021)(10067099003)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDFhUnBEaHYzZ2hHOXFZVCtFVEUwa2IrY3FJSWhFdTBYRWtQc3ZZajlvbnFz?=
 =?utf-8?B?emd1UFoxclduRzhZSFJ0MmgwTzVlMnk2Sk9VOGJMcTRuQlowblp0dUlaYmU1?=
 =?utf-8?B?Umgrd2MyektYWHc2eUhoOGV3R3lSQTlOQVoyUWUzeTVOVDBRVFBaSllNY1k2?=
 =?utf-8?B?VHg4aXBnbDBzRDd6cU1RbEtWaXA2Q3NGM0ZqMmZ1RXlML1daRVBOaXBPQlV4?=
 =?utf-8?B?U3hKTW5kR3loM3A0Vmt3blpvVVkra0xoVy9JQzB6TzRUYWhDY1lkUXphcTlw?=
 =?utf-8?B?SU10bnhmenk2dGRSZ0JBZFVsRkJFb25uOVd1UkVKWXBoY1gvWjlHeG5yRGMy?=
 =?utf-8?B?RjltaFh6QlpoWVpGbkR6T2QwbWQvbHV5UG10Q1c1aDJ5OEExUG9Deit3alQv?=
 =?utf-8?B?UmVlZ204N1Y2MHFGWVd5R0xYMFZ0MzRNK0dmdFptYzZxUFBlVHIxRTB3SnAz?=
 =?utf-8?B?YTJEUmJFODU2bk9BUXlCa01jNzFJTDlhQlNtcjFZQnBoNUxEejQrbUs0OFIw?=
 =?utf-8?B?clFEcWdZZFlVa29ncU43T1VKNUREdkZ2QU45ZFlaYjJOanJEbzE1VWRSQU02?=
 =?utf-8?B?WGQ3ZWFmeVc3SXg3TGtFWnlOSHNDQkhrMTFVc2tCSUxZcFBTeVk2TDJTWTJu?=
 =?utf-8?B?RXJpYmNHcnBhZWVKcEc3alhTMlF5KzVlT2VlbzhLOHBuUHMvMDkzeGlFMGk2?=
 =?utf-8?B?MmVVdm53bG9OeE9IOGd6TWJZamlKa25nZDBEZVpYMHoxQ1hodlJ4cXV5Ukdx?=
 =?utf-8?B?SitBUmJvSXZ1WGRkQ3ZYSCtPcTdVTTFJeU41Uml1eHN6d2tmYlpRRktFNURM?=
 =?utf-8?B?Wm5QeGp0R2JJSDBKUHlGYmVEUVVOYmtNVjJKbG1UM1RWQ1ZZMjlYRmhhTHhG?=
 =?utf-8?B?NHpYV3ZTVlhaREtOT3VaekF2eWt4R2RkakVtU3p6WVpRS3kxd2s2QW5LYVFW?=
 =?utf-8?B?clNabXRWZVRzc1RrU0VzVFhwUzFXUEFwK3MwSkRMTi8xL2taWlJmVzFpTXg4?=
 =?utf-8?B?UTBYeGhzTGxVN2Flc0hEL244TGJQbmhhc2ZsQXN2OGFiU2VTYmxyWTJFQ2Y0?=
 =?utf-8?B?WVJ1ZVg3cVUrMU4rajBQdlViSHNwZU03eWpWREpjNW9IS2J1YTgyQUdYeDd0?=
 =?utf-8?B?cHZySkJTVWhzVkFBSHUrQ28yMk5SbHJpVkpsOFVQNldBSGdDR0VoWHk5TFMr?=
 =?utf-8?B?emdCdU9rYmNrTHIvbnVBU2tvTHhSYlVNdFUvQy9saURyNU0wcDJRRHdTeUFQ?=
 =?utf-8?B?aDBRTnhBWjhjUXFaSXFNNTlZRU9WWXFYQ2l2ZURjRU53VlZ4TUszSkNFalNm?=
 =?utf-8?B?MkxYU1NpSlA5MmxSbFNkcFJFY29kV3ZkcWN0alFQQng2K1NNUURvZGF0UnNq?=
 =?utf-8?B?UnlKYnBOd3IyUGttUjZ2MTlFbk5JZ1VEQ2plTnN1MUZhRFJmSXpMSThZZmcx?=
 =?utf-8?B?UTcybW1SeUExNnVnUFR3YWZxbU5hR2F6M24xS2pVZEdHWUxhZG1wSHJ4alhG?=
 =?utf-8?B?MWEwUGZaOUJlbnc4WUtvbjBPbm0yQUNwU2RaNW9uRFJnTHBKQ0ZhVW53M0Uz?=
 =?utf-8?B?SVIveTArNkhIVVc2RFYyVU5Ea3VPS2RLVSt0VDZDMDlGSTg0T3hQdzByUFYr?=
 =?utf-8?B?RVFiZWc3NjBVM2hSVE1MdjNTV1MrOG9ROGo3SmhZakxhSGZKaFB1Z1oyWm16?=
 =?utf-8?B?b0lVdE0wMGVZZDN0MVB1YTJER3c1WlFPVGZubFBkNUlyMUVvRlgzVHdZK2hi?=
 =?utf-8?B?UzRmZjRGcGE4MHZYd1pFbDMydGJJWG8xTFFsYy9MeDZBZjJ4ZVJncW11YzBB?=
 =?utf-8?B?c3VtNjhibzRBNEJVRC9nbDRRZFFkVjgzOCtqQ2RKWnYzbkJtQ3VEb3dTeFZN?=
 =?utf-8?B?MVVYMnlBS2wvUmJvdzZwQzJrR1RyenhWZElBWFNHSlVwNWVRS3NBWWFoTHRQ?=
 =?utf-8?B?NzRNcW8wOW5KQkZ3RVNTQktMbEdMN2RDODdoNUpCdlA3N2FyOUVSMElFTHhR?=
 =?utf-8?B?bHN1RjRvNUFlMTZXY1loSkROQWhzT0hvc2x2OHR0aGhwdmxVUkxzZk0yVWg3?=
 =?utf-8?B?dmUrbHk1aVVCQzJ6b3VxaUM4TmFMTGk3S0k3akhBM0ttUmw4Z1lvS04vZ2tu?=
 =?utf-8?B?bGwyWTFDekQrSjFqSWcwMThwSVVsWGZPcDBwMGd0RDhYRFppZGVqeW55MStE?=
 =?utf-8?B?NTg1d29DRnQxbFNOWUxWeTljd0I0ZFlOQW9lM0t1cjVncXZUM3lOS09XMHUv?=
 =?utf-8?B?a0FoeklXMTNKQ0wrVEdWMGlkRFppd0JFU1ZRcGtBYkZnSHdJaU5iWnExcUlW?=
 =?utf-8?B?cVd4UXZCQkJ2V2RPR1duSXh3cFJjV0Y3S1RmNmxNL3NZQVZRTXpkQT09?=
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
X-Exchange-RoutingPolicyChecked: jNBkcZnd9L6KbmX5FXHn25PCg9UlyVlhbh+o4bwNZkU7XtT+gxJnw5FfTXovWv7gwv0AKmjm6XRWxv1T/OMtWW832ZQnxMifO1HE0YLUSYJe4TnP0DqoLbHKbIAthrx+Kbwp7Ly1cw+I6dRIUPHTGMyQjI6YrUw2bwrFYEM+dKX96yPC3avrhdZSZUMkIPaA7vMPZJT+m2ke+WuMXHTXMXdkrwg0IUxAxMf6PXhdwWA8Um9I6DOwr/dITLRbBKpLqbETfHgqvtiPxDpvkNXDIIOA9FKnozcJ1yHEVSIVbSO6KAAngBxnGAiJnFg5e0PXTRtYVB/TPxIOy9ipSVoO3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fd909d-3a0a-445d-d8f1-08df3eeb27e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 05:26:21.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 665042ad-2a24-4d2d-b35e-cb1d8bcb0cd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eIJhIkgoXOECcoDiZFCvU2XT9f8jX61SsOfyumzVEBL9WCtyG8UErXcCOEYoVzXTbICZx3yD9divqVPccWbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF5B48BD6A9
X-OriginatorOrg: emc.com.tw

SGkgRG1pdHJ5L1l1YW46DQoNCldlIGhhdmUgY29uZmlybWVkIHRoYXQgRlcgQTEgd2FzIG5ldmVy
IHJlbGVhc2VkIGJ5IEVsYW4uIFRoZSBFbGFuIFZhcmlhbnQgSUQgaGFzIGFsd2F5cyBiZWVuIDMu
DQoNClRIQU5LUw0KSklOR0xFDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBE
bWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+IA0KU2VudDogVHVlc2Rh
eSwgTm92ZW1iZXIgMTAsIDIwMjYgMTA6MzYgQU0NClRvOiBZdWFuIFlhbyA8eWFveXVhbjAzMjlv
c0BnbWFpbC5jb20+OyBKaW5nbGUgV3Ug5ZCz6YeR5ZyLIDxqaW5nbGUud3VAZW1jLmNvbS50dz4N
CkNjOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+OyBWaXNo
bnUgU2Fua2FyIDx2aXNobnVvY3ZAZ21haWwuY29tPjsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQaG9lbml4IEh1YW5nIOm7g+S4lum1
rCA8cGhvZW5peEBlbWMuY29tLnR3PjsgU3RhbmxleSBDaGVuIOmZs+W7uue2rSA8c3RhbmxleS5j
aGVuQGVtYy5jb20udHc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gSW5wdXQ6IHRyYWNrcG9p
bnQgLSBBZGQgbmV3IEVMQU4gdHJhY2twb2ludCBkZXZpY2UgdmFyaWFudCBpZCA3DQoNCuKaoCBF
eHRlcm5hbCBFbWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSB0aGUgb3Jn
YW5pemF0aW9uLiBQbGVhc2UgdXNlIGNhdXRpb24gd2hlbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzLg0K4pqgIOWklumDqOmDteS7tu+8miDmraTpg7Xku7bkvoboh6rlhazlj7jlpJbpg6jv
vIzoq4vorLnmhY7plovllZ/pgKPntZDmiJbpmYTku7bjgIINCg0KSGkgWXVhbiwNCg0KT24gTW9u
LCBOb3YgMDIsIDIwMjYgYXQgMDk6MDg6MzZQTSArMDgwMCwgWXVhbiBZYW8gd3JvdGU6DQo+IFRo
ZSBuZXcgRUxBTiB0cmFja3BvaW50IHZhcmlhbnQgaWQgNyBpcyBmb3VuZCBvbiB0aGlua3BhZA0K
PiBYMTQgR2VuMSBsYXB0b3AoUHJvZHVjdCBOYW1lOiAyMVhNQTAwNkNEKSwgaXQncyBub3cgaW5j
b3JyZWN0bHkgcHJvYmVkIA0KPiBhcyBHZW5lcmljIG9yIExvZ2l0ZWNoIFBTLzIgbW91c2UuDQo+
DQo+IEFkZCBFTEFOIHZhcmlhbnQgaWQgNyB0byBtYXRjaCB0aGUgVFBfUkVBRF9JRCBjb21tYW5k
IHJldHVybiB2YWx1ZSwgDQo+IHByb2JlIHRoZSBkZXZpY2UgYXMgdHJhY2twb2ludCBjb3JyZWN0
bHkuDQo+DQo+IEJFRk9SRToNCj4gaW5wdXQ6IFBTLzIgR2VuZXJpYyBNb3VzZSBhcyANCj4gL2Rl
dmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8xL2lucHV0L2lucHV0NjMNCj4NCj4gQUZURVI6DQo+
IHBzbW91c2Ugc2VyaW8xOiB0cmFja3BvaW50OiBFbGFuX3ZhcmlhbnQ3IFRyYWNrUG9pbnQgZmly
bXdhcmU6IDB4YTEsIA0KPiBidXR0b25zOiAzLzMNCj4gaW5wdXQ6IFRQUFMvMiBFbGFuX3Zhcmlh
bnQ3IFRyYWNrUG9pbnQgYXMgDQo+IC9kZXZpY2VzL3BsYXRmb3JtL2k4MDQyL3NlcmlvMS9pbnB1
dC9pbnB1dDY1DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1YW4gWWFvIDx5YW95dWFuMDMyOW9zQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuYyB8IDIg
KysgIA0KPiBkcml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuaCB8IDEgKw0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5w
dXQvbW91c2UvdHJhY2twb2ludC5jIA0KPiBiL2RyaXZlcnMvaW5wdXQvbW91c2UvdHJhY2twb2lu
dC5jDQo+IGluZGV4IDNiZDhmZGY1NmNkMy4uZjQ2ZmMxNjY1Yzk2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lucHV0L21vdXNlL3RyYWNrcG9pbnQuYw0KPiArKysgYi9kcml2ZXJzL2lucHV0L21v
dXNlL3RyYWNrcG9pbnQuYw0KPiBAQCAtMjUsNiArMjUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IHRyYWNrcG9pbnRfdmFyaWFudHNbXSA9IHsNCj4gICAgICAgW1RQX1ZBUklBTlRfTlhQ
XSAgICAgICAgICAgICAgICA9ICJOWFAiLA0KPiAgICAgICBbVFBfVkFSSUFOVF9KWVRfU1lOQVBU
SUNTXSAgICAgID0gIkpZVF9TeW5hcHRpY3MiLA0KPiAgICAgICBbVFBfVkFSSUFOVF9TWU5BUFRJ
Q1NdICAgICAgICAgID0gIlN5bmFwdGljcyIsDQo+ICsgICAgIFtUUF9WQVJJQU5UX0VMQU5fSURf
N10gICAgICAgICAgPSAiRWxhbl92YXJpYW50NyINCg0KSSB3b25kZXIgaWYgd2UgcmVhbGx5IG5l
ZWQgdG8gc2F5ICJFbGFuX3ZhcmlhbnQ3IiBvciBpZiB3ZSBzaG91bGQgc2ltcGx5IHNheSAiRWxh
biIgaGVyZSBhcyB3ZWxsLg0KDQpKaW5nbGUsIGlzIHRoaXMgeW91ciBwYXJ0PyBXaGF0IGlzIHRo
ZSBkaWZmZXJlbmNlIGZyb20gRWxhbiB0cmFja3BvaW50IHJlcG9ydGluZyAweDAzIGFzIGl0cyB2
YXJpYW50Pw0KDQpUaGFua3MuDQoNCi0tDQpEbWl0cnkNCg==
