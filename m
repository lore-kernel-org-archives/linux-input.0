Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45AF481223;
	Wed,  5 Aug 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945291; cv=fail; b=UVtNwue//B1feS0nk6NZxNru+IAdVja7w3vMOvXI//psc9BnygrArBDMl6JIPp5bSFevgW2Uaww+nrCgnlyfV0dOfNVBPKYelB7NH7E3Gwv4LTNNG3qio3OhzwEHFkP5W3X1BJx7dixUCehPpSNBUE7VkeZDcyYCLtnnwRHtp2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945291; c=relaxed/simple;
	bh=QGlWMuH8FpWi2KF/YcjvoLe18+8pwa1DaFiPo9r/+00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZExwtWaOQ+BEebWMlTsuOhfRCj/bYi0sPD+FmyUalsuXFOW2jBc6LedbuhHid6ynDJ9CEXS25MJOZF2PGjiyXlSUEfHGrV1GxPJ//mMtIwozJwIDeENc4Sa6hlJ5+R8xyI5F0pulL0G68cLfx4j9LXkknKI0AQ9H4iomWV4OrhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vu.nl; spf=pass smtp.mailfrom=vu.nl; dkim=pass (2048-bit key) header.d=vu.nl header.i=@vu.nl header.b=W17CB0Ec; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vu.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vu.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vu.nl header.i=@vu.nl header.b="W17CB0Ec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHrPAeBb4NpmiK9096d5b3Dx+zZxXNJoCgojUzxsCo4gHWKFyAGiVof8AqKo5/F629CuiGhuopyJhjuraUyHPsiXVLncHT95IkAJ61wemhFQv8Y77zYDPWTtKM2wl/cGDJ8TafcKRA8nLCw/i0WMjSXfS5zCmE2FKv0tv8D2o7SN/rqlYhumgHhZ/ejLiVoi/0duXMqb7zyeivXkNU0ChmWyA/oIgpQsjr87hLg6IKHHq5QiABWTdVTqx3J6i/LnvsFpSHCA7WLy2oTWPiDeqvqMf4PlWH6vWXX91ARzhjkC1GzF+MMFdycyGyiTBS7sUZVjGbaf1xLVLvjpd+DYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S5rXYLEcglQ/wgP8mNEdq4RuEAmw2UDtqWH//ubj7Q=;
 b=xZd4ua39zBw0sLkS/cIdebBRVHWRmd5F8AKhZGemlVYuoCOgFPRo1ooK2VZH+LoczFEoiiJYKAqy2mqT194SXMqQgJKhf7L+rEJ/tvA8LGyc31ndoPtl6WNfyaCoHE5iGaJ1jXCyLOiELQa+3U8dc/+02dpGeJoRk+/0VcMakkVJQD4q0aqS9ZxCZVFFs0OTwaB/9DS9iX1oHqcotr6jfiDbQfhf/OhAE1mVwan13BaH0vpGVzdNjdxTJHOACdW8mIbMm0yER+CMVs3uQVfZseSnlhPgeBhDWGCZiGHZ5l9rxO7DgjMVcGrbagud5QsthVi6cWMa9AvMjxiZP9tHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vu.nl; dmarc=pass action=none header.from=vu.nl; dkim=pass
 header.d=vu.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vu.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S5rXYLEcglQ/wgP8mNEdq4RuEAmw2UDtqWH//ubj7Q=;
 b=W17CB0Ecs4O9kOx/iGZNWz6i9gT862j3kTIfMWazc30RzgA1aKAHa5N+tvku1kI588GbZmNWFyuAPWQqR3BzMVIeW3lu6yWj+WG8UjvDh4WxauqcEGehWVweY3znbyk+VSK5n+GBCFlq5+CUrnUBPAD9x0YkKlCJxPODcLDlZE5+FpU+i25Y20OTJ+9Uy5SDeJrx+oICFWPoSK61ErgNAbPRQ4F+lS+FpKB9xYw5mduGTwWx1D3F0OQkYSY3MMxIWkkqe5Q8wsftH5y27yQEFo53Bh3JXiJRiWVjo1nPcrxinXpJtKOnimO6nuqYe+ZnAgSM6bCT1K7P/wU28Fqzfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vu.nl;
Received: from AS4PR09MB5573.eurprd09.prod.outlook.com (2603:10a6:20b:4b1::22)
 by DU0PR09MB6196.eurprd09.prod.outlook.com (2603:10a6:10:47f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 15:54:42 +0000
Received: from AS4PR09MB5573.eurprd09.prod.outlook.com
 ([fe80::40c:9041:66b5:2ded]) by AS4PR09MB5573.eurprd09.prod.outlook.com
 ([fe80::40c:9041:66b5:2ded%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 15:54:41 +0000
Message-ID: <71f6660c-672b-45ee-8fe8-fdd703df5fb1@vu.nl>
Date: Wed, 5 Aug 2026 17:54:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: evdev - sanitize event type index when fetching
 event masks
To: Greg KH <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
References: <anFCAfvxwXB5eJF1@google.com>
 <2026080412-camping-fringe-8219@gregkh>
Content-Language: en-US
From: Chris Wagenaar <c.c.j.wagenaar@vu.nl>
In-Reply-To: <2026080412-camping-fringe-8219@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::14) To AS4PR09MB5573.eurprd09.prod.outlook.com
 (2603:10a6:20b:4b1::22)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR09MB5573:EE_|DU0PR09MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 9478d082-9576-484c-a828-08def309dc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|19092799006|376014|786006|366016|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o1WRxrQc8h+GdQD6hG/IcmoAQgPLH96FaNfDmvat8VDWEUF/P8jx2GY0tM1cSRnMsxbiqpTDV6hKDisR7Y5jBxTqilsTnbkSf+4MUkwYxiUejp7tBoQ83WIyVHbWH1XP4JmehoHQPk0gUmADKwjjEQ/QMUOiSA6PqbtAO0qjEP0yPooo2Ne1GSYJ/yp127w7y6gx7MrjdKHQWpjkN9+LTRrY2l8qsqmMY/C/+ezRonUGPd25YIl2PtN7cegEb70k6vuylYbEW5ItvLdjhz+u/VdmnoFNPF+FRDO7ScYNoR5x/O1Rn6fVBej2Foj9+gkEOFdkbiz/dnlj9hbtZ7IWkj813RgEkfIL53d5r1MVa5Gu+5MSWVN2VFqLDZm3kVc4tw9pcOQJv29EoLvNtLFWWj9m+Pt+Jj+M8yFZrr5EKPISJyRtsjMtuI3y7ZQT06QpJ8xg4cLhh2DO7mGUeqRtiADGG9yX391n1Si0e1+WHYGD67aIqzhHZp5X5CDM/YrYQd7vOx0FfPkuIWQvt61aNO+du801AxTXl3bEnq+8jkJTkvHpdygNP5S2v1wewKiHzkZHLgJISuQn4aDHIdLQr8VpFpkDAeYkn/CzD7cp9DNuTLb2XPr6A2G8NMiXxClhMqs2FTy/2mh0zIbXCaRr02kCMu+qm5iHCEDpU2v22ag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR09MB5573.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(19092799006)(376014)(786006)(366016)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdRVEx4aGhRNW9RcnNDSnovZ1RCTnN6U2h0TVhBSkhPWnNlby9nVi9oTVNv?=
 =?utf-8?B?djBUaGdDTmphN0xNRm8ya2hBeldQVTZxd0ZYeHFEbVkxV3kvR2tqWUxMTmI4?=
 =?utf-8?B?UG0yaDVkbldOT0Y0dENyOE5rMDFOdXY1R3NMUDVsVlhkdElxWWhyeU9oQjFS?=
 =?utf-8?B?YUluNGczenJJTjhjMUlMa1p5aisvbEV4b0ZTeVg1cU9HQ1dxZ0h1WjdSeHZH?=
 =?utf-8?B?ZWczUm4rbzZ6czI4VVhzaEZlbEVkL2VxQVlETVBlaGxqK0dXNE9VcGJ2NTJ4?=
 =?utf-8?B?T0pjMFd3WDk1VkthOUlHSzJsZzcremdLNFNnVnZoZ2xTcHVoQ3B6OW5YRDNu?=
 =?utf-8?B?MEcvd0pZbTYzYUFLQW93QWYxcnp4c0dCa3l2WnhlQzlUdFg2LzRzMUJ1aXpv?=
 =?utf-8?B?SVRHTWZoVGdvTDhmV0Y3N2xnVmFKRVpRRGk0R3pLU1JxMmpFZk5tTC9ITEk2?=
 =?utf-8?B?RzNTOHJ3eWtYdHdVaFRabS9HOW5CbDhmb1hrdzYwR1pSenNJd2FsdXIrUnIx?=
 =?utf-8?B?elJZVjhvc3hDS1FIUThMd3BHUGYvSWc0MU9IZlJxTU56elFVVU1uREtKMjQv?=
 =?utf-8?B?NHlLSG5hZEFlTm9kdE4wc1MxblQxU0tWMVdtYnZXZTUzRGYyQVlXejJCMEFa?=
 =?utf-8?B?dkRtZDlFS1M4eGtQMnpBYVFNdkg5WXR3cTBYNmlkKzBFaGpPYWorOU54OERh?=
 =?utf-8?B?MW5kcW54TVEwSVJZaUo2aGdsWkFCU2lrNDkrVGpCRFFwU2dBRzdoN3ZvQk1p?=
 =?utf-8?B?RlpUWDRGV2ppOXd1L28zSWFTNGlLbWdnUnFpNzBRWlh3a28vNjRRT2wxdkhK?=
 =?utf-8?B?TTFLWkFKZllJWUdOM3d1UU81WmF2MXZPcENuYS9lTWkwSmJEMFppNThmbTR1?=
 =?utf-8?B?S0FyVWdheVlMdkJLSFF6dnpmSTExakllNSs4SnVBQUtCL0xSZW13cWV0SlVX?=
 =?utf-8?B?d01BR2hjdldkOFF4bVJ0SGJnN2JsaWFPT0F4ZlJIWEt2cWtFWGRDamtuL1hY?=
 =?utf-8?B?U2ZDelk5YWZ4WWY1QkdHQS9CNlpldDlUU05iTjljWTdRWlBzSG1WWFRoWm5n?=
 =?utf-8?B?clZYVFNydHRBeE96RDU0SzFJWEdsTFhYYXlxVWdqTkQ2T2JybnhXKy95Y3RX?=
 =?utf-8?B?R0Y4TXlKSG5ZOGhKNVgzanV6eWQyOGxWSlFUSFZkMkVRcEdER1RWQ3JCZThr?=
 =?utf-8?B?MEtjUGNKeVI4Sy9OTG1BSmVsemptbHJqdG1heXNJWi9YVGQ1d1hYYVdkNXpM?=
 =?utf-8?B?RVJJT3RNbVk3MTF4dlNUbXVUTGZETkJNeDlZSXRlQjQwM1J5MjdkQnh4MXo5?=
 =?utf-8?B?akozelNWVEtwVFFlNU9tRDFvTnhtV0w1WC82cXBNRGpqWlRDS2k1MlpYYjI3?=
 =?utf-8?B?b1RlTVZKN0l3NThYblZaL3UyWFVkeXNnNkNEVzM5ck5SZUh4Mng0VmViQkND?=
 =?utf-8?B?UFdKUXlCbExLMGVBdlBIcjZZcC9ndEFia2tEMk5sLytLR3ErRk9pNTNpdUdp?=
 =?utf-8?B?ck5HdU5xU09HTTBhb29vSlJQNlFJekxYK1h6aHFkU2lMT0k2b2JybEhzVkJq?=
 =?utf-8?B?N3FleVFORXJ4SHZRelRPbU53SFBLZTJmMThZcGpDYW1mSUFGYkM5WjZMQzlM?=
 =?utf-8?B?VHN3YkRCZFczc0pJemJuK0RJS3VDTUg4Ly9POG5OOHJiU1I2YWRGeXN4M3Bo?=
 =?utf-8?B?MG85YUd2ckFYNGxteHRJTkJhWFU1Ukg1T3pNUk8xUDRoWjJtN25XejdaaGVt?=
 =?utf-8?B?c3htZ21kZVQySGlBU0ZTMVNTZUZGSWpXbXdPc203Y2pRNUFEUlZrWlA2dXV0?=
 =?utf-8?B?MG9YTnpLN3E5OFlMZ05jZjY5T2QrRzA1b3VSNm0rbFk5Q0xwazlmZTBXbVJE?=
 =?utf-8?B?Sk4wY1B5bTZ5VnFTZlU4TWtmOGZaSTZTR3g3VGZVci9zRFpGWmtqeXhmNDZo?=
 =?utf-8?B?Q0N1YkNReFAxNWZCRWp5M1UvWDRsYlMvVkpQTk1PNFVzZlZTTFF6S2toVjcz?=
 =?utf-8?B?OUtBb2RwK0wvV3YxVFJwcnUrMGV3MVZpSEhJdHYwNTV2eEhKcDc2aWRpSWVR?=
 =?utf-8?B?cVpNc05RenZoQnF1T0cxSUFXUWlkOHhuc0hWY0dpelpyeXpaTk1mMUdlVGFZ?=
 =?utf-8?B?b3ZjUllZTFkvM3d6RzlKcHJKQW9xUmxpVDRndlh6NGtlek9vQTdGVk9MQTJS?=
 =?utf-8?B?V0JVU0xaVXNnUFJBenZESC9qekJhVDhRMTU2RFdhUVhLdFV6Q0Uvc2p6NmZp?=
 =?utf-8?B?UXQ1dXFkYjZvT0gxQlNrZGhnUi8zVmo3VDRmUURDcXFpS1BNd001Sm9rUndO?=
 =?utf-8?B?OVVTRE1jU3RETnFCMk52aVRpNk90YTUwQ0FHWmRBWm1NTmxreWptcExpbnJW?=
 =?utf-8?Q?r8LuK/tMwAe/i4Xn6Jiy0rCNSWvbRJ68FbjR3gXEh9aTa?=
X-MS-Exchange-AntiSpam-MessageData-1: vy6g0IB6w5yMow==
X-OriginatorOrg: vu.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: 9478d082-9576-484c-a828-08def309dc3e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB5573.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 15:54:41.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462a9c9c-2da6-4bfb-b318-0f83043fe49b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H83nKPyjk/ESrAS7bJJ4KMPUrDPePBhHZ1xVjFGAueR7IZURbDmyygIvHNax3pzK/zEhF7AoordLd/5SSKHopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6196



On 8/4/26 12:02, Greg KH wrote:
> On Mon, Aug 03, 2026 at 06:41:49PM -0700, Dmitry Torokhov wrote:
>> The user-supplied event type index passed to EVIOCGMASK / EVIOCSMASK
>> ioctls is used to index the static counts array in evdev_get_mask_cnt()
>> and client evmasks array in evdev_get_mask().
>>
>> While the event type is architecturally bounded by EV_CNT, speculative
>> execution may mispredict bounds checks and perform out-of-bounds loads.
>>
>> Sanitize the event type index in evdev_get_mask_cnt() branchlessly using
>> array_index_mask_nospec(). This clamps the index to 0 for safe array
>> access and forces the returned count to 0 speculatively when the index
>> is out of bounds.
>>
>> We do not need additional array_index_nospec() calls in evdev_get_mask()
>> because evdev_get_mask_cnt() speculatively forces the count (and
>> resulting xfer_size) to 0 for out-of-bounds types, preventing any
>> speculative memory access to client evmasks array.
>>
>> Reported-by: "Wagenaar, C.C.J. (Chris)" <c.c.j.wagenaar@vu.nl>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Antigravity:gemini-3.6-flash
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>   drivers/input/evdev.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index 5764c98b4f1f..796ac7ac2b8c 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/init.h>
>>   #include <linux/input/mt.h>
>>   #include <linux/major.h>
>> +#include <linux/nospec.h>
>>   #include <linux/device.h>
>>   #include <linux/cdev.h>
>>   #include "input-compat.h"
>> @@ -67,8 +68,10 @@ static size_t evdev_get_mask_cnt(unsigned int type)
>>   		[EV_SND]	= SND_CNT,
>>   		[EV_FF]		= FF_CNT,
>>   	};
>> +	unsigned long mask = array_index_mask_nospec(type, EV_CNT);
>>   
>> -	return (type < EV_CNT) ? counts[type] : 0;
>> +	/* Returns 0 for out-of-bounds types, including speculatively */
>> +	return counts[type & mask] & mask;
>>   }
>>   
>>   /* requires the buffer lock to be held */
>> -- 
>> 2.55.0.629.g250fe7f194-goog
>>
>>
>> -- 
>> Dmitry
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Dmitry and Greg, I appreciate the quick fix and the attribution!

