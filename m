Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815B42F6EC;
	Wed, 15 Jul 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107881; cv=fail; b=pVp2WY/SB73ubnVFPrAiYeKgeybtpjDStSOsmFAwv7t3biTP45Bxe3BQUi++fX717jiE6BSeplNp1GkI7SmhZeDsb89qyoWqCSdG+988POGioY6j4OQQAQdEbPk9hZvje6syjg+918Wb7/uihcH+m2VbSZpZwtYfEIGXR0HL9DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107881; c=relaxed/simple;
	bh=VQrqM89cExvIEUfuommd9kHu9D3SZxAsVKf/E7wLD+U=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WlYghEIxr2ElH7O907ktqAho9nxo1q8vQUCTSWJbVS3Zhebtgt5G4D2WwKpdbeCfCfywyvxHqbYyAK0nn6jpKOWfKpjxp6DmJeFi67lRktjIJJ2v0P34YBJqTKlnXvAoiRtMSV/pjTGsuUz9so4Bl646vKKkYQRSDjbfbsX16rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ER2bjMwD; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ER2bjMwD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laxo1b9GA4XbXB0oNMmS5fpKqtZDGs177BxCKDH3tDxzvlsgs66jwoktzgZJFn0VzIO8sJBBJl9llDWJUGbSCaPYNxSjieQ/IATCaCWZEswYnMca+Bf+AszayeKOwHPYNKe9WWQ0J/0lkCwbNqL9LRW1GwplHdGpi/MQSfTrRFkpgF22J9V7jjq7ZxKrwXAxHbcI52Lmy0kLuLrb4LYFgMw7thstFGVBzm2vpuAH9gBfj1P8bTsLmKBrd0v4KDuOPH3cccZOMaUkwDJ8mqrq2vIEhnlTynCIUINWkjkqj+iWGptUbov5aYcgFSgUuV+2CkuZ9WugkUNkqYpno5lwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHcF7csyOyqrQoTYG9XJ9kwF7JxjnPhhsat5bmMCWnY=;
 b=fm2fH4p3G0OUMS6SnnyLpFfxU2Lu/PVXSyZfgbHN+XbJvEtYI4JP5dyPLOr+Xl8a0WRKoqVAZgx27rwR8+MzyQyrtpqkZOSOMA9SO8F+ukaWDYoBYOiYJzni81UcIRwbiiPccH1ThTFyXVxSMjQsw4dovlHSMB9MFCczJzB1TOt6UKwDSb6BYuPLaaRF4XDxDyi5bpSBPtjdzobIn9JqbT8kT2ylP+5tNz4rKuVapW2+LCL79mnkp4LweNfBtvk9YbJ3VZNjQv6PXE7cqFOmc86NaFZCzGp2wQqFMvtA+pdIdaD6zq4W4jKrUDr3J/uxhQjMxj2hFR7hojE1uu+fTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHcF7csyOyqrQoTYG9XJ9kwF7JxjnPhhsat5bmMCWnY=;
 b=ER2bjMwDMAVPijDeS72O/Wni/i2OqWidI/vrJYkWoeUtVJ0M+ekQZIFuTr14QniY1opdfVyRspoc7qnoWAvk495RG2gK3KyznEgErdlQwENjn5Unn/WK4Waj+c46WBnzZY1wZj/AhY2M9mrG7SGY0VrGO3nonZ+7aUVT0UX2B4n2H4bUenQP3gLYRre9lK84mtpZJpWErRrggytn8NWX6FJX/IvRk9dM2ed6ELEPVxCNlgGdzJ2LNvLf9UxCz3BondAhn2JEvYnFZsAbCbhdUyxkav1Zh10IT7olQZMqztGb5+iBzYWg7K1A2cFKnDNnFaJ3HnyxvbtaD+NYjdGdnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:31:10 +0000
Received: from AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f]) by AM6PR04MB5800.eurprd04.prod.outlook.com
 ([fe80::6703:fb32:63c2:a84f%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:31:10 +0000
From: joy.zou@oss.nxp.com
Subject: [PATCH v5 0/4] snvs_pwrkey - code improvements and add report
 event
Date: Wed, 15 Jul 2026 17:33:50 +0800
Message-Id: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5TV2oC/3WOTQ6CMBhEr0K6tqR/VOrKexgXlH6VagTSIkIId
 5fiBhJdTjLvzUwogHcQ0CmZkIfeBdfUS8gOCSqror4BdmbJiBEmiaQZ1gK3b/+AEReSaEYELw1
 TaOm3HqwbVtfl+s3hpe9QdlEQG5ULXePHdaznsffL23NMcAG54tpIYFydmxDSemjTsnlGzT9GZ
 ZRoSo/cStgx8U0vtnv5lhULK7Q1BSWZNpbv2XmeP90bW8QmAQAA
X-Change-ID: 20260615-b4-pwrkey-a60b2043cd29
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To AM6PR04MB5800.eurprd04.prod.outlook.com
 (2603:10a6:20b:a4::23)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f7d1ad-f1cb-44ec-5a78-08dee253cd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rck/x0hb1lHr9bfscdwyA1yGGlxSj8EcTdapSmrATAqJPVS1y89HxYlWdrf5BFBqLgODHioeQwSfADwTeA8JJM7QIU63+wEThuSl3kQE9SIh5H6hvmc/DhFqk/gTWWktsE5H0DsoBnjqLwwmqixcSvWwilxNOKwZo00GBbaWFCMzuJ1XZg9ZOCmvMLUnB5D2c/GfzTEFrWDyyicf11fZwr7tQrPv282K/THSbS4TKYlnjdUwYXOah9jd/0VzXPT+oDRkh/BVFZwg6mawTJpY1NkIP6+VP8Pf3LXCOzp1A1CfHksCqltXgnI9x3sp1f2T7TYLjuuFSnraQ2S98kHHRCJjoLAcxdb2ZUR1oXYC40pXWalDA+lHzbEau21myadcexVKMJEu7i04fnThAca84XkgZQl6hPNriielCfsM0uJlMygaiq+fTEX1xqe+okv8sFb4PkpcsKXXkVJj1F2VE8sZIDhiAvFG79NpSX9DxlaR2xEIEMsJt/QCYpBFB1W2kDoWS9HGWi4RdjWF7h8gr49CHh3Pyo0ETWB331Pka9S1kioAjUdCFmdz6MnA6Lh4j85cg4R7Jfbb0dmjGyp69OqUkNuhGwJZljWo15UEjt6LNIkJ/LlqHcUufm7h9onO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVdXWWFvNXBPZlFKeHFBV21tK2t4SGdvK0Z0WlNmVVhnTG0vWkNoNTZpQXJF?=
 =?utf-8?B?RFBSVUdEMkNHMlVrWXA5UTFoTWRYUmpDeDFUVGZyU0JueW9BQVNOK2NnTTB0?=
 =?utf-8?B?RG5wRWtNdDluVnZ2WUV3ZjNRYWFYZENRT01VcUNRd0VkcWk5OTJoMFJyMVJ6?=
 =?utf-8?B?MmlJNndYcFU3bUQvSnR2YldDbTBtMVRNYTY4d0lyUEdTa3lHb21rRXRFMXB4?=
 =?utf-8?B?RWYwZXdmNmM3Z3NtQTR1STgraGFoM0ViY01RaDFBdCt0RmhRMnhjSTRkTkVW?=
 =?utf-8?B?RmNIK2ZZQS8wV3J6OGVLMHZTVzl0Ty9Na2VHa0c1d3htM3RiL0wyZFZyeU1a?=
 =?utf-8?B?VVBvd3I1dHh6MlkveE1RWWpSQ0hhQTV5ZjREcXNUVnQ4UVlmTkRiQ1hvczgr?=
 =?utf-8?B?Z3dSTCtkRWtzbnFHV0U2YTk3L1p3bzBwdTRHTW53VVZVanAvSTBGTVU4c21T?=
 =?utf-8?B?OGltV0RvZTR6QVlQcXpkL2pKNHQ1S1pRVTZZeUJmajJiSENISk4xQ1BJdEVC?=
 =?utf-8?B?VjRyL2FISFdYSXl5Z01aemJDWWdOMHpCZzhTRkgraVJzQmE4MkxRVHZjWDFR?=
 =?utf-8?B?Vk9aTE9nNC92S2s2MjFWbERoUENLbDJUNWhJN0dPandJRVY5UWo3T3V3dHlT?=
 =?utf-8?B?bGxUaVFNS1pDeTlzMWtuMjlSR3dDSUpnWVpIT2FUOWJDQnZ0ajdLN1g2dU1P?=
 =?utf-8?B?TWtrOTJpaVBadGQ4YUcxTlRMVnExQkNQcDkxOEFuSllTRStwOHp1UGZOYThm?=
 =?utf-8?B?SUlXK21ld1pzaE5GMGt5TDlQVm9Kc3F0THVxRkpiajhieC9ib3FoNmdSZ1VP?=
 =?utf-8?B?cy9MVlg2TUp6QTRxME1Ua2ZHcVl4N0g5NnRDN1RaY2xOV2ZMaHJWU3FUd0pn?=
 =?utf-8?B?eDZKWENSTVdaZXVhOVhIb01vM2YycytlMFhSY3ZIR0tRT1dqMkpkVlpDZ3Y5?=
 =?utf-8?B?Q09SYzRMSTRqRDI2bTFTVFJUMDJPdWVNNXpIWmJSQmJvWUNGMGRIaTVsb2l0?=
 =?utf-8?B?c2hzeTZtYjZsRU1Od1JEU3ZlZXVXaHdMbUY3aG9Sb3UzWjhGMTQyRmJMSHZt?=
 =?utf-8?B?SGZ6b0F2Y013S2l6elJhK0NkclJ2Sm91eDZMcU5BR0dMMTlDRGdoc1BIZ1ZK?=
 =?utf-8?B?eVR0UlhjYjFVdG15ZU9lUmdGZUVSSHp0UDJWZkNqNFJQb2dvMlFINmFabmlD?=
 =?utf-8?B?V01jMUZmRTlwTDBIdWg2THRzVkJYZnR1Vy85T0E1ZlNyeGZZYm9meU00VEV2?=
 =?utf-8?B?OWFTWkFmMUZMcHdJWEhmQXBhWm54MjF4UVRNRVFyRGpWeVZoSzFTamI2ZkU0?=
 =?utf-8?B?NEN5WEhLclZRWlY5RldVV3JJWlhjT1VKVSt2MjNlZXFER1RmV21pZ3RTeHY3?=
 =?utf-8?B?bC9aZ1AreVdSSFlwVFQ5S2d4SXJaa0RlUzN5enNITnF5R1hmc0UrM3p1TGFz?=
 =?utf-8?B?ZHArdEVBT2Qvbld2cHNldnVKZGtwaVR3TzVYcUtZOERGOWZJSUJnNFQ0aG9l?=
 =?utf-8?B?YSs1NGJYTGJ6Zko1S3E5TjlLSm1CS01VcEs1ZGFqVTEzQzBSS0JhNzh0Rm85?=
 =?utf-8?B?dVZySm8vTTJXSVZFc0lmeEFJYUtjL3FTdUJnc1RxV2MvNTE2SjFkY2g1SGpQ?=
 =?utf-8?B?eE0wdmtIRUtEQTZDLzhZT0tKU3RDd3JTWURpc0kwZkEwVjlZZnRDaGlPQUxz?=
 =?utf-8?B?RmQ4ZTJFUkFCT1lKTXIwWWp5ekxUWnZVbS9pd2lKSUpNSlFreFdEcVdjdHlL?=
 =?utf-8?B?dGZ3V0hYMzcrYWVvaHZDdFRUNVJ3aG80RTRXUU9Ha096ZGhTTXNqMFFLWlF6?=
 =?utf-8?B?dVYyUE92eVN4T3VwUHZhZk1vUzdmUW9OS0Naa3dtb09iV3VUSlprSmRsR1hM?=
 =?utf-8?B?aGlUWnNISWxxM2QzaEwzSGZwMFc5NjQzam9rUm1IRVVzeEFJVDhFMUp6WHdh?=
 =?utf-8?B?bDhjS2w1V2lqUEpOUEMySkM0eEZQcWowOVVOaE8yc2wxMzFOK29Na044N2FL?=
 =?utf-8?B?UnJDWkZ6amtEaUp5UnROcHVIVDhYQ2tMMVVjeE9ldFA2bnU3Y25EVEFMaVBX?=
 =?utf-8?B?WGUrdlZQUzF1bm9BaWk2SmVkallBYlc3MVZJSDVvU2ZTRk1LcStkZzM2VHFP?=
 =?utf-8?B?aFlPcVZsL3N3QlM0bE1LU0xsWTNlMW1NUzRrVnB1RmRPVVVBWXVnOVJhTU90?=
 =?utf-8?B?elZJSVc3OUQvaVdSY1ozV3pYOG9oQ2Y5VXIxbVlteWhUQnZ4bHYrVmZSanBz?=
 =?utf-8?B?a01xRTFQZFFDcTFwZVdod1JXeWZlV1NPaE9MK1NXWThEOE40VE5ORkZZWlhD?=
 =?utf-8?B?NmIrM2lVdFJ3WXBWTGhralJaOGl1ZTBlMm10SUtPN2NYNGFiTnhDK05QMXJY?=
 =?utf-8?Q?Y+Ghgsqtbhq5YXxu499dLqMP2m2vXKpMXXApg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7d1ad-f1cb-44ec-5a78-08dee253cd87
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:31:09.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/QZpIqZ/jDdDEszmchthGcCxwCXIvDu/ddQlvNlAl48KIDgvgf/s8V6CCFisQEURujQAhCcyzHQamw8RJh6PdVMurE2jLfMArnPGvxa59oac/+5ERosdU+XQ9wNWYw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

This patch series improves the snvs_pwrkey driver with better code quality
and add report press event.

The main improvements include:
1. Clean up the code by using local device pointers and dev_err_probe() for
better readability and easier debugging.

2. Fix potential event loss during system suspend by reporting key press events
in the timer callback.

Signed-off-by: Joy Zou <joy.zou@oss.nxp.com>
---
Changes in v5:
- Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS and remove
  __maybe_unused from suspend/resume callbacks for patch #4.
- Use pm_ptr() to wrap pm_ops pointer in platform_driver for patch #4.
- Replace suspended flag check in interrupt handler with a pending_press
  latch: set pending_press in hardirq context, consume and report the
  press event from the timer callback in softirq context for patch #4.
- Link to v4: https://patch.msgid.link/20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com

Changes in v4:
- Use dev_err_probe() for devm_input_allocate_device() to simplify error handling
  for patch #1.
- Add Reviewed-by tag for patch #2 and #3.
- Modify the subject description for patch #2.
- Link to v3: https://patch.msgid.link/20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com

Changes in v3:
- Add spinlock for pdata->keystate and pdata->suspended per AI review comments.
- Replace hardcode value 1 with local variable keystate in input_report_key()
  under suspended.
- Link to v2: https://lore.kernel.org/r/20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com

Changes in v2:
- Drop dev_err_probe() change for platform_get_irq() per AI review comments.
- Add new patch #2 replace hardcoding -EINVAL with original error code per
  AI review comments.
- Use dev instead of &pdev->dev for devm_input_allocate_device(), which was
  missed in patch v1 per AI review comments.
- Add a boolean variable suspended and PM callback functions to replace
  the use of the is_suspended field per AI review comments.
- Move event report handle to else branch in suspended state, since the
  pdata->minor_rev == 0 branch has no debounce detection per AI review
  comments.
- Modify patch #3 and #4 commit message.
- Add Reviewed-by tag for patch #1.
- Link to v1: https://lore.kernel.org/r/20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
To: Bough Chen <haibo.chen@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Joy Zou (4):
      Input: snvs_pwrkey - make use of dev_err_probe()
      Input: snvs_pwrkey - propagate error code of platform_get_irq()
      Input: snvs_pwrkey - use local device pointer to simple code
      Input: snvs_pwrkey - add press event reporting to avoid event loss during suspend

 drivers/input/keyboard/snvs_pwrkey.c | 143 ++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 45 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260615-b4-pwrkey-a60b2043cd29

Best regards,
--  
Joy Zou <joy.zou@oss.nxp.com>

