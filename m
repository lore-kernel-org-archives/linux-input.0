Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA74F5DE5;
	Fri, 18 Sep 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741097; cv=fail; b=GzhuCTe/argXMlGm0Db/IYREnPIIj+VkwpJFD917jouBiu4qdebEOSTlyYF3tZzQWlJfjAa/yLfyaZcWdvv8HUO/pfwcH+KNQlHMBfG6kvyq6xnLe9sv4pbH343Tbyerbr5tiXl3MwcgChsLeUdxwuYfuTyWtSiLpiKUdh5ttOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741097; c=relaxed/simple;
	bh=cMcBeyjBYJ3FZfnNgjsea0FuSJ4nan0sBqxtUprHB+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KkXMDKhxTVJGMvR4H+4Vdp+9ialVoEzwAul7rHT/KnNKPZGFFsmGGqpTlPepm9tkuu7THFvbfcsKEbs2g15KjvZ0hV36LDVmxmtDbWi/ZOcU3JTYBwZ94QwPUqxJumUNXSydj2nQpOzJqNpgNSahULJmlb6DWowrnMyUq5qMCR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FLTtR1wv; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FLTtR1wv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKStKncggWJaouaP3kuhCizYGlUjK3Y03VZzFciTStuSm0QhoPROn+DhKCM3FOe/6IV362J3lGu5Et9UThJzFb5M0Ot2oKvHlDJWxTn2QRCBLWBokHjfLbro2PA96GCfDYlv92WNibwyHjBXiPmQMfkcsjatBIeg4Y3E+3b0EcG72cOLCnwWr0cZTZbxIOiMz/yvr3v+jLtOPOcVLSqmMLT61RU0U6/XYokYFkCpLX5+/5DFRkRghQ4K+LEdj94dEVdl4QSMJbugGKoZQZle2tQwiFUHYJgGUY/AuDKda8gOOryyV1+BiMZSp+3+47dLGEzOrXV00du9BYTZXb63xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv/GbYYBab5QW3paaj31oUjK8kiHd0/dB/BXbXV2TJA=;
 b=qzNuVDq0VbQFpZzDfqDsoK0vjJLEY+7g2Rwlsrw2giVUFTan9wJ9PuCKPmQk6MUQPamkxoEZcg/UQKkttHEmCNibzBhGVTqeNw3Ax+3295O7JOe4/iDyTugybbHLJzgvl/39xReLqzPi5UQiYusol2TMKnB70oV2sZB1Yb0w6IO6LbciSWdWWBVfEFSUOx+qjfj6YVdZODaXBM2B/jcGY2OG5s/WEORwBrXxFunpzzuDfNFD5D6D81gZQzlMRsdYMqps2c8LtEIlQ+zcR/XcP68+6UYVJ984G+2oEK0FZb6wTh91BsPnHN/c7Xeqgia3vJCEcHR46DOXKAf7tf5e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv/GbYYBab5QW3paaj31oUjK8kiHd0/dB/BXbXV2TJA=;
 b=FLTtR1wvwJxFuN10soxfNBhNo+CrB5RPo/gnwyKQhnYyksz7DwMubsfW8vCgk7pxzD2zKHvSFpKvj4JjTb6GWxghlO2h8HiUbrLbH5OAaDqaBj5ZkZO+tY5N37VTY/PPb2RQShjshUDpPguzBOBKyCI4qnWeQKM+348QZ156+wgcKiiLsK04wR1WymMDCJxCJXX44NF3IyOjMeVVC2QrDqaRfTT8mR7P6zopGfGSWIEIjYlbdquQszXln6AbwV8yPFEz61QHHqGc3QcekXZBXUz4fI7KixBgqxeLA76R9PkSawaZVOriWB8P3YGxZD/XEd+oScedd0ezBCxYP7W9hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MMZPR04MB960486.eurprd04.prod.outlook.com (2603:10a6:190:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:18:13 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:18:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] HID: use assign_bit() where applicable
Date: Fri, 18 Sep 2026 22:15:43 +0800
Message-ID: <20260918141544.3022797-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0291.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MMZPR04MB960486:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6e2598-0ccb-47bc-55e8-08df158fac8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	gvpn0Ji/ESnMqW47I/1F89hygMXqeyJ4DK0GzBdSzmis3Ka5gbMaeDR8w3PH4berp80CUszwgoMiFZAPrhzX7+qUpLzqJr8rLWqQORnS5jUN9/IpBuaPfn/OvK1s48cp2eCSNChvssC4lRkRMXX5h5+C7l9uQPHpkjQoWQxM30Ukgjl3zrkr9asWgz9WrG3eHd0s2yTaz8o3nsDzlD3XIV3AddBvcd2Zyv9YpJb84gBmfA5UaIi30Aag2cGNPgOuaWrJhQ85TtQ0p1yuAs2ThyoPQgoOTnWDqbkVDDRi/1D0OKPadaH8Brr9q076WzwYaSA4r/p20wxkwyNjv67lH73wctDksdXuvF1nXc+3N3JQFV6DFaLXQlQ7O1DhJ/hDVBgCmoGDyFP2+i9UM/QeiHtzoTP3HM2x+Yw/CsVBoodQhctni1JA7feLWb0lQTplV/ZrwZyQzdWiEJ8X6GSny1Wl3E1riSvrcFOJMuCcMMM8mn06F1QQOaQMQDYrVLdVR54lTe0olQDUzYC1gYaWwX08XJHXetPLkvmTPWBExon8Re8qtL8t5rWjgNLGishJztH6GfIucNRJOWQhGj0asDwknaH6uQVvsBzlrd1aNeg09IdBFENmFoNtoq2gfNEnc37Z677+tEIPP2pRpFHpaKaMbwl/L4KgsCG+ZHX71Sg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WfusxkDB9s4ZFTBOiOl69DVd5y6CGifVhmFaNO3X6NswcRUx4yZkLQicB75?=
 =?us-ascii?Q?LWxLCTBZeg+iK7EGAKp/ATaLbX5wtY82PEW5WFeIPf9nIlwpYlNjZv3FnVJH?=
 =?us-ascii?Q?f9yTaE599dm7Rs9I1KeJMnICHjkt8Glu1ial0pQBV4QcMfjFTbOkez1QEriv?=
 =?us-ascii?Q?J/xXlC/+c/SfyGSmxWwEh52By/OdsU5j4KB89yIEITmcyv/DkHNoLUPAs6y+?=
 =?us-ascii?Q?SHkoRy7rCWW5ELO8Po0v+Tw8kAnxCLUO0EbT4HkDSkhstyE3NFLOIlO15bsc?=
 =?us-ascii?Q?/nkcOHClnfztFyZzLe6Pjn6pyjQFglmKkiOJjlKg0EfSg7Gv0vCYWm496NzS?=
 =?us-ascii?Q?nDLGTNQanf6Iq34hPljLAlk9sVI9LfpexOzGs5wSGqKEMB98b6kXGs4nw92s?=
 =?us-ascii?Q?EYu6KhSMeCA/S1vs8N0mS52Eff7UgBh5fMBvUFtJdn/p3/dub2cqL7ij29Kz?=
 =?us-ascii?Q?kfhZjmakNqp51f2osbr/SO4RJb+iZtmt7xjx0j7PS0KWc2etG8GIEg24DGel?=
 =?us-ascii?Q?elT+gzUYdSBLFg13iufBhm8+NIf+aH3hcRO3iVBQxZCq2AEFuNZNjcegkPxG?=
 =?us-ascii?Q?WCZDyUdMNYlXGTyFX3NoU2nZC1JWfnNwSZElf79yLGKlzQ1DYQIETStR6mSs?=
 =?us-ascii?Q?aCRB1pMd4+1cnX6iAoOd8vl58dXbgAROGMq+OnofNwc2kDArVh+b5T7qp+6D?=
 =?us-ascii?Q?Ih4NZEmO15vAP/PyAjJsjkFfJFsxTCxPuhazvnNCtVHBuKC4B9cuz8OrbCpX?=
 =?us-ascii?Q?JQwl6m/ZVhD/C3Frwc2dlykrbLdFGW0oUIdK7Uq4jpm3lGza8ck1YwRC8wlb?=
 =?us-ascii?Q?eZ9XVONvOK+F0I0pmtWpUtluIhgxi8nm+3Mkyr2Cp1ULX3oLt40uc5AbNq0a?=
 =?us-ascii?Q?B4YZSbdHEiox2+9AcI93uyIXVJG0eDQpHwHE5TpzB/m/IABJErfBveT6D916?=
 =?us-ascii?Q?ZNyTEcRy7my3c2syOi39qxpYU+qykl2dupv6WIxrPbN/DrZDj73KKQ3XFK3R?=
 =?us-ascii?Q?/GN+MCyaklRZHSa86C+LYJVi9lGeicIASkfEP+srR5FPNFsByDqJWvRI/iFm?=
 =?us-ascii?Q?g4gsjvvxa/IiahqSdZErwRwnWoLsSBYaGDy3uhMRppE0IlJFgldNYwcYBOKb?=
 =?us-ascii?Q?iMUcYXeVJay/nQv7IVX5nyRWwJnLqtKpAYg44yPbACyblQ8zmmOwzjOpgVjq?=
 =?us-ascii?Q?DiIEboftSAAGsW5RPc+DdMFiHRLGOPO6aD0/rxJzHiPTsM56kvYUWI33xHQY?=
 =?us-ascii?Q?7S/mQS5dZr+n95+2JBIV4gwbjzKf8uo73TEBr+Kbmm64CrEsThoMahwtRzPI?=
 =?us-ascii?Q?uOrYiyMWPlYUkZaFllHVtwiNgS1IfGJpBU07Dk0IsMC4sTLavgAZoUU5slD7?=
 =?us-ascii?Q?SAGDgaIS92gRl2DwxhuxV9LT/wUsdBdHyxVkg2eJWTubMfScLapm4mI7/0PI?=
 =?us-ascii?Q?oqu1rGVGqut0F7ppY2cA9OM7bS36f8lK+cXW6aocwApVQHKSoBs5uTkk9LPZ?=
 =?us-ascii?Q?1OlgPrMZf2Ft84cB5Zm4n1wJx235ewwU+Ofxcvji34J0ULZT5oS45+fRhCdl?=
 =?us-ascii?Q?MH+Gs2I2o0VCn+9PQQogwQdLd6oWUuOVFD1CdWtnMEs9/sLdPSuB4Gg465Um?=
 =?us-ascii?Q?9so/4lxF7zq/Eaur4fUuow35MweutNbAA1kxmBnlrIjkcEyRmbNPZstgk63j?=
 =?us-ascii?Q?20pa+BKGd2bt72nVaRy5CF9SR2WbSant6uZ7sd0zowXy5EqdwEETMLJ8SfJX?=
 =?us-ascii?Q?CZKgyfezDnfdYyu/7Hoo3eHcTGG/mErOMHuXt1TSEEobL17VTJCF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6e2598-0ccb-47bc-55e8-08df158fac8d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:18:13.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP4HXhHqWcf9tkZvnwO9XysHebkOqTMSGlQgkbzrMvo1xbS0SYUsVpEsNUbDx/5Rrzwr78+rydg/R5LPyV1QJjaLwWVCDMN4jNhIjZLojjLn4C4KoNrkAJQjelRqbEJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB960486

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/hid/hid-apple.c       | 5 +----
 drivers/hid/usbhid/hid-core.c | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f6134c5820ff..dc5915e69243 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -578,10 +578,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 			trans = apple_find_translation(powerbook_numlock_keys, code);
 
 			if (trans) {
-				if (value)
-					set_bit(code, asc->pressed_numlock);
-				else
-					clear_bit(code, asc->pressed_numlock);
+				assign_bit(code, asc->pressed_numlock, value);
 
 				code = trans->to;
 			}
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..6eb48ef8d496 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -292,10 +292,8 @@ static void hid_irq_in(struct urb *urb)
 			 * because most keyboards don't wake up when
 			 * a key is released
 			 */
-			if (hid_check_keys_pressed(hid))
-				set_bit(HID_KEYS_PRESSED, &usbhid->iofl);
-			else
-				clear_bit(HID_KEYS_PRESSED, &usbhid->iofl);
+			assign_bit(HID_KEYS_PRESSED, &usbhid->iofl,
+				   hid_check_keys_pressed(hid));
 		}
 		break;
 	case -EPIPE:		/* stall */
-- 
2.51.0

