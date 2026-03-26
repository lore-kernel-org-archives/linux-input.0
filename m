Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAE3A7839;
	Thu, 26 Mar 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521493; cv=fail; b=i7dQp+nPKqyDZjTeOrVqcVQEE+0FMjhnCBKmPc0otSuCG7rnJBAf56MZYwL6y618t0mZusen140wq2Kh8rmIG5ugSgAI1cS1IYaAFytKqGdSMhgJ6sw433Mu2p89qf/Cns/4PGpw8e5mSuVPJPrskFxVQY35qExhpprtCxVbSt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521493; c=relaxed/simple;
	bh=2yHwQckEwnpiCMrOqalfLIBh2CZgUsWlpceHYSxS8/s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kTvUlrwUWgP11SDofkHQamsTzFQJt8+iuc/q6I+BdBybpwdVao95lWtK+2GPkCJ2AN8vQPUWqIHCuORftzuQyJ+8GIugH44WImvr43Pdr2u5txP3VYtpliIjMnxG5OvknAbAK408fLL/DWig2MA2Vp0DeA5MGh2FSrrnrudgJc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRcuE6z+; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRcuE6z+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPmp4kfWegv7QvlT6yquPz31L8G5GYBKb6MZGk3OWXzf8voEwuH4+IoOeewyGMH0LXDNuNj07w/KTE6MQcR5jX4nC2b9k7aqUWzV34XXkf0/EGqkGfXpBaIiD+oyMjgCB1E3kb3llgikmG44lwWyWZP996MD03CuSjznaboWZ9tPB4IJm9CV3bJRyj6n+oFnd5GxViGtyY2kupLDk+ELFM78+EjVaCygvoSFQw6HZHIYx5wy3ssQYHnGnOhhYfeO5o7/f316T9vD6ddOFqQqQtq7czjGEyWLB86DuCaDv8e0SqHKuOQwpRqerX4nLAZ7mU9Gycf9WTBD0pJczxfRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMUlKmfFriUwcga70NUsguDAtjCPa0xKET+NT/73wX4=;
 b=QD+pudkrgPAoAG34nu5061n0mv8R0kgU/WuCzMUHga45kpCGcXmTT8sD8Ww1m3S4P5DOQTirObOZVanFV7ly8VDprOnVN+CjgF9eekJyRYjKLDz661CBDuWpEsr+gzR1Rm+Qi+UxtbcM36vwZ3cbUyiFk+yKPWwsMpKFmsjbNRFnfe1ZmDEbg0rn8B+rRTys3vSB4kGxspzwCthVR7ru1hTB0e5KWtb+YW8T/LSh9ArERYfBo5p/QIhk9tqMD+mPJct1EHFP4S2kaoMy87JIXdcRHgrRJF/7kVavSaPe7jXRHTGfOe10zM3fDkvd32pn8crEKg+24hsUt0gW8FBEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMUlKmfFriUwcga70NUsguDAtjCPa0xKET+NT/73wX4=;
 b=SRcuE6z+3P3CKtIYOCYLdoHENK1au7jNlo22dhxKM9gS0DN9TrHfdA1h/7UeABCGxS/EL/7TNNZMay3fpdWQI0FT7Wycj+bgc788dP2rc5j4IlqjTF1/Net83Tv1hg+ZQGL8ugjhgMJdZvyZBGARE3jh5paBu7xlsoz8VnJI68HKFAhuRtYkbL77DmNKhNW0omtd+REAuMaDpTsJDX9+C6OltzYpehZXETyeyoj5qaa7u/FNhkaWKMFvoaamrckj+HMCMfwmr0EwVpfWvn2wvdEZMHrX//MK8S1mli8fIVvx+uxC6PJVCc4Qz7AzErH5+huKJZsV64bd8gIyaqCoBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9006.eurprd04.prod.outlook.com (2603:10a6:102:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 10:38:09 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::1fdb:9c8f:5400:8bdb%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 10:38:09 +0000
From: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH 0/3] snvs_pwrkey - code improvements and add report event
Date: Thu, 26 Mar 2026 18:39:37 +0800
Message-Id: <20260326-pwrkey-cleanup-v1-0-d85d7c0bf275@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkMxWkC/x3MSwqAIBRG4a3EHSeogVBbiQbR/atLYaL0Itp70
 vAbnPNQQhQkaoqHIg5JsvkMUxY0zL2foISzyWrrdGWdCmdccKthRe/3oOqaK4YzYMeUoxAxyvU
 P2+59P5ERVwFgAAAA
X-Change-ID: 20260326-pwrkey-cleanup-99d3de61ed6d
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 494658f3-0577-4b59-4bb8-08de8b23c608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jq8eIHQYsVkGNXP3rFHNCbMHFAe3E1KoPNm6Qi13HLLOLD9dgtvTLvuBLCVi2bnFlMUuC/TpVNMSHEYNQ2XpC1uhudYLRPtV6Uxx/5kDRcjMjpCzTJSsoXRe6JPXs9CxvJ8pOF/FJ0gsM1x+uaRdIuH7AtzMhq+KoQFoQSNZuAO7ljCudIZzZwa1OnHEnqTNt8rshSFrltMkZE7AlfY4p2YLPXhNKS8pe7XnFdMoBYcQWKyDTMtesqYv3+QvetRjJSRqhho+w4WVE+SGpCfNeN60HafRqB9d9oBH2O2IEmpoQRzI89Ki9qFgUeFpgKOYwrcrXiQwwIs2YXi5Y3OVk+lki3bcjBIv1a7T+W/UQ4nVhwSyMTSGEZQElVjb8c+fmxLJybwahV6aDuS68/hKwvMrGTcD/UuNrQWThnrgpreBWhEV1mqwZSLygBVJwQazynlfX4khaG0KaylD72E4c2+ahIDAfD/53KkowBgw97ZFq9cNgy+eFk1wetdPzaDZW2tBVybrBqZD10+6Cjuq/eM5aNpcBxNwaXGyOQY+TERElUiL1PiuPb0S6fxVYY/d0B/h6HlfTiBxbhJ2K9/VEbc5EOEAktkoFDYAkLMRmi5KhIMiVHBV4iVywawP2Evlci/fwDlPl2yMZg7GniCga8SfIqmxIe9M0zxjVGVO4qqdfA8OP+JyiudL9sqWm1XJwkeccb6zdZPl89suYa6zavQoCxRjSgmQuR2lolYxqb7tqFMzGJUkk4GhTIT9K8PjCPobHYvOSzeOe/fPlJL4yh/2tIFR6GJauGBIDgmRRaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TSs0UTVaYnY5YUkwOWs5U0YwaWp4OFVPNk9razVveGFWWm80VFIyNVRXMnhu?=
 =?utf-8?B?Vld5UHNqZCtiNjBpbitRaUc3WUNDM2FzbHNPVXlNTm9ZeTloeFBPd1YwS3hp?=
 =?utf-8?B?K3U5MkdsYWNUTWZFSmtqMXpSbFZ3dXpLTVE5QlkyaUZ6ZXhNWVNpNDVjcjBG?=
 =?utf-8?B?QWxJWldCWExrSndjZWYzWGhGcVJSWjZLS3RteFpPZ1BlU3FWSDZRSVdvL2wx?=
 =?utf-8?B?WDZBYkdHKzNuS0R2dmw1Wm9McEloS3JvbWlHOW9qRzZ3alRJeFRxVzlNQkIz?=
 =?utf-8?B?RzUwalRDdHRxaFMyZS9SMyszbUIwbWcyTTZ5WURNbGRiSkVKOTJGSmFzSVdC?=
 =?utf-8?B?RUh2cUMrOGtTY0lZZzNoK3JqemxtMnlhdVVxc095bTBRdzRQaUNRaUtEbFp3?=
 =?utf-8?B?elA0WmFmZlBybEg1TzRGcDBoNDZyUktyeWVkeWYzMkpxV3doVEM4bDFMNWhC?=
 =?utf-8?B?N24vMXV3bWVEYWxUSEVhb1NVM3d0QlNBb2dZRm1FdVlpYnpETXJjOHcwNDVT?=
 =?utf-8?B?Mzdjc2E0SDB5TDZlK2ZpSExmTHN4a01BeU1EK3hKMmtsRmJmaVRaUEpUS2h6?=
 =?utf-8?B?dWZ5VjlGM09yN2dBbzlCdU1SQ0xCVjlFdERRcGxkRytkajVuamF5bVJ3V1FT?=
 =?utf-8?B?TldBZXdYenJHa0lPNXdpeU5laHpsaGpIK1pnZThBakR2U2FjQkhUWVZzek5J?=
 =?utf-8?B?UjlSSUdWeDlUN1dGQThVREgwOElobE1kQmlWR2hKRTA3dlRvOWJhNG4yMEFL?=
 =?utf-8?B?NG1oY2ZpbTRraUFlM3o5OWhCTW9yRWZCQk9jY1hKYXJGK290a3JZbUVVdFNQ?=
 =?utf-8?B?V0xaZU9XVVV1Q0x6eVhQVkZQMTgxSTVmN3A5WjNkcnBKcTRkeVhGZXltTit4?=
 =?utf-8?B?K1ZJeW9MamhzVHd2R3ZwS3ltelFnbkJhVXg3cm8vVGlVcElkcFpVYTFDQkNM?=
 =?utf-8?B?YU5DNjBUMWlKcG0rSDQ5Ujd0MVFqaHpiQUVOa1h6YVJHMlpyU1BJL3VRc0Fy?=
 =?utf-8?B?U2RRbzlaT2NFSkNOU2hVZVNsQ1BkYmZ0WlhBWms3U2YzeTg1NktwWFA1NGl3?=
 =?utf-8?B?Y0J4eTlvd013YlFuS1VDKzg5WEtaZ1hneHVCQjd0UDhYcFYxMmZDb3NMUmZX?=
 =?utf-8?B?dkNlNkIzWXlFZFNhY2taRXZpdGJOb3FSYUFmYkZDT0hDOVF1c3FPdEVRUWc0?=
 =?utf-8?B?R3lUSjhCM2dxOExKdWRFbzJ4cnFRYklhTzU2RVFvZGdwa043d0FRbGptNjc2?=
 =?utf-8?B?OUc4eHhKTE12NjR1RGZZN2ZpeUxpc3hnODNxM0EwQTNRUkVYc2cxMG9rQXVF?=
 =?utf-8?B?TDB1d0toN0pqWHgzQm5wUXVrSkpBUGFJb2EyZnp6YXcyd3lyekl0a3NrQ3ZM?=
 =?utf-8?B?SVZKMEVDb3hzOTM4SHJmY1ZxNy9Fa0E5NUxtVkl1QWNwbENmMUlyNXhKTU8z?=
 =?utf-8?B?Ti8xejJBdUk5ZUw5TkV1Y0NhTEg0VTdRZUFsOFVwM0FOc1VyVG85SWd0NE9m?=
 =?utf-8?B?KzdTSWliNUEvR2xLSWIrbXNPRjZhRG16N1ZhWFd3SWEvU2laODhES1ByL1dQ?=
 =?utf-8?B?L0NOblFqUUluRndvaGRSV1kzYU9GUHkvQWhYalI5VVdHRjd2YnZUTHBqOExB?=
 =?utf-8?B?UWN5RmJnOWcwN2pJR2ZWdXRrdlZJbHFzZFp3R0lKb1BFWEFVRUROWS9hU2xn?=
 =?utf-8?B?OFFJblgxQWVxNDVBWHBkcWczQ2VVaDc3VUJiSEtick8yejVrRlYvRU95UThP?=
 =?utf-8?B?YzljejdtNU14OWZWWTVXRDhLZGxrUjM4MmU0c2hYOTdTa0x3NWdIOXlpN1VO?=
 =?utf-8?B?RStGOFBiS3BFVmpPc1JKL2lmdGVBTkdhVlc2Sjltc0t5NVpQTXprUGZLdDBU?=
 =?utf-8?B?bWZjV0YzdlNQc0l0cHIrZ285MTFpenB0RURYVzloYlozaW1BbXMyTTcwWkhI?=
 =?utf-8?B?c1FaQW1qbDJFNkQzb1dUL1FpSTZhd3E5RW56bkxaVGpPcjVxM2Vub1psZlNH?=
 =?utf-8?B?cmswR0hQaEJMR1Myd3piNWNoQXIzbFB5Y2dUcHQ1bE1zaXBXV25UZGErcEp4?=
 =?utf-8?B?c0IxSVNYbFkwOXFnRW9TdnNkMmVlYXQ1WUdNbUVQSU95MFJVb2FncVJUNHhw?=
 =?utf-8?B?WmEvTUZ0c29JdzE3M1NYb1hEbnJQNnhVejlWK1p3Tjh2RjNlTysvRTExQ3R2?=
 =?utf-8?B?d0h5WU5wdHBHZkp5dkhybDkyUzJwMkNjb1F6elE0REY4R1BVVitxOTZaMEJS?=
 =?utf-8?B?V1RUSjZUZ3VoS2s1ekNRUlN5aXdxV3dpeWVHQndqU0ExODBkZStlQ3pYT3VS?=
 =?utf-8?Q?84YLOfoa/nuOr0tlL8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494658f3-0577-4b59-4bb8-08de8b23c608
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:38:09.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRPpaiI9T0Q17kQ+aZ1fYr+xV110E6Exgu40mD2LDTyqwcjtQJLUB9PgBPUB0Bl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9006

This patch series improves the snvs_pwrkey driver with better code quality
and add report press event.

The main improvements include:
1. Clean up the code by using local device pointers and dev_err_probe() for
better readability and easier debugging.

2. Fix potential event loss during system suspend by reporting key press events
directly in the interrupt handler.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Joy Zou (3):
      Input: snvs_pwrkey - make use of dev_err_probe()
      Input: snvs_pwrkey - use local device pointer avoid reference platform_device pointer every time
      Input: snvs_pwrkey - report press event in interrupt handler

 drivers/input/keyboard/snvs_pwrkey.c | 75 ++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 37 deletions(-)
---
base-commit: 66ba480978ce390e631e870b740a3406e3eb6b01
change-id: 20260326-pwrkey-cleanup-99d3de61ed6d

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>

