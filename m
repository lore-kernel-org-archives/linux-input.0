Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61339371878;
	Mon, 13 Jul 2026 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949100; cv=fail; b=SW9X28O/+XMg0CGwTSaPiGWyzG9AJmxZpsSpX4cakoMDmASC3xgXc4Hf9rtA/ixx2H184w5kotWtNbD103DLpCbpdR/Za+8olfdPmals4p/87TDI6zXVcNhTW9eaYhwbgj0OyF52r8ifZOgzmp8SeSYEwBHeHCIld/YzK8BXxsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949100; c=relaxed/simple;
	bh=cRE9xBkk8z73AR1fnXQba+pQinn0aCaz9+9KlKZDOi0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hvR6YM6TZFZy7tLOjiNxva2j6EXgQySx/EjyBJxUcJAwbtTP/0sEf8gElQJMpOV2WwdAaxFOUvVg5Ji7JGaxrUSdxbbxiuZjllSRPz/Su8wGmdIaIo0BcFR9qhatB0RrUkZcLiRSQCTEaEogIusU72hVpzDVXWyi9Gfh31va6D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YoFoFLxI; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YoFoFLxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8toKroohEqbpFEbDvH+hvBApx64vUVh6ThieVTmuJO7tlADjm7ymKAlMWHDwhQU4xXnxzP8GRez8cE+1VO+2sdsgCUZZMKIYnCD2+4Vc5stBO/2z4ksorvgVk2D6iDZssq/7IHWxcOOYye9BMYNmEYjLPvkRvMnPAzl3HcJ4Pr5nM+DOw/wecTjdv2wEE3ZJvyxUBv+nYNWi+iZpC5zaglrPbWNB4bAQDCxzaE5fsaT+F5+1xQQAV7+HDHiRykp5et41mgKDwRKqCASlnv4zRge46A6WeqUdSkp0B+P4vAJJihA/y49wUcDC571ye5NygY73oBv2VN9mDi9KhnrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5Fucx+mDgV8BeMG0rCQOo7wZN96AOBhE/JrZISdCJY=;
 b=RD94w/n/AwZeVEKDrTt5Nb7tLL8IfqcxZNrXyXhA81xJAQtJNfoz4++vIhAIQW1oCYm0/acBJYjtNsHB9BlaQStf2Ug2A8wLUbjZO0CQgo6VHzYMxtUA94rDDjKQUspQoem39tosy7BJE9GynaGcRKrL3riFtJlOqBysOyHhxkLSi/QaKb+4DaUjFPGq/0XpJe9b7yzUH3oy00pszSp95eTEsJeRIVtDVhmG2t7YHJxdlllA+9YwIm2bJGxK99EkIjZmArtX1oxU9TpB37fBXmcO1me2vjoW1GAIqFHxxvyIDQvHNIsjzui6rb8O0DmvADIQ48+5AWYXzC4mQUKoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5Fucx+mDgV8BeMG0rCQOo7wZN96AOBhE/JrZISdCJY=;
 b=YoFoFLxISa2JJtF/XL4A7FEeW8N5+PiXj8fU1YWIDbdXrLE7hyFJPqk7p0mYcrcux+bpxUvQS34AYraKaSCayFQy+pY3lerebXOqPnRHyCmytHHQg7mmeoBfoIuor5F8Cz6mJFSswyTbm2gkqrm3rvomRWfA4FmkfEVjd6oxMI6HSSdkqzV7bUodkulJMBa2Jo6a/Ehnc1Hoq4KOvdnAwAv+NL+LyD3REpXVAETbW4bf5y6G1L6G+3+y6gmNtVt27iz78WqvUPhGbJrbuXz1DRrzqcZKXaRhPvAdg0ZqbHR1P2Cwsg13Oru41WMGtYIAJwpaTzwDhgJAaU9t66+IIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB9248.apcprd06.prod.outlook.com (2603:1096:405:3d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:24:56 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:24:56 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Pan Chuang <panchuang@vivo.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] HID: Remove redundant error messages on IRQ request failure
Date: Mon, 13 Jul 2026 21:24:29 +0800
Message-Id: <20260713132439.380121-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: b3075062-01d0-47cc-fb3a-08dee0e221a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|23010399003|1800799024|921020|38350700014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pzNJ4gccwcdI16EUpaIhpt5dhbuJuTeZL4syfr35PBVygt4QCHyRDRp8/A19sOOHoMqjv9urcdTQ6rsZxehYeIn1SAqUcAEO/Zb851Ar6BMlJCQg6YGDKxrtdq5WgKCxPC6iFc9R/BYej6slqkVaV0o8oHfFskV6wNvEOh9COq/IVpdoOj/eZ6RrcS4JPa6QpsFmRw5UGDU7KP4DnD//29KBssI0/iYRB+YC9LDnu0RufN2qUKT79eR+1ywh5GOe9K00cKBmpPyscpWKzqGRjc76YuYfkXZxpNcfw6SdqrPDvjtidEQH5TZEW5oik103rfCUW4a2oKW8PKfWDbHRCr304BYvoS5VUsdxKPF9ydHgTNDkhPX3sjOeHoOpqmLhv3QlFIeWtDurgEuJmGdC8ksKyLTD9XLMoDHavtG9ZMXMzQsXYcTOLzQQwHBISiHAWnF1O9+GspwnqBdYfc8C5gBe1voeSdfGqOrqSA3qdW8uPVkR+yPSN2SFUEoOohyuI187+LWcH2HC4dp1dSnZSI9x2bMgKY2dgYjssME3RvOo1dT9Suv4tGsTxrqybxDz3vENuOjyhqH8QsQVsa9ghPAUBGKinwuUnvRp9mlTDbW+L3zgB5V6Aqfuvzl/nS6UVqX1HLjGn9qFypUtj3IU3Dz2xzcvztXNc4PqA5aU0JJAePnoees4qjcfc8BGgakZZ759hlOLP3NePRr+EiKVOYEU+JfXjJjQdgGygBvkNCX7t7XXR/QihHft76LyaNQw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(23010399003)(1800799024)(921020)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwvOkdZqUZnaQsHNps7U6QB8QvXF5VEw8r51C4kOcoQqUUG7HWatcg9/rorg?=
 =?us-ascii?Q?ZZ3edbtb53Zr0IgsVKxYDCrvDJTPAbWwcev26URxBpYGLO93pJr6YdZpZsTH?=
 =?us-ascii?Q?euj5Qwplk8z1RreHDW+0ewE/XyfnpXyqycyWnSQ4TFhHzvxdb8FGylEcNDpB?=
 =?us-ascii?Q?Was9XB1y/YPBpzyTGpooCpNKh/qOHMwckfg1CDA0UIsMEDapQgHEoxN10mJb?=
 =?us-ascii?Q?3Avo7qxfDKAe5kX+vEv0Pg2jUCOWXzG4HYCwVRjK40PeHyddOpfcXG0AzwR9?=
 =?us-ascii?Q?qpNy/usikp8S8OkrXfkkDnQMakNT9RZmZaIRi57C+RN2iwnO9Vq0rSRlDsgi?=
 =?us-ascii?Q?04MEUXVKZmnYco7eBycKkRQzMi+hLey+3Rs9FUUjHLh1zF5GdbysCplGwJOQ?=
 =?us-ascii?Q?soRCAvnEZ6rM/cfGOmv3P5qTiqLmQ2i/gEgap0vPcViIU68Out8mdSeNIviY?=
 =?us-ascii?Q?PfabDLAymd4E4mgMabdzXde0C6s6fDBiJFxIVWtxZABBO5CiIQemS0flzs/A?=
 =?us-ascii?Q?DElCwdMVRWo2CCGMMuDBpSib2RLcv2TLrxugOy+UYex0QpgFE2PNxa3nrRWB?=
 =?us-ascii?Q?iWer1lgL3/FwJTwnGmxj35AhVsp3tE4fGaPiw6hHm9c6jiSZckYvD4UPFu8+?=
 =?us-ascii?Q?OLcgWXmFwnocAe+lSDPi+aZ+9mLnX9EwTShSJG4AenuBE+dmlH8j2UU3wyAd?=
 =?us-ascii?Q?SeSGcmNjUDIT4be29+SdnpsawEAdYExt16rK40KqZozaew5lruJUxKsxcfUS?=
 =?us-ascii?Q?sZtHzGrkYubdupCoTec/xBHbH1lo8J7K/TLjyUYysUxkF1zsiIyYc2gSvPCV?=
 =?us-ascii?Q?fxWb94KbN6YWV9+s1iZHlVFzdq6iB5qtQ8QzF7G0KHwGk7dRlD5VDy9jnmov?=
 =?us-ascii?Q?XRpIDhUmvnzDacf2ekPrfV8byo4m2NBGc/DgUTGHm0f2yRKbdkCaMlIoit1Z?=
 =?us-ascii?Q?8lYR6oerZ+GPFVy8R/spGSnFQxhO8Bvtj2XNW5Qj4bg1Jy+rf7QwDvD67vsl?=
 =?us-ascii?Q?teZDubuRZahkwTxXVsD7cMeGFhP0Fj/P7sUp8r43IUdU0n3V7jPZSROr5bHx?=
 =?us-ascii?Q?ov3noYVhkhN+ueBS3LPHPV15zRMpA0/Dc9adtI5iigdFZ7imLaWv+80ZfJNB?=
 =?us-ascii?Q?Rf+BexgGIeeqd1q9D+4hKgTgNRwtNBprypO3ID0842Lwh9QlKMKK9L5hqlEF?=
 =?us-ascii?Q?0MqtnGWuXob9cDAi318gnAVlgrL4ZEsRORIy6RnHdzY5WJ+XFUwQLLWDonSh?=
 =?us-ascii?Q?LmaybWcexQsfJhH4UB1JirW7y/lAirMq+Nyo8c/TuN8Q1NPX3KtdYOhYF+SQ?=
 =?us-ascii?Q?cGkJsUzGdcju5mhNtenrIatZi5I1Q/8OMuWPyghWgPhcj2lxY6+ecP5MNsIU?=
 =?us-ascii?Q?c1M6FZEzLBXUm0P+5Vb9vOsGT3hBk/89E0MTRi+afeb/wNvZrguO5nAQzqi2?=
 =?us-ascii?Q?qf1oBB56kENfiR19seGVpDqj/7oI9JGoRpLJYFcx84S5SOG5SOrurYXMqw9E?=
 =?us-ascii?Q?dYLzUVkVuZHLh5y/SPat9JoAZhTgANGe/+oXjKpsOEbhjoGAjQpLrHzaQ+D8?=
 =?us-ascii?Q?gvi4PmMxvgSlPHwEkJKtpEYvSruYHzD3z+F9pPA9B2hGYjlizI2rtehs0pLt?=
 =?us-ascii?Q?Pu7aA3SR+B2fGMQGW7lFSFUSlwwR1Ax7ljqpBH7ewfpEDo62f7yUSfr0G6ps?=
 =?us-ascii?Q?qCHCWwyQ8ogUG7p+ZLn2FxNHGNzkzg9YtgQozapLZe8/ie8pku5JIk4MDJQS?=
 =?us-ascii?Q?jkCFwCK+Cw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3075062-01d0-47cc-fb3a-08dee0e221a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:24:56.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKKB84/g0pVQ+FmmIuuxtrgFTNiQ0LPed/lcHf7lBj0DGgjqdR6CLUzjkzY5w2qtgvrefsJlmLvumsVS+zTpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9248

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in hid drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (4):
  HID: amd_sfh: Remove redundant dev_err()
  HID: hid-goodix: Remove redundant dev_err()
  HID: intel-ish-hid: ipc: Remove redundant dev_err()
  HID: Intel-thc-hid: Intel-quickspi: Remove redundant dev_err()

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                  | 5 +----
 drivers/hid/hid-goodix-spi.c                            | 5 +----
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                 | 4 +---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
 4 files changed, 4 insertions(+), 15 deletions(-)

-- 
2.34.1

