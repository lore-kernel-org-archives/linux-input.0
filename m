Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012013.outbound.protection.outlook.com [52.103.14.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9F381EBD;
	Sat,  1 Aug 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594746; cv=fail; b=uBSs1cxBZma6onZDqWep1BAtTUXCgg6/10OTpYTy7ioXksIEXMFGVEZi1uWOGjBA1wZIRtbQlQxdmTUphAWZLdvprDSU1sgpi3VMZMb4pAtkw+F/pCa/9ihSUGG3DUUnCfYaeDPY+nfsd2GbaPmL8zMQfdCSdz88l9Kc3IZWj80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594746; c=relaxed/simple;
	bh=1kizPxBgR5DZ9Bn8d0WcwRuSFLIoFLjtwY5CNoHgb1U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SCEPHkecTUUFeX2I4jyg2ormwUVMcerq9CbB3R2aI3XL317FwposM0jo5pBsdcCG1mOs3q+WJ3LS2nV1a7NLQfVRLJUyYtiP+yBDuIHtmgmBgV6yAdQJT2XOK05jbFORYJ02iln8LgClx2PpEPyLU2ouJocJQLYpTObRHzfChTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=twHKDwl/; arc=fail smtp.client-ip=52.103.14.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="twHKDwl/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3VsUcv6iX8sONTBzrDIryZDS6zzIMBdMNQJ3vK/NL3GSi6BYXV+UTD6SAM7X3ovbyniAuj4zzuXkzG4KEzOgdlqBPC72U/op/fRSZSo1k5q7zrMDyJ+RDSQuOJwvRm5DQ/GEv7pBJXKerUUL2MwJUxhYp0ICWETR7zP9mbvQwwPkHKAraAtbfUb5w8O+G58wZoqly5OFdmXbpnvQU3rGfbQ1UQE3GU3612Uzwel8dquI5MJF5onGGtlq5KbjEteoVpbh5jhTEd7KLgu+zmRnpwM3ArYZEXEataMI/VyEX6FUG6DoU/QNqcr1oSWeC8LhX07u7b2RGAucszwGMqD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kizPxBgR5DZ9Bn8d0WcwRuSFLIoFLjtwY5CNoHgb1U=;
 b=i2kpDvTkvr9nb6/KyaR7R5YnVDoRLMJKN3gCKE5k3odnACAdgAdqFJvEwcMR2YZpqfHwjOj5uT+4mLUsqGBHkA3GnKANcf479pOQ3nNyziz8giST1jKMYxB6WfzohUh3Q2IjL3lvhSLnVuhvOZGMMAj0OGRDgfGUs3xa6TqTYtFrogHkGDjpYwtb8+0Vg8YBYe+apkhojt8JtUxvkgjC52Y2c5DFjdDpMbPt51+kTOL2oc17THI1SsRkQycKsB1ynT6eq9V4ALIgguM4H6cw71LzSE2aJRhIW33GLRcIzVb5NOjL1hmt98gWA6AN1iHxDDAcLczPYrgWuTLHbHxaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kizPxBgR5DZ9Bn8d0WcwRuSFLIoFLjtwY5CNoHgb1U=;
 b=twHKDwl/iwG8PmqsVIMfSNcvoeRV7u9Ry6C+xBOkc83C1DtZLDxQ1UkAPZZYwyhBpqlj9D70IdKM/8Wg+H7mEiW4djiEJSMRQTBn6uSSzwrOzasfX3okaCmER4WbBgGyXTrxWJXTyTVUNT0FVNScV0TJ9RKvbNtie2z73hzAINO8sfqTZJArPnBFSKz5P9a42WfkfZfQ32f32iwsCZe3zgzE0299ppO0CI20sCt3Rr6DM7X/BErOMQ7FlHLC5i5DZiVpuKnm+0sDD3Tp5rYqCU6rggxBr9NFP/hAlCQXMnn8KRFSnt0FhIH1PlaqJapgo0DpUukamfOHa4zdCpLHJA==
Received: from DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3a::8) by
 MN0P220MB0838.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:381::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.16; Sat, 1 Aug 2026 14:32:20 +0000
Received: from DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
 ([fe80::bef0:a986:1cd1:a57a]) by DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
 ([fe80::bef0:a986:1cd1:a57a%5]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 14:32:20 +0000
From: =?utf-8?B?aW5rbyDMhsyI?= <inko.lvdl@outlook.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?aW5rbyDMhsyI?= <inko.lvdl@outlook.com>
Subject: [PATCH] Input: atkbd - skip deactivate for HONOR ZQC-P
Thread-Topic: [PATCH] Input: atkbd - skip deactivate for HONOR ZQC-P
Thread-Index: AQHdIcKP/1yqVcjPGUaK6nW1SwQA7Q==
Date: Sat, 1 Aug 2026 14:32:20 +0000
Message-ID: <20260801143216.46292-1-donglin_lyu@outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P220MB0584:EE_|MN0P220MB0838:EE_
x-ms-office365-filtering-correlation-id: ee86a809-8bac-472b-faa6-08deefd9b1c6
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TWTq462A1ci1xfPBdi3ebdl/H+mllPxCfeixN433p9nuyNlzcZVSWTJiMwELhOeg0VHrZFmi9+FZIzJPa46yyPXlv5BTXSAe7N5933QdjG54DECe33ubsEuhCWP0M0Qt+wlKJXx1UwEf7KjmoSIt8jFMGfy3SPA1TXZFur680qlUXjgDZmfEvR80cy0ndC5s9HNCQsF9WWJbrGjOsPLd3rbiDaCowYVEbeFtamzhFVsjJL1LOko9tdHqt0SVDNoRyh42xahFE8TYS/bfr/9l7UGoeqV5qgR2+Ggvt8uvuRqr2Z6GFThFLoXd9tl+BueXLy4jZfdiqy/7feCqSzQB1rNniB+gvb/zmZAeiSNuJzPhhTsrQd3YOqb4AqILAAJjeXEeEkGokX9lQfTtRCc6uKFjUYDojbKzlIqK1x2L8Lolei9Shs7BcME8uYollikCl2vyIYbgM6Q8aM7BbViXGxA4iTtTCL/M99fo+PjV3Xd3iLUYAnDy9lO6MEIAZfwfvUslW23EdasIG41TUJyx+XjpElLHrD8EoFL1wJUrC0gj+OXVnjYVB1+fcXgJGxPA8Ejk/QCdKjdyZyFHcHdLBtnjos6QmHOIZsVpIchG5uvAiVSjF65mSd91Awtaa5ndmB+9VMTEDLbn38ji0i6jpM+hDtyXZER6qYub6kQrNyMSh9hMre//1iU5f+Hhp6K2oKtCcpPG7S+4yZ30vVok5XLTz8RuuuqYgKEDq0Qi9ZnK7nw8Whm/35Rebf23lRYblCpWRVkFLVXo/HwkM+ObD1EXUV/vo59Ois=
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|38102599003|15080799012|4140399003|16041099003|25010399006|31061999003|8062599012|19110799012|8060799015|440099028|3412199025|26104999009|102099032|53005399003|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnVDWDdHNjY2RkpndFlVSUhNODN5WUdFU3NkOUpndmVObE5kc0NBY29jRDI1?=
 =?utf-8?B?aitmT0h3MjNVTllpQy9rK0wzQk5VSUtSbThuU3p0azgyejc2blBKM25rQnBP?=
 =?utf-8?B?V2l1bEdVQXkyNUV6VE1EMG9pcndoRDhtUkN5U3JEalNxRVp0bGpBdTVIK2Fv?=
 =?utf-8?B?ajE5YWxZdGg2a25JRmVEUW8yUDJ1ZTJFQWRRTHBFaG1icHc4ME5ZcFdiZWU1?=
 =?utf-8?B?MlI4Y1lacjVjeVlKR05PZWZ4cU5sVldGeWdoQWtkUzh3dFRHbTNXNHdiSEVp?=
 =?utf-8?B?NTVzeE9aMVl0bGhJTzZFUU9ubDZOa0JWUFdqUmQ4cTFCUllVZmcxUkwzZVNC?=
 =?utf-8?B?bW5CbTVQUERkN2R3MFl6TGJMQkw3UWhjU3c4L0c2TUZxeHZMQzVSdFljaHE1?=
 =?utf-8?B?Vm9ESWFXdnI0OGVVMVZ4NFFKTG9XVUV5VnByUmhpY0syYmI2Q1BCN240ekE4?=
 =?utf-8?B?WE1zUmZFbWlLSUN4aTFhUlVlNC9HWjFRR3d5b2tvTEJadnp0QnlJWWNLQndQ?=
 =?utf-8?B?ZlBWMlR1azIyRXppNklHOWtwcjhFRmFoU3hVVzI5RTlMS0k5K3RqU2FxUWtr?=
 =?utf-8?B?S3Z0R0E0RnhuZkZoQVFrRDloTitNV0dVcUVEdGNzeXJ6WG5nbEcyNjkxbnQ1?=
 =?utf-8?B?NnJENlNVNWY3bjFWUWdyejdhV1VpdFEzSUdnUXo5NVVmRzI4RWVEZkM3Nlo5?=
 =?utf-8?B?OWw2Q2U3TUJBNkhpNS9DdHMrVjFKRXFpcXArWTZqeVRWU1FsOWZTZk5lZVlz?=
 =?utf-8?B?ZE4xRTJDU0FXcStZUEQxMkNRekNnZnpadHAvbXNEMVo5aEpmQ1c0KzR1akxI?=
 =?utf-8?B?VlN5RlRYVWRiZytWSkU4OFhNb081SWJaNTlDcFNwVloxNmhHUVVSaW5aTFg5?=
 =?utf-8?B?NElwTFBDVFlBQVY2eVlnNy93U0xLOHZuOExacmJDNmlZREZVTXpTdGFLL0xn?=
 =?utf-8?B?S0RMY0V3ZWp0dlVKbENCY1F1aXZhSFd1eG9kWTZjQ0FkS2ZKUFNzZUROeXBU?=
 =?utf-8?B?bmJhallqN3ZDKzMxVVhaWXJrSTJSelRGbTZSZUhRTExHbFN5amdOVEZaUVdm?=
 =?utf-8?B?WGVuQm40ZEE5UTFnRnpFeFpSdG05dDRLZ3ZKQjlRbHNVT0tuanlTelk2dGgv?=
 =?utf-8?B?NWJpVlZqckFNcStWbVN5K3pQUXVSbk5aYTFpUnVCYTRCUkV0Y0pXTERqMVF0?=
 =?utf-8?B?WjBqK2pWZ0ticXhkKzA4UEE1QU9BL3dydlN6cGZ3dWw3YTcwV3RJdUd0UTkr?=
 =?utf-8?B?R2xvdk0vWDF5Ykp0Y1RidzBLWFpDcmowbUlyYldFTzBqaFB0VVorZ0M5TEVl?=
 =?utf-8?B?Rm9sdU52b013bUpYZCtjNUlWZXVpQjAvSUxxS3N1QWFKTVRkNm8zOWZ1Yy9E?=
 =?utf-8?Q?jBBjsIIdRNSsWHqRq0ABVwgyZRdAg7qE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGFMWXVOb05ZbmlwMSthdkVSL01xUE80eStLcUJQS0dlbkZPQTlHOHBGa3Mv?=
 =?utf-8?B?RDJlSldPV3FSbEtoWHYxMTVKZFJPZmNGbG9rdEhWSVl5NFoycG1CekY3bDZ3?=
 =?utf-8?B?K1BTbVM5MWJPdjlBRkxkS1U3K2Z0VUp5a09XVjcrNldZNzdFV0hCY2RmNmR2?=
 =?utf-8?B?OTRSMXNPMStXUVpiSkhaaE8yZ056bkpkZlQ0bGRFczhXT1Z6MkROalF0bjBt?=
 =?utf-8?B?ODh6cTFiR0JuamFEL0huWWJHZXhDSm5YYUFTSjJJUFkyUHdJZzErbENGbUc4?=
 =?utf-8?B?ekxHSzdmRjdROWhOb1VCZ0EvV2I2WS83ZXFMby9DQytYYVYyNWgwNGFwRlBO?=
 =?utf-8?B?NWdYSi9MVlNPT3lkWmk5aUpaTzRra0YyNkpEazdQZ2VEdWFLcGtIZnM1UjJN?=
 =?utf-8?B?QUg3OXVudVVjR1dKUm1HMklaeW9tTWtWdTEyTFZwQnpLcnRSS1ZvQkpxaGlE?=
 =?utf-8?B?bHhncEdTb2t5VDcyMThSajExR2VXczBvSVIxMkxmSlp4ZGE3SkVKVVJjNm8w?=
 =?utf-8?B?Q09sMXFVTHpoVEpuUVU0TzUxZ1krWUo3SjkwcUd2NEg4VFlmMXBnbnpyZXJh?=
 =?utf-8?B?bFZJbG95MVNZdnFQWHdzRXhRdFF5cWx0WGVwNUtRYzVWMlZ4S1NRWnN5c2FQ?=
 =?utf-8?B?ZVZrclAxVWhXOFRZL2JhOXBOOHlNemp5MXZ4OGZ4d0h5SXV0SmRUalBrOWZT?=
 =?utf-8?B?UXlDT2liZWtuR1EwMWgyYUp0cGJsZTZsT0hiZURrOG5GL0lveGlnbXZFY2VR?=
 =?utf-8?B?OC9pN2pjdW83WVZuaVF0ZjhKZmZRVFE0TzhrRW9NWkY3OEZ5dlQxdTR4ME1l?=
 =?utf-8?B?SnJoSXJ3V0xOVEh2KzVibE8yOEZPN0lhODhRcTFpWjMrVGhvQlZmMW5PbE8y?=
 =?utf-8?B?NmkxUHlyZDNHRVo4aGtzQUc2c05PSVc5N0VPNFJFR2dsam10c3JTZXFjcXEz?=
 =?utf-8?B?T2tLTFBTWmdTVFVRTFAvWGduR2FuK1hrUnNocW5KZ0JYbmUvSXl6RVhrQitP?=
 =?utf-8?B?aGx0TXAyd1R5dWxSaE5scTNlRE94aXpoR1duMmRnTmI1Rm9lZHpkNTczUzUz?=
 =?utf-8?B?NjZBdkpmMkhqbnVlQUI1QWhtSnllRnRiOEhoRXRnM29hTEZ2ZmxWbGgrdG81?=
 =?utf-8?B?ck1EQVVrd25nTnFPajhOZVR2VkJodTA0QVdDNUllUmR2Q1Z2bXkxZUZNdThS?=
 =?utf-8?B?ajNSSnBRUnpxQTZnZm1Vc0UzeVloVGZxNndQczR5TkF0Ni9kZkVmK2x4RXNT?=
 =?utf-8?B?aEdETy9Pb0E2MFhtUFFTNGJIblo5Q1JQN3hzSDdYZFBBcHRndzRsQUttV05p?=
 =?utf-8?B?QVFxSDFyUUprVkZNQXBGL0NXYTBiZDlURG9pdDlNd3lSZ2N2azYrTmhiT3Va?=
 =?utf-8?B?RTVUZXFvZVFXYlgyRTR0MExUeTRxdFNaRmg0Zlp1YWY4R2tMWTZEdjVVM1hD?=
 =?utf-8?B?dkNaek5mRzlKTjRKa0RTKzlXNE5FQS9KZ0ZlaUlaekROdENZMW5RcXQ1ZlM2?=
 =?utf-8?B?NVU1L2o5dVNKd1A0OUR0L2FoTlMrMVRkUVJ5L2QwWTJQOW1CL1FJdHYzR284?=
 =?utf-8?B?Vi9QOVRlaGJzSGY2dGgrVlAyRXRqdnNYNEtNVFBDMGlabllNQnA5dXd0RDFJ?=
 =?utf-8?B?Tmh5YVZoRFJTTlczekVGb3lHMENKenprUkNLUitLR2N6ZE9URXRqMVlRT3ZG?=
 =?utf-8?B?bFFmbndMMmt5YVdtbjR3UldHVXExbHlvTXRDOVp1Z2RuNmtyWGIwa1dVTXc4?=
 =?utf-8?B?NzRtTGNOVkkxSTl2blRDUTJyTVpZcFBWeHhjZzVabnNyNUxoQytuYUlqUURF?=
 =?utf-8?Q?0kun3XM1txhXHgUHd1pcA2IWukPZw7I5jNAa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee86a809-8bac-472b-faa6-08deefd9b1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2026 14:32:20.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0P220MB0838

VGhlIGludGVybmFsIGtleWJvYXJkIG9uIHRoZSBIT05PUiBaUUMtUCAoSE9OT1IgTWFnaWNCb29r
IFBybyAxNCAyMDI2KSAKZG9lcyBub3Qgd29yayBhZnRlciBib290LgoKVXNpbmcgdGhlIGtlcm5l
bCBjb21tYW5kIGxpbmUgJ2k4MDQyLmR1bWJrYmQ9MScgbWFrZXMgdGhlIGtleWJvYXJkIApmdW5j
dGlvbmFsLCBidXQgdGhlIENhcHNMb2NrIExFRCBkb2VzIG5vdCB3b3JrLiBBZGRpbmcgdGhlIAon
YXRrYmRfZGVhY3RpdmF0ZV9maXh1cCcgcXVpcmsgZml4ZXMgdGhlIGtleWJvYXJkIGFuZCBDYXBz
TG9jayBMRUQKbmF0aXZlbHkgd2l0aG91dCByZXF1aXJpbmcgYm9vdCBwYXJhbWV0ZXJzLgoKRE1J
OiBIT05PUiBaUUMtUC9aUUMtUC1QQ0IsIEJJT1MgMS4wOSAwMy8xOS8yMDI2CgpGaXhlczogOWNm
NmUyNGM5ZmJmICgiSW5wdXQ6IGF0a2JkIC0gZG8gbm90IHNraXAgYXRrYmRfZGVhY3RpdmF0ZSgp
IHdoZW4gc2tpcHBpbmcgQVRLQkRfQ01EX0dFVElEIikKU2lnbmVkLW9mZi1ieTogRG9uZ2xpbiBM
eXUgPGRvbmdsaW5fbHl1QG91dGxvb2suY29tPgotLS0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
YXRrYmQuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2JkLmMgYi9kcml2ZXJzL2lucHV0
L2tleWJvYXJkL2F0a2JkLmMKaW5kZXggOGNiNGRjNmZiLi40YTdlOTEyOTAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYworKysgYi9kcml2ZXJzL2lucHV0L2tleWJv
YXJkL2F0a2JkLmMKQEAgLTE5MzgsNiArMTkzOCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRt
aV9zeXN0ZW1faWQgYXRrYmRfZG1pX3F1aXJrX3RhYmxlW10gX19pbml0Y29uc3QgPSB7CiAJCX0s
CiAJCS5jYWxsYmFjayA9IGF0a2JkX2RlYWN0aXZhdGVfZml4dXAsCiAJfSwKKwl7CisJCS8qIEhP
Tk9SIE1hZ2ljQm9vayBQcm8gMTQgMjAyNiAqLworCQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRD
SChETUlfU1lTX1ZFTkRPUiwgIkhPTk9SIiksCisJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFN
RSwgIlpRQy1QIiksCisJCX0sCisJCS5jYWxsYmFjayA9IGF0a2JkX2RlYWN0aXZhdGVfZml4dXAs
CisJfSwKIAl7IH0KIH07Cg==
