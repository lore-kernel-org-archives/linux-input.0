Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62E2E06EA;
	Wed, 11 Feb 2026 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846091; cv=fail; b=OmuCh7nSlQGIf4PBkRE7zcO6mOYMl/4B1nhxX9kLDWGr9iK2aQeFUWYpki1Q8PWiCokICh/s91EdDQlxKSS3G3UEYBv+2G96exG7UaZVf/dR3+C2oJEgIyYklqexdC44HMFAQKWK98AgmjQ1E7sVPV/4oHqe2j+fAI54xKsOqe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846091; c=relaxed/simple;
	bh=/aSYhmGzqfaA9O2+ttJJkcSIq2Nsl+94YG2N36K/hG8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uUUCE0y29/BhsTzTxexviQmSKRfWtbiRYyYAotucTNJA4E1XCjdKKr7fRPDrnztUJCYClKhB7iGpwWqkfWRHQkVzkxGOvv1WRibRbiajSMCffDHUNoISdqFl2p1pDuT/bvj80DzZ5w9G5ZcNEjJJwenQP42WqzsPmm7GaWtqWvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NC/qaKtH; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NC/qaKtH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3xhC46eT4kGU2GBuauYXskTwdRYhiFr3pCFWXXOjsqhuUf7gmfRJ7Laf7uahq6WpVTMOj8wDLBa+eAhACoDWsogqiPThUe1fZhLrxZgPAC1thKWFJvBMKKd+eg7UrWZnmu4OxvMxycVJWrUgk54nxIKgVDcPCXiBveLtC2duezcSFf4OShe0BXwzKSdrMdzccdmf7Y0zvecAw4/MBglZV6A2In30gUQ5YFiqAvZtwNP3jg6ip68sSRDe9UaBLU7GPVCbTidFSwR6IY8kyGlUxFctPtYvg0GNzE2x3wG+U87nf+exzBFSbknfPCakZg2GQyq/LUHXbowZTM64A9v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v741jSZ1Kcz5cz7NeSocCMmofISj2Ea7ZojEGMM5KlI=;
 b=eKvKv7O/5G8/BVGor2jyuUCB46coOk0GBIQdejnsFZUDcF/2ee5d0GePh2xI4UcMD+9Aq6prbhYplaFim5RmmA6uEU718WiuMZXtq2y3Y5Jjihgh4RJmsYamFpb89KDDKyLAi3H7w+wTEBbOCfFU/DUv0HYJS1adD88BILjkW0N3ibTX/ixEzD0mfAIFjM3wLSALq7IStcS6wShjQES0VUvuOzxGZRQnyTkh1wYqVusoPa0kRfiwjGLwbHyQnRyRS25zAhF1RpX+RcqEk2Yun3JHjRvK2r+dzvL+CHAKnirROgv4runwF03Xwtniw1eYlLV59QrXUI7JSvBBs2CnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v741jSZ1Kcz5cz7NeSocCMmofISj2Ea7ZojEGMM5KlI=;
 b=NC/qaKtHHLNYq1DR2vLC0wTYVHi21Q0lSnUQL6tR/GCTNSlnNFieWhKhjYZToyzSnBSFrk9rBdlmMgUizwZyd2anNHZWUzeMSZiQtrks5bUc06MNyCBMaDUo4u8kBHZ489vzQO/4vzjvvrV647W/aD8EATSa3vDOpKkF6b0C49iNlWa/GqsgxLCl4UhkVCReumGCnfGdC2aPVLVS+CPuI7kLyBXCBlQd+SI7XJDnCQuujf5PD5HbnWkH9yLTwTvr2wnmAX6vakrMvtl+4jtEzSq1jR0+04a+wC6XWp/Xs9t46MQQFSdq50cvyrqDvVSVyVEz9kMrab9qjO9y/TQvmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:41:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 21:41:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Feb 2026 16:41:05 -0500
Subject: [PATCH 2/3] dt-bindings: mfd: convert fsl-imx25-tsadc.txt to yaml
 format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-yaml_mfd-v1-2-05cb48bc6f09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770846079; l=4591;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/aSYhmGzqfaA9O2+ttJJkcSIq2Nsl+94YG2N36K/hG8=;
 b=FSKNPQmQfz0cnFJcqxjw7V89M4AoHiv927FvpXJiujnpVdQ3+HRNRE6Y1L7cvZO2WzAPfqlAC
 I/ZxX/aIN9+Dbb/vm9kWoIHbm1T3Uj2iYSxLBY7ulPaWGwUMVw3jF8Q
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
X-MS-Office365-Filtering-Correlation-Id: 1ea6f89f-4d13-4671-84c2-08de69b65060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0Mrc1IzTVJianFzM0t4K281eU91U1FyUDNKczUyVG8ydnowcGtsVmozYzFj?=
 =?utf-8?B?V2tCNGVjcngwci96SmVFM3pJY3FsT1hLS3pYcEU0L04xMnd6THdZdVJLWDhw?=
 =?utf-8?B?YjNFWlVsaHd1QUI3Z3JXQ1V6L0RXSkZRU2JFOGxkcm50ZjZLRGpYQU1UaHIv?=
 =?utf-8?B?RkhWUUg1OWVmblpNeVhoS01ZVjFlMCtFQUZJdXJHbk9jZ0pQZDdjQW95c2VJ?=
 =?utf-8?B?dW5za3NPVEJVdDM1bXJ0NWpCa1B4UnozdjRXUmdMeHJBNjRicUR2K2tWUDVq?=
 =?utf-8?B?dHFwcjZxUFl1SGNMMlJmbllJa0pubUxPbHI5VCtrWHBzUkVtcWx3R3kybmR4?=
 =?utf-8?B?UkdHU21mMDBTaEcxWjNDWUFGcFpNTXV4TzAxUVBrWk9WVEdPMGZLOHZMYXg3?=
 =?utf-8?B?Rk10b3RVRFYwOXBJZ3R1Z3FsckswRkxqZktBUVU1Lzc0UGsyaXF1OGo1NjBZ?=
 =?utf-8?B?emtSUnh4YlArcGljeEs3d0t0bE8yOHdYelp3M3I3SjNEVGFkdHdreFVzZTBu?=
 =?utf-8?B?RjZCZ1hFYW56a1NzUHFzYlY5YlhzYi9nZVR1b21nRG1neUxsNkVvc3dObVFE?=
 =?utf-8?B?RGc2SWZIeUYrSGZJTmxhQjNnN0hjZkFuOVdJV01QWXNCV3Q2cmFFOTgvTFR4?=
 =?utf-8?B?K1pHdzFKL1o3UlBZeVIzQjZjNGh4SXJySzlRYnl5Y1VZYzA1Mk5XbS9MYUdl?=
 =?utf-8?B?QTYwYURlZHp3VWZXRTRnOXh4eUdJeUkxYTdoSmk0NEJVY203ZU5jU2xmLzlZ?=
 =?utf-8?B?M0w5aGNwV2hFQ1hPZzNyM0VqeUxJeG1EUUJwZDlyKzJsUFgzMXE0TW5UMlFw?=
 =?utf-8?B?d2d0NUFNb1VWcHltcEdsVlJPYVpvZkswY3doTVl3cnM1c2FTM1cwa0dIS1Jx?=
 =?utf-8?B?VGJWeUxQbkxuRG5XaHRXcG1SUXdHQ0pGbFAvYVVINkx6Ri9pamF1Vkt6YzR6?=
 =?utf-8?B?YUI5TjBMRFpxeDZuVm5YZGtvRzBUUjlKV09VVmorVGh5REVvcDBIQlplNGRn?=
 =?utf-8?B?ZllKMjJySGl5RXNwaVJaRE1VazRvbU5JZkR0bktpdTQ0MmFPZE9uRFR0MXRV?=
 =?utf-8?B?TmhyRUw1SUtvQ3dOaWV0VW9xYUdmTi9CMFZ1cmljTnk1eTFMeldPZ05yYnEr?=
 =?utf-8?B?ajVKZzZEcENPV1ZHaXhua1hTMzIyYWw0UTd4UTk2OVNJN3dsUVM1a3hHY2py?=
 =?utf-8?B?SUhLVUZhVFNPeERQSTVmZGVBRXpuTU1CWVR2U0xhNGZlT1l2MkdabnNIdFRN?=
 =?utf-8?B?QUdvY25GWENvMlpyRzR1N3EyaW5wYWRldVE0TkZITElHTXp1enc1dEZJT3Rk?=
 =?utf-8?B?cmRIMUt1T2YzN3hUTXpxMWF3eC9NcTJjb2YrMytiUFI4eDhQemdmTkU5M1lQ?=
 =?utf-8?B?Qlhlekx0cHF2a2ZtMXRpVGNRRi9mV1MzR3A4ejRmaGROcjl2WnBtWVpmT1Rh?=
 =?utf-8?B?eUhCUURqczcvTWFBMWU4NUxDaW9UVVB1ajJGa25ScTltb0F6Zm1SVlRXdEFF?=
 =?utf-8?B?MnR5S2pqVGZIdUI2S1ZOY3lCK1Rnd2t2TElabW9VMGxBVFIrRE9XN3hTOVBS?=
 =?utf-8?B?U3p1a1FuRjFEVERST2NGQTFEVWl4VVdqM2xjdjQzZUk0VmxiWVBhR0lIMi9R?=
 =?utf-8?B?ZGhlNHByU3crbjB0TldmUWNZKzJNQ1BvMHViOGkwbGFWbzE2QUI2RFBHREcx?=
 =?utf-8?B?VkQ2K05waU1acUlyNDh5VUVKdFlWOE9KQ0VJRi9mYUtFaW4yQ1NxcHFVeTRQ?=
 =?utf-8?B?eUd6bERoNHBmbGVuMk12K05nV3Z6cnVpS0l1OEMwZEFzaEFya3J3NTBYUkpT?=
 =?utf-8?B?TUVBc0RpdlQwd3A5SCthMjM3SWFEa0ZXRWc1d2xQTDNYYUF2QkR3aU12TWM3?=
 =?utf-8?B?V08wUTh0enJOYW4xUnNwK3lXemVZQW9ON2o4TE9MRy9sZXpwMHplTlRoZFhE?=
 =?utf-8?B?TytrNUE1aFVrNW93aG90OGxuS3VTekNuYnN2U0tqVC9PK3RQdlpVZDNPUE14?=
 =?utf-8?B?dFloMTdWdjRUZjlRLzdBV1ZrVHNIN0Eyb0FGbmRZODJUc0tiSU93Nm81b0ky?=
 =?utf-8?B?V0xoOUorRVR5eWNISVFwU092YVJXSW5qeGhlbzVPTFVVQkllV1JOeWhobUdk?=
 =?utf-8?Q?5pwGdXTI2J56t/tLoExYevc+3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhuY3Q4VkttTUVzZFVJTjBWblZkSWhjRm9zakJuaXMvZVJsQlpTUkgxOVJV?=
 =?utf-8?B?c1lrd2pjSWFNRTJRY012RkhIQ3hCa0F1SURuUzdhKzBvTTFtMWpDR1V3blk5?=
 =?utf-8?B?RDRkV1VCdURwWTdlUU1WNE9aYk1LMloyNFdoVjJTVmQ4N1ZWeENkMGNOdkc4?=
 =?utf-8?B?ang4Y2kvUHBlMW54dk52U2FsM29wczFXQmpZNHR0ZFlXc2VvcUFybkhjODlX?=
 =?utf-8?B?aTZwS2NkU2o4YjRGQVl5endKSW1Uemh4Qit5YytWY1pQNjZBMWh1V3QwT1ND?=
 =?utf-8?B?Mi9JT1pMNHdwcEVlU0RKVDJROGd5dFMvbk9sL2dGa2Q4T1hkTklXeXZOUjV0?=
 =?utf-8?B?aTF2SUp2MldGVjRkVitLemtUS1A5eXcyQnhNTmhRbnU1eEhJNWNUNTdVSFlw?=
 =?utf-8?B?anA0S1M5T0hNUWNHZ3NIaVU3MHJYNFh5alJtSUkzOTVjdFM0WkFCd3F4YjVR?=
 =?utf-8?B?YkdSeXJmYUFlaHFYYm5hRTZ6U3Z5N1JKVmpWOENWaThreGsyZklOaTQ1S29N?=
 =?utf-8?B?K2dGZlJheXBCTnNnQisrS0FJalhFVm54dXZzUFRJZ2lIY3Z3dnZXOTZJN3h0?=
 =?utf-8?B?eVBmYjE1MVBiMUlUWnZ4MFg1dCtBZUlmK2Rpa1ZvNGl4OVlHR292QnFtdWtr?=
 =?utf-8?B?V2VXWXlVdWVHcjk3OVlBYlhkZEJpU1VycWN5bXBjUUlqY21DT29udmF0OXZm?=
 =?utf-8?B?dVB0MFl2eDZzWkdSN21kUkJQSENFZ0NqbUFzY0VxaW9kN254UWVPbU9ZNDNv?=
 =?utf-8?B?VnhML1kyUW1WVXQrSS91YVFNOVpoaXQxd1JldWZScFYzVThOdGNOVS80d09n?=
 =?utf-8?B?NkdPa0srcWVjTFo3KzA0ZXd2eFNoSktBRC9jK2hOOG5KV0FzbWJzK0VlaXo2?=
 =?utf-8?B?eG5EeDNxRU8vTGE3MGNTUnl4RFU4VWlUUUt3WW5Za0hqL2ZtNmdYcURCUWcz?=
 =?utf-8?B?ak9YSXBqM2RpU1hZUENxRnVrQnYyYndzV3owWkRvTkU5OTlXNGxqY2VWdlYw?=
 =?utf-8?B?TWNTMVlYcmVMQk1JTFBheXkvUFlxWC91Y1RIeDFRd0RKeEVPSFdKbzI5UEVv?=
 =?utf-8?B?bXZtYjZObEVUb0J3SDBPc01WQnVLNk0wcUdVdm5RanYwM3R6OVBmRXFENi9U?=
 =?utf-8?B?TVNjUUF6S3FXSXJIR2dTVXRCU1JTTmo0eGo2eDJhOTBzTWlENG1ibWY4ditF?=
 =?utf-8?B?UmNmU0I2NHlxeG9JakJtVGZtK29oV05hQWVtQjZTNDJ1bXFHQ1V6LytxNzN3?=
 =?utf-8?B?cXMxMjAzMms4N0YzMFpmakhlUE9TVjNNZ0F1MmZQQys0TlNhMEZ0ZDF4cllJ?=
 =?utf-8?B?b1kwM0hsWXIvckZBUnJ1VmNIYk4zeVJDeDNNZXdrVWo1ZUJJb1pBcVBJdTNE?=
 =?utf-8?B?MzMremo1SjFhajhpaHZlUitJaFJBSkRJekEvZmZPNHVuV1JITjAyditsV1Jx?=
 =?utf-8?B?c1BjL1VJajRhR0VBSXZTNnRRbEluQUJLQmhWblBTWkttM0kybHpnSURCdXVp?=
 =?utf-8?B?RXFOOEtYZ0pkZElmWWN5M2E5SGdROVdHbjEwSGhZRGRLSkdiRmpBQXJhdmph?=
 =?utf-8?B?elZLMy96aVVnbzJMYVFPQTZSRVJWV0dRWDZMVHZGbVAyNXpNcktNRC9zZmxE?=
 =?utf-8?B?cVJsSnphNXk2SHNKelBaWGVPL1pvaHovUUlIVnM5MVY5azJ4T1VoeXhwZm1h?=
 =?utf-8?B?dUVoeVlKM1V6WFJYUStFYzM1WnZaL1M2Y1Uya1QxZzlUd0lTLzJBaXpSN0Vs?=
 =?utf-8?B?Q2NYVVJIUTk2Mm1BYW5Lei94eDZmeE9Db3p1bEF5MUpraXdra2lWV0VWb3hS?=
 =?utf-8?B?Q3d1ZjZNQjcxTWlIU1BnSFR3bWFsQ0EyL01MWjdWLzhURklDRkNDNjFSb3hv?=
 =?utf-8?B?WkxJbzdQbGVSMFBLbDdPUGJYVlJjT0k1SDdhRCtDVHlNN0ROTHhIeExJK0dl?=
 =?utf-8?B?bWFBTTZmMW9XZlZwbXlCVVQ5Nm1QYS9FV05NQ1ZoUXN0NjFUemZCcys4clFE?=
 =?utf-8?B?N3NUQ1FSS3YvZ0tBU3dBSS9sdWxnYnFnYXRsaVE3VG9pOTNyc3RpRlVJenY4?=
 =?utf-8?B?TThhM21JMzhoYjlTUlAwZXJJNWNrazZoc1orR1BvK0lPaURJTnV1RFBEeTdZ?=
 =?utf-8?B?MDRkenZJRGRFTGpjN0tpZU1QUHhTdERZd3ZvdWlmVDVsVHltMmMvK1g4L1la?=
 =?utf-8?B?L3pVYUpGSUdxWlIwOHF1YXUzNWdzY2dOY1R6eDY3N2tXSHBka1lTanVOdzRt?=
 =?utf-8?B?dldZQkIzSjNLRkxwZzdLK3dqZzllQy80ZHc3dUZJRFVpeUg5cXFyMHFKS0JV?=
 =?utf-8?B?Y1dtZjVJb2dxR0g4cXRqYVRTeU1qWENEK3pFOG0xUExnTFRBRjZqUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea6f89f-4d13-4671-84c2-08de69b65060
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:41:28.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPvRUigIvKQBSOIOyLUG7ht7O2ut8jmOCu81gangeriyaCMHV/rnzRueQEmy2u1wSJJ2QCGCT0QzuLWN/xlGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

Convert fsl-imx25-tsadc.txt to yaml format.

Addtional changes:
- Add ranges.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/mfd/fsl,imx25-tsadc.yaml   | 97 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 47 -----------
 2 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx25-tsadc.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx25-tsadc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b5c6a2d4750115a2d2332d766722b99e517721ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl,imx25-tsadc.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/fsl,imx25-tsadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MX25 ADC/TSC MultiFunction Device (MFD)
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This device combines two general purpose conversion queues one used for general
+  ADC and the other used for touchscreens.
+
+properties:
+  compatible:
+    const: fsl,imx25-tsadc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ipg
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  '^touchscreen@[0-9a-f]+$':
+    type: object
+    $ref: /schemas/input/touchscreen/fsl,imx25-tcq.yaml
+    unevaluatedProperties: false
+
+  '^adc@[0-9a-f]+$':
+    type: object
+    $ref: /schemas/iio/adc/fsl,imx25-gcq.yaml
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#interrupt-cells'
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    tscadc@50030000 {
+        compatible = "fsl,imx25-tsadc";
+        reg = <0x50030000 0xc>;
+        interrupts = <46>;
+        clocks = <&clks 119>;
+        clock-names = "ipg";
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        touchscreen@50030400 {
+            compatible = "fsl,imx25-tcq";
+            reg = <0x50030400 0x60>;
+            interrupts = <0>;
+            fsl,wires = <4>;
+        };
+
+        adc@50030800 {
+            compatible = "fsl,imx25-gcq";
+            reg = <0x50030800 0x60>;
+            interrupts = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
deleted file mode 100644
index b0350528699764c49e388362aaceb2311e9ec57e..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Freescale MX25 ADC/TSC MultiFunction Device (MFD)
-
-This device combines two general purpose conversion queues one used for general
-ADC and the other used for touchscreens.
-
-Required properties:
- - compatible:			Should be "fsl,imx25-tsadc".
- - reg:				Start address and size of the memory area of
- 					the device
- - interrupts:			Interrupt for this device
-					(See: ../interrupt-controller/interrupts.txt)
- - clocks:			An 'ipg' clock (See: ../clock/clock-bindings.txt)
- - interrupt-controller:	This device is an interrupt controller. It
-   					controls the interrupts of both
-					conversion queues.
- - #interrupt-cells:		Should be '<1>'.
- - #address-cells:		Should be '<1>'.
- - #size-cells:			Should be '<1>'.
-
-This device includes two conversion queues which can be added as subnodes.
-The first queue is for the touchscreen, the second for general purpose ADC.
-
-Example:
-	tscadc: tscadc@50030000 {
-		compatible = "fsl,imx25-tsadc";
-		reg = <0x50030000 0xc>;
-		interrupts = <46>;
-		clocks = <&clks 119>;
-		clock-names = "ipg";
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		tsc: tcq@50030400 {
-			compatible = "fsl,imx25-tcq";
-			reg = <0x50030400 0x60>;
-			...
-		};
-
-		adc: gcq@50030800 {
-			compatible = "fsl,imx25-gcq";
-			reg = <0x50030800 0x60>;
-			...
-		};
-	};

-- 
2.43.0

