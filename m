Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013040.outbound.protection.outlook.com [52.101.127.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800842EED6;
	Mon, 13 Jul 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949107; cv=fail; b=DriE4ch9eVRjUAzvNS9BBjWv8uCinD5TdGsLR3xZR44yurlyWcr8/hO91aV9TkFGh3TRbVbslhROUFhc1lEFF5GumeH6nT7QgxKSaziX31Gxed4iBelhTG1Q3Hiei6oVewC7eem9suBC3yESq3buPHahIklPWGnnLH6zka/NTEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949107; c=relaxed/simple;
	bh=1YFH3hrlqjZW7SN6Daensn/hoM8pNR0Ipd6RzInhQIs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEtYLqT7gls3WbATtwHwrBqRXCX05Q3kp/qIQMnnlUJQwmcIaICRswzTZDH6sthaZz6hQ+5HHahgnKbbwEaDUCfDWQdNtm7z34frrBanBQQB+DkUqIlrrVRTBEGAp/ewr6jpID5zXGhPL3H1Zf9j2KU88ia/B7IIawIaFVgfJZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SabtDlNj; arc=fail smtp.client-ip=52.101.127.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SabtDlNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUA91xzZQi88FM+ceaU7swDEa2Tyd2TV3owUJ6UmxUpixF2kdnu9bdP5TK5sujpHYowu+yAQULEKk9xSToKcsBWf54PtrpTGBm+PktpnwDm8jWTydGDY94DQYpKsG1jUfIHs7gCKOG3hcDSvZljrR+XSOmTPtJoXBUj5NdTebq/TIowpxIY8JpGnruZTcP69k3vrT8RQ2/plaDuX0YmP8Njhyz4ZpNH8SW4RmxVmIlT3fgbCBCKTJj8I+sDaYJ+B/L5SAxpkcp9QjFJlpKLAcmFJRuM+uNxJJpT2YAAUH/z3GBMufLYgOhUCUG7LvGkVBGLW3VRJSzG+1y1E9486ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZyPXBqHNfWoRtD+nWC7vr4+jKHltdXaANF2RRwjf7k=;
 b=jqArX8epeWZCZXkxYMYtPKyir+n9LSL+ACI/T3aZow3kA+aqWEIuez58AdSK0n7ysYUbBMtSQ8ccD1/j1W3BB5NKIukKZSikTWAYAdzgKZxiCWPGQ2YJI7yQ1Ci5foDT92umX1ChQ6BfYWcpmMFZQSq3Z35ELHy0esq+WYn6LkuQjTO+sP3CZ4mwXzl1lfqlZxBzPliZ+Ki/CmEBgKE65ONr+Xbp9m7APA2QNrn4rtH1DAsabbj+9dimVJnOCKij9RP6cDAsuFe9tUNeSvf9Oc+nVJoj3c7haU2A2s8e7q+2O54ZvOan8kn7hg7iSn8aUOJ5/7mdi76njGvbnkL3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZyPXBqHNfWoRtD+nWC7vr4+jKHltdXaANF2RRwjf7k=;
 b=SabtDlNjkzRuTlbrRjGLbgk1/ZZDvLsAQ6ggLh5Px6FsMd3lXk9ORclJKHy6oeNj3m0jd/UKnLyAkfg70tmKrgDdbDTxtF6w4JZ0Ez9qUvPXdPYitBbI8YiAUASETthBKs5sIm6gc3O/ygrcRxH/lsCtcj+ZfeojQ1Nm1VkMbU9g0/ZNploKV5BVgGDYOXpNIwBLkQy5Ttn+o3ijW65KfcjrIxFZiaO62Um5umtag0YYqz8624DR3ZDhgkPPsp29GDSZbuoqsR+pB/Hd82P6sL+hr1N9665I+mI9OHxifRwx96O5xJtpZP1RAYMxs/eB5aJLKgW03kVlcp7LgyMKAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB9248.apcprd06.prod.outlook.com (2603:1096:405:3d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:25:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:25:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-input@vger.kernel.org (open list:INTEL INTEGRATED SENSOR HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:24:32 +0800
Message-Id: <20260713132439.380121-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713132439.380121-1-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2509ccbc-3064-448c-d5ca-08dee0e225d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u/emuHpQPaz/fX36xLjHdavPupMzvy6e6B64vuLSh5kkiZhHYalFAkp1OyMmKMeru7LSlUhPuPCdNm7CGXHsbLrVmYZa58/EXOw0cLck8GMKIkDM1IRkSjSCgaWWFd2vS5GcKIu3LBJP7c92MjSa7rm23pg9nA0pohR0nHI5kVao4wujGXuEsPL4slDxeeKdMfcuU7cJgdFWKZwYZDwMJ6WieeCuixgajBlZrg4HBbuslsiwBSwI/Kqx16aJ1S901M/Yy9yrw1XrZEiQLEKLx1ISOuO54zZaBFCYDHp5nKFohV+8rOE6AntBcDyB6qEQy2pVVoFDCv3jQdzdCBHlbkqgsVaX23uqO7vpUFsTYn7WFnBvQQk7ixTn0esAqxVvUxjyhXW6HEV9zmKUHUU5j+Uk6VHwJKw0W1CA4IkuQCXx5zmay0hgGotMSXpyi5PR87XPt+xl8vThBY+nENXh9Ou27Omt/DBL07KsLqSLwv1IslAUpReBikhMjqdNyJ3i5hK/LZqebhD5ofOjBDHKhX+FzN5boRHMOHegF5YCwQ5vR6n3HUbRUiyfO3o7h3Q9lq3SKPn6UAOtEiH8rn+Kyx/EZH+6mFeOh6r5tEJajFKVTi4UF9OKsqNLeWX4iG/50IYjQAUw79BI3/v/pyt0TtSTDZV/4LCuUzk45jTIW62DkNewIwlwnWgQyqTAa3EK10q5NesQ6sCQTF8PpKbqjt6izsCisBigoGjgDiuXhd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aOR9b1It6TRanCR0abIPOrtJlf4TvBbU1doRF7TCIuAGzxueAsDxHrM/WiXr?=
 =?us-ascii?Q?s1TlCXUJGNOZrsL8A+9j8AYwrUpW5Wh+AhiHpEWbnhViQcM4/eSaanfbGcaG?=
 =?us-ascii?Q?UtMMCPT4w//4S54ZdJu03z/W8o8owk81UzZNk9SSygeOZUnDSS4p9RXkjXFg?=
 =?us-ascii?Q?XM+sTmgl7Ry/vS68hTboUWMuVrdYZuoWuNMYTU1N56V9emDFPCO+XmYDqMWf?=
 =?us-ascii?Q?ax5Suz6LZlhBU3mw7jTL2nf2GSDae6BehZ91UtM2JO7DZ/e9xvPrRVJ440pH?=
 =?us-ascii?Q?BYh4xcpgiRI2UUUP8QtYhZTHiN9sr4Qh0CInpz6fOektj/uchW0Yj6trOpgR?=
 =?us-ascii?Q?0hwW9/1vgPtD+P333x95730yx7arD0OiXpv3WrI7rd8C52wzjrS9k324g3uP?=
 =?us-ascii?Q?HBwyR5324nHOecn/IuPIx91EwovJ3ZCAv86Ys8TIbw6anwge5Mb5ZKHK4Zyx?=
 =?us-ascii?Q?JYTouFNRhgdBKeA26wEdKOONjawcxOYhq5iG0lRlWJbooJY8iAQWbJn/qeX2?=
 =?us-ascii?Q?Y7UhJbO+yTbpJ/9e9QzOKuilFhSFX+fg2W0GidC18BEJJuJC4ZRURlRKxAFf?=
 =?us-ascii?Q?9wVlC5ILlYq4P5LVqmF3srtTYSbOx9MgFtOyTRJ7FaNR4ABmSRx0qMXVPgAc?=
 =?us-ascii?Q?SeDJ3GEP9+nL9kXQ+cKJXeCBpfADMFWVT2vxTvVjuDcyLgL40H90aXE7FH8K?=
 =?us-ascii?Q?oA+V3fvuz7e+sRkKCPxRpZQ+bWkc7uGFdUtuEyRuPfRekBCj7W4j4phJ9rrd?=
 =?us-ascii?Q?vIH6DU+iPUhGiMZNCio3KA9f/lowo54NDTyu0saQnF5ZoXoajMtbaHDr8LYW?=
 =?us-ascii?Q?+dPHMW32rsG/K1L6wcWdF5NaNP/+IS6HK3oNlilCWg5kwApJZxVf0pyTebtC?=
 =?us-ascii?Q?DsZ52Li2ha1bOTAjdb5KbfiF5De7XTQwaTI66Xv8VKNyOUytlj+W2zt7uOho?=
 =?us-ascii?Q?Ik5/xA3HxO3RuWkJ4TmkiegamPvb0oJ+25vVifO0/vFX8ziRwMiGTUW6gIK+?=
 =?us-ascii?Q?RKah4ej4wF4QbXVNiyPi1+/UYFmEiHbKD8YH7Y393YIE9O+wnNWUyaXEzJRi?=
 =?us-ascii?Q?yaJhi/KOnW2h3djzyT3NFz0UBAo2LdNBU3SVAEHEHWEXc9AOUO1McdGx4nLa?=
 =?us-ascii?Q?PTH0VcfLiDkdWtRNJvBVQ3nUwQiwZDU3+yJ95l+4eHvkKnEOgsJPPM6S4x2E?=
 =?us-ascii?Q?cYdwAh7902/ZIpsNQ93hsT9jYjFZNp1HMuWylLVzrpybySXQ/9+sd6tbzkDk?=
 =?us-ascii?Q?xug2/V2O73H/aQFnrmLUYUZTXUgGZAfpHAQxNVmht0oRDw4klTpE/qXTi0mY?=
 =?us-ascii?Q?nW3AdzkchJWdUKDqWaDQjUEwy2LGlKrNr5JDyCYLZDA9abvbDiZaperNDWsP?=
 =?us-ascii?Q?cq4Ai2nVk8nUWbXqdSvE+vcZysY65EIU3YXrvZZMbLJmW3uDYTl+L7RcJUjx?=
 =?us-ascii?Q?VqnVu0JQfljWBl7+NR0oucei5R23nlsLnovjare0v2lBmtruKevDXqY4WX2S?=
 =?us-ascii?Q?PRyO8Z59PBjc7hWDvV1R73+dssdCXnZdgpu3x82/7p1/90s5PMmO6gzBGBOW?=
 =?us-ascii?Q?0c8bsMLBqJ8oJ9qRn9ZoaKwkZAateYbT4KNoICocgHnZZ7eoR3wKgsrtMTbg?=
 =?us-ascii?Q?9VcJaAERdjabp1meArbpAbHDAwBnlDJLLdQdiBz7oC/WgXHXCnly6obGwEn7?=
 =?us-ascii?Q?2Lp7D6/1n+v9/lF3igtnbElKVSSpTG10LodBmTsGG9Z2sLmfRe6jzOi9XlrF?=
 =?us-ascii?Q?ePStDgV8lw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2509ccbc-3064-448c-d5ca-08dee0e225d7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:25:03.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RXuimpYsgEUkdj5aPdxWAzMPsT5xy5OF9GHGQCsv2GXzsLAk0Ecgv3KHfkjkdsfFHBx7OOI7YnEWHge9/6vQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9248

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 8d36ae96a3ee..e7196e429c8b 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = devm_request_irq(dev, pdev->irq, ish_irq_handler,
 			       irq_flag, KBUILD_MODNAME, ishtp);
-	if (ret) {
-		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_set_drvdata(ishtp->devc, ishtp);
 
-- 
2.34.1

