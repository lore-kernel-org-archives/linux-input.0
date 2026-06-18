Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844903C81BE;
	Thu, 18 Jun 2026 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767744; cv=fail; b=BXk84VssxKgDoQAsfOaQErhX7Q7pvoc+2TGFdmczexfaoZgTjcDPDN0Sle4SnqcpDCl9PYJPAJ0sW0+Lwkx1iv3CfG6f+UuRcqmggshsHdPnavkc+o56t0/fOsvQifQxgC5FT0WA5zPNEpWor+4WqjxehE8+hbkRSyANr/dG4Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767744; c=relaxed/simple;
	bh=ezk0gsD3X1ZpdUXpCx3exhCXHPKIXbA4Y6by5dxmJTs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pctZvmagarqggcXVg3+sF0NXl2VI/DdNI/+V+ScQ9firXVinjYmDqf6Y5YCY43178JPsEl85gLruJG5OYVAxQqAL6hhicPtwj2MPWXzBLCpNmmitj5UQLzWCAbQSD/RTSDjjZ/dGabNyeS1s1CV7YeUOPqS3m5ZQuJeFv00ZTKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=si5jhiYZ; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="si5jhiYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf27zavGoIAIxL8V9cx9gAOrMPveC6OW6JcbX/ynOS1ndbcqUicDpA5dNWWcDLfqeXoXXv0s15yY+Oe7+M6HpUOAV+0NyKGQH0Yx7gOIns8P9l68HpowNVekVqi1KvMU9cnCHgNZTEd3riPo0avF0D+Y0JH9OjDzacL/wq36Csu38vFfWs/DsmZpHbdHsr9fA9Gyg0hIhpe1O090RqdNDo2fTCRpnRKT3kNOAgebjKfTZvwOwrTXRh7e7kT4cHo8JGhSwXhg4C9rtGJuRKG/4tcm7Ys3rJGdlVIQrluD7wg3XApdVMnuMT14Xu/tsmcJjoJiKHOLAdtFIZMHtpkN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNASxd1vm2jkRhH1oQm+v9m/EDvQOA4Q+Z1IaFn9sbk=;
 b=ukA65V1e0HPahGWZkuY6/VrbUZ2MJ0uLlTGvo2hZocqjUa6rt56uu3bDrgNFtWj93LQGg6ES5cXJfO/KWwlRbvKTXt+GQC3ydgksSSlJ02h69PXmv/etn/bD9S1jYS7NMasmNlFDhqyBLkFIxHFClwVTuabRKTsE1v2bVECD0fdFLFPl2zY126sBKGX56Bztv7DcdAcfA5SHjJmcXzkShekNlSeJl2CMOOML+OlPDk+SDbcOW0ngixLtJl2lsosRaXHEbCUicPV3ce/X4de5UPG4aTkUb4ZsaE2nes0Nao62+1w5ggzkekXvl/ldW1Kwa1NXyipvcIqnJtJ79+xU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNASxd1vm2jkRhH1oQm+v9m/EDvQOA4Q+Z1IaFn9sbk=;
 b=si5jhiYZgT1cKNYcCFJRQ9wAHJawKLBRcyNKfu78WmE08lXssrSBZF1Mn/2KaKpPblKkmN63Eap25NQhSNxoA/EWVyvOCNBkPNE2O2cV/BSx4Ynki2OPPoMM2f6ZUgWgPJE+rD3F+a6EDV6M7c99oA8B7Sb5nsff02ZTNChxu9ylPsRpYrxo6ztpqpgCfmlXROD3F7m/NIqnGmDLcNM2F66mrFR4/Zcp5iEB+ESIJrmBQ4SDLFonGtaOuzOC/ffaZPiE3iP0yjNqZzK7oAqR0WGm3CXHsGNCzkXB5eo7ODItu/LbLswzRjSqwaMl0jH1CBeR6dgbMtDCzxKm3LQ2yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:28:59 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:28:59 +0000
From: joy.zou@oss.nxp.com
Subject: [PATCH v4 0/4] snvs_pwrkey - code improvements and add report
 event
Date: Thu, 18 Jun 2026 15:31:45 +0800
Message-Id: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGeM2oC/3WNyw6CMBQFf4V0bUkfUC0r/8OwoOUi1UhJLyKE8
 O9SXJnocpI5cxaCEBwgKZKFBBgdOt9tkB0SYtuquwJ19cZEMKGY4jk1Ge1f4Q4zrRQzgmXS1kK
 Tze8DNG7aW5fyw/g0N7BDDESjdTj4MO9no4zer+4oKaMVnLQ0tQIh9dkjpt3Up9Y/YubfRuecG
 c6PslHwtSnXdX0D1k1lPuoAAAA=
X-Change-ID: 20260615-b4-pwrkey-a60b2043cd29
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5b790-5673-44cf-9ffb-08decd0b434a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PBIi/fipo93Y1So3z7x9xGN1DQTG9HYdEoLOfHdum+UQR44Imwe4YEmZAsgdn08alOId9l2aVFc0bqKYQPtYnP0HSYoHbE6bBF92On/pl96rv+2b9LUr981N3z/UJyzFuOUEFM56UxztELRVHqEPj3dSGGIhYXtRSgcFeupFfT/a1yszZm2CCDxKFjcOjE4br8Srs3F8SLRCaUq8WtTeFd4DXMocYTExXoU7cwMeBRknwh6KhkdCbiyikbgWcQylJxutGTyj3QZRf1Bxom7NFzakeCI+zWbttG7NpnX9sIrxp13HVCndklSNCAdrhQOsOaTl1yNesCwLmeore0t3ZE+uQA1JY4peVAGcTbBHlx1I/QPUwLhpyWEc7LwwKsqvcg7tcukYv4YRtQlinPi4/FmLh/L2rzj3oS0+h3yM+klBI4YSM9sGat15Jmm293meMFv2WjurM2iPURIOnTa8xezGDPj0F5d9ykYeQuN05oypmFIJHmWhKrf6TFrEgjNrKN2I3KIJ8wbAIisaKaJirppsb47HqaqW9mhuTu0aeDzJjNfLfU4cNhTbdcghOxpwKj+boqJ78q8j5IghYv4CcdMgt2dDP6gb0NqJJKN6o6eKoZSs8GCj1R8wB6d9T9Rkc+i7mMFOpkmeWRwz4Iv67w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ais1RkdmZS9DeElKRVpLYU5PZ2lMaDIzMFh0a0NUSkx1L0dDT2hLb2FtQXcw?=
 =?utf-8?B?N3oxNUhjVTkrMm05djJyMXRHa2RUcFhwOStzYi9TaDJxbDhPR3lyQXZydTBs?=
 =?utf-8?B?MFJMbm91eE9DM0t1UnQ5NTdkeTc5TXQrdEhwY3hmbjRMNW1RMVRTbGgreFdW?=
 =?utf-8?B?bE1kUlBJMEFJMzR3Z2w0ZDV0aysrWGRPaVczNFBvMmJDVWV2R2YzdXJJOGIx?=
 =?utf-8?B?enEzYWxWL1VZcmNseXUwb3dOeEJvNzd1QUZsTys1bmlOM0tYZGpYcWRrZks5?=
 =?utf-8?B?ZXU3K1h2Z3dmcmZ2Q1g0Yml1bTIxZW5YbkUrbGorSXJSMmszV21MNW1yNmRj?=
 =?utf-8?B?MzN5THZENE96cnFmMU9KUWhzSks0RDJUMXMrYmdjbzloNWRaRG0zeEtlNmVK?=
 =?utf-8?B?c3NpNFlBRW5kdE5sUExCSXhhTU5qRkJROU9NeFBhdWMvb296WHNSOEtPNHNa?=
 =?utf-8?B?Y01IS2xNT1I5SXl5VEV3Rk9ERDdmeVZCYktNWm16K3NPdllibm82WFVtd2JO?=
 =?utf-8?B?SFBPRkEzU1VMZDRRRjlEbHJUU0tkdzlsbnduWTE5VUVCWXY3cTIxc01UdDVn?=
 =?utf-8?B?YWo1TWtCalYrcXhyYnUyWDJMMHc2TzNEa0Voa0tONkZTRTFXa3hzMVJ6SmdV?=
 =?utf-8?B?dWN5enY4c1hML1M1dkFuaXh0RWUvMWFqNkdHWDBBdGZ3cVhQcGxxVjIyVU8y?=
 =?utf-8?B?Um43UWJhcEdvNURLS0VVMktUZXpiUzlkZzZHQUFCMmhrNXRObHJFdERrQWVn?=
 =?utf-8?B?cHZrU01DMjFlQmJKMGNXUlBKM2NuVHhFRTRPYWdhWmRFV2JiVEFPbVZPdFg2?=
 =?utf-8?B?dU5ybm5aRFNqSUFTRkFKb3F2RjhHSDJuN0pwRjI4WERSRGtkUjZUc255akVj?=
 =?utf-8?B?b2VjQnF1UGdwOFJjNFY0MnJaSzZkbGxUcmM2TWFGR2NzUG1PMnJlMDM4ZkhT?=
 =?utf-8?B?aGdkU3Nla0xwdjljZmF0NVp3R21iWEpFNGxDSitzT240U3J2SkwyWFFGNldY?=
 =?utf-8?B?aWQ1MVZIOWtmcmxLMXZBem5lUjBlekdPZUNUZnVvV29Ka2xqR2hQcWx6VlZJ?=
 =?utf-8?B?QnNUaDZPWFZBSVpFSkFwQVpJVEFmcmlsWnR1UmxIZ2dHd3RUeEFZcnZuTUZD?=
 =?utf-8?B?TXBnTkMyZXJKQk1DYk1GQ2lmZ0I5UE1OTlhWaTZYQytadzYzTmo2czd3ZTdN?=
 =?utf-8?B?M29wSVR6Nk5XdzBEcG8wSzErRFREZDhJeEZ1OVV0bUFhOXpXcmNRb0hGa1pt?=
 =?utf-8?B?MGZBcUFYcEJpZXV1bmFMaXdRM2gwQzRQd0w1UFdaUFlaOUlwQmdNK1YxNjNC?=
 =?utf-8?B?N0N0VmZEUmdlU3RDU0k4YTM3TXlrcTI0QmZBQ1FSMXJYMDhuWExBQ3cydzNX?=
 =?utf-8?B?SzQ1QTVJcXNEWXNLWHpvRllpV2I1Y1VId1dFQUhzUmtxcEMzQ3VBa0tTWW9Z?=
 =?utf-8?B?U09OKzhaSmhJZmZMN09ucCs5TVh3Z05EWlZhak0rSU9lcjM2Z2JqRUZZb0Qy?=
 =?utf-8?B?bjc3VllTWmhtNXlXY3dOL0gwK2c5SXlCWjZBbEJrZ21oYjI0Y1UvdHZEN1FC?=
 =?utf-8?B?ZmhITk1BK0hqdmNsZkdoUEcvcnJlOHVQY000bUZYS283WHBUT2Y0ZHJSOGlN?=
 =?utf-8?B?cXhIWnVtMmI4NDR2TUZBUldkY1FKNkhSakZUWkhOK2xQdk1TYXBIQTdtRDUy?=
 =?utf-8?B?MXgza2dHN0hGYk5tNHh6YUVpNzFJVW9IS0VqbmFSa1owTy9SblpSdEZnSFRX?=
 =?utf-8?B?MzJrWHBiMkRDZEtNVlRoVS9hOEpqYUZBMlhtS2hCeGNDRzAzcTg1dklWODR1?=
 =?utf-8?B?ZjkzcUZidkNlMXRuSmhsYXpveVdYRWlDMU1BVEZFTk1Nb0FPQmcvWUtnaFRl?=
 =?utf-8?B?bXF6d3BTbHRZZXgwa1gxSEF4MVd4dWcwbllTSWJ3amFMKzhUemZRNXkrRjRS?=
 =?utf-8?B?YVlkdE8rWEFjTFZoKyszbU5JQzJMVzFhOFJUcGV6dnFuRC90Yjdibjc2RlQz?=
 =?utf-8?B?YmxxVHd2aStFQW1rQllwcWM5dHlMRGhJS0w0ckxHTEtwRVpjaS9qUEhIM3NF?=
 =?utf-8?B?NHVHWTNvand0bk5BMDVpR0hocDI0anNrWDFWR0NEWCtZa2VFRWk0cHhzRXY3?=
 =?utf-8?B?M0ZMZmxOUXNnVjgybmViTmI5QXB4WXp4VTdtSXNJSllBWTdHRDJINytTVjBY?=
 =?utf-8?B?cEFrbEZhMGlTKytTMDdwMFBuWXFuM2hXSWUxNVo1WU9RTG1yZGFZRWoxM3Rt?=
 =?utf-8?B?Mm1VZnNscjY0K000NGRLdjdNRk1abXVCLzRaSDVDZDRGSlh2QUFVV2YyOGRB?=
 =?utf-8?B?Z0tJMFZ2bXBwaThvNzM4S2pyZloxMkVvNkNTdlN3RmFqSkJkb1lYMUd5dUVp?=
 =?utf-8?Q?F6WnXbnh0WTt5pxQZUTTjsz21wLAsJM9GcYH+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5b790-5673-44cf-9ffb-08decd0b434a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:28:59.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHt6W4hbmdhJng0S77y7Gm73UMmRJ4POOjqSrALhUBxelHIsVVH1OyJDzL7UyajceC+pFGoy7IvgI1VBwpTieiFPmOkA5YNLG/dSQ86LEvPJIYMqZyHH0lnPg9qU4dZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

This patch series improves the snvs_pwrkey driver with better code quality
and add report press event.

The main improvements include:
1. Clean up the code by using local device pointers and dev_err_probe() for
better readability and easier debugging.

2. Fix potential event loss during system suspend by reporting key press events
directly in the interrupt handler.

Signed-off-by: Joy Zou <joy.zou@oss.nxp.com>
---
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
      Input: snvs_pwrkey - report press event in interrupt handler

 drivers/input/keyboard/snvs_pwrkey.c | 131 +++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 44 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260615-b4-pwrkey-a60b2043cd29

Best regards,
--  
Joy Zou <joy.zou@oss.nxp.com>

