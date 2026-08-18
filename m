Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94847D925;
	Tue, 18 Aug 2026 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070452; cv=fail; b=AEt+KK7Eq1ziVkI7Lc1hMVaYnwdBVOFU1r2sqy3yN9Jxvt7LL8Twq9vqjovbBFjJ8MMrkAHef98gz6Ukcyrhx4YorOcTpCIEG1nwxMK7RDNHg69Mdic+eJv0L2m12vzzbrLzIur/ngAKzQwrhydbcdkaKNGfra659O3fpm1Usx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070452; c=relaxed/simple;
	bh=8DrTE2AP0OWU9fkIx06lFLTWadloFdMOCfynK+NQpwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tTwk2iHWa3emCqpgGn3NfpCWCIB4SBdj6aGWXisSq8g2E0AN4dbbGunPAElTBZ3BbmfDbry5Dc4zJrQ2LdcemXQDM+nk0OhgeFGz3iavPELXVbGivsiMQiYdwI8/16sSenUVVnceXx+O4hX2NJU4ftULflJDnF6FojikL9TxAl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZjXkRYCI; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZjXkRYCI"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuVJD3725535;
	Tue, 18 Aug 2026 12:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=EvHr3OtHREQPxVo3/GnX+3+jJPF+U
	cvIpPkA/grF740=; b=ZjXkRYCIfkd2Rrc/H4ePCfL4zlnaO2dWSHAmZRnjbCpzr
	JhQ1n2VQmDFLSiFcZ1gnYUfBM3Dx3uWzgKXBm8GSksp2uS66rkn+cRaOQcx/350d
	rbCenkbIyG3EEmzU1RsYzP9WI9MgLrRU5sJAAxNuOSNVNw+luBBpyNojsgkbnoDV
	xgd28nqbz5yE/HcUSnsAVXlAE2/ycVEe6vcNuzlJ8SMolwgusPeAkdAx8khp9nn2
	RhjOBmsEMfyulleau32JyEwDEJngpBiI/7yxm+G3qShHKPZbPUhn3d/GNJGMjXF8
	wveStaSY41mnyParIiBcwWGRQCxypqY3b5Oj1AR/A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4nyr1q41-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:27:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlVIbI9wE5biG+TV08RXzmOYAbZli/N4PFgfLUfnYtLuXsLECZpEY5WQtj/BN9Om1MbsT4ueNkO4WcwnactRQHuPMErqQhcCuv5VmOlR2IR5m/Fy0Fdi4EdpiwHY/crZd2rN1RkyBcXNECLMcKMlpIXDFTYLKhund4bohA2iqF2qufQZhFJp4B5PAcHXyQVLXvR8f5cWFao+rJdqV5K1w4uoPrkUBuT2SW4+aEcsenxJfbMhXazP16T/DrqIwogfZcqijZOtfxuRqxiY8Efph2gsodrXjbNr9ikPR0qi+miIW1SEPZaLJln3AqkdcHogO9+mikxCFsD0PIfF9hC8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvHr3OtHREQPxVo3/GnX+3+jJPF+UcvIpPkA/grF740=;
 b=XPIe1FuBmfXQir1pLcCb5wBL+GKvPMSH1h7MdJ3EU9C5Hec/NSgOAqQTi6XTuBOImERQRIKmRuuxFjxOuSBLJXy2moxsTvGZHJ1EA2gcbYlkaEmXeHZU7NryWgb5NSpsDpIPRX3Ti2n1AhjFLfIQxnRE4tH4+7dBGJLg+1PnG1d5QRD+VKH8N4U4dr2fEi8eLIDszwB9yaIdTWa450dWFhsqKGdl5T8FVWbB9BBGTbXAu81bjPjjxHwuq4Lc8IGpqX8/qsiYeBo+DMcurh4jeHx2d4A2+FXw+gQOdpqefDwQ+o/Q9VZ38w0cjYUBaHfm2U62aROX19FFziS3qJjk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by DS1PR03MB7989.namprd03.prod.outlook.com (2603:10b6:8:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:27:24 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%3]) with mapi id 15.21.0315.014; Tue, 18 Aug 2026
 16:27:24 +0000
Date: Tue, 18 Aug 2026 18:27:21 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Input: adp5588-keys - cache GPIO state before
 registering the gpiochip
Message-ID: <aoSFhKxPk-QPv2EQ@analog.com>
References: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
 <20260818161119.E25A31F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818161119.E25A31F00A3A@smtp.kernel.org>
X-ClientProxiedBy: CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::15) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|DS1PR03MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b63ca8d-be4d-4c38-63ea-08defd45961b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	tS7bg3FbvGlsAUlhFjCiEQMfnm0rZQy+E0toUFzPLG/6DXcsfRuvyHkv9o7AKpdOeO43UwG5S52JIqMW8ONC4tL80LT/eLz4hgbleHniKhiK5d5foBTtKMOV7UtNtSibfQ8rhXZ+3KDI2DRfsDFTUtfIOR1aLv4/0OaXMKqZ5U4a2jWE5j7FYURbDqpdmJl5cQFRglDNeQP/tC0yOhXCKilwhL0xrjikXDp7qc16/uhCsp+swr2PZqrALCG1QC22Nt3kssZp5RNfVNt2RgWYSzrEpXMimNjfHW69957KYiNqAClRCjIrdLabLn8VH6SBOFwceZDU4Zotxcs787gbRbqGflpuBubilhJOdOH7YIxckiX0VFn4ctaTuv1HNPjNNrQemswEUNDIR8iaBsdYAr0rSmcymNdSuilCLKyg3i9mYZzeASH5kt6lX/6w7FZ1473ARuu7wBWdM7znXQoDGP72D6HDO1GAOg/LAGosPXMLPoi2ObJkTkvsKku+52/YDjWTzZV+wL1AlaaLv0N8ChVoewWxA5zcwYz9ybAkA6E2xkTAgUJ66r7ME0/qAJHI56pv/wyFYuwiYNTChGP2Xn25Kx12QZE96AY4kCSDvUbxSx3C8o3o1L21S5LVmoE9ZQaTmYaItN1tNYgoJD4euvp9qy5MqcnAl7nekGq+s50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0x1MnRuYWt1UzVhYk0zc0hHT3dURWpjOGZ0a1NnczZXbFNsUXdBcXFMT1hL?=
 =?utf-8?B?KytrS0x0NWlGWk1lRWsxTzFPSTRnWEJqOEYvZkttMVVwdXRvc3A2ZVBQQy8r?=
 =?utf-8?B?akZ5dWRIMkZvNkxiM2lWcGtabjBCbkw3NGVmZFllRFdvY2ZTbis4NW1vcVla?=
 =?utf-8?B?M1hFWUhoTnFoZWV0dmhuNkIzczN2ZUw4UFZYWGprcDVyV0JZUFRXeDNTSWRX?=
 =?utf-8?B?Sk9UZzdiZmdNRU5XK2xRWFZ5NXowdHo4cEVUTCtUc1JyWXhKbGNWczBIeEFL?=
 =?utf-8?B?OE5IbmQ5STJPQjJTRDROVmd0SmZQQ3ZubGl6NHlBSkx1S3g4OVpZUzNBdEQ4?=
 =?utf-8?B?Y0paZjZKbzBaSnJ4Tlo5bllJTWtqb2F6bktsUCtzdlpKUml6Mk0wOCtYWVVY?=
 =?utf-8?B?dWo5S04vcFRpeUxCWWJuUzRIZUxkcG8vTTA2dVlhNWRGV1FkZ3d1VUVkUFZY?=
 =?utf-8?B?cEhXSXZHVjJLZ2MxWjJUdmYrTnZBRHVyVWdoOHR3SUJWT1MwU2JCenVrcDFG?=
 =?utf-8?B?ZmVJQmJ6OXJ1aTFGS3hwbk9BZjh3L0MxZCtBWHBtSUE4cGFWQUJsa0lIc1dH?=
 =?utf-8?B?clpwWGxIQzNPT0trNTdzcnNLYjNPMy9BK0JveWdzZEVLYW1PY3gxWUxsRkZn?=
 =?utf-8?B?WXhwb3V4MWFqWHM3WitoalpGRitHS01ORmZWcENQM1UrbS9ua2M5STBzOGZu?=
 =?utf-8?B?eHltRGJnOEgwY3ppSzYrS3ZRZ3BtaEpzckk0R2l5b1hLUVlpQWhQczYrNmMx?=
 =?utf-8?B?Z0lBMEt4bDBxZ1NZSklzU3pUTnp0aUFKdW9rL0ErY21OVWlVOVBoN3FOeXl3?=
 =?utf-8?B?VlBlMWN4QmJYdlQ2STdNMFpscE1YVTBRVEdiUncvQUcrVGVBU3FvV2gyckF5?=
 =?utf-8?B?UEJ2UTZ6OGUwREd5ZG8yQVJDM0U1RERRb0llbDY3TVdCM3cyMitEcWh2TWtt?=
 =?utf-8?B?bWcxK2k3YzRZNzNrLzZlOU4xTkozVE9jWmY0U1N0WExoWm5WV1FCK3Z5WEtu?=
 =?utf-8?B?NWxDcVY5T0VrUVZERmoxSnRxQXNWMzZROUhPcUtXTTc5MkNRaG5xTThma1ZO?=
 =?utf-8?B?cVRhNHBwSGNwakxsMWM2OFg5MDN3S2cwZ2NUWGtBMW5aL0NLSS84cEVqejBK?=
 =?utf-8?B?QzV4VzNPeFNEcG9udnN4ZmhIYTNkVFJpRUNqWDFKR0JnRE9nUWlaNFIvajZM?=
 =?utf-8?B?dFhoTmc1YkViQVFPeXFLRCtFYW1Qek1aUDFScHdQVnBEeEJuSlJWV1ZHVERL?=
 =?utf-8?B?aWZtK3k3dFV2ZGgxOTNHTTh3QWNjWndSMW5za0hIUnVFSTl2NHZGQTR5M1du?=
 =?utf-8?B?NHltaXRza2tZTU9WNzVreXZnUG9wTHJSRFc5VEpONTA3bUZkcy82V1Y5YVUv?=
 =?utf-8?B?UW5JTDg1T2ZEeHdPK0NXNVN1NWFwYlUzWDdNZHpiUlpIZGxqd05wM1RaVy9E?=
 =?utf-8?B?K2tJWVd5aTB3RTZUZk1SakpEVlMvOUVIeEtSMUlMVXhkcXVxcFVtdFZZV1lp?=
 =?utf-8?B?Yk5jdVVFZDF6dVdlZ21Jams1VWt2SG5SaU5Fc3NseU5HQ3gyamVEbnhoMlZp?=
 =?utf-8?B?ZDFzUGx0STdWaWFpYlRmaTl2cUY4RGdNTUFQMzUwMldEQnRyR0Z1MHNCRGwv?=
 =?utf-8?B?Y05FcmFjY3R6eW55ck4vcHBPanZpM1UvQ0dIdDMyVkQyWFd0UVFmYzVZWDZL?=
 =?utf-8?B?L3o5TDdPWFI3MHRWV2pjVC94bzJnQXNRWDBtWWFpckFldmU4TTJVTEw4LzYx?=
 =?utf-8?B?VVJFQmVKcDhvazEzVUNId3hObnZpU2Rxbk0wMDJNYTM2bUE2OEhXSjZycnh0?=
 =?utf-8?B?SXB5R2o5UkNqNzFCSGUvVWE0Z3c4bWFsS1E2SUc5TU5xRmpRUlhQNE5UK3JO?=
 =?utf-8?B?aUxid0JKYWVHZlAxZWwvTklHN25vcG9aa2xubUVjS3dCUzVORG0rbTJzc1FD?=
 =?utf-8?B?dWZ3c2Nvb0dEVVo5Tnp4RkNTVll3MjFuM1VncUNLcUN1cFR2K0p5eEVMTTdq?=
 =?utf-8?B?UkF2dmxSdEdubWlMTlBoaWk5YXpPcUNxZkx2V1hiZzc0SFhOU0cyNmduaXl3?=
 =?utf-8?B?REtXbDVNYnVTd1pXUThVbG1WR094U1duYWRkVEFWTmVmUnE3THRMM1E5azNH?=
 =?utf-8?B?ZytDZ1oxN1B6VCtwcGJ5MEZuVFNwQ1Vubk1JOVNBM0svMXRSaXJEM3RvZ2dn?=
 =?utf-8?B?MmtEYUVERUNpQXpZdThzS0thT3d3Unc4bGdRVEJMUzdOZWx3Q3ZKb0R0MkhM?=
 =?utf-8?B?T1EvaFovdW5QN0VVV203dGpFbDVtNEF4QUZEM2djWnZReStlZmtRaVA4akNy?=
 =?utf-8?B?eUdhTi95Y082UDQzQ1pGcjlHamVmcHJNQTB3TDFiVC8yRmJRc245bENJckg0?=
 =?utf-8?Q?PqeOtf5lQTMWJ2Go=3D?=
X-Exchange-RoutingPolicyChecked:
	rf63PMpvxW3G/L2IyXFimWqacJKHaIMfNTcuwTevFYTHI7gVGxJZpaOeRTNYV946w9kOtGaT6Hx+4iMNAJy9eOz9PP3spoD3QyQniUuP0TFFTTQ2XoIwZKf6MFlL4Zt81njOHZwqpyQkTMSXkU/wq5wYYLs+mxMtp/qY0itvDrjpGjqU8ZPW6e1ohUMTfRb5bZuKtQVwZfUnuIjFUW5T9oJ1XYDRy/YCQDFLx3NugHu/V3bIl17fMFuCW9vUNlpYpuAlBprKj/6wqKg6MN+QjtvSH12+9aumOvy+TT6GNHjxxUihSTN0TftqQ9PQdRDE3YF+0J8gn6bV7wVW7ODlrQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b63ca8d-be4d-4c38-63ea-08defd45961b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:27:24.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV/5K5/UsiuAAUNFrc7e8b7YxF9SfITZ+7UeAuzcNStL1nODFOjU3wK9n4qjiOvnAZSFIihgIVX0x01mKxsKCZtHk2NRWBdGruWyqGraVhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7989
X-Proofpoint-GUID: ykuyBoBsWoXAGX8vJATWTyZMvA5ZZpxa
X-Proofpoint-ORIG-GUID: ykuyBoBsWoXAGX8vJATWTyZMvA5ZZpxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMSBTYWx0ZWRfX/SBbwsuGWriu
 IRGKLzezMRD03pcE4aUsSiAtsWEceiFHUYxupB30rN2mX/KjtM5VXODgLXAgDnow/f1lfWItJ6l
 kBQ4LXzmB+aqdBetWwB5FhOmEUdEgWGDXVE6V1ZWmRu8w0pMSFBKG/Jd9OVMfedcvPgc38QYCVa
 wmTVh2n3I8+4r7IRRaLqdI8ATtt0kUyNu+gnLpe+uMRb10M07hZmqXkWndtv9sRkTm1WHa8hdxz
 qt9L+FLCveLUKWp/5RXCLmQ5BVxLOE4WBwJkLvjAyb1m5SsKvJqo1UccJqcfwjvkALNuHeiiSci
 S84aX0dpdY+EgJattaKx8kNtLO827KqU0+JPnqiiMw+yZ+X4Q1LFYWOEdhqUWPWJqu4q1FZnVhe
 etVvMlv6J5FSStEzSHRU8KIFL9h9ah9tgamVxoSuUtED9CaF5nhTUnW5+2s1GGB7pPt6u9dEPec
 B2Wzmu8oZrP0t7hgnbg==
X-Authority-Analysis: v=2.4 cv=ZITnX37b c=1 sm=1 tr=0 ts=6a8487f0 cx=c_pps
 a=wFYUR1nkr81kUUYKqjx/LQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=3WthbB7VbCXhtRywDn8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMSBTYWx0ZWRfX3295YyOQM2vg
 m3bFvOIpsvDVgJ8P9funqevcqbgQh9Ti1cjvrNJWGMK8PM1kiUpyKAnhMQsdwBkxGn9MjiW+u+N
 muYwtTh9sEmZZekqYHovCohsWNjw8zSiHjngq0+cXLUWwEsLjVbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180121

Thanks for your review sashiko-bot,

On Tue, Aug 18, 2026 at 04:11:19PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but this patch actively
> exacerbates the consequences of a pre-existing issue with missing error
> handling on I2C reads. 
> 
> If adp5588_read() fails due to a bus fault, it returns a negative error
> code (e.g., -EIO). In adp5588_gpio_add(), these negative values are
> silently truncated to 8-bit unsigned values and stored in the driver's
> cached GPIO state (dat_out, dir, pull_dis). 
> 
> Because this patch moves this caching to occur before 
> devm_gpiochip_add_data(), when a GPIO hog is subsequently applied, the
> driver inadvertently clobbers the real hardware state by writing back this
> error-corrupted cache. Can this actively undermine the patch's stated goal
> of preserving bootloader GPIO configurations if an I2C read fails during
> probe?

If the reads fail, I would not expect the driver to behave properly at
all - neither before nor after this patch. It's true that this patch
might trade some broken behavior for another type of broken behavior
though. But only on systems where I2C reads are failing.

If the argument is that such a trade can be considered a regression, I
would point out that the suggestion here - to add error checking and to
fail probe on bus errors - would invariably cause probe failure on such
systems with buggy I2C reads. That's also a regression.

> Additionally, this same missing error check causes severe issues elsewhere.
> In adp5588_report_events(), the error is bitwise-ANDed with KEY_EV_MASK, 
> resulting in an invalid, large key value. This yields a calculated code
> index that exceeds the bounds of the kpad->keycode array, causing an
> out-of-bounds heap read and leaking phantom key presses to userspace. 
> 
> Finally, in adp5588_gpio_get_value(), a negative error code evaluates to
> true, incorrectly reporting the pin state as HIGH.
> 
> Would it be appropriate to add proper error checking to adp5588_read() or
> its callers to prevent state corruption and out-of-bounds memory access
> during I2C faults?

Sure the driver can be improved by adding error checking, but that would
be a much larger change. I hope that is not an impediment to getting
this particular issue fixed.

Alvin
