Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011026.outbound.protection.outlook.com [52.103.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CC4266B8;
	Mon,  3 Aug 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778339; cv=fail; b=hTCpmDkUoEmOosOHIZoeTWjjBoQESciyTOkbltPhpApo4S04I9NXXwo7spAnedGdfGLr3TsaUT6X0SHnc9UCNDi3zN7wCUxFWb9VDzujK0SqdALAg45O1WJYKehSBuQpFGULiaMuDuMpx22x4ucCfnDb0jeJLN3uis5k7HYK+AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778339; c=relaxed/simple;
	bh=VUqkhz2IIo/rmNxzG1mFLnVXzbUgF0bc4kZUEYbpt4E=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gu5GmWnEJcJLB+h8SeeUPRjH/gVu5LslPKuQ8mO/5le+RSpPQaNRYxR6gQ25YQ5FXHOhfpxetDQYGe2mmJ9tNoIUQP+kCKlZg7222YB/zBqgpPktlDKxaqOCrufXTGC6EQIamZnOp13Y3lM/Q0zKEa3+o7QOq2C+xCF/QzVdS68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=piOm0RhN; arc=fail smtp.client-ip=52.103.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="piOm0RhN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuN5RRIjxeGoVV3BeAmKJgu2Ja4oi6W1CZM/8h6WG4eEGxpKnvfsGPoLDjlAf0/QQu8PKAUGQ991hwix7h942Hbsn871bSiQPIU9tQ616/8yUoCFRy4n5wSQG+7X7JYMtJQbgGRZ5dN13oNCkDHOITCDbd5utNZDvtqewbWi7/QbPuc24ruXLz4QAwoVG1cmvSlGzry1gCVOeM0NztzS+6atEWtsbZUymXXc7Bj8sQbyxjcWk2FgrsBXB6kERmGZaUmmeDGKyOdJ3oFKuqRBxPr2Et1utL+2uUYH/rZvfaBq7NyJmmQ+ShHSgxokPaSn81Ym97lbUd+IWJPMgy7nIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUqkhz2IIo/rmNxzG1mFLnVXzbUgF0bc4kZUEYbpt4E=;
 b=H1z6XgwtO1rMW+mLWmwJ0VmSdRbtoq/HirjCO4gC1fDeT9dv4ECGNzCCQlg+RG7PEURuavS4EY62xYShh6wW++M3sGzK8YAheogv8OaMsVG2upaMjEIXE0gaZBagWwm8KPZCeNpzru6G+3mkLnUvEEYMy7ww40pjarFBGNiv/gQcG/BFz4S3wRv/1G1NxMpBj9IQVY/Dm/5pGKOcHjWskxEkt1tYo6Ns0NWNnh8kaMjkmeb3bY4Y1dYheiKqYLvpAEobLHhM+YAv+MCjPrNpi5dLKVRayK79Zj22GPhDKCrFSqJNCemhci7SWlnoTVqFfn0VqANUfMlcACWUaSHlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUqkhz2IIo/rmNxzG1mFLnVXzbUgF0bc4kZUEYbpt4E=;
 b=piOm0RhN/rDGrJAscnzgdWha50blQEoRzIi26f5GT9piOzISMjQFzfIHdOCeFvczIwSOfCfrLTaQvrQw/SAO9NAKSs3RtnFh9rlU+7r+hxMAcOplpgvv1aXAtej4t5dt2FUKKhX3tGb45yeXL+7ZIo3bX3CU3FONgRXeOWgZewdXFKgqY6bZSMtuOrjRTWJ/z8F4EW/0fS/IL2IIorka4W98BEDyX/P/R/q3GZrnOBafy8Ocgpq66Y2A5Rpm4VZ/qt9QdBrDPm8RKi0YptAWPkRLZCJcv5lYEfX5101C0Bz925T37Z5VTT2PcLHIkLtiiPn3aw5LTfBnvB5ZrTYOTg==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by OS7PR01MB14463.jpnprd01.prod.outlook.com
 (2603:1096:604:38f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:32:14 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:32:14 +0000
Message-ID:
 <TY4PR01MB14432E89E86246C0DDC8B816F98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Tue, 4 Aug 2026 01:32:03 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>,
 Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>,
 Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Pengyu Ma <mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
 <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0N7Q6Ttl1iUbaNiYl1KCkFA7"
X-ClientProxiedBy: SE2P216CA0207.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::13) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <eacb323e-f1fa-45b7-8619-6506507d24f4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|OS7PR01MB14463:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff68e18-f303-41cc-f1ba-08def1852822
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7Kx8z7aOOdibWQVs7OByUfBuC/ycloXaVTlfNG5PO+Dpbt2RuGnuH5Oo76qYWwbJNuT+REa842etrgu7084xWCZBnPrjnGN2s66aPLaOw+8sfbEIPLzotjqC7Le1kTiNqb9Z9B7oRcqTxwZefRqKlRT5kppp0/1EimD5/PGdBSpMW6ktk/rfHChunCTMBwFYXWN36OjDzrO2taD9M3/rVgX0xzGw6+Lk2vL1X9nzPihHZ7XRJ1p9R8xltTw/uwQuWQNyohnmsYmyT8P3OxoB7vbCpu5iGXH2Zgnmnx/shvoIPSzYHkHfC3AXxS6llLmI78KlgFT9Jh48w/LJe9m96wk6J7+b4BgCxyTkjjLFgV7K0yQC7zUftZple/KvTodz0h92jkJFjWxZPbbft2jGtP35FGEJgb0E3ywGb/FDYNvrBuDcEBWcLq+yXHAQifV8BVvSqsvdHCmxbZUFWhBq5KlQI77TCsSWCwidZrM0TgqlNJ5+hfyiROhIqh5SAbD8qdNUxhqsU/eCo1drUzxPL74TBnGy14ruuVjPGrR2vORswlS5XwgQzNJGccfVPci1P9918LAAjWCW6WjGZghON3/Xm7+xSB5IjsloAjxVek+xH4itnr2TEGNutcblKamcqXTTN0BAvh0KnAdyEM/Aux4tjiTRS26cIvawhSlW/DAE6wji2iUR7mVwWhHrd0vyakG7pqWoy8mZXDECjCSH6Y/fVsVlPqeIjVZDP6GxViTc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|24021099003|15080799012|51005399006|4140399003|25010399006|5072599009|12121999013|19110799012|8060799015|440099028|3412199025|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGMwVzZXS0RLVFVoRzZqYktjczlPMXBIVlpwNXRuTGVvbWxRdTZsVkZEN3hm?=
 =?utf-8?B?TWJHbGp3UUtiemtvb2JBckNRYWV3eWpoc0FnMGptSG5VRUlvRGtRbFBkQlcy?=
 =?utf-8?B?ZTlxbmMrVGhZdVNGWTcxMXBKdVJROEZMd3NOWkxCR1ErNjhJZEVOeVV2ckxy?=
 =?utf-8?B?Zi9ZQmdPNVVOU3E4Z2gyLzA5NmNwUkowMHFYME1WWGtpUkVrZVVSaThXTE40?=
 =?utf-8?B?L2hqdUpjdnp4NkdlcXNrSXpKUVhSRE5EQTkveU40eFMzQ0JPQzZ0TzRSVFlI?=
 =?utf-8?B?dnRvdnVqRGVyNHBYc0dqbzJKV3JDQjVCVU5EcEN3SS9XR3lqMXo2eUUwTlM1?=
 =?utf-8?B?SmF2ZU1VMklTRVdDcE5mV1p1R1lZZ09QZGh5VFZFNUZObWpLWHUrZjVXcDFU?=
 =?utf-8?B?YmRBeEZqUzI1WEhYYkVlbERMVlJyTFJHeitCTXZFVk9qK1VEVVMzblJEZ2Rk?=
 =?utf-8?B?cXgxRU9XbXVuSnU1SGFBeDd6WVRYWkxEYkZJTmo2Rk9EUzNUSFlEaURPQUZR?=
 =?utf-8?B?bHdkUUh6UEVKL2Y4MDA4a1kyLzAvZjVEazZDL0lOTVBWQmJhRktZaFJYM0Ex?=
 =?utf-8?B?MmxNSUJFWmk0RmJLbmdDNXhuTC8wektsTFl6NmxBL3ZIODQzYUVsUDdzbjhN?=
 =?utf-8?B?MlZoem44L3MvTURnSnp5MUJXZnZra2NxQXU5dllWYy9mWXJiVmFSQkE2dGpU?=
 =?utf-8?B?ZE9FV3NvR2NUYUIzOFBYMVhEdS8vcWgvQXFqSndkTFA2Y0ErUUhMa241dFpM?=
 =?utf-8?B?ME1DVjY1aWF6ZHJ3M09xS2toMElKNmFWZjEyd3FkSnNJZjB0Q1VYdFZQWnFv?=
 =?utf-8?B?Sk91YnA4RXozVm50eVp2NzZYOTRnYm1tUHhFb3NjdCtyZ1BWSjFvMFVQVHBx?=
 =?utf-8?B?SEpQSEs2L2QyUy9vWDhWTHJzYysvSjdRTnU2aTd4OWRqU0dBRlpIc0xBeHc0?=
 =?utf-8?B?aUgyMGNEWSsvMll4SEt6Wmd4dnZmaG83aDVIUFByb3NwVHZZc1dKd1RDelNM?=
 =?utf-8?B?c3U5Vm95cktzUXRUSWRpNmlTMGhsQWhhR3lmaEdjL3Jxc09WMDNtNThFcXZG?=
 =?utf-8?B?K3ozdFo3WllTSlZOSEl1SXc0T1VCWTdYZTBTbmlhZDc5ZjZLdndGZC9JdXZ6?=
 =?utf-8?B?U2JYZWxLRlVkNlpYaThqNE5KaWREbmoxV0puMEZBZXZEL09WWVZBbE4zMFJH?=
 =?utf-8?B?VEVtejV0QVZFdVZJOEV1bDA5VEdnNUw0aGxpci9RZFZJSVlCZ0FqRFMvSUoy?=
 =?utf-8?B?ZGFHRmtTS0hUc0VjNUFKTzJQQzRJaFMwN2dYb1IxRE1Td3pxbXNDbVdzZ0pU?=
 =?utf-8?Q?+F6+E108usY4UTthQQ/KfYKYLhIz3ZwgzZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3FyeHE1c1NtTkpzck9kWlJCajkzOFJ2UENkRUpSQWtacVVZUEFtVXJrRTBF?=
 =?utf-8?B?VlZTV01DY1ZCMWpHejc4S0s0cjBMM2ViNzVCT3NSNFpLQWVZdjgzVHd5SC9C?=
 =?utf-8?B?N3JseWNYR2tZZjdKZUJWbXpQdFZzZFVPdmt3c1FOenRhWVZUZHlSQWlNTDR1?=
 =?utf-8?B?c2V4bnFyWUIvRWRUenR2WlNSNzU5Q3BKWVExR0kydGhIMkNYZSt1NXg5OVNF?=
 =?utf-8?B?ckpHQWVWbmR4UGxrd1ZCd0cvM1dQcUd1WEVERDVDSjdKb0dQWEl1ME54cXg1?=
 =?utf-8?B?WHY5R2hFd0ttUnZxekZMTWJraVo1anZ5WXJzNW8vZjZKbEdZSmg3aEowZTN1?=
 =?utf-8?B?aGhNSWp5VEJsN2N6dE1YWUpVcG5jRkY5d3FlY3JzRitUZm5zQks5aHpJT3RQ?=
 =?utf-8?B?VFArK2c2ZjdtL095VG1qeUY1S2RLVjdYTXRZWnpWWHNpdG45N2RJcXFIZTNt?=
 =?utf-8?B?VlNGczY3blFOcUlBVHdWZFZwampVRjBscUh0MWcvOUNpU01nNms3dmRjMm45?=
 =?utf-8?B?eEppNCtuaFVwb2liSThHT25HQXZ0OXlpcUxFUktZV2RUOUdpbHUxNHl5NzAx?=
 =?utf-8?B?V1d4cU9SVDFsM0ZuZG1XanVhUi9mbWh3MDIxUXRhV3hlc0g2a3VVYUVtUm5o?=
 =?utf-8?B?cFRXRVZScXAyQUtNT0dhVkJhVHNmeVd5WjZYWVlyWXhsS1JKMUtYbW1SS1hP?=
 =?utf-8?B?aCtSRzhkQmExWkVwdUtjMk0zS05JMXJJS2lIOUxjbC9xTnc4cDVVQk5ReWtT?=
 =?utf-8?B?bFpocXozUWpCdzRFMmZJN1Qyb3A1THlheGtRQnd6WXBYWFlxYk1mcGxjdkhR?=
 =?utf-8?B?UTNSS2x2WE9kdXVNdjVJWFN2WE1ydWxDVHZLNFRvenZOM1lBTnRoMWtoMFM0?=
 =?utf-8?B?ZjlCVmxDTjRsNlZvSTJWSExOM0I2YnpGZkhSVkw2MVZScUV3MEl4VGJwbTNU?=
 =?utf-8?B?a1IvUSsrZVBtUGF5bjZZdGx0Ym5mdkxhK1E2dGtOWGZ0OHRkKzZScGlSWFdQ?=
 =?utf-8?B?aDN1WjJDNERhNXpHS2FwbllRR1JITnFya01GM0VEdGR1aWpHV3BBNklCZTBN?=
 =?utf-8?B?dXc2SEcwNkM3eXZkeVBKYko2QjQreFFRRzBtYmE2QjVmSHhXT3haZkRQNldt?=
 =?utf-8?B?ZWZZd1NPaHpWb1ViVkhjOG1xVjY2Q0JjeWVFN21MZTdIYlJjMDhHTkJJeWk4?=
 =?utf-8?B?akpTUGpNYklTRnpxMEhtT2lsbjlYMW9vUit3ZEhuSllxYTZIbkJOaTJvWEtS?=
 =?utf-8?B?Sy9paEZPYzRnZ25pRk94eG5tT1dQM2pMa0UyejVoaEtyUVVJdEtsdVRWd1l0?=
 =?utf-8?B?UHM4WXhnenVxbC9NV0dENHJTc2VENlpYSVZ5STR6aWdhd05oQ3A3WHZtYmhw?=
 =?utf-8?B?eG1aRnZSUUhPcGt4Z1VheXpJcEkzM3lSRi9EbnhZQmhFN1NtUUtuK3V3UkRM?=
 =?utf-8?B?cWRWWDQzemp5K3JuVnlWcFVpVG5iZkVQN2tOU1pubjZGN1pxZDBBZTd3cmFG?=
 =?utf-8?B?Q3ZSdGRXR2lENjdXejNLZTk2bEpEb04zNjBLYmlYVzVWMkZacVJkdnc0L3A1?=
 =?utf-8?B?N1ZwSGVNOXlESEFweFd2QkYwdWRFYTkxbDNicEJQSy9YazVDMklNOThnTVdT?=
 =?utf-8?B?ak0rQStFS2xmengrRzNWQ2tpQkR6aS9kOG82QzJzSDZFclBvS1JQQnQzSEdu?=
 =?utf-8?B?ZTZCVmRVajZOZ2ZGMXZ5L0t2UjNHY0xYcjF0V2pRQ2Nid3V0aG11TVQ2M2VC?=
 =?utf-8?B?OUd0SzBkMWZnYXUrQytpV1VkU0lRZU04dVQ4MDNXMERrMEFuYWVzV3lMbmov?=
 =?utf-8?B?M2szWTgzNThYejhEeFNvQWE2anlCMkE2SHF1TzV5RXdMbjJEM1VvZUJIOEdL?=
 =?utf-8?B?cmx2RGh6RUFxVFVXQjZadkZjbmF0N3piM29tMTdidHVEVkZFQXRKa2MwRUM3?=
 =?utf-8?Q?Lc+De4uXMuEgWs7erLlwmYpBO20limE+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff68e18-f303-41cc-f1ba-08def1852822
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:32:14.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14463

--------------0N7Q6Ttl1iUbaNiYl1KCkFA7
Content-Type: multipart/mixed; boundary="------------6ZOrWLloxnEAi0AF3kOgL8YR";
 protected-headers="v1"; hp="clear"
Message-ID: <eacb323e-f1fa-45b7-8619-6506507d24f4@outlook.com>
Date: Tue, 4 Aug 2026 01:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>,
 Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>,
 Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Pengyu Ma <mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
 <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>

--------------6ZOrWLloxnEAi0AF3kOgL8YR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNi84LzMgMjA6MTMsIFBlbmd5dSBNYSDlhpnpgZM6DQo+IE9uIE1vbiwgQXVn
IDMsIDIwMjYgYXQgNTo0MOKAr1BNIFNoZW5neXUgUXUgPHdpYWduMjMzQG91dGxvb2suY29t
PiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IOWcqCAyMDI2LzgvMSAxNTo1NiwgQWFyb24gTWEg
5YaZ6YGTOg0KPj4NCj4+PiBAQCAtMzM0LDYgKzMzNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgeHBhZF9kZXZpY2Ugew0KPj4+ICAgICAgICB7IDB4MWVlOSwgMHgxNTkwLCAiWk9UQUMg
R2FtaW5nIFpvbmUiLCAwLCBYVFlQRV9YQk9YMzYwIH0sDQo+Pj4gICAgICAgIHsgMHgyMGJj
LCAweDUxMzQsICJCRVRPUCBCVFAtS1A1MEIgWGlucHV0IERvbmdsZSIsIDAsIFhUWVBFX1hC
T1gzNjAgfSwNCj4+PiAgICAgICAgeyAweDIwYmMsIDB4NTE0YSwgIkJFVE9QIEJUUC1LUDUw
QyBYaW5wdXQgRG9uZ2xlIiwgMCwgWFRZUEVfWEJPWDM2MCB9LA0KPj4+ICsgICAgIHsgMHgy
MGJjLCAweDUxNTksICJCZWl0b25nIEJUUC1LUDIwRCBDb250cm9sbGVyIiwgMCwgWFRZUEVf
WEJPWDM2MCwgRkxBR19NU19PU19ERVNDIH0sDQo+Pg0KPj4gSSB0aGluayB1c2luZyBkb25n
bGUgaW5zdGVhZCBvZiBjb250cm9sbGVyIGlzIG1vcmUgY2xlYXI/IFNpbmNlDQo+PiBjb250
cm9sbGVyIGl0c2VsZiB1c2UgYSBkaWZmZXJlbnQgVklELg0KPj4NCj4gDQo+IFRoaXMgaXMg
dGhlIGNvbnRyb2xsZXIgVklELg0KPiBUaGUgY29udHJvbGxlciBpcyBpZFZlbmRvcj0yMGJj
DQo+IFRoZSBkb25nbGUgSUQgaXMgaWRWZW5kb3I9MjBkZC4NCj4gDQo+IEFhcm9uDQoNCkl0
J3Mgbm90IGNvbnNpc3RlbnQgd2l0aCB5b3VyIHBhdGNoIGRlc2NyaXB0aW9uLiBBbHNvIGlu
dGVyZXN0aW5nbHksIA0KdGhpcyBzZWVtcyBub3Qgd29ya2luZyBvbiBLUDUwQi9DLg0KDQpT
aGVuZ3l1DQo=

--------------6ZOrWLloxnEAi0AF3kOgL8YR--

--------------0N7Q6Ttl1iUbaNiYl1KCkFA7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmpw0JMACgkQX75KBAfJ
sRnHthAAiUjKi5W8fwsQV6OfuQF/VFeL04jiEWc5T56VGcE2K1Rz0PlEZOuy6jn4
49nAHAlckvrpFCzi93O+UV+Hwv7ZU7G+w0Nln6WpxPb1rjJwGCK+t9lcxSITxi7O
tZwcGXeFJBfe/ybQQoTfBnVm4FwrGWG6QyQGPp35Jo7XO/V08Np5G22/ETyUj3fr
tPqUmMYM1qlu0mw4Zp4E6wCRlFKbhW18dCiA2xjRLpXYtfQWvKJkoHdpSUEN4nLF
ywG946mxgQuRCg5r174dXEKCcUR8ID9+rRpLG22OxZoxP4jNWxUVCwh+pG/WhU3z
CxXjLvJtjRCB+UllsM/xftymsCW+urQPOSEz2rwqDDGGqpFrhn6p0KP8rrJMM28/
stz8DCnpDMyesSn1hIm0LDrzjnE1L/yJZQRh7uosA3b2QqbLKB8sK0Vy4abvCD6o
6RZQsgFWhTde/uLOI6zbEBtp/v6ij79IoUFve8UGcMKmLIMPRaWDmXBhjrdQULJ+
EQD+zIf95UA17bMQhcvqV1el1EY2Dp1VU+DPevoAYNXgLn3Jo4epRxWVNZXr+HTG
1zYJq/qIbCux1x1ImZfN0pBhyek1ShAF2y7bxwVzLvHTWHHOK/en6ge3SYHHYUj4
CDaK5R3l6ft1qufOrHGUCOYgQgCGnadAqB7FEzHkn86DAXcvIaM=
=CmFH
-----END PGP SIGNATURE-----

--------------0N7Q6Ttl1iUbaNiYl1KCkFA7--
