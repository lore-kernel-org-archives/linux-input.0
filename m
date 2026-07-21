Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A046DFE9
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656372; cv=fail; b=kzx/9OMwJHbAnF5FijeTJluPXfneT+8ux15KnAsK4NPPuLbtYdizk5T2V6QlPaFYFhhQO+Re+IWp7btJWD8xYYkmvL3+yObRC0721c2v9BIT5ZSrbHYZkE3wxRZfkQOGqmeL9O3D7iy3xh6k0PfSGfEoZ4qleWbNeuto8EiWuMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656372; c=relaxed/simple;
	bh=4Zglte7rta1emeTtW1IigR3P/8Rj9o5yuKqagTLu2T4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgAJVM72b9cARLkprmRk9F3MJ2nQtnp3o3TP5tvTOEDJkTRvRPIxz9s4AFUlJCV8F+3gJ3Ov3h3JtkjRnJvNhtnQ2ERmbcsOdAU6+Cls5TNDpD/KmOtbs+5Y12o3NOSoq6ANo2kYu2ZbEjhovqtFkN5SnV1ipCIqqRtNyoweldk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjMTr0zM; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjMTr0zM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3q+tWvpe0V9sb8z9wBUdswlgmrQ6uQMTU9/hSMhdwgT4Awp2G/eMOLfbBHilwnzkSNLH0XyYOlU0LUyLZfq26kZDt69AygO4oV1KGwNfspudUU1re+IVjGwUSZ8EY4DQCstVz6zsnORmKwGi3PDtA8EZVboha01Purzyl4n+fH4ttTwqLogcccInCNsH5jCAaIqis11ZQF0/C2QAvZCCMVOMYYFma50XxsJRFXMbQvjYrVtVHWT/03xLuoY27DfKEx+T0OUvs/0dfao/MMex5uJuNB81X4xd/0qXxYXPnfO1ekyvuBOSTdf0D9cUPx4XQmbIIzOfTOMB+Q9Uzyceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvZJxn2lYnOrMnGf2t4wT39X0Cl9REu4/EIbuN4A9PI=;
 b=Phw5PNxvZplOIpl6Cb4cSWGazLq+W0Of9OuHhmv4SdA8LGqKkOWc3rRzwDOF4gVsDRCdDclDkb5V/R+d8sScVO8LSpdllXu5w1EnxBqva38MmKZC2eWmFMAgGeeu7wQ0oAQynr7P9AHUpSAxN09S9wTpkL3t/VtQBzxZ9EkANOGdnIEBIBKzCwlQ34Sydrtrrhpnm8ziA70YAnVdboLtKPossQLSOXjU7gMDq29LlDGNqEiLcfvnsjfbvhKjOCfUT7um/jISrcRlTkUS/Y1GaVyYViEmmdgPubCBGbQT9Mep/8/xBze2aEooDqPPBNq66w9AE+YbX8vhHX0y7bR3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvZJxn2lYnOrMnGf2t4wT39X0Cl9REu4/EIbuN4A9PI=;
 b=vjMTr0zMMohq0ye72l1Zjy16b2ApxPW47G0n7WkwzaOHzjiUMJKrbk/Q33U1J4C0rOlw7VOvQ2Q08f8V6W47Q5JuMAsNFjh+oZ01RCH09pfdw8NFjwdBPvef5Tx4RgoDJEqB129yZnsU5o7cf69R/0yzwsQbPMxO4e8TtG57W5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:52:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::94f:c77d:ded2:28be%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:52:44 +0000
Message-ID: <b128d96e-5a05-4ea1-9356-2b4f7169911f@amd.com>
Date: Tue, 21 Jul 2026 23:22:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] asus vivobook tablet mode
To: Helge Bahmann <hcb@chaoticmind.net>, Jiri Kosina <jikos@kernel.org>,
 linux-input@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com> <5234335.GXAFRqVoOG@zephyr>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <5234335.GXAFRqVoOG@zephyr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fd3e9f-3055-4bb1-f694-08dee750ddd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mq3k07+qdUS8GUEqVZE7m5QnpPJjnCgmsIcWmgEd/a4o2XMAHsXEHD21OLdiki1VBMT1pm7bLehQMMrkRvGY5LrwTSyriqhlf3UHtxjmJI7dQ/OeUQS96KN1/uEz6U8gkG0/hS9CWm3iwS5/ipy+AnPfj32/qcmWt/4xgzgb0xDdF5ozL/rpGJ4HtjO9mW7Gh9W6V7UtBh31dOyDnDB1kX468Dbq/XxffkuFncKSLjWqt60IwpYfPj8Mc1f8XHqxxaQkPI+KdiOEw2DdbpFWHU9xaJbJS+8XHinc/H9m4sN/WVpjdsTTp6LKoL/zh4dFnfWuRIUSO+q2xNMcp81ZqBk0pMxZmwaCZgNqIxPD/IUx/0h6v5hstksJxP1/RFSV8zZ+g/7i6RT7JRT/7rsHxL0Ohndnhk4aTOT24TUwM/p61gUbRzUWqjwBSH3hL03KntclWJ1B8Fk4SZgicoOH6dJdz7rW+t6mW5odfI65NC7LbD5T9/lSUAwLUjLkxMKJOa8a97l4BJBdM0r8jGwKi/8LP5XhYbm/FoYVXoFid5MYHHgFF/WZa9fXAD8+VMipl7gFlq1qRk6kkESNAUAAvK7Ys6zuxK3NZYhKYCTnOociw95l04sywc2UHp4mQ4/GWs2XqiYbOwi44i7WdiIXZZbSkCKfl6p3xenW6o8BiJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmR6SUI5bkVoVjg5T1I4cDQ3OHlrWVU4Kyt5U25laXpRMUY5a0dDTzVtTFhm?=
 =?utf-8?B?Q2I1WG9DRjlNRHNFQkpJZlZmVE9aOU50YUNlOWxieTFycUx1VnV4TjVHQmRw?=
 =?utf-8?B?a3hLQys3am84cGJWOTF4NjFTWG1FZVYraEtIdXhSQnd1UVFxdWVGcnFQUU84?=
 =?utf-8?B?OGJhNDMwN1UyZjlCNXF4UDg2bncvZ3ZUL3JJbFB3cVp2WDZXQll5MTJOQmUw?=
 =?utf-8?B?MjZKTGVuTFNicjVTeUwvckVkRVBkV2QzTnlSSzZCMXJINHpBWWtyTTEvSVBv?=
 =?utf-8?B?MmxwcERpTFI2N0RQN083V1B6c2ExbC80S0pmcDM3NlR4dk9jOHVDUWJXcm1v?=
 =?utf-8?B?TUw5bHI3K1pyWTVSWTFKelRhQ01yS2NIZ082dkpqc3lUdFlscXAwclRPRWp3?=
 =?utf-8?B?QTFtdk5SaEk2RGJ3QkNvWVE0bTA2Mk95dHhrdTdKSUVOeTE2Rys4VFFXRjZx?=
 =?utf-8?B?ejZVQzB4THd1TVRBdGdlTzVsdW1QUitQMko4VXp0OFpHUXJOSHdrdVpmZ2NH?=
 =?utf-8?B?dXlVQnVvazUrUEZ2aVJuZ3lSc2Y0eS9VNy9WY0V2ZzVndUIxMWUwQ09Ga1RS?=
 =?utf-8?B?dXR0Um1jcEpGZ3ZSTGV6eDBZdjNQNFdSTFZHY3ZFZjBpR3lSc2cwZlRwWGpW?=
 =?utf-8?B?eHorSDhCcE9TbjNmMHFmbHJmWlc3aFBkeE9QcDNud1pqZllQbWtLcU56Mjdq?=
 =?utf-8?B?TzdNMnNnSU5GU1BuTWhIVnBScXRMUWVwWGd4NDNLY1RScEhWZEpBWURNS2Vr?=
 =?utf-8?B?WWE4K0dZSXVVc2ZwcHpGOTFJSEM0R1JjN1ZvMU5tenEwdGpRd3lZSTVjb3ht?=
 =?utf-8?B?ODkxYm5LRjBIK2k3Y0xrbGFnL0o2Q0VaKzY1SEt6UjRtWXdwYzFiaWVKdXZj?=
 =?utf-8?B?ZjhyVmRoakF0T2tsMDVZSWdFWlViR2RENmdwR3RZSGtSSFJLWCtoYlVzeFZR?=
 =?utf-8?B?TWlYbitGc1ZQRnptWWpCSStTQ3hweE9tc2VHVU1MKzFob2toRHJmVDBLenow?=
 =?utf-8?B?anZhS1luWExhamgxeFdubEVjSVI2L3ZKbzd5NUlmU2V2WjFRMDg0RW9YZGxD?=
 =?utf-8?B?c0RQVERGbVFOMGIycWw3VTkyM0tHRnlRdUdld1FNTW84SnZxcWV6NWZzL2JD?=
 =?utf-8?B?bHM5M0p0bS8xenFDUkFnZENIa0lJbFJLL2N0RVB4Zm91R0hFQkRWTW03SjBU?=
 =?utf-8?B?VmdsUGQxUE9tSFoxS3c5cmdNeGkyMHg2dDYzRUVMUTFOZzgxVnZPN2FScmJj?=
 =?utf-8?B?VUhkcENqMUY5dEl5RHpqeXRocGxWWUhGNy9vTEc3YWh4aHY2blFacElrRTN0?=
 =?utf-8?B?NHlMSHFNWkZTTVFXemtuV3k1b1ZqSmE4RTFoalMyVlVMMWwrM1ErVkcxL2lR?=
 =?utf-8?B?c003RVBGUEtaY3FwOVhyNC9OSWU0d2NMbFZWc0JGRHNnMkpwWmVOdzhselhj?=
 =?utf-8?B?d2ljbjBOZlVlSzVNN0wzVHlHK0o4UFlSVy9kSlBGOW5sR05xNHZEblp2MmFr?=
 =?utf-8?B?bEF0aExCVVhlN3BNUFVCU3NtQVI3NWJRN0xLQklWWGpKZ2dyVDRFU2U3UUlU?=
 =?utf-8?B?aXhiQjJpNEJyUm4rNnFEaWFocnRkZGpUREJtb0M2ZGxhVVFuZVdDSmxHWHo2?=
 =?utf-8?B?UUJKOWlYREVna0pvN0ZaMXRsekxYdFdVQm9MQmpqaWZtMFNKODVZeVpiK09B?=
 =?utf-8?B?U0Q1ZzVlTDdhN0ZwblNUT0MxU09SLzNMSzI1QUVXRkRnV0JRSWJDRDQySURN?=
 =?utf-8?B?MzFsWlZqdDBaY0pwdUdWRUhEL0FiYWZBaEZyS2RmdHRQcW43a3B2WDN4MWcw?=
 =?utf-8?B?MVdMQzVQQ0xrSU1IWnBwZUJLazNHMHQ5a1hRUnFrdjRac2srVG5MdnVoc3pL?=
 =?utf-8?B?VXhKOTZKYnc1WUFtbWo2NVhzdTVYYVBpTXRCMFlhTktVTG80NkVGb0RHaUlK?=
 =?utf-8?B?cWlaMzlMU1JndS9MUlVTcjhNeXRjSnpFMmM1bTQwTHdYQzQ5aUt0U2ZxM282?=
 =?utf-8?B?bENUQ2dnL2M2YzI5bUFsU1F2TDUrdWVmWE5HQ0xBQldTaUlxbXZJUktURjA4?=
 =?utf-8?B?cGYxcG5TZVF4a0o3TEsyQUU1d0gvV2M5bFIzSUQ5Ty8wcXJCQmp6RFBaOEE1?=
 =?utf-8?B?aDlocThEUlZaS1dCS0FFaEp5c0NyYmNPMENYYy84dTFqUVErYkNQUGhIL2Ur?=
 =?utf-8?B?N2diZC9laDFBWWlWaXBGeE9KbklWbzJBVzZRdXZiSWZLNjlQYTF1ZlZZckxR?=
 =?utf-8?B?b05NcXdRK0tSdy83Wk9wZjZVendZOURPd0NLME1uZzZ2d2JIQ0hhZFpxeHZ4?=
 =?utf-8?B?L2FJb05aVDdvN2VNMWVyT0FBSktPYVNLaW1VZFhqMS9mdkhBTlB3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fd3e9f-3055-4bb1-f694-08dee750ddd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:52:44.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZw0+1/llUJg45IgJDnDzfhOEIE8HjOrQlY0vDBmsI2ASwZL5FkscM17TV1zOYU6rwfJwfqYevd5mX5awxKHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727


On 7/21/2026 7:58 PM, Helge Bahmann wrote:
> Hi Basavaraj,
>
> Here the two patches implementing the split hid/input
> gdriver for the tablet mode support. I mulled over what
> exactly to use as report descriptor in the hid driver, and
> there is no clean and easy solution -- I hope this is what
> you had in mind? I could not figure a way how to do
> a stand-alone input driver without doing any hid indirection,

Hi Helge,
Please find below the series adding SW_TABLET_MODE support via the AMD
Sensor Fusion Hub, covering all currently supported AMD convertibles

   https://lore.kernel.org/all/20260721174422.3109166-1-Basavaraj.Natikar@amd.com/
   
Once this is merged, the ASUS VivoBook quirk can go on top of it.

Thanks,
--
Basavaraj

> as I simply could not find a way to bind to the physical
> dev twice.
>
> Please let me know in comments to the patches how you
> would like to proceed.
>
> Thanks!
> Helge
>
>

