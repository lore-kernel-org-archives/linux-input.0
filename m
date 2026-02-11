Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349435CBB6;
	Wed, 11 Feb 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846095; cv=fail; b=op1oxMXt5JVMjhS4LqxCgTI45eXj876KuKxB8UqPCDvk9HTeAYCE0dkzEfDGo4uTSNlRkNGTYIDwxOFgjvQ+L69Niter/HfbTt0gAHvc7oSHrEgYeRiqZ5elHvyDnc2QsrK3svLafGUYdFtySQfABZ9rShzVx+EVl3CbXMfu04M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846095; c=relaxed/simple;
	bh=3OAnTxhLN0HWyaX3XGT6iYbgJimsGe0JCxnXg1hjefQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UHomMWtsgDnv4I2xVUse6A/BaEzhjOfyD6P2cZPsXO7NskabfbSEPVrRPo+aES5MVS938pKwtUgci9RiaUEWCH0iZhP+OmSH+nOWpkXo0wrWoIcvevuGtfv8cqcw1vtAY7dy8KXPOCLZTpzLBGvbODvVw/YAI4R3iMxZ0Hp5dUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TsNDnWqw; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TsNDnWqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avT8dngIfRJRll2hhklSQWNusf8TxVknNNVg/ZFyaZjIs83edfufqNX54mdRoqOQhx8FRKExkIf9u7xDSQs4+Qgf2C9LNeLy2tz3RxqiiFY2vHvNH4NbdZb935OAulIPRrJ1yQDOajIPp+aRAHZkyeSdv29dLL3RLJ1vwnMLNDWandHHQKj2egv2bUP9s5ijjFRCh50lVFqy2+ckraacvqOvT42WyxKVkUi3eblMNINchARRJ/tDH/jFFh/Xmb9/gQ/jhr+RIGshxls/AM/GBNASsCZAaifqhWkugTS7gz69zkYu8f3Qs3tP/UKoezwAUW9FnPryTk/4lN3VqxPzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YL5XQ3G0NESLQr0KPzE8fTl/N1d0L7+Vvsh330j/9A=;
 b=QH/xK8X+JwNez2SbOv8eNAptJfN21osg8GD9wZ3ecga/RiO8J//MbEEqAn/PDMt473dn1JSfKwa4f7J1SwQWNZb1GsbsmEfN+zL92FSxL4O9Fm3fMIeXY0zNntlzEbSr1XHz3HiXnjPs//Fg2G9jUeTrKbWebDlrOSdHId6ceoq45jU9cw6UW6RAVDBISuGsOPGREMijdNWolBDxDh0Ze2aX4tqEk2VyYTz+nBZqBof1h9IP5JQ4JUw7+LY0CeLtDEcr/YTn7BotctCcoygP7HY35DU0U7svE0/9R2nda5P6MF6wb4J0UF7TjuDgNVhgKzSelED9Pd3YwsWAef15WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YL5XQ3G0NESLQr0KPzE8fTl/N1d0L7+Vvsh330j/9A=;
 b=TsNDnWqw2G23W5RM88pfV3uYkI6t9f8n6+Ts8X8UUSkVtEpeA2868O0keESKYjzKBTW9h75wyfpaUhn89gOQipXp3lTctMGZ4p72Uaue0d666k66sQHW4J++XrMUyY2JobBVZBjtYYr9kI8S3V0bs49mQB0vfZrHRUQ3UB1V2O8W+gO6qdKGRhwqNNZp9F7oHhyJSAshh+as0qAdpkYLwEgnkegmPyHcTgXDLIyOnd1YMDR2vTWTLSn6pAHso/cwmafmCSx+EK3YEzqcouYqDiBMVwGKt7W5RqIxR+dMprykfEBKZP14/kHjp7VgcT4x0CUkSOUfRholwQJ3AqV43g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:41:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 21:41:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Feb 2026 16:41:06 -0500
Subject: [PATCH 3/3] ARM: dts: imx25: rename node name tcq to touchscreen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-yaml_mfd-v1-3-05cb48bc6f09@nxp.com>
References: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
In-Reply-To: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770846079; l=1034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3OAnTxhLN0HWyaX3XGT6iYbgJimsGe0JCxnXg1hjefQ=;
 b=y0szIYsrS1jOlRtgvJrLHgTz7bu3VR2ytVVWzw9g6nUYms2UB5GnIVOrzEjNDDq+tjVBu4Iym
 8wmanTsgZFRAD6urOqzfT4mNdYI4K2mbWS3d5JXvvUYBQXmY1+J21nf
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
X-MS-Office365-Filtering-Correlation-Id: 38004396-7de1-459b-f8e0-08de69b6524a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3ZUWmo1cnVkSTJsRTBYR0EvUVRKS2l3RXhNcDRQQi9HcXM3bHE5UFhkdk1h?=
 =?utf-8?B?OEFSbXY0NzI0Skhtc0ZsMnVYb0g2dFhrRVBrbFpFeXZZRFo3MU1VUUM3dHlq?=
 =?utf-8?B?MUtId2Y0WGFRMUZsZklubU1KaFI5R2RBOHJ3VEd5dmR1NzRpN1pWd1pRNDlO?=
 =?utf-8?B?VmNObUlGMDFGMGQrWGhXY3JkMlJYZUt2MVB1NWkvS0FtL3AyKzZoc3VaMkpH?=
 =?utf-8?B?blpCeVRKSkhMZzJkcWxVcTEwSG43R1hmSzFUWU40NkZSUC9SMnFBU3lkMGNn?=
 =?utf-8?B?K0NTb2Y1MmlCQ0lGVDZkRHBWNCtXSUcvVE5VUXVzZG0veVBhYzRWV1RRU2Fs?=
 =?utf-8?B?YVl2UmlaYVZ5WVhlZ0NxMzFtejdTOEpmaEpkckJYbEdPaFFZT1I3R1lBZUNR?=
 =?utf-8?B?QzZYWE56Zk42cnhsV1JBQm1Nam1OcGFWUzBXUmc3ZW9WNXBObEs0U082S3FV?=
 =?utf-8?B?ZzZzSTVjb3lYWU9nQlhsZlZIU3prWXE3R3NXOVJGdkl1MFpaUlNZWWQ4SHc5?=
 =?utf-8?B?cFpzcFh0MmZOYnRJVGpxZkttTTZIMlk3TDQ0Rnd5Q0hpS1NRdlBIM3AvQkNC?=
 =?utf-8?B?V3Zaa2tNMS9KbDEyWjdiWkNSSkxnZ1pXUTh4YWZ3NHBwTkh0ckVicTNSRXB3?=
 =?utf-8?B?MER4VW91QkRWOWV2WURTMTlrQzNINThhTUZSdEVPYTlzT2tFQm8wcllYRzc4?=
 =?utf-8?B?SVFXSWRUR2F2cTNSdGs5M0wxN3hNYVViUHE0NkR0Ry9HVVk5Z1JBWkYyVkdG?=
 =?utf-8?B?emRDbDcxVUlpaGVsY0JXbHhDSUpoU3ZzdVpKenRNWjNxMXd6cTlvbyttTGtP?=
 =?utf-8?B?Zk5DZzQ4QXMrWHRPaVdsVTNPSG5KMTBGNkVBUWhDbjMyQ2JRRzAzYlN1a3FU?=
 =?utf-8?B?UzBSbkpKZ2Jhdk1DeFU0YlJwT3M3bjJGK3IrY3paTXVSKzZia0Q4YlBCSmZx?=
 =?utf-8?B?eDVRYm0zQmFDVkVibXpFZ0g1NDh3ai9WWlZ4N2RZRGpVNFZoaUpWQ3BidHFC?=
 =?utf-8?B?QkNyc0VmWUxtdWMxTGdsYVNlK0xhUjdVL2h6ZkVTSXhoNER4RS9UcUk2bUNa?=
 =?utf-8?B?OXVveEVoWE5YdlJ1U0ZuNHc3am4wNlFsRWFKemo4ZDJRMlhYZWkrNEVuY2Yz?=
 =?utf-8?B?bGtBa0xZNk9qNzg1OU5sb2FBd0oxVHZUZ08xbmpDME52WjlBdnVCazJmcnNz?=
 =?utf-8?B?WXRqdmVhM2F6Yy9veElIczRVTGkyc3NCdGhpYlVnNkZzNFVYTjRCYzRyeXBz?=
 =?utf-8?B?QXdiMkttR053S3ZUdGJRRDFtZ0hTN2hpZjRhc3NibCtzaUQzRDIyRnBVS1Vt?=
 =?utf-8?B?ZnM0d045T1ZVOUNLV1dKRHVwSXg5WlJwL0tocVZyeW5wZVBSbGsvNStqRmxW?=
 =?utf-8?B?Wm9YcUlXMW1YUnA5b1NMakVDa0pPS0ZudWdSQnZKRFJ1NW1yZ2xxM2MzOEh0?=
 =?utf-8?B?eE1SdzdZRmpkd1lWb25VL2FkREJxQUxodGpkVUluN0Nyc0h5T256NVM1NERZ?=
 =?utf-8?B?YnZCekVqWmlLdDgyVkVuN2tMZlNLOG40WFIxV2J5dFEzdkZDMDh3MGNYejNY?=
 =?utf-8?B?LzNZdEQ5N1dUWjcyRjBXRTREMXc0N3dBZTZPc3krZmFNa1g5SE96eEdkVWVS?=
 =?utf-8?B?cVE4NGlXZEdIUFVHRWIwYkhoYlhtMkRHZUJuc01XMWMwMlQ4RmlDVGoweFpS?=
 =?utf-8?B?eDJucmgvMmZBV3ZMTGhMK3NsMzFNWU00aEFSWWRyV0FlTnl5ZjEwS0Y0YzFK?=
 =?utf-8?B?c0pnMEdQME5XNXFGOGFsM3gxOGF5ZU5xUmZNcTI0NkxKSWE3cmNnOW51cUZo?=
 =?utf-8?B?aExhVnpsVEFuU2lQMFBydnVvVlB5VHBXcXZDL09kMVVvelpLdktOZEE2TkJF?=
 =?utf-8?B?MEZQdkxmRnNMbmFTdmdycDJHUDFGd3RFaHBiTGU2cndKL0dVMm4yN2tXdVVa?=
 =?utf-8?B?WjlVTURNZmRIUnZQSXZ2MFNtbHppS0t5UG51NmRtbzVwb1RocFNnSnBvK3VC?=
 =?utf-8?B?T2w3ZW92UU5BU09FOXN0S3duQ2poSXpXODJPdTk5NlI2ZDk1TFRoVVp0ZDRU?=
 =?utf-8?B?V01WUkhPUEdCZGtKV0cxRHROVmJVRzlsTVBYZm4wNVU5OWxVcUJDeEFtY1hq?=
 =?utf-8?Q?eVqU4uG4/+jTVbgzmfMxbv7Su?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anFuTG9sMjhQM2xrNlo4TVBvcGVDS1JaSXA1REViSldLSjBwQTJpTGFqaEt6?=
 =?utf-8?B?WVZYWDJVZFdIRVc4MW5QSjQ4TlB6dUhaeUg4OHlORFVYc2M3VlE3VU43aGw0?=
 =?utf-8?B?SHJaa3FhMGlFbkxPR1N3ME94MzIySTF4Q2dDTlJaZENoSHNhS1ArTUY3NkNY?=
 =?utf-8?B?YzBmZnZHT1hDanRHM0FGczZSZEFUZEt6TE9OTUxYZVBQMVF2aGtHN2ZYVTIw?=
 =?utf-8?B?MjVCdVVQcnNNSzhqVEJZWVBFZ2hYcmxhYmMzR1MrODc4STlpbVlVL3VwQUgy?=
 =?utf-8?B?KzYxNk93RElmMlJZeHdXZ1lubWlBdmRuSHRwWWxYc1B5U04xRmpLV3pZbXVJ?=
 =?utf-8?B?aFF2M3ZDS2JzOFlDYjBvcjJxOG1GUGpjRGFBR0ZhRXMxUE4zeFhSVlFWL1lx?=
 =?utf-8?B?dzBvMENtMkIvek9IaCtmSGhaWW9VQndMVm9EMmJjOEU4SFJ0SGo0VXBzTC9W?=
 =?utf-8?B?cWxUUitJVFBrYW90SlBHWkladmZDbFJ4S1QrbVpuRXhQK2JPWk1NelhBY3h0?=
 =?utf-8?B?dkRqNWw3Qll4MElEL241RTgzSmlOU2NSVXBMUXlONE9MeEx6TFowVlYvVTlO?=
 =?utf-8?B?MzJMU0orMmFicTBNRGlwVEZmUkFReEZ6dEVod0ZLUzNGMEVBL2YvSkp0dUdR?=
 =?utf-8?B?MjA2UENsRkc2VTl0b244L3lBOFVRZG5lNTloVk5oU05POTJlWUo4TGE2UUJz?=
 =?utf-8?B?bG8wMkttUmxPN3pybW9US0FLc2tORTRYMW9maGh0M2VZbVlGdy81SW01Ukdq?=
 =?utf-8?B?azVOOEVpa08vOC93TnhSeStkT1JpT3ZScEtTN0FVNkF2cElCbEFvRnloUEpB?=
 =?utf-8?B?c0lJektNcnZiSXNKVGJ2bStxbWlKdG02K2t0WGx6blc5VkhTdFBiNDlXbUF3?=
 =?utf-8?B?U0xyMU9OaTNJRUZXQmV6MklaVmIvRUxITmViNzVMQWJ6ck5BRnRPRWFuQlR5?=
 =?utf-8?B?N0RtNkVubnJFL0hKZngyNmgxU0ZqV3JDcjk2ZWRCNlA4b0tLUmhKUktPUkNS?=
 =?utf-8?B?b0VjV1pOTk9mL3AyUzhCamRnbGpScHhvOURzMUFkMnA4eUlSbFI5SkI3VitT?=
 =?utf-8?B?R25hWmo5bWYyZ1Z3cEZ6ZWpOeHpqQm9nbDNnQThIZ2d3elFTYjhlZWVaL2NG?=
 =?utf-8?B?c2ROdzUzbThJUUZadDBvUEo0aUNRcysrcU94SVA3cks1NnBBUFRYYjZ4NVRI?=
 =?utf-8?B?dmZLakdPeCsrNmUvK3Y3eUhVT0U2dGV6eUtZc2VDRTBES0REa2NPQmY4Vk1B?=
 =?utf-8?B?RVhjSzFqbTI1QXJTdWRITjFiYjd2eWVSckVrVjVWQ1FtYUZyUU5kL29MeDBP?=
 =?utf-8?B?V3FMaGkxRUJIOVI2YWx4N0N3bDlaRTI0T2hhMFN4bEIvb3VLWDNmcFRybXRt?=
 =?utf-8?B?YTc2RFJ6TEhvVDJIdzJnT2V1WHU4Tzc5V0hVZFI5WG9mcVJFWTJ2RHkydDlD?=
 =?utf-8?B?ekVzOWpNQzFyVkh6cXlQOWhVRDJ4dXk5aXVubVlWdHc5bGZDT2VCaCtyM1Z2?=
 =?utf-8?B?bTMvbnNBVDVuOUxpcE9UR252UmR4QUxjaGZ5RHFmaHppcGpSbytqSkxWeXJN?=
 =?utf-8?B?U2lBT0ppRitrZUVSM2ZXZk9ZbDlacDdSRUUyN0o3TDE5SUtsbkV3UUxKUFNV?=
 =?utf-8?B?THVQejg1WUFjQkFtdnBpUlJCbjFNM2JSN1h0SmRzTWJkMUZOS2pxbll4M1Uy?=
 =?utf-8?B?ZnZlUERTVWRsMzVsZnY1UWRwVXJsMDZUWnUwdkViK1c5cmE0RTQyOTN0Vyt4?=
 =?utf-8?B?eEpac3ErTmdEU1FjQWZNcy82dnFrNnVoS2FoeDgzSi9HMHd1cW00QkljWDlY?=
 =?utf-8?B?SFNYdWRXQnhGTVJHeTlQcFAwd3JmTTFub0h3d2pzUCtaWTNFRTRmcktIekov?=
 =?utf-8?B?d0dPeGJtOFlDRERCYnJMUktjNnEzemdoZUk4Q2wzc1JacWQ2cjQyc21RcmhI?=
 =?utf-8?B?ZEw5T0w3dk1NdldvamdRZDVwN2NiR3d4YjFmVDJRc1BYNnh6cWJRZ1hRNEtE?=
 =?utf-8?B?SFdsTFlQSTZQZ1NrVkJlVXJEUnhocGVVbmtBZ20vZVN5enhtd0JBaGlpUUpU?=
 =?utf-8?B?bExYTGdwSHdqd3lhdUVuUjZlS0hkRjFjaktiTXVLTHlqYksxbmVhNituOEYr?=
 =?utf-8?B?UmRRYUYybmg1SVN2Q2xLU2s2eUplSEJnRksxMitmOTFuaDYxNHA0YU8vSjVr?=
 =?utf-8?B?LzFBVURobGtYWVFtZW41NFhUZ2x1RVhITW5GY2ZFMGp0NXRPZ2c5bFN5aUU5?=
 =?utf-8?B?UDNKYkpvbTJ1UXNCWWgxWDRJMXMyMmo0SG9DMS9IdFV4UXRjVSswaS9EMTh4?=
 =?utf-8?B?T3FqTFNTbEhvUHpLeFNiZm1USzRPbHBHemp4MmdyL29xekdwa1hhUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38004396-7de1-459b-f8e0-08de69b6524a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:41:31.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtKsIoAkXxQBt6Q+nwqhnIGDVpI0RB9gKvM8RjcJT4Na8kQU3hp7Id4QmDn3cpQL7Z4aPTgsEskHJnsJyvlEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

Rename node name tcq to touchscreen to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dtb: tscadc@50030000 (fsl,imx25-tsadc): 'tcq@50030400' does not match any of the regexes: '^adc@[0-9a-f]+$', '^pinctrl-[0-9]+$', '^touchscreen@[0-9a-f]+$'
        from schema $id: http://devicetree.org/schemas/mfd/fsl,imx25-tsadc.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
index d0f01f9b76afcfa0f38398ec29697b6d590a613a..0aa0d1931958c588bb816fa040aca6379ac67906 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
@@ -305,7 +305,7 @@ adc: adc@50030800 {
 					status = "disabled";
 				};
 
-				tsc: tcq@50030400 {
+				tsc: touchscreen@50030400 {
 					compatible = "fsl,imx25-tcq";
 					reg = <0x50030400 0x60>;
 					interrupt-parent = <&tscadc>;

-- 
2.43.0

