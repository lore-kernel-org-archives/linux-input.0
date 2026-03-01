Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED56430BA8;
	Sun,  1 Mar 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371065; cv=fail; b=ci5PR0g4daZj9GYK42TDuhqIr27fpAlMt8K3rgNpFmNGpsCDniCYfLTh34S4qxQZhOo4vW3K8IqBRiS42kwekjnln9PgNTrOY4YLuVIFFBclbqWhhVLW8W5bnFi0lyOmhnR4EFBsBum1KPCb1EQQ/xx0+OhwXfz8eAoES74/o/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371065; c=relaxed/simple;
	bh=VsfT6gbr8J3xeZSBen/xwUYMo0iKfkyFwN4ORIDIfEM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=b8S8XQ8CF5nmMC7O2Bt7c9/0iXevYLTpAFA8X+8gxO91H94VHbbqFkJa9xw37gXDQl8SyBoKONNjvuDOyTuNe6jBlTf6vsXV/FzRm18zZRksFXk5q9NWH2oUl6SJqBUko2khe7QDNdYl7nmItWAjrhAiW18Ruf03ktI5liWZXXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CN/SYNJe; arc=fail smtp.client-ip=52.101.196.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CN/SYNJe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtCWwll8H06aL5GxaJuP1P7JTWadHn6OhW8exF9sjXgQiG9lJsJn9CMaICfQuGql76WlaYLmjrsMHMha9FNfjQ3LZWOpr8zrucX43NQfm4w+N0LtvOHNwinNmeNfCZdAUsRtu3LBCmu8LM9ac6b9SgUnFkUArZIOtSqB8GOyAN1lPFZfuZ8aBJ4M3t9TQZnpEASe/b725qPgf7yhHkwHjkY9aiNsG2Qx19wtwHpiEBw5Fz4LgccqwDjJ7Enhq39ZWkZ6ItgNfMI/zvMTRgG2nX29gE024MTq2jlGku+Ye5X8IOS4uJOFyzzdxtGmNbKrCDgPZxQF6MNuYGozSehQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4HM9g2kgULXOilnMutQPNm3wTveIbc+uWFl54CW1C4=;
 b=i9gH+ItRU7XOFthLVJSbCAOsasihnb2ZfBUDvrNKS8sc4rLvIOZ9x3wZrXNss1Wju7L7rH99CZuPON81p3slMmz+MyjK1wK4RcckMq3R+UWDXGfC8OZLQqtQeiyTj+SEQugae2XmlyQRNU7I+Qd5PUdZDhNi20HCKf17wDqrdEOsKzupEVM2YOdMaX+WRArrQIuLblnBKFdyclTM5Eu0Aqs9y5+c1o3m+KdU2e2X/V8I/PejYn2ez/KI5XSeBvBSwU5Qhy4yCEEOo3uy04hOPXe/5MFxrK2LvMZjZzi7oiKagnNLIB8xzY1CTGDDocTWxnkSHDAvUDkpg+VimhSNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4HM9g2kgULXOilnMutQPNm3wTveIbc+uWFl54CW1C4=;
 b=CN/SYNJe1tmmPiLRhCse1lKhiKlc/3FqVoyKCyH1uZFPM4drFUu75vV/iIpSlXjoLtt3uHV3xyDZYtfSE8ILYimuzRflEWRQYw6h4dv865UbGfQsHkqVDBdNum7MDhwmh9Jxnik7z5Zk5OIzAeF7W8xK0k9YlQSbuU03y4uQTak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7840.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:213::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Sun, 1 Mar
 2026 13:17:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 13:17:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 13:17:40 +0000
Message-Id: <DGRH3T072LM3.3LTULCM4FPU99@garyguo.net>
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>,
 <benjamin.tissoires@redhat.com>, <benno.lossin@proton.me>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <dakr@kernel.org>,
 <db48x@db48x.net>, <jikos@kernel.org>, <ojeda@kernel.org>,
 <peter.hutterer@who-t.net>, <tmgross@umich.edu>
Subject: Re: [PATCH v6 1/2] rust: core abstractions for HID drivers
From: "Gary Guo" <gary@garyguo.net>
To: "Rahul Rameshbabu" <sergeantsagara@protonmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260222215611.79760-1-sergeantsagara@protonmail.com>
 <20260222215611.79760-2-sergeantsagara@protonmail.com>
 <DGPUMHQSACGL.1ITBM2W573WD1@garyguo.net> <87o6l8kpud.fsf@protonmail.com>
In-Reply-To: <87o6l8kpud.fsf@protonmail.com>
X-ClientProxiedBy: LO2P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::35) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa54480-9833-43f2-a158-08de7794eb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	xtNKagcmhuEUO2ro7fAmrfV79pfmIgLdiuM3O+a5SsN3yCsHqus9ShSLZVkhJyvokRELUbomXYKBzrXSExbLvqojfiYeo5zUDo/6TFMn2Jz1AqwDgCyHhCpBP/F4YtNBGUVlVKoIYTi/K4n0yatV50aM2kwQ7f1zkY704N8ev/2C/FGf1YOPgSe0ZOk3o5O+Z1XT918CqqTrOSUv51Mlp6ETSlnycda4bOb/oIjfG0wSYgQ80BsK+i4ev7IeAYtlS47VGUlImIugfs1oXMOAOex8aBXqONPzNLj9y/NnJOgOYCDlj3Ka9xz4n8caQxub5bgceQ++kCu/l6Kh+lXNRJ6voYqCgJ2zxEwnsgIWYTFvIm9PpD6k4Hi915GGDbIdygjZGZS+HIQev47Aawvfwg7gwTQaNUawvqCyML1dtYPasA/4tVLWscFNErEJ1StrYC/SSsR8teTK4EvrezUlVLDTCkHkMaJrwFIbyc0PTLC0+vnV/kJT6yDSPf1TIqWGi24792V5ANq7Zd3Nw4AqT5rfFkGAsgfyjSnhLgNGVzNbwz/7ybUIKsVxIQWjriIaC4EezNheyicDOnJ2kOxw5K93d/fE851h1ZHs4qiiay7OUb111zX++M939MLK5JqG661rvfV4KUGsHgbNe7+nTDUVWtgoVwcLOy6T31ysPOVeQUbRwOad/2Lhc4Y5L4yB6x3lg9+gUVSr8Demx5ysDKbWejhiLvlyYwMNO5qsNG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjhaajd3azc0ekRyOStqNzdwc1Zib3BJNHFXclhjQi9QYjNMa2FWNXp4ZEVv?=
 =?utf-8?B?QUhYV0o2RTlXaFFaalFKaXl2aEw1QkpmTDdEemZ5dVRVWGNWbTMzR2lMaUI2?=
 =?utf-8?B?MlF0aFVEZ1YrVlRMNUh1d0kvMC95alhuNlgxWllCcWJkV21oSXFGV0hTV09z?=
 =?utf-8?B?Y3hPUmRYTDJEVTZYUWYxc1JWcitWR2Z0SDJtczRIUXFVcTRmM0wzbzNiYzF2?=
 =?utf-8?B?R0VZOThQTExPSTBWcDJLZy9JSG9EOVcyVkU1MGJYN1dlUkFXNGJkQ1dMWjVD?=
 =?utf-8?B?WUowUlhJMVlzMmZueFE2VlRQY0YxSVV2dTBsNndUb2NyaUFGS2cvMG0wajhX?=
 =?utf-8?B?SzRlVmhHV1QyTUpSTENOckxmQnZaa2NGZHRPTSsxUWVVWWFOZHdSTVBKbkRq?=
 =?utf-8?B?UXZ1dmpyQ2MzdlU4WWRWeGVEeHQvNGIxM2VoQ0Yxak04UUFnTzc5N2hlMGYz?=
 =?utf-8?B?OUlEYnBBN0wycTcyd1I2WUJPNGROMmZFRXRLOWdoWG11d1Eyc0RTamZlRFNt?=
 =?utf-8?B?NkhkZEZoMEZSYXkzOTZDZkZOKzlIMGVyUEtSUllqaHNqOHFJemlrTVkwSVdN?=
 =?utf-8?B?SVg3TEExZnpUcDdLaFBhaVV2ek1uOW0vcDhXSitlczM3all4S2JnOURWdEdW?=
 =?utf-8?B?VlV6OFNiVUYzL2ZlbmNzNm1tVWN5Zmc4WXFtb05nekM0anVYZnUwb1Q4WnNo?=
 =?utf-8?B?akx3dlVHVWt6ZHlrZVoxanpzcmh5Sm1XSkV2Zjk2N0pOcnV3dm9icGg1OEx1?=
 =?utf-8?B?Y0hYMmk2YndreC9vU2wvK3JHcHVVelBGbDJCWDJZMlRhd2JJd3V5UVRNWnZZ?=
 =?utf-8?B?OWJkVXlhT3lRbEFlN1F2bWwwOCs4YUhBK2tzaUpDNWNucWVDR1VzblhEYmda?=
 =?utf-8?B?UVZQbU1XWG9YTDhlVmZXbG5KdDlmSEZBOGlPTENLYm1ZN3l0cUlBQ29pblpS?=
 =?utf-8?B?eEVjdzBNNFRKdFI1RmJvTjFTRjk4TDU1dXpCSEtNaXNWcHM5Qi9NbmxLeDFq?=
 =?utf-8?B?amM1Y0MrNkFzdUdWK3QyZkdMZGZ6REdad3hCU2tOZFZJc0FXVWppTnVSZTRP?=
 =?utf-8?B?TGJpSmFhMGZzZkloTzBqMURrR28rSWlNY2YzMmdPV1dyMVdjUUdNRFRUR1pk?=
 =?utf-8?B?M1d6ajdieGo4Tko3TXJxOUhYYmwybG1jZE5JOG5PM3FjdzhoZ3RkblhNbWVt?=
 =?utf-8?B?MUxZa0dOK0Z1eS9HaDRkK3g2aEpJMlU1enhNTzFkclEwSVJrVjdKK0M3amJC?=
 =?utf-8?B?RHdhNmx3TUhlZTBEQ0RzZ2EyYjIzalVPYkpyY0RVekV3QlpWZlp6SG5UWjdr?=
 =?utf-8?B?cGptWDBpU2o3K2hMdXpQeEJwczF1WVdpQy9GNFBwZm8zVEh4SWJhVzRzUHpv?=
 =?utf-8?B?Nzg5VVdEKzVPbVp6Tklzc0toUm1BY2k4OS9MOGhEbUxxa2hGZnFXMm85NjR3?=
 =?utf-8?B?MjBJVG5mbEFzeTFkd2VESzNEZXRTNkhwM2hXZ241M05sZWZqS3h6WE5GMUJn?=
 =?utf-8?B?aEdBYUZ2RmRLZjVweis3UW41UTl3UmdFSDBwMzBuNk1LK1ozNDhQS3NNaFB4?=
 =?utf-8?B?bm0yVE5CSlhiOVlhNFFUS1BGbDVLWUdKOE5SbjV3WTJ6dHNYYVVNSk0reVh0?=
 =?utf-8?B?NTB4dFhZVkxIdm5uaXdQVHNKK2dhaDJLeE96M2FWZjkzUVQ0Ym9kRGsyRDgv?=
 =?utf-8?B?NkN0dlN0YUY3eGptVXBZaWNWNXhuQktSWHE3Y09JWTR0bGZsV096Q09nQ0ZW?=
 =?utf-8?B?TWNCOVdGTXd4K1hMOVNxVjZrV1lNN05OTnNzME9TbDZCTkJ6Z3VQYjlvaXFW?=
 =?utf-8?B?bjdwZHdaeXZDQTd6dUJCRHgzeFZibnhnOFRuM0YvT1lKUGs1ck5memNUN1ZD?=
 =?utf-8?B?SFBJL215T04wR08vSnBxSkdSQm5tVzE3RDQwdkxITDgyNUdmckZvZ3VKdWQz?=
 =?utf-8?B?bEprVThmS3VxbzZWeVo2NDR2NHEzQnNmMjQzWUNEUDAreFlIeXJ6QmJyczBF?=
 =?utf-8?B?RTRWcERXTVlaQ2pSd0FiVUw0WmNKOWI5STVwaFRWQWRIZmhqU1pKTWdvNmh6?=
 =?utf-8?B?Qk9nWEJpQnVrdGd0ZXYwdmlHM2VIM2t4OW1Bd0x4MFRPSm1iZkE5azk2RW41?=
 =?utf-8?B?SEEwRnQ5emlOSTN0MTlaaVpxcWJUbFRmcVpDU21ZWmg3YlEzaWFjOGt6Qmgy?=
 =?utf-8?B?d0lMYUwyaS9aWTBFbERhRklNVGYyYUJxVk1PUGd1YVprOXpwV0hqczUzRWIy?=
 =?utf-8?B?QXpDK2JOdVY2emRoMFhlZzFJTU44WkJNa05CUnV3M3RyOENwcUhpcUtLOXVS?=
 =?utf-8?B?U0IyL3U1K1d0ZWJ1S0x6MVcvSm9WM0VkRFJXM3lJQ005NXFCSWhYUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa54480-9833-43f2-a158-08de7794eb06
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 13:17:41.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHZ0CQ7Z8uAxJSrzhH1d1GiYS3XlrPMwTrSjdRtNCkIKRxYy+XG+GTLceyqbxzD/B1frVN9GPdgYpAoeGuszXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7840

On Sun Mar 1, 2026 at 6:48 AM GMT, Rahul Rameshbabu wrote:
> On Fri, 27 Feb, 2026 15:27:59 +0000 "Gary Guo" <gary@garyguo.net> wrote:
>> On Sun Feb 22, 2026 at 9:56 PM GMT, Rahul Rameshbabu wrote:
>>> These abstractions enable the development of HID drivers in Rust by bin=
ding
>>> with the HID core C API. They provide Rust types that map to the
>>> equivalents in C. In this initial draft, only hid_device and hid_device=
_id
>>> are provided direct Rust type equivalents. hid_driver is specially wrap=
ped
>>> with a custom Driver type. The module_hid_driver! macro provides analog=
ous
>>> functionality to its C equivalent. Only the .report_fixup callback is
>>> binded to Rust so far.
>>>
>>> Future work for these abstractions would include more bindings for comm=
on
>>> HID-related types, such as hid_field, hid_report_enum, and hid_report a=
s
>>> well as more bus callbacks. Providing Rust equivalents to useful core H=
ID
>>> functions will also be necessary for HID driver development in Rust.
>>>
>>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[snip]

>>> +pub trait Driver: Send {
>>> +    /// The type holding information about each device id supported by=
 the driver.
>>> +    // TODO: Use `associated_type_defaults` once stabilized:
>>> +    //
>>> +    // ```
>>> +    // type IdInfo: 'static =3D ();
>>> +    // ```
>>> +    type IdInfo: 'static;
>>> +
>>> +    /// The table of device ids supported by the driver.
>>> +    const ID_TABLE: IdTable<Self::IdInfo>;
>>> +
>>> +    /// Called before report descriptor parsing. Can be used to mutate=
 the
>>> +    /// report descriptor before the core HID logic processes the desc=
riptor.
>>> +    /// Useful for problematic report descriptors that prevent HID dev=
ices from
>>> +    /// functioning correctly.
>>> +    ///
>>> +    /// Optional to implement.
>>> +    fn report_fixup<'a, 'b: 'a>(_hdev: &Device<device::Core>, _rdesc: =
&'b mut [u8]) -> &'a [u8] {
>>
>> I think this can just use a single lifetime?
>>
>
> I think the problem is when a driver decides to replace the _rdesc with
> a static lifetime report descriptor declared in the device driver. My
> example driver does not do this, but this is another common pattern in C
> HID drivers. This is why two separate lifetimes were required.
>

Lifetime on references are covariant, so it is okay to convert `&'static [u=
8]`
to `&'b mut [u8]`.

Best,
Gary

