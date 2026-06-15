Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0E248F72;
	Mon, 15 Jun 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509779; cv=fail; b=gEoaBx5NmQMBBbiLuKiyslacLZEMSe0+iTQFUoGFkSzFmD2yt9AvVbaZuKogn8wMclS+AIo1YUBvemPdDrZ4yc0/iyZYvSr0j62NtcPKAR1MNA4MPA6Ek/28+lVbyQaxueetimXsyOvaJqji7RFCRgR+0ITBIHFag2wibjCB1Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509779; c=relaxed/simple;
	bh=nk/2n/89whB31K8DT31JqjGqkwNi05fHP61Ds/LHLjo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KKNjK3TXJytWTFPYl/tcYeL35QIpaSMNwoq2c042dVG2BK4PW2XR4OWbFpBHIw91slDs5o2kI0uiOkW5+4BTsSA7lv3J3a9TBBUNv+TnVB9Zc3MYWH5h0E6UfNx7qCleRasuF8KU+ehmWY+YLdu2A7tSevKR2om7+4mqJu5eKrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q/09ZpLO; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q/09ZpLO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOIb7TNUn/kGDIzvUQdKka8CzSqE3TxGeXN7ISm6SB1hSXCrCn4oVjohVpCwCRdbstZD5kL8iYTMXq5xaUnM+/e2JDy+6i2pcqBArOeiuheI4vhQUCl7j3R4ThJI9WGqWhJuw3wGLc3toui2I5MMXirTQBUMLM7BfWP/oCZkXV/Bogt+IyOBHICOHlFgjHQTuThS+Gw5Z234P+2hGiW8i6lQI97CxOh7JnE2kFbcMQT7FSrLqONr2r7CfQubMIgyam/F+WVhWFwcyqtgsvNCtJkm8yf460b36+hs/IMC+HFSFCOu6jYF40/+YuEENNHOJoMX7soHqNyGV6HI5J3cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L3i48nCMSTQeEdoUmXiM600U+gXYsQCOSPioQlH2Qc=;
 b=hRzGIbpZhNE51oiYLZUhGrDlPk3NtIDxWf3O6COzJV9ySUfL0VUmAuJga0BITxRiMhP4J+95Fy61VWqjlrRhvBGwYNxo6paiqzOe2WkyaLj4Oun3tYwwf7HTHapeO8r3ZOQRh8rNQJgJoxDeLeLXM6fCPT6hmSmkJQix2J5YX6ivIYz3tD2J+TGZqX0QejtUmpM750lARiFUezr+DRlYWIHnXM82TLY5WpcUm2yVBzRMi2p9HRwumE7MTDGd7mKpdvv3eVHSda1Sw8XxPPyJkrc1DOoMjgH+n9jFNZeXRH/iDEBTuWUC5Z0hiFWHnuCTs5XFvbDSl0ZVSuz1MnONJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L3i48nCMSTQeEdoUmXiM600U+gXYsQCOSPioQlH2Qc=;
 b=q/09ZpLOen0yFuhAKzZ/fEkaPQeuzl5GruoiAwWVJUcezmj8t2c1FVONsOEmKfExO7F4uU+7hPrrT+A3l8G4CI2pnF2afSOd1sXg/n3VjIuBBAxgoKL1NocH7pOnFBLptjIQ83C3tbvbtKt/ojDQSQ/0lFaM5AVa3Aypwo5O+OTyx7+HmMzvC5I6QX90hOwm3Iowp/jgaSPU/IAlHbtggRpFwwySNDKKRcKs+PAHhu98/e3hbDMvL5Jamo52EBEXaYu89/OfrezgBe7a8K5rRlIxjSCL610WqIiZXfqA3N40XR0v29GrFneR6eZmk5DOPCbSSCcnb2uAv4N36uRjow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by BESPR04MB12586.eurprd04.prod.outlook.com (2603:10a6:b10:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:49:35 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:49:35 +0000
From: joy.zou@oss.nxp.com
Subject: [PATCH v3 0/4] snvs_pwrkey - code improvements and add report
 event
Date: Mon, 15 Jun 2026 15:52:13 +0800
Message-Id: <20260615-b4-pwrkey-v3-0-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2vL2oC/22NQQ6CMBAAv0L2bEltsbGe+IfhQMsq1UibLiKE9
 O8WvHqcZDKzAmF0SHApVog4OXJ+yCAPBdi+He7IXJcZBBeKq+OJmYqFT3ziwlrFjeCVtJ3QkP0
 Q8ebmvXVtfkxv80A7boHN6B2NPi77bJKb9687ScZZi2ctTadQSF17onKYQ2n9C5qU0hdGqG/Ft
 gAAAA==
X-Change-ID: 20260615-b4-pwrkey-a60b2043cd29
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Bough Chen <haibo.chen@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Cc: Joy Zou <joy.zou@oss.nxp.com>, imx@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|BESPR04MB12586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b76e079-c726-4176-132e-08decab2a4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	d6tXMuz/FWXSs03vXmH90PgAyg+iPAmRSGok66+zFbuO75qMrFy+yRdNQl044Kzi+xh72WN241XX1TyhcJer+tpX3CEfMMRHVpHnDEzsZQKU2gFNGy9uYZKwX7POiMor6l34XgsDzgKuHAhNXIln6wFhEzPVBOvHYGJPSTYqoOK7YXMLw3g+hk0LVFGrMlETRIWvTgnkHDDqfq7akbIyuGJBZ20eblZfnxmfOK6T4CIeERn/ZdxqSCRinYjyz96Pni2t9VifqzoleoCg6Pcf/eCQLstcMJ0xASFYWCJ//45jg7x5DA/s5+PpO6fQcZcGUFZ9j8iYsZjIDz5xdhMGaOWyD0xiS6wbI0zTwEzB9kq0nSMoSS6mgiNfaZJ/ykPpfSTljKirCXqjwk6DcRmjwjrrFnPdBsbEUDC2T1whd3seLOxZmODPQCsHxta2Q7+Ucbe0CZJNcRTpGdDwaOYTAwoiYF5nrFZ85hUGMXCx22ljN93Jdscu80RGFnHYY7I8ktUFHmjeps9L49OX2MlRdh+t04hGnxExVhuqTVl/qDbcZtp2wHN90JRppYfBireqHU6+8ZmZmG/boFWHQ2m02XOwOSgv0rABvr5WlEhY/tMCRa6n7TYnKdj0IDWI3tuzZkvQq+bSj/XXpIqxh1ygjWcqAapsZaDKtfLFi5QzLHCOaDZYrF8ceBKtoOHej092
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1HQTVPU2xOa2E5ZUVpU2g5QVJLcXpDSW5CS25KSzdFQTJCUTl4MkZXQVRT?=
 =?utf-8?B?MXRpaUhtVHIxSncySWZOL2xZUFg0b3g2MDBLem1Yc2JuaDdzcUFSTm52bUh6?=
 =?utf-8?B?MnBRRUFBZDBKZmR6MHJudXBBNm1nc1hqYUwzTTE0V21aUFZxenZmZGlNZHVU?=
 =?utf-8?B?VDVuWEFNc0dFMWpxQTZhUGZFY1VyYkxNenBWc3MzSXkyOWFhOXBsTnIzQkxS?=
 =?utf-8?B?RDM5SWpINkdyK1Z1SVIyVG1XdUVPNHZsM3lNQUZJNTczNXFSS0NMWEVoaUp2?=
 =?utf-8?B?U0ExWEVZYk5mUW1odmo3NHpXaDVIT2dpUHk5a3RuN1QzRTRCTWIwekY3Unl2?=
 =?utf-8?B?c3BhNFUyYWlJNE9JNWx5azJrVVl0cVp5ODFsbG52bDVoNzMxdkFIRWt2V3dl?=
 =?utf-8?B?ZWVYaEdvQ1hZaXBSOG1QMGJKdXdSWHFVR0xvcmtjSjVlYUNnNTB6eVhHdzBs?=
 =?utf-8?B?cXN5ZDZRaXVXYm5SUlg5VjJuUVBmWGx2TXdoTFJlUm13bUg4VmsvSldqOTdM?=
 =?utf-8?B?UUxpNkI3N0Q1UnluYTVtTzJuRmhDeHNjd05tQ2YwR0laYkhxbzlMNFhnRjhN?=
 =?utf-8?B?Zkt3MWlhQVV1dzBzaFhrMXp1NFZDczhJOThCRHVhTm90dGhDUnhRR241aTdk?=
 =?utf-8?B?WVpYQlJ3NGx1V2tobGd0dGZ6cnVlMUVKVkJtSlJFditnc0dCZUJjV2hhRGRG?=
 =?utf-8?B?c1FHdURXN2p2c3ViRlBuakRwSlRZM0Y1SnZUenpZNTY2RWdYbU4yWUJOZnVl?=
 =?utf-8?B?Q2x0QnRJWU0wbThhOUZsV3JGOXBBbHpkUVRhbGg2UFV2VE1qK2NMYnp3YUVp?=
 =?utf-8?B?SHBKaS9HNVp6NUZUQmVVVTd6MzIraDlhOXRwb2M1azMvaFB1U3laSjYreEFj?=
 =?utf-8?B?c3JuT0JzRlhPUXB6emdYWExtN1NaVmpITFF6eS9Ba1F4R1FkODA2QXFjejIr?=
 =?utf-8?B?RWF1L0dxNUVmTHBmQ1p6K043S2MrL2NhVHZRTTEwVzlPMkVOTlYwRzY0b0ti?=
 =?utf-8?B?OURNKzdnbjRwbTFVeTVwazRnL2srMDRCUENrSXN4ME52WUpuZXg1eVJMcHE5?=
 =?utf-8?B?NUtEczFWbmFJczR1OU9ZWHA4bjVnbDdZRTd0WEt4SGhBSU5Pc21Femgrc29L?=
 =?utf-8?B?NjliaEMwaDFyZFNGbVVpMFI5WERJZmxXWkNlOGlnRDFWQ0NBNzNhNTUrc3ky?=
 =?utf-8?B?TFg3ZmF2MDVya2ZMelpZbzdJZUlaWnh1dm93KzB2ZUF6NzNlMWZvdEJkd0RC?=
 =?utf-8?B?MytSc0VCYzhaeU1iS1VGU0ZUWXM1cGZIZFZNVjJ5UTF5WFUvQnZSZ0FuMDZi?=
 =?utf-8?B?KzRrc2hOUUhqOTVCMzN5bkhhM1diamtlU2JnUys3VUo0K3ZDWWZXcytjRnkr?=
 =?utf-8?B?aWNpK0p5QXJYZ2dscVRWa0k3U1FMSXZzUW9nekZzKzY2UldVaW1jNnpydmpI?=
 =?utf-8?B?MU9MbTBlaFpmSHBzUUNSZEpjRFRIN0ZmSEdyL2Q5TkVMKy9jSHljcDJUdlhQ?=
 =?utf-8?B?dDljM0NveDJZbFNrMmxWdGphWU5Ec0xteFZhWVlwaXNDRnhpNlRrUG0rbWkx?=
 =?utf-8?B?UFFPK2ROcklhUlJXa21zektCM3I1SENOdmFuN2pTRmJtbTRMbGhmVkhSMmRM?=
 =?utf-8?B?WGI4b24yVlFuNm54YlJCT1B1UW1RUUdqQUZTZUpCMGFMT0drem1rNEpZTnJs?=
 =?utf-8?B?YmJ0ZXZTZmZrV3JUWUV2UzlpV2VsT084cURGd2hmVWhlNnpBMklWUk9xSm05?=
 =?utf-8?B?V1NJZ3llSlp3SUgvUFVneWVqYm03MWc3b01ucFRLUE1GUVBITnJQaWFJdXI0?=
 =?utf-8?B?RUhxZU1DWGFqVVZ3QkdyWkJkSmdTcmVRYmNaRjdZeUdkaFQrNG4vakd2a0dL?=
 =?utf-8?B?ajBzN1JaR3J1OVQ5U0Z2eHlCUFQrR1hyVFhXQ3ZiZkswUE9Dbmh1dzl3dEky?=
 =?utf-8?B?Y1lSZ1FDSEJaQ0hDYmxXN1FhV2QxUHZsaXZ2Qmxnak9vSmR0Y2FDd2lZSnh5?=
 =?utf-8?B?aXJJblkvUmdHY0NJaDRvS1dxcmVCQlcyWXJEeGlVREJscVhreVpFWUdmdFFv?=
 =?utf-8?B?clpTVkdNMjZOdlo1Wk9IV0Mxcy9tOFFNNkQrUU5Felp6MlBISHZlR2V2Rzgv?=
 =?utf-8?B?ZkZpU2tnM3NoOWdqYnhrd3N5YitKakFQYkxXQ0wwTTZ1MG83RmhOU0ljK1lK?=
 =?utf-8?B?cDNmbHJ3U3ZpVmRjcFRJUjRveTFyOU1TWDJkc0plcGJxeWdwRld1ZU44Q1E5?=
 =?utf-8?B?OGp0dG9MaWxUQU1VbUhZOFdpUVZlcXJycWptQ1JPcnFOY3ptMkkyM2VUWWhX?=
 =?utf-8?B?S3NaMlpkdjAwQUFmTzRKR1RpTkwxMlozTTQwZG54TDFsbEk5cHd2YzJ0VUc2?=
 =?utf-8?Q?lp3kYhpJaIAWLJ/Yi7353voKllL5WkGGywWIM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b76e079-c726-4176-132e-08decab2a4df
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:49:35.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbgrVQdNtppmNqkhNL20mQlHN4V36ENVG1WiHyyLCGyBQQiF+GI6UCoIqT+A/hJTKV3ji2oo87rWm5bpHEiX+GFQE6fu3SNF+af+HM0I8V6uIZaRL3b7G4Qqf7gcUX14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12586

This patch series improves the snvs_pwrkey driver with better code quality
and add report press event.

The main improvements include:
1. Clean up the code by using local device pointers and dev_err_probe() for
better readability and easier debugging.

2. Fix potential event loss during system suspend by reporting key press events
directly in the interrupt handler.

Signed-off-by: Joy Zou <joy.zou@oss.nxp.com>
---
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
      Input: snvs_pwrkey - replace hardcoding -EINVAL with original error code
      Input: snvs_pwrkey - use local device pointer to simple code
      Input: snvs_pwrkey - report press event in interrupt handler

 drivers/input/keyboard/snvs_pwrkey.c | 127 ++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 41 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260615-b4-pwrkey-a60b2043cd29

Best regards,
--  
Joy Zou <joy.zou@oss.nxp.com>

