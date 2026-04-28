Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F532936C;
	Tue, 28 Apr 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394705; cv=fail; b=bWSfBi1g4YP62jjRgEReDUp729Fuz0QxzYuTIre/2DM7f9avfpWdwpG+lidBmMPWplnheDxLO21P/0K3kE7kNMS96ST+8S0RW8sk1yJnUfCcyHhXXpycMKPf92vuboEr4IBM40iZMkgc4psSgJBPnJR2okpE9eOHcS8ojVHLgjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394705; c=relaxed/simple;
	bh=ZciEy8uXhXdUzEuKg4jHEliIV4MEYIiNfXOfFE75UgI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=ZK+Fx6COO5mbT5nIbTr6qIVZdp3c/FCi58lbevD24dFKP1dv6NlL2J9BiP/auUccveACk39aKQl/wtThj5OvvMOA/2ELf2ttbA4Q2CWDR5rm2zbpKkhYF2DzTzAh4ibKGzkww1YdvCP6d7ndLh4OSyBjf1XeEfFG8zzWYSfGhiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dVmDVYQu; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dVmDVYQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyl5NPhA6WD+rVTAuKKvUK1QlXGrmYUaKz/Yjv3vpvQgDXz0N/qCbR+DGTWhq7HFuHHL1B+Lmo8azGssFO3/pTMsTsnuWDxv3IDN+yRsHXYoISiBdCC8fX6GZzXMsXlGequ2pBvwlqc2fc9kO9eRJ+rIGKp+ptIhCbSUdvExvweNdh+MILFcZ6B3Ss4iTVcoJOnVvm1imzz88+SpBjHH0LlzGytXrdc32M4p0Eu9AngvX+HTwyp8JpvbIgkUvj10auhgJBUsTSL7pFYaHGcVypSzpQevr9SxcHklAKeTAFvxnNkuH0XdTA5y6galh+e46o8PLR6Lyvej7bf8j79zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LBjQ6i3R/DV5W4+KFDbAG1HrridEQR1oqc055mruSU=;
 b=xcYB+5z8UL/SuM7msCUnma6ssWwyD4g9Hm0N/hpPAz50GkOFjDZmIH7t/VQkzMi157BD4p0LpJ9sRrWXAPwvtCXROl19WotR+oPAokW4cK56r0FYPRdjQA2JSEVWeV2ExHtBKQGcFeGEbZ/EFModC3wavyJmr2eWqnIZ5XlefTxLjbw+Or+a0tOjlTaAwVQJFdrE+TV+F02fLpK9ELpmdRSZ+9Ql4XtAyHwH65Hcvtg8n0z1ILhXh6BPBQKTU7Xabc/1+HRGM3azJ8q8FHLBknS0tyR2ZBFfsWTiGAfPu0cSFob/JNJG8n7jNfriZhiNPMqSgDIWmb4fJz7HVim6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LBjQ6i3R/DV5W4+KFDbAG1HrridEQR1oqc055mruSU=;
 b=dVmDVYQuHE/G4hamQ1DWCdTW6Y1S2y4PKnrvbEfvEAenG25iRmZkxcD4EvPW1Lli4jXRSAUMO9xiQFCiAdfuki8u779UMmLJaZUrtnw3WRDwU9nZZgf/F4cOe1xzlKHpnkuehZ1myHHY64GNZ+0C9/MiwQzBAYoF3hqvBwuRGcJCCXI9grUFe73yRYA4VhDu2emu9bwRh42p2uSxqmErCqtlBHBvCp1puPcKuuPBgwL5j58QPcMgYTIdvFu6hftJGLxMVYaLwpE+5vm1muc6mWByO/NbmBQdsZY+2K3omPJ1pihPKCAmMfbWFWaCnHe5RnszzabgEREpy5U/QzF/Hg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PNYPR01MB8079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:53::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:45:00 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 16:44:59 +0000
Date: Tue, 28 Apr 2026 22:14:55 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Sangyun Kim <sangyun.kim@snu.ac.kr>, bentiss@kernel.org, qasdev00@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_HID=3A_appletb-kbd=3A_fix_UA?=
 =?US-ASCII?Q?F_and_mutex-in-atomic_in_inactivity_timer?=
User-Agent: Thunderbird for Android
In-Reply-To: <s3qr2s36-n156-4srp-771s-20130s13760r@xreary.bet>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr> <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM> <s3qr2s36-n156-4srp-771s-20130s13760r@xreary.bet>
Message-ID:
 <MAUPR01MB1154677622C6F5881985851CBB8372@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::12) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <8912D75B-3F99-4E20-96A9-A6B989550F05@live.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PNYPR01MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fc1d5c-f726-439e-0ec5-08dea5457ba9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|461199028|15080799012|6090799003|19110799012|5072599009|8022599003|23021999003|55001999006|24021099003|25031999004|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eStYSkRUVmtmSlBVMUcvVkt3dkllWGJDZDdjWGdVeFdkY1AvL3BHMVhEODFn?=
 =?utf-8?B?WlM1ZytMMlRmNUd5UFpQSEI2ak1ZTldWZmNETjM4SkRWY1ZxdmdyYzhyUmhn?=
 =?utf-8?B?VEo5cEd1MERobUY3M29CeGJRdmdraWxsTEw1NDAvUkxLV1RxYStvYnExeHRL?=
 =?utf-8?B?QkNSbktVK2h2SHQ1bm1ld1lucHFmV2J2Qi94VHlKRE9qYU1ra3BONXp5QTZQ?=
 =?utf-8?B?Q1JkZnZ4ZHVpZnpwTkFjemN4ODhuME1manpiYjZxMExydmpNY0FkNzU5OTF2?=
 =?utf-8?B?NDgyejJQclBRem9GejJiVXNxajBMTWN3cDlYQllETWJwdVVGOVRidXUvUFJZ?=
 =?utf-8?B?QnBGUU9sNFloQTRFNVVDQXhibE5OSnRkQU5WTXBPaCszTVZsa1FpUmhSY1ps?=
 =?utf-8?B?NU12UWloa005NU8xOG9pKzhKd01sQitwdUlCbEhucFVpWHFwdDdYM05vV05Z?=
 =?utf-8?B?YTk3dTg2MjhwOTZ4R29kOG16MWlqeGphSGsxRFY0RWdWazdLR0FrUEVDWnd6?=
 =?utf-8?B?cWRCMUl4WWFNVDhERXBBQ0NGdFVCV2NPWVExRXIxUkZCNUdDeTRHV01rcVVx?=
 =?utf-8?B?VnpTZk9HVnBJM0huVWdRWWR3RU9DSms3eVhlaENSVklJQnFNSkYvQkJ5VzMz?=
 =?utf-8?B?V1NZZ3NRYll0bTFhbXVsSWJMV0NjSjk2K09od3dxaXBBUEN4aWtOeVVnQVV3?=
 =?utf-8?B?NHpSREhjQnBqdFdYUmwzVFFxVzFWMngvZDQ5cUhQMUFHekZEOThLVGxJZ0NB?=
 =?utf-8?B?YlQvaEU2S2xoZUE1NW5LUWkrNFRKTmRURE5WaXhUT25qeEU2SGFuSnNxZHhx?=
 =?utf-8?B?LzZwQ1YrU2ZrdTQxSTZvVmdncDBQWmxaWEpCOFhMZ1NtMmJjZC9zZThhMHpW?=
 =?utf-8?B?R29IaDJIQkcvOGVOR0U5dTBENjZyVWJxY3RCTStETTc1RUNoSjIxc2diWE9E?=
 =?utf-8?B?d1JhWkdpR1hIVWFmY0Q5dmVQeXB3YStpb2JoUEsrWTRlWkZWZHl0dTZxSDZi?=
 =?utf-8?B?WWpxR0QrQ2RmUkt3U2xLQ0RIQjNIdzVOdWJCQnZoQ2VpUW9icENYY0c5SHIv?=
 =?utf-8?B?bCtLaEdzSGZuYXdCMDY5c2s0YzVaQ0I2R0VtcEpJMEZobXJTekp2aGpaQS9K?=
 =?utf-8?B?QU5DMWFPK1hVRXZuZHBBRHIraXFEeFY5ejNRaDVoVUNIVkhzMVZpdTc3Um1v?=
 =?utf-8?B?aXhpY3RkUGoyTTRxL0FRTWNZTHB4bStsaVpwak4yaVpOdGMyVTVjZE55NlhT?=
 =?utf-8?B?cVBiNU5xYjMvUXJhVkg2bG40dUZpcmJyVGwxVHhLY01Mak1pMkdBendNbzQv?=
 =?utf-8?B?dlFrSmhhZU14cVozNWhMZFpyYlhTZVpoRHJvR2NERkVtbmFpa1U2M0h5emU1?=
 =?utf-8?B?N21reFdBdjJWNktaVXNTemk5ZjhYcXpxM1VrUkZjMGZzMFlqQnV1Sm1EMWFB?=
 =?utf-8?Q?0UJ7H28Y?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRWZisybXRVd2lJRGJ3TnlmNGhGalpmR2N4K2dQU0lUSHFvYnR1T0tGZkxw?=
 =?utf-8?B?MEtjKzMrN3Rya25JV1F1aVNxVjVlSnhrK0Rpb0kzVFlOcnhtdVduVzdLc3Bw?=
 =?utf-8?B?aG8wK0UzN3ZxK0NZUmorbmlDL0pBVlVDbWdjbmg1cTFxOVhBbWdJUkRDM0dF?=
 =?utf-8?B?RVUvUGcybzhCT1kwRVYvWi9PWndpbDFLV05Cc1BJTXAyZU52WUxHRkpsZzEx?=
 =?utf-8?B?UzBwbTkxZFkxbzlNclRxYlRSQU9sOVUvR090UXJrNGcyemlVSWFkdDVkbGxk?=
 =?utf-8?B?UnBKQ3I2R1RudEpESGhaQzJTYnU2Zk12aFgrSDBFa1BUQUVJb0xaUDVwZUpw?=
 =?utf-8?B?TnFINVBId1ZUeWxScW5hOHhjakJVQkRXRmNnQTNmY2F4WGJlOTZJZG5oTFhM?=
 =?utf-8?B?b1FkKzNjdXFTeGZ4Tk8vTUZQMTYzcDFVeHlJOTdZYzcxcmpZWGxpVXBLaHQz?=
 =?utf-8?B?Nkk1dUdtNS8wZ2VLbG1VbGpHd1cyWDZHczlGSFBsRTNsbVg4MG16cFcwWUpr?=
 =?utf-8?B?ekNFL1ZaOFEvMG1QQTg0dE44TEZaR3F2WG9ESFBrYlV1eWtNbXhvRzJhZUNj?=
 =?utf-8?B?bE5tSkxZY0RtNi9aSW9wTHlqZ2dtT3UvZ283ek14UDBzbFhVRnQ2MHJ5cTdY?=
 =?utf-8?B?c1RNdDZhL1VjelF3Q3BuZXZKS0JoMzlWc244RC9hYkV6dEMyN2J6dExuSTFq?=
 =?utf-8?B?SlB3UU0vUzlHUDk3bzI0QzlkS2Zsc0ljRStqbHlNdTZzSXN6TmJNdTVvaS9s?=
 =?utf-8?B?RkV6R0NKMHVGTzdnR0RQczhwT2JaVy85UXpqZXM1Z0tuMURGcXRXaThyT1dW?=
 =?utf-8?B?MmtNemdxMks2ZWg5THJySk14YkszYWdlR0wybEdiT3pPZFBJWWZyaWUvZ1Ev?=
 =?utf-8?B?eWdtdkpvRnNtZERYTFRWM0lLOE1MMzlBZlNNbEh2cStUVWdNYTlMYTF0SUpv?=
 =?utf-8?B?SHY0U2VReWp3ZDhVUy9kVStxSFZ6TGNnb1FPTnpvZjdWYityQ2c5aldQc2N4?=
 =?utf-8?B?VXpHNEcxald6NllBQWp2Z1hqZHkzNlVXQVREMGJoSXdrekpHSUZwa1V2VXBL?=
 =?utf-8?B?ajhobC82d3lUcks4Y01CdjZBdVJtU0ZDT1dCNUkwMHo0Q2JrTlRuYTBwWlRz?=
 =?utf-8?B?VXB0cUlCak0vU2dzeGI4b2g1YitCSjFTdVFFNVpoc2hHYVpyeFoydS9TU0U5?=
 =?utf-8?B?VVF3bGJvTE9UQkZDS1hXeDhLU2ZvZzk0UzZUVUF5WWZlaUFNNFBmanZPS29J?=
 =?utf-8?B?ZmIyNm9kcTAxRkdwZzFxSWNIdG5PcHBJV1plMVlZTkNMSi8wdEx2UjVNdXJ3?=
 =?utf-8?B?UTV6T2g1aDdTYmhXRnlQZDIrS2FHeSs1RzVMT3RBNFNHOExnOE9FWkd5YXlq?=
 =?utf-8?B?dXd5eFNWTG1iODh1OW9RQ1NEYzJ5MmJZYi9hMERMQjRpaWxOWjVkZzZGRTV3?=
 =?utf-8?B?aGl4bDJEcEFvTElpK3JmWEtXb3Zkb0JmNEd1bWs3MUZXcDZ6TExzYW1vSVRu?=
 =?utf-8?B?TFFYNFZ3U2tIK01hZUZKVUw1NjBRRmQzV0lHMlNEUzFaOUVSLzhLSDlLN3dv?=
 =?utf-8?B?bG54MkxPSTU0UzBJOHg3SU5TbXN6T20xQWgzd1pBVk43amFvc1N4LzJ4eVQ4?=
 =?utf-8?B?am10VnVodmY3eVFKUWtGVXBOTHoxcFhXRXhUQ0FBNnhSbG9aNTI0MkdSZEdr?=
 =?utf-8?B?eWhCdGowcGh1UnFjZzdCc1daekw5cmYvYUVFSm1CbENET29IVXl0VU9wNTB0?=
 =?utf-8?B?c2RQY0xvSWxBVW40ZnlLZVBhUkdISUhkM1F3b2ZoNG4zYWlWWXFvL2RaNzJB?=
 =?utf-8?B?aDZYeHZFUi9ncWM0eTZWZlZSRVd2V0RDdWpVaFBybDM3VXhVbWRvYzlCMDgz?=
 =?utf-8?B?TGlaV1RCS0t5YnZMbjg0YXI2VVZkWXVQWUxmcmxPYXdaU1hJeVpZUkRVWFVV?=
 =?utf-8?Q?Xd+6mVUoLK/tStdyGHGb/M6/9CcyLZt8?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fc1d5c-f726-439e-0ec5-08dea5457ba9
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:44:59.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8079



On 28 April 2026 10:03:03=E2=80=AFpm IST, Jiri Kosina <jikos@kernel.org> wr=
ote:
>On Mon, 20 Apr 2026, Aditya Garg wrote:
>
>> > This series addresses two defects in hid-appletb-kbd's inactivity
>> > timer subsystem.  The two patches target different bugs and are
>> > logically independent; they are sent together because they touch the
>> > same tear-down code and because the same maintainer will review both.
>> >=20
>> > Patch 1 fixes a slab use-after-free with two related tear-down windows
>> > introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
>> > use-after-free bug in appletb_kbd_probe"):
>> >=20
>> >    A) Within "if (kbd->backlight_dev)" the order was
>> >       put_device() then timer_delete_sync().  A concurrent
>> >       hid_appletb_bl unbind between those two calls can drop the last
>> >       devm reference and free the backlight_device; the still-armed
>> >       inactivity timer softirq then dereferences the freed object
>> >       through backlight_device_set_brightness() -> mutex_lock(&ops_loc=
k).
>> >=20
>> >    B) The "if (kbd->backlight_dev)" block ran before
>> >       hid_hw_close()/hid_hw_stop(), so even after window A is closed a
>> >       late ".event" callback from the HID core (USB URB completion on
>> >       real hardware) can arrive between timer_delete_sync() and
>> >       put_device(), reach reset_inactivity_timer(), re-arm the timer
>> >       via mod_timer(), and reopen the same UAF.
>> >=20
>> > Both windows produce the same KASAN slab-use-after-free on the object
>> > allocated by devm_backlight_device_register().  Patch 1 closes them
>> > together by moving hid_hw_close()/hid_hw_stop() before the backlight
>> > cleanup and, inside that cleanup block, calling timer_delete_sync()
>> > before put_device().  Shipping both as one commit avoids leaving
>> > stable kernels in a half-fixed state where only window A is closed.
>> >=20
>> > Patch 2 fixes a separate "sleeping function called from invalid
>> > context" bug in the same subsystem.  The inactivity timer is a
>> > struct timer_list, so the callback runs in softirq context and calls
>> > backlight_device_set_brightness() -> mutex_lock() from atomic
>> > context; reset_inactivity_timer() has the same issue on the
>> > brightness-restore path (it is called from appletb_kbd_hid_event()
>> > and appletb_kbd_inp_event(), which run in softirq/IRQ context on
>> > real USB hardware).  Convert the inactivity timer to a delayed_work
>> > and defer the brightness-restore call to a dedicated work_struct so
>> > both sleeping calls run in process context.
>> >=20
>> > Sangyun Kim (2):
>> >    HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
>> >    HID: appletb-kbd: run inactivity autodim from workqueues
>> >=20
>> >   drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++-----------=
--
>> >   1 file changed, 36 insertions(+), 20 deletions(-)
>> >=20
>>=20
>> I had a very weird bug just once. And that was when I pressed fn key, up=
on
>> releasing, the touchbar mode did not restore to normal.
>
>You mean with this patch applied, correct?

Yes after applying that patch.

>
