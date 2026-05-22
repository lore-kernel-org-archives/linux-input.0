Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011037.outbound.protection.outlook.com [52.103.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E2287247;
	Fri, 22 May 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430320; cv=fail; b=tcjEVg/O27ginRAK6I7Z9g9qmU153I2Mq7ld9bW3/mPqwmVrWfUuE2TRjlJQasxYcVEbMNS6x9NUnfXzGxYGXe/WEfv2v4nByE5r/ExIt+pUFyyjPz42YfAQj5zZ4Aaw1S2SvlTEYjgQLlS0fIGfHZ0pk3nygYj+E0Nejd4Tuh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430320; c=relaxed/simple;
	bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L2zhy7teoYsb0t8664nAt/o02FLHRd+DsmQPgiRWulULDO21xKMJIrvmRCHEJ6NeVM/j9A/Hf8yzQBml9OFXqQF3XecPRe40nzVwdK2/yE6dYeB/Kh7WerM2/Z3yXJaeymXVERLbq9zTRQZAEH50tVenGhe2IoDEqsgKDHbCRqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p9IChDdA; arc=fail smtp.client-ip=52.103.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p9IChDdA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igylg08v+7Biz7fhDjrW0JZG2Dm2IbKBGcDmGbKR2GBxFR0RU4Z6PJagz3H5i/A2Ke/AVGIKRxyWPolHA1JenfvF/aoRE5S2yoX6qLFR6wVUxAKif3NHfmgTzW3fmNQchejaZAmYzbxCzKN7gOONLd1SbHbJXbdDedqETRSzs4tz1qNSvQWCLHzrZ0DnAFKAZvDLPLTjVXNvEe1uWkiO/feNTNDURh1yx5h62l5wEIhQLBNOMpthOlEJd52eVj7GhghhLEC8iOEO/T1nrLhfda71xVy+hk/Z3qap/rrEWLoWICif34SqatVtj2Ed8ksKnSSC7llNzLAqk0tiouLwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
 b=G9ZiPusxWVITeKO/GbwztaXDXHRJOuoV3Pfw63aTjRwXLrQkEsxugO5LWcFB92rTOR2tMKAY2Qws+9W88kqw1g63eufVXDH58PNh6moDwuKEqJ2TpEaYZvCnAr6vDghRH4mEIaVq7KpdWUCNInCdv1UiRXHioeHaT8VjxYZ1JZPLXJKaHq0qOxHb2GNFfQeQjle+16iikgJ/+UBG685/LrqvHBJEXMFDRCDayVXeWXl/IfkcE+9U94AgFWQ9THw4tL89G2whJl9CRA+mCuabIUXZSBBQD8tGWJ8Nj/deOMlmHnmcOJobzTlfpz4FVUEKCTagxK8d+gu7GpeQdAamcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPcHiYLbx3PhpiAi1l3p8tmcouxPwIQGgLxCph1eQcg=;
 b=p9IChDdAfsAsMg+me8QJ9dRVqAEfrReIeJADSitV7/hEUwr4uaEEjuOMp8EVSo/qGUqE80NF91y7sg29HRt6loVAmQ+ssybp4wfPTHoB25807sVuZAw43uuPywBcXaEz4xrg0xBM8yExXs1SmJr588JNUxEy75/7m7lau6K41Q2GlKVoJpXwhni5EQUI4VPQRmek9nXld8VO+3NGxxE+GjM82obpu9U9SFSc9O9lyN0nJ8eE0rAeCymURUg5lqmARXzKu5sFVUwvolXOIOnrJs8crVIseMJX34XUCQ8cdJXZoWogMvlP5y8o4o17HF+AiVuEDggPuwX0N6+BeJaBnw==
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com (2603:1096:604:162::11)
 by OSCPR01MB13049.jpnprd01.prod.outlook.com (2603:1096:604:32d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:11:55 +0000
Received: from OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01]) by OS3PR01MB7969.jpnprd01.prod.outlook.com
 ([fe80::89a6:c807:9302:8c01%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:11:55 +0000
From: Liu Kai <lukace97@outlook.com>
To: Benjamin Tissoires <bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Topic: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Thread-Index: AQHc6bHj9F3ExQgVrk6U1UgZW95/xQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 22 May 2026 06:11:55 +0000
Message-ID:
 <OS3PR01MB7969ABA966529C8A7EED348BC70F2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB7969:EE_|OSCPR01MB13049:EE_
x-ms-office365-filtering-correlation-id: 7930b517-a8b9-494b-9eea-08deb7c90666
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|37011999003|25031999004|8060799015|8062599012|13091999003|51005399006|15080799012|19110799012|31061999003|26104999009|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/4sIR7F4IAdqMSjtxoqFYvX0/gOWiITL3AbtVw+8TNNoNAIodO8PyeBr88EE?=
 =?us-ascii?Q?cu+qpcGDhCnTQnUHdi7dbUpzHIN/RFFUmKl21TaKeZ7gg2rgmaNIFOCr2drr?=
 =?us-ascii?Q?Wwe2akChdBRE3iQCFs/jMYs+ZwqwEEeTFicrs43dxwzVKy3Bzi5SfY4l9vBG?=
 =?us-ascii?Q?PSEJk2apzoV16QnvWjqOB21r8QQ0AzjUA2AkJ4VFpoZmSPf4u4fecLQ1Phc9?=
 =?us-ascii?Q?uSRvC1ccdryqgfMTvGOXwnFU/ocDluRG0Jn5+GHDcu22MCR+aRJF/fWMFps6?=
 =?us-ascii?Q?PKczjtkDkGnWUk9Uv3cXL6Fx6AlbBV2LKeidlFIFl1FpmAqZZpll9x4K97w1?=
 =?us-ascii?Q?cwrK5w855FiyYxHTDev9FlDpvJXSPb1H9xMEoyviJtJwHwmW0UVuiEmP16Jq?=
 =?us-ascii?Q?OOiYweEKQQjJyOA12hQ2jU49k9nHkBVlDe8yW5EwLH04pkmKzXE35OTANl+E?=
 =?us-ascii?Q?xDmniGVhpkmhNRX26hhlo2bQlGpuSw0XRLpH9UVmnVS031U2m6HOBvV/vggO?=
 =?us-ascii?Q?atM4vY5YrVg1BVu4G6jLGcM0XHoCgeD8YzKzhC8qI1nFdTFZ+RWnriR5i75L?=
 =?us-ascii?Q?mGavf9mFNR/lFReIwFNgvqyj+9Gn/KGTvfD9tjP9UOncBOAgmxkonb3VM8XP?=
 =?us-ascii?Q?IUHw3PejXE6nFeBtAWWoLCQKHSfw12lyWCGSWaNl54/QO18NRGaUCE3jGNnN?=
 =?us-ascii?Q?9oIRgYRvefGNTnN36Dto2IXAidEDouLM9SYI+uXLje8hVV2Nz/BpUx8iC/QX?=
 =?us-ascii?Q?BRcD63qC2WOVC9k6GqUnTM1LoCDPKCQx4+aVIqrWl3QFmhSqZLWMC8KwSBBD?=
 =?us-ascii?Q?eF4DBHWuA7vIZ2UW0/n1fX4me+rTHIeFg/1bS6HQCjleMlpA9UdJARtq1dqy?=
 =?us-ascii?Q?5mVQdyLpHbF7J1mEQCRuJj4ZgSQeGT94b8Yu6wQiQhzyOEemGBXJWp4+5cuE?=
 =?us-ascii?Q?v8baf1Uy2kcgTw5Vq94lrV5QfEoRvzW0wGPwzpNz8/eTn+QDlNIuNQ/6s9/Y?=
 =?us-ascii?Q?SRjjEJWBndysn4VOGgvfgU0+ecs6AruDXxSewIehIVNpJ/8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SMZleq26wlafQCwZVoz99UNvLUHkoTreHL75X161o9OYF/T4rXypcJkxryO3?=
 =?us-ascii?Q?HXqxQp0sTKUZcCqabAHpK2e358JonxK/JBlthCHheaUAyibfEf6lYmKBIHbH?=
 =?us-ascii?Q?HvSqGzayfD4MwShhgQgC2pnip/7Kf/5bMhps7qSQM2kZ0KND6PuDlSSbZR93?=
 =?us-ascii?Q?n+6+kiI9Rrw/XDDQZ03IW1JGK8qbNbCKEXg0klreErGPX+eVpqZEvw/LDP4x?=
 =?us-ascii?Q?cpnOGr6Z5KSSWgSnwIybpyU97hp/dBT+VT7jus+q84imGYbIkw8o1aGU3wYd?=
 =?us-ascii?Q?0aZFeysFe2Noy2Eoe8EdnSYt8FoM8wfgTch/FT6y/kDWCbkcJwKTLZxM/DzU?=
 =?us-ascii?Q?2XZ7jgCF3M2xa2X8WS3hGR24xYtp4jFqX6CjA6W2rLw2vlyuX7hH8srqhdCy?=
 =?us-ascii?Q?xTDxdlCead4fjWSGOsDctjDGPtI5ghUuYS4NgYNDQLhVSy0M+0BZdaxDA1fx?=
 =?us-ascii?Q?P5dCdq1j02PiKBcwBeYFp81B701PakeInN9UO9HShRft8gvkJQd3romd/2cd?=
 =?us-ascii?Q?sWjSZM2D2YEKyirBhYFBMIbUn2wiKwLE/ncWFmZKuaSoYLav5hbtyYT7z7Z/?=
 =?us-ascii?Q?I4iMcJmSNwC9yXyMi0E9POsTVVamfM5BR6M/mHCeoObq19xwsI/NgjxBGDmT?=
 =?us-ascii?Q?dwJ+GGx2T8KmSHRCiIqR7O/8Aatkyg3jJEzJW7szGiV8eZjrL9a9mC1SwDbM?=
 =?us-ascii?Q?lJ7LOl99nuOpWFgIx/Iuo9Xor1Iiim5MLl9xvKUWy5JZeJfKyhCRe5GhbLg3?=
 =?us-ascii?Q?HWOEERN/7F1ZEOLz9qAood8oMQ2XUEcBDq2v35ZZ7RmZvQRAH1tPCLh6q+5g?=
 =?us-ascii?Q?eFAwHqDCgpwQnAMH0v3B70UGgGqg9i9cU6Wt9KhCHDD2eTczdjYWGpFrOuNU?=
 =?us-ascii?Q?Hh080e/OBGR+KVuOV9KqEREUnnqoI7wCsfu14hH19fNpZ1zeEh5ipjtty9BG?=
 =?us-ascii?Q?I+bdxAYONlRMO+76svu97hnfk8q2U2uNi7GY/0lZsBmUDaP7A8LNJ598l6Fs?=
 =?us-ascii?Q?SIduRDmlM+3Fp9DxSnUapl7ANwYNRAlaS2Ihwh5OyUc88mOyOLe5jJnpVJVD?=
 =?us-ascii?Q?/3UaNIj6UNwGD2Wi+oMJ+N9Jeu3SI3w0+vgX7pDc8Z28tXM7aUXGBsX+GkSp?=
 =?us-ascii?Q?OYxkTW3YOojX7y3aGNXt8vnFwHfl+ugwk3PeopudP4rtNP/6ylZuwCuK+Qoz?=
 =?us-ascii?Q?fyT/U4bnP7koFCuA7+x1u2umcfk6QXGgICdXOt0dzIFZkpn5q0I3tD2/NRFj?=
 =?us-ascii?Q?IcamCNpFxSTKoBqGNr6npLHQ3j5PU+HjjUDMjhZhYvk3Xlxz4gc6J+6wfJ83?=
 =?us-ascii?Q?VrPV9T4AZNJXfTbINBJtJ7EQ8UlXmvSu1LAMiIlxkCWYVSc2nB/4EpuBv+Ew?=
 =?us-ascii?Q?JyLpGTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7969.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7930b517-a8b9-494b-9eea-08deb7c90666
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:11:55.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13049

Liu Kai would like to recall the message, "[PATCH] HID: remove duplicate hi=
d_warn_ratelimited definition".=
