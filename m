Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010009.outbound.protection.outlook.com [52.103.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F89390212;
	Mon, 20 Apr 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689266; cv=fail; b=PBGuCyHuHpPAr60D3rJN/iGm7r86wD2/UlCfqEIKozf1hXkmiix2Ry0501u3lWTH230fWzDeL3mNrWGtGem9zFu58NQ9gXwH6P87zkp/DcH6+JvExQD2OGsgM0vbxZxsNSjdaSmUjAkcIi4V7xhWNaiQr9k21nKhJrERpjoQU+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689266; c=relaxed/simple;
	bh=JG8XpOACyRhwBVFgcWcsIlO6MIF36Ta4R2inIlFFYmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1v/K4xISOE7EhJbBQUeaMK8xLjkR5DNSwOPD4UQnmcIHAmOMBPldUqtRpJ2UnydtTEHYu/cSbI5E5vHkwzbLkMUuGoz+2hSrA5XEfE33mzKciwi9OLYtErbMAtzebSncfhPeMZzkdPC9ubwefdhpWWcv21z2WkLdr6LCYJYwws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AI9YnacJ; arc=fail smtp.client-ip=52.103.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AI9YnacJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HafRfjDWMug5g3QKRZo8HpDYaUX5Q+2jz/QiPtNNSm/FVcx2zJqaxEEVN0rhPWr+Q19TomigjpqCWLQUwhGni0Se+V8sPNc/QD3t8ZQbLVBv6O1jbatzN47CKLFwVyKnUzA2zM1iDMdk9latK2zuhRzcdSKajPVBIpW9Rv2nfXB359z6JWS1P16kFNDlBWAREbBCdWzdqykFaDsJ4jpsUyij6DPsLBdKLKTofOsdGnUn/xWs+6mSfmR9iLUSXpt97EpJnf0THObXi91hk8ySsC7vpJf3mtciGgT6QO7q5pwMV/gqU0he4f4keZwSZvqcfOeWH8eZU959vfUQ9C2DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmLv67f51intECJLiwTkqErtXHc+R7+TeYpwf/l6CIM=;
 b=AHL63ZZ6Hih1DPphHGUA3eRGH4LL8dUrPH9G9DdJ5lNvQLdzDD0bZ6iJM0Dl+4OWLzwKTrIqeoGNNrKSzXA1FBjNmAOIMTmEThWNItO6VSydu03+NRBJdhmN3NfX4Y2XvnyJ9s1cEWc27+drEb/tcPi+c+Rhi9KGS3sQRCdUiAaGLicHCe1igLffa5L6FJM8zgKFGzPDNDVdT9vB0EcEBsccDURTF5z0tmeBMSOSbIaRSPw7kise/CjeNC17bCwbhEPNmhTXg371p7rKgABceg5qs8eCOFXLoRrPDmKIwp21H522+c26jNlm4e+X7HQV/vlxxwnDJc0qGecHvM8jlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmLv67f51intECJLiwTkqErtXHc+R7+TeYpwf/l6CIM=;
 b=AI9YnacJiyy81yAyy30vUVKXg5wocSCjcEnpLAqJuHmbHPuij40i9g9DFX4f8BAiaZTTBCNLwiIe1urhDU2bbi3YH29w3pFiDjyW1z74Mr2STmNDjKvRYysuxiHs72jhfuOeHpIeLdIvYtMZXalDzGW7ZK0r+30+aM2OgSNEya9YdBVINQJcgWysn9Fkk2c9Ha6dpDO1/UF0tozgYDbiLH0d7zCGSuUNVsi5pRw4G1zCjeRJIVkTb94MrtVW3x4wNNgCy9R5ZJVgCLPk7HH4jtmxHEbHQpXuLbCjiSw303W58yu0A44GbTa8D7E6RDrUdIRH2glEaQK/hrKnePLpKA==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MAZPR01MB7795.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 12:47:39 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 12:47:39 +0000
Message-ID:
 <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 20 Apr 2026 18:17:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] HID: appletb-kbd: fix UAF and mutex-in-atomic in
 inactivity timer
To: Sangyun Kim <sangyun.kim@snu.ac.kr>, jikos@kernel.org, bentiss@kernel.org
Cc: qasdev00@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <048cd8fb-ef9b-40ff-811e-7f1f9e5e5aaa@live.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MAZPR01MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: d66f4b67-0c7d-4bd0-b44e-08de9edb018d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|6090799003|25031999004|23021999003|19110799012|15080799012|8060799015|41001999006|40105399003|52005399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU5PbjJoK3dJV2RZdUUzSWxnWjIvNzV4ZE1GSzFrWkZ0N045MUVsRkJMZEJu?=
 =?utf-8?B?WUFIVE1VbTFFRzNLVExSQzUvSUxFcnM2M053aktnS3ZsWVNidUx0UlFpUS9G?=
 =?utf-8?B?MC9NVGk3TEtCUFB5eGZXMUJtVGVHb09XdHhIanZrRzZjcTFQeG51cGFiVEJj?=
 =?utf-8?B?UFhGV3BBcm5MZGEraFZnNDNjUHMyYVAyYWUza2ZRN1d5UlN2bHBjUVdtQzdi?=
 =?utf-8?B?cFN0OFV4c2JBb3FBaTE5K0pPUmE3Mm9WZVVrQ0VZODBEcVovcnFta3JZQlV3?=
 =?utf-8?B?cU1VeFh3YjVJdEdPS1hRUlRIODltcW01QmdEM2hranFZQ0orS01SNm5Qd1Qy?=
 =?utf-8?B?WC9XL3hUM2R4cmJJWndvb3dLVUZYaU1kOGNMZEJlQ1BWYU16aG0wWWlBNXdW?=
 =?utf-8?B?RTZyWk91enA4dlRTK2tEbVlXS0lnL25nSjdLRmRVVDFnMHBVTTdyWGozdlVQ?=
 =?utf-8?B?TGFJQmZtOVVtWS9vQUIrUFJySDJiaGdFNnN6ZDIxZ1BBekZLR2F0Y2tIeUFP?=
 =?utf-8?B?QnE4MGJ4eDQvWWZpNzRnVGVDZUVqWjlPQTNIalRUQmJkYVhCTTB5WWI1bm1y?=
 =?utf-8?B?NFVKcFVNeHpiaFJBaG9RNGxNck9OM25Pdi9WdDFLcjRLWCs5MnhVRG9nb040?=
 =?utf-8?B?RUcyL08wUXpDWVB1OFhxZGZDb2RQWHIzaDFZc0xiZ2xCejFxeHFOVFhjQ1lE?=
 =?utf-8?B?RWNUNm8xS3QxZkhqNDhjT2Naa09tUXdERkxMS2ZxN2ZrbzFTZlRVaFh3T3BY?=
 =?utf-8?B?aVZlWGNNdC9pemdya3NDNkN0WnRqckl5TWFvczhLd0kyemdlYUF0bitjQVlN?=
 =?utf-8?B?UStMcmZZc0I4UGIvTWJTMnVoaFoxUzZWaVdtaVpkNHA5dlR5eDlNeXBBOGcz?=
 =?utf-8?B?a0JEWlhiVTAyNThwSUJzUnBoOWxReVowWXY4ZktBcjVkVS9DUk5tc255MDdI?=
 =?utf-8?B?UzRkN3lCZ0dHNDV2UFg2RzdTOFl6dDl2QkxOSmgrengrWi81QzN4dEMzZTZh?=
 =?utf-8?B?T1czSnFxSExpVmJaMXNIaXVvODZrZ2ttdmpOTUh2WmJTaTFJQ3JDdWlPbVVj?=
 =?utf-8?B?L3VaQlFOcHYveUlNbUEyb0dYWWhKRDk3bnB0UmkvVnZ3cDhsZXF6Z0h5alQ4?=
 =?utf-8?B?SGlYeDN4M294ZjlJY1dOeml1eHNjUSt2Wk9IWUwrdkVIWXZlRERjTjZTWElF?=
 =?utf-8?B?R3cyRjRvdElzRWRtQk8rbjBSSktFdW5LUWE0UVkvMjdIbktkS1RFYjhZRml1?=
 =?utf-8?B?Rk5BQWlQSGYwVzQrTldOZXNic0RFQTYyVnNqK0JERS8wYkJGUEJxRzRGRFdO?=
 =?utf-8?B?NmFOd1NaSGZkSTI5aWpjekUwaUNRWDFSVVlybkFoMFJ2dGxtMWQyanRCWTFi?=
 =?utf-8?Q?zAKQbFVWbrCVGc82x1XmW6p2D145jcIc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9uUEN5cjVIaHVVbGFWV2ZBMHdWYWU5Q1crQWxnNzBOdGpCUWFCeThvb3JU?=
 =?utf-8?B?QVhFNGh3bXM1N0JNT0F1NmhpWXpyU2MwNUdRVlh1bkpTaEs0QjZCRUtpcDl4?=
 =?utf-8?B?QWQ2UXNaYU81WmZzM3JrVmt4Wm9YSkU4UkpVeHdwUk11MTdISTZqL1RFdlJl?=
 =?utf-8?B?NGVOWUY4cHFPWUorZDJsZ2xlUjFNbDArWWpSU3ZNa1B1MDRDMXBaOUNoRVF0?=
 =?utf-8?B?MitJUWZkMk5kc0RGbFdyaUVRTFZrNXFBVHBnbmtubVNBTkU4MG1mMGJZMHNk?=
 =?utf-8?B?UVpqdW5pQ0VFQUpyRlQwVUZkRUI2M0dObVlVWFJsZGR3d3RhRkdzWEhocThj?=
 =?utf-8?B?dFRsWWpIakFCd0ZJWklGTWhCMVpkSFB0UmoxVFZXY0NHN1pFS1ZGbEZIUExZ?=
 =?utf-8?B?dFdWdFQ2d3RZQ1Y0Mi9VUEwvdG9IMkVEYlNsN0VPUnM0WVJDblZma3FsNWpT?=
 =?utf-8?B?cjJzVWErVzlxNFNBL082bUwzVVdMU3c4Z0VZMStlYXRRWUxoaVRJdFZHU3hM?=
 =?utf-8?B?Rk8wT2lZd29CS1JBSWZBT2ZnM0Y2S1h2d1Ntam8zVDFWZ1FOUGFGdHdSMm80?=
 =?utf-8?B?d3F2R3piY3dmWTViMWwzNmllVVFhUUllZEI5ZTdZbTVhV2VybS9Udmxxbmw5?=
 =?utf-8?B?M083Skk0SGxUOGxEeWdsTUovdGY4MmMybkdENTVnUURZdXNSWDcwRWRKT3lK?=
 =?utf-8?B?WTV1TkNEejNXc2taajdvRXlRNFA5ZzdTR0k3VmZja2Z3STNsbkFuWUZucXZs?=
 =?utf-8?B?UEVlV3ptTXhXb2l6VGwwSHBzczN3dkl2bEJhczcxVHFoZUZvR3FuVUVxRnBi?=
 =?utf-8?B?VlhiOHk4ZFhoc2pLVWw4cE45bFJudWlzTWpOdlVuR2RVeG5MY0huL3phMzNt?=
 =?utf-8?B?dFZLdWNUQWU2OGduYkdYSU0wdkQyWkJaQi83YkdjbDIvZTAvWXVmb0xsWUt3?=
 =?utf-8?B?L0RBaFErSHpEdWlyWnY0T3NwbVczY3RubzlLNW13cCszdnNvUkZwakV3L1NU?=
 =?utf-8?B?M1JLbzFtRGR6SEhaTSs3VGpxc0NUWTNPalQ0RkJpQVRqKzVvN2ZkczlLMk1q?=
 =?utf-8?B?eUhobnpVR2hkNjMyWUNOUnFQK1E4TjVzWi9ZVmM3cklhcE96YmxLNkNhRFhP?=
 =?utf-8?B?Qy9HelRSTFVQTzRxT1k3OFpWM1Q3cnJNY3A5Mm9XcEQwYWJtOFI3S0ttN2dY?=
 =?utf-8?B?Wm5iOUF1OHZ4TkVTYzJwUDNOeDJ3aXF3NzNYenhqTERLNGM0Wlk1cURsdk1N?=
 =?utf-8?B?S1FMTGQ1eU9tT3hZU1NQYlJaanZJaG1kMEFyT0JhcGxyU3NjUjROUVRTcE10?=
 =?utf-8?B?eUVPTWJkZE9CdnpBd1JRNlRHckIwRGVoSWhOUzZzVVR0aGFrOWRiYWVjY3hF?=
 =?utf-8?B?Q0Q3SUZvYXBDbFlyOU1BMzZNTG1qdlMyNFVLR0ZYNjBnZWJZaFNZY0RZem5R?=
 =?utf-8?B?NU13aGxMK3lXUzRLWjVNalhpZXoreTNZRHptbThxMGJsVWJrZlBIaXdPbUhy?=
 =?utf-8?B?ZEVhL3hlQnpkdDF5YlZJQ0RQYUVNdU94eTNmVS9UallWY0Q0SWF6bEJJVzIz?=
 =?utf-8?B?cjJUNlVidnAzRmFpMnBBaG5jRlpLTEExa1RMOWIyR094cmpRbUl6YnVSbDlW?=
 =?utf-8?B?T3NqbFQ5SVV2VVQxSCtaeDIvSzdsb0l3alFSV2VtVGpuMGExdFZXaWZxWlU5?=
 =?utf-8?B?THNTK2xvdzVGTXdURlA3ZytkWTFkUnlRd1kzRnJCS2w3Qm5GTUZNOXYrVHJT?=
 =?utf-8?B?VGNQRUhLTDlmTU5MSmhGWlNlZHgwUklDZ0d6OUhWUnRrdnFnQVdUWVIzTi9W?=
 =?utf-8?B?bFBQbHVrSVNWTXJVN0x2YUs4MlcxSzhBQS9KOVo4RklDSDR6c1BEZUI3MDcy?=
 =?utf-8?B?K0drTi9STS9UN0Y4UHpSNWZpOXZvalVtbGkrK3NrNTUzT24wRTNwbGl4Z0Jh?=
 =?utf-8?Q?IWOglcfudDod7n6By2+F6koVQfor8rLK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d66f4b67-0c7d-4bd0-b44e-08de9edb018d
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:47:39.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7795



On 4/20/26 10:43, Sangyun Kim wrote:
> This series addresses two defects in hid-appletb-kbd's inactivity
> timer subsystem.  The two patches target different bugs and are
> logically independent; they are sent together because they touch the
> same tear-down code and because the same maintainer will review both.
> 
> Patch 1 fixes a slab use-after-free with two related tear-down windows
> introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
> use-after-free bug in appletb_kbd_probe"):
> 
>    A) Within "if (kbd->backlight_dev)" the order was
>       put_device() then timer_delete_sync().  A concurrent
>       hid_appletb_bl unbind between those two calls can drop the last
>       devm reference and free the backlight_device; the still-armed
>       inactivity timer softirq then dereferences the freed object
>       through backlight_device_set_brightness() -> mutex_lock(&ops_lock).
> 
>    B) The "if (kbd->backlight_dev)" block ran before
>       hid_hw_close()/hid_hw_stop(), so even after window A is closed a
>       late ".event" callback from the HID core (USB URB completion on
>       real hardware) can arrive between timer_delete_sync() and
>       put_device(), reach reset_inactivity_timer(), re-arm the timer
>       via mod_timer(), and reopen the same UAF.
> 
> Both windows produce the same KASAN slab-use-after-free on the object
> allocated by devm_backlight_device_register().  Patch 1 closes them
> together by moving hid_hw_close()/hid_hw_stop() before the backlight
> cleanup and, inside that cleanup block, calling timer_delete_sync()
> before put_device().  Shipping both as one commit avoids leaving
> stable kernels in a half-fixed state where only window A is closed.
> 
> Patch 2 fixes a separate "sleeping function called from invalid
> context" bug in the same subsystem.  The inactivity timer is a
> struct timer_list, so the callback runs in softirq context and calls
> backlight_device_set_brightness() -> mutex_lock() from atomic
> context; reset_inactivity_timer() has the same issue on the
> brightness-restore path (it is called from appletb_kbd_hid_event()
> and appletb_kbd_inp_event(), which run in softirq/IRQ context on
> real USB hardware).  Convert the inactivity timer to a delayed_work
> and defer the brightness-restore call to a dedicated work_struct so
> both sleeping calls run in process context.
> 
> Sangyun Kim (2):
>    HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
>    HID: appletb-kbd: run inactivity autodim from workqueues
> 
>   drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++-------------
>   1 file changed, 36 insertions(+), 20 deletions(-)
> 

I had a very weird bug just once. And that was when I pressed fn key, 
upon releasing, the touchbar mode did not restore to normal.

Although it was just once, and I was never able to reproduce it again.

Have you tested it on your Machine btw?

