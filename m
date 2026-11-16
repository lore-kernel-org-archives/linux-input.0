Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794829677;
	b=qF6M72PnPVB/qEmW9pG1EGe6wHkOUh3arZpENIqZMjWY0FFW/HWtvBBhPtxTzPlycfhP
	 r/o5+BNhBhRzop8kZdLRxOvd8AdkLEwwWneJylBx5Y93h3xTrsQQYouhXsYkkN6TKdlIi
	 +FeQkJmIgb+rIadQOltec7w6PK7hVTDNV0PlIZM353e2JKW5lPs7qfvIRVNfMYU8EVaIl
	 I/tAh9NpEcsRK7UDb9+VPTXzsP/KkyIodB3Es880QKpXQgZfZzYRVzOpa+btrAJxVINYx
	 klcEuUGm3LGJrwWj79OzMKMw8QS1uklVPxVdfux6ndT+PnwvzuBlM5Kf+NuNcvvWHgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829677;
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
	bh=zoChkdmITvvsNZn64vlqKsHj/BgIntzOEA1lKhmQVwU=;
	b=2OCfA3Va2FYEPkDkU3ri+USzA73gXYejuK06oegTnqbL89drN3zeQQoyUZaWbxjsAE1d
	 kNKQv8LD1PtOmMmM5bzL591O66UWB1LzGd3OYCYJoQZoHEj9vGudBbdXhY95f/rJIV4rQ
	 hObVewNQuiQtmBfcKfKJt3cuK+V3JrnN59sA6hUY+8AcQ7F4o6IPSKVaFEwcL+shp47Nx
	 cr0IP/9C6VgM4jpBOZp0h3PmiiUoGVezLnk1W/XIBXwliEY6ZyqgXO7DlDJByVEpfIOoU
	 Wa5fgkZsk0Qwwi17/4cuFTHQELc9jXccRZc8woFj5VlXqjd+s2nQwtc/YBKz+BMQv1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sttls.nl;
	spf=pass smtp.mailfrom=sttls.nl;
	dkim=pass header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256 header.s=selector1 header.b=lX6FxXvm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.93
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020093.outbound.protection.outlook.com [52.101.84.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CC606A31C;
	Mon, 16 Nov 2026 11:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D3CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256 header.s=selector1 header.b=lX6FxXvm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXVinpfJ43SkVbOPeYCkQtk8ReWC+nStZRWBysph4L+cU32lqHoeaAojcwcNQAxJi0rJaX4vslXEeC71Yo/R4FA3Qk1imv0U2zunw8jQzkaBUHiBGPsDkBKI8M7S/g54Elz22lOSr/v95oM8H7iHsSa5JBa9BIMZkEyTI/1bWBgcO7V6R0Oi55NnDajgJTupYwSsbSjz5/lq6J4iVaV7AN0/AoAmL1cDP89EyXGr1z2YRLhX9A3u8jZMILXVNu9iSDrL03Yyy59jsLJYSG1gpq7AoLFWc7OSRMGTLv5u+FZYgoJn67cngRvIsB4e+oX+AQQTNcNRFm56plAE1ia+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoChkdmITvvsNZn64vlqKsHj/BgIntzOEA1lKhmQVwU=;
 b=q5StLa6Xyzkph+urMOm6YDY3UlLDQdMg0CQa2kk0TAz1l27YOA17UxhFV8Yb+KBEs4NOEZjZWDgrbTIE/xjaJcxhmwqYZ0GHo8ljd0pyadZJgELzUcNgBDuLbJ1FXAV0uABLxkAe8hpReZevZ/j4LBH2lVjIEFuDNRmu2yZeH4v/vM9NGyzBS/tP5IWBWvItKcEhGHICQjGFlUXgzVvsEEND+YjLgDmvzuoT0MdcLrFYQWvUj42dlk0GAjKaCu8D+A0daj2xZJVg3CS6gmk+un3gjD3gpsAMXh8dmo6AVWHM86KuwKybtXBM5V7nKRa0thBbk1mhS344nm8aTZYxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoChkdmITvvsNZn64vlqKsHj/BgIntzOEA1lKhmQVwU=;
 b=lX6FxXvm7KtU+++7hyk96M3uVPD/zuIaJMxN61lDrKELOGyV6uoMzxrgQzkEx3z72z6WFrq4Y9Qn/efyil/eCUXySXFs/HyByP3FAcIE75VhLa1jucpDqCswCIaRCjDM8DV3WdhR+gaBm1EGfBLLKTnAJ8teYdRNfolA2sU0chB8cKCnIftLpqgNBzEq6TZ32J+gtq2q0/WD6mp1vat2w6ssZAvXtPvja68q2odt1QJz4IBYfjkW4RA5aSxd1t6sYkVoGUxTkjs+Bw9B8vXSY4wbPTYU0HY18ga5Uslf7AVHBNITpEcnpbNGVj90dBzmrJ99Va2rS0a33eEvhveGhA==
Received: from DUZPR01CA0121.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::11) by AM8PR05MB7409.eurprd05.prod.outlook.com
 (2603:10a6:20b:1db::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:47:52 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:10:4bc:cafe::16) by DUZPR01CA0121.outlook.office365.com
 (2603:10a6:10:4bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 11:47:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 11:47:50 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.64) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 16 Nov 2026 11:47:49 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by PAXPR05MB8399.eurprd05.prod.outlook.com
 (2603:10a6:102:1ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:47:47 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:47:46 +0000
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
Subject: RE: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Thread-Topic: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Thread-Index: AQHddI1shPxxnBII5UeF9WgGSsYvOrcwlX5w
Date: Mon, 16 Nov 2026 11:47:46 +0000
Message-ID: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-9-michael.zaidman@gmail.com>
In-Reply-To: <20261114230800.1344401-9-michael.zaidman@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|PAXPR05MB8399:EE_|MAD0EPF000008A9:EE_|AM8PR05MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: a95f4f55-caed-4905-c27d-08df43d771a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|22082099003|18002099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003|4143699003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 9qn8JaU+JikqLCP/CiiAsO9knK4uXCXbjXe0bHBem/UAfFG92es+nFxkv5FL90hgijPtG0WVfozmQa+RqAn5woj6l44CMHJIWgpZpHq+XjOYwOgQXuqCnrcJ+ZOfNxeEYkVf6LERNzatNnsQLITdyB4uj46TnKdup6oFRpP7WUce5AOr9RqZpDhc9FYXM0AFaotV9R0GLEEhRyxqoaIZqN1YTYaFEBU41qaBO9zIlXK9n2Tv71cG4FE5vwZCEukXpoSYZE0NOgTN405Yiji7c1xPNuO1z/91Ap9bTqRNrURLd9n80JcJCBZIqZ78jgx7RR3zlpb3PGTA5fdV5j+f1dNgoGbUFc+o21D2nHVStBDM7LbH7OJlKl27ove7mehifAXEcJKBK5syab/Mr6LHH5fG9lDh5pUJHOWU1Yh/2SvaDNpYliYIECqgUwPaZLUJJiIr0KzFFzMmayM2TP1bzrpZ8VpCxfjdPccgqeDa8j/GGf7EAYtV6gIdH9QQaIW0e0XF37k3kBu4i61NhaN7NjkNY6k76660dVDuf3mb14d09MSK7GAXnYtsrphEehsrOyTzywjerClKlHkcswSqrZoirGw52O1k/aVEN01Yg9FT+TsoprwIZVIrpAvNcWVxdBOd6wKxvML4QQG67RGwM4zW3Y5qp7+3j4Sj9R1LFr9oPOFXeoeIJCQ1LzFkg0Oo2W38XL2aqHtPQoah4EfHcZuGOlrWlIb8CaGZp+1ym9c=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
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
X-Exchange-RoutingPolicyChecked: f8VhulzffmyyPf1khGaWjrvNIXfqACx1yM1cpvpjG20AauvjaxUe3uMCEGY5+P0J8bCp0VGyN5v9AdzqxQSYdx7J1/vowIAHUToCbDBZdOF/cWh7/Dv+KdN2xD6ZZBOfPd/3Dabhsbp/BCR+72VdrZbkioZc8xXmQJUYS/vnyX6Y6EZCKW6w2wS2aZ1UwWP7HBIET7O2/KxzpWd+gqLJS2nHMyrnbt0yb3MjqpIW3Dwqbc55REKfsj5REJqn0tuwydP2C0Xl3FlFajaDaPLY0ShaeZupKm7c6H+r6rDnGl82v4lKMtWCzy8STVqqugAF4JHTrk3VC/DIwwYCS+FE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8399
X-CodeTwo-MessageID: b76cefed-10dd-45ce-b7a7-fc6020f1a417.20261116114749@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fae48788-1d0c-4be3-8001-08df43d76edc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|35042699022|14060799003|22082099003|18002099003|56012099006|4143699003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ar4emwu8poEosEDo1AyNK0q4kxO88oTYsyWtgqBCNe8yHVuZRfDG0i/yli9gXELp/+CoSTzBebDBG+XuX5j7/f1/BemQLmym96QSjZe14aZNS1KG6tMM3mD7jhdqAJao2h8Um4AX02ufhwp+T0OwqIM+1yOOS9WCCA+2sinRejgkNccWlUIMX+jaNCUuzfsqdJWbl2Qpjgr9MLfYmp8JEgFnsE8SINdK1YywoxGi5JEL+iWMcJMFzcXltWhy1G4SQVY1OlnQg62hE/wkPFAS4byxPCzS9QixGX5fiUxFlKFugeemulPb9ZkJ/qSiafXdIrvEr+gSzBsCzXap+AZw6NCVeqcG5VRQuNyD+5Mljj207VFOgQx+kYp5s4Br8yM6Kn7ejrvEkKHNA9XYLqHXUePwHvsPDZDZoPCY6ZvHgudpZLkMGUZW7UdsL3naBwsrGx8ge10N9JkayW946l4miYt87pxsvJIX8gUpzNykcAOxRLWek9ojR0sP+iscxjeGWx3Fl/wdf4eYu8qgqbWgdZJrZhOA5cnfTSIOyX9ByWTpj96TKodLfk6G0+7mMCjdc2n5MfVyt9H2Bxwgy+97q8Li4c2TSjlMQWkJDJfj/tN2eDqAFKTRMGsI3iJ3J9WPzK+1B1m9bVpXZPLSBy3BK0rRrR5FTNKlhDF8wOBzYH1JY+An7ZWpbcf04g9iFw0dYNGIZTE1pztY7b4uc+IHUQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(35042699022)(14060799003)(22082099003)(18002099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nCz4VJaLUfBwrjW3JcO5/7q7yxeGzG76Cvgf/TvIQq3iPL9pGkWpTZpajiFFKLtfhJLsO0ZnhLOjz8zkppIePrgMZc2TTuqIZYuUZIUyMHv8YxMfX3kculH4UogoPGphHG5+LGSJnLsamRlLV6wxvGEIhaYgWeb3Qs1QM4xLGcFlxSXeiemRO+2VxHFbZw3Rkf9lUj3XZYfMuc2V6VJX8s6Hr4lLY3BtwoyM4tNmTJ5V8J7ppSx9e98F6s3mNtcDPvJKYNpf3dR20kFPhboAsQ0LJhZXskHhTyd5ASYSAsz7a6oW8x1kLqY6SEU2k+GWK4n/nSp4vcwlISR4UrUG4A3U5jx78/sNp5NwTb1Jc847jnkDXZZRVu60j5zCWSkFY8g5nOtyyn+Mv+3FFHMk488VBg6ujkB9z64jrVkb05OwbxfZAY9DPFfgvS4PTxx1
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:47:50.7907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95f4f55-caed-4905-c27d-08df43d771a0
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7409

SGVsbG8gTWljaGFlbCwNCg0KPiBGcm9tOiBNaWNoYWVsIFphaWRtYW4gPG1pY2hhZWwuemFpZG1h
bkBnbWFpbC5jb20+DQo+IFRJT0NNR0VUIGFuZCBUSU9DTVNFVCB3b3JrIG9ubHkgd2hpbGUgdGhl
IG1vZGVtIHBpbnMgYXJlIEdQSU9zLCBhbmQNCj4gcmV0dXJuIC1FSU5WQUwgb3RoZXJ3aXNlLg0K
DQpXaXRob3V0IGNoZWNraW5nIGlmIGl0IGlzIHBvc3NpYmxlIGF0IGFsbCwgSSBhbSB3b25kZXJp
bmcgd2h5IGl0IHdvdWxkIGJlIGFuDQppbnZhbGlkIG9wZXJhdGlvbiB0byBUSU9DTUdFVCB0aGUg
bW9kZW0gcGluIHN0YXRlcyB3aGVuIHRoZXkgYXJlIG5vdA0KR1BJT3MuDQoNCktpbmQgcmVnYXJk
cywNCk1hYXJ0ZW4NCg0K
