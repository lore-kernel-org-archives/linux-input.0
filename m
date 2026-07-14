Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3626AF4;
	Tue, 14 Jul 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044039; cv=fail; b=Ciel0IIsECOzb0zk5hSam4gRrowLIM0QUxoi1GILfJ3p8lw+eXM1BY6G+AURIOa+SINkKSM3WX7Gzun/Wi0ez2QViIGNijUIg0Bh0cSK+bbvg2P1jHab4SfPIPH1Kawa3j41wWUl3/Ypl9CXTIJC319xH3LirQgJpeWcJQ0IB6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044039; c=relaxed/simple;
	bh=2jqmYSc5CXllpn13w0cVmcMTf2wzTl2kIFasX3bBqFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jibGligxpfehONiE1mV7LcsTxCXTdePauVSEDXejUTtP3npFgDPIm0r45aoUCYEDsirMXGLamb8iu8+Gq2xVfREfZsq6JI0yMnok23jJhCAj5s7T2WFKZuc7t/dEb0IQEiAhGP7BHp1y8kdzviLOBEdryHrt0EKB6Ly8H6nZk4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MyyXMd5f; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MyyXMd5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlSc1JUMXvYX2T2aDD1g64TRdJTqCekVQaebWKlebcZ7CkrjUXEn/Af2yHizc4TfNazIrLOPT2+qu+IVib01HgN0CNPxTeG1xP1cqGMRMDoiH9hHoJ7e6Ve0pXI5hkR0LYXSPtyB+2rm4YHvmjFKyZElV6E3LwvQiT5R/7uG4+A55pwe/BYKzfrMIRlTah7rYLr9UNNv8hg6b+jr97Zdt7cthj1l3aveEwvAJDjbEvNMUi2jtkMpJUFaI67Skkej5ZpMr2X6RAC5ktBUcPfAUYpIuEqmMLppUnqNcof24ahkvmCOL6+FIC2qMwlACb6bthizPzv02TI+yPYIur2SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOXwnV73GcfyNmNpITUfjDdj5FIPSkGlKyzmvDJmRZM=;
 b=Ms7Dr22bWsnzkBMf4KyE9AuN2p1kYiygsQkh0A/loOfQl/I10jLaqSJGTGEM5JO/KzFRGWNWcM5wDd9bc64ATzyj4b9V20Q4CBXE5zXDAiQL9yIUbFf2/G0uuPF6vNyCmf/u4rFh9Pz25b3V4CKced73zZ9GLd+VZSf0GKHRDM2WIoi/2ksTxEtFFewhb6722XLEwIM1R/vaYIi1Xv7zsPONuVELU/6iLUmqHWQ9M15S8K1S6cZHPb7RkB4ra1v/JuGbIbFO+OPI2q/3ybvrfDvunIuiGe4MqFdkyDU6yrwCHx5KiY2aIMUOQ+tkp5tP/W/tKXBHQXwod7Q0FDcQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOXwnV73GcfyNmNpITUfjDdj5FIPSkGlKyzmvDJmRZM=;
 b=MyyXMd5fvPHQEbPZRCwkefE+1xfxsEnUqGWVqKjQPOh/oRb0Cznj9fYDg38qzYxLdKMiMFQh/VIaVkMoe0u/D+Ui5iCJV5B2a2FIwUsqvi/snTeNuaYNevePoVCQ+MmZUFnUBnDsycD9acVoOIpq+OZbJQtz5VUoTsNBXgSLB9A3VyQfxF9A+ZF0Z0Fewzzdp2oNO/FesATJYWqB4+6wfeWM8Z17QWsIRQ/O1+eyaemCABdHoUjsPNxYWNsQYuIlXuKOP5tc0JOwcC1P5An85GRWxOi4Dti4PL7KOV0G1NCJ/74eUJZg6ZJH46Q4HqQ/uqaBsKTOuBmXXvpDRVZmyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11548.eurprd04.prod.outlook.com (2603:10a6:800:2fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 15:47:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 15:47:13 +0000
From: Frank.Li@oss.nxp.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] input: fsl,scu-key: Add compatible string fsl,imx8qm-sc-key
Date: Tue, 14 Jul 2026 11:47:06 -0400
Message-ID: <178404388197.1628554.1376903172807695440.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028-b4_qm_scu_key-v1-0-9732e92a5e83@nxp.com>
References: <20251028-b4_qm_scu_key-v1-0-9732e92a5e83@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11548:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e57efd-f96a-4b8b-a928-08dee1bf2c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	FLzrOIg58YDfS9dJhOlCztfKSf0juwRZwVuFV0YjCgzUXDSRW7y0WqU2UZfl+vlRJdM2D5wayF56ptektFoQHFiqA0pxIQXzLhgvzGe+j2k33NywJG5+DSw7tOG+KXYhGh98UIVYzYLuLaQ/ON7LTGJ3dFne9Ro1egEUI7x2x827kPhfK5O5fFDJpV/xL7Dban0/9nc8pjWltlYeyVAlvZaR692zbyZsSIS5rOh7n+aHCLNrHKahiMgN9koLSbnUr7LLqFZD3AussQpsUPw8gIp9OGo9a53D/5Na+YTfSOeRovQXvfhblhdhtxY/2zLRm7VGujB+3ev57EP++U//z8/M4iGK/IJKXuo2DCTwbS+8jAT59Ej81e8nWLpknWodBaJnxZ8zo0+lEYueVJZ2EHXI74htcspBNqtFv5/0MtVb/GLm3uyMSZMsoadtAMNqx+p7IfBJIi/iQ1DmVNRcEjpOVZehqpNUbuK1n5s6n+27fYIiPa0P6cCiwUb2ZtrSRovjtQahfI6vMPYIKwx6ytvs8TMz1HKjcvQP9+px5UhzkzL50l3L7j3/HdDH2nUgUphbTkdPKk60X8qh8mmpZw7w3VRs1sacK7uJRn0/cTzWxMvjjM9mb3SkR+NcKShsgi4xwqmPFI/WFmInS6Zkb6QCCMV1+2jzclohKglGj1demysU+YmOfg7sso6bN2NSuH/9L1tOrEVT81aII8Fhrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdBelUwQW01V2NkUEJCakxqS2UyT1B5ODJka0dZRVlibi80Z1RQaW5HeTNp?=
 =?utf-8?B?TzZESnc5RHA1WUN6WHhTVGZtM0xucUo2SUxKVWdpdTlFWE1qV25NbzNnNTg1?=
 =?utf-8?B?Mk1qbUszYld5b0V4bDFRZG1oSmdjeEllRzZrVklRcjh3RUZhUjJPckZLNGt2?=
 =?utf-8?B?RlNWaGpYaWdQQmgwNzVaS2lQL0pvZVZjby9KNy80eExHUEdqb2F2YXhjUkxy?=
 =?utf-8?B?M3NuMURwcE1hcmlNaysvMmxIUklpSSs0OEFLbm5oUGZVbHRidEtvbUFvSTB3?=
 =?utf-8?B?cHFqdWJidk9IUkdEYnByUjFSOHI1djNqeFJDTmR1aDZtL2JSelBsKzVpTW1l?=
 =?utf-8?B?d1ZKSWRQR3p2SE9yZ3Z4YXNKQ3p3UE11Qk15VnhQOW54UDkwVThSc3lkOEN3?=
 =?utf-8?B?MmdwZzJQbkFWQ0NvQXdNeVFNNXphNi9yc3RLSmd1U0ZiWXZhaGNYaUZmWW1m?=
 =?utf-8?B?WkZ1dkVyR1p2bEI3RURNTmxhKzZ1MG85RU9Wem9XS3k3MzdUY0Z4TDBESUhT?=
 =?utf-8?B?SENhTlZRL2FTdXh6c2txSWZWNTk2QVk4UWQzRFczQmNmRnZQVjNVeG50elZN?=
 =?utf-8?B?NWpUT0ZoVkdvaVc3b2owVHhIaml4VlpuNVh5R3BqUjNKK2J6WDdPaVd3a2V0?=
 =?utf-8?B?dHdldndWVmxkcHVPQlNjOVRSLzllUExPeUhXMHU1UUJaOWFxMGtidGpSTnZm?=
 =?utf-8?B?cjVGZXNYVWpyeTc4REpoTy9PUTI5aVJjZEFJbVBtVlV3c0NJYSsvdWE0bTJD?=
 =?utf-8?B?SGF2OVJlZjg2WlExZzNWV212NWJQQXFwdjhTR0l1NUN6aUJlV0Y2VHRncVpu?=
 =?utf-8?B?UzB5dUdpVzJKUzlXQkJ4eFBxYVdSNWdiTXpRUWppSVVlcTZ0K1FkQVprYTV0?=
 =?utf-8?B?NC9oS21vMklUckk5YmJQS0hDREc5Z0VZRjhmSmFXUFV5bFVINXNTNFVvVU1n?=
 =?utf-8?B?WVJYK2tib1RGTmN4TXYvK3JBckwySVh5cUFXSkdkeGVPLysvMXYxY01ncFJO?=
 =?utf-8?B?VERnRzcxOW0vNkRuNGQ0a0RmTjIzZm8zZjB5bXd4VXJ5eGQwTnhqSG4yMW02?=
 =?utf-8?B?U25yVFJ6ZVA1YUQ3bU8xc1RkL3NzVU9yVE1UekhIa1FodXl1eGNjY2Zac1hJ?=
 =?utf-8?B?UzFkd0RHRDErN1d3b1NxMVphRXorK01obUNRb2ZMU0IvdGg1aTlOeXpCNXE5?=
 =?utf-8?B?a05oVjNHZEZLZmtXVk1Kb21IMFFXK1NCaUMzRnFOSU5jVkp2ZElhZVROdzNI?=
 =?utf-8?B?RGQvRzBVUGpmQWsvNXA2MVJrclFtdmY4UGZXK0owbG5JMHI0U0xuM21YZk92?=
 =?utf-8?B?MmkrT1NObVA2SlFCMkNBck1lQ0s0dlpDV2tIcnNnN0RmNXl1d08vbG9BN1U4?=
 =?utf-8?B?QnJKQjNEQzV1MkwxSDM2RUtrZ3VnM08yNVRmd1c0UHJ6WnNhcmlMaTdRSFBR?=
 =?utf-8?B?QXZNMW02Y3VaTEhGNFNKcHBYYnoweHRPQWlwSWZmbTdWR3RYUVN4U2EyNHlj?=
 =?utf-8?B?UmdNb3c4blR5d0pKeUpKcXJaVkZ3V0xZZWFlSW0wdXFJNmxxVTZkWmZ1TWpr?=
 =?utf-8?B?OUdTZUlyZWYzK1gvY21oZGhDNCtMNktCaHZQNEhxZi9vN2dOS2ZkZFFjb2Fn?=
 =?utf-8?B?Z1hSS1Y0aXAxM01kNHdRZkM5K2FBWUYxWkp1cGQ3MzJqLzNtYnV4MGJEdldl?=
 =?utf-8?B?ODExd212Z3ZFdDVzREx5S0lpMDdFVXhncElGK2lldWM1L1pxTFhLVEJJZE9J?=
 =?utf-8?B?ZnJueHgvU3ZFSVQ3VkhiZFppK3hBSXFJay9nZUpDSnRXV2hkMHQzcVo1RUFQ?=
 =?utf-8?B?aFo2ZTM1ek9NMHFRdzJYTTY0RUxQUTJ1dE5USjl1VE1rMkdISlR3SlllWlVi?=
 =?utf-8?B?bFZFNjJvdGZjV0o2eW0rSHhGSWs3R0w1ZkNpSEZVbGtYYnlualg4VktWM2hr?=
 =?utf-8?B?STUxclMvaG5UclZ3c1M2c01YTDIxT1IvMGtDYlpkQ1QxWTVIVk5hWEcwaUtJ?=
 =?utf-8?B?WTBuQytJWi9sL3lhQ3lleENqUXZhRjljRlJjb21YWUlOTU9IWXJwVHhRR2JD?=
 =?utf-8?B?KytDZHo1RDZ3L1FGZE9mdUFuZnE4MmtGTENuQytJdWJRMTg2YWQ4a3ZaWmFu?=
 =?utf-8?B?bWZMN3NzYkxXL2Z6L2t2K1IwWnZRZnhGdVU2cWE2N0JoakRWUmlZVUQyaDFU?=
 =?utf-8?B?SUdRQTZWRExEQ283VFlPUTlrNXN0KzlkSmpUd1Z2NXZYQXJnN0xHTUJ6WFI4?=
 =?utf-8?B?Y1JuK0ZmZTdVb1kraURHQmhCeTlBb0NML1NSdlV2QUtoSDA4QS9aR0lFeW5z?=
 =?utf-8?B?dlJQN1JVR05DTHZSM1daRE8zbU9IMlFWZFJRN0tKTXNKMWdLT1Q5Qi8wSmc3?=
 =?utf-8?Q?VSMKm3mzJgxIKO68VSZ8HqV8p/rLCvu8iah2f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e57efd-f96a-4b8b-a928-08dee1bf2c7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:47:13.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfGxngeQSzjj/5U/MRwzIvVY2Aq1z1GVxpZ+iF+YkiSTWwa2NYpBLFlz7y54cK2IerGerQ5JRU6U+sfDo9v75FYMO5mKvBgbIkbDIbDcACV5/Du5bErolWTZZrQuH4nz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11548

From: Frank Li <Frank.Li@nxp.com>


On Tue, 28 Oct 2025 16:01:27 -0400, Frank Li wrote:
> bindings: add fsl,imx8qm-sc-key.
> dts: add fsl,imx8qm-sc-key support.

Applied, thanks!

[1/2] dt-bindings: input: fsl,scu-key: Add compatible string fsl,imx8qm-sc-key
      commit: df9b9d59586f3d8bdeba5b3c7b7ea68cb0302fb7

I picked it because it was missed since 2025 OCT and ping 2026 Jan and
fsl,scu-key.yaml was only used by imx/

[2/2] arm64: dts: imx8qm: add scu power key support
      commit: f9c8aaffc782cae682d3606037f2d02fb4e0035a

Best regards,
--
Frank Li <Frank.Li@nxp.com>
