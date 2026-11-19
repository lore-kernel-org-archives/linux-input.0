Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104469;
	b=L91m5yYZMlZej8jJghVm9OroFlyOAdxOlCxmwpK9hwoOhMnc4IgcZjfBsc3u4h+NkBfW
	 Jotvme1FVikfGScD0pL1HePrJqNEqT4T//2c60M+Tp2Pe2IsWRhle6on4u0ZVmOy5erf/
	 s6+T8loxXykBMoQ2YLFolHCrJ14kza5FMho8U1LwcCwA7CgNpUlteOHeA1UjNcniMc1Yc
	 m64Zro3yrF/QU2wAdoKjJI0WFHhws1hKhPyUmc62wipN/p3oBimGPAONmUUTIa9TWKSzD
	 qKypLOcEeuNijVRcrP+rKCYDi0/e27CRQkk9rdK34kd+1fJB29QA9sDNIAef076TePA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104469;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=w5wY7B4wxU+WJsr8t/SuFNdKrrVXmbRrJzqkurHNsuc=;
	b=UpBfrPO9XEBJ+7s3G5s0wBZkvi8cZJwIxyO+gmIz17QeXigVUnBg0BJjn/c7vd3o8e2T
	 wiXfaJk8f/d4uRnOW2/Up7a0RBQrohMFtBr+hmFysEG24w5KxBRGAwpfSbIpiyX1kOVr4
	 J2aGl6r13Qt4wm/Zf6MTEeio3PGjstkrG2Db20i0j4XIykAglHQzH8+7Eud30L3Cwt02i
	 plmTUxpJQyC9ET0LwMknCF9a/FS/+1MZhUy+8TIHYGO+M/x8V/F4WtpN0XrTMEGyqytYY
	 SdxhWA9iYUq6iq7E1T1Fjux54gzuzFjhcdd8V6bWxGpYqIHwx5Dr617XS3Zhlg9CkPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BYJiTg4t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.25
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AF606A32C;
	Thu, 19 Nov 2026 16:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C72AF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BYJiTg4t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h76aFVNBcOnN85LwCjE0I8Qhx+/+cttHWnGB/SXcRMppsgrHmniea/UQWCilWPOd8FzYmsJ8BQfe5uJkvBZchjCuYZoWifFOz5C/KQ1/2HyIO3TmP8ge2xJZbkxWKFjXyMXjpWwV/OgNidqs62F/i7laO1FeV/+Cx7J3vpd9JRkc779CrqZZEVGBjD/V6+wgtMKyspjDhdbxi4+5kw3dsytNTPyUB5gjK+4omyEGGENuoOwLJVACZtPHmfBxIi/mq8Q15FkHoe+NNoOJj3WpkSeW4A+nSny3vX8FeE/UDXP/V6SVx68tnE+NFBLAfB/Q3QC8yoTdzq2KsXZQRIITlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5wY7B4wxU+WJsr8t/SuFNdKrrVXmbRrJzqkurHNsuc=;
 b=Do6eebfiWD5gxcGG9wWkLhGU8rU5W+/+YVhAR9RwBma8SxyHCnTspqcwkzSQ5BnIE+kJWckoetgjeADdY1GdTr83WMiH3SyPZgRyFwQVcNGM7ILabI3/o+lticfME/oQoojhB8JGzSHKQWawts7byCosXfVpRXgBnHyHBKZurOS1Ud3/PggimLez3ct2i3kmNZw3TqnqLNmw4dq2y/+BEIvpfGile3b+37bCfnpkxSSv+KA/8aqVO3m05Jtehvx/N2UxpzmnlgYtM4iQtSLOfG1x1TWTyoB8mMCGWCftcBuTRbhvMUqL2Om6X4cgGDprdAxSEN8+iOImyTaXR8CzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5wY7B4wxU+WJsr8t/SuFNdKrrVXmbRrJzqkurHNsuc=;
 b=BYJiTg4tbfP7HdzZfjhl0n3jzXg2lZyPjR9uFXpVJaMkOAl+cj+A91xVCKmIim5lTyZRSVuezTFbxvltD2EnPB88KjWIP1gxyKH1aIHWS5BmdM7FVMsFiVAEGX8z5wuDB4UYjSyZ2wMh8+I6eRha52pAhA+00weaOCuk/AXMJUDxftutrIEhTrz+k5KeLiIqLij0+C+KAODLrE1htjOcgc4P4lY2sHY7VtmeoEFgtgbggq25tUdQI6gb+j++fKg/KeGoaINZR0f4g3y71pgJ2atNTav02ncculkHq7Qe2Ks8sn94EdwJBOEnURmhuudjzWaC1S/bkc1Pvp4DHWg/hQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV4PR04MB601625.eurprd04.prod.outlook.com (2603:10a6:150:411::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:07:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:07:43 +0000
Date: Thu, 19 Nov 2026 10:07:34 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Message-ID: <av8exqpGDbMhDnzK@SMW015318>
References: <20261119134041.16611-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
X-ClientProxiedBy: PH7P220CA0154.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::35) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV4PR04MB601625:EE_
X-MS-Office365-Filtering-Correlation-Id: 763b5f65-96e2-4cc1-f30d-08df46573e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|56012099006|11063799006|261021121427099003|261021123027099003|10067099003|261102123227099003|261009223027099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GGXVZV/3sX7ouLS0cTpSWxFPA2glNB15InfuxG8bvYIu8114N3lzGkgV/Si6G1aYNdA+wyvep6i46o0CaToZNpcbqFP1W+RFUkHm87XP/s+XsLDQmw1kTZTchJe5JqYJ3pmDidH5yffrfgER1sGlR7Chfy/vcFIwJvdmx4eD39k9hSlZxrQyyWUkAkpceU9qkD7gud2vVMeAmfvscDHGFuF7TwXqPUA3VN0qCZZL/UB1/HP7LZitLc/JYnGKNylAqdVGC2Iq6OvWt6d4Bv7LdWf9shNvFZRjYEYqdRj9kQjYJ8oPEN6WiNbtfy7rCuLMRGypYMwFRwOAAQbc31ZCtnvPIBUcFR+uJRke1KkhUp1ZusMfIHC+FIdNyaNDWb7izWCCae2lFJtESje+IPVh8Y6Hkz5iG8KTajFOrQaUw+DplcfJhh43MCcHxuhHtZxuKHgEehb2DOZuFeqsV8vtw2NuDXze+uuElFmGoTpfVxVrzCAn6oU6XBwUXWWrqxQLOpQp1sNaT/F9L09sJRnqzUfbvGsGPJuFKBrI8mcCoOCYYQyi1PevaS1G1BtuZKLjTHHEQk/MR83o85lD07IFBIIPL60TYS+Gkv7YUGUlOn6VtMZM2JCHYlrgWapoUol0Ehar/s7lcMMxybuNr6B187hA1m82wLW7Hi5s5uXwQhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261102123227099003)(261009223027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8k1+VZEA2+HQQ2E7ya1sQHfD2xR8HIlbNIOc+SBzC3DNio6uzd7l9qFihlaY?=
 =?us-ascii?Q?ID6IwVLKhQljxgaamio4P5Lx2xbfrnuZFMT2nnrj1jqYm3Ycb1P1cvvph6FE?=
 =?us-ascii?Q?XgAujF5y8h3i5chDinODdW8ULwzfdbcywY0vQIQZH8rOxXCrhWFn0p3zTL9Q?=
 =?us-ascii?Q?yYihADPKjf2GVmB0JIY1SvNVKsOqorIMzVRmb7emqcErn3rSVYjep143k0N3?=
 =?us-ascii?Q?ghJDFrRyvBt56ltnzmY0fFXrwL3YKBh8oYgeF8EHHmJp5PUQiRpKKMZ9BXOD?=
 =?us-ascii?Q?PybLssYPtkojKi+iIbkzC+Y7MGpbaDYrFUhF+B+qnUe0UNC+CeD573r+snaC?=
 =?us-ascii?Q?Rb7O7Aebm/882gONzlyLLMyAzx6TPNbJlBDn7rcBdVa20nm7TK68X3N6pc0V?=
 =?us-ascii?Q?43Kw7fFn6tG4qspJTiUKp+k1VHY0fITDzbN1EG+e4VWyK7RTPDAiMh5lFRUd?=
 =?us-ascii?Q?/whv2rcp2rKw7p9l9P12phVtbE1WbE0NgP8sY2ykkHMV+ZjcTqeTNtVgE1BP?=
 =?us-ascii?Q?4qrzfcMjqsnrFbv33gN7D7Utz3yvnfCbts9MvEQfS3I9hYsgdf2+2OYtK1CQ?=
 =?us-ascii?Q?3FZApF4abYNzZgiwsZd3UtGvFrLTABAm7AdZjAJ4P02WQ4usKjoov7O51swA?=
 =?us-ascii?Q?RL+i0hyxSKH0NwCdLdWL2aB7tlCTcAxV6BPzIr5HG9NPJMw46sSOif0nHPtD?=
 =?us-ascii?Q?0MRAl7cPvHA+jE9F6/Z34Hkw408OPx4qfBslD+SWuJ/9eQBsuNHRnvPxqSbT?=
 =?us-ascii?Q?AGMyVFXzi5xvhURCBScUkOMh2SayRAnfO9MGqhKrqN+sWPzpoHmA9N/1lJA0?=
 =?us-ascii?Q?dAEnft55VijeZMduFd0e20DmbWuKFmQ4kQaAKp0N040tMFaN6a0sX5SyTs9W?=
 =?us-ascii?Q?bTbLWB62DPbw6xunqVqh3G95QuZyZuVKKIG/8BUgY18l1uiLKh2n3wGOvv5M?=
 =?us-ascii?Q?1RCo1HgAZhXEkr03CIrvbEEIfvUknGRA8P0OpKbnIqzPnbScPmx7xqd6tR8e?=
 =?us-ascii?Q?vEuMUdS8ExiY+fcHja6FZWep8hx/Pz+Ya2093Elz6dOKMyAIploBmchYahg0?=
 =?us-ascii?Q?uKMvwXom108fPCwCIJKHjPY54/f91ikq1kuVnD07aEQa4WAnKo3johTmiU+m?=
 =?us-ascii?Q?BUCjrm9IUC3zZzx1w4pviXpenc8o0RyU05SnV+yFzEZiidOwnALo9I+y2HVF?=
 =?us-ascii?Q?9qjR3bYSLmaO2iU6CgUyIObsa5/20QOIR7c6kSChgAqeGQjOqh6x1fOedptF?=
 =?us-ascii?Q?OO3w9oaGxDqpHc6UCrX1LZGt7jMeeDv4qf+GIOp8vLGtpZX1RQjAFyphw6ja?=
 =?us-ascii?Q?mnYoBglnz2zZ0dt0diKLhK/oirN2fcSIdn8HI8rleyER+cs7tMMAqfyXvCE6?=
 =?us-ascii?Q?70Adc8hx++qZZGwjl4bdtKr22cBA4gcs2JIpD3/h5YkdV95QIny0yECgQE9c?=
 =?us-ascii?Q?1W03G6kS6i2l5oKNA38rg6qWOpT5U+L6piQyCZb8dhBBW6Sr8vby7Lri8Ky9?=
 =?us-ascii?Q?gugyIjKi3Wkjz5WXA0C6EtmuAD+8/MXVogct/BrqwB16X+3Lz13Yyx7xvlzL?=
 =?us-ascii?Q?rm7qJfrxuVpvRNMVH2jC6q7UABq/+eNEbiKRNSBNzg+HL60OH4f9Nwfx7/HA?=
 =?us-ascii?Q?1q9EG8aHjSJxh9W/SH8ccJ4N6xgIGt+cqW0FGrFjwj3WExEhz6x9X88E03wG?=
 =?us-ascii?Q?2GUFPKZejq2an55gdS4GU2p85ABX5YDYpIh8RozljlGGqbqVETJANd+troyB?=
 =?us-ascii?Q?Xw0Me+xgW9xn4iAqEY2/HVBcPOfQcma0zwYlkbXEkH38EgGP+FDR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b5f65-96e2-4cc1-f30d-08df46573e94
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:07:43.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYXxmjZwEYMej+spqDx+TG8wFVDDHzgPmrY0LZ0ybSzQ/M2Ybdzm9U64LWyCqZErxI1skMeD4HTiliKZ5uwQ+5/4KUMLGwCEhgg9bKyPyO3S9TRLhSQN72w8iuYehgZj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB601625

On Thu, Nov 19, 2026 at 10:40:38AM -0300, Fabio Estevam wrote:
> The interrupt descriptions added during the conversion to YAML do not
> match the ICOLL source numbers used by the existing DTS files.
>
> For i.MX23, Table 5-1 of the reference manual maps source 36 to touch
> detection and sources 37 through 44 to channels 0 through 7. The DTS
> lists these sources in that order.
>
> For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
> 15 to the threshold interrupts, sources 16 through 23 to channels 0
> through 7, and sources 24 and 25 to buttons 0 and 1. The DTS also lists
> these sources in that order.
>
> Reorder the schema descriptions to match the hardware documentation and
> the existing DT ABI.
>
> This change was prepared with assistance from OpenAI Codex, which was
> used to compare the binding with the reference manuals, existing DTS,
> and driver ordering.
>
> Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes since v4:
> - None.
>
>  Documentation/devicetree/bindings/mfd/mxs-lradc.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> index 782b2f4005a0..755029880677 100644
> --- a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
> @@ -87,13 +87,13 @@ then:
>    properties:
>      interrupts:
>        items:
> +        - description: touchscreen
>          - description: channel 0
>          - description: channel 1
>          - description: channel 2
>          - description: channel 3
>          - description: channel 4
>          - description: channel 5
> -        - description: touchscreen
>          - description: channel 6
>          - description: channel 7
>      fsl,lradc-touchscreen-wires:
> @@ -102,6 +102,7 @@ else:
>    properties:
>      interrupts:
>        items:
> +        - description: touchscreen
>          - description: threshold 0
>          - description: threshold 1
>          - description: channel 0
> @@ -110,11 +111,10 @@ else:
>          - description: channel 3
>          - description: channel 4
>          - description: channel 5
> -        - description: button 0
> -        - description: button 1
> -        - description: touchscreen
>          - description: channel 6
>          - description: channel 7
> +        - description: button 0
> +        - description: button 1
>
>  additionalProperties: false
>
> --
> 2.43.0
>
>
