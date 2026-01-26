Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FF33B6FD
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445548; cv=none; b=brIMAjYJmIOn/lqASe4XCIxA6FFE6cYKubCixTpQH0S9ucyfYZKfBVRp9HNHMfqZGNyIJGIaX15ZHWCaslQs4dO+DcZSDKokjBJM2021nQsBfKAxIjK01Q0AIfns6OHLm0sL71n33XBYbjkN7/ytzyZoDr2CbWpHDSqYudJfyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445548; c=relaxed/simple;
	bh=qU9hjkq02RMfBGJ2ZqhX7fSjNIf1NBEX8j93ChbZpvE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=KOmkoAPFQN94QWv5eBFI/Q9gdDnmgPLKQURxKnL6+nj7dJCnKp93Jxt8C67uohwYGNSOG6hluBLgxO3gyTAXteg+1IcWb8wVuzAFtvei3RoV7OaP8Maxs6dsKF8jWz+EHj4w/DMpVj3B0OBspu3Gr7l1UzTAyGQMsI2L9cOhMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022082.outbound.protection.outlook.com [52.101.101.82])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-187-Xl0D4wSxOoSLBKuHw1ZDCw-2; Mon,
 26 Jan 2026 16:38:58 +0000
X-MC-Unique: Xl0D4wSxOoSLBKuHw1ZDCw-2
X-Mimecast-MFC-AGG-ID: Xl0D4wSxOoSLBKuHw1ZDCw_1769445537
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO2P123MB3824.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:12d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Mon, 26 Jan 2026 16:38:54 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:38:54 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
Date: Mon, 26 Jan 2026 16:38:23 +0000
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: add TouchNetix aXiom
 device tree
Message-Id: <20260126-axiom-driver-submission3-v1-1-d462c4a608e3@touchnetix.com>
References: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
In-Reply-To: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Thomas <andrew.thomas@touchnetix.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769445534; l=2763;
 i=andrew.thomas@touchnetix.com; s=20260126; h=from:subject:message-id;
 bh=UJ2CZxwm3skLzsg4d1bbLkCekiBEDSRN6CMUdDhOWyU=;
 b=RRmsHjtWMk+oJrEAw0oljoBlOWzbkAQK2Pu66f4LjtVVReFJ1pFaQflg2T0K0MGsCCtlhseJL
 bsMUnUA13Q1CLvPBvw7WS4IXoiB2YoM8MRGu08DkXlCFxQJ7IsUydgN
X-Developer-Key: i=andrew.thomas@touchnetix.com; a=ed25519;
 pk=GtS7O+T7kMl4PPu344KeKG2xlsaHEzDUFLtOqb5JPPg=
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:e9::9)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_|LO2P123MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6841690b-d196-4e9a-48ca-08de5cf964b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVdJZDNqUEFjT3VTR3VTUS95dnN5RHFUY0gxeXdUYmtOZnB5Mko2em9uak0r?=
 =?utf-8?B?YU5aaHVJVXlRZzhaYUlFcHhuUUlscHlKdmFQS2NmTEE1QjZpS3V1eFJVU0hu?=
 =?utf-8?B?REd5a3BUMGNZaW1pemZKdG16L1BUbXZIb2ppNjgxYWtibk8xWGJmMy9ZVmNn?=
 =?utf-8?B?RzUxOSttZTZVUDdKQnVMVFNzbUdzZzBjQkVRSUVIZHZ4MjE3YlV5SVlQQ0Vz?=
 =?utf-8?B?TzR6WmZCc0E5SkMyOUZYbDBSY1owSW5jNTl1MEhkdUh4WGxGUjljNW1yQjRa?=
 =?utf-8?B?TjdTN0t0RnpQdTZldXdGVTZEaVBDNHJWTGZDZ2twUHhCdlByTVUxaG5QTm9E?=
 =?utf-8?B?MWlNRFhCa0V0MEp4a0F5b3BQaVc2dE52TU90NVF2TzNxNkdwd3FlVGswSXp4?=
 =?utf-8?B?d3I1ekl2YTJNWnRZTkdCKzZFMTlybFRMVjFra0VKNHJEdWRVN1U5YXJpZTV4?=
 =?utf-8?B?OUhjQnF2MzgvTysyV3d4cmhEQVNLcU0zb2hobHRrTEl1Y3Bzd3lmTjJISVNt?=
 =?utf-8?B?RzJZeFhCMkxqWVdnNGJuSDJaRFViOWkrYzNMUnBPYWRaYWpCUndoVnIzZ3NT?=
 =?utf-8?B?cjRxR0tMU3FhRE1va1ZCODlMcnR5Um9vb25nQVdQOXJKQkYwL3VLR29lN2JO?=
 =?utf-8?B?SXZYMTFySS9meWQ0NWZ3Qk5KT2NRWFRic2NUcWxiRG9hemtyc0cxV2ExR2pl?=
 =?utf-8?B?Q1lJRmhEV1V5a2Mra1Q1WG1mNW1BN01hbmNia1JzRUcyTThGWGtLZGFHbEVx?=
 =?utf-8?B?YUxkSHExL2ZpYXZMN2pyUVp5aFc1UllzbzV2ZXpsejVBeEkxUmpvWE9ieEdj?=
 =?utf-8?B?d0V5dXFaSC9mZTVkZUNxdEZSdVNIM2NBOHc3aDdQTXVrRERLemlEd1U2enVF?=
 =?utf-8?B?V0tnMXdIR21sSngrdUYrUktnVHJHNWNxdVhWVlJ5dU00TkFPNnNUL0lyVmhh?=
 =?utf-8?B?bk9nTitVMmUyVUc0ZUFGaTcvOWFEM0REdnFFamZ5Q0FESFhlV1J3L0I0V0VE?=
 =?utf-8?B?MFQ2dVRpU3JaQ0tUeUh5MEdsUlJ1UUhETTFvYVl3bHNSeVM4by9Td2N3RE1o?=
 =?utf-8?B?WEtuRFNUUm5DTldsR0Y3RXdldWV4Tm5yc1NjV2F4ZEY1Zk8xZDZMZDRNS01Q?=
 =?utf-8?B?cHhaZXpHWHhmcSttbXJwNVppMlducVdtSmhUTVNjNVc4TDhzelNzelVhRU5B?=
 =?utf-8?B?NjF3OUQ1ZnZlTFh3VThHOXBjNXE0QXh4TnVJS1d2UDNyNGNLWDJmWklnYmJn?=
 =?utf-8?B?Z3hydkhmNTRyeU8rblo0bGd1TU1Zei91VEFudDd6Mk9oRHhBTU9DMFB2clcw?=
 =?utf-8?B?U0NOWUhsNlpBaklpZkZVSy84STV6UlVxQXdNNEVaTUxONVIrUXZ3clZISDVn?=
 =?utf-8?B?V3MyS2lCdzR2TlU5SkFSYTZ3NkcvSDlOd3lkWVNuMzY5alo2dEc3MUlNV012?=
 =?utf-8?B?S0RiYmZ2MW5yMmZoc0FwMFBqVXlBM1h6Y1dwdndJZUEzVGJVN0VTTUVzNERS?=
 =?utf-8?B?ZjdjaGJmMWdtb2haekJMRE5wVG9vWjZBVkUvb21VUDhSenVPUlNrbktaQTF3?=
 =?utf-8?B?cm5zRFB5WHg4L0Z1N3p2NFhSY3RCc1ljTzQ0Yzh2eDRJSzE3cVg3MFY3RjNY?=
 =?utf-8?B?YzAxWDBXV1o5WnhPVm1EOFRtYm9uSW9HN1hZRWppa0RFRjQvSzJBbWZsejh5?=
 =?utf-8?B?cHQ2UjFUNHVEY2MyNjZVRXBIYXpFTG03QlYyYUxhaDV4OTFwNHJOZGZ1d3V0?=
 =?utf-8?B?NDJaS0I1OFdMb2U4LzlNUFhQNjJjOXp0cGM3WDN3ODRIUW9zdVcwTVRoRzlG?=
 =?utf-8?B?ZDlBNEs3RFg5cGVEUDRaRHl5NVdoZEJBRzhUcENZQzBzcEM5REk2UzFZamo2?=
 =?utf-8?B?dU10VEFRNVFCVGtDTnBUSXh2V2dUeUZ1T2lVem0yU0RXeE1sL1JHSEJQdkpN?=
 =?utf-8?B?WEpkNVJubTd1ZDdzTE9TbDI1cjdRQ0pwdDVIaThHMlhqMTNQK1QrejQwWUUz?=
 =?utf-8?B?Wmp0UHpKZ2xuZTA5L1JIVFlLK01LaVJQTFVJaUZUbzRhK29NbEwwMmN3MUZU?=
 =?utf-8?B?KzFuRVkrUEtlRzJBcVpQcU5jWnVCTmNCNUJINVpVUUVqbzFaRHY4VERLbUdh?=
 =?utf-8?Q?rn8Pj5zNjvuiTR/JXHd6t0rqg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9Cc2dHaURXclYvaDZiL3FkYWhEc0c5Zmg0NjI3UTAramRxbWM0eU5XaU1Z?=
 =?utf-8?B?ZE5xNjR2bUNQM214eWp5SCtxYllZTWUzR3ZZSHZMSlZXSFh6Um9tQXhTUUxh?=
 =?utf-8?B?M1EwRnJZaS8yMXd2ZVMvd09Hek05TC9rREg5c0pyRXQybzRTZEJqZ2k5K2Vh?=
 =?utf-8?B?em5MOXR2cmVnRVArL2tuRUc2VFp2eFNzWnVka0VmdXNMZUhoV2ZNTTdZZEU4?=
 =?utf-8?B?d3BVV3lMUlVXOW51OUZsNHdma0pHY0NMc05PQmNMT1oxdTR5NmFpZmlUZy90?=
 =?utf-8?B?ODdScHNoK25MVml2a1ZkTlh3M2RsSVdKTTUxOGwwcjBGRzBIUUdLdWVQUlJC?=
 =?utf-8?B?MC9MbVQ2S3FQZlVoQzhTbEljMHM5RUNpcU80b3pBbTdCNzN1SGU3RW9FbVAr?=
 =?utf-8?B?aDRBVysyVUVmTTJ5OFM2M1M3MHlFL0c1cTU2dVd4SWZBSWdNd3FWVWpSRDh3?=
 =?utf-8?B?UFlFUnFXanhiajJVSzNxenJDNkJCS0ZqTVlOMDdNM3JMMlNRZmZiSXU1cTRa?=
 =?utf-8?B?YjhCUklmYjhhcHJtRW5uN3M0K2ZLU0xocGNkYmxuMHRQMWlpWTA2Uy9LM2E3?=
 =?utf-8?B?TTJoMlZZdzZ6VmNpeERqOTVRS1RFKzg2YnRna3ptZkxSdjNJaFZjQlMwMkpx?=
 =?utf-8?B?cHVkbGpaOEhjQ2h3UDdya2FkNnFTcVJ1MW5YNjlqMGFpOU1JWGpKNUQyK2g5?=
 =?utf-8?B?YWFoR1FLYkVIdDhGdTh1Yi9ReHNtRk1XeUVXTjAwZytwcmoxMEpTamxsOXdV?=
 =?utf-8?B?ejZaQ3piK1d2TVFCSXRWMWFlMHNwMitEcXZSbEpGNWpvMGNhY01TaUpjYXBs?=
 =?utf-8?B?eG5lNjI4K2g0a1ZjZnM3QjM1RXpqQlRYcnE5cXFuL0xmbkdIcE9oUVJ5K3Vu?=
 =?utf-8?B?dFZSZi9JbkdXcjZHOEE4Tlp4b1RneWZCMUc3U3ZtYXNPTVNqdXNWK29FZTRn?=
 =?utf-8?B?VEVObUV6MDNraGFUblVMYy9yWlVsckIyeHhRZ0VZMlhpdTRpSC9vQnJhT09a?=
 =?utf-8?B?M1NoOExQdmN3QW9qQjVyZjc4eGppVDB6dHB6QzI2WmM2Y2JKcE5CaG5Pd29u?=
 =?utf-8?B?UW90RVJkNzNtbHdWbUE0NjNLM1hKdVE4VzBBZ01pSFVyQTVmK0M4Z2dTSHhS?=
 =?utf-8?B?eUF3M1pQdVFTdHJFaEhONVZ5R0daZG03R3ZnQjl6SGorRFNhMUVkVVN5bnJx?=
 =?utf-8?B?UG5rZDFYM2NPTWFZVktOVzh5NmRIN1VkVk5HdzQyUXhmMzkvYmpQOUF3dzIy?=
 =?utf-8?B?RmpVTXN4V0dTcDRiYTdIQSs4cmVzNU9uSzl2ZDljL29tNWFDTElNb2FsVEcx?=
 =?utf-8?B?NklwdEl5VUhzeHJmY3l1VmJSeW1TVmdQN1lqM2locGllQ2xSVk5DT1lVOEUy?=
 =?utf-8?B?NGw5ZitTNHE2OGlxVStLL0F2ZFVsMlRJcGRRbTVpOS93N3hZOUVueTlYenFu?=
 =?utf-8?B?TFVMSkg4NmY1SWVhTU9mVTMwd05tbnFIMDhheUxTTWlBcVBXSnBSMlhxck1v?=
 =?utf-8?B?YkJWYVE1MUZvamNDN0k0Mms4Tkh6Mm9DTXBzSmtGYlNnK2NaWDNVZlpPdDVF?=
 =?utf-8?B?R2JYbWl0L0VRdmxrWXdMRldaTnZJbjBCN2JDOXlaaTZLWjVtR2FpYXNkMjRW?=
 =?utf-8?B?OS9nbmN1cEYyRjkrOFdQWHBWVkJUeUMyT3g0V0IxdzZzNzFyQXBpWHk5V0pm?=
 =?utf-8?B?V05relArQUNYbnNHUmUxRGlvWGRzMHVwU1gzUURmR1pTZit2eHhUSlJSRFFx?=
 =?utf-8?B?VW4vNFFZQkVJL3hBVDRVYXFKdTlic09ZdU5RMFE0Nzd1THF0S1dCdjZlUWps?=
 =?utf-8?B?S1hLVkJ4d1Z4d2tnT2VtUllldFNrWjk2Tm1zVmdqbm96Y1RXWHJSeCthdi9X?=
 =?utf-8?B?RWQ3K3ZpNEsraFpxWVAybVE1b2dJa1Z0YlRtQTBMbkJmVlUwRDlqL1cxejQr?=
 =?utf-8?B?WDRuNWpIZHREckJkVGMxMWJSaDA3M3psSDBzd01CNWtDcVhWOUI5OFNSOVEy?=
 =?utf-8?B?Qk9LOENoc3cySFVLcy9aVnFIcTRwV2d3MXdJTmlhTWFOMFlwc0VLL2VTY0Vq?=
 =?utf-8?B?Vko5QmVKYW5DZ3BvTlpDRW1qbkI1WHEyajVtVFlFT2s4Y1BBc1FwTGlJS3BG?=
 =?utf-8?B?aGZCengxejhaZDhvN05ORkhkMjFOS0tNcVV3UnEvS0d3dkl3UHNzN1VpV2RW?=
 =?utf-8?B?bDVOZ1RBSU1RU1JzV0IzeGxjUElRVWpSM1RIOEY0WnRnZVdPeXVmWkVVaDhu?=
 =?utf-8?B?MmxqMGV0SlZLUlQwWUZHaWg4NDRaZjVxdzNSdkU0bENzWmtyUGtvYW5FK3Ni?=
 =?utf-8?B?d24rc24yMy9sTFEyeFAybVlOSDFYYUZrUzlqK1RUM0xXTjN2UkFBZ3ZtVVIv?=
 =?utf-8?Q?53ZwWHnZ3/BMKJCo=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6841690b-d196-4e9a-48ca-08de5cf964b6
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:38:54.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Dhxll5ZsLSPh5ENoaSuEhIhA6NHIqtxqpcryhAPVn3U1bwNE3Fu0IdDbJ04EfzV2JuIUsAnZ5Ep6OXD4J2+WWyYMDjsfQuFk0sGx1WRpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3824
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9azLi4ssrj6YXQMtbl1vropfJvgwfa7ot8D6NPWM2mw_1769445537
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

---
 .../bindings/input/touchscreen/tnx,axiom.yaml      | 70 ++++++++++++++++++=
++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 2 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.=
yaml b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
new file mode 100644
index 000000000000..7b532471c17f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/tnx,axiom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TouchNetix aXiom Touchscreen Controller
+
+maintainers:
+  - Andrew Thomas <andrew.thomas@touchnetix.com>
+
+description: |
+  The TouchNetix aXiom series are high-performance touchscreen controllers
+  supporting various interface methods including I2C and SPI.
+
+properties:
+  compatible:
+    enum:
+      - tnx,axiom
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Both IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING are sup=
ported
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchscreen@66 {
+            compatible =3D "tnx,axiom-i2c";
+            reg =3D <0x66>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <24 IRQ_TYPE_LEVEL_LOW>;
+            axiom,poll-enable;
+            axiom,poll-period =3D <15>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchscreen@0 {
+            compatible =3D "tnx,axiom-spi";
+            reg =3D <0>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <24 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..dadfc7036ed7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1636,6 +1636,8 @@ patternProperties:
     description: Trusted Logic Mobility
   "^tmt,.*":
     description: Tecon Microprocessor Technologies, LLC.
+  "^tnx,.*":
+    description: TouchNetix
   "^topeet,.*":
     description: Topeet
   "^topic,.*":

--=20
2.43.0

