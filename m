Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD023CF962;
	Thu,  4 Jun 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556060; cv=fail; b=MQtPoNWjexr5gMKm1cm6EaxMViGoh4vmtLYc9xGRY4EgxDqmnvB/9GBJ0i4Ukrbyco3s6ULtrtp9zy1oU3r7GnNTOnriQFIEXt88M2aTqKfGWGHHGWAf2CSNsUPwE/lrVkpsW6CrFRKoYRIcfJ/hbcIoa4LNBUIOdQZStv9Vplg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556060; c=relaxed/simple;
	bh=iiP/1UobeEhE2mrOOtsg4RMYdh2JfuHxzzNfkhkXusQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rsmQC0IMm7mARkVjTzsJ2suP13MOm3rOdWEi++ctKfLxk0Xr0c7c7N8ytWGjaPS9kawsFL1RAm4BmYDBrO9VoTt6lYhwt3cop2pkI57nxYpokM2KSHsuOsbU8Qc06QEvOwClyXCGU6C43EpAc7JA/aefWzntPuc4gQAvl/mZqLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ui8JGFdk; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ui8JGFdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8R3s8vIHXSCr7aXoFoUoqx2C10aghU65jRbHXnZECJihhUsgrRhZE+++em9c96j9OfsQ9TGhsMAa7Qi8ejiJ3iABDITfq/x3jcULybms8k1EeHMuVo4rw8LieGWAvsOWJHrv87+ZhaMDMLy7dgbu/mbezIaZZxGdeeWFhHjP7gQpjpELNlp9MnHATVU24PMtq4gMoMy/dLTBEVbX9B8fQRMsr2dQdGckhD1FXYlczel29ve//pJzc/K38xS+f38lA/Acq5LHhEjPkUkMXMajBz9aV/+lfCUBVbgS1lIZ2vkileLX8QSll8+uwiuMtKypaloQP5K1qWArNp1FK9XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob2FYLDQi5XZ2+KuRwunVJwE4Wd1EkJ4pZ8b5n1oCL8=;
 b=PEtGiVamENz/eKueizkRvbYybCP+ZePibyb2ZtbytVSA+ZH+FfogE9vHghknuN2F3+j9a/q3UmGbZyc3xqlzZBRzzV+y54TeAhFpzjTgqkGXEOs1u+wllm3ZGvz9NEEDnBwi0ybBwx31aZG++lwsFd2Dm3Q9ac/isuUJjPV4tQ/5hEXJDGT0rC67GWEnLgWRJDkqNCPL8T/FBP84AUBoccOt87ip1OrpSKBU+ZE2gP2iaXDXdzYQRsHYCwyVdO09uT8QmgGNuSyuWMmnocrqDtfAAwHlsjx9BRVA3+dOuUfWSxqA4RQYoyLPXvVdB9FVNdf/OIK8BGxc2wuUG5M96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob2FYLDQi5XZ2+KuRwunVJwE4Wd1EkJ4pZ8b5n1oCL8=;
 b=Ui8JGFdkGJaom/W4OsqioB2HtDgp/uQDH9l2y2tGgYJtssz/BX1nKfSTlZz7nNuMUXXIIZFvw3d82azkaopvKSdZrWDjp/VZXkh/jzn4iyoTyi79jg8cC5QqI5gBEJe/ke4X8CyPD3DCmB6AulumYhB6SNccaRZrBqW+7eijijJSuLfGFqcvcp6v92PB2r5Jxb9ONJbM1FYI/vEOtrv0FYF32W2bNpo68a7uXbyq24MO9gzF79K9Gq/OoEQ0Kx/ac8AHNGzjSar0pXBAgCAtD13A6RtTxGzPnDCHS3nWwVWoPFtJUksMn6YWvWvUrFsNbhPYgZ57dRlAyrPSehOjEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:54:15 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 06:54:15 +0000
From: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v2 0/4] snvs_pwrkey - code improvements and add report
 event
Date: Thu, 04 Jun 2026 14:56:20 +0800
Message-Id: <20260604-pwrkey-cleanup-v2-0-59fa0ddf0d7c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQhIWoC/3XMQQ6CMBCF4auQrq1ph1DAFfcwLrAzSKOWptUKI
 dzdwoaFcfle8v0zC+QNBXbKZuYpmmAGmwYcMqb71t6IG0ybgQAlclDcffydJq4f1Nq343WNOZK
 ShApZQs5TZ8YteL6k3ZvwGvy09aNc37+pKLngWBVYanHtoCwaO7qjHp5sDUXYsRLyB0PCUJOUo
 oK8U7DjZVm+BC0VX+cAAAA=
X-Change-ID: 20260326-pwrkey-cleanup-99d3de61ed6d
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::7) To AM6PR04MB5765.eurprd04.prod.outlook.com
 (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: b670f62c-ad47-44ee-168a-08dec2061772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|366016|376014|38350700014|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XwLQp26RsvP1h6ycTZbET2Ll/mOGJPySQ+g3xR9gg/JIVBTZgXlPSfCYXB6z0N/KKr64KevfLaankV+ESq+SZu6B1V7sewK0/UhfwwKKji/QkOhixnCULfljWOqOkpwXYc7wOQc/WROdlmKdzCMxmHCWg78RZEWcvgv/KsnE+P/3kPE4iqIvN3DMAywRIHvMXFle/TP0jRwGpkbZBWS5InXCzoOwK0RDmN3naAx4XIG2PyuEP8Vx89LRrbUmn7EXg2lKFIZzeIP3Mlrfqf6v43dvD9J1YB1RzsZCFy3UEx4RRGdYliP/D7PilmVOrJfKrFjwEaBQu/o7Gc4Yx1fEUWfcsftDU4vTMYVp/kV8phtPh5Q5gJ0Vxlnt6Wq1sZbYwHzyENC2AAoAYm004GqRkQlbCvaKh7PGy4PQEn9/DXVQ8c0NA3uzuFMiwpv+nYKVOHoY/RwyVRlZgnUCeFMNptj3t+iIByACvsLdq+IKXHypFcdtv4/lRA1UlNOUdx0D7g0p8DEhu2hPGGtr0KIExYJ62yw38XjbzZRZyjQVnlZNRXkqeKQPv8UDxbEK/JY+37r9P1Dv2YYiS7nxy3ht0EQ+peXLsn/GTJE9Vkt87kfJR4kZF3lSJEb1HUYsw5DYL9OF+va5SSYPHEkg/2GydJV4llCS5AhbsJ8l7E+w3+OWZEZnJbwHmjvO/7J58BCz5//6mSrjNcGxYvAyZmXmdv3QNy73gsczkJ2NMyqkefy/X1MvFMjv6QU4olgfmu78
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(366016)(376014)(38350700014)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1Z1Um1wY2IrWXo0UTFIR3RTVHJzMWZmVERDbGhiU3kraVpSaUZ6TTNVSmZk?=
 =?utf-8?B?SUVtRG44RkJmZ3d2VWw5R3hKNlI3K0tNZTgvYlQ5ZHdoK0dSMjU4dWg0eUF0?=
 =?utf-8?B?VHZjSDFGLzFsc2U0QjN3SGRhRHc0QU42WC9lZTM2WU83WlJucWtsUEpaalV1?=
 =?utf-8?B?S21admFabU56OFA5cU1CRHRzcGZ1TVdheHhFNHRmY01EMW0wTHdZcnJFMlJ3?=
 =?utf-8?B?eFFnWUNFWmxsVVlQeitIanUrYk5JdjhtYVkxTzJhQUU4VDM3OVk2V0E5TXJ3?=
 =?utf-8?B?WXN5QXppNEpjNnRiQTViSGZBVXdGWTVacUVvenE1SVdtelRHMmNlRHhKbGFz?=
 =?utf-8?B?dmFpNGw1WVhleFdyL1BRQldTYTY1aWN2SW5MdVV6WC9McnppV3ZKWG1STzZH?=
 =?utf-8?B?TksvYWx2TkRudzV4WitSVFRZRmlGQzhDT085a3hheDRRb1YweUJXMVRFdEdL?=
 =?utf-8?B?Q3hjTHRNdzRVZHpPZENVNFNVRzlWWXBOVDB0VEhrZjJkdlJpRWxoRFZwcS9P?=
 =?utf-8?B?V1o2aEhBVWZRQU5iaFc0cWpJNmlYSkpTckV4MGtWMXUwKzRBdEt2MjF4RWNs?=
 =?utf-8?B?ZEM5bVpoVzN6TXVPcnFhRUNGL2NwLzBvVFloU3B1VXRXNUJMMWgzd0tZbHlL?=
 =?utf-8?B?M0dWdmVGVUlBNDJlRzFGd0Q5aTRUWHU1N09SMG0xSHBCU1BoSHBIS1dPeU00?=
 =?utf-8?B?V29mZUIzU3UwTWYvN2FqYjNIRUJaaDFlUnczNXBZaU9TV01VSUNHclAyK0pE?=
 =?utf-8?B?bDZmWEx5NVdqekovVUUrNkJBVTVES3pIckFMeVhGN1h6RmpuU0V3dVNMWkVV?=
 =?utf-8?B?c25mTk5zRTJKeHFkL21iMU1VN3NSRk4xM3dKMS9ZWHdGeFZFQ1cxVGNiWngx?=
 =?utf-8?B?c2JmMGJqZUhhMGNBcWk1VkZwUkx6Qys1bDgwZHJnRHpwVi9nOEdvUTlsRXIy?=
 =?utf-8?B?VzlvS0JNTTV0ODRYcklTb2Fzdkh4c2pwUENyZExyS2xsclF3L254Q01lbCtj?=
 =?utf-8?B?UmEyUE1BOHo5WEE1bUIybVBJZmpBSStTWGV0U1ArcWwwVnVhS2Y3Q3ZndDJh?=
 =?utf-8?B?NXhrb0svQVkxRndZMFUzeUJ2SWhnb1lmTFRxYkpONGFGMm8rZHNNS29JeUpy?=
 =?utf-8?B?a2Uwb1Q1ellraFFkY1ltNGhnSi8zeUFwWDdMS2FJVlgvbkJwb0F1MFNWWnlC?=
 =?utf-8?B?V1lMeStjSXNYMmVQM1djSXpmOE1IRURFbG9iN1Y3VDRWQUt6V0VGMWVDaHZL?=
 =?utf-8?B?QUJDK2YyVDcwaVphOFRWaG9sZ3RlSGI1UWxvVjdqdWVYRUpYRUdIakdxS1Bx?=
 =?utf-8?B?TTNnWFRybWI2TFlHOVVraWd6Z0tNWG9Kb1lBY3RaZk9iSi81SmlzbEVrbC84?=
 =?utf-8?B?a3JiZTlCTG54Y0tSaDJVaVhEMXVkbk5vMjhzZUxGZ25uU2tRYUdIekM4UEx3?=
 =?utf-8?B?ZjNnbGc0STBqTU5kbjUwV0h0ZkJoMjJZUUV0VTZZWFNBY2NMcmJSMmxrbmNT?=
 =?utf-8?B?T1B0OXBNRGh2QWJEMWhLcDNqQyt5V1ZGVm1Ua2ZCQTluUEVMa0crMFRGbVRt?=
 =?utf-8?B?NW1XUWlhNUxnMytObkxtSG9lelVpekl3dVc3MjNyQUdITlFkWXVSVi9VTHcr?=
 =?utf-8?B?MGZUNEV5bGQ4VWlIMXdLK1VNNXBkMUkvcVRaZzZoT0VnT2U5bEczckVjNHlx?=
 =?utf-8?B?YVNxVWZScXFJUHRjT2lTeldMeXljSnlTR2hIRFlGc1VvK0lGQmNHcjk2QS81?=
 =?utf-8?B?M20weXkrelZrOER4RkhBbHd4MDhBSkc1WGwyaFVkNU5BSXlUZ1UwTXVrUDIz?=
 =?utf-8?B?eWx4WTgxbS8xckVNZ2loQmgrWUNkYmJtclYrNSs3NGZub3pDL05kUVdlWkho?=
 =?utf-8?B?QVpDWDBzTkhOckxBbVJoeEt1Snh6NVlLejdEeStFcEVjQmJkbitya0lFSkJV?=
 =?utf-8?B?NjhnVlBqVjF1c002MnBnOVB2RkQyNWM0bCs1ZnRpanRRbW9qWE1WZ0tiaVdI?=
 =?utf-8?B?YjVXVGQ4dEIwczRGMTJlVXpUcDNJYUYyb2tWN085a2dPK2xWZ05rQzVXL3hU?=
 =?utf-8?B?UjczdFlzRG14N25QS3ZTK0ZEMnVqMWVibXR5bC82NkZ2MUtqeGpxdWM0RWd5?=
 =?utf-8?B?SUxnbEViSEZpMkJpWi9rak1Nb0srZWkrUUpJSkFXcC9FUHR3d1h6cE5oNXBM?=
 =?utf-8?B?ald6RDR1OWlVVXFacHZpWXlHNEVTbXhnWmg1dHNSSW4wNGROSy9XOFI1WTRZ?=
 =?utf-8?B?SU9VK3BwM1QrazBmWkYxZlQzTjg4dDdHZ2F5K2R2Q25SblZ6alVldnQ0ZVgr?=
 =?utf-8?Q?ezrJhNyGK7JQn0vTz+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b670f62c-ad47-44ee-168a-08dec2061772
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 06:54:15.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMeMWIqQRUcS8nuQg8aPTjyoe5Y1ph8coz+09ax3RhMLXgs2be0mIXlgk1WR/tVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

This patch series improves the snvs_pwrkey driver with better code quality
and add report press event.

The main improvements include:
1. Clean up the code by using local device pointers and dev_err_probe() for
better readability and easier debugging.

2. Fix potential event loss during system suspend by reporting key press events
directly in the interrupt handler.

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: imx@lists.linux.dev
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
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

---
Joy Zou (4):
      Input: snvs_pwrkey - make use of dev_err_probe()
      Input: snvs_pwrkey - replace hardcoding -EINVAL with original error code
      Input: snvs_pwrkey - use local device pointer to simple code
      Input: snvs_pwrkey - report press event in interrupt handler

 drivers/input/keyboard/snvs_pwrkey.c | 102 ++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 38 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260326-pwrkey-cleanup-99d3de61ed6d

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>

