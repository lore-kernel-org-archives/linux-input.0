Received: from eu-smtp-delivery-101.mimecast.com (eu-smtp-delivery-101.mimecast.com [185.58.86.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53589344035
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445552; cv=none; b=BSdNTGyhbqJL1oV98dWvKr/ieR9BY/aTb5WHYVjCcZXhm01ZRE43MAf0vFzE8id3HnAHQLI+w5QJjkj2+F5O/f+SXVaywAkQDIAqr6zAuIUIn37K0BGMtAb6a9nk3jifBIbK7t0DeZ3iGtNBEF+zTXJKl2u0lheIvs7gZWcS+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445552; c=relaxed/simple;
	bh=ehs/TW5o6C93FsFDJMKD2VLUaEgWLWPNwagtvHc+SAg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=nvflrF2kE4O2B5ThaSoso9q5UN/7GeEFzFbC+yCpDtHthVoRIALKUrFQEIGUc2xQhbxcv7CA0Lea0UmSIxulV7oikMGUfgtx0b4/GE83bXSYe2wmPfTIqf83WZHYEL5hLnZyjrskLAeo58QlE4Z8Sq/N0GC3bxsoLXa4kiWIUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com; spf=pass smtp.mailfrom=touchnetix.com; arc=none smtp.client-ip=185.58.86.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=touchnetix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=touchnetix.com
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022082.outbound.protection.outlook.com [52.101.101.82])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-187-4tR-Yqg1OXCJccuPP5d2OA-3; Mon,
 26 Jan 2026 16:38:59 +0000
X-MC-Unique: 4tR-Yqg1OXCJccuPP5d2OA-3
X-Mimecast-MFC-AGG-ID: 4tR-Yqg1OXCJccuPP5d2OA_1769445538
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) by
 LO2P123MB3824.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:12d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Mon, 26 Jan 2026 16:38:56 +0000
Received: from LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1]) by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4a94:a629:f86f:40d1%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:38:56 +0000
From: Andrew Thomas <andrew.thomas@touchnetix.com>
Date: Mon, 26 Jan 2026 16:38:24 +0000
Subject: [PATCH 2/2] Input: add support for aXiom touchscreen controller
 using SPI or I2C
Message-Id: <20260126-axiom-driver-submission3-v1-2-d462c4a608e3@touchnetix.com>
References: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
In-Reply-To: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Thomas <andrew.thomas@touchnetix.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769445534; l=27929;
 i=andrew.thomas@touchnetix.com; s=20260126; h=from:subject:message-id;
 bh=GB50aXuckUvQJOPovqpShsfnLyaN56CEQq5IrTGN6XE=;
 b=+52g9soMvfXC0DrRBDi99oZfK3TpnS6QK03HHVO6ifIGd7WmZdkthRXYBM35XZTMkBxbzoU6A
 8FQcnU+yhdrA8sfHoaaMQK7Pu4d3z3mbEVRrlxnoYJJvbXqTA7RhMCR
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
X-MS-Office365-Filtering-Correlation-Id: fa6899a2-2a4e-411f-1310-08de5cf964dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|18082099003
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmRzUWpuTERPQjNMd0VRYlVsdGhia3d5T2s4ZWtKUndHUU03QjlMYkhpd3Na?=
 =?utf-8?B?QnJHNTFsTVBRUFJiR1duVlhqbGxBZzNuQUFFN0RFajdobHMzWEVxZHk2aHpa?=
 =?utf-8?B?Lzh4UDI5VlFhZlUwbzhsdC8wNUhTbkZHQVJrTHVRTE5kMThiaFBmWTJyUVQy?=
 =?utf-8?B?a3BXdGJ0c280dG8zV3ZvYlI3TkRuS3RuMG1TNVZMc0lUYnJSbmJrY0YwazRa?=
 =?utf-8?B?WXNCSU9rNUJ6UmdJcm1udVNUUFdHc0g3aEVNeGd6bEZvangvK2J2eDB6dDVa?=
 =?utf-8?B?QUtpeFpJUFN1bU5icEVCTVM1M3hMeVM2RjYxdUNTUTBOeDQrdzZnQ0I2M243?=
 =?utf-8?B?UVJJQ0o4c2ZPM2t6anU1dExybUJFSktidDh3NjlUdGlNbCt0c1VvTEdpRi9R?=
 =?utf-8?B?K1VhWnlzWVZtK3lVL2dmSGlLNHh4V2RmMnFHY2h6TVJWNTNjZzUrQ01vNDkr?=
 =?utf-8?B?cHlYZGNPQmVPVGNYY1g3eERKQ3F4eTVYQ3doWkF2N25VN2J6U2E3dDVlTWc2?=
 =?utf-8?B?VFQ4TElLWngrdWlObzhNNWpHR25TVmhJaEIrajNaZTJPeWQ2c2ovelRzYURQ?=
 =?utf-8?B?dkxWajAwN2c1Z3NuTHZ6UmI3ZXltZFc2Yk9sMmw5NzNDVEVDc2s0WEpWRlJP?=
 =?utf-8?B?OWNod0RpMklXNUJTbk1qekxPbDl6YndIcW1VQzAyb3IyWlgzYXlMNkZOVmww?=
 =?utf-8?B?YkFESkFSQTc0aFhENllqMjBVdHY3cHlPUFdQY2FLT09Udlo1ZC9hdG1TZU0z?=
 =?utf-8?B?NHJ5elZvcnZEa0tlQm9IN2lkTW1PMFdoYk9POWZSMldqdFFZRG51TG5FSFBV?=
 =?utf-8?B?b1JhSU91TkVCZHlUNHVBeTZBbmFBUmRQQnRNTXU5TVBMTVl6OUl1OE5lOUxQ?=
 =?utf-8?B?Ui83K1I1aGp6K1RyWGhBdVkwTEFIRm92Z2E2REdmOXVoN0RVOFpEQlpPYUow?=
 =?utf-8?B?eVRWS3puaHhQSWZLd0NTM1BDUVBzd1BncXhVSHRsRFRyZWxUSjlQZE1TNG1C?=
 =?utf-8?B?WElHNXJqNGozRFlBb1BySFluZFR5UjJROEIxVnFQQnVpWmNzVmJmSUoyMk5L?=
 =?utf-8?B?ZzlINm1KWGFtZk0vdUFCSzFPQVdsY0ZBWm1FZUdMUWdPcG05azk0Q2V6UzZq?=
 =?utf-8?B?aytGT0x0K0V2WFNxbGI3RjdSZVFFTHQ0R0EvZzNNbWVXYnRoenZjYlNkWkYw?=
 =?utf-8?B?LzVkdHNaTUJ1UnB3N1dyWTF3YVQzZ0xpWG1ITjA5dzF6MnB1RmxKZVhaVGtG?=
 =?utf-8?B?M3JvMFYvMW5iclpFUXFCWG9hT21tWGV6b0FEciszZng4T1F1alEzbUVoUGRp?=
 =?utf-8?B?TTVjcTV5SERvNFBtSkd4cHJLcU9oUDFGVGFabzI4L2JhWVM1SlFsbkdtSGhI?=
 =?utf-8?B?bnlLVU5lWStSRXFhdTk3MWxxTWRZaXVrc1dLMXEya0VBWTR6Wmg2ZFdUUlFP?=
 =?utf-8?B?MlE3TzdEck1jdlBSMW9nRnJpZW5ZRUZaMHJ5ZjBzZmlRVHVkVVBUbEhtUE1L?=
 =?utf-8?B?UFNQdkNJOFVyeGwwY0VOUHJBdVJzNWJPdU5zL2VwQkNTQWQ0RWNOM2hCbGxh?=
 =?utf-8?B?Yk10cUhtMGUwMHdab1RIazRYQmVNNG45YmxHWGhweDA0VEpyemdFN2pCQ3la?=
 =?utf-8?B?Mi9ibnNoR2s2UVZVRGFURkJ1R1ZDSHY2ZzhhWDBlNUI1VHFPU1ZwNmFPdUNC?=
 =?utf-8?B?Vjhnb0pyL2RseS9HeWl2b0RBb2s4ZmNZNzlKUFNOdmhqUUxpcVh6REI3TE1H?=
 =?utf-8?B?OVVLcmVCcWZtNmtSTWJPYTRwSDVnUmtxamNHN2NXdThoMVZ3cCt1S2tIV0xN?=
 =?utf-8?B?UmtJR1JrYkhhdzJoL21QekZ5OTlaNHJtK045aTdHRlJIcTE1czNLd0hrTlZI?=
 =?utf-8?B?ZXBkcmNGT0ZWWURXNDJ1TTZEOElvVmhZRjdjT3VrS3A2NkpFaVoxeTdsN0NH?=
 =?utf-8?B?QXJmQnNyVXJxMDFuR3hlMjdHQVlXMkxLelZBN2xUdHZqOFBHMTZwUDVZZDQz?=
 =?utf-8?B?S3ZldnNzN3RkZnNhbDl1YXRKOEViTmNWcWxldXRycXlLOTFUSkViVDAwZGFq?=
 =?utf-8?B?RE54MnNJWEhnT2d2VVlZV0FWZEZzMVhGb1ZobUg0RG1pWUp1cm5jOHI0OTdR?=
 =?utf-8?B?bDJoNWZldXpoQlpLWDFUSjR2dFZVQXRRWE5sY2lxN2RqeEozTm05WHRwdEVr?=
 =?utf-8?Q?T8Qv42/gQ2CW7k9s53WgRAc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(18082099003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxpTEVDL0w5NHJzR0xveWpUdmU5OFljcmhoSmZXSDNqU0FDSllrc1hyZmZG?=
 =?utf-8?B?M3NhT3Zrd1BLVStrZXRmM3pOOTA1M0VVaEdJWWVzZzFKSzEwcGVielBFQzZ4?=
 =?utf-8?B?UllJV0k5V0tnRnQ4OFBRckxkcnR5MzNqcEQvSUdRb3haVytPZXlZeHdxNjNU?=
 =?utf-8?B?ZTM0MTh0aVEwUFVFTURKeDlheFJuVGhZdU5vSTlUeDM4a2xHNjJvMWFOSjFy?=
 =?utf-8?B?bElIK2VTNlpEelpDRk9ZUm5qNis3WHN5cWZmanp6WEROTU81ODZ2TjZtYVNt?=
 =?utf-8?B?cFo3VkVGTkx4OTRmaUZkZ0FuTG1BWVNPWlBYbFdNbkcvdnFxV1hPRUNWb3J0?=
 =?utf-8?B?MUJITlZ2b0lQSUZkWWJzT1F6eFFHMmJPbi9JczBBeEc3RWhzb3haenhjQ25F?=
 =?utf-8?B?UzJIZE8wQTFSQkpmOFd1bDBZVlJyTU9BRkdsWnBNWExWNnVWaGJMWm9sbTBC?=
 =?utf-8?B?NE1wYnkrV0sybjducFRUbDIxNXdMdVlmQUNibzBPdFZiT0lkaG5OcGZISlFB?=
 =?utf-8?B?b2hRbkI3NEl0NUxxVytXeERYNVhTSEZCTWtFa3RKdk1YdzEvbFA5SVlDQ3hV?=
 =?utf-8?B?L1U3dTlYYkVCMVg4aTJsc2NrcXVsT080d0lBeGxxaUs1TGRHTUJFZ1NBZDAy?=
 =?utf-8?B?aStUdGc5UGl2OWVJL0JjN0pRVXkzOU9LeUF1U0FnLzVDTVNneW1CdlQ1U1Qz?=
 =?utf-8?B?eDRRSTZFU3dKMldMeTh1Uk95TjlZS0xsamVheFhQL3d4VWdEVWZzK2xEalpW?=
 =?utf-8?B?L2xBUC9EaWx1cE5kRnRIQmdMUGs5V0Y5R2FoenJvRmMwbWM5MitlcXBXYmRx?=
 =?utf-8?B?SWY5VHJKc3ByWUdHeFJkY3lUamRRSEQ0dEZ5MTJsUU0vZVFCTVB0TXViM1Ju?=
 =?utf-8?B?UUF3SytzWmxMMDNQT3hJeUlSeTBmSm9mZVpsa3ZkVHNQZFUzU2E0aDlQUTZM?=
 =?utf-8?B?amprdjQ2WEJqQzVRMmhaV1VoY0J4SWtrMGJqbXpvcDhJbkszQkVnY0JYRHh0?=
 =?utf-8?B?N0JTSHlyNWprckwvL2xJU09qQW5VTEhSazk2QmQvUmlDdHVIWlRIcmxkWUh0?=
 =?utf-8?B?dzE0V1NDQ3cxVVVsMWVUam85WTRpTXlYcHVKcXhYQW9hSWZCMG9XVTJxSTY3?=
 =?utf-8?B?UW9VZUlJWGhnMk9LaU9RT1ZjK0JJcHdnTy8vYkc5ZGFKdVpNSlFOdnBTRWdI?=
 =?utf-8?B?WFc3NlJXdit1ZjJWMmFXWFJSdklLVWdaNEVIUFp2aTZZYkdubUhtV2o5Ymha?=
 =?utf-8?B?aHI3ZTZQeUZ6VW1sNmZXQ0k2aVk3QWREVFJSY3dFSnlvbG1obWkybWNaOVNZ?=
 =?utf-8?B?Yi9HaWVmRDVXY0Y0OUpBVitNcUdFT1p2REw4RHVnSnBhUjJveEFldVE1eTVt?=
 =?utf-8?B?VGRDK3VNUFV0M0dzWElZb0Njckc1NVFoUysrcGdpNTZrMlMzaVA0ckJwSEg2?=
 =?utf-8?B?L0ExOTZoZVJQWDRtNDhWUjlqeDQzNEg3c1d3YU9JK3BzcHRRTmFyZlJkUHd3?=
 =?utf-8?B?SDQrK1ZDbWFXbXh0azdZZWtjSjJ1ZG4wTUxHWTVRVGVWcWcwTWRDNXYwOG9z?=
 =?utf-8?B?M09Ga1QwVjBoMGpLeHBrQWE3QXhwa1B3cm93NmhnYXpxQWVnZW1kU1VWN0dm?=
 =?utf-8?B?MWM4TStSN0NLRzdZS2JMZm9yWHZwcVFLakdBU3p1ektGdGRueTMwNkpyWmxC?=
 =?utf-8?B?N29rZXZ2Q3ZXSXVLQW9ra1hFVlJMVHBWS1YxaGd4bWFUOVhOLzdUcTVHVVhY?=
 =?utf-8?B?aW12ZE1NTFcraTZrM2c2K2xIcXpiZ083NFRROTNOMjNmU29MeVRBN1d6Zzh0?=
 =?utf-8?B?SE8zMk5xL1ZjelVON0VOYnYzTllleHZUMzlmZXJxZk5Ub2FKMEpyR0R3SnZD?=
 =?utf-8?B?NXpaWUpwYTQ3NThmMVVWcFp2QUw1OWpnWlpURC9ldUhUc0ZkSCtRYnVyM3R5?=
 =?utf-8?B?dEdaT1Q1ejN1bDg2cXNDN2J5WFdlWmMvTy8zVVh3ekRUeHZTcXNhYmxCQ3FH?=
 =?utf-8?B?K1RDaEFsS21DcGc3Wi9QVlkvTzBUcnpzb3BORW1mL0FHMjJNWWVpRzhjcGNF?=
 =?utf-8?B?WmJ5KzZDZ3kzQ1lOMXM1ZWxjS2tueHNiRHNRNC9TWHRRK01LamxqSkZ6WmU3?=
 =?utf-8?B?MG1GTEpZRUczQVBIVHVEbE8zbU9tUXk2dnVlTkxRZHNJaGQzT2xXS0xaY0NY?=
 =?utf-8?B?a3loSFY4OG9ldldPVzVYbnBxa20yZEFuQ0JPc1dsQWMrcWE0bFZqaldGYWt5?=
 =?utf-8?B?OE95RFpGTDB5L2JQRDR1M2JxYWNOOGwxczlqckMzWDNSTlNLRnBJMXRzOGxy?=
 =?utf-8?B?c2Y2NWEybnQyL1h6TVhuV1BXeGNrWmlGRldmbS9YdlBNZXlZSFF5Sk5TOFBY?=
 =?utf-8?Q?LHiWQR5xQiljwkwI=3D?=
X-OriginatorOrg: touchnetix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6899a2-2a4e-411f-1310-08de5cf964dd
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:38:54.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 120474da-7cc3-44b9-aff9-438a33341070
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmRVaJRcG6jqMM2XESLsQHK3tWo1Qd+m7+UOvk8nh+XTL5P1es6AKRNHlcbSO3KxGt+hALNjihfQwCe79kVJuPP4Xf33lhmgfq/WaHGVAhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3824
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xYjiTpaTj0nf7XzsVKjNBYFOEwiBQ7X4Cu1Dyd1bwRQ_1769445538
X-Mimecast-Originator: touchnetix.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

---
 drivers/input/touchscreen/Kconfig      |  25 ++
 drivers/input/touchscreen/Makefile     |   3 +
 drivers/input/touchscreen/axiom_core.c | 473 +++++++++++++++++++++++++++++=
++++
 drivers/input/touchscreen/axiom_core.h | 118 ++++++++
 drivers/input/touchscreen/axiom_i2c.c  | 150 +++++++++++
 drivers/input/touchscreen/axiom_spi.c  | 155 +++++++++++
 6 files changed, 924 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 7d5b72ee07fa..d27292ccabc9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -162,6 +162,31 @@ config TOUCHSCREEN_AUO_PIXCIR
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called auo-pixcir-ts.
=20
+config TOUCHSCREEN_AXIOM_CORE
+=09tristate
+
+config TOUCHSCREEN_AXIOM_I2C
+=09tristate "TouchNetix aXiom touchscreen (I2C)"
+=09depends on I2C
+=09select TOUCHSCREEN_AXIOM_CORE
+=09help
+=09  Say Y here if the aXiom touchscreen is connected via
+=09  the I2C bus.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called axiom_i2c.
+
+config TOUCHSCREEN_AXIOM_SPI
+=09tristate "TouchNetix aXiom touchscreen (SPI)"
+=09depends on SPI
+=09select TOUCHSCREEN_AXIOM_CORE
+=09help
+=09  Say Y here if the aXiom touchscreen is connected via
+=09  the SPI bus.
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called axiom_spi.
+
 config TOUCHSCREEN_BU21013
 =09tristate "BU21013 based touch panel controllers"
 =09depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index ab9abd151078..9b7d572c4589 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -19,6 +19,9 @@ obj-$(CONFIG_TOUCHSCREEN_APPLE_Z2)=09+=3D apple_z2.o
 obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)=09+=3D ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)=09+=3D atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)=09+=3D auo-pixcir-ts.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_CORE)=09+=3D axiom_core.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_I2C)=09+=3D axiom_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_AXIOM_SPI)=09+=3D axiom_spi.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)=09+=3D bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_BU21029)=09+=3D bu21029_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)=09+=3D chipone_icn8318.o
diff --git a/drivers/input/touchscreen/axiom_core.c b/drivers/input/touchsc=
reen/axiom_core.c
new file mode 100644
index 000000000000..89a845ab90ba
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_core.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ */
+
+#include <linux/device.h>
+#include <linux/input/mt.h>
+#include <linux/crc16.h>
+#include <linux/property.h>
+#include <linux/interrupt.h>
+#include <linux/unaligned.h>
+#include <linux/bitfield.h>
+#include "axiom_core.h"
+
+static bool poll_enable;
+module_param(poll_enable, bool, 0444);
+MODULE_PARM_DESC(poll_enable, "Enable polling mode [default 0=3Dno]");
+
+static int poll_period =3D 10;
+module_param(poll_period, uint, 0444);
+MODULE_PARM_DESC(poll_period, "Polling period in ms [default =3D 10]");
+
+/* u31 device info masks */
+#define AX_DEV_ID_MASK=09=09=09=09GENMASK(14, 0)
+#define AX_MODE=09=09=09=09=09=09BIT(15)
+#define AX_FW_REV_MINOR_MASK=09=09GENMASK(7, 0)
+#define AX_FW_REV_MAJOR_MASK=09=09GENMASK(15, 8)
+#define AX_VARIANT_MASK=09=09=09=09GENMASK(5, 0)
+#define AX_FW_STATUS=09=09=09=09BIT(7)
+#define AX_TCP_REV_MASK=09=09=09=09GENMASK(15, 8)
+#define AX_BOOT_REV_MINOR_MASK=09=09GENMASK(7, 0)
+#define AX_BOOT_REV_MAJOR_MASK=09=09GENMASK(15, 8)
+#define AX_NUM_USAGES_MASK=09=09=09GENMASK(7, 0)
+#define AX_SILICON_REV_MASK=09=09=09GENMASK(11, 8)
+#define AX_RUNTIME_FW_PATCH_MASK=09GENMASK(15, 12)
+
+/* u31 usage table entry masks */
+#define AX_U31_USAGE_NUM_MASK=09=09GENMASK(7, 0)
+#define AX_U31_START_PAGE_MASK=09=09GENMASK(15, 8)
+#define AX_U31_NUM_PAGES_MASK=09=09GENMASK(7, 0)
+#define AX_U31_MAX_OFFSET_MASK=09=09GENMASK(14, 8)
+#define AX_U31_OFFSET_TYPE_BIT=09=09BIT(15)
+#define AX_U31_UIF_REV_MASK=09=09=09GENMASK(7, 0)
+#define AX_U31_USAGE_TYPE_MASK=09=09GENMASK(15, 8)
+
+/* u34 report masks */
+#define AX_U34_LEN_MASK=09=09=09=09GENMASK(6, 0)
+#define AX_U34_OVERFLOW=09=09=09=09BIT(7)
+#define AX_U34_USAGE_MASK=09=09=09GENMASK(15, 8)
+#define AX_U34_PAYLOAD_BUFFER=09=09(2)
+
+/* u41 report masks */
+#define AX_U41_PRESENT_MASK=09=09=09GENMASK(9, 0)
+#define U41_X_Y_OFFSET=09=09=09=09(2)
+#define U41_COORD_SIZE=09=09=09=09(4)
+#define U41_Z_OFFSET=09=09=09=09(42)
+
+static const char *const fw_variants[] =3D {
+=09"3D",
+=09"2D",
+=09"FORCE",
+=09"0D",
+=09"XL",
+=09"TOUCHPAD",
+};
+
+static int axiom_set_capabilities(struct input_dev *input_dev)
+{
+=09input_dev->name =3D "TouchNetix aXiom Touchscreen";
+=09input_dev->phys =3D "input/ts";
+
+=09// Multi Touch
+=09input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0)=
;
+=09input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
+
+=09// each report id in u41 can be configured separately in u42,
+=09// to keep it simple have all reports ids be touch.
+=09input_mt_init_slots(input_dev, U41_MAX_TARGETS, INPUT_MT_DIRECT);
+
+=09return 0;
+}
+
+static struct u31_usage_entry *usage_find_entry(struct axiom *ax, u16 usag=
e)
+{
+=09u16 i;
+
+=09for (i =3D 0; i < ax->dev_info.num_usages; i++) {
+=09=09if (ax->usage_table[i].usage_num =3D=3D usage)
+=09=09=09return &ax->usage_table[i];
+=09}
+
+=09pr_err("aXiom-core: Usage u%02x not found in usage table\n", usage);
+=09return ERR_PTR(-EINVAL);
+}
+
+static void axiom_unpack_device_info(const u8 *buf,
+=09=09=09=09     struct axiom_device_info *info)
+{
+=09u16 w;
+
+=09w =3D get_unaligned_le16(buf);
+=09info->device_id =3D FIELD_GET(AX_DEV_ID_MASK, w);
+=09info->mode =3D !!(w & AX_MODE);
+
+=09w =3D get_unaligned_le16(buf + 2);
+=09info->runtime_fw_rev_minor =3D FIELD_GET(AX_FW_REV_MINOR_MASK, w);
+=09info->runtime_fw_rev_major =3D FIELD_GET(AX_FW_REV_MAJOR_MASK, w);
+
+=09w =3D get_unaligned_le16(buf + 4);
+=09info->device_build_variant =3D FIELD_GET(AX_VARIANT_MASK, w);
+=09info->runtime_fw_status =3D !!(w & AX_FW_STATUS);
+=09info->tcp_revision =3D FIELD_GET(AX_TCP_REV_MASK, w);
+
+=09w =3D get_unaligned_le16(buf + 6);
+=09info->bootloader_fw_rev_minor =3D FIELD_GET(AX_BOOT_REV_MINOR_MASK, w);
+=09info->bootloader_fw_rev_major =3D FIELD_GET(AX_BOOT_REV_MAJOR_MASK, w);
+
+=09info->jedec_id =3D get_unaligned_le16(buf + 8);
+
+=09w =3D get_unaligned_le16(buf + 10);
+=09info->num_usages =3D FIELD_GET(AX_NUM_USAGES_MASK, w);
+=09info->silicon_revision =3D FIELD_GET(AX_SILICON_REV_MASK, w);
+=09info->runtime_fw_rev_patch =3D FIELD_GET(AX_RUNTIME_FW_PATCH_MASK, w);
+}
+
+static void axiom_unpack_usage_table(u8 *buf, struct axiom *ax)
+{
+=09struct u31_usage_entry *entry;
+=09u16 report_len;
+=09u8 *ptr;
+=09int i;
+=09u16 w;
+
+=09for (i =3D 0; i < ax->dev_info.num_usages && i < U31_MAX_USAGES; i++) {
+=09=09entry =3D &ax->usage_table[i];
+=09=09/* Calculate offset for this specific entry */
+=09=09ptr =3D buf + (i * SIZE_U31_USAGE_ENTRY);
+
+=09=09w =3D get_unaligned_le16(ptr);
+=09=09entry->usage_num =3D FIELD_GET(AX_U31_USAGE_NUM_MASK, w);
+=09=09entry->start_page =3D FIELD_GET(AX_U31_START_PAGE_MASK, w);
+
+=09=09w =3D get_unaligned_le16(ptr + 2);
+=09=09entry->num_pages =3D FIELD_GET(AX_U31_NUM_PAGES_MASK, w);
+=09=09entry->max_offset =3D FIELD_GET(AX_U31_MAX_OFFSET_MASK, w);
+=09=09entry->offset_type =3D !!(w & AX_U31_OFFSET_TYPE_BIT);
+
+=09=09w =3D get_unaligned_le16(ptr + 4);
+=09=09entry->uifrevision =3D FIELD_GET(AX_U31_UIF_REV_MASK, w);
+=09=09entry->usage_type =3D FIELD_GET(AX_U31_USAGE_TYPE_MASK, w);
+
+=09=09// Convert words to bytes
+=09=09report_len =3D (entry->max_offset + 1) * 2;
+=09=09if (entry->usage_type =3D=3D REPORT &&
+=09=09    report_len > ax->max_report_len) {
+=09=09=09ax->max_report_len =3D report_len;
+=09=09}
+=09}
+}
+
+static int axiom_init_dev_info(struct axiom *ax)
+{
+=09struct u31_usage_entry *u;
+=09const char *variant_str;
+=09char silicon_rev;
+=09int err;
+=09int i;
+
+=09/* Read page 0 of u31 */
+=09err =3D ax->bus_ops->read(ax->dev, 0x0, SIZE_U31_DEVICE_INFO,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return -EIO;
+
+=09axiom_unpack_device_info(ax->read_buf, &ax->dev_info);
+
+=09silicon_rev =3D (char)(0x41 + ax->dev_info.silicon_revision);
+
+=09if (ax->dev_info.device_build_variant < ARRAY_SIZE(fw_variants))
+=09=09variant_str =3D fw_variants[ax->dev_info.device_build_variant];
+=09else
+=09=09variant_str =3D "UNKNOWN";
+
+=09dev_info(ax->dev, "Firmware Info:\n");
+=09dev_info(ax->dev, "  BL Mode     : %u\n", ax->dev_info.mode);
+=09dev_info(ax->dev, "  Device ID   : %04x\n", ax->dev_info.device_id);
+=09dev_info(ax->dev, "  FW Revision : %u.%u.%u-%s %s\n",
+=09=09 ax->dev_info.runtime_fw_rev_major,
+=09=09 ax->dev_info.runtime_fw_rev_minor,
+=09=09 ax->dev_info.runtime_fw_rev_patch,
+=09=09 (ax->dev_info.runtime_fw_status =3D=3D 0) ? "eng" : "prod",
+=09=09 variant_str);
+=09dev_info(ax->dev, "  BL Revision : %02x.%02x\n",
+=09=09 ax->dev_info.bootloader_fw_rev_major,
+=09=09 ax->dev_info.bootloader_fw_rev_minor);
+=09dev_info(ax->dev, "  Silicon     : 0x%04X (Rev %c)\n",
+=09=09 ax->dev_info.jedec_id, silicon_rev);
+=09dev_info(ax->dev, "  Num Usages  : %u\n", ax->dev_info.num_usages);
+
+=09if (ax->dev_info.num_usages > U31_MAX_USAGES) {
+=09=09dev_err(ax->dev,
+=09=09=09"Num usages (%u) exceeds maximum supported (%u)\n",
+=09=09=09ax->dev_info.num_usages, U31_MAX_USAGES);
+=09=09return -EINVAL;
+=09}
+
+=09/* Read the second page of u31 to get the usage table */
+=09err =3D ax->bus_ops->read(ax->dev, 0x100,
+=09=09=09=09sizeof(ax->usage_table[0]) *
+=09=09=09=09=09ax->dev_info.num_usages,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return -EIO;
+
+=09axiom_unpack_usage_table(ax->read_buf, ax);
+
+=09dev_info(ax->dev, "Usage Table:\n");
+=09for (i =3D 0; i < ax->dev_info.num_usages; i++) {
+=09=09u =3D &ax->usage_table[i];
+
+=09=09dev_info(ax->dev, "  Usage: u%02x  Rev: %3u  Page: 0x%02x00  Num Pag=
es: %3u\n",
+=09=09=09u->usage_num, u->uifrevision, u->start_page,
+=09=09=09u->num_pages);
+=09}
+
+=09if (ax->max_report_len > AXIOM_MAX_READ_SIZE) {
+=09=09dev_err(ax->dev,
+=09=09=09"aXiom maximum report length (%u) greater than allocated buffer s=
ize (%u).",
+=09=09=09ax->max_report_len, AXIOM_MAX_READ_SIZE);
+=09=09return -EINVAL;
+=09}
+
+=09/* Set u34 address to allow direct access to report reading address */
+=09u =3D usage_find_entry(ax, 0x34);
+=09if (IS_ERR(u))
+=09=09return PTR_ERR(u);
+=09ax->u34_address =3D u->start_page << 8;
+
+=09return 0;
+}
+
+static int axiom_process_u41_report(struct axiom *ax, u8 *report)
+{
+=09enum u41_target_state_e state;
+=09u16 target_present;
+=09bool active;
+=09u8 offset;
+=09int i;
+=09u16 x;
+=09u16 y;
+=09s8 z;
+
+=09target_present =3D
+=09=09FIELD_GET(AX_U41_PRESENT_MASK, get_unaligned_le16(&report[0]));
+
+=09for (i =3D 0; i < U41_MAX_TARGETS; i++) {
+=09=09active =3D !!((target_present >> i) & 1);
+
+=09=09offset =3D U41_X_Y_OFFSET + (i * U41_COORD_SIZE);
+=09=09x =3D get_unaligned_le16(&report[offset]);
+=09=09y =3D get_unaligned_le16(&report[offset + 2]);
+=09=09z =3D report[U41_Z_OFFSET + i];
+
+=09=09if (!active)
+=09=09=09state =3D target_state_not_present;
+=09=09else if (z >=3D 0)
+=09=09=09state =3D target_state_touching;
+=09=09else if ((z > U41_PROX_LEVEL) && (z < 0))
+=09=09=09state =3D target_state_hover;
+=09=09else if (z =3D=3D U41_PROX_LEVEL)
+=09=09=09state =3D target_state_prox;
+=09=09else
+=09=09=09state =3D target_state_not_present;
+
+=09=09dev_dbg(ax->dev, "Target %d: x=3D%u y=3D%u z=3D%d present=3D%d\n", i=
, x,
+=09=09=09y, z, active);
+
+=09=09switch (state) {
+=09=09case target_state_not_present:
+=09=09case target_state_prox:
+
+=09=09=09input_mt_slot(ax->input, i);
+=09=09=09input_mt_report_slot_inactive(ax->input);
+=09=09=09break;
+
+=09=09case target_state_hover:
+=09=09case target_state_touching:
+
+=09=09=09input_mt_slot(ax->input, i);
+=09=09=09input_report_abs(ax->input, ABS_MT_TRACKING_ID, i);
+=09=09=09input_report_abs(ax->input, ABS_MT_POSITION_X, x);
+=09=09=09input_report_abs(ax->input, ABS_MT_POSITION_Y, y);
+
+=09=09=09if (state =3D=3D target_state_touching) {
+=09=09=09=09input_report_abs(ax->input, ABS_MT_DISTANCE, 0);
+=09=09=09=09input_report_abs(ax->input, ABS_MT_PRESSURE, z);
+=09=09=09} else { /* Hover */
+=09=09=09=09input_report_abs(ax->input, ABS_MT_DISTANCE, -z);
+=09=09=09=09input_report_abs(ax->input, ABS_MT_PRESSURE, 0);
+=09=09=09}
+=09=09=09break;
+
+=09=09default:
+=09=09=09break;
+=09=09}
+=09}
+
+=09input_mt_sync_frame(ax->input);
+=09input_sync(ax->input);
+
+=09return 0;
+}
+
+static int axiom_process_report(struct axiom *ax, u8 *report)
+{
+=09u16 hdr_buf =3D get_unaligned_le16(&report[0]);
+=09struct u34_report_header hdr;
+=09u16 crc_report;
+=09u16 crc_calc;
+=09int err;
+=09u8 len;
+
+=09dev_dbg(ax->dev, "Payload Data %*ph\n", ax->max_report_len, report);
+
+=09hdr.report_length =3D FIELD_GET(AX_U34_LEN_MASK, hdr_buf);
+=09hdr.overflow =3D !!(hdr_buf & AX_U34_OVERFLOW);
+=09hdr.report_usage =3D FIELD_GET(AX_U34_USAGE_MASK, hdr_buf);
+
+=09len =3D hdr.report_length << 1;
+=09if (hdr.report_length =3D=3D 0) {
+=09=09dev_err(ax->dev, "Zero length report discarded.\n");
+=09=09return -EIO;
+=09}
+
+=09// Length is 16 bit words and remove the size of the CRC16 itself
+=09crc_report =3D (report[len - 1] << 8) | (report[len - 2]);
+=09crc_calc =3D crc16(0, report, (len - 2));
+
+=09if (crc_calc !=3D crc_report) {
+=09=09dev_err(ax->dev,
+=09=09=09"CRC mismatch! Expected: %04X, Calculated CRC: %04X. Report disca=
rded.\n",
+=09=09=09crc_report, crc_calc);
+=09=09return -EIO;
+=09}
+
+=09switch (hdr.report_usage) {
+=09case AX_2DCTS_REPORT_ID:
+=09=09err =3D axiom_process_u41_report(ax,
+=09=09=09=09=09       &report[AX_U34_PAYLOAD_BUFFER]);
+=09=09break;
+
+=09default:
+=09=09break;
+=09}
+
+=09return err;
+}
+
+static void axiom_poll(struct input_dev *input_dev)
+{
+=09struct axiom *ax =3D input_get_drvdata(input_dev);
+=09int err;
+
+=09/* Read touch reports from u34 */
+=09err =3D ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09return;
+
+=09err =3D axiom_process_report(ax, ax->read_buf);
+=09if (err)
+=09=09dev_err(ax->dev, "Failed to process report: %d\n", err);
+}
+
+static irqreturn_t axiom_irq(int irq, void *handle)
+{
+=09struct axiom *ax =3D handle;
+=09int err;
+
+=09/* Read touch reports from u34 */
+=09err =3D ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
+=09=09=09=09ax->read_buf);
+=09if (err)
+=09=09goto out;
+
+=09err =3D axiom_process_report(ax, ax->read_buf);
+=09if (err)
+=09=09dev_err(ax->dev, "Failed to process report: %d\n", err);
+
+out:
+=09return IRQ_HANDLED;
+}
+
+struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
+=09=09=09  struct device *dev, int irq)
+{
+=09struct input_dev *input_dev;
+=09struct axiom *ax;
+=09int err;
+
+=09ax =3D devm_kzalloc(dev, sizeof(*ax), GFP_KERNEL);
+=09if (!ax)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09input_dev =3D devm_input_allocate_device(dev);
+=09if (!input_dev) {
+=09=09pr_err("ERROR: aXiom-core: Failed to allocate memory for input devic=
e!\n");
+=09=09return ERR_PTR(-ENOMEM);
+=09}
+
+=09ax->dev =3D dev;
+=09ax->input =3D input_dev;
+=09ax->bus_ops =3D bus_ops;
+=09ax->irq =3D irq;
+
+=09dev_info(dev, "aXiom Probe\n");
+=09if (poll_enable)
+=09=09dev_info(dev, "Polling Period : %u\n", poll_period);
+=09else
+=09=09dev_info(dev, "Device IRQ : %u\n", ax->irq);
+
+=09axiom_set_capabilities(input_dev);
+
+=09err =3D axiom_init_dev_info(ax);
+=09if (err) {
+=09=09dev_err(ax->dev, "Failed to read device info, err: %d\n", err);
+=09=09return ERR_PTR(err);
+=09}
+
+=09if (poll_enable) {
+=09=09err =3D input_setup_polling(input_dev, axiom_poll);
+=09=09if (err) {
+=09=09=09dev_err(ax->dev, "could not set up polling mode, %d\n",
+=09=09=09=09err);
+=09=09=09return ERR_PTR(err);
+=09=09}
+
+=09=09input_set_poll_interval(input_dev, poll_period);
+=09} else {
+=09=09err =3D devm_request_threaded_irq(ax->dev, ax->irq, NULL,
+=09=09=09=09=09=09axiom_irq,
+=09=09=09=09=09=09IRQF_ONESHOT,
+=09=09=09=09=09=09"axiom_irq", ax);
+=09=09if (err)
+=09=09=09return ERR_PTR(err);
+=09}
+
+=09err =3D input_register_device(input_dev);
+=09if (err) {
+=09=09dev_err(ax->dev, "Failed to register input device: %d\n", err);
+=09=09return ERR_PTR(err);
+=09}
+
+=09input_set_drvdata(input_dev, ax);
+
+=09return ax;
+}
+EXPORT_SYMBOL_GPL(axiom_probe);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen core logic");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/axiom_core.h b/drivers/input/touchsc=
reen/axiom_core.h
new file mode 100644
index 000000000000..8ca46200bede
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_core.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ */
+
+#ifndef __AXIOM_CORE_H
+#define __AXIOM_CORE_H
+
+#include <linux/input.h>
+
+#define AX_POLLING_PERIOD_MS=09(10)
+
+#define AXIOM_PAGE_SIZE=09=09=09(256)
+// u31 has 2 pages for usage table entries. (2 * PAGE_SIZE) / U31_BYTES_PE=
R_USAGE =3D 85
+#define AXIOM_MAX_READ_SIZE=09=09(2 * AXIOM_PAGE_SIZE)
+#define SIZE_U31_DEVICE_INFO=09(12)
+#define SIZE_U31_USAGE_ENTRY=09(6)
+#define U31_MAX_USAGES=09=09=09(85U)
+#define U41_MAX_TARGETS=09=09=09(10U)
+#define U41_PROX_LEVEL=09=09=09(-128)
+#define AXIOM_HOLDOFF_DELAY_US=09(40)
+
+enum ax_comms_op_e { AX_WR_OP =3D 0, AX_RD_OP =3D 1 };
+
+enum report_ids_e {
+=09AX_2DCTS_REPORT_ID =3D 0x41,
+};
+
+enum axiom_mode_e {
+=09AX_RUNTIME_STATE =3D 0,
+=09AX_BOOTLOADER_STATE =3D 1,
+};
+
+enum usage_type_e {
+=09UNKNOWN =3D 0,
+=09OTHER =3D 1,
+=09REPORT =3D 2,
+=09REGISTER =3D 3,
+=09REGISTER_READ_ONLY_ =3D 4,
+=09CDU =3D 5,
+=09CDU_READ_ONLY_ =3D 6,
+};
+
+struct axiom_device_info {
+=09u16 device_id;
+=09u8 mode;
+=09u8 runtime_fw_rev_minor;
+=09u8 runtime_fw_rev_major;
+=09u8 device_build_variant;
+=09u8 runtime_fw_status;
+=09u8 tcp_revision;
+=09u8 bootloader_fw_rev_minor;
+=09u8 bootloader_fw_rev_major;
+=09u8 jedec_id;
+=09u8 num_usages;
+=09u8 silicon_revision;
+=09u8 runtime_fw_rev_patch;
+};
+
+struct u31_usage_entry {
+=09u8 usage_num;
+=09u8 start_page;
+=09u8 num_pages;
+=09u8 max_offset;
+=09u8 offset_type;
+=09u8 uifrevision;
+=09u8 usage_type;
+};
+
+struct axiom_cmd_header {
+=09__le16 target_address;
+=09__le16 length_and_op;
+} __packed;
+
+struct axiom_bus_ops {
+=09u16 bustype;
+=09int (*write)(struct device *dev, u16 addr, u16 length, void *values);
+=09int (*read)(struct device *dev, u16 addr, u16 length, void *values);
+};
+
+enum u41_target_state_e {
+=09target_state_not_present =3D 0,
+=09target_state_prox =3D 1,
+=09target_state_hover =3D 2,
+=09target_state_touching =3D 3,
+};
+
+struct axiom {
+=09struct device *dev;
+=09int irq;
+=09struct input_dev *input;
+=09const struct axiom_bus_ops *bus_ops;
+=09struct axiom_device_info dev_info;
+=09struct u31_usage_entry usage_table[U31_MAX_USAGES];
+=09u16 max_report_len;
+=09u16 u34_address;
+
+=09u8 read_buf[AXIOM_MAX_READ_SIZE];
+};
+
+struct u34_report_header {
+=09u8 report_length;
+=09u8 overflow;
+=09u8 report_usage;
+};
+
+struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
+=09=09=09  struct device *dev, int irq);
+
+#endif /* __AXIOM_CORE_H */
diff --git a/drivers/input/touchscreen/axiom_i2c.c b/drivers/input/touchscr=
een/axiom_i2c.c
new file mode 100644
index 000000000000..93b445f4ce54
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_i2c.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/unaligned.h>
+#include "axiom_core.h"
+
+static int axiom_i2c_read_block_data(struct device *dev, u16 addr, u16 len=
gth,
+=09=09=09=09     void *values)
+{
+=09struct i2c_client *client =3D to_i2c_client(dev);
+=09struct axiom_cmd_header cmd_header;
+=09u16 len_op;
+=09int err;
+
+=09put_unaligned_le16(addr, &cmd_header.target_address);
+=09len_op =3D (length & 0x7FFF) | (AX_RD_OP << 15);
+=09put_unaligned_le16(len_op, &cmd_header.length_and_op);
+
+=09struct i2c_msg msgs[] =3D {
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D sizeof(cmd_header),
+=09=09=09.buf =3D (u8 *)&cmd_header,
+=09=09},
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D I2C_M_RD,
+=09=09=09.len =3D length,
+=09=09=09.buf =3D values,
+=09=09},
+=09};
+
+=09err =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+=09if (err < 0) {
+=09=09dev_err(dev, "I2C transfer error: %d\n", err);
+=09=09return err;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return err !=3D ARRAY_SIZE(msgs) ? -EIO : 0;
+}
+
+static int axiom_i2c_write_block_data(struct device *dev, u16 addr, u16 le=
ngth,
+=09=09=09=09      void *values)
+{
+=09struct i2c_client *client =3D to_i2c_client(dev);
+=09struct axiom_cmd_header cmd_header;
+=09u16 len_op;
+=09int err;
+
+=09put_unaligned_le16(addr, &cmd_header.target_address);
+=09len_op =3D (length & 0x7FFF) | (AX_WR_OP << 15);
+=09put_unaligned_le16(len_op, &cmd_header.length_and_op);
+
+=09struct i2c_msg msgs[] =3D {
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D sizeof(cmd_header),
+=09=09=09.buf =3D (u8 *)&cmd_header,
+=09=09},
+=09=09{
+=09=09=09.addr =3D client->addr,
+=09=09=09.flags =3D 0,
+=09=09=09.len =3D length,
+=09=09=09.buf =3D values,
+=09=09},
+=09};
+
+=09err =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+=09if (err < 0) {
+=09=09dev_err(dev, "I2C transfer error: %d\n", err);
+=09=09return err;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return err !=3D ARRAY_SIZE(msgs) ? -EIO : 0;
+}
+
+static const struct axiom_bus_ops axiom_i2c_bus_ops =3D {
+=09.bustype =3D BUS_I2C,
+=09.write =3D axiom_i2c_write_block_data,
+=09.read =3D axiom_i2c_read_block_data,
+};
+
+static int axiom_i2c_probe(struct i2c_client *client)
+{
+=09struct axiom *axiom;
+
+=09if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+=09=09dev_err(&client->dev, "I2C functionality not Supported\n");
+=09=09return -EIO;
+=09}
+
+=09axiom =3D axiom_probe(&axiom_i2c_bus_ops, &client->dev, client->irq);
+=09if (IS_ERR(axiom))
+=09=09return dev_err_probe(&client->dev, PTR_ERR(axiom),
+=09=09=09=09     "failed to register input device\n");
+
+=09return 0;
+}
+
+static const struct i2c_device_id axiom_i2c_id_table[] =3D {
+=09{ "axiom-i2c" },
+=09{},
+};
+MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
+
+static const struct of_device_id axiom_i2c_dt_ids[] =3D {
+=09{
+=09=09.compatible =3D "tnx,axiom-i2c",
+=09=09.data =3D "axiom",
+=09},
+=09{}
+};
+MODULE_DEVICE_TABLE(of, axiom_i2c_dt_ids);
+
+static struct i2c_driver axiom_i2c_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "axiom_i2c",
+=09=09.of_match_table =3D axiom_i2c_dt_ids,
+=09},
+=09.id_table =3D axiom_i2c_id_table,
+=09.probe =3D axiom_i2c_probe,
+};
+
+module_i2c_driver(axiom_i2c_driver);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen I2C bus driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
diff --git a/drivers/input/touchscreen/axiom_spi.c b/drivers/input/touchscr=
een/axiom_spi.c
new file mode 100644
index 000000000000..a7d9d3dd66ce
--- /dev/null
+++ b/drivers/input/touchscreen/axiom_spi.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TouchNetix aXiom Touchscreen Driver
+ *
+ * Copyright (C) 2020-2026 TouchNetix Ltd.
+ *
+ * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
+ *            Pedro Torruella <pedro.torruella@touchnetix.com>
+ *            Bart Prescott <bartp@baasheep.co.uk>
+ *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
+ *            Andrew Thomas <andrew.thomas@touchnetix.com>
+ */
+
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/input.h>
+#include <linux/unaligned.h>
+#include "axiom_core.h"
+
+#define SPI_PADDING_LEN (32)
+
+static int axiom_spi_transfer(struct device *dev, enum ax_comms_op_e op,
+=09=09=09      u16 addr, u16 length, void *values)
+{
+=09struct spi_device *spi =3D to_spi_device(dev);
+=09u8 pad_buf[SPI_PADDING_LEN] =3D { 0 };
+=09struct axiom_cmd_header cmd_header;
+=09struct spi_transfer xfr_header;
+=09struct spi_transfer xfr_padding;
+=09struct spi_transfer xfr_payload;
+=09struct spi_message msg;
+=09u16 len_op;
+=09int err;
+
+=09put_unaligned_le16(addr, &cmd_header.target_address);
+=09len_op =3D (length & 0x7FFF) | (AX_RD_OP << 15);
+=09put_unaligned_le16(len_op, &cmd_header.length_and_op);
+
+=09memset(&xfr_header, 0, sizeof(xfr_header));
+=09memset(&xfr_padding, 0, sizeof(xfr_padding));
+=09memset(&xfr_payload, 0, sizeof(xfr_payload));
+
+=09/* Setup the SPI transfer operations */
+=09xfr_header.tx_buf =3D &cmd_header;
+=09xfr_header.len =3D sizeof(cmd_header);
+
+=09xfr_padding.tx_buf =3D pad_buf;
+=09xfr_padding.len =3D sizeof(pad_buf);
+
+=09switch (op) {
+=09case AX_WR_OP:
+=09=09xfr_payload.tx_buf =3D values;
+=09=09break;
+=09case AX_RD_OP:
+=09=09xfr_payload.rx_buf =3D values;
+=09=09break;
+=09default:
+=09=09dev_err(dev, "%s: invalid operation: %d\n", __func__, op);
+=09=09return -EINVAL;
+=09}
+=09xfr_payload.len =3D length;
+
+=09spi_message_init(&msg);
+=09spi_message_add_tail(&xfr_header, &msg);
+=09spi_message_add_tail(&xfr_padding, &msg);
+=09spi_message_add_tail(&xfr_payload, &msg);
+
+=09err =3D spi_sync(spi, &msg);
+=09if (err < 0) {
+=09=09dev_err(&spi->dev, "Failed to SPI transfer, error: %d\n", err);
+=09=09return err;
+=09}
+
+=09udelay(AXIOM_HOLDOFF_DELAY_US);
+
+=09return 0;
+}
+
+static int axiom_spi_read_block_data(struct device *dev, u16 addr, u16 len=
gth,
+=09=09=09=09     void *values)
+{
+=09return axiom_spi_transfer(dev, AX_RD_OP, addr, length, values);
+}
+
+static int axiom_spi_write_block_data(struct device *dev, u16 addr, u16 le=
ngth,
+=09=09=09=09      void *values)
+{
+=09return axiom_spi_transfer(dev, AX_WR_OP, addr, length, values);
+}
+
+static const struct axiom_bus_ops axiom_spi_bus_ops =3D {
+=09.bustype =3D BUS_SPI,
+=09.write =3D axiom_spi_write_block_data,
+=09.read =3D axiom_spi_read_block_data,
+};
+
+static int axiom_spi_probe(struct spi_device *spi)
+{
+=09struct axiom *axiom;
+=09int err;
+
+=09/* Set up SPI */
+=09spi->bits_per_word =3D 8;
+=09spi->mode =3D SPI_MODE_0;
+=09spi->max_speed_hz =3D 4000000;
+
+=09if (spi->irq =3D=3D 0)
+=09=09dev_err(&spi->dev, "No IRQ specified!\n");
+
+=09err =3D spi_setup(spi);
+=09if (err < 0) {
+=09=09dev_err(&spi->dev, "%s: SPI setup error %d\n", __func__, err);
+=09=09return err;
+=09}
+=09axiom =3D axiom_probe(&axiom_spi_bus_ops, &spi->dev, spi->irq);
+=09if (IS_ERR(axiom))
+=09=09return dev_err_probe(&spi->dev, PTR_ERR(axiom),
+=09=09=09=09     "failed to register input device\n");
+
+=09return 0;
+}
+
+static const struct spi_device_id axiom_spi_id_table[] =3D {
+=09{ "axiom-spi" },
+=09{},
+};
+MODULE_DEVICE_TABLE(spi, axiom_spi_id_table);
+
+static const struct of_device_id axiom_spi_dt_ids[] =3D {
+=09{
+=09=09.compatible =3D "tnx,axiom-spi",
+=09=09.data =3D "axiom",
+=09},
+=09{}
+};
+MODULE_DEVICE_TABLE(of, axiom_spi_dt_ids);
+
+static struct spi_driver axiom_spi_driver =3D {
+=09.id_table =3D axiom_spi_id_table,
+=09.driver =3D {
+=09=09.name =3D "axiom_spi",
+=09=09.of_match_table =3D axiom_spi_dt_ids,
+=09},
+=09.probe =3D axiom_spi_probe,
+};
+
+module_spi_driver(axiom_spi_driver);
+
+MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
+MODULE_DESCRIPTION("aXiom touchscreen SPI bus driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");

--=20
2.43.0

