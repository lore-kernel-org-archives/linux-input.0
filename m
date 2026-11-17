Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794959805;
	b=DkNQme8mXBYR6P5NbX6ige1MrruLmfdMSZhC3PgsBU7Q2GhD/CZjqiKeM7sTo5ftQbPR
	 e2To7voTMvdMTY/Eo0foL3TILvuQm9SUT/g89TsXtkJB4+8ePRx6WgOLW88FuJVrftKjK
	 3nd96E6p5VVpiTtxTFZvl0giD9x4PbsYMl805lTtgBH1jEcI9xnGbVctX3NAR47VDhjMv
	 t+RNZqaDcSVi5vSSGx+6ZMiiSBDUNtkjHw4CK72swExHZUDPq/Ra8N68aiohpLAcW612J
	 aXudwZIlbtomgkNsIIYCOdcqsOeEEKDtNVzKMrEzr+T8froaXS/sadprKQzcxbn38TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959805;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:Authentication-Results-Original:
	 x-ms-traffictypediagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1xhRt6jnbrigBlglIjtYFEImhiKoamW6qHZL4VZFyYE=;
	b=cpAQSfvrJSf/VzCEWMg5Ahs8CSGLU7MD8t0fdCGD+OXvmpbBRn+ntKJ5k64Udaenifzs
	 sMerYwysN3bfg51mRCRmi/GFb3v6OLZ+sJ7t7Nj9xzw2eL9CV3X86qTUznhgP6Ggreo29
	 hbiZrepY54YfPSFVwhpjT+7vK7zCcc4ZC3CDPkhnh537yUMC61rrWj761MQvIrSr+o4m+
	 rKqRCUpjrQssWe+D6ON++jRcARtI5iCbyTiWdqFrvOtw1bJ5FnIErjWstM1CfuLaUFTr8
	 5YUJkgb4N1STyeDA4gopM52o3bcilvkgF+MuRLxsZ074PzpjwugzsdxpVGRD/rNL8bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sttls.nl;
	spf=pass smtp.mailfrom=sttls.nl;
	dkim=pass header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256 header.s=selector1 header.b=mj4K3nlZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.81
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020081.outbound.protection.outlook.com [52.101.84.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291A606A31C;
	Tue, 17 Nov 2026 23:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0291A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256 header.s=selector1 header.b=mj4K3nlZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX5uWYR+1IPq7U/DoZJgZZQBgGKLr0JzRvDrXXRZc8rcMQ4dcBjN4O1DIqlIXyIhSp15plgohh+F7PEZwngz5KTTptNCOlK3XX5aYZUaRFZj6lA+WIt++5zosaRtMgeHwXXBo7SdyCaNfJnjcJ6t0o2M3bgOq7+UWum4Vcg9SnU8u9GsqDf5JVad9EdoQOZ6uTFvTojSGQP+G26p7U9mNftHYkzvd+Xvqu9/Qw5JQ2TJjNMkU4jD8eulxPC1PUGqDvFI6mBolCytnRieCnmj94L7CB/7tL0fwJSO8wIvYo5ddUZx59LsnWXPiwTfXLOPAh3BMxUNBM3cjHDFupqesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xhRt6jnbrigBlglIjtYFEImhiKoamW6qHZL4VZFyYE=;
 b=xW8S5ijUYb66bsRa2mbH3VLZJAnMKG0g3cLxYy03ik/+mN1HmSSQyofDlynRw8jw6A+GGoQQcu7MwU3R9SfIBxbejVPBh5za+Q3jDQkr95gZK6VJv1OTqFdEB9jczFLS94OngiNVaaZ8Gb7QzvRSTnvyJC8F3AOboqnf7LeKuUPbXReoDcfc9KHCxUixYvO71hQE05Fti8j7m+mM1SNQLMcmBp85MqUOEXWlzgy5AkvQh6Wu3781v3IgzN4v7joGU1rlxcrtwiqkG6LpMC8lA0I728Nfo2kvQY38BidUOsQavYWhNhJ7oAzG98m5/avuu0wi/m5VoFtmmM9a4zNBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xhRt6jnbrigBlglIjtYFEImhiKoamW6qHZL4VZFyYE=;
 b=mj4K3nlZrD39d9OcziZKNqIvqOMBbe57kQ4tVrjEHiRrvLxjrxkQI4FJs4SJZtpmQV+lrTJphz93J3Q7BRodrCa6qrLEZabzjyadnQs02C+faz80B562ivgOtdKjcBBfcQd8PQczsyJhsOfJapGxXBJrYysk4h2phWTPJWozNyiGcpDUGQDBLPxwOGAJLB45GZ6nZqukc1kLeSLw5H7/rumSfZ3saqGMjiqK96WfkYo1kysSJfmuvRxNdM1Fj17Uff4Ad59sxnAwYNYp11VvbX2pi03B/bH0DeSalar/g1Ai44urDzchy5VsBsH6W201Ub4imLvNGxpim+B0xhIjcw==
Received: from PA7P264CA0080.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:349::10)
 by PA4PR05MB8969.eurprd05.prod.outlook.com (2603:10a6:102:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:56:41 +0000
Received: from MAD0EPF000008C5.eurprd05.prod.outlook.com
 (2603:10a6:102:349:cafe::12) by PA7P264CA0080.outlook.office365.com
 (2603:10a6:102:349::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:56:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MAD0EPF000008C5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 23:56:40 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.90) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 17 Nov 2026 23:56:39 +0000
Received: from BR0PR05MB049132.eurprd05.prod.outlook.com
 (2603:10a6:2c8:48::23) by DB9PR05MB8984.eurprd05.prod.outlook.com
 (2603:10a6:10:36c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:56:36 +0000
Received: from BR0PR05MB049132.eurprd05.prod.outlook.com
 ([fe80::9b49:1b04:b999:aba0]) by BR0PR05MB049132.eurprd05.prod.outlook.com
 ([fe80::9b49:1b04:b999:aba0%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 23:56:36 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michael Zaidman <michael.zaidman@gmail.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
CC: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Raman Varabets
	<kernel-linux-20260610-80b7ab08@raman.v1.sg>, Germain Hebert
	<germain.hebert@ca.abb.com>, Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>, Bruno Giacomazzi <brunoceg1@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Thread-Topic: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Thread-Index: AQHdds79cU1GT6gjGEm4sASFfuICtrcy5tAg
Date: Tue, 17 Nov 2026 23:56:36 +0000
Message-ID: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-9-michael.zaidman@gmail.com>
In-Reply-To: <20261117200423.19561-9-michael.zaidman@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	BR0PR05MB049132:EE_|DB9PR05MB8984:EE_|MAD0EPF000008C5:EE_|PA4PR05MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: b671038d-383b-43c1-0d74-08df45066cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|3023799007|56012099006|4143699003|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|10067099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 EVTudnNwcKltH8kFXy7TZVHcaK9vtmceCBFmAmclu4Pz4PnRRh61RAZ6m1DkLtM3clQxBG3kH8aVlXej9xBk+l8vTkBMTws4HCc2/F7vjAo/u5jJWEMS36KTFKJ1WimbjNfrpPCgeS+ai/49DtsTLPyGDWv++cKaKPEpZhw5FlyjHPPtLD6sGMaJgvzmxflAGdQseLasjIkeGVex5bsTs1nnIcD96i2cM3vXLlLaEMY5B5EZe/8sMFbVG6LnHObJDcZZYXMU6SH4vmws5S+1WIAhpYbEgkQwN5+uUX8yUOAUWmKlQQAcf5N/gDsNvVuOmTSKi9H8HmCa4Tx9J6eSel8B53oV0uEV/Z4LSnknNKNjY9bR5cBZtu5l2vJ80ZIGEVGImdT0v8E1Q4rBOkxxiJYj7Nozt1ZdtbNTEbSXDwGKC7QPr7DctREbDWN+/viThuwy/M/5tC/8lPFvnYLE30U6dkM2qZFtnAOzAyClAIz0tW354M1yqp1V8H1XcTBbUffk7S5U89y24MkDGvxVKGmcBV+v0TY6YegKlCU9cD1JujBtluRJUCeaJFDAk7P/6zBaWJejhuelfDyYcZKH/oBGptcWiH4bMFcfUi6AgJxTq4+DbLfXO0tar6CWgpS6HrL/fz9W2HXMsFQ5LSVUPi4ydSiK5dY93jG/zTXdE1CIlm2WqiGM6GQZDToFDfFM7POP8WvsPeBnDWbN6DenFlXTT5WmclcCTLZy0G0SIK4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR0PR05MB049132.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
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
X-Exchange-RoutingPolicyChecked: 1qSjekdxOuhsJSB1DfEwBbFUrWBsfgRIezZ+Vrsm9QIJ/ooW3Dd9F8Q3V8csuoxq8YuXfyXWJ1qOak9vsbCJxYy1WiiQI+9VGGexL2y/5XZvQzvn8Ha0763zSw5jIumwxBeg0fzsRSKSe9ljNOjKuEbhZDU2Nf9oR1JZnS1lG+vA6q+3S9hjrBwqnfUIYfIGx39VElvUjve8TvNJnXh7ft9QIUlEr4j77xT0cQ5zC4hHeEgH/bdK7h+4bwPNq0wlcEBWAUjyM/Xduhv3XZGAcgrBV6TAX9lppbDADKe77STi4i3mblRRp9ArR+qUKDAPDsrrS9yLfObfcmFiM810hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8984
X-CodeTwo-MessageID: 7cd046a6-af3f-433f-a35a-337926dda9fb.20261117235639@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2c359ad0-0749-4a72-1c34-08df45066a42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|14060799003|35042699022|1800799024|7416014|376014|22082099003|18002099003|3023799007|56012099006|4143699003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ulqnwcW824DfvBUhGZ4D/u/nm85fNWLR411V1lbvTMT/Br3z0LA7bsBuW86AZH7+f+hd0+0HpuNQPbwXx42q+EJ5R1KyKvhpv3Hr7RNfSY3s51llEY5yeaTxcjQ5Xt0uIdyln8ocGx3YpY3RuBTvJQxlnNU1WX2HTxfO91sZAaZF8qUZaSI3UiIo7rf5lfpBn9PaFzHlAOUsgurd0i3IvPHq4Dy/cD8GSwp+iL9k2lTr2fVdG/SE2EyvX8uE1sHvHyE5ss6d4WP4whi4VhyQUA5MoFbiNVV6Zt9mSXgnTruE+ontIQ7SYY4O6C2n2sddG1QZm8zdErufAMmbePHs6QnHvIuA1C63Q98Kz+9yBw+E0eQFH4/ngdCczYoP68xVW5CoAD0+35iiKKr9I/gtOuM4SvenV3RYlrWS4ENtU63u80Bt2/WHMOJmB/Nzl5Xv+7rIAPPYANUtA9NOWZ3oR/Vq/Nao7QnUHB0qNt/ZjGz29DHmIMCb+nWs/L2fDBZRZn8FdNl1n88NGLF3PSSlLlKDV37shUbzu1JRy8NY84mP3wiwOp5QmeV/TmL1F8DyS4AGLHoflKKrOZ4yopjGktCaJoSu0MewC6Jrc36/uAKxga/yqulvz+jAel9MAVA+w2XJoLkeAgFZh/Z4kULCK/eNgYuidPj7dy34qsr+59nzcpKYMyZ2uq1yyns3RXi0iBuQV8A6PxFssBWVTu8hNA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(14060799003)(35042699022)(1800799024)(7416014)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	grjo/vWGSHY0T0QjJc8JIlpVmc5A2LtgSYXuIdw5LUp7hNswCCEpj/R4GtxcvYv0e8jbnysILRMtBT0aal/Gwc2t68ITytCQYCAKq2aIvjZLB6itHgug5veFECZo1TxOgnvuSQn27IRPZ3GeRY8aTRP/eCv/N63IVYCMu54WyhJ2rBgyz8y+7CZ4I6/nOxwRdTG+nMttRS6TpJ/URa0jJBwJeCxJuBtohfwew8DiFubLWQxlUoSvL7a397adAhW6einMiZ9osyaGvikRoC55O81l96iJq5cx+x02TRzpedpvq8IbSYkXtwDVmbH1tvIr2geUKUPLSbm9Dc2G7Ah1dQUJd/Muc0kx6MX5tuHxCOwOzed2pvGo+VdcniXC3CYoDWNbx+qQrjYAEvspfWN2JHLTsI2AxhOcZr9eFFe2XSRc9rRtyrBd5btvdbLbRF9j
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:56:40.2225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b671038d-383b-43c1-0d74-08df45066cd5
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB8969

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFphaWRtYW4gPG1p
Y2hhZWwuemFpZG1hbkBnbWFpbC5jb20+DQo+ICtzdGF0aWMgdm9pZCBmdDI2MF9ncGlvX291dHB1
dF9jZmcoc3RydWN0IGZ0MjYwX2dwaW9fc3RhdGUgKmdwaW8sDQo+ICsJCQkJICB1MzIgb2Zmc2V0
LCBpbnQgdmFsdWUpDQo+ICt7DQo+ICsJaWYgKG9mZnNldCA8IEZUMjYwX0dQSU9fMF81X0NPVU5U
KSB7DQo+ICsJCWdwaW8tPmRpcnMgfD0gQklUKG9mZnNldCk7DQo+ICsJCWlmICh2YWx1ZSkNCj4g
KwkJCWdwaW8tPnZhbHMgfD0gISF2YWx1ZSA8PCBvZmZzZXQ7DQoNCk9kZCBjaG9pY2Ugb2YgYXN5
bW1ldHJ5OiAhIXZhbHVlID09IHRydWUsIHRoZW4gY29udmVydGVkIHRvIGludCBhbmQgc2hpZnRl
ZCB1cC4NCg0KPiArCQllbHNlDQo+ICsJCQlncGlvLT52YWxzICY9IH5CSVQob2Zmc2V0KTsNCg0K
QW5kIGhlcmUgeW91IGNob29zZSB0byB1c2UgQklUKCkuDQoNCj4gKwl9IGVsc2Ugew0KPiArCQlv
ZmZzZXQgPSBvZmZzZXQgLSBGVDI2MF9HUElPXzBfNV9DT1VOVDsNCj4gKwkJZ3Bpby0+ZXhfZGly
cyB8PSBCSVQob2Zmc2V0KTsNCj4gKwkJaWYgKHZhbHVlKQ0KPiArCQkJZ3Bpby0+ZXhfdmFscyB8
PSAhIXZhbHVlIDw8IG9mZnNldDsNCg0KSWRlbS4NCg0KPiArCQllbHNlDQo+ICsJCQlncGlvLT5l
eF92YWxzICY9IH5CSVQob2Zmc2V0KTsNCj4gKwl9DQo+ICB9DQoNCktpbmQgcmVnYXJkcywNCk1h
YXJ0ZW4NCg0K
