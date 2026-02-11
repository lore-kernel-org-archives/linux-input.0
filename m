Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A23542D6;
	Wed, 11 Feb 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846087; cv=fail; b=isPP+KnxGU+gIlPeJ68eIENweQYAlZgzMvue11s6kZueGRcbuZa27qXmacWPvleco2WkN3s5WynFRY71gd+QPkl7I5vH0MK+1X6j3PTV6Bmqi/UG1+/pB3o7751ekvM2ALPalbaR3ZK+fxwStZ9diJem1w1+FVf43ouWJaOGp0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846087; c=relaxed/simple;
	bh=bNjxTkY53ldggHhSj6myFEyxtlzvufhF5ePgyNZUdK0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ULrbOfbocbCyWhGI8pna4cxxSmYihjmhJACOFw2Ase7i5SiO8bR9o8NyJO1VfHuKDZ0P7IiFUFMH+Gfe6tFTsmNuNDudB0LpWPHyRNlYBZyww9P++VNU8oPzB7Vl6HPBOReg2ChWk9JNTgKsRFceT99qEePd1AlpLRNZ9VyPPmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CQMcCMzP; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQMcCMzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jafZTXDvA+U27Ai+E5dZae6xg2vRhi93MJbBQCI1oaTXeqwhZYo+IGNbc7C5v8XREVv80HTyfIGB570syMDotAmwtldXvOGAHBj67rJE+nDZKU0QrSYz+JkMvmYJwq89EHl3aqw1KnYkAwFQ1mcZMXsXaX43hA99BiqILOe0RCTR1kF2PrdnsIrhuBp3jcyWqdUYeVjquJ6Hcp+zHc50fTwdyZ7E6M5Dhz6gOW8sLFsLFK1APLxYCwR6+qRA1rPeM+1aRzIzt7xkUJdnoaS56HnFzCUnuTzQhNnIwPEb0sh1i72Kq5itkqKGOfSboH98cQzQMTYKRorJfIgM5Fd4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z7H2Gj3bTd/M7rVay1pGv+U2V3Kgve0tkTZTG5lGUM=;
 b=ZhEfVETsee7uuH1i+pQMypDCUVBUnsMdJWJxesgWUQueOZJO1urNuutYZlI6cqds5QIT50gOvTUWCVhfBbnn8rnhzhaOdMwKfAmzsgHf8Q04w7uhjfSq1YTUd6ychYy8V+u7FaSmZhIOlAW24ON2aHqLROWccq9etEycGtDUYdAgDcu+cZxO4DcxDDBiWJRxRH+rsAfKTMWF0KeRugrQO9IWI3tnApRtDHx5C1+bG5tnmLfWaM0IoKsXeUWcMgBvJhzZsMhRT2Ovc5c6XcBnCZwxjeN/sx6OJPj4Pxtx2zxKMm2fYmHjRRkSwIz5HjQK+IQcd0Nn+6xjueJwWNLBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z7H2Gj3bTd/M7rVay1pGv+U2V3Kgve0tkTZTG5lGUM=;
 b=CQMcCMzPkL4xCAgJCZ3lyFm2hBYkR+HX1i89SLr4h01z8k5QeDCTUosxqTvKGTt2E2XB0ddcC6yPRWT38E9E9Z4F3cMjpu/eCCg+NUZLgxJFaq+8McuTz8MP6eqQCnRjDTwMPFc62Ql8ub9nANDs68Y/3efRFxPivZQz2VFlJR6MyytEH+mD5KzJEzIQygpaoi486B7nQHmSUXO2qjXY3QwG28MtWYJB5YUOoTw/qX7+5pOKBlaHRwVVl5jj41E3szDl4sZc3G/uQcTJIGEyn6zbVwrT1Qsg38ASzKK1W6gGCPEn05X8qq9oOyxOUv14j8O6owTWJyJ0xXvhaBJIDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:41:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 21:41:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] ARM: dts: imx: clean imx25 tsadc related CHECK_DTBS
 warnings
Date: Wed, 11 Feb 2026 16:41:03 -0500
Message-Id: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/3jGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ND3crE3Jz43LQUXQtDA8PU1DQjc+NkcyWg8oKi1LTMCrBR0bG1tQD
 S6gC9WgAAAA==
X-Change-ID: 20260211-yaml_mfd-8101eef273c7
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770846079; l=925;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bNjxTkY53ldggHhSj6myFEyxtlzvufhF5ePgyNZUdK0=;
 b=hWvE/QdHcDtVszP85XRLg7PsabnSPPJrDBy4rNuMqG/77C+1dmHGIElmhO54bclYpWB+GdLpk
 BEQ79k1V3b0CQvgBHz8ZLIus6gRn84ziYOEyN8T1ybip3bMYmmOnhxZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10717:EE_
X-MS-Office365-Filtering-Correlation-Id: ca78d6ef-143b-46af-180c-08de69b64c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXJ5bnBVUHhYeDlpUFp2WnNuYUdLWHNtVUlmZjNPbGNTZ3RHYlYvdGxsSk1S?=
 =?utf-8?B?NmtEb05YWGg4UGhrbk1qVkZrSVpxWGFjeEQ5dTlrT2VieXBQWnBOdndCdHVB?=
 =?utf-8?B?cUJobVNiM2RkUGp5QUF6NTRMY1lmbW9qUVN5UkRxL0lJNUtuZWp3cVcwYXFo?=
 =?utf-8?B?V0FjSVJneVhQRG10UVdtL0FIZTZBanBiNGJzM0VYb01OYkZzY0ViWDZISHZI?=
 =?utf-8?B?OS9hZjFoa04zTmJjU3JJcmR6WkJabC9jMEt1STNJYmRMbXNIbXFrRnpNeFFy?=
 =?utf-8?B?OTc4RjBkaCt2dGROZUxaVnBzTlh2dkhJWVMrSlhCc3dxRENoaUVkN3ViMlIw?=
 =?utf-8?B?ZytuNVdzVEEzV2kxNldERUdyWmFjcnkwL0NIWm1DRVdmTExhY21UQWpielI1?=
 =?utf-8?B?K0dDanlDbHF0ZWtRZHBydUdPalZmb3AzaVRzN3lYNDBlWTJQS0VUbWRSQUx5?=
 =?utf-8?B?eFdZVWNWTWFYRFpKK01Ca0JtMmdQK3NWVkZqRTJtN2p5a0ZVRk1rTDA0R3Mz?=
 =?utf-8?B?VDQ5T1dhYlpUZ0tkNWs1WDlPYzN4cjBLaWFsWjNUNGhyelpjL3FSMk9KWStV?=
 =?utf-8?B?ZENITWJwdFg4L2liSjVhOTMzMXh4R2dwUHVNZGUwdGVYYTc2YnBoRGg0Qisy?=
 =?utf-8?B?RTgrdnh5LzRaNmc3V0RDZ0tMZ3M0aU8wZUgyWWhrVTlHanhBb3I2QUpBVXFv?=
 =?utf-8?B?ZjRhTDF1THRGaFMwR3MyanFxQ05zNytHa09aSkdjakMwaU5xRDVUVlUrbFl1?=
 =?utf-8?B?ZzJiY25wL3hxWEJrendKanhKL1pXNFNBTXhtUHA3SStuRWpsWE1zQzRUS1U5?=
 =?utf-8?B?b25lTEkxNlA0aEdlZkxMVk10UjFsZ05mSDUxSEMzLzdQeGhKZ2dqMTdqTjNQ?=
 =?utf-8?B?T0g5bVRvY2c5RW1JKzRDWmRmSHBwZkUrMG1uWXExUkRIL25ZaEZtNmlOdHNx?=
 =?utf-8?B?bGxlWEpVdlcwWHQ5dkhHNlgwRFRoTkI3blI1UXEvWk9VZmEyWmlzYzdLWnd2?=
 =?utf-8?B?bUhLRFRLaHppMTNvL2VFcEhOYjZ0QTIvdWtOdlozaU5ueTB0OGY1NVBDUEJi?=
 =?utf-8?B?NTlMbk9WdVBDM2l6WWZieTNPWGxsL1dZUkZHME4wOTJkMnJjcXUveXRBaUFw?=
 =?utf-8?B?ZmYzOWFtTlBTSTRidGo3blRsbVRuL0NQdHJGQXNzYWwrS09VMU9rWFhabVJD?=
 =?utf-8?B?WFhFVzcxNHpHOWY2dFJlekxnamdGdnpRUjJwV1YvQ0VHT1c4WFY2T2hBS0Rn?=
 =?utf-8?B?alp6YUxQZWZrWXlWN0N6azdmNG44cjMwTHVCZUlTZmdzUHErck5RNU5WQmJ4?=
 =?utf-8?B?TXFEWUNOdEtjOGJ5MHFkY2hzbnpkTW5KQ0MvRE1IVlhqOXJBY1AwN0RMMUlv?=
 =?utf-8?B?M2hHRzlTU1Q5WVprZXp1OHltb2FCTXVXY2tVcCtxb2x4ZWxwRmlzZHl1dk1I?=
 =?utf-8?B?eWZlWlZwTVZLV29UUkh6SEc5S3hWQWtyVmxRUFg1UzB2Ti81UUlyQ3ZqSFBr?=
 =?utf-8?B?ekpDZkRIaEpFWjhHY2FvOEdjcTBlNE90VFZtQTBSRDNZZVJwZFA3QXNYa3hK?=
 =?utf-8?B?Q2dhamxhSnNEQXlZYnVnZE45NEt2NzVXZmlXb2krVXdGOWh2Y0NzY2t5blN5?=
 =?utf-8?B?TWx5VEEwdUtmbG9jUjNkQWR3Zld3UVZUeFNQcGdneWNHb0FkaDJJZXBTeEtk?=
 =?utf-8?B?Q0lKSEFqTWtOUjA0UldhVXkwbDRlV1BRR1lqajlyNWJZTHRYSXdpdUQvREJQ?=
 =?utf-8?B?YlJ2dUtVQXFOKzhBMTdiQWZvTkZ2SnJqVExLVStvUVAwUG9nWTVpNFdmVHhu?=
 =?utf-8?B?SzhxQUVuZm1DU3VsYXZ1U2lldFFuYWFtWEd3eTIxbGNYY2RuYnVQa2pJY21C?=
 =?utf-8?B?V0FRazk4TmdwVTZMK2ZZMFpNRHVsUG1VRjFLbDdESmRSVkFqTXlyUGY0SlhE?=
 =?utf-8?B?Q1h2MVc4eWdqaUhoVXhnbW4xSDcrSDU0bmxmNEdGcnN3eWN5cHpOVTBtRlp2?=
 =?utf-8?B?cFAyWC9aUmJ3ZDhFbmQ4em9wa044S1hMWnBYdUJ3ZEF5dG1zU2RYeitIbThJ?=
 =?utf-8?B?OWtkZWpLRERxSXZCVldmOGlUOWRseEs3YmRVd2lMb0hNZXVmRHdla3pvZlhk?=
 =?utf-8?B?TXU5OFAzUm9tV0NDV2M3VFBsOU5SOGdiNGJoSm8za3VMWk5Ta2ZIMFZEcHhD?=
 =?utf-8?Q?TAseGO2lWesbznzPRJIUWIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNMMnExVThYZFlhZDBEUEJOOEcwbnd6R3F6UmdFNTRpT3FoSmxwWC8wSmx2?=
 =?utf-8?B?b2lNVGRsVi8vbG9DSXFJQnJkdFBtckxrRHBWZzVxTW5VM1lPU2J1YjR5cFFV?=
 =?utf-8?B?VDl4bXJqTlp3V1FIU3F4Q0pJNWRNQ3hDOWNMWE82ZHNKWWxnOFZKc2EvOHZK?=
 =?utf-8?B?aS9WSTVqUndBcVg4N1hSMytoeWlGSWREdHBXOHIvbWRPRHA5eTFXZGZKalFo?=
 =?utf-8?B?aHNlVytNbGtySW9TMndtNDBpYWVoWnNZdFlWTmdSTHhoNnp0ajdadFJvZjFS?=
 =?utf-8?B?VTQxVllWVVFoMlJMY29UeWdaRGlQdGNsVXMyRUcvYXpaaHhnc1kxTlhtRmFh?=
 =?utf-8?B?SS9uUjl2aXdiblhDbWZxbFl5SjNqYmlDZzk3bzlaSStESlVhVGg2L1hQMGw4?=
 =?utf-8?B?MDh5ZjFKblBEQVg0MXNYMDQ5cmJJSHVoOU9FbG53cFF0Z2pTdURYaWZONHlj?=
 =?utf-8?B?blFwUFRMUkxscUZPd1U3TWQyKzNJTGZ0S3hBc2J4Z1hVTXVPYmNMT0FsTE9S?=
 =?utf-8?B?UzBTWCs0QkJHT0ljSmorYVpEUFNnVjVoQnhCUUJtWVV2NTZTUmF6NmU2U1Vi?=
 =?utf-8?B?NkkycENCVlB0ZGZuZEZPejg0QzVDa3BGanRIcEt3VlN2R0MvL3V6REFJMTE1?=
 =?utf-8?B?UjVYQVNEdGRwekVwUEQ0MThON0w1NG9lMjVnUS9HQ2VqNkRFYlc1SlBNYlBY?=
 =?utf-8?B?Z2cxWnkwTFpRc0V1YlNQZFdGc0Q3d1FGMGNkM1R2STNWaG0xQ1dTU2wyTFly?=
 =?utf-8?B?QnJoZUpXU2RQdmRaN25sdHVsVjFwdHZ2ZVMvaUlZdVZGUVJWREdmcURxYld4?=
 =?utf-8?B?K2wrMjZ2Tk5yU1FoRVFRZGJoRDlwWEs3SFRmNk9BaDVPVS8vTC9NT2xyYlV1?=
 =?utf-8?B?OXc5VUJCZE5JclUrczFzcVhISEdZV3BCdDRNNzlDL29POXVIN05vUGQ5YWdU?=
 =?utf-8?B?aDVvdlBOcjhNK1pvZTJ6V0RQQ2Jxa3BMTjBsZW5mcWJ1bjNWL2hTRW5pYm1q?=
 =?utf-8?B?MFgwTkdXRWZmcWNQT2lvQk5vc2crbGZPU2toaGZRZ3hiNDJTa25PejhkRSt6?=
 =?utf-8?B?SkVEa2ZmcUY0S253ZXcxbS9CdmE4aFdGRFpUaklBZExZZ25QSjliaTl1eXdH?=
 =?utf-8?B?VnlVOGZLY3lsL3VpQVA4Nkdac0xsTGVmUnR5d08rbXIrOVRxWEE4KzlHNnVS?=
 =?utf-8?B?QzFoUkV6a2ZGVU1wTkJGWEtYSEgxeEJ4MEszRmR3QVJ4Qkt2WHhPQ1hXcGJM?=
 =?utf-8?B?cXpCRXF0NWd5QjBOK0tDK0M5UDhjZGphMzNqOS9XTlN4QUo4cjRSZitmc2dG?=
 =?utf-8?B?cVM1OVU4SytPS1ZqVlpnSElsVFNvTS9nc0E5Wko4Nm8vZkc4WVFqRTI4YnlQ?=
 =?utf-8?B?TWRCYVhUb3V4KzJ1SnpoZEx2STlud1BITFd1MVcxbWhQc01kRmVqK3BuWm1u?=
 =?utf-8?B?andNck51MlZwN3NSblZrM3BuREpjU1duM2E4b3huaXpGTmRQZFNyVDlSZ3Zw?=
 =?utf-8?B?U2ZuWEZ0SW9zenFCZ0l3WWNSWnpFYWtvOGJRcnJFWnhXZzRLQTJPWUpWTUJ4?=
 =?utf-8?B?c1hvdExNU0x0NVNIbDREbGdlYzJBN3lVTWxLb0Q5alJSM3VSaElnV3BOaVQr?=
 =?utf-8?B?SEVvNFhlbm82VWtmZmJtMGlENndTTkQzNkJqd1doOHdKcDhvcGV5UVZwUmY3?=
 =?utf-8?B?NjZ3NUxLQ2FoU0pneFBhbE5HdFpXZDdhck4wVTl3NmZqejczMzJqeGFDNWVZ?=
 =?utf-8?B?U2QxREpUUk1mTk9aeWcrZ1BPbU13SDQ3STF3VUV2WDFMcjdWZDVONzZQR3Rj?=
 =?utf-8?B?TWRHNC9Ra1RVMmFpZ3o5VjZ4MWFGK0Zwdnc2WHlSdE0vM2cxRkx6TDhyY1R5?=
 =?utf-8?B?dzV5Qkg2Zm9iYVlZSFJXVkh1dmtpK1ltS2FSWVY4Q0x2cTZKTzVnSll2R1RX?=
 =?utf-8?B?TEwxYmJVS3JaRlFqeUR1TityaHB1YmlLd2xCNEZTMktWdEdMRTdDazh5cEVE?=
 =?utf-8?B?KzAycHJXYzJibDlBZzJ4S1kvUTVSVGRYZXltZzUrdlMxWm9iYzRCeGxkWXcy?=
 =?utf-8?B?UmNaeVVIRVZDbUJLSWo1R1BXYkNSN2c3ckc3dVdadHBGODZYdlZJQmozUkdS?=
 =?utf-8?B?VWRLWUQvaDl1aHU2UTVNNTRDb0VnYnBlQS9wUXU3RTFJMXRlK3c0UklyS2hY?=
 =?utf-8?B?R09QR0RjaXIyM21PS0JTR0k0ZVRTZENOZStDSGhwUVhTUXRMWmxzZG4wdXls?=
 =?utf-8?B?VmQvVmVFSVNuMXR2UWxIbFFKMkhIMEZSc0o2cU02R1ZqenVBaXVWZ1NzSVdj?=
 =?utf-8?B?alFSdjhlZkxLZzNZQ3R0YkhkSTQzcjBRczRWVDFxUGNJdUw4SXFVZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca78d6ef-143b-46af-180c-08de69b64c8e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:41:22.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol7dybW2iC9SN7xP5vG8h8eyXQZCMkqH078Lah6AGGSiV0CffsGq3J9tMRdmr/CXRK63HFFF/u8uJlFBg3z6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

Clean imx25 tsadc related warnings.
- convert txt to yaml.
- rename nodename to touchscreen.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      dt-bindings: input: touchscreen: convert fsl-mx25-tcq.txt to yaml
      dt-bindings: mfd: convert fsl-imx25-tsadc.txt to yaml format
      ARM: dts: imx25: rename node name tcq to touchscreen

 .../bindings/input/touchscreen/fsl,imx25-tcq.yaml  | 69 +++++++++++++++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 34 --------
 .../devicetree/bindings/mfd/fsl,imx25-tsadc.yaml   | 97 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 47 -----------
 arch/arm/boot/dts/nxp/imx/imx25.dtsi               |  2 +-
 5 files changed, 167 insertions(+), 82 deletions(-)
---
base-commit: 80a957b5f15ec855849f15cd1cbe1a655c09701f
change-id: 20260211-yaml_mfd-8101eef273c7

Best regards,
--
Frank Li <Frank.Li@nxp.com>

